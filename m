Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7111C982E0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=; b=S0MCbfqxaInO0rCn9C4O9+Cqkq
	eeNxX82p+sjmySe3XbTxAhsIUeOqBTm6O+glVQYhIjmIaYaMyX0Y/AjNo1f/EnvtoS0uh2fbApMva
	IqGKKuBTxUTDLqOrESoA0U/QeykWbtF14UTfwAT7bQRrEOP1IUJXtCiDdnCz9el2r9BkYroLLDGmN
	91KK575jCmQuXgJ3kDSDg0/SbkwC1UIM7exXsgGmjz8HAVndWysMtfkRzTexlH9iTLDSHsQo9Dn9N
	niXkgL5yorOXyr37hWl18iCn85ClfFKwU4mjnqA0S3ys7U62GChXXjBlyPhzrRDLOqQ03zjdaOjUw
	br+hbSaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9H-0000000FHVB-0r0b;
	Fri, 18 Sep 2026 18:17:23 +0000
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9D-0000000FHMf-2rvV
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:20 +0000
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc50b9e8a45so635969a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755439; x=1790360239; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=;
        b=FsW3LFJXM8Qo9MWz+XutfYkzUUlowow0rfegMuYRKpmzpyaKY0nc9L6/5X/w5wyhLZ
         e6sRa2D62kSEkRbOmy12vTHQjMwXo5zstjnFFXarrZMp/9jNoAYXad7VUWL+yjk7rJUe
         jhR1owD9yyOTIpQtu3F7rtvF1Zz7PYg16DoN5LP53B9r225EOxlf1QRJv8gx6RFR7JWG
         waL6L4T7NOuNiAvEMxZyQk/AvawYKg+kFBglHwIYjco/n+vUcefrST6jN/955CcFl61X
         3H7103bQfbfn/d8X0Fna7fX74PsE3qUc4xgNqx1lD9uDgSZhcVUWdhFRTJyKaWfoBo7u
         URPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755439; x=1790360239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dih43qxI5dfgAB3392PAv6zbxSUobiO7FmfsRmituIk=;
        b=v7FuMJSh5aTUfhvNWC82hnxoERsEiMpcGZIYsXh4ffPBANIFtcXVtLmbYQurRQ6255
         bSrrL1ZdWw1ANbLtYRXx4fYDZ9s6+JW4JipQyz5n9If0eQT37H7kLPrgYrAQmzuTfGkS
         7+6MjfV1Wlnrg4Izrtx+gnFeC0Q3iH4OJEF5NHK3FWAhA9QScGCNTxDfQ5M+IEzqmjW3
         zVfIyQbSnwLn5nrInR5mQkSIyXvzP5zr1/VXDwvlUsbn9fMY2xzLvbh+/Cj4xmJgCBUb
         SuZIHtUXEk3ybcBgXJIlaOgu2MblV0nKr/Q4YC4C0FKlfghcvxDfutdA4DlsRCEnN4yE
         UKbw==
X-Forwarded-Encrypted: i=1; AKwUvBwUnoYpZdBuldfAk34gwu6QqW7Ct2AaWlEtvXphE6Kc834U2lAXA98+td2SbaMlBmEvMTe5K7AnVFd8@lists.infradead.org
X-Gm-Message-State: AFuF++n5CT1O+J7qDo8/9NrAC0XjOSqYzArwqh9SrC9nGaFeZDMMRfcu
	1TQO5NtRhs2LCHAht0M5EkU2RR943WCJo6iyXtxRWJ1Mne3SYZl7O+HNdqnbfZM/uB4=
X-Gm-Gg: AYBFou08HzHda8n4IzJxzvHHwSHM5hqB/0TaWnPJTa6sBc1WRZ+66dR9bwhiNSbEIIZ
	hebt3SzYb7cjKZDfvVh1nX60Dcz2r+5lsVhER3UUxz+JojwyfL0mLudZcbCKSiAEIqKhPtIh4aO
	9TSqmn8iDmDIpkKA2yLmSxFLsu15QTCD51iRBGFS2B4q/FVVjkLbn0Kq22l6IZj30FSkK2fl7Yp
	q59NcSnsQFJZwa/pZd7RKf+Y1A1SXjrzf+kW79DFIJD/0Uyh8XuwDBgMukyHGdJSAK4NlieXuva
	c6RzCWLSfl1k9mpEFBcGTQk7JPsqTxgUYwRSUCCOBMDqaoqiN6Q2G+cApTKkmPwW0cj2K0GgDxC
	T0D5JnKoLp6eOGReU9JgHHugNKnd/Aj2kXy41WIPMpYzHTEHBcw8n5jLiNHv7LYPxHt20i5NsTZ
	xvzCcB2Npud6pld2nkwA9VHqCtsNbN59EwbaDWc06uH2oPUiSkH6Y1oQTYLNcLhKgWwKE68zrAp
	XCqIQEgfdiBPgkTRKyW250=
X-Received: by 2002:a17:90b:4a03:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39e54d38c48mr11469185a91.8.1789755438885;
        Fri, 18 Sep 2026 11:17:18 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:18 -0700 (PDT)
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
Subject: [PATCH 18/18] nvme: let controller deletion wait out a fencing window
Date: Fri, 18 Sep 2026 11:14:18 -0700
Message-ID: <20260918181614.3947933-19-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111719_745746_F5A5BCC5 
X-CRM114-Status: GOOD (  18.68  )
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


