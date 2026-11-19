(async () => {
  const list = document.querySelector("#boss-list");
  const detail = document.querySelector("#detail");
  const search = document.querySelector("#search");
  const number = new Intl.NumberFormat("en-US");

  let data;
  try {
    const response = await fetch("http://127.0.0.1:3000/api/data");
    if (!response.ok) throw new Error(`The server responded with ${response.status}`);
    data = await response.json();
    if (!Array.isArray(data.bosses)) throw new Error("The API did not return the boss list.");
  } catch (error) {
    console.error("Could not load data from MySQL.", error);
    list.innerHTML = '<p class="empty">Boss data is currently unavailable.</p>';
    detail.textContent = "MySQL and the API must be running to load boss data.";
    return;
  }

  let selectedId = data.bosses[0]?.ID_BOSS;
  document.querySelector("#boss-total").textContent = number.format(data.bosses.length);

  const findById = (rows, key, value) => rows.find((row) => row[key] === value);
  const escapeHtml = (value) => String(value).replace(/[&<>"']/g, (char) => ({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': "&quot;",
    "'": "&#39;"
  })[char]);

  function renderList() {
    const query = search.value.trim().toLocaleLowerCase("en");
    const bosses = data.bosses.filter((boss) => {
      const attack = findById(data.attacks, "ID_ATTACK", boss.ID_ATTACK);
      return [boss.Boss_Name, attack?.Attack_Name, attack?.Type]
        .some((value) => String(value ?? "").toLocaleLowerCase("en").includes(query));
    });

    document.querySelector("#result-count").textContent = `${bosses.length}`;
    if (!bosses.some((boss) => boss.ID_BOSS === selectedId)) selectedId = bosses[0]?.ID_BOSS;

    if (!bosses.length) {
      list.innerHTML = '<p class="empty">No boss found. Try another name.</p>';
      detail.innerHTML = '<p class="empty">Choose a boss from the list to see its details.</p>';
      return;
    }

    list.innerHTML = bosses.map((boss) => `
      <button class="boss-row" type="button" role="option"
        aria-selected="${boss.ID_BOSS === selectedId}"
        aria-current="${boss.ID_BOSS === selectedId}"
        data-id="${boss.ID_BOSS}">
        <span>
          <span class="boss-name">${escapeHtml(boss.Boss_Name)}</span>
          <span class="boss-meta">${number.format(boss.Defense)} DEF</span>
        </span>
        <span class="life-chip">${number.format(boss.Life_Amount)} HP</span>
      </button>`).join("");

    list.querySelectorAll(".boss-row").forEach((button) => {
      button.addEventListener("click", () => {
        selectedId = Number(button.dataset.id);
        renderList();
      });
    });

    renderDetail(bosses.find((boss) => boss.ID_BOSS === selectedId));
  }

  function renderDetail(boss) {
    if (!boss) return;
    const attack = findById(data.attacks, "ID_ATTACK", boss.ID_ATTACK);
    const minion = findById(data.minions, "ID_MINION", boss.ID_MINION);
    const bag = data.bags.find((row) => row.ID_BOSS === boss.ID_BOSS);
    const items = bag ? data.items.filter((item) => item.ID_TREASUREBAG === bag.ID_TREASUREBAG) : [];
    const segments = data.segments.filter((segment) => segment.ID_BOSS === boss.ID_BOSS);
    const minionAttack = minion && findById(data.attacks, "ID_ATTACK", minion.ID_ATTACK);
    const wikiName = boss.Boss_Name.replace(/ \(Wave 15\+\)$/, "");
    const wikiUrl = `https://terraria.wiki.gg/wiki/Special:Search?search=${encodeURIComponent(wikiName)}`;

    detail.innerHTML = `
      <div class="detail-header">
        <div class="boss-art" hidden></div>
        <div class="detail-title-group">
          <div class="detail-kicker">Boss · ${String(boss.ID_BOSS).padStart(2, "0")}</div>
          <div class="detail-heading">
            <h2 class="detail-title">${escapeHtml(boss.Boss_Name)}</h2>
            <a class="wiki-link" href="${wikiUrl}" target="_blank" rel="noopener noreferrer">View on wiki ↗</a>
          </div>
        </div>
      </div>
      <div class="stats">
        <div><span class="stat-label">Life</span><span class="stat-value">${number.format(boss.Life_Amount)}</span></div>
        <div><span class="stat-label">Defense</span><span class="stat-value">${number.format(boss.Defense)}</span></div>
        <div><span class="stat-label">Parts</span><span class="stat-value">${segments.length || "—"}</span></div>
      </div>
      <div class="detail-body">
        <section class="detail-section">
          <h3>Attack</h3>
          ${attack
            ? `<div class="info-card"><div class="info-name">${escapeHtml(attack.Attack_Name)}</div><div class="info-meta">${escapeHtml(attack.Type)} · ${number.format(attack.Damage)} damage</div></div>`
            : '<p class="no-data">No attack associated.</p>'}
        </section>
        <section class="detail-section">
          <h3>Minion</h3>
          ${minion
            ? `<div class="info-card"><div class="info-name">${escapeHtml(minion.Minion_Name)}</div><div class="info-meta">${number.format(minion.Life_Amount)} life · ${number.format(minion.Defense ?? 0)} defense${minionAttack ? ` · ${escapeHtml(minionAttack.Attack_Name)}` : ""}</div></div>`
            : '<p class="no-data">No minions associated.</p>'}
        </section>
        <section class="detail-section">
          <h3>Treasure Bag &amp; Drops</h3>
          ${bag
            ? `<p class="info-meta">${escapeHtml(bag.Treasure_Bag_Name)}</p>
              <div class="loot-list">${items.map((item) => `
                <div class="loot-item">
                  <span>${escapeHtml(item.Item_Name)} <span class="item-meta">×${number.format(item.Amount)}</span></span>
                  <span class="item-meta">${escapeHtml(item.Type)}</span>
                </div>`).join("")}</div>`
            : '<p class="no-data">No treasure bag recorded.</p>'}
        </section>
        ${segments.length ? `<section class="detail-section">
          <h3>Boss Parts</h3>
          <div class="segment-list">${segments.map((segment) => `
            <div class="segment-item">
              <span>${escapeHtml(segment.Segment_Name.replaceAll("_", " "))}</span>
              <span class="segment-meta">${number.format(segment.Life_Amount)} HP · ${number.format(segment.Defense)} DEF</span>
            </div>`).join("")}</div>
        </section>` : ""}
      </div>`;

    const art = detail.querySelector(".boss-art");
    const image = document.createElement("img");
    image.alt = `${boss.Boss_Name} image`;
    const imageUrl = typeof boss.Image_URL === "string" ? boss.Image_URL.trim() : "";
    if (imageUrl) {
      image.addEventListener("load", () => { art.hidden = false; }, { once: true });
      image.addEventListener("error", () => { art.hidden = true; }, { once: true });
      image.src = imageUrl;
      art.append(image);
    }
  }

  search.addEventListener("input", renderList);
  document.addEventListener("keydown", (event) => {
    const target = event.target;
    const isTyping = target instanceof HTMLElement &&
      (target.isContentEditable || ["INPUT", "TEXTAREA", "SELECT"].includes(target.tagName));
    if (event.key === "/" && !isTyping && !event.ctrlKey && !event.metaKey && !event.altKey) {
      event.preventDefault();
      search.focus();
    }
  });

  renderList();
})().catch((error) => {
  console.error("Error starting the page.", error);
  document.querySelector("#detail").textContent = "An error occurred while displaying the data.";
});
