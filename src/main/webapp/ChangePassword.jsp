<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Change Password | AceBank</title>
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
                <div class="card auth-card" style="padding-bottom: 32px;">

                    <div class="auth-header" style="margin-bottom: 20px;">
                        <i data-lucide="shield-check" class="icon-auth"></i>
                        <h2>Change Password</h2>
                        <p>Protect your account with a strong, unique password.</p>
                    </div>

                    <!-- Status Messages -->
                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success">
                            <i data-lucide="check-circle"
                                style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>
                            Password updated successfully!
                        </div>
                    </c:if>

                    <c:if test="${not empty param.error}">
                        <div class="alert alert-error">
                            <i data-lucide="alert-triangle"
                                style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>
                            <c:choose>
                                <c:when test="${param.error == 'mismatch'}">Confirmation does not match.</c:when>
                                <c:when test="${param.error == 'tooshort'}">Password must be at least 10 chars.</c:when>
                                <c:when test="${param.error == 'same'}">New password cannot be same as current.</c:when>
                                <c:when test="${param.error == 'wrongcurrent'}">Incorrect current password.</c:when>
                                <c:otherwise>Update failed. Please try again.</c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <form action="change-password" method="POST" class="form" style="grid-template-columns: 1fr;"
                        id="change-pw-form">
                        <input type="hidden" name="action" value="changePassword" />

                        <label for="currentPassword">Current Password</label>
                        <div class="password-wrap">
                            <input type="password" id="currentPassword" name="currentPassword" required
                                placeholder="Enter current password" />
                            <button type="button" class="toggle-pw" onclick="togglePassword('currentPassword', this)">
                                <i data-lucide="eye" style="width:18px;height:18px;"></i>
                            </button>
                        </div>

                        <label for="newPassword">New Password</label>
                        <div class="password-wrap">
                            <input type="password" id="newPassword" name="newPassword" required
                                placeholder="Min. 10 characters" minlength="10" />
                            <button type="button" class="toggle-pw" onclick="togglePassword('newPassword', this)">
                                <i data-lucide="eye" style="width:18px;height:18px;"></i>
                            </button>
                        </div>
                        <div class="pw-strength">
                            <div class="pw-strength-bar" id="pw-bar"></div>
                        </div>

                        <label for="confirmPassword">Confirm New Password</label>
                        <div class="password-wrap" style="margin-bottom: 8px;">
                            <input type="password" id="confirmPassword" name="confirmPassword" required
                                placeholder="Re-enter new password" minlength="10" />
                            <button type="button" class="toggle-pw" onclick="togglePassword('confirmPassword', this)">
                                <i data-lucide="eye" style="width:18px;height:18px;"></i>
                            </button>
                        </div>

                        <button class="btn btn-shine" type="submit" style="width:100%; margin-top:12px; padding: 14px;">
                            <i data-lucide="save"
                                style="width:18px;height:18px;vertical-align:-4px;margin-right:8px;"></i>
                            Update Password
                        </button>
                    </form>

                    <div style="text-align: center; margin-top: 24px; font-size: 14px;">
                        <a href="<%= request.getContextPath() %>/home"
                            style="text-decoration: none; color: var(--muted);">
                            <i data-lucide="arrow-left"
                                style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"></i>
                            Back to Dashboard
                        </a>
                    </div>
                </div>
            </main>

            <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
            <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
            <script>
                // Password strength indicator
                const pwInput = document.getElementById('newPassword');
                const pwBar = document.getElementById('pw-bar');
                if (pwInput && pwBar) {
                    pwInput.addEventListener('input', function () {
                        const val = this.value;
                        let strength = 0;
                        if (val.length >= 8) strength++;
                        if (/[A-Z]/.test(val) && /[a-z]/.test(val)) strength++;
                        if (/[0-9]/.test(val) && /[^A-Za-z0-9]/.test(val)) strength++;
                        pwBar.className = 'pw-strength-bar ' + ['', 'weak', 'medium', 'strong'][strength];
                    });
                }

                // Show success popup if updated
                window.onload = function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    if (urlParams.get('success') === 'updated') {
                        alert('Password updated successfully!');
                    }
                };
            </script>
        </body>

        </html>