Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147D606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4B/Okkf4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nb3gicYM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=8VgjHKA9D0wxTxAwTxM36J8aZ5zKUy8zacU7AGbzWa4=; b=4B/Okkf45mJ4yllVPCsreW+GI8
	Eid02Ee80/LQjJkDH+EIg6aY/UXndfAuHpkx79lbNB0Uei+9NrHR9EYhLJIKyAuBTGhplinH5Dyzk
	7FqAOJBngNSAMLwHz3ErjfhEJE8cx84V2B2vgKKi5h6o21Ryns2q7UMChcptRYuv/yzplcg8g73d5
	pJc/uSe+cpwjp/5DOG5ouvSNHrUommb4TcbcmqbYvDa9yXSCLfPLQxfRF6p/DGcI6v2lOZkdi3hIJ
	n77AdG/+Wroo6VAC6jc2AE7BoU2rfNIfahTuN1xUM1c83iMIS15J963CInMxj1GD1e7cib6pYkU7A
	DbrvqPbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO83W-00000001FfY-2kQX;
	Tue, 03 Nov 2026 06:31:38 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO83R-00000001FfA-3yWF
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:31:37 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-170135e43c7so1998067c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 22:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687493; x=1794292293; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8VgjHKA9D0wxTxAwTxM36J8aZ5zKUy8zacU7AGbzWa4=;
        b=nb3gicYMgUdbuceZj8qzogDk3bkSXK8d+xkBfw6Q3lSSpBRAwYk00MhI0AB+wl1KhG
         L6L2cOBaYJ1GyCWhB1MJf9ZbxRPbiGwg6lueT8E3Pno2G3knGkd3SW0Dp6efy/xcnK+U
         nuy/445573ewtX9WwdE+K0Ohy4BfbsM84eLCdwiYcGeNv50ezuo8Va4Vy21dliuJqA9X
         LeAgqA5l4iVtTC6ry+Imyu5aVvJxAnIfuC7hDr1QlBys9sFPHXpjmjY9+TsObYVzEFCD
         BoG/7gNP98OpFYeKhOJ9L428jxLzfW/o/RzIPf+6N+DV3fEZS3G/r/Fk1uWTE1yhRxjr
         Hz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687493; x=1794292293;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8VgjHKA9D0wxTxAwTxM36J8aZ5zKUy8zacU7AGbzWa4=;
        b=2eV3IXdBm3iHJP8WpFxaHmBrersj6Dq7KVdWZ0flYe9MbQs5AEkvkbu3Ec9kPC2Znh
         iSlVTYkGBNdyk42OkidAJMjYOjKotp47KmvYjKurMFk3pqui945Aps9PzDngO/YeF4Ms
         ElywG4IzMxATFyJAHOHafJkC0AWJj5tz2HlzS9OiG2Xk2LXPpKytgJ17iFSXJYZaLCeK
         gnGobG1unO5uvVKtIbyaLFYzn8RpLYZa+BTYwE/hGEyfy8W/YVrTBIZ0WnCeTZ9Pj60q
         ffFKZmyOd3NV2NQBapVGlC0Mr00Oo88xzK7fubh7W6+bTDD9gfm2WbW/tbyvUwt/yRYp
         RdLA==
X-Gm-Message-State: APuU4Z92+qwuguliiV+I+8plrUgHCLIzfYCmt9l3yFGHkTbZofcgpEyD
	/nfz8Hl+Suq9VwlNzq/iF+I4O6JGzKk/CB9LQivF+f7xAj4+NaVP14HQjpFwOhu6SfE=
X-Gm-Gg: AYBFou1Ed/3dYwSDrZ69hsmKSDo0UisNZjTUKKEChXGzW5Tw8880ovv6i6YZZ/Y0wYu
	3yI6Q/n68Xj8jmdHW5hBh5jl6GIA4PrClPi6lNA5wE9OlTOYkQjG4LiQ6i6rm1us4eSfmDxQ77u
	uWwdrPLCWWSezJGwOh9iyyHAfjUO/rsIp3dpYndfzEKb2ux6V3ZSf3X31/Q/7i+8LPKXGRd2J3I
	WnD5HEMoVuTq2jdmoeJgAJbRjHeRPrHNjwidbJ/PadGnov0hjfeLw6axRVr8qLzzQICBvca9447
	MbnaEB4t4JCuUCObP0mx1pVFfDrILhp42SOQsY10KhUde8oah7zOQuUqOeDk48PQSBfBCdfY9ah
	toot240NxVxHak5aVgGeRAdo5GGsovlZdoltx6z/t9UJEb9DlFcj1a9gwbkmv8e3UQ+Ktkmwzsm
	Q133cugoRozisM+nTUvqhaY3PbAZWK3qTgo3YdzgifL4It0rfr7RJ2wz5cfMB8eDUS4rY6LNK0H
	tzmnU/BRX8evZJ7/ROmaoJwYoqr0ldAXrH7Mbkhq3xcyk6YKQfUg3CLI0t/SCXRSVdtI9HxfncI
	Pry+yURf1XDe4I53dOdq3cSH
X-Received: by 2002:a05:701b:2710:b0:189:ff2b:b194 with SMTP id a92af1059eb24-1ac5b9cb051mr17514114c88.16.1793687491593;
        Mon, 02 Nov 2026 22:31:31 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm45849488c88.16.2026.11.02.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:31:31 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 03 Nov 2026 01:31:25 -0500
Subject: [PATCH] nvmet: drop the extra RCU grace period in
 nvmet_ns_disable()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-bug-nvmet-ns-disable-rcu-v1-1-ff7ac5623923@gmail.com>
X-B4-Tracking: v=1; b=H4sIALx/6WoC/x3MQQqDMBBG4avIrB1IUumiV5EujPkTB9pYMipC8
 O4NLr/Fe5UURaD06ioVHKKy5gbbdzQvU05gCc3kjHtaaxz7PXE+vtg4KwfRyX/AZd75YeBDxGC
 HGKnlv4Io570e39f1Bxqjh+9qAAAA
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_223133_992722_A8528091 
X-CRM114-Status: GOOD (  13.86  )
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

Killing a percpu ref already switches it to atomic mode from an RCU
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
 drivers/nvme/target/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a8171b88035c5..8aca4b279bb9a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -669,13 +669,13 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	/*
 	 * Now that we removed the namespaces from the lookup list, we
 	 * can kill the per_cpu ref and wait for any remaining references
-	 * to be dropped, as well as a RCU grace period for anyone only
-	 * using the namespace under rcu_read_lock().  Note that we can't
-	 * use call_rcu here as we need to ensure the namespaces have
-	 * been fully destroyed before unloading the module.
+	 * to be dropped.  Rely on that wait for anyone only using the
+	 * namespace under rcu_read_lock() too: the ref can't drop to zero
+	 * before an RCU grace period has passed since the kill.  Note that
+	 * we can't use call_rcu here as we need to ensure the namespaces
+	 * have been fully destroyed before unloading the module.
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


