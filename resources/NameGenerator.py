import random

class NameGenerator:
    def __init__(self):
        self.formats = [
            '{first} {last}',
        ]
        self.first_names = ['John', 'Jane', 'Alice', 'Bob', 'Charlie', 'Jeff', 'Peter', 'Gabriel', 'Mark', 'Dick', 'Rob', 'Jack']
        self.last_names = ['Doe', 'Smith', 'Johnson', 'Brown', 'Williams', 'Silva', 'Botton', 'Pimenta', 'Rockscarface', 'McDonnald', 'Jones']

    def random_element(self, elements):
        return random.choice(elements)

    def name(self) -> str:
        pattern = self.random_element(self.formats)
        first_name = self.random_element(self.first_names)
        last_name = self.random_element(self.last_names)
        return pattern.format(first=first_name, last=last_name).strip()

    def generate_members_name(self, quantity=0) -> list:
        unique_names = set()  # Usamos um conjunto para garantir a unicidade
        members = []

        while len(unique_names) < quantity:
            new_name = self.name()
            if new_name not in unique_names:  # Verifica se o nome já foi gerado
                unique_names.add(new_name)
                members.append(new_name)

        return members

# Exemplo de uso
if __name__ == "__main__":
    generator = NameGenerator()
    names = generator.generate_members_name(8)
    print(names)
