Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC3BD10375
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+tOUSVfYAveGgYFyI0DvGkCr7R3J34UcR6zCL8mu2o=; b=WLUNAi6u8SiirB2TAW9ML+Hx0C
	jPQwHfvZKqlTEukWPH2J0S4pIhzFFXKwrMseOUba8M1Ga4nGCJA1Xt6IkuennVGjWyY6DRMxgLrbg
	5Nl8d/pgm0vEgsOlGkPQ4IfzAOvhIrNrZx7hCOB/eSyHbSfC1P4J8ksFXH27kHOxwnl+s6wEmkkmt
	Gd+ZA2UOCRy2e5QzkyPni4e6nphDqBq6+3iu8aFebPokspjB64b5LleHD+2zIRltSFhh6bKx5h2PW
	nkVa1g1rycAE5twhYP4BD7cOQkcXxVvF87RXomXcCb0yA/+06QHQ4A0cHDlwF+NdsV6inpbdnHC0w
	9ksT1iGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52K-0000000EDdR-0gAr;
	Wed, 26 Nov 2025 02:13:40 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52E-0000000EDTd-1xPO
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:35 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so5389844b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123213; x=1764728013; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+tOUSVfYAveGgYFyI0DvGkCr7R3J34UcR6zCL8mu2o=;
        b=QjycVS7Egwozu6jBlSsBOBrvwWylgwX8hZzN/cUXKh1dLvgWk70Co0VAOs6VOnwwEB
         wdNv7zlWBstkj6eWcrg9252vaw4xSQzU1NLSTzfWMcukGWZ9tl8NDTxPB1IW3CxRMZH1
         8xlQJfC7p8n8pQo0C9ZO8zlD5EadUcvYneCea05p90wIT9bhe+P+D57RkQV9m7/xraxj
         8BMwRauN5A+Hlz5Tw8uWR++wUrTRJN6dteotlor8hJgS03DFLBrH0M/Y+ut4+39iWS4g
         C57iV/3yaLDAmxZ7n1kJOD+6oeR25hWGSQmjjsbxB906EBUKWiqgJykx36vUOBWDK5VY
         MeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123213; x=1764728013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+tOUSVfYAveGgYFyI0DvGkCr7R3J34UcR6zCL8mu2o=;
        b=W0a16E1R8eam9xA/K4U66QyD7K84yJ/2EnOt9LUKfLH+Sgyg2RoWe8j7i4awDZPDXu
         grrxQWvPIqFFU5ZyGQpbjQ8twCI0n3JouL6ru1l1017YF7NEBQ0EkaA7tAfCmt2YzcCB
         53SRW/NA0tpGo5ntU4KeUwH4U8vFtmaXBVKJMOPVhDIdJ1buFtH0J3t3t6facwNZhJlq
         7lwjSORqLgxxNj/1o2nE1DUFRp/1xv3mE+u9a8iuN4jEoaZA2u6HstXTeDPqgBLCJ04o
         nrLJfsErE+2c2NemmIdQ78MLstnPosrQSr4pGDlQnVHsrVtkD62rjUtRSpOmi1BQYY+l
         i+cg==
X-Forwarded-Encrypted: i=1; AJvYcCVR8fWSsrCd3X0vEHWDsgG6Z9pYz8fR6e7+nw3o3+I/XupWkdIv48bT2vtFmT5RXbIQij2Q2KbCuebF@lists.infradead.org
X-Gm-Message-State: AOJu0YxeuQE9FT/1SO0mERf9v5CZz80CDeSZdcLW7Py1eyvfi/4lUl0n
	k7ZnBs17/nS8MYhiBpORnng/k04JcmkhnjONA1bDXX8k1I84kQIlI73z16ysgNxOilE=
