Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283CAC982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=; b=hzQcM4yMr4IGQaVzxZNa/c9Wag
	NABOOZ++1V2eehy5gCocGGXmnB1rwVfFpSLZOKyncQ83RrmZIOPi9zFS8zQuAYSuZtf7jpjsFN0dN
	qlZUvsT8u8TQCMeLDPrQw32h8wh7H67+fmrNLbF4x4UUmY6bZzdLkesa+7jAZkZAIXEhX2xl7mOAi
	k/0ov9s8oGSbaLJD5m32EB4fnYKqOpk+CEvZMnO2CdeOrJle67G+RPwT9GGuW89ppvxoySW5zGtzS
	HdWTNf4hdCnFY3eckaFc7E0D/g4ObYSE1ChCghjJeAkF6EQL0pJ6Sd2OjW3VWsyAehbY/o94BtYyz
	5BBhoeug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJP-00000000ENj-2lua;
	Sun, 20 Sep 2026 18:30:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJN-00000000EHf-0sYw
	for linux-nvme@bombadil.infradead.org;
	Sun, 20 Sep 2026 18:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=; b=dOHfGCPxv1NYEakigm7w4Gz90m
	rpwkoWJBdzkkZ2B+6FwZWI+3oY0PyJeEABIPzlnGeVy5YAF7DrLEdQqSoGUAps8pBHj0rQHTmJpAf
	Zn/ZU7u+mQZBrfSMGMQ9qBqtJhQcHy04nnSBsOOXEFlZl8kflrkvkzQcolkbYYX6xWAxO3YhZUz4/
	kFtMGj4j7yCfEsnGnKC/Rt0hGLvo4WDyJvQbXLUwUo0+8MHtA/3kWnifiG34Jkp4QzJ3CinLZ0Qz8
	H5iD0nL9GK+gYifc3gRvbb27drvHMqIlUwxzKD/uDfVPH9L06SfPORUHND0PG04e4+266AMjj9GiT
	M06ZKXCg==;
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8MJK-0000000BXjy-1HfW
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:48 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1537161a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929044; x=1790533844; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=;
        b=DMeCo0adxbaUFuxY8DBQUVUPYqTim5zXvC2+4Sr7UVS5LDCkljb2vOkT0z6nB2tuD1
         UVI/StTN0/pck7mpr4Uk5fOgB5YTfRRyiPgikwhIwn/OxmVVBXPBVAZ2KhWfNFHgavM+
         4shkZ1PtWEf10NFVRY/KaKyb2JDeAyzFQFZfk1PTjhV0BPfqAlyRI3d6BEBkrT1YRrvF
         8OZsygq6roRA8R9S59RcY3N1YyAHEA2nzfy8tJp5TM4c4S+iBDRsBG6WMdoTinh0naos
         ytUbE53M9/9ZbTj19PGpbN5wG7N5dY2n6DVrgN64aX5GcR4xEgiPlDOiPHV23cqm9F+c
         4yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929044; x=1790533844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=;
        b=F0IF5prXL6sNWHZ2HWNggF49PESkov3SXqGLcM1Vd45Eu5U9GGJY5/H8zj3VZ1RCeW
         3zR82sr605og/6IU+1hIEbAgLRaKbIBajNiewHbK+5a7O2IEc/t4A02A9Xo0bYsbjtuI
         NV0Ee0giIevg9lEyot1LyuSWhVcfjPZ0zCMlVZPccJ9excYmTFWtdtjfKwKJrWOExHC1
         KyJGIkGoIBZn8V8c00f6oMTc31rnpaFQk1wud9kXiYpniQtI+O6RCzQs31BcA9dn+6ry
         /dLu2nZYIRkB3aKGJd9yScVoOdLumqbYb/ylyMqRKvrPIufVHURWVi1umTxSkThWMElU
         HefA==
X-Forwarded-Encrypted: i=1; AKwUvBxW6mYiKPYj8e7DTl0JAhOffncK/SC8VnLAmrcmyv3uTpf9UI87lu/je4YFhevLtspnFoa9TBYjptpm@lists.infradead.org
X-Gm-Message-State: AFuF++m0PzpxCWEWOWGahLChirCh3Ni0bXo1SGPYnTSRVmAOCFmsyKyv
	45/Ar8e9rUBo92wEJPTdfgvKJLywAQIpMUAqVupVs6EEsFvDsE/3GPQ2ZU6740OO6MA=
X-Gm-Gg: AYBFou2DmMeVBPVBefJkzdeDzPKbOKLybWcCtvrmcZX3B+mHRC/6BJvwD5zOtOPwlz+
	CRkhxSZwq1epfBc+iMB9875gzBi8oDnnNsSwiifnyP7zs9RyBBBUqrkOhAQrp1cG3FwcKjOPKmc
	ev38IhnAissqujq3OTmKBD5lUsgCN4yqS4qukDzUIKnOzleSJg5y6hHG/3NKSIbraDjSY6XZy1Y
	B5Dbg2MsppZ3km9YDKMNyNmaAOs7ZoYV9JI1JMZ6xlU4IA1C+cgD5hwGks3WGe+H6kPSEmNW8VK
	awprh5EGxAfB/EykJ87LkE+nqucdaLzXgG/aIsFcvk5PZgYgVeNdJ0ubRo8AIR9NG1eFyblRSiG
	uIREIatFUjtIBNt7fNi0wpa04UNTUBmZYXxHaylNJgcMZD+F1FnGXCfqlb9d/IKtAL+m72saxOd
	cmkIvFTtzCqi4LltA7bwk1kvkMYYeQbOqeoSRe5sc4vsHRrh54UU2GBcce
X-Received: by 2002:a17:90a:d00e:b0:39d:fd82:de0c with SMTP id 98e67ed59e1d1-39e54aeed0emr12729347a91.2.1789929043967;
        Sun, 20 Sep 2026 11:30:43 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:43 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/18] nvme: let controller deletion wait out a fencing window
Date: Sun, 20 Sep 2026 11:28:16 -0700
Message-ID: <20260920182936.2317916-19-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_193046_429879_E1E684A0 
X-CRM114-Status: GOOD (  18.82  )
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

DELETING is not reachable from FENCING or FENCED, so during a fencing
window nvme_delete_ctrl() fails with -EBUSY. Its callers assume
deleting a live controller cannot fail: a sysfs disconnect is silently
dropped after the delete_controller node is already gone, rdma device
removal returns with the controller still holding resources on the
outgoing device, and module unload leaks live controllers.

Fencing is time-bounded and always ends in a state that allows
deletion. Add nvme_delete_ctrl_wait(), which waits on ctrl->state_wq
for the fencing window to end and retries, and use it in the tcp/rdma
module exit paths and rdma device removal. Make nvme_delete_ctrl_sync()
wait the same way so a sysfs disconnect during fencing is delayed
instead of dropped.

nvme-fc's remoteport unregister with dev_loss_tmo == 0 keeps the
non-waiting call since it runs under rport->lock; it does not need to
wait, as dev_loss_end has already expired and the reconnect path
deletes the controller once fencing completes.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  4 ++--
 drivers/nvme/host/tcp.c  |  2 +-
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc44e3af5f14..ca7f083702f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -271,6 +271,38 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
+static bool nvme_ctrl_fencing(struct nvme_ctrl *ctrl)
+{
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+
+	return state == NVME_CTRL_FENCING || state == NVME_CTRL_FENCED;
+}
+
+static void nvme_wait_fencing_done(struct nvme_ctrl *ctrl)
+{
+	wait_event(ctrl->state_wq, !nvme_ctrl_fencing(ctrl));
+}
+
+/*
+ * Like nvme_delete_ctrl(), but waits for a fencing window to end
+ * instead of failing with -EBUSY. May sleep; callers that cannot
+ * sleep must use nvme_delete_ctrl() and handle the failure.
+ */
+int nvme_delete_ctrl_wait(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
+	might_sleep();
+
+	for (;;) {
+		ret = nvme_delete_ctrl(ctrl);
+		if (!ret || !nvme_ctrl_fencing(ctrl))
+			return ret;
+		nvme_wait_fencing_done(ctrl);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_delete_ctrl_wait);
+
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -278,8 +310,13 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
-	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		nvme_do_delete_ctrl(ctrl);
+	while (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING)) {
+		if (!nvme_ctrl_fencing(ctrl))
+			goto out_put;
+		nvme_wait_fencing_done(ctrl);
+	}
+	nvme_do_delete_ctrl(ctrl);
+out_put:
 	nvme_put_ctrl(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bcecaaf06f7e..bf8c2bf91ad3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1026,6 +1026,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
+int nvme_delete_ctrl_wait(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8ff5aa312377..ce37e3eafeae 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2483,7 +2483,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
 		if (ctrl->device->dev != ib_device)
 			continue;
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_delete_ctrl_wait(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
@@ -2523,7 +2523,7 @@ static void __exit nvme_rdma_cleanup_module(void)
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list)
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_delete_ctrl_wait(&ctrl->ctrl);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 	flush_workqueue(nvme_delete_wq);
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7b1d9e2cb00d..9331a3e0bd9a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3208,7 +3208,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_delete_ctrl_wait(&ctrl->ctrl);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 	flush_workqueue(nvme_delete_wq);
 
-- 
2.55.0


