<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Settings | AceBank</title>
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
                <nav class="nav-actions">
                    <a href="<%= request.getContextPath() %>/home"><i data-lucide="layout-dashboard"
                            class="icon-inline"></i>Dashboard</a>
                    <a href="<%= request.getContextPath() %>/LoanRequest.jsp"><i data-lucide="landmark"
                            class="icon-inline"></i>Loans</a>
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

            <main class="container fade-in-up">

                <section style="margin-bottom: 24px;">
                    <h1 style="font-size: 28px; font-weight: 800; color: var(--text-heading);">
                        <i data-lucide="settings"
                            style="width:28px;height:28px;vertical-align:-4px;margin-right:8px;color:var(--primary);"></i>
                        Settings
                    </h1>
                    <p class="muted" style="margin-top: 6px;">Manage your account, security, and preferences.</p>
                </section>

                <!-- Profile / Account Info Card -->
                <section class="card card-animate" style="margin-bottom: 24px;">
                    <div class="profile-header">
                        <div style="display:flex; align-items:center; gap:16px;">
                            <div class="avatar-lg"
                                style="width:56px;height:56px;min-width:56px;border-radius:50%;background:linear-gradient(135deg,var(--primary),#8b5cf6);color:#fff;font-weight:800;font-size:24px;display:flex;align-items:center;justify-content:center;text-transform:uppercase;">
                                ${sessionScope.firstName.substring(0,1)}
                            </div>
                            <div>
                                <h2 style="font-size:22px;">${sessionScope.firstName} ${sessionScope.lastName}</h2>
                                <div style="display:flex; flex-wrap:wrap; gap:8px; margin-top:8px;">
                                    <span class="badge">
                                        <i data-lucide="hash"
                                            style="width:12px;height:12px;vertical-align:-1px;margin-right:2px;"></i>
                                        Account: ${sessionScope.accountNumber}
                                    </span>
                                    <span class="badge"
                                        style="background:rgba(34,197,94,.15); color:#22c55e; border-color:rgba(34,197,94,.3);">
                                        <i data-lucide="mail"
                                            style="width:12px;height:12px;vertical-align:-1px;margin-right:2px;"></i>
                                        ${sessionScope.email}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <i data-lucide="landmark" class="icon-profile"></i>
                    </div>
                </section>

                <!-- Settings Grid -->
                <div class="settings-grid">

                    <div class="card card-animate settings-card"
                        style="display: flex; flex-direction: column; gap: 8px;">
                        <a href="<%= request.getContextPath() %>/ChangePassword.jsp"
                            style="display: flex; gap: 16px; text-decoration: none; color: inherit;">
                            <div class="settings-icon-wrap blue">
                                <i data-lucide="key-round" class="settings-icon"></i>
                            </div>
                            <div>
                                <h3>Change Password</h3>
                                <p>Update your account password. Use a strong password with letters, numbers, and
                                    symbols.</p>
                            </div>
                        </a>
                        <div style="margin-left: 60px; padding-top: 8px; border-top: 1px solid var(--border);">
                            <a href="<%= request.getContextPath() %>/ForgotPassword.jsp"
                                style="font-size: 13px; color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 4px;">
                                <i data-lucide="help-circle" style="width: 14px; height: 14px;"></i>
                                Forgot current password?
                            </a>
                        </div>
                    </div>

                    <a href="<%= request.getContextPath() %>/LoanRequest.jsp" class="card card-animate settings-card">
                        <div class="settings-icon-wrap green">
                            <i data-lucide="landmark" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>Apply for a Loan</h3>
                            <p>Choose from Home, Personal, Education, Car, or Business loans with competitive rates.</p>
                        </div>
                    </a>

                    <div class="card card-animate settings-card" style="cursor:pointer;" onclick="toggleTheme()">
                        <div class="settings-icon-wrap purple">
                            <i data-lucide="sun-moon" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>Appearance</h3>
                            <p>Switch between dark and light mode. Your preference is saved automatically.</p>
                        </div>
                    </div>

                    <a href="<%= request.getContextPath() %>/SavingsGoal.jsp" class="card card-animate settings-card">
                        <div class="settings-icon-wrap amber">
                            <i data-lucide="target" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>Savings Goal</h3>
                            <p>Set financial targets and track your progress with our smart visualization tool.</p>
                        </div>
                    </a>

                    <a href="<%= request.getContextPath() %>/About.jsp" class="card card-animate settings-card">
                        <div class="settings-icon-wrap cyan">
                            <i data-lucide="info" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>About AceBank</h3>
                            <p>Learn how to use the app, guides for every feature, and our privacy policy.</p>
                        </div>
                    </a>

                    <div class="card card-animate settings-card">
                        <div class="settings-icon-wrap orange">
                            <i data-lucide="shield-check" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>Privacy & Security</h3>
                            <p>Your data is encrypted with BCrypt. Sessions are secure. OTP verification on password
                                resets.</p>
                        </div>
                    </div>

                    <a href="<%= request.getContextPath() %>/logout" class="card card-animate settings-card">
                        <div class="settings-icon-wrap red">
                            <i data-lucide="log-out" class="settings-icon"></i>
                        </div>
                        <div>
                            <h3>Logout</h3>
                            <p>Sign out of your account securely. Your session will be terminated.</p>
                        </div>
                    </a>

                </div>

                <div style="text-align: center; margin-top: 24px; font-size: 14px;">
                    <a href="<%= request.getContextPath() %>/home"><i data-lucide="arrow-left"
                            style="width:14px;height:14px;vertical-align:-2px;margin-right:2px;"></i> Back to
                        Dashboard</a>
                </div>

            </main>

            <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
            <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
        </body>

        </html>