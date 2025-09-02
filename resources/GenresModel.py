import random

class GenresModel:
    def __init__(self):
        # Formatos de nomes que podem ser gerados
        self.formats = [
            '{first} ',
        ]
        # Exemplos de primeiros, médios e últimos nomes
        self.generos = ['Hard Rock',  
            'Heavy Metal', 
            'Punk',  
            'Blues', 
            'Classic Rock', 
            'Symphonic Metal',
            'Progressive Metal', 
            'Vicking Metal',
            'Black Metal' ]

    def random_element(self, elements):
        return random.choice(elements)

    def genres(self) -> str:
        pattern = self.random_element(self.formats)
        generos = self.random_element(self.generos)
        
        # Substitui os placeholders no padrão com os nomes gerados
        return pattern.format(first=generos).strip()

    def generate_genres(self):
        return self.genres()

    @staticmethod
    def generate_random_number() -> int:
        return  random.randint(1, 10)

# Exemplo de uso
# if __name__ == "__main__":
#     generator = GenresModel()
#     print(generator.generate_genres())

#     random_number = GenresModel.generate_random_number()
#     print(f"Número aleatório gerado: {random_number}")
