import streamlit as st
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import math
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score

# Streamlit Page Configuration
st.set_page_config(page_title="Retirement Investment Optimizer", layout="wide")

# Constants
EPF_RATE = 0.08
PPF_RATE = 0.071
FD_RATE = 0.07
SIP_RATE = 0.12
INFLATION_RATE = 0.06

# Load dataset
@st.cache_data
def load_data(file_path):
    return pd.read_excel(file_path)

data_file = "ELData.xlsx"  # Change this to your dataset file path
data = load_data(data_file)

# Train ML model
features = ['Income', 'Age', 'Dependents', 'Disposable_Income']
target = 'Desired_Savings'

X = data[features]
y = data[target]

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

model = LinearRegression()
model.fit(X_train, y_train)

# Evaluate model
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

# Functions for projections
def inflation_adjusted_goal(current_goal, years_to_retirement, inflation_rate):
    return current_goal * (1 + inflation_rate) ** years_to_retirement

def epf_corpus(basic_salary, years, epf_rate):
    employee_contrib = basic_salary * 0.12
    employer_contrib = basic_salary * 0.0367
    yearly_contrib = (employee_contrib + employer_contrib) * 12
    corpus = 0
    for year in range(1, years + 1):
        corpus = corpus + yearly_contrib
        corpus = corpus * (1 + epf_rate)
    return corpus

def ppf_corpus(yearly_contrib, years, ppf_rate):
    corpus = 0
    for year in range(1, years + 1):
        corpus = (corpus + yearly_contrib) * (1 + ppf_rate)
    return corpus

def sip_corpus(monthly_contrib, years, sip_rate):
    n = 12
    t = years
    r = sip_rate / n
    corpus = monthly_contrib * ((1 + r) ** (n * t) - 1) / r * (1 + r)
    return corpus

def fd_corpus(principal, years, fd_rate, compounding_frequency=4):
    n = compounding_frequency
    corpus = principal * (1 + fd_rate / n) ** (n * years)
    return corpus

def plot_projection(years, with_plan, without_plan, title, ylabel):
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, years + 1), with_plan, marker='o', label='With Plan')
    plt.plot(range(1, years + 1), without_plan, marker='o', linestyle='--', label='Without Plan')
    plt.title(title)
    plt.xlabel('Years')
    plt.ylabel(ylabel)
    plt.grid(True)
    plt.legend()
    st.pyplot(plt)

# Streamlit App
st.title("Retirement Investment Optimizer")
st.sidebar.header("Enter Your Details")

monthly_income = st.sidebar.number_input("Monthly Income (₹):", min_value=5000, value=50000, step=1000)
monthly_expenses = st.sidebar.number_input("Monthly Expenses (₹):", min_value=1000, value=20000, step=1000)
basic_salary = st.sidebar.number_input("Basic Salary (₹):", min_value=3000, value=25000, step=1000)
years_to_retirement = st.sidebar.slider("Years to Retirement:", min_value=1, max_value=40, value=20)
current_savings = st.sidebar.number_input("Current Savings (₹):", min_value=0, value=100000, step=10000)
retirement_goal = st.sidebar.number_input("Retirement Goal (₹):", min_value=100000, value=10000000, step=100000)

annual_surplus = (monthly_income - monthly_expenses) * 12
inflated_goal = inflation_adjusted_goal(retirement_goal, years_to_retirement, INFLATION_RATE)

# Predict savings using ML model
user_data = pd.DataFrame([[monthly_income, years_to_retirement, 0, annual_surplus]], 
                         columns=features)
user_data_scaled = scaler.transform(user_data)
predicted_savings = model.predict(user_data_scaled)[0]

# Investment allocation
ppf_contrib = min(150000, annual_surplus * 0.3)
sip_contrib = annual_surplus * 0.4
fd_contrib = annual_surplus * 0.2

epf = epf_corpus(basic_salary, years_to_retirement, EPF_RATE)
ppf = ppf_corpus(ppf_contrib, years_to_retirement, PPF_RATE)
sip = sip_corpus(sip_contrib / 12, years_to_retirement, SIP_RATE)
fd = fd_corpus(fd_contrib, years_to_retirement, FD_RATE)

total_corpus = current_savings + epf + ppf + sip + fd
deficit = max(0, inflated_goal - total_corpus)

# Display results
st.header("Results")
st.markdown(f"### Inflation Adjusted Retirement Goal: ₹{inflated_goal:,.2f}")
st.markdown(f"### Predicted Savings: ₹{predicted_savings:,.2f}")
st.markdown(f"### EPF Corpus: ₹{epf:,.2f}")
st.markdown(f"### PPF Corpus: ₹{ppf:,.2f}")
st.markdown(f"### SIP Corpus: ₹{sip:,.2f}")
st.markdown(f"### FD Corpus: ₹{fd:,.2f}")
st.markdown(f"### Total Corpus: ₹{total_corpus:,.2f}")
st.markdown(f"### Deficit: ₹{deficit:,.2f}")

st.subheader("Model Evaluation")
st.markdown(f"R² Score: {r2:.2f}")

# Projections with and without the plan
years_range = range(1, years_to_retirement + 1)

# Without plan: current savings grow with inflation
without_plan = [current_savings * (1 + INFLATION_RATE) ** year for year in years_range]

# With plan: total corpus (including EPF, PPF, SIP, FD) grows with the respective rates
with_plan = [current_savings]  # Start with current savings
for year in years_range:
    total_corpus_at_year = current_savings
    total_corpus_at_year += epf * (1 + EPF_RATE) ** year
    total_corpus_at_year += ppf * (1 + PPF_RATE) ** year
    total_corpus_at_year += sip * (1 + SIP_RATE) ** year
    total_corpus_at_year += fd * (1 + FD_RATE) ** year
    with_plan.append(total_corpus_at_year)

# Plotting the projections
# Exclude the initial current_savings from without_plan, because it is already included in with_plan.
plot_projection(years_to_retirement, with_plan, without_plan, "Retirement Corpus Projection", "Corpus (₹)")
