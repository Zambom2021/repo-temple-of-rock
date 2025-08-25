# case_utils.py

from robot.api.deco import keyword

@keyword
def assert_equal_ignore_case(expected, actual):
    """Compara duas strings ignorando maiúsculas/minúsculas."""
    if str(expected).lower() != str(actual).lower():
        raise AssertionError(f"Esperado '{expected}' mas foi '{actual}'")

@keyword
def assert_list_equal_ignore_case(expected_list, actual_list):
    """Compara duas listas de strings ignorando maiúsculas/minúsculas."""
    if len(expected_list) != len(actual_list):
        raise AssertionError(f"Tamanhos diferentes: {len(expected_list)} != {len(actual_list)}")
    for e, a in zip(expected_list, actual_list):
        if str(e).lower() != str(a).lower():
            raise AssertionError(f"Esperado '{e}' mas foi '{a}'")
