# webhook/webhook.py
from flask import Flask, request, jsonify
import base64
import json
import subprocess
import ssl
import logging

logging.basicConfig(level=logging.DEBUG)
app = Flask(__name__)

def run_attestation():
    """Executa o script de attestation e retorna os tokens"""
    try:
        result = subprocess.run(['sudo', 'bash', '/opt/cgpu-onboarding-package/step-2-attestation.sh'], 
                              capture_output=True, text=True)

        logging.info(f"Attestation output: {result.stdout[:200]}...")  # Log primeiros 200 caracteres

        # Extrair os tokens do output
        output = result.stdout
        start = output.find('[')
        end = output.rfind(']') + 1
        
        if start != -1 and end != -1:
            tokens = json.loads(output[start:end])
            return tokens
        return None
    except Exception as e:
        logging.error(f"Erro na attestation: {str(e)}")
        return None

def configure_gpu_pod(pod_spec):
    """Configura pod para GPU Confidential"""
    attestation_tokens = run_attestation()
    if not attestation_tokens:
        logging.error("Falha ao obter tokens de attestation")
        return False

    # Adicionar sidecar
    pod_spec['containers'].append({
        'name': 'gpu-attestation',
        'image': 'brunolaureano/gpu-attestation:latest',
        'env': [{
            'name': 'ATTESTATION_TOKENS',
            'value': json.dumps(attestation_tokens)
        }]
    })
    return True

@app.route('/mutate', methods=['POST'])
def mutate():
    request_info = request.json
    try:
        pod = request_info['request']['object']
        modified_pod = json.loads(json.dumps(pod))
        
        if configure_gpu_pod(modified_pod['spec']):
            patch = [{"op": "replace", "path": "/spec", "value": modified_pod['spec']}]
            patch_bytes = json.dumps(patch).encode()
            patch_b64 = base64.b64encode(patch_bytes).decode()
            
            return jsonify({
                "apiVersion": "admission.k8s.io/v1",
                "kind": "AdmissionReview",
                "response": {
                    "uid": request_info['request']['uid'],
                    "allowed": True,
                    "patchType": "JSONPatch",
                    "patch": patch_b64
                }
            })
    except Exception as e:
        logging.error(f"Erro: {str(e)}")
        
    return jsonify({
        "apiVersion": "admission.k8s.io/v1",
        "kind": "AdmissionReview",
        "response": {
            "uid": request_info['request']['uid'],
            "allowed": True
        }
    })

if __name__ == '__main__':
    ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_context.load_cert_chain('/etc/webhook/certs/tls.crt', '/etc/webhook/certs/tls.key')
    app.run(host='0.0.0.0', port=8443, ssl_context=ssl_context)