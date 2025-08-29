Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F387DCA0FF0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Aug 2025 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bszIUzxQLTEt9qKtVk60Yq14XpKWvo60eVObJJ0Pfk=; b=4XWDib7IVFVkbpNCRFtNHU1Tth
	eQEECHzfjVEv2GeirO8BsvWOisi6ygFfgt+1zL3aYqX27qcSPLy6lHVV3NMaWJSNV38RwI7rSR3lj
	BswvYYV6BispfXy8CeOkvbHOuOFvBmWKav/dCxF9s1vCwbT1HWRSSmZKKECvDWom9yNQe+KCwrcI+
	/GxIsQjIg9x788U3VJk2rBhs85RzE690ONefh4eqFBpP68vtnE9IjeckzoH6//UIEX41MKUEy9VDQ
	EUcxOh9ICsNAO6X9G0VvL5d8YK0ubrrpanSuhQxaBmAuvY8bDKxhqCLP++Krn5fnfngGkFRR/ifA8
	utamVsTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us9jm-000000078VR-14Zm;
	Sat, 30 Aug 2025 00:46:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1Fz-00000006FC1-2e2f
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:43:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 58CE5406DD;
	Fri, 29 Aug 2025 15:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF43C4CEF6;
	Fri, 29 Aug 2025 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482195;
	bh=fqRuJpbCT5D0SI6B1QuBDKlqWeqnFieL/HVZ3RqF/YE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P2Oaridc/+ZIk9H+gKb71zx2+9aHlG2tVTkcao+8z7qWiBJZJV7xAuDDXQrM/HimZ
	 Wr7AfitBOhvmIXHc40LWraIv7YIbqRtKutDf41Wf6qBiHCuzfljKo9lOvIhST8BblI
	 IH5XogRtOcxCH4tmcZamHv3G6qmLdeDLZxpd8PPE2ohj8PH/Qoa6jTdzV9CsRoXPPF
	 yU6vLIlXjT9Vn7lYOGFmUsTTOUxx1zX4SN9Bcyw95B24FMsZQMTM8c5lrd+zizlJ2T
	 09KL+C9e/Jp4Vrp982rO0bI7rEBPMw4EBPAxf3lu6/jKpTPCOhf7P6HtADwhnjxFAu
	 YfV+oFNXKK9KQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:43:01 +0200
Subject: [PATCH v2 2/2] nvmet-fc: avoid scheduling association deletion
 twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
In-Reply-To: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_084315_719508_4712955A 
X-CRM114-Status: GOOD (  16.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When forcefully shutting down a port via the configfs interface,
nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
then nvmet_disable_port(). Both functions will eventually schedule all
remaining associations for deletion.

The current implementation checks whether an association is about to be
removed, but only after the work item has already been scheduled. As a
result, it is possible for the first scheduled work item to free all
resources, and then for the same work item to be scheduled again for
deletion.

Because the association list is an RCU list, it is not possible to take
a lock and remove the list entry directly, so it cannot be looked up
again. Instead, a flag (terminating) must be used to determine whether
the association is already in the process of being deleted.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6725c34dd7c90ae38f8271368e609fd0ba267561..7d84527d5a43efe1d43ccf5fb8010a4884f99e3e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1075,6 +1075,14 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
+	int terminating;
+
+	terminating = atomic_xchg(&assoc->terminating, 1);
+
+	/* if already terminating, do nothing */
+	if (terminating)
+		return;
+
 	nvmet_fc_tgtport_get(assoc->tgtport);
 	if (!queue_work(nvmet_wq, &assoc->del_work))
 		nvmet_fc_tgtport_put(assoc->tgtport);
@@ -1202,13 +1210,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	unsigned long flags;
-	int i, terminating;
-
-	terminating = atomic_xchg(&assoc->terminating, 1);
-
-	/* if already terminating, do nothing */
-	if (terminating)
-		return;
+	int i;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_del_rcu(&assoc->a_list);

-- 
2.51.0


