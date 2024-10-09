import json

class JsonConverter:
    @staticmethod
    def convert_for_json(response_content):
        try:
            # Converte os bytes para string e depois para JSON
            return json.loads(response_content.decode('utf-8'))
        except (ValueError, TypeError) as e:
            raise ValueError(f"Erro ao converter para JSON: {e}")
