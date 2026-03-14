import pandas as pd

def read_excel_row (test_case_id, sheet_name, sheet_path):
    try:
        # Read the Excel file
        target_sheet = pd.read_excel(sheet_path, sheet_name=sheet_name)
        # Convert the data frame target_sheet to a list of dictionaries
        print(target_sheet)
        if sheet_name.startswith("Login"):
            target_row = target_sheet.loc[(target_sheet["TestID"] == test_case_id)]
        else :
            target_row = target_sheet.loc[(target_sheet["TCENVCON"] == test_case_id)]
        return target_row.to_dict(orient='list')
    except Exception as e:
        print(f"An error occurred while reading the Excel file: {e}")
        return []