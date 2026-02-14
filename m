Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE34EDF15A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XwNieIMOOEiX5lV5XWEf+KtzHT/dG6SPDzSjOWp5JHE=; b=jeDhHlY/q/saajIAVpUDUgxAtX
	91FtBp5aheUVswzybRZU3gVIXzMd5/bLOAR7Jv5+0k82ep0rHR42To3ZAcQe0O0gR+69HzjCI2n4W
	vxYyuHlfjdMCJ4MrD8pa+0v0YFNZYCIkbYPRdTxzOVjaI341WY1Zo7P3SGJVk2zY3ThPAWdJK3QJG
	/xmGWMYRBgoCjXgVhlqCEgLE5AbruLTcHZ50RBJIiMSMoUzqDzT+o3Wvy8Fab1yfmVodLgLeYpw5Q
	Iz8cNxv0kmHjKWp9mWcTQUb0lraKXrVCf7IqrzkVh0CXjPFk9jqFUBxzDqqG5vRZpKKz7wydzre7f
	Y+WZ3OaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gn-00000004FE1-0UBQ;
	Sat, 14 Feb 2026 04:28:37 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gi-00000004F4w-2VX8
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:33 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-124a95e592fso2862937c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043312; x=1771648112; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwNieIMOOEiX5lV5XWEf+KtzHT/dG6SPDzSjOWp5JHE=;
        b=VWmqFxIaBEu9q1r2A+FHmv/v/6Y6q75GHMR68mujZT8pd2L/JgzTm8uEtZH08NdV+K
         8tRt6TLBIihGJwR+/s1BqQVp1VmV0ezfAcVmoVTRbiPNnPTpJyKv25bI+Xq24KAz+uZG
         ebPkZiE4xxz3xQJfBbGxCwU45Y6VdpxnrU0WaKlsVO22i5VNUbe3giQ/3OEo22rYjBQN
         vmMFSbxoybGv+ULo2WtdV8E59FVa1yXpbnEzEK9s1RCvlxUlii0xFmMKhpTAVAslcQrF
         qyP5Xpv9N7XRIrLjSdvGEIgJZpGV70kjdUGC9ivWNzFnfp3ZuvxdMtlc0T7kQfhRQ2e2
         NQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043312; x=1771648112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwNieIMOOEiX5lV5XWEf+KtzHT/dG6SPDzSjOWp5JHE=;
        b=pXIG8fjO+Lwp9TnvbrUpTussvKrEIrkfYqsNmUtAs07WIVsmCi8oLacNrsFjfrbObu
         tOxxic/T4PJzkY4z5QxvihLUhxL7dceoln1S6vuj2rPknWKcOpxRIgGb+c9i78wk68NN
         JWmNu4C2mActvd3bBV701UNzd8ijYdu+StccYDBWEMrDYrF84V4GbRC6bn/7PrL5bjM1
         uTE6y9hMXo1aBbpeqjHAYe7HJMi+7q6j36txA686iiAV9WitPRMrqZUxMzq8Hi5MIOTA
         bVj3MjGVhZ62SseY8OCjG8Bc3U1xzrn4sBame4Ylyp8INvvBQ5MtSmrRqxKdRWQ8KclR
         wSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPxwntjnUZF3GVztpBSnEDPlrCLYzmd2aozwjOSJ/+iXPokCZzB//fFls7q7pty+FksWyzlw0sQxD+@lists.infradead.org
X-Gm-Message-State: AOJu0Yws++Vy5mFm9bZOX0x/ZCLH5ruAwVB81htbOZEKERNILtQeZGnO
	m2m5JWi7putygDWq4gDp/VaXhVY0u2YDrGdLqGlsVxLnSe0hcOLuyXx440OXqC7ZBpY=
X-Gm-Gg: AZuq6aIX4y4Gu2IOxDfudp30fPudpat9CroywvEs2Ux2ZwM3clEF+t1PRRi5vlE1GFL
	OLiPu8MONGJB8a9XkSK6KOzYhNO8+xFPE8hMGGCOjcVVCxPv6aMHiFhfhJ6eNAjaEgi4bMQaNmQ
	cVgwowg4i6/oPfdv7PNUBMskkj6qpxhmuCMqSnVMwS431jG7JJ8RSOz9k4R4fwwkH3rWNOOLvU6
	56y4yg544NH4fnEKyKqSInEXMG/7jnFqljWbrMma54m8xCZRcKmokcIFqe90O/dsCdgzVP8w0qo
	IgK9NvUob/KSrM1wf4OC2MTTOUDgWMRC1TZ8e9K1UbXTOzS2ge4EtCsOHM04NMjGIpZamYIiXyn
	0fs1ekgmPjSd5xsKXr4FHofiGZUW7AixWskQlE3zK+0IJ6D3v+T+yauTcXnQJaXgrDUifmeXbEh
	uK4zel+py8xuyfB8vMs7yO7UqAMawJ53cy8JAvJiaQb9I5iQ==
X-Received: by 2002:a05:7022:6706:b0:119:e569:fb9a with SMTP id a92af1059eb24-1273adba5d6mr1562540c88.9.1771043311738;
        Fri, 13 Feb 2026 20:28:31 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:31 -0800 (PST)
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
Subject: [PATCH v3 13/21] nvme-fc: Use CCR to recover controller that hits an error
Date: Fri, 13 Feb 2026 20:25:14 -0800
Message-ID: <20260214042753.4073668-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202832_649248_B2F0F802 
X-CRM114-Status: GOOD (  12.17  )
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
 drivers/nvme/host/fc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e6ffaa19aba4..6ebabfb7e76d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1868,6 +1869,24 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem) {
+		dev_info(ctrl->device,
+			 "CCR failed, skipping time-based recovery\n");
+	}
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1889,6 +1908,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 		return;
 	}
 
+	flush_work(&ctrl->fencing_work);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -1915,6 +1935,14 @@ static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 {
 	enum nvme_ctrl_state state;
 
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
@@ -3322,6 +3350,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3497,6 +3526,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.52.0


