Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A270EDF142
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AyBlaNKrUhJxF0JOHaXwDus/gth9nfmpIZXXREVAOz0=; b=0MGHVIh/vDhvXfdLKsOTN7ngjy
	ylY1b+8fKf55vnBLJPE/eE3BaIYozD92YLnKvB6y6PMPFJC8EZnAnOf+V5pGe5njEMzM2MLbfk6lU
	qW5Nbw2nKMnvPFlR/g7gslIaCy1yFiUbKRrlNnlaKaob/d2lxio0106MGfHi4OmmHNVjwL5Lahebn
	YWlARHvaRB58EbLx21eZOkDWyk1leK0xydMcL391y5NRXxH1tgw/cpp7FN6TqsijqK9q/vZ+fr5mC
	rIy6PfjzWkxa2Y47eHZ3WqbQSGusFE9DGerwa9Ou+zrcGOHOScXAwyxtdwLAB7y8TqfFpQz0SHPgi
	iE6BHbPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7H4-00000004FeW-1lUf;
	Sat, 14 Feb 2026 04:28:54 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Go-00000004FGp-2ATS
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:39 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1271195d2a7so1945632c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043318; x=1771648118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyBlaNKrUhJxF0JOHaXwDus/gth9nfmpIZXXREVAOz0=;
        b=LCMLqtq+NCxc3JZ7/C8i319Bk+3D8IZywymMXjSoi0RwK0tcSMw46xXXFZ6dr0/xKb
         KQrSjTf6Ix7e6DXPm49Kw/brXagTyfh1xC0xdiNZFxfmJqncTUUimNtbA/zML3zZAczt
         xxjlPwwpy0Lq90HSo3H7LwZqGBZe2feJM/rQylJIRNL7rUQOIxwuWK7ZOf8AbHHdHRt7
         X4KVyo4D6o8xLQrsXDsoSDN1b8bk0sioRiSY9a2uj5sGdfkd9X7ZQEqf9pCgzxmG/rJA
         ehNQ8Vbdp0tStctMp+2HEZzGwgxwR7W2PwnK0YgpMazuZy+p/8SdqrEZDL7FcK2Uy5+1
         rvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043318; x=1771648118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyBlaNKrUhJxF0JOHaXwDus/gth9nfmpIZXXREVAOz0=;
        b=OKD6/v++JPvzRH1DWzRk0RYS8sleFQsa2IorUEDXJxBefqH+/c1W7T7kxwbPhogrd5
         rk++YTvMg9iCQPmq68pe+WYXyxlpGbuEEcfoBQ4RWx7PtXPgSehZsT3ovfzhFGVdhM2o
         AhqHrKUQfetaVOQJqKzn/F61U7Z5ZLUONM2/gvtsL8K9gnJhSlCnIRYCxSW/a/h1cXty
         KayDRsFlCWgXCD/ReeXEJxHWDeU8F+JIB8xSQ5uq0UcETnZndALdmjehScPMx5Ks8PaC
         NpnnFp+/pXnt2bJWYTkVyxT+aivD+2j+18SymCKQDykrAUk15KBgali+BRmlNfwvcvzj
         p+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUdkdoioiX7ujLm/ZBgmJV8SWBSJzrv1ZJsLCtvj0RnSaKpcutEsqgW+4AVMZqM9HAjY/LZ/i2O7nwA@lists.infradead.org
X-Gm-Message-State: AOJu0YxbQQt7K/badUWy7lT2YCqE0kkfC+dvvll46eV4dVI1uzTBXrZV
	TsB9ptxu8W6J4IqY+2+waWQtNgFcPE7Z2TgtHVrZvxPnooLHkbt0c37nsHF7Om4ASuY=
X-Gm-Gg: AZuq6aIXbwuPB+qBLS9zOysKHUqdUviEXpYKgSU3EBBHsvc3TIZxpL6PRlh5FwCNb/Y
	oax1lUC/3Vuhulu622fKXW5nHoa8TfdWxsvVCBvxHEG2BSIp+Ps1IHJd6QtjwCENpKW6x56vAVu
	JzWjx61ErMildOE8qGTFla6Vz3/m4jHnlTSWZ3nKeNYoN0sQVfyrMYc6/B28SuXagi/R98aP0sh
	CfuiS273lqH2o5JSObXFtvAr91PzYgat7g1b2t5M+C/G//jjWECtpC1PTt28d1dHBgl8DwN5jq7
	HwpnpTLHRJlRL/uQSoRBx5gEgY5P/dAnpjMsrYxRItG73YAqOHEBOldRjtqXceyQm16S38PQ3tu
	nKKFOW9QAqjRVm4VulNGc0VQAtOugyBVa7TrULq00UjO05uFwqxXmEicBl1vji2YmTW5IWUDOkw
	4pg+vG3x8HXVBNUYby9yuH0d+HIg+kTc789GDLBwZQLeY72w==
X-Received: by 2002:a05:7022:45a8:b0:11d:c91e:3b58 with SMTP id a92af1059eb24-12741bd2c33mr759110c88.39.1771043317436;
        Fri, 13 Feb 2026 20:28:37 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:37 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 20/21] nvme-rdma: Extend FENCING state per TP4129 on CCR failure
Date: Fri, 13 Feb 2026 20:25:21 -0800
Message-ID: <20260214042753.4073668-21-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202838_623969_F6C1022E 
X-CRM114-Status: GOOD (  14.67  )
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

If CCR operations fail and CQT is supported, we must defer the retry of
inflight requests per TP4129. Update ctrl->fencing_work to schedule
ctrl->fenced_work, effectively extending the FENCING state. This delay
ensures that inflight requests are held until it is safe for them to be
retired.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/rdma.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2fb47f41215f..4f48780c3b19 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -107,6 +107,7 @@ struct nvme_rdma_ctrl {
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1121,6 +1122,18 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fenced_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(to_delayed_work(work),
+					   struct nvme_rdma_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_fencing_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
@@ -1129,22 +1142,39 @@ static void nvme_rdma_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem) {
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
 		dev_info(ctrl->device,
-			 "CCR failed, skipping time-based recovery\n");
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
 	}
 
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &rdma_ctrl->fenced_work, rem);
+	return;
+
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
 }
 
+static void nvme_rdma_flush_fencing_works(struct nvme_rdma_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	flush_work(&ctrl->fencing_work);
+	nvme_rdma_flush_fencing_works(ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -2197,7 +2227,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
-	flush_work(&ctrl->fencing_work);
+	nvme_rdma_flush_fencing_works(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2311,6 +2341,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_rdma_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.52.0


