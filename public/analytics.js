(function () {
  const siteId = document.currentScript.dataset.siteId;
  if (!siteId) return;

  function getSource() {
    try {
      return document.referrer ? new URL(document.referrer).hostname : "direct";
    } catch {
      return "unknown";
    }
  }
  const VISITOR_KEY = "visitor_id";

  function getOrCreateVisitorId() {
    let visitorId = localStorage.getItem(VISITOR_KEY);

    if (!visitorId) {
      visitorId = crypto.randomUUID();
      localStorage.setItem(VISITOR_KEY, visitorId);
    }

    return visitorId;
  }
  const SESSION_KEY = "session_id";
  const SESSION_TIMEOUT = 30 * 60 * 1000; // 30 minutes

  function getOrCreateSessionId() {
    const now = Date.now();
    const session = JSON.parse(sessionStorage.getItem(SESSION_KEY) || "null");

    if (!session || now - session.lastActive > SESSION_TIMEOUT) {
      const newSession = {
        id: crypto.randomUUID(),
        lastActive: now,
      };
      sessionStorage.setItem(SESSION_KEY, JSON.stringify(newSession));
      return newSession.id;
    }

    session.lastActive = now;
    sessionStorage.setItem(SESSION_KEY, JSON.stringify(session));
    return session.id;
  }

  function getDevice() {
    const ua = navigator.userAgent.toLowerCase();
    if (/mobile/.test(ua)) return "mobile";
    if (/tablet/.test(ua)) return "tablet";
    return "desktop";
  }

  function sendEvent(event) {
    fetch("http://localhost:3001/track", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        siteId,
        event,
        path: location.pathname,
        source: getSource(),
        device: getDevice(),
        session_id: getOrCreateSessionId(),
        visitor_id: getOrCreateVisitorId(),
        userAgent: navigator.userAgent,
      }),
    });
  }

  sendEvent("page_view");

  let lastPath = location.pathname;
  const observer = new MutationObserver(() => {
    if (location.pathname !== lastPath) {
      lastPath = location.pathname;
      sendEvent("page_view");
    }
  });

  observer.observe(document, { subtree: true, childList: true });
})();