X-Gm-Gg: ASbGncsyJf2be2KLJdU1pDbzQjfwmPnX6mzyArR25lAHx/97aP/i7YGrHWd+bXXjXFi
	0ivOGsMGDDCyah6+ULMwPAIyDj8qhy1qHoOjPET8HCP05RQiO26INOoXMARsfQa+QS7zEkXW138
	ruJhbvoPR//L/aD9gBpCKJBi0M8AhK69mOsMqc8Wtp68FltbBzif0aIZMzpseMPDAG6VcRy3vu/
	7xNpQ0t0GAPoUR9dMdcz530s88ajrsqYPfjJzO3n9QPZ3DB7N1JHk95Ff0dNRXAbJujATKx6yS4
	krBlrOVRTYfjNjtdpiQCAannn/bY4JDeKxoL+fH6BiOFli0m1f8g9+RRfKs4+5CyBEjRZenFomn
	GBbynieHdlirbLrvbysRsFKvouIX+Oqeho46S5D4B0r47D0Kjm0JK+SKT8kZjpd4uiwMV6Ugjyt
	/H0W+oj2NepybWeeRQWU/RE8UStz1VI6TlL7N0pboGq2Mo
X-Google-Smtp-Source: AGHT+IEX52DbN1W3fLNeFgULMbeGoHOJm/Hbe+XFe8rU25L89rCrrZxsAphbup4ofHcY7P6zLwy4Ww==
X-Received: by 2002:a05:7022:ff48:b0:119:e56b:989b with SMTP id a92af1059eb24-11cb3ecc810mr3258084c88.2.1764123213235;
        Tue, 25 Nov 2025 18:13:33 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:32 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 13/14] nvme-fc: Use CCR to recover controller that hits an error
Date: Tue, 25 Nov 2025 18:12:00 -0800
Message-ID: <20251126021250.2583630-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181334_521132_34125D4C 
X-CRM114-Status: GOOD (  18.06  )
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

An alive nvme controller that hits an error will now move to RECOVERING
state instead of RESETTING state. In RECOVERING state, ctrl->err_work
will attempt to use cross-controller recovery to terminate inflight IOs
on the controller. If CCR succeeds, then switch to RESETTING state and
continue error recovery as usuall by tearing down the controller, and
attempting reconnect to target. If CCR fails, the behavior of recovery
depends on whether CQT is supported or not. If CQT is supported, switch
to time-based recovery by holding inflight IOs until it is safe for them
to be retried. If CQT is not supported proceed to retry requests
immediately, as the code currently does.

Currently, inflight IOs can get completed during time-based recovery.
This will be addressed in the next patch.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 52 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8b6a7c80015c..0e4d271bb4b6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,7 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
-	struct work_struct	ioerr_work;
+	struct delayed_work	ioerr_work;
 	struct delayed_work	connect_work;
 
 	struct kref		ref;
@@ -1862,11 +1862,48 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static int nvme_fc_recover_ctrl(struct nvme_ctrl *ctrl)
+{
+	unsigned long rem;
+
+	if (test_and_clear_bit(NVME_CTRL_RECOVERED, &ctrl->flags)) {
+		dev_info(ctrl->device, "completed time-based recovery\n");
+		goto done;
+	}
+
+	rem = nvme_recover_ctrl(ctrl);
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
+		dev_info(ctrl->device,
+			  "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
+	}
+
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+
+	set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
+	queue_delayed_work(nvme_reset_wq, &to_fc_ctrl(ctrl)->ioerr_work, rem);
+	return -EAGAIN;
+
+done:
+	nvme_end_ctrl_recovery(ctrl);
+	return 0;
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
-	struct nvme_fc_ctrl *ctrl =
-			container_of(work, struct nvme_fc_ctrl, ioerr_work);
+	struct nvme_fc_ctrl *ctrl = container_of(to_delayed_work(work),
+				struct nvme_fc_ctrl, ioerr_work);
+
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_RECOVERING) {
+		if (nvme_fc_recover_ctrl(&ctrl->ctrl))
+			return;
+	}
 
 	nvme_fc_error_recovery(ctrl);
 }
@@ -1892,7 +1929,8 @@ EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 					 char *errmsg)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECOVERING) &&
+	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
 	dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
@@ -3227,7 +3265,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->ioerr_work);
+	cancel_delayed_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3465,7 +3503,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
-	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
+	INIT_DELAYED_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
@@ -3563,7 +3601,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-	cancel_work_sync(&ctrl->ioerr_work);
+	cancel_delayed_work_sync(&ctrl->ioerr_work);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-- 
2.51.2


