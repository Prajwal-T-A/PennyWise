import matplotlib.pyplot as plt

def calculate_ppf_projection(annual_investment, years, ppf_rate):
    """
    Calculate and project PPF accumulation over time.
    
    Parameters:
    - annual_investment: Annual investment amount (₹).
    - years: Total years to keep the PPF account active.
    - ppf_rate: PPF interest rate (in %).
    
    Returns:
    - A list of accumulated PPF amounts for each year.
    """
    # Print the input data
    print(f"\nInvestment: {annual_investment}\nYears to be kept locked in: {years}\nPPF rate: {ppf_rate}\n")

    if not (500 <= annual_investment <= 150000):
        raise ValueError("Annual investment must be between ₹500 and ₹1,50,000.")

    total_balance = 0  # Initial balance
    accumulated_ppf = []  # Store PPF balance year by year
    rate_fraction = ppf_rate / 100  # Convert rate to decimal
    
    # Annual compounding
    for year in range(1, years + 1):
        total_balance += annual_investment
        total_balance *= (1 + rate_fraction)
        accumulated_ppf.append(total_balance)
    
    return accumulated_ppf

def plot_comparison_ppf(years, accumulated_ppf, no_ppf):
    """
    Plot PPF projection over time and comparison to no PPF.
    """
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, years + 1), accumulated_ppf, marker='o', label='With PPF')
    plt.plot(range(1, years + 1), no_ppf, marker='o', linestyle='--', label='Without PPF')
    plt.title('PPF Accumulation Over Time')
    plt.xlabel('Years')
    plt.ylabel('PPF Balance (₹)')
    plt.grid(True)
    plt.legend()
    plt.show()

# Input values
annual_investment = float(input("Enter your annual investment for PPF (₹): "))
years = int(input("Enter the number of years to keep the PPF active: "))
ppf_rate = float(input("Enter the PPF interest rate (in %): "))

# Calculate PPF projection
try:
    accumulated_ppf = calculate_ppf_projection(annual_investment, years, ppf_rate)
    
    # Calculate projections without PPF (same annual contribution but no compounding)
    no_ppf = [annual_investment * year for year in range(1, years + 1)]
    
    # Display results
    print("\nPPF Accumulation Year by Year:")
    for year, balance in enumerate(accumulated_ppf, 1):
        print(f"Year {year}: ₹{balance:,.2f}")
    
    # Plot comparison of with vs without PPF
    plot_comparison_ppf(years, accumulated_ppf, no_ppf)

except ValueError as e:
    print(f"Error: {e}")