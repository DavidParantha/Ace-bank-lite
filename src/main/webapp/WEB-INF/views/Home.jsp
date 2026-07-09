<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate" ); response.setHeader("Pragma", "no-cache"
    ); response.setDateHeader("Expires", 0); %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard | AceBank</title>
                <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/main.css" />
                <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs"
                    type="module"></script>
            </head>

            <body>

                <!-- Auto-logout warning banner -->
                <div class="logout-warning" id="logoutWarning">
                    <i data-lucide="alert-triangle" style="width:18px;height:18px;"></i>
                    <span>Logging out in <strong id="logoutCountdown">60</strong>s due to inactivity...</span>
                </div>

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

                    <!-- Profile Header -->
                    <section class="card card-animate" style="margin-bottom: 20px;">
                        <div class="profile-header">
                            <div style="display:flex; align-items:center; gap:16px;">
                                <div
                                    style="width:52px;height:52px;min-width:52px;border-radius:50%;background:linear-gradient(135deg,var(--primary),#8b5cf6);color:#fff;font-weight:800;font-size:22px;display:flex;align-items:center;justify-content:center;text-transform:uppercase;">
                                    ${sessionScope.firstName.substring(0,1)}
                                </div>
                                <div style="flex: 1;">
                                    <h2>Hello, ${sessionScope.firstName}</h2>
                                    <p class="badge" style="margin-top: 8px;"><i data-lucide="hash"
                                            style="width:12px;height:12px;vertical-align:-1px;margin-right:2px;"></i>Account:
                                        ${sessionScope.accountNumber}</p>
                                </div>
                            </div>
                            <i data-lucide="landmark" class="icon-profile"></i>
                        </div>
                    </section>

                    <%-- Statement sent success notification --%>

                        <div class="grid">
                            <!-- Balance Card — Hidden by Default -->
                            <div class="card card-animate">
                                <div class="balance">
                                    <div>
                                        <h3><i data-lucide="wallet" class="icon-inline"></i>Total Balance</h3>
                                        <p class="muted">Your available funds</p>
                                    </div>
                                    <span class="badge"
                                        style="background: rgba(34,197,94,.15); color: #22c55e; border-color: rgba(34,197,94,.3);">
                                        <i data-lucide="check-circle"
                                            style="width:12px;height:12px;vertical-align:-1px;margin-right:2px;"></i>Active
                                    </span>
                                </div>

                                <!-- Hidden balance amount -->
                                <div id="balanceHidden" style="margin-top: 16px; text-align:center;">
                                    <div class="amount" style="letter-spacing:6px; color:var(--muted);">₹ ••••••</div>
                                    <button class="reveal-btn" onclick="showBalance()">
                                        <i data-lucide="eye" class="reveal-icon"></i>
                                        <span>View Balance</span>
                                    </button>
                                </div>

                                <!-- Revealed balance (hidden at first) -->
                                <div id="balanceRevealed" style="display:none; margin-top: 16px;">
                                    <div class="amount">
                                        ₹ <span id="balance-counter">${sessionScope.balance}</span>
                                    </div>
                                    <button class="reveal-btn" onclick="hideBalance()" style="margin-top:10px;">
                                        <i data-lucide="eye-off" class="reveal-icon"></i>
                                        <span>Hide Balance</span>
                                    </button>
                                </div>
                            </div>

                            <!-- Quick Deposit -->
                            <div class="card card-animate">
                                <h3><i data-lucide="plus-circle" class="icon-inline"></i> Quick Deposit</h3>
                                <p class="muted" style="margin-bottom: 12px;">Add money to your account instantly</p>
                                <form action="home" method="post" class="form">
                                    <input type="number" step="0.01" min="1" name="deposit" placeholder="Amount (₹)"
                                        required />
                                    <button class="btn success" type="submit"><i data-lucide="arrow-down-circle"
                                            style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>Add</button>
                                </form>
                            </div>

                            <!-- Send Money -->
                            <div class="card card-animate">
                                <h3><i data-lucide="send" class="icon-inline"></i> Send Money</h3>
                                <p class="muted" style="margin-bottom: 12px;">Transfer to another AceBank account</p>
                                <form action="home" method="post" class="form"
                                    style="grid-template-columns: 1fr 1fr auto;">
                                    <input type="number" name="toAccount" placeholder="Recipient Acc No" required />
                                    <input type="number" step="0.01" min="1" name="toAmount" placeholder="Amount (₹)"
                                        required />
                                    <button class="btn" type="submit"><i data-lucide="arrow-right-circle"
                                            style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>Send</button>
                                </form>
                            </div>

                            <!-- Withdraw -->
                            <div class="card card-animate">
                                <h3><i data-lucide="banknote" class="icon-inline"></i> Withdraw Money</h3>
                                <p class="muted" style="margin-bottom: 12px;">Daily limit: ₹500.00</p>
                                <form action="home" method="post" class="form">
                                    <input type="number" step="0.01" min="1" name="withdraw" placeholder="Amount (₹)"
                                        required />
                                    <button class="btn danger" type="submit"><i data-lucide="arrow-up-circle"
                                            style="width:16px;height:16px;vertical-align:-2px;margin-right:4px;"></i>Withdraw</button>
                                </form>
                            </div>
                        </div>

                        <!-- Loan Requests Section -->
                        <section class="card card-animate" style="margin-top: 20px;">
                            <h3><i data-lucide="landmark" class="icon-inline"></i> Loan Application Status</h3>
                            <p class="muted" style="margin-bottom: 16px;">Track your submitted loan requests</p>

                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Type</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.loanRequestsList}">
                                            <c:forEach var="loan" items="${sessionScope.loanRequestsList}">
                                                <tr>
                                                    <td>${loan.createdAt()}</td>
                                                    <td>${loan.loanType()}</td>
                                                    <td>₹ ${loan.amount()}</td>
                                                    <td>
                                                        <span
                                                            class="tag ${loan.status().toLowerCase()}">${loan.status()}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4"
                                                    style="text-align:center; padding: 24px; color: var(--muted);">
                                                    No loan applications found.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <div style="margin-top: 16px; text-align: right;">
                                <a href="<%= request.getContextPath() %>/LoanRequest.jsp" class="btn"
                                    style="text-decoration: none; display: inline-flex; align-items: center;">
                                    <i data-lucide="plus" style="width:16px;height:16px;margin-right:4px;"></i> Apply
                                    for New Loan
                                </a>
                            </div>
                        </section>

                        <!-- Transactions — Hidden by Default -->
                        <section class="card card-animate" style="margin-top: 20px;">

                            <!-- Transaction area: button when hidden, full table when shown -->
                            <div id="txHidden">
                                <div style="text-align:center; padding:32px 16px;">
                                    <i data-lucide="shield"
                                        style="width:40px;height:40px;color:var(--muted);opacity:.4;display:block;margin:0 auto 12px;"></i>
                                    <h3 style="color:var(--text-heading); margin-bottom:6px;">Transaction History</h3>
                                    <p class="muted" style="font-size:14px; margin-bottom:16px;">Your transactions are
                                        private. Click below to view.</p>
                                    <button class="reveal-btn" onclick="showTransactions()">
                                        <i data-lucide="eye" class="reveal-icon"></i>
                                        <span>View Transaction History</span>
                                    </button>
                                </div>
                            </div>

                            <div id="txRevealed" style="display:none;">
                                <div
                                    style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                                    <h3><i data-lucide="clipboard-list" class="icon-inline"></i> Transaction History
                                    </h3>
                                    <div style="display:flex; gap:8px; flex-wrap:wrap;">
                                        <form action="<%= request.getContextPath() %>/send-statement" method="POST"
                                            style="display:inline;">
                                            <button type="submit" class="reveal-btn" style="margin-top:0;">
                                                <i data-lucide="mail" class="reveal-icon"></i>
                                                <span>Email Statement</span>
                                            </button>
                                        </form>
                                        <button class="reveal-btn" onclick="hideTransactions()" style="margin-top:0;">
                                            <i data-lucide="eye-off" class="reveal-icon"></i>
                                            <span>Hide</span>
                                        </button>
                                    </div>
                                </div>

                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Reference</th>
                                            <th>Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.transactionDetailsList}">
                                                <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
                                                    <tr>
                                                        <td>${tx.createdAt()}</td>
                                                        <td><span
                                                                class="tag ${tx.txType().toLowerCase()}">${tx.txType()}</span>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${tx.txType() == 'TRANSFER'}">
                                                                    ${tx.senderAccount() == sessionScope.accountNumber ?
                                                                    'To' : 'From'}
                                                                    ${tx.senderAccount() == sessionScope.accountNumber ?
                                                                    tx.receiverAccount() : tx.senderAccount()}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${tx.remark()}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td style="font-weight: 600;">₹ ${tx.amount()}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="4"
                                                        style="text-align:center; padding: 32px; color: var(--muted);">
                                                        <i data-lucide="inbox"
                                                            style="width:24px;height:24px;display:block;margin:0 auto 8px;opacity:.5;"></i>
                                                        No transactions yet. Make your first deposit!
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                        </section>

                </main>

                <footer
                    style="text-align:center; padding:40px 20px; color:var(--muted); font-size:14px; border-top:1px solid var(--border-color); margin-top:40px;">
                    <p>&copy; 2024 AceBank Lite. All rights reserved.</p>
                </footer>

                <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
                <script src="<%= request.getContextPath() %>/assets/js/ui.js"></script>
                <script>
                    // ===== Balance Show/Hide =====
                    function showBalance() {
                        document.getElementById('balanceHidden').style.display = 'none';
                        document.getElementById('balanceRevealed').style.display = 'block';
                        if (typeof lucide !== 'undefined') lucide.createIcons();
                    }
                    function hideBalance() {
                        document.getElementById('balanceHidden').style.display = 'block';
                        document.getElementById('balanceRevealed').style.display = 'none';
                        if (typeof lucide !== 'undefined') lucide.createIcons();
                    }

                    // ===== Transactions Show/Hide =====
                    function showTransactions() {
                        document.getElementById('txHidden').style.display = 'none';
                        document.getElementById('txRevealed').style.display = 'block';
                        if (typeof lucide !== 'undefined') lucide.createIcons();
                    }
                    function hideTransactions() {
                        document.getElementById('txHidden').style.display = 'block';
                        document.getElementById('txRevealed').style.display = 'none';
                        if (typeof lucide !== 'undefined') lucide.createIcons();
                    }

                    // ===== Auto-Logout on 5 min Inactivity =====
                    (function () {
                        const IDLE_LIMIT = 5 * 60 * 1000;   // 5 minutes
                        const WARNING_AT = 60 * 1000;        // Show warning at 1 min remaining
                        const LOGOUT_URL = '<%= request.getContextPath() %>/logout';

                        let idleTimer = null;
                        let warningTimer = null;
                        let countdownInterval = null;

                        const warning = document.getElementById('logoutWarning');
                        const countdownEl = document.getElementById('logoutCountdown');

                        function resetTimers() {
                            clearTimeout(idleTimer);
                            clearTimeout(warningTimer);
                            clearInterval(countdownInterval);
                            if (warning) warning.classList.remove('show');

                            warningTimer = setTimeout(function () {
                                if (warning) warning.classList.add('show');
                                let sec = Math.floor(WARNING_AT / 1000);
                                countdownInterval = setInterval(function () {
                                    sec--;
                                    if (countdownEl) countdownEl.textContent = sec;
                                    if (sec <= 0) clearInterval(countdownInterval);
                                }, 1000);
                            }, IDLE_LIMIT - WARNING_AT);

                            idleTimer = setTimeout(function () {
                                window.location.href = LOGOUT_URL;
                            }, IDLE_LIMIT);
                        }

                        ['mousemove', 'mousedown', 'keypress', 'touchstart', 'scroll', 'click'].forEach(function (evt) {
                            document.addEventListener(evt, resetTimers, { passive: true });
                        });

                        document.addEventListener('visibilitychange', function () {
                            if (!document.hidden) resetTimers();
                        });

                        resetTimers();
                    })();
                </script>
            </body>

            </html>