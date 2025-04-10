Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A669C369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MN3eMpxX2z31ojkqq3RTjYfJ1j7pkMzShA6yI2cX8IY=; b=RnSuv2mcYAvGZcGrj9V5qGH8qs
	RBniR2kGXtib8XXOW7ZQ0K//BGmJfa+1C2wKgaBOob3gsejdOxdcjmS+vruIWlM+7g6FEqif2f/DY
	3BwTV0ryWIEk9NJ41Bi3NIR2ESgeQcmSs4dgRb8RgqPMIUNZmRwOVlPWHOCCGArZSLzQ4PTDDRo3r
	PYTnJEgceglixkkWLSgOoYzGyb0TNKSTgAxy4u5z8f+fAUoF2U+8eJuPdNDqNKng+fr5VpfsmbKBc
	fA2JucUV/QnjWbCH/S9EAi2tpW0WzzMzFaLnIHzuiVYuFlG1pCQyi3M1Lo5DympahNRoxgw6BBKDN
	WL++mdBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quH-0000000ATMC-2F6R;
	Thu, 10 Apr 2025 12:21:21 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quF-0000000ATL0-2Zrs
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 12:21:21 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-736b0c68092so533253b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744287678; x=1744892478; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN3eMpxX2z31ojkqq3RTjYfJ1j7pkMzShA6yI2cX8IY=;
        b=hZ9Ip0bzbRkMMUzKjXDnw9/9D8oh+sIOvCIMvhkHnfm1mqooyN+R4UDK6rEqjJ3itR
         644siRJoctM7ez+roIxb+5UyzibGq06G7TIZGm5mp0oJL2YBX0nqLRyMDmzJjM44wRX6
         S1sgqZp/jZtOlo4SpWchael2o/x9IiGsG/FrCWPi4ARPZeUY11u/3mcvRiac0DPLsP3E
         2XRMA4rsoT7J65bEvQTQkAazemIptnIFFKgobRBDSJdvSxeoY1D/5Y81ClwiK177TW2j
         POLXa2AKNnE0KlUinAgeNawkIOdmP2HPIrpYEFnfjTyspChmXAFQAARiFwnMd3HvL7M8
         QXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287678; x=1744892478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN3eMpxX2z31ojkqq3RTjYfJ1j7pkMzShA6yI2cX8IY=;
        b=ePMSEKBjM7fwzC20785dDkcmNB2x15EQpLtyADpQ04lF5tMQ3Ir8f2tVB1tMYe4a3i
         vOGO0s73iZC+smhjjwVbALs6M+upiypFlPcqh16j/U3IfGkv/YR81bunESf//jCmE0Mb
         ZUeH3CAondSp/0kW4CFRoEbek/pQL83mf4ZTeArNogO0rYrZbcJ2A9vDn/AXEc3J+mga
         33AqsRzsVIThPl0NPOsXThyy4QJQ6/0RmRo3hBr/P7/jyP2EZsQC8U3vjuYYDdOr1y8e
         xaNYkB/nq536rI0bN5qcOD7Uiedk0sWs/lS5M0tEJwjigFbjOqHym2jLwRfXuOMes8MG
         f57A==
X-Forwarded-Encrypted: i=1; AJvYcCURMJMqsfhSYKfW1GV70dGfDUxNsLX8yZI3AydC36IBpYasw3irRWBR+MamZ8gLfRBWT91Ljdlg7Fy5@lists.infradead.org
X-Gm-Message-State: AOJu0YwzePJPbgPvKzJWw9hoplzknjiP4VaGvSR7TxDrFIpiedL1P5x4
	UtBi5e1Z2Q/WzFPB/CKOFjpayp+jpuqEG19o0jNntornZPmcM0x6ytB4XLFp714=
X-Gm-Gg: ASbGncueJ3zv+D66rdAiwzK3rSisdl4sBAf5rQ+KCeZt9XlB3GmaFwfmMk55FK6AnuH
	GOV7e0csb/Uq4Xwrx3Jd/Wq6Z0aH9zhE2xlN1/NAHyZoATmaBGerT2Kav67bkrAj6i1HC9JiQiB
	QcwzULBsAli866znS1x6V7yaJL/F8jPtn7b5oOxvW0DXr4gV6wHx6vLu3HGh7F13ClfiVjl44b9
	FidRbmOHVTusXThne1eXNSZf5ikOujZ69PpJyPL7RMg04tloxRvdPr6GKOru58ff/3ESNC37wMO
	V76w0i4H1eF1cfH06hTr2RXvkZjIrjYq
X-Google-Smtp-Source: AGHT+IG3L5CpkWQMvY17X0Z/aZewAD0pJht6tPtd9ADxFdU64zt/Q/xeEVYxh2pJajNFg6+7Z+bSuA==
X-Received: by 2002:a05:6a00:1494:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-73bbee32941mr4275827b3a.3.1744287678306;
        Thu, 10 Apr 2025 05:21:18 -0700 (PDT)
Received: from localhost.localdomain.com ([2001:df0:a640:1::4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38258sm3186109b3a.107.2025.04.10.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:21:17 -0700 (PDT)
From: Jiewei Ke <jiewei@smartx.com>
To: hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	kaiqi.chen@smartx.com
Subject: [PATCH 2/3] nvme: add support to delay retrying aborted requests
Date: Thu, 10 Apr 2025 08:20:53 -0400
Message-ID: <20250410122054.2526358-3-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410122054.2526358-1-jiewei@smartx.com>
References: <20250410122054.2526358-1-jiewei@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_052119_656432_9B319126 
X-CRM114-Status: GOOD (  24.54  )
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

According to section 9.6 "Communication Loss Handling" of the NVMe Base
Specification 2.1, to avoid potential data corruption risks, the NVMe
Host must close the connection and wait for a sufficient period before
retrying an aborted request. This allows the Target to detect the
connection loss and clean up any residual I/O.

Adds support for delaying the retry of aborted requests in nvme_tcp and
nvme_rdma. The delay duration can be configured via the new
"delay_io_retry_time" session parameter and may be passed during
'nvme connect'. The default value of 0 means no delay (similar to
current behavior).

When delay_io_retry_time is set to a nonzero value, aborted requests
will be added to the controller's retry_list. After closing the
connection, nvme_delay_kick_retry_lists will be called to synchronously
wait for the configured delay_io_retry_time before triggering a retry.

Signed-off-by: Jiewei Ke <jiewei@smartx.com>
---
 drivers/nvme/host/core.c      |  3 ++
 drivers/nvme/host/fabrics.c   | 23 ++++++++++++++-
 drivers/nvme/host/fabrics.h   |  3 ++
 drivers/nvme/host/multipath.c | 54 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  7 +++++
 drivers/nvme/host/rdma.c      |  3 ++
 drivers/nvme/host/tcp.c       |  3 ++
 7 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ffc8f23a174..5a3cb019d6b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4852,6 +4852,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 
+	bio_list_init(&ctrl->retry_list);
+	spin_lock_init(&ctrl->retry_lock);
+
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 93e9041b9657..edb8d54b00c7 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TLS,			"tls"			},
 	{ NVMF_OPT_CONCAT,		"concat"		},
 #endif
+	{ NVMF_OPT_DELAY_IO_RETRY_TIME, "delay_io_retry_time=%d" },
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -738,6 +739,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
 	opts->concat = false;
+	opts->delay_io_retry_time = 0;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1064,6 +1066,25 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->concat = true;
 			break;
+		case NVMF_OPT_DELAY_IO_RETRY_TIME:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0) {
+				pr_err("Invalid delay_io_retry_time %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!opts->transport ||
+			    (strcmp(opts->transport, "tcp") != 0 &&
+			     strcmp(opts->transport, "rdma") != 0)) {
+				pr_err("delay_io_retry_time is only supported for tcp and rdma\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->delay_io_retry_time = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1302,7 +1323,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_DELAY_IO_RETRY_TIME)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 9cf5b020adba..51c42d2d19af 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_DELAY_IO_RETRY_TIME = 1 << 29,
 };
 
 /**
@@ -110,6 +111,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @delay_io_retry_time: Time to wait (in seconds) before retrying an aborted I/O request
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -140,6 +142,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	int			delay_io_retry_time;
 };
 
 /*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27..0e5a39003423 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -4,10 +4,12 @@
  */
 
 #include <linux/backing-dev.h>
+#include <linux/delay.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <trace/events/block.h>
 #include "nvme.h"
+#include "fabrics.h"
 
 bool multipath = true;
 module_param(multipath, bool, 0444);
@@ -89,6 +91,9 @@ void nvme_failover_req(struct request *req)
 	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 	struct bio *bio;
+	struct bio_list *target_list;
+	spinlock_t *target_lock;
+	bool delay_retry;
 
 	nvme_mpath_clear_current_path(ns);
 
@@ -102,7 +107,19 @@ void nvme_failover_req(struct request *req)
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	delay_retry =
+		(nvme_req(req)->status == NVME_SC_HOST_ABORTED_CMD) &&
+		(ns->ctrl->opts->delay_io_retry_time > 0);
+
+	if (delay_retry) {
+		target_list = &ns->ctrl->retry_list;
+		target_lock = &ns->ctrl->retry_lock;
+	} else {
+		target_list = &ns->head->requeue_list;
+		target_lock = &ns->head->requeue_lock;
+	}
+
+	spin_lock_irqsave(target_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next) {
 		bio_set_dev(bio, ns->head->disk->part0);
 		if (bio->bi_opf & REQ_POLLED) {
@@ -118,12 +135,14 @@ void nvme_failover_req(struct request *req)
 		 */
 		bio->bi_opf &= ~REQ_NOWAIT;
 	}
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_steal_bios(target_list, req);
+	spin_unlock_irqrestore(target_lock, flags);
 
 	nvme_req(req)->status = 0;
 	nvme_end_req(req);
-	kblockd_schedule_work(&ns->head->requeue_work);
+
+	if (!delay_retry)
+		kblockd_schedule_work(&ns->head->requeue_work);
 }
 
 void nvme_mpath_start_request(struct request *rq)
@@ -176,6 +195,33 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
+void nvme_delay_kick_retry_lists(struct nvme_ctrl *ctrl)
+{
+	struct bio *bio, *next;
+	unsigned int size;
+
+	spin_lock_irq(&ctrl->retry_lock);
+	size = bio_list_size(&ctrl->retry_list);
+	next = bio_list_get(&ctrl->retry_list);
+	spin_unlock_irq(&ctrl->retry_lock);
+
+	if (size == 0) {
+		dev_dbg(ctrl->device, "No I/Os need to retry\n");
+		return;
+	}
+
+	msleep(ctrl->opts->delay_io_retry_time * 1000);
+	dev_dbg(ctrl->device, "Retrying I/Os num %d\n", size);
+
+	while ((bio = next) != NULL) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+
+		submit_bio_noacct(bio);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_delay_kick_retry_lists);
+
 static const char *nvme_ana_state_names[] = {
 	[0]				= "invalid state",
 	[NVME_ANA_OPTIMIZED]		= "optimized",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..afb63e7d4c41 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,9 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+
+	struct bio_list retry_list;
+	spinlock_t retry_lock;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -956,6 +959,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
+void nvme_delay_kick_retry_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
 void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
@@ -1004,6 +1008,9 @@ static inline void nvme_failover_req(struct request *req)
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }
+static inline void nvme_delay_kick_retry_lists(struct nvme_ctrl *ctrl)
+{
+}
 static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 		struct nvme_ns_head *head)
 {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4297507725cf..1bcd7946dedc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1114,6 +1114,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, new);
+	nvme_delay_kick_retry_lists(&ctrl->ctrl);
 	return ret;
 }
 
@@ -1154,6 +1155,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_teardown_admin_queue(ctrl, false);
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 	nvme_auth_stop(&ctrl->ctrl);
+	nvme_delay_kick_retry_lists(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2178,6 +2180,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
+	nvme_delay_kick_retry_lists(&ctrl->ctrl);
 }
 
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9109d5476417..f07b3960df7c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2449,6 +2449,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, new);
+	nvme_delay_kick_retry_lists(ctrl);
 	return ret;
 }
 
@@ -2494,6 +2495,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
+	nvme_delay_kick_retry_lists(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2513,6 +2515,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	nvme_delay_kick_retry_lists(ctrl);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
-- 
2.36.0


