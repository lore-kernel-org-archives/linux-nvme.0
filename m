Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB2606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sqOxxEpe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J66Ct+rM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=f6L55/RbaJ3smpt9qLKGW/waSSFGUX0+URTLDC9PQCw=; b=sqOxxEpeGF9Dm/LmgfDVbN5Yhh
	GS0E9KzUeuxGmDVB+UbrEcQTyIToo6NEUOI9USuKSXqxPFObwjZUefAp42PTpYWcLM4h04iaftQZN
	hxUkBEahJNjoJqqrL+ELzfeTy9bWS0cR2K3A8bJ7pm3KyEfcosD4d2robCVtuOO6re9/myQp9MSyP
	cHp+/PuXOTgWLQGKfDZovbEEXgfyh4Ar7AE6n96I4vr4JB2TsLUnqyFTouN6MAiVx5deNK+rysOds
	GSxvdFDhq6fZSE4KzY0q2gOqOr7GCv/MC/bKgR7/Yp0vkMnBHQN/6SQ7BCwPdC8DthLosoyCroWlu
	u4/mBUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUX2-00000004QLA-3RmU;
	Wed, 04 Nov 2026 06:31:36 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUWz-00000004QK2-1k6s
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 06:31:35 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1adbf62dd31so579334c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 22:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773893; x=1794378693; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f6L55/RbaJ3smpt9qLKGW/waSSFGUX0+URTLDC9PQCw=;
        b=J66Ct+rMHiAV3OfKFZ5HH2PR2di9p/f2z5IUJufBgEogu0PCMugicbq9EsGWdi5TLG
         9UcFg8Udixtzqqbo/RCoQFzmVjkZuHm/15JOPYDNuY5H4nN8QQXN0FnyHFLs+MUCTbl+
         /LYtQWIRoJfInz/tAxnzkZ43JPuh+tCBjphDfxIXUIZ/ReczxWLjK4RNLj6iqLiiUdPN
         i+nEIfswM4sSkEvLAi/JIoKhYyi/1zFG99hQmgbO9qYKBV318rOjbQ9/beUwn3sHYXOy
         GaZKyevVwHSUwPo0vd7lziLfXGIyd8lQk+mmAw99PQULIAcgDoI2IpGQQ6BxantePuNO
         n1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773893; x=1794378693;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f6L55/RbaJ3smpt9qLKGW/waSSFGUX0+URTLDC9PQCw=;
        b=cKBxYiFTtTEFSVD/VUSWhxEcISSjWSiERP5cxtqFPMwCEWhYCuoNf8kchEZgh9MoMj
         oxTf7Mtpw/C/xdP2ORzowBC6sXRyUte1pfCt/pA7K705C/Kopi0zNH+CnvY1qDyXzfCZ
         2WflVZAzHoKvdK+A5rJ/7llrrBradU1ffb3zFhTZ/dxg3AURtSExJGLGuaISIMjd5di6
         JEiqxuBdmaRsdSyra7mobIM36e8JVjkdlKwgjGzc9qImAmoCD5KbmUJ+0F9CuuHF3oo4
         NOu8r+NeVRS8JbR9dJyBuNJ4oRZRx+X6uSeinBMTK3gRfnz6pmR1gisu/eMVPn/5u2n6
         bg/Q==
X-Gm-Message-State: APuU4Z+HdrkHj1c5qXh4YGex9wW4GjepSUwHTS3P2dcgMnFWcjsmbygn
	fGa5UdVU+OkxUKxRe17wVIabi8Cj+CuQE0J2yj/U6o0vhSvpLpDAzlQW
