import pandas as pd

def get_correlation(correlation_df: pd.DataFrame, indicator_code):
    """
    get_correlation returns the correlation between the value of the indicator and the unemployment rate of the selected indicator code

    Parameters
    ----------
    correlation_df : pd.DataFrame
        _description_
    indicator_code : _type_
        _description_

    Returns
    -------
    _type_
        _description_
    """
    return correlation_df[correlation_df['indicator_code'] == indicator_code][['value', 'unemployment_rate']].corr().loc['value', 'unemployment_rate']
