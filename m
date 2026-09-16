Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB44C982C3
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O+y/Q9mdt9PnTTtST4xQER5OnK2laopva58JNzfhxRc=; b=tVdhYzXECSTe4DbGT3svLtvz2O
	T00MGznWsollgFgQVTL7VAC20lgVLem3sNOr0aTHbDhAAojHI6uWudKCnQRbO/6ki2EdNgWRgMsEY
	AbvnEa0BLC7nu1fNTmRUPVyCUPQuY9TcSb3YSYpB11tNTiTk4vU/3mDUeuIwdBzdqvpvqqOOoEfQ1
	7f5zQky5Nb9upU6uVL/EXD9l19ybAUmT2Z3raq6MSb8o6cb+LoDNPNmSImZyU3nZbqGVIq1VbEoOJ
	QKt6o/4WSK4jvN/IsTLhGyrFxT+BWOXuMpz+4yulmYQciLqhC4uAhd/kOs4AUEAtCt+1IaOd52z+p
	5fA2Ndpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o2c-000000096Nx-27zl;
	Wed, 16 Sep 2026 11:43:06 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o2Z-000000096LM-02kL
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 11:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789558980; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O+y/Q9mdt9PnTTtST4xQER5OnK2laopva58JNzfhxRc=;
	b=w6ybGUJB/xlXoIaVZ8oRb0d4YsLvDrY9UMWaaClTYXpvy6S9cmR1/qhULoEejjXDnnOL0rb9Qo7FlWH792EE+z1RY3a1TEYRfIQc4+PastNi1bcIdlhR7s/6mFYb5RVTwY9FrdoKKKHuPY/SUxNvNhDDJ9tlo2K+G5F9dCBmmVg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB4wRQK_1789558979;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB4wRQK_1789558979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:42:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: copy the hostid into the ctrl before creating PR pc_refs
Date: Wed, 16 Sep 2026 19:42:54 +0800
Message-ID: <20260916114254.335277-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_044303_267899_9683089C 
X-CRM114-Status: GOOD (  11.37  )
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

Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
implementation") added a second uuid_copy() of args->hostid near the end
of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
uuid_copy") removed the original copy that sat before
nvmet_ctrl_init_pr() instead of the new one.

Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
per-controller per-namespace reservation refs while the uuid_copy()
from the connect data runs later, after the controller is published.
The ctrl is allocated with kzalloc(), so every pc_ref created on this
path stores the nil UUID.

pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
matches it against the preempted registrant's hostid to kill and drain
the victim's in-flight I/O for Preempt and Abort.  The match can never
hit with the nil UUID, so whenever a namespace with reservations
enabled exists before a host connects, which includes every reconnect,
Preempt and Abort silently degrades into a plain Preempt: the
preempting host sees success while the victim's in-flight I/O is still
in the air.

Copy the hostid where the rest of the connect data is consumed, before
the controller is published and before nvmet_ctrl_init_pr() takes its
snapshot.

Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..8c8c8627871f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1648,6 +1648,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
 	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
+	if (args->hostid)
+		uuid_copy(&ctrl->hostid, args->hostid);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
@@ -1706,9 +1708,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	nvmet_start_keep_alive_timer(ctrl);
 
-	if (args->hostid)
-		uuid_copy(&ctrl->hostid, args->hostid);
-
 	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
-- 
2.43.7


