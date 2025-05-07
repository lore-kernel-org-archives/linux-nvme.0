Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF23C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g45ouMru8YdHnjiY56WfaAoUceJupiH65HB2+2B9N3M=; b=gKN7jW+ncmqkWv1SbA1oGzM1Ay
	qQgb2PJkRT6Ie/7FNF9Kv10odmq30QcwNp8WFhnW46BNa9//TfOIHks5t8utKCNUyPDvJuSVlHRCE
	MZ/kfSCl2vUkwBESucqK6txyXFkL/njceQdARRpDMB+2JlqvR4sIPIPeOQ8wa3mQp6/yBrZv5FICx
	UsUAzACXtZUDQji3aoXbCSEY4BCgarcjJnHikZ5lz3IJ8SKTaKG8ADtlfjK9B+KjZdg+DCmaZoNRj
	Y1qS4Mz1fhmL4gwQfUTtd05eRsmr43fIal3z+hotvTIEpcXb5QiOxob5BGGkd2pib5ubUaEV/PyPo
	w4AYh4LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo7-0000000FN2j-39tn;
	Wed, 07 May 2025 12:23:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo6-0000000FN1F-0y9m
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A4914629E6;
	Wed,  7 May 2025 12:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E64C4CEEB;
	Wed,  7 May 2025 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620605;
	bh=6b42JwnMURdt5WTJ46ewytcIr/A+kw+Ss9xMkw6/v2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iSB+1aM7jMplBaAZ5EVqgcIAvWm0z4oGtjQ3KMzqOxlY0KTK75ubKmtI02eEcO9AH
	 3096cqOZMGiU6pu1rtcKyKfqT8btRMpg4qoego/QvGEHuX7DRfIyNQp6WE/9XKcYv1
	 iRb2k/AoNCWnOmwBJkQdjsfDVSxSKeTGPYrLbFBN3EaEiGSTe5u8ZLqvOpwyrKeOso
	 cybwyQqqTOhqcusqqzV18JUFLIYIx/vX11ddy9n4VICJoCuKVPgN4HETEwtVseWnTX
	 J2ySLWdnYemrk3dICluN6nZ7um5AJroRjS94djSYNzN4TKcQtuaf2kyU5LEJ70FVss
	 LtOVQvwHayg0A==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:04 +0200
Subject: [PATCH v6 08/14] nvmet-fcloop: prevent double port deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-8-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
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

The delete callback can be called either via the unregister function or
from the transport directly. Thus it is necessary ensure resources are
not freed multiple times.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 9adaee3c7129f7e270842c5d09f78de2e108479a..c74baa7f6e43c8bddd9e6948f806f27b032b1d4d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -215,6 +215,9 @@ struct fcloop_lport_priv {
 	struct fcloop_lport *lport;
 };
 
+/* The port is already being removed, avoid double free */
+#define PORT_DELETED	0
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port	*remoteport;
 	struct nvmet_fc_target_port	*targetport;
@@ -223,6 +226,7 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_tport {
@@ -233,6 +237,7 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_nport {
@@ -1067,30 +1072,38 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	bool put_port = false;
 	unsigned long flags;
 
 	flush_work(&rport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (!test_and_set_bit(PORT_DELETED, &rport->flags))
+		put_port = true;
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	fcloop_nport_put(rport->nport);
+	if (put_port)
+		fcloop_nport_put(rport->nport);
 }
 
 static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	bool put_port = false;
 	unsigned long flags;
 
 	flush_work(&tport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (!test_and_set_bit(PORT_DELETED, &tport->flags))
+		put_port = true;
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	fcloop_nport_put(tport->nport);
+	if (put_port)
+		fcloop_nport_put(tport->nport);
 }
 
 #define	FCLOOP_HW_QUEUES		4
@@ -1433,6 +1446,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	rport->flags = 0;
 	spin_lock_init(&rport->lock);
 	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
 	INIT_LIST_HEAD(&rport->ls_list);
@@ -1530,6 +1544,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	tport->flags = 0;
 	spin_lock_init(&tport->lock);
 	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
 	INIT_LIST_HEAD(&tport->ls_list);

-- 
2.49.0


