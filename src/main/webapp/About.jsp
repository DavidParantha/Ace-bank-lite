<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>About AceBank – Smart Banking for Everyone</title>
            <meta name="description"
                content="Learn about AceBank, how to create an account, manage your finances, and more." />
            <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css" />
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
                <div class="nav-actions">
                    <c:choose>
                        <c:when test="${not empty sessionScope.firstName}">
                            <a href="<%= request.getContextPath() %>/home"><i data-lucide="layout-dashboard"
                                    class="icon-inline"></i>Dashboard</a>
                            <a href="<%= request.getContextPath() %>/LoanRequest.jsp"><i data-lucide="landmark"
                                    class="icon-inline"></i>Loans</a>
                            <a href="<%= request.getContextPath() %>/Settings.jsp"><i data-lucide="settings"
                                    class="icon-inline"></i>Settings</a>
                            <!-- Avatar Dropdown for logged in users -->
                            <div class="avatar-wrap">
                                <button class="avatar-btn" id="avatarBtn" onclick="toggleAvatarDropdown()">
                                    ${sessionScope.firstName.substring(0,1)}
                                </button>
                                <div class="avatar-dropdown" id="avatarDropdown">
                                    <div class="avatar-dropdown-header">
                                        <div class="avatar-dropdown-email">${sessionScope.email}</div>
                                        <div class="avatar-lg">${sessionScope.firstName.substring(0,1)}</div>
                                        <div class="avatar-dropdown-hi">Hi, ${sessionScope.firstName}!</div>
                                        <a href="<%= request.getContextPath() %>/Settings.jsp"
                                            class="manage-acc-btn">Manage your AceBank Account</a>
                                    </div>
                                    <div class="switcher-section">
                                        <div class="switcher-item">
                                            <div class="switcher-icon">
                                                <i data-lucide="user"></i>
                                            </div>
                                            <div class="switcher-info">
                                                <div class="switcher-name">${sessionScope.firstName}
                                                    ${sessionScope.lastName}</div>
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
                                            <a href="#" style="color: inherit; text-decoration: none;">Privacy
                                                Policy</a>
                                            <span>•</span>
                                            <a href="#" style="color: inherit; text-decoration: none;">Terms of
                                                Service</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="<%= request.getContextPath() %>/index.jsp"><i data-lucide="home"
                                    class="icon-inline"></i>Home</a>
                            <a href="<%= request.getContextPath() %>/login.jsp"><i data-lucide="log-in"
                                    class="icon-inline"></i>Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </header>

            <main class="container">

                <!-- About Hero -->
                <section class="about-hero scroll-reveal">
                    <div class="badge hero-badge pulse-glow" style="margin-bottom: 20px;">
                        <i data-lucide="info" style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"></i>
                        About AceBank
                    </div>
                    <h1>Banking Made <span class="gradient-text">Effortlessly Simple</span></h1>
                    <p>AceBank is a modern, secure banking platform built for everyone. Open an account in minutes,
                        transfer money instantly, apply for loans, and manage your finances — all from one beautiful
                        dashboard.</p>
                </section>

                <!-- How-To Guide -->
                <section class="about-section scroll-reveal">
                    <h2>How It Works</h2>
                    <p>Everything you need to know to get started with AceBank.</p>

                    <div class="howto-grid">
                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.05s">
                            <div class="howto-step">1</div>
                            <h3><i data-lucide="user-plus"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Create an Account</h3>
                            <p>Click <strong>"Join Now"</strong> or <strong>"Open Account"</strong> from the home page.
                                Fill in your first name, last name, Aadhaar number, email, and a strong password (min 10
                                characters).
                                You'll receive your unique account number instantly.</p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.12s">
                            <div class="howto-step">2</div>
                            <h3><i data-lucide="log-in"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Login to Your Account</h3>
                            <p>Go to the <strong>Login</strong> page and enter your account number and password.
                                Check <strong>"Remember Me"</strong> to save your account number for next time.
                                You'll be taken directly to your dashboard.</p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.19s">
                            <div class="howto-step">3</div>
                            <h3><i data-lucide="layout-dashboard"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Use the Dashboard</h3>
                            <p>Your dashboard shows your <strong>balance</strong>, lets you make
                                <strong>deposits</strong>,
                                <strong>send money</strong> to other accounts, and <strong>withdraw</strong> funds.
                                All recent transactions are displayed at the bottom.
                            </p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.26s">
                            <div class="howto-step">4</div>
                            <h3><i data-lucide="key-round"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Reset / Recover Password</h3>
                            <p>Forgot your password? Click <strong>"Forgot Password?"</strong> on the login page.
                                Enter your registered email to receive a <strong>6-digit OTP</strong>.
                                Verify the OTP and set a new password. OTP expires in 5 minutes with max 3 attempts.</p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.33s">
                            <div class="howto-step">5</div>
                            <h3><i data-lucide="shield-check"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Change Your Password</h3>
                            <p>Already logged in? Go to <strong>Settings → Change Password</strong> or use the navbar
                                link.
                                Enter your current password, then set a new one.
                                A strength indicator helps you choose a strong password.</p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.4s">
                            <div class="howto-step">6</div>
                            <h3><i data-lucide="landmark"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--primary);"></i>
                                Apply for a Loan</h3>
                            <p>Navigate to <strong>"Apply Loan"</strong> from the dashboard.
                                Choose from <strong>Home, Personal, Education, Car,</strong> or
                                <strong>Business</strong>
                                loans.
                                Fill in your details and submit. You'll receive a confirmation email.
                            </p>
                        </div>
                    </div>
                </section>

                <!-- Privacy & Security -->
                <section class="about-section scroll-reveal">
                    <h2>Privacy & Security</h2>
                    <p>Your security is our top priority. Here's how we protect your data.</p>

                    <div class="howto-grid">
                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.05s">
                            <h3><i data-lucide="lock"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--success);"></i>
                                BCrypt Encryption</h3>
                            <p>All passwords are hashed using industry-standard <strong>BCrypt</strong> algorithm.
                                Even we cannot see your password — it's one-way encrypted and salted.</p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.12s">
                            <h3><i data-lucide="shield"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--success);"></i>
                                Session Security</h3>
                            <p>Every session is managed securely with <strong>server-side session management</strong>.
                                Unauthorized access to protected pages is automatically blocked by authentication
                                filters.
                            </p>
                        </div>

                        <div class="card card-animate howto-card scroll-reveal" style="animation-delay:.19s">
                            <h3><i data-lucide="mail"
                                    style="width:18px;height:18px;vertical-align:-3px;margin-right:4px;color:var(--success);"></i>
                                OTP Verification</h3>
                            <p>Password resets require a <strong>6-digit OTP</strong> sent to your registered email.
                                OTPs expire in 5 minutes and allow only 3 attempts for maximum security.</p>
                        </div>
                    </div>
                </section>

                <!-- CTA -->
                <section class="card card-animate scroll-reveal"
                    style="text-align: center; margin-top: 48px; padding: 48px 24px; position: relative; overflow: hidden;">
                    <div class="cta-glow"></div>
                    <h2 style="font-size: 28px; font-weight: 800; color: var(--text-heading); margin-bottom: 12px;">
                        Ready to Get Started?
                    </h2>
                    <p class="muted"
                        style="margin-bottom: 24px; max-width: 460px; margin-left: auto; margin-right: auto;">
                        Open your free AceBank account in under 2 minutes. No paperwork, no hassle.
                    </p>
                    <div class="hero-actions">
                        <c:choose>
                            <c:when test="${not empty sessionScope.firstName}">
                                <a href="<%= request.getContextPath() %>/home" class="btn btn-shine">Back to
                                    Dashboard</a>
                                <a href="<%= request.getContextPath() %>/Settings.jsp"
                                    class="btn secondary">Settings</a>
                            </c:when>
                            <c:otherwise>
                                <a href="<%= request.getContextPath() %>/sign-up.jsp" class="btn btn-shine">Create
                                    Account</a>
                                <a href="<%= request.getContextPath() %>/login.jsp" class="btn secondary">Sign In</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <!-- Footer -->
                <footer style="text-align: center; padding: 32px 0 16px; margin-top: 48px;">
                    <p class="muted" style="font-size: 13px;">&copy; 2026 AceBank. All rights reserved. Built with <i
                            data-lucide="heart"
                            style="width:14px;height:14px;vertical-align:-2px;color:var(--danger);fill:var(--danger);"></i>
                        in India.</p>
                </footer>
            </main>

            <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
            <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
        </body>

        </html>