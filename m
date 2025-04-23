Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A7C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDnsS4qg/7AYD67lTksjaq+U+O3pM/B5DrWKSsF5grQ=; b=BWHt6gE5VWoBHDcAh8wEiwB8wr
	NZC4/ji6wM8a/N12gwJwiDH1qnrpeOY0hwtFAdRxf2TAhaSqa6d9aYxxXDatNg6PZ7oGi2Xwt8mUf
	V5Pvpg+CXPpg/B8PVE8DE1gTP0up8VId0sgXETRTbZURbDeQ8hII8YuTrAF28avJWsfrGyJ8c9pBi
	8EXniWmmkzEjVvw2uuX8VcFlcGDdupOS4wemp4eY7qBL5Qi+MwVL/eWBG5epaaZbOV7+002p2K9Jr
	txFhRaGOPE8BxE+btHKI+leZexgzs0Z/1iWQMrnYZtE9mrGqgPQ20tWbt/oDo9QRmFK3bJsxtLV+r
	lEHCVxMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXP-0000000AhnU-17fu;
	Wed, 23 Apr 2025 13:53:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3L-0000000AamJ-0EUA
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EB53615EB;
	Wed, 23 Apr 2025 13:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A02C4CEEC;
	Wed, 23 Apr 2025 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414534;
	bh=YmvfucME6p9mQbq10tqk6j4ONnoLmEFU9LLeZ/eqRUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=axpj7R5q57Mj82o3h/MOqTF2aEcTMNDebumr54f6EJh6MmVFEog2tkq75/SiowMhA
	 trvi45zHR4C5D9cm8bilF8462kmu82ln4qvPMiEWwuOEDQ8zb+J4fWprBqzN7Cf9nS
	 cFyAmNS0no5ht/gR0h6BqTeq+l7sYSF22lknP6rT2Imd/lcjH8NW2PwlG7lWf3G0jk
	 yiIJpsN9VRyJxZ75ZR9KeLP+e+q3caqttjdEx2eZYGWKS54Az7IJ8Vs/V/FbWZ4Kta
	 01UvBGKkMaFTe6tWcloR4cqDVxDcGrtS1jqa7KDYx9gzQkj7X9we70RxzoPP3HlWc7
	 BiNfsCJ0ihZMg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:51 +0200
Subject: [PATCH v5 08/14] nvmet-fcloop: prevent double port deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-8-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
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
 drivers/nvme/target/fcloop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 9adaee3c7129f7e270842c5d09f78de2e108479a..014cc66f92cb1db0a81a79d2109eae3fff5fd38a 100644
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
@@ -1067,14 +1072,20 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&rport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETED, &rport->flags))
+		delete_port = false;
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1082,14 +1093,20 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&tport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETED, &tport->flags))
+		delete_port = false;
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	fcloop_nport_put(tport->nport);
 }
 
@@ -1433,6 +1450,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	rport->flags = 0;
 	spin_lock_init(&rport->lock);
 	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
 	INIT_LIST_HEAD(&rport->ls_list);
@@ -1530,6 +1548,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	tport->flags = 0;
 	spin_lock_init(&tport->lock);
 	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
 	INIT_LIST_HEAD(&tport->ls_list);

-- 
2.49.0


