Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE38C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1VPg0zzRFFXOexVsxctQBy3L1AfDsBcsiUfabTztMk=; b=mu7u7cfQvkMs1+IvPlQAggpwBD
	6aekMToTo6HRgtQC7b9vrGBwD/+J9wfDzg6QANTARu/bFowc0FF8RR6jbllPwNEaVrPULg8ExoWIR
	h6zhB4L/voGciZ6797Jx8IOqwmDxk6uWYijivL+5iUZkaFl639mDCRvOtDoKsW/tQTXnO264LsOK9
	wTzC2MuIrU4cuF6Q4m5qgegJKRV8CqpttjmKAl/mXMKsV+KxwJ8y+QrSlsjoLLI90KGoqzpjYJXaQ
	0oxtaIaCLzMb4/4KwcwySP1ErRPpeSu8BeEc5AzOjbJCbxpbXRnsN4gRev9csuD32k8rPUx0ulpFX
	sYOVzKvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN1-00000005Y0r-3SxF;
	Tue, 18 Mar 2025 10:40:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMz-00000005XxB-3OZc
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 685565C55E3;
	Tue, 18 Mar 2025 10:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C466BC4CEF1;
	Tue, 18 Mar 2025 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294425;
	bh=Ao268T67hDxmPxHaefQt0CLnltxYa5k4a0l1IHd9hCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iwv68cRy9tqCoYfLNsYQLavDYYTwic6Oc8x/ZZz4dmO9bwrzmj0bOGQCU2tJtS0US
	 NDSgaQ8l5TEc5sCR8LgS9PLczdTy10ABgkyiUKFydwWHByBN9NsZTG1ngSz384w+n8
	 RrEffaCh1unPpy8Xj5wmBuVWycFe90FhGl24jdFBaY3wx2B5x4Ri3fAVdAOYKR+73G
	 sDEz3+2tD0vKXPjlr1Yt1LMgUAJH/zto93EAMyGnixlf8AzjayVhm7a96NPnrRBz/O
	 2+xVVQwyJVXbxU4UxdLgW7rBl6bsxT4/0hJf1io+MtU3XYlcxg0GsJKWM96w3o4j+U
	 0wjN15SW0UuXA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:03 +0100
Subject: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034025_953205_D6095B6C 
X-CRM114-Status: GOOD (  11.85  )
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

The delete callback can be called either via the unregister function or
from the transport directly. Thus it is necessary ensure resources are
not freed multiple times.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index de23f0bc5599b6f8dd5c3713dd38c952e6fdda28..06f42da6a0335c53ae319133119d057aab12e07e 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -215,6 +215,8 @@ struct fcloop_lport_priv {
 	struct fcloop_lport *lport;
 };
 
+#define PORT_DELETE	0
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port	*remoteport;
 	struct nvmet_fc_target_port	*targetport;
@@ -223,6 +225,7 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_tport {
@@ -233,6 +236,7 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_nport {
@@ -1062,14 +1066,20 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&rport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETE, &rport->flags))
+		delete_port = false;
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	/* nport ref put: rport */
 	fcloop_nport_put(rport->nport);
 }
@@ -1078,14 +1088,20 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&tport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETE, &tport->flags))
+		delete_port = false;
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	complete(&tport->nport->tport_unreg_done);
 
 	/* nport ref put: tport */
@@ -1394,6 +1410,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	rport->flags = 0;
 	spin_lock_init(&rport->lock);
 	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
 	INIT_LIST_HEAD(&rport->ls_list);
@@ -1492,6 +1509,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	tport->flags = 0;
 	spin_lock_init(&tport->lock);
 	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
 	INIT_LIST_HEAD(&tport->ls_list);

-- 
2.48.1


