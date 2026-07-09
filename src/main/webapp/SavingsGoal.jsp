<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Savings Goal - AceBank</title>
            <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <!-- Particle Canvas Background -->
            <canvas id="particle-canvas"></canvas>

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

            <main class="container" style="padding-top: 40px; padding-bottom: 80px;">
                <div class="hero-section" style="text-align: center; margin-bottom: 48px;">
                    <div class="badge" style="margin: 0 auto 16px;">
                        <i data-lucide="target"
                            style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"></i>
                        Financial Planning
                    </div>
                    <h1 style="font-size: 42px; font-weight: 800; margin-bottom: 12px;">Your Savings Goal</h1>
                    <p class="muted" style="max-width: 600px; margin: 0 auto;">Set a target, track your progress, and
                        watch your wealth grow with AceBank's smart tracking tools.</p>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 32px; align-items: start;">

                    <!-- Left: Goal Setup -->
                    <div class="card card-animate" style="padding: 32px;">
                        <h3 style="display: flex; align-items: center; gap: 12px; margin-bottom: 24px;">
                            <i data-lucide="pen-tool" style="color: var(--primary);"></i>
                            Configure Goal
                        </h3>

                        <div class="form" style="display: flex; flex-direction: column; gap: 20px;">
                            <div>
                                <label>What are you saving for?</label>
                                <input type="text" id="goalName" placeholder="e.g. Dream House, New Car"
                                    style="width: 100%; margin-top: 8px;" value="General Savings">
                            </div>
                            <div>
                                <label>Target Amount (₹)</label>
                                <input type="number" id="goalTarget" placeholder="Enter amount"
                                    style="width: 100%; margin-top: 8px;" value="10000">
                            </div>
                            <div
                                style="padding: 16px; background: rgba(var(--primary-rgb), 0.05); border-radius: 12px; border: 1px dashed var(--primary);">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                    <span class="muted" style="font-size: 14px;">Current Balance</span>
                                    <span
                                        style="font-weight: 700; color: var(--primary);">₹{sessionScope.balance}</span>
                                </div>
                                <p style="font-size: 12px; color: var(--muted); margin: 0;">We use your current account
                                    balance to calculate progress.</p>
                            </div>
                            <button class="btn btn-shine" onclick="updateGoal()" style="width: 100%; margin-top: 8px;">
                                <i data-lucide="refresh-cw"
                                    style="width:16px;height:16px;vertical-align:-2px;margin-right:8px;"></i>
                                Update Goal
                            </button>
                        </div>
                    </div>

                    <!-- Right: Progress Visualization -->
                    <div class="card card-animate"
                        style="padding: 32px; min-height: 400px; display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <h3 id="displayGoalName" style="font-size: 24px; font-weight: 800; margin-bottom: 8px;">
                                General Savings</h3>
                            <p class="muted" style="margin-bottom: 32px;">Target: <span id="displayTarget"
                                    style="font-weight: 700; color: var(--text-heading);">₹10,000.00</span></p>

                            <div style="margin-bottom: 48px;">
                                <div style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                                    <span style="font-weight: 700;">Progress</span>
                                    <span id="percentText" style="font-weight: 700; color: var(--primary);">0%</span>
                                </div>
                                <div
                                    style="height: 24px; background: rgba(0,0,0,0.05); border-radius: 12px; overflow: hidden; border: 1px solid var(--border);">
                                    <div id="progressBar"
                                        style="height: 100%; width: 0%; background: linear-gradient(90deg, var(--primary), #8b5cf6); transition: width 1s cubic-bezier(0.34, 1.56, 0.64, 1); position: relative;">
                                        <div
                                            style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent); animation: shine 2s infinite;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                                <div class="stat-card"
                                    style="background: rgba(var(--success-rgb), 0.05); border: 1px solid rgba(var(--success-rgb), 0.1); padding: 20px; border-radius: 16px;">
                                    <div class="muted" style="font-size: 13px; margin-bottom: 4px;">Saved So Far</div>
                                    <div id="savedAmount"
                                        style="font-size: 20px; font-weight: 800; color: var(--success);">
                                        ₹₹{sessionScope.balance}</div>
                                </div>
                                <div class="stat-card"
                                    style="background: rgba(var(--primary-rgb), 0.05); border: 1px solid rgba(var(--primary-rgb), 0.1); padding: 20px; border-radius: 16px;">
                                    <div class="muted" style="font-size: 13px; margin-bottom: 4px;">Remaining</div>
                                    <div id="remainingAmount"
                                        style="font-size: 20px; font-weight: 800; color: var(--primary);">₹0.00</div>
                                </div>
                            </div>
                        </div>

                        <div id="milestoneMsg"
                            style="margin-top: 32px; padding: 16px; border-radius: 12px; background: #fffbeb; border: 1px solid #fef3c7; color: #92400e; display: flex; gap: 12px; align-items: center;">
                            <i data-lucide="award" style="width: 24px; height: 24px;"></i>
                            <span style="font-size: 14px; font-weight: 500;">Keep going! You're making great progress
                                towards your goal.</span>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
            <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
            <input type="hidden" id="hdnBalance" value="${not empty sessionScope.balance ? sessionScope.balance : 0}">
            <script>
                const uBalance = parseFloat(document.getElementById('hdnBalance').value);

                function updateGoal() {
                    const name = document.getElementById('goalName').value;
                    const target = parseFloat(document.getElementById('goalTarget').value);

                    if (isNaN(target) || target <= 0) {
                        if (window.showToast) showToast('Please enter a valid target amount', 'error');
                        return;
                    }

                    // Update UI
                    document.getElementById('displayGoalName').textContent = name;
                    document.getElementById('displayTarget').textContent = '$' + target.toLocaleString(undefined, { minimumFractionDigits: 2 });

                    const progress = Math.min((uBalance / target) * 100, 100);
                    const remaining = Math.max(target - uBalance, 0);

                    document.getElementById('progressBar').style.width = progress + '%';
                    document.getElementById('percentText').textContent = Math.round(progress) + '%';
                    document.getElementById('remainingAmount').textContent = '$' + remaining.toLocaleString(undefined, { minimumFractionDigits: 2 });

                    // Milestones
                    const msgEl = document.getElementById('milestoneMsg');
                    if (progress >= 100) {
                        msgEl.style.background = '#f0fdf4';
                        msgEl.style.borderColor = '#dcfce7';
                        msgEl.style.color = '#166534';
                        msgEl.innerHTML = '<i data-lucide="party-popper"></i><span>Congratulations! You have reached your savings goal!</span>';
                    } else if (progress >= 50) {
                        msgEl.style.background = '#eff6ff';
                        msgEl.style.borderColor = '#dbeafe';
                        msgEl.style.color = '#1e40af';
                        msgEl.innerHTML = '<i data-lucide="trending-up"></i><span>Over halfway there! Your dedication is paying off.</span>';
                    } else {
                        msgEl.style.background = '#fffbeb';
                        msgEl.style.borderColor = '#fef3c7';
                        msgEl.style.color = '#92400e';
                        msgEl.innerHTML = '<i data-lucide="award"></i><span>Keep going! Every bit saved brings you closer to your dream.</span>';
                    }
                    lucide.createIcons();

                    if (window.showToast) showToast('Goal updated successfully!', 'success');
                }

                // Initial run
                window.addEventListener('load', () => {
                    updateGoal();
                });
            </script>
            <style>
                @keyframes shine {
                    0% {
                        transform: translateX(-100%);
                    }

                    100% {
                        transform: translateX(100%);
                    }
                }
            </style>
        </body>

        </html>