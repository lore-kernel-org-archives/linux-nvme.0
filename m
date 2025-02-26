Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6CAC021BC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3l7GROLF0hZ1BZq3eYPJKkDI6AAachc1n443lFXXU84=; b=dMR4s6MNyXfHPIFOEmtj3kSHwI
	4PWeQJvzSbn2CTWmQruKfunrDMC/m//3Fka/M2mxaZgDZogzW2YzUgAj7Lat8+B9GGPlzPGyUptBz
	5/mX007Yuubr7GJ/reYMIQeZJtXsfcEi/FCyhHQR0E+xO9m3PF6HD7zVl4m7K7Ri+zIxsePfGbP6e
	CSN5MIUnjGBkHU8465LulZyzHGi1Z6jbQviUTBi9bevzHty0IQ3bLX1FNaoYekwqLu+l4WZm0ntKJ
	/KrJ8ypJTtg5ty1YDDdTtUkAQCmhRA353dsBhTbq5u5Kw+eCMuaW+PJOGQjDOlvPLwOZMXOxoUs1x
	nXVHBnNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQA-000000050J8-3ou0;
	Wed, 26 Feb 2025 18:46:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQ8-000000050HL-3ddZ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 844FC5C6A5A;
	Wed, 26 Feb 2025 18:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4CFC4CED6;
	Wed, 26 Feb 2025 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595572;
	bh=rCD9QYbyoazCDF/iLKJMcfOqtD6D4ELGTlkaa2TRQvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qkh3rAotbyNAH5uU5EFkTF85cDZG6TuME+7BiZkC2kcaIoPENXXj0CUmjLPyD0OqD
	 T687OYJdMOft8gAiODzK9QL/1pCW4G7y65u4SOAptJiJtRSvLYDXhLKV8P7P9C8aFY
	 279Gj+EZwt1dJrtN2yBSsyTs0m7Mrp6ZcbVj/yh4SuoJRTbHydcd9hgFCHkyCdXYmM
	 qyy6X3D6K4Q877Ydkek52unB5mEYYQ9DpuMndTTHVp0UcuF4dvXoho4fGo0j+VGcEN
	 I42twBQDwsFjVJchvghgcHTh2Agr4PD8WxsNOFZ0JBDrtW9hKLhK2/d7tHbHzkkU/F
	 OvIO0mMj01Wfw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:58 +0100
Subject: [PATCH 06/11] nvmet-fcloop: track rport with ref counting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104613_008370_48F0A4A3 
X-CRM114-Status: GOOD (  14.06  )
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

The rport object is created via nvme_fc_register_remote and freed
via nvme_fc_unregister_remoteport. That means after the port is
unregistered nothing should use it. Thus ensure with refcounting
that there is no user left before the unregister step.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2269b4d20af2ef9bb423617b94a5f5326ea124bd..d64f5fba136e13c9e4e545acecd905c31542d442 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -223,8 +223,12 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	struct kref			ref;
 };
 
+static int fcloop_rport_get(struct fcloop_rport *rport);
+static void fcloop_rport_put(struct fcloop_rport *rport);
+
 struct fcloop_tport {
 	struct nvmet_fc_target_port	*targetport;
 	struct nvme_fc_remote_port	*remoteport;
@@ -346,6 +350,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
 		spin_lock(&rport->lock);
 	}
 	spin_unlock(&rport->lock);
+	fcloop_rport_put(rport);
 }
 
 static int
@@ -365,7 +370,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 		spin_lock(&rport->lock);
 		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
+		if (queue_work(nvmet_wq, &rport->ls_work))
+			fcloop_rport_get(rport);
 		return ret;
 	}
 
@@ -398,7 +404,8 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 		spin_lock(&rport->lock);
 		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
+		if (queue_work(nvmet_wq, &rport->ls_work))
+			fcloop_rport_get(rport);
 	}
 
 	return 0;
@@ -1078,9 +1085,6 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
 static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
-	struct fcloop_rport *rport = remoteport->private;
-
-	flush_work(&rport->ls_work);
 }
 
 static void
@@ -1386,6 +1390,8 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 
 	/* success */
 	rport = remoteport->private;
+	kref_init(&rport->ref);
+
 	rport->remoteport = remoteport;
 	rport->targetport = (nport->tport) ?  nport->tport->targetport : NULL;
 	if (nport->tport) {
@@ -1418,21 +1424,30 @@ __unlink_remote_port(struct fcloop_nport *nport)
 	return rport;
 }
 
-static int
-__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
+static void
+fcloop_remoteport_unreg(struct kref *ref)
 {
-	int ret;
+	struct fcloop_rport *rport =
+		container_of(ref, struct fcloop_rport, ref);
+	struct fcloop_nport *nport;
 
-	if (!rport) {
-		ret = -EALREADY;
-		goto out;
-	}
+	nport = rport->nport;
+	nvme_fc_unregister_remoteport(rport->remoteport);
 
-	ret = nvme_fc_unregister_remoteport(rport->remoteport);
-out:
 	/* nport ref put: remoteport */
 	fcloop_nport_put(nport);
-	return ret;
+}
+
+static int
+fcloop_rport_get(struct fcloop_rport *rport)
+{
+	return kref_get_unless_zero(&rport->ref);
+}
+
+static void
+fcloop_rport_put(struct fcloop_rport *rport)
+{
+	kref_put(&rport->ref, fcloop_remoteport_unreg);
 }
 
 static ssize_t
@@ -1468,8 +1483,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __remoteport_unreg(nport, rport);
-
+	fcloop_rport_put(rport);
 	fcloop_nport_put(nport);
 
 	return ret ? ret : count;
@@ -1717,10 +1731,7 @@ static void __exit fcloop_exit(void)
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
 		fcloop_tport_put(tport);
-
-		ret = __remoteport_unreg(nport, rport);
-		if (ret)
-			pr_warn("%s: Failed deleting remote port\n", __func__);
+		fcloop_rport_put(rport);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}

-- 
2.48.1


