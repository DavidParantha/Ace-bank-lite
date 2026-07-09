<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Apply for Loan | AceBank</title>
            <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css" />
            <style>
                .loan-types {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
                    gap: 12px;
                    margin-bottom: 8px;
                }

                .loan-type-option {
                    position: relative;
                }

                .loan-type-option input[type="radio"] {
                    position: absolute;
                    opacity: 0;
                    pointer-events: none;
                }

                .loan-type-option label {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 8px;
                    padding: 18px 12px;
                    border-radius: var(--radius-sm);
                    border: 2px solid var(--border);
                    cursor: pointer;
                    transition: all .25s ease;
                    font-weight: 600;
                    font-size: 13px;
                    color: var(--muted);
                    background: rgba(15, 23, 42, .3);
                    text-align: center;
                }

                :root[data-theme="light"] .loan-type-option label {
                    background: rgba(241, 245, 249, .5);
                }

                .loan-type-option label:hover {
                    border-color: var(--primary);
                    color: var(--text);
                    transform: translateY(-2px);
                }

                .loan-type-option input:checked+label {
                    border-color: var(--primary);
                    background: var(--primary-glow);
                    color: var(--primary);
                    box-shadow: 0 4px 16px var(--primary-glow);
                }

                .loan-icon {
                    width: 28px;
                    height: 28px;
                    stroke-width: 1.8;
                }
            </style>
        </head>

        <body>

            <!-- Floating Parallax Orbs -->
            <div class="orb orb-1"></div>
            <div class="orb orb-2"></div>
            <div class="orb orb-3"></div>

            <header class="navbar">
                <a href="<%= request.getContextPath() %>/About.jsp" class="brand">
                    <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="AceBank Logo"
                        class="brand-logo">
                    Ace<span>Bank</span>
                </a>
                <nav class="nav-actions">
                    <a href="<%= request.getContextPath() %>/home"><i data-lucide="layout-dashboard"
                            class="icon-inline"></i>Dashboard</a>
                    <a href="<%= request.getContextPath() %>/Settings.jsp"><i data-lucide="settings"
                            class="icon-inline"></i>Settings</a>
                    <a href="<%= request.getContextPath() %>/About.jsp"><i data-lucide="info"
                            class="icon-inline"></i>About</a>

                    <!-- Avatar Dropdown -->
                    <div class="avatar-wrap">
                        <button class="avatar-btn" id="avatarBtn" onclick="toggleAvatarDropdown()">
                            ${sessionScope.firstName.substring(0,1)}
                        </button>
                        <div class="avatar-dropdown" id="avatarDropdown">
                            <div class="avatar-dropdown-header">
                                <div class="avatar-dropdown-email">${sessionScope.email}</div>
                                <div class="avatar-lg">${sessionScope.firstName.substring(0,1)}</div>
                                <div class="avatar-dropdown-hi">Hi, ${sessionScope.firstName}!</div>
                                <a href="<%= request.getContextPath() %>/Settings.jsp" class="manage-acc-btn">Manage
                                    your AceBank Account</a>
                            </div>
                            <div class="switcher-section">
                                <div class="switcher-item">
                                    <div class="switcher-icon">
                                        <i data-lucide="user"></i>
                                    </div>
                                    <div class="switcher-info">
                                        <div class="switcher-name">${sessionScope.firstName} ${sessionScope.lastName}
                                        </div>
                                        <div class="switcher-email">${sessionScope.email}</div>
                                    </div>
                                    <i data-lucide="check" style="color: var(--success); width: 16px;"></i>
                                </div>
                                <a href="<%= request.getContextPath() %>/login.jsp" class="switcher-item">
                                    <div class="switcher-icon">
                                        <i data-lucide="user-plus"></i>
                                    </div>
                                    <div class="switcher-info">
                                        <div class="switcher-name">Add another account</div>
                                    </div>
                                </a>
                            </div>
                            <div class="avatar-dropdown-footer">
                                <a href="<%= request.getContextPath() %>/logout" class="signout-all-btn">
                                    <i data-lucide="log-out" style="width: 16px;"></i>
                                    Sign out of all accounts
                                </a>
                                <div
                                    style="display: flex; justify-content: center; gap: 12px; font-size: 11px; color: var(--muted); padding-top: 8px;">
                                    <a href="#" style="color: inherit; text-decoration: none;">Privacy Policy</a>
                                    <span>•</span>
                                    <a href="#" style="color: inherit; text-decoration: none;">Terms of Service</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>
            </header>

            <main class="auth-page">
                <div class="card auth-card wide">
                    <div class="auth-header" style="margin-bottom: 32px;">
                        <i data-lucide="landmark" class="icon-auth"></i>
                        <h2>Apply for a Loan</h2>
                        <p>AceBank offers flexible loan options tailored to your needs. Review the information and terms
                            below to start your application.</p>
                    </div>

                    <!-- Loan Information Section -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 32px;">
                        <div class="card"
                            style="padding: 20px; border: 1px solid var(--border); background: rgba(var(--primary-rgb), 0.03);">
                            <h4
                                style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px; color: var(--primary);">
                                <i data-lucide="info" style="width: 18px; height: 18px;"></i>
                                Why Loan with AceBank?
                            </h4>
                            <ul style="padding-left: 20px; font-size: 14px; color: var(--muted); line-height: 1.6;">
                                <li>Competitive Interest Rates starting at 8.5% p.a.</li>
                                <li>Quick Approval & minimal documentation.</li>
                                <li>Flexible Repayment Tenures up to 30 years.</li>
                                <li>Zero Hidden Charges or processing fees for educational loans.</li>
                            </ul>
                        </div>
                        <div class="card"
                            style="padding: 20px; border: 1px solid var(--border); background: rgba(var(--success-rgb), 0.03);">
                            <h4
                                style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px; color: var(--success);">
                                <i data-lucide="shield-check" style="width: 18px; height: 18px;"></i>
                                Eligibility Criteria
                            </h4>
                            <ul style="padding-left: 20px; font-size: 14px; color: var(--muted); line-height: 1.6;">
                                <li>Minimum Age: 21 years.</li>
                                <li>Steady Source of Income (Salaried or Self-Employed).</li>
                                <li>Good Credit Score (750+ preferred).</li>
                                <li>Active AceBank Account for at least 3 months.</li>
                            </ul>
                        </div>
                    </div>

                    <!-- Terms & Conditions Box -->
                    <div style="margin-bottom: 32px;">
                        <label style="margin-bottom: 8px; display: block; font-weight: 700;">Banking Terms &
                            Conditions</label>
                        <div
                            style="height: 120px; overflow-y: auto; padding: 16px; background: rgba(0,0,0,0.05); border: 1px solid var(--border); border-radius: var(--radius-sm); font-size: 13px; color: var(--muted); line-height: 1.5;">
                            <p style="margin-bottom: 8px;"><strong>1. Application Review:</strong> All loan applications
                                are subject to thorough credit appraisal and verification of documents. AceBank reserves
                                the right to reject any application without assigning reasons.</p>
                            <p style="margin-bottom: 8px;"><strong>2. Interest Rates:</strong> Mentioned rates are
                                indicative and subject to change based on market conditions and individual credit
                                profiles.</p>
                            <p style="margin-bottom: 8px;"><strong>3. Repayment:</strong> Failure to pay EMIs on time
                                will result in penal interest and will negatively impact your credit score.</p>
                            <p style="margin-bottom: 8px;"><strong>4. Prepayment:</strong> Prepayment charges may apply
                                as per the specific loan product guidelines selected at the time of disbursement.</p>
                            <p><strong>5. Security:</strong> For certain loan types, collateral or guarantees may be
                                required as per bank policy.</p>
                        </div>
                    </div>

                    <form action="loan-request" method="POST" class="form" style="grid-template-columns: 1fr 1fr;">

                        <%-- Loan Type Selector --%>
                            <div style="grid-column: 1 / -1;">
                                <label style="margin-bottom:8px; display:block;">Select Loan Type</label>
                                <div class="loan-types">
                                    <div class="loan-type-option">
                                        <input type="radio" name="loanType" id="home-loan" value="HOME" required>
                                        <label for="home-loan">
                                            <i data-lucide="home" class="loan-icon"></i>
                                            Home Loan
                                        </label>
                                    </div>
                                    <div class="loan-type-option">
                                        <input type="radio" name="loanType" id="personal-loan" value="PERSONAL">
                                        <label for="personal-loan">
                                            <i data-lucide="user" class="loan-icon"></i>
                                            Personal
                                        </label>
                                    </div>
                                    <div class="loan-type-option">
                                        <input type="radio" name="loanType" id="edu-loan" value="EDUCATION">
                                        <label for="edu-loan">
                                            <i data-lucide="graduation-cap" class="loan-icon"></i>
                                            Education
                                        </label>
                                    </div>
                                    <div class="loan-type-option">
                                        <input type="radio" name="loanType" id="car-loan" value="CAR">
                                        <label for="car-loan">
                                            <i data-lucide="car" class="loan-icon"></i>
                                            Car Loan
                                        </label>
                                    </div>
                                    <div class="loan-type-option">
                                        <input type="radio" name="loanType" id="biz-loan" value="BUSINESS">
                                        <label for="biz-loan">
                                            <i data-lucide="briefcase" class="loan-icon"></i>
                                            Business
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <label for="fullName">Full Name</label>
                                <input type="text" name="fullName" id="fullName"
                                    value="${sessionScope.firstName} ${sessionScope.lastName}" required
                                    style="width:100%; margin-top:6px;">
                            </div>
                            <div>
                                <label for="email">Email Address</label>
                                <input type="email" name="email" id="email" value="${sessionScope.email}" required
                                    style="width:100%; margin-top:6px;">
                            </div>

                            <div>
                                <label for="phone">Phone Number</label>
                                <input type="tel" name="phone" id="phone" placeholder="e.g. 9876543210"
                                    pattern="[0-9]{10}" style="width:100%; margin-top:6px;">
                            </div>
                            <div>
                                <label for="amount">Loan Amount (₹)</label>
                                <input type="number" name="amount" id="amount" placeholder="e.g. 500000" min="1000"
                                    step="1000" required style="width:100%; margin-top:6px;">
                            </div>

                            <div style="grid-column: 1 / -1;">
                                <label style="display:flex; align-items:center; gap:8px; margin-top:4px;">
                                    <input type="checkbox" required>
                                    <span class="muted">I agree to the terms and conditions and consent to a
                                        credit check.</span>
                                </label>
                            </div>

                            <div style="grid-column: 1 / -1; margin-top: 8px;">
                                <button class="btn btn-shine" type="submit" style="width:100%;">
                                    <i data-lucide="send"
                                        style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>Submit
                                    Application
                                </button>
                            </div>
                    </form>

                    <div style="text-align: center; margin-top: 16px; font-size: 14px;">
                        <a href="<%= request.getContextPath() %>/home"><i data-lucide="arrow-left"
                                style="width:14px;height:14px;vertical-align:-2px;margin-right:2px;"></i> Back
                            to Dashboard</a>
                    </div>
                </div>
            </main>

            <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
            <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
        </body>

        </html>