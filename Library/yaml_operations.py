import yaml

def get_config(env, key):
    with open(f"config/{env}.yaml") as file:
        data = yaml.safe_load(file)
    return data[key]


