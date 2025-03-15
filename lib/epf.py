#EPF code for calc & graph :

import matplotlib.pyplot as plt

def calculate_epf_projection(employee_income, years_to_retirement, epf_rate):
    """
    Calculate and project EPF accumulation over time.
    
    Parameters:
    - employee_income: Monthly income of the employee (₹).
    - years_to_retirement: Years left until retirement.
    - epf_rate: EPF interest rate (in %).
    
    Returns:
    - A list of accumulated EPF amounts for each year.
    """
    # Print the input data
    print(f"\nMonthly Income: {employee_income}\nYears left to retire: {years_to_retirement}\nEPF rate: {epf_rate}\n")

    # Monthly contributions
    monthly_contribution_employee = employee_income * 0.12  # Employee's EPF contribution (12% of income)
    monthly_contribution_employer = employee_income * 0.12 - (min(employee_income, 15000) * 0.0833)  # Employer's EPF contribution
    
    total_monthly_contribution = monthly_contribution_employee + monthly_contribution_employer
    epf_rate_monthly = epf_rate / 100 / 12  # Monthly interest rate
    
    accumulated_epf = []  # Store EPF interest balance year by year
    accumulated_balance = [] # Store income balance year by year
    balance = 0  # Initial balance
    
    # Monthly compounding with yearly accreditation
    for year in range(1, years_to_retirement + 1):
        for month in range(1, 13):
            balance += total_monthly_contribution
            balance += balance * epf_rate_monthly  # Monthly compounding
        accumulated_epf.append(balance)  # Accreditation at the end of the year
        accumulated_balance.append(employee_income * 12 * year + balance) # Accreditation at the end of the year
    
    return accumulated_epf, accumulated_balance

def plot_epf_projection(years, accumulated_balance, no_epf):
    """
    Plot comparison for EPF vs. No EPF.
    """
    plt.figure(figsize=(10, 6))
    
    # Plot for EPF vs. No EPF
    plt.plot(range(1, years + 1), accumulated_balance, marker='o', label='With EPF')
    plt.plot(range(1, years + 1), no_epf, marker='o', linestyle='--', label='Without EPF')
    plt.title('EPF Accumulation Over Time')
    plt.xlabel('Years')
    plt.ylabel('EPF Balance (₹)')
    plt.grid(True)
    plt.legend()
    plt.show()

# Input values
employee_income = float(input("Enter your monthly income (₹): "))
years_to_retirement = int(input("Enter the number of years until retirement: "))
epf_rate = float(input("Enter the EPF interest rate (in %): "))

# Calculate EPF projection
accumulated_epf, accumulated_balance = calculate_epf_projection(employee_income, years_to_retirement, epf_rate)

# Calculate projections without EPF (same contribution for each year but no EPF interest)
no_epf = [employee_income * 12 * year for year in range(1, years_to_retirement + 1)]

# Display results
print("\nEPF Accumulation Year by Year:")
for year, balance in enumerate(accumulated_epf, 1):
    print(f"Year {year}: ₹{balance:,.2f}")
if(years_to_retirement < 5):
    print("\nTax is payable if you work under this employer for less than 5 years!")

# Plot the results
plot_epf_projection(years_to_retirement, accumulated_balance, no_epf)