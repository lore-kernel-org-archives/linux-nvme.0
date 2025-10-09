Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F455CCD187
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3sjYs7TwKO5MdT4mEUHlp8nrIdd+x6qO+9WiSK5KBo=; b=cmS8kFgSr+UEXJ77XHhKiWYzxc
	Ui5aSiBt8MilEIn4Hn3YUxvDmFb1d0shI87riOMx1+X2qk1k0fgE2JiiRHYMbMEktvk7x7XX1iV95
	sgNTq9ymI+3VJpM8SWXnCN5AESi2TpiGH+glaX+vTAdk1szZVN36JzcLZjvXU6bWKXVuDqbAcMsHt
	Z29JLeBCDIO3Mlt9rPQWjOVlIx3K/wObbmdGcrIVZxFTTmXxFUMAWiiju3PP6b7SmRnk3ke40RFw6
	qYZvjyJd6vHFCBCeR1zqeyGcm0u8NMTdRc0S2OYAV7DxNQnB9hacenK4+yWmyl/GS9D/RVgbnJy55
	Esjqh8AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t21-00000006adY-2fno;
	Thu, 09 Oct 2025 15:58:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t1z-00000006acW-31Or
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 15:58:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 238B362366;
	Thu,  9 Oct 2025 15:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D82C4CEF7;
	Thu,  9 Oct 2025 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025494;
	bh=vf9lXfhJkmvZ4gOreQJTZxAVrmsPZT8DFyk3EjXjbNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4J4K92OS7w/TQsj9btR3Ld1XSZ8MeDWNisSbN09t3OXgIxNOP15YZWUxz+NLioFF
	 7ZIbA4c4NCy7gbs0dOqv05wIuGZHgXg2/fZppxTvSqSVc2eL9lQ3gdSVcTMeg5jYnJ
	 n0EAw6veYid6HQWMQvyBBU6uhkc8Gs03uhDgMXH0d+YhnRwGNeDuD45NtocWgAmluv
	 xialESWo7oCT1hmN4CBw4yZ3sF5OjmyxSs5YWUKjGpQr9Hjle/agCVUhhsjto4oH/H
	 f6tPiuoprkehBBmUgHoCrXQN/fL9fZkVX74ul8Tbw7Q8AyyOYWeqkTgE1EaCSh0DIq
	 5h59VxF7qqTsg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-5.15] nvmet-fc: avoid scheduling association deletion twice
Date: Thu,  9 Oct 2025 11:54:41 -0400
Message-ID: <20251009155752.773732-15-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit f2537be4f8421f6495edfa0bc284d722f253841d ]

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
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this prevents a real use-after-free when an FC target port is torn
down through configfs.

- `nvmet_port_subsys_drop_link()` first calls `nvmet_port_del_ctrls()`
  and then `nvmet_disable_port()`
  (`drivers/nvme/target/configfs.c:1088`,
  `drivers/nvme/target/core.c:301`), and both paths funnel into
  `__nvmet_fc_free_assocs()` which queues `assoc->del_work`
  (`drivers/nvme/target/fc.c:1482`). So a forced shutdown schedules the
  same association cleanup twice.
- The guard that’s supposed to stop duplicates only runs inside
  `nvmet_fc_delete_target_assoc()` after the work executes
  (`drivers/nvme/target/fc.c:1201`), so the second caller can still re-
  queue the work once the first invocation has freed the association,
  hitting the race reported on the mailing list.
- The patch simply flips the `terminating` flag before queueing
  (`drivers/nvme/target/fc.c:1076` in the new code) and removes the
  redundant check from the worker. That keeps the work from ever being
  queued a second time, exactly matching the original intent with no
  behavioural side effects.
- Change is tiny, isolated to the nvmet-fc transport, and has no
  dependencies beyond the existing `assoc->terminating` infrastructure
  (already present in supported stable series), so the risk of
  regression is minimal while the bug being fixed can crash systems
  under administrative port removal.

If you’re carrying stable trees that include the fc target (v6.10 and
earlier back to when `assoc->terminating` was introduced), you should
pick this up; older branches without the later queue_work refcount patch
just need the same flag move applied to their local
`nvmet_fc_schedule_delete_assoc()`.

 drivers/nvme/target/fc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a9b18c051f5bd..249adb2811420 100644
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


