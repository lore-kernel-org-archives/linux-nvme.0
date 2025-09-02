Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2EDCA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkRWrZKjViLwojvlb5FxVg+quKaINICqlseRFWIdKXk=; b=ybt5m3+RTUunc9f4WDHwhysTYV
	31ajBduYjlTTkJhO9bcs9teW++alVrxY9sFIoJ3ZzU0wIg+MFd2vwrnK2IgO369niDwXjIE1AvT7m
	mjTWAKKOTSHLjGmmtEF5anlSYb9Il/IL3mt3A5qnXk0Zs0BkFzfUMMSjN8unJqMNokxadeVPV9CAd
	F9mwmRj+6yKVUKvvwNp+dMOJEgaDJvHL835wvOHgsURfZvlN35Ag5+1BZtCkMtqCPHGOkiEVNGI6D
	PUXP9UPLx3+hERVXUqzp2/QlplvzE171Ek11jnpw4RNJ4Di5c6tbPLsGsOShYXcBspqIfC6tsMC9I
	ZJ5OesPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQBD-0000000HJWD-49Dl;
	Tue, 02 Sep 2025 12:32:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utO9f-0000000GeBs-1oe2
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:22:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D8B8F6020F;
	Tue,  2 Sep 2025 10:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBDC4CEF5;
	Tue,  2 Sep 2025 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808542;
	bh=pExNi9+edZehDdqmuJ6i1lZki0E/5kjYkaDbpM/DJjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LLlZYqdU3KevwmEYeq6IAuWJMuVjLgmlYSDvY8XcXlg5uESCn2/2XSr3OcrWbOshx
	 NYEoGFa93Yz2tQS9HvcUKkw0uXX0FPG7Hjnd1tUscJkRtmXqtr0omOEjQw3DDvIKgq
	 dly3pWhOgx+ltIbnFLBl3SPtTT7TnYX2y3QDQqhTen1CkXFs4eMQQGqynbPmmPL1hn
	 Hv2O6EUlvAbkOgG4uCy04bsbXwK9fB8iNcg8aHBnkFuCPknvTxu+Od59fLz3Lkx6AD
	 QafS3M3rVgydFCI839AOxoUcVfYrdS4cn4wGBSAqELl2oitWIa4+7Kq1aEfew6HWBm
	 Tes6f5rhbm3LQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:01 +0200
Subject: [PATCH v3 2/4] nvmet-fc: avoid scheduling association deletion
 twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-2-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3/
Reviewed-by: Hannes Reinecke <hare@suse.de>
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


