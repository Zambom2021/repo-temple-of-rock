class modelPayload:
    def __init__(self):
        self.payload = {
            "name": "",
            "genre": "",
            "members": "",
            "formationYear": "",
            "country": "",
            "discography": []
        }

        self.model_disc = {
                    "title": "",
                    "releaseYear": ""
                }

    def cadastro_banda(self, qtd=0):
        self.payload
        i=0
        while i < qtd:
            self.payload["discography"].append(self.model_disc)
            i +=1

        return  self.payload 

    def find_empty_discography(self, band_data):
        for band in band_data:
            # Check if the key 'discography' exists and if it's an empty list
            if 'discography' in band and len(band['discography']) == 0:
                return band
        return None
    
    def update_discography(existing_data, new_discs):
        """
        Atualiza a discografia existente com novos discos.
        """
        # Adiciona novos discos à discografia existente
        existing_data['discography'].extend(new_discs)
        return existing_data

# Exemplo de uso
if __name__ == "__main__":
    payload = modelPayload()
    print(payload.cadastro_banda(5))
