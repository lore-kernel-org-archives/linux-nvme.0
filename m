Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3373710F3DC2
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BG9grs2JIZbnZf38OXY3X2RYCpdQyaZgWV264Kd3xHo=; b=BMdzVuxcGj64mgs41C8/a1wvkF
	XS3PtBTYIxRqRDiCy/xcsGgzmiTmBXUcZBrRoz8OZzqYucRuLsghbPKZ1+WccYlPZjZcattOEAVud
	pb5w/IeV4MIpIh7LCHG8JYkYeBedo+2b6yF2N/wOMLbpewI8ycKbM5kDixnNbrTCbKvbgdyCJAhoK
	4erSxvStjiu/thUuE1GdCP+EAfBHw/J7xllPZ4mTN3lCf8EBa4z6AmgVrEHxTm2fDt6TdcC1J8GYe
	eJBQu+T/Y7IL4kBDzBFBFRH2IBO3CYvccpfqCa/nJYH2924FRpVUP4J7uhWKzXnmgl0tL3A7HnRwf
	yFa+gXqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hod-00000008O9r-2KLo;
	Sat, 28 Mar 2026 00:46:15 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoZ-00000008O4O-0nn2
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:13 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ad9f316d68so13294495ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658770; x=1775263570; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG9grs2JIZbnZf38OXY3X2RYCpdQyaZgWV264Kd3xHo=;
        b=ISAEACCD+w84u8Thifv7Zle4pCEIQni1AKHGuJo9xMzKOaqwXFP5ixfyLOUH1/7aRk
         5VMP+4n7TmliWoaeoCnNCcOi6Q0QugGABELbDPrKgDkmwESQCCVBtfMcMVMigFK7ey6l
         hns5omX2Nervmy/vY5BynaN6HbXdwHQN4Bnl8JfU+2yaVbgzf18DNe7JHlWoYasiE3cx
         P0eVsVje1Gd+Y/cSCk1gTqEI4ITrPJJr0stHwwLYH7y90y6nGVpHB8ymM0lOUUDnDs0K
         L9whAFqa6dFVWNGJ+/oH+IqhJnf5KxAd7VJYrTAz5Iy/C23N3Ke41/KoPdeSrDtZgCtK
         rN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658770; x=1775263570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BG9grs2JIZbnZf38OXY3X2RYCpdQyaZgWV264Kd3xHo=;
        b=oknWdifpjs7JNoGznltpFDvRc8kZZ7c2FTK40XHqpMHgUQUmYrRels7ZKO5+SdjwVB
         OFcTrUeU6Jh6hCmyCm6yG4HrIJRmPPFgFF89aJtuH6Y3L6syJ3g9+vkpX89BmwkIL8dv
         THrKFGCXUmc8MD2U1O9iUvkq5b8SKtHOT5ozIlRdZHBWHQZrM5eCRaxx4oAo7DU+bvNZ
         0BxFy9MMieEXhxLsZQSFb2diHIoPmUD60Ihq8QY2lMwqP5C+jrz7WM78sS+IfNwWIApq
         jRNhXrxHWs35nHwIdlzPeXpdlJ4fmzRIomf/UhFdxpyf8o9BOociFXrpa2xyoHO9FuBm
         nKpA==
X-Forwarded-Encrypted: i=1; AJvYcCVjX4GjMkGqYDrOdaea8+GIb4w9ZeMcQhpQAfJ/HBqroQlwSaTE7UPSevwVS0/2N+nYjbxBvdflCvY1@lists.infradead.org
X-Gm-Message-State: AOJu0Yzl3WKXhFqRzLDScksIoQu+YETc9JroCa9WaEkcVe0TrElz77SV
	xaiPj1rdQB3i+E8eIUsnZp7t4l2qEcfFnPAj2AlFshYMtrbAG8Sj9L4v6aS2/1iga88=
X-Gm-Gg: ATEYQzw8I8RTWFyBob9RDq5PgKuuiIyyVwp8CqungWh8HCGFhLOeGY1jMWA9UH69tnc
	Kq5zpVPDSF8El9499Zk2v9YKN6R4Tu5a7qKdjc16A6Y3fm2KSj6cPkzcpkL9UPWvaEd82SoJj/4
	4Grd4wRENccJEbCwGO9yAYkRMIe1oyDHsPeHlgSnDnHGgNVtAyfy4+DlObRnGA0OJvKfq+21hG0
	GFa4zhrJ5CEtfN+XAyBPfPZ4UG7kazi0Qv5bl/1eDUw5bzlRwjwHx7fj3ARUVE0qxeR9GB8eLYq
	r4/4hUt9cwbIPS8udrmllRuaZHlvKMg1I9PctMPX95C2AokYG09dfAsPxwk0kf0gdgD7+d9dL4l
	ItP2CFYb+npxmAvLXlXsw/ojqKmjtWGaV9v4yioYd1J03OddJAIZDYHr2FjTQPbgdAcOC8tolHP
	NP//2GQdI=
X-Received: by 2002:a17:902:fccd:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2b0cdd03fdcmr31623685ad.36.1774658770331;
        Fri, 27 Mar 2026 17:46:10 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:09 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
Subject: [PATCH v4 13/15] nvme-fc: Use CCR to recover controller that hits an error
Date: Fri, 27 Mar 2026 17:43:44 -0700
Message-ID: <20260328004518.1729186-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174612_547699_7F65395A 
X-CRM114-Status: GOOD (  12.22  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6797eb17917f..9f6b95415f25 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1868,6 +1869,22 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	int ret;
+
+	ret = nvme_fence_ctrl(ctrl);
+	if (ret)
+		dev_info(ctrl->device, "CCR failed with error %d\n", ret);
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1889,6 +1906,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 		return;
 	}
 
+	flush_work(&ctrl->fencing_work);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -1921,6 +1939,14 @@ static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 		return;
 	}
 
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: starting controller fencing %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
 		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
 			 ctrl->cnum, errmsg);
@@ -3321,6 +3347,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3496,6 +3523,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.52.0