X-Gm-Gg: AYBFou0pAqs5hx5plzb/4uDTOMoD4RkGyMKxqpD2I95lva1qeBfXcAS3YE4TEheSF0X
	UQbA97+aTDm88tUdRBQMWl44o6IYB17Ut2JzcpdbtmcMc+8njPZdbMRanmgDla80lkHv6t+ZyES
	ScLWQws/U1X6WjEhpiCkMkwMUvCuz1RCY6rur09oMas5WXzISCbRBty25ekMpoIK5FwnA2j5fxJ
	hesXzY1rzIGw8QIFoUEG8jfHI4hbuy6Dqx5ZLZha6dqPqUcEZIO7CCTCor/U8GJdi0vcxwhiCx3
	1Tw6+Vo80OC0l0pGkM8r/5Y83GOS/HKrJIpuQr7EEvwh88l2NU8pXIZxU54LbUzA9cL/yUO6wOf
	GmgckanmBjmNwv57nEC0A0rrYX4vj1+0oZRHagT8WssVC8kQ4fxr3dLeHSTrEG6kLeQh2ALy8A5
	TFEjiyIZ+b4g6kxNYUZRb8clj1q7dXTKJ5+wWfWq6comkZn2j4SE/7F2DA8Tt5DSJChluG/YKuV
	VOXvC/o5OmYusrXI/RXIQ07TRw1NpQHmIF+50FacxGF4Fk7laWFG+7uy6MNqU+itRYD887JTh7r
	pPsa6hM0NjgV7txLq13Wqse/
X-Received: by 2002:a05:701b:4193:10b0:15a:4155:3d9d with SMTP id a92af1059eb24-1ac5da76f61mr23283133c88.31.1793773892649;
        Tue, 03 Nov 2026 22:31:32 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c69c3fsm4558998c88.20.2026.11.03.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:31:32 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:31:28 -0500
Subject: [PATCH v2] nvmet: drop the extra RCU grace period in
 nvmet_ns_disable()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bug-nvmet-ns-disable-rcu-v2-1-b158a59318ad@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD/R6moC/3WNQQ6CMBBFr0Jm7RjaIkZX3sOwKGUKk0AhLTQa0
 rtbSVy6fC/57+8QyDMFuBc7eIoceHYZ5KkAM2jXE3KXGWQpayFKie3Wo4sTregCdhx0OxJ6s6E
 qqe0sVaKyFvJ88WT5daSfTeaBwzr79/EUxdf+oup/NAoUaO1Vm0st1U2qRz9pHs9mnqBJKX0A4
 uuLycAAAAA=
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_223133_485923_594C2C99 
X-CRM114-Status: GOOD (  14.53  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_ns_disable() kills the namespace's percpu ref, waits in
synchronize_rcu() for anyone looking the namespace up under
rcu_read_lock(), and then waits for the ref to drop to zero.

Killing a percpu ref that is still in percpu mode, as the namespace
ref always is until then, switches it to atomic mode from an RCU
callback, so the ref can't drop to zero before a grace period has
passed since the kill. synchronize_rcu() thus adds a second grace
period in a row, about 4 ms here, and disabling the namespaces of a
subsystem one by one takes about 9 ms each.

Drop synchronize_rcu() and rely on the wait for the ref to cover the
RCU readers as well.

Disabling 64 namespaces through configfs, median of 3 runs on each of
two boots per kernel:

  host connected  before          after
  none            588 / 590 ms    409 / 409 ms
  nvme-tcp        617 / 619 ms    542 / 511 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Note in the comment that this relies on the ref staying in percpu
  mode until the kill

v1: https://lore.kernel.org/r/20261103-bug-nvmet-ns-disable-rcu-v1-1-ff7ac5623923@gmail.com
---
 drivers/nvme/target/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a8171b88035c5..50486fc3cde8b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -669,13 +669,15 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	/*
 	 * Now that we removed the namespaces from the lookup list, we
 	 * can kill the per_cpu ref and wait for any remaining references
-	 * to be dropped, as well as a RCU grace period for anyone only
-	 * using the namespace under rcu_read_lock().  Note that we can't
-	 * use call_rcu here as we need to ensure the namespaces have
-	 * been fully destroyed before unloading the module.
+	 * to be dropped.  Rely on that wait for anyone only using the
+	 * namespace under rcu_read_lock() too: the ref can't drop to zero
+	 * before an RCU grace period has passed since the kill.  This only
+	 * holds as long as nothing switches the ref to atomic mode before
+	 * the kill; bring back synchronize_rcu() here if that changes.
+	 * Note that we can't use call_rcu here as we need to ensure the
+	 * namespaces have been fully destroyed before unloading the module.
 	 */
 	percpu_ref_kill(&ns->ref);
-	synchronize_rcu();
 	wait_for_completion(&ns->disable_done);
 	percpu_ref_exit(&ns->ref);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvmet-ns-disable-rcu-30ebdfe414ff

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


