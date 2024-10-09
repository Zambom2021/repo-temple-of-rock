from datetime import datetime, timedelta

class DateGenerator:
    @staticmethod
    def current_date():
        # Gera a data atual no formato DD-MM-AAAA
        return datetime.now().strftime("%d-%m-%Y")

    @staticmethod
    def future_date(days):
        # Gera uma data futura no formato DD-MM-AAAA
        future_date = datetime.now() + timedelta(days=int(days))
        return future_date.strftime("%d-%m-%Y")

    @staticmethod
    def past_date(days):
        # Gera uma data passada no formato DD-MM-AAAA
        past_date = datetime.now() - timedelta(days=int(days))
        return past_date.strftime("%d-%m-%Y")
    
    @staticmethod
    def current_year():
        # Gera ano no formato AAAA
        return datetime.now().strftime("%Y")
    
# Impressão das datas
# print("Data Atual:", DateGenerator.current_date())
# print("Data Futuro:", DateGenerator.future_date(5))
# print("Data Passada:", DateGenerator.past_date(5))
# print("Ano:", DateGenerator.current_year())
