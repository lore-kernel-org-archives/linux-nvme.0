Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADD2CD13DE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z9TxvhrPtlNNXma26gkv6zurVPWw88/pKoxfZSRpH9U=; b=zmWXfo4fWitZUuBvJQDTbF/1NM
	sWrF72DGtUM2Qw57x5SMROK9R2MMb3msq9oUulh2ojW4hzJCr9Y9K4oCCXfyT/o/fMFt1eJIVuY/e
	vDXKls8mtbf4FKxZ82x66Z2FH7d8ladmTsRzMbWc0rGei6zJ+DTKQ8Y2vZk39yd+YZx54kWI+VtQY
	xzDF4nrcSusBViS7i/TWxZrXXZepGeCI6JcrBgkNPv+57o8sKmgpkoc5876aZBzb4YmpBmQRYSwWC
	NdNejv2WJ09z4RFfLPWjbbSWXakIbKVksQ+R9YpRNHNl7QJsxgL1b11HvZrOAUbNDGglE+DYdfIx+
	25mqTURw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapX-000000066ju-18DX;
	Thu, 30 Apr 2026 23:30:03 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapS-000000066fq-0LXk
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:30:01 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so15409465e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591796; x=1778196596; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9TxvhrPtlNNXma26gkv6zurVPWw88/pKoxfZSRpH9U=;
        b=Il0zfNHd6TjHd9a/WzttGE33h8ZNPlCjWhXdayCj+0FxEh8xIc/E7iQoZgzpbcKtOB
         fNs/QZiffcMvtrXRxVSHrFh5irrwqF68Oq39sOEN7qNDjoiUqezUWA1IjibbENjNT9MN
         990C0kKEyApjyysyzF/mfz6jXEnaNnxhEwh3BtEB4mHcSZ9LGAD28l/bLjLEif6BNzhW
         rpamGIOsqAYJJyOeGKpUa1B7PLd+2oQplhpr9KD8mfw39bsmzH8UyniAgJPA02kkIMKo
         vZU9PZRk/kFic+iPCVkLYvuPHqP6+b/U6HpW8CbLCjAORCfSE4xJGd5i3+7GGwqxJ37W
         EAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591796; x=1778196596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9TxvhrPtlNNXma26gkv6zurVPWw88/pKoxfZSRpH9U=;
        b=ioNdiq/v5yZCMVSL+KW9sVIdWJVG9/IqVZEtW461ik9VTzSQhSvhWMU4SWopCEI5ld
         Jknw3Y8iTPWfNeF+PkrVJOBFY7Fti4K5KZ2t0ioBQKAytXHsN6RKwvyZTUjDLvihpYCG
         WIPMn5HzoAMh5tUlY4ByAx1wspI0EAwpLKst5stvSXYiBk1jvNjVPy/PFbdj0En2kqj5
         dsYXyuxITiSMyWmrc2kGzzT7kfM+JkgOXW9dd6tolLhAid2+xTLdzGGtCjrm+evb7pYi
         q0XyNRVpvNDrDFqtQrfKKYtP4pNKlL95VOgPVXlghvgKf1M0L1WZ1zP76vtT005uWB1X
         Re7w==
X-Forwarded-Encrypted: i=1; AFNElJ94DWlojnroSPrgMRgklhpp/XqbpK636lRf0CdNcgwGaYXn0OujuKojhNqmgAa1cpMbhtPkL6hFHLtj@lists.infradead.org
X-Gm-Message-State: AOJu0Yza+Wgo69qG+iGcC1ibMJHcX8RT993YLPyvGmh2FOBfv50FdxXc
	R+7i5JOwOQLS0nd8SijPHLSsI9J3o9LxR+lS4DsYOse48CXWJenmaIrWVdcMeYQmj7iPw08W5c+
	y8JX6
X-Gm-Gg: AeBDiesVs155DrL2lsDTCd2NAckAV5EbIBE30v15c0JwFE1WYi2HPocnq3o4wPLykdx
	GVNX7hYJFATheynKz9sbJIp+NhOw2V3Ji1Ec18NXjVMmJzPunxdwSatXkkJtkRZhDU7Q0rCHI1D
	YvcFRKtv1dZwz6E9jQzNpFJQD7V6GZnv1eXWXaz3N4aBsxch3pbvXDhmYO1STO7YNkghDVY++5w
	DzhldszJv3zfRaYJvWUjcEIB2OtgLjCOZNOTs1WHQfJ5BGCCDZ4xfXfIu4u8FA3d4Lx+JmFTjwt
	Shn4Qo+SBhsjIYPstrogISdMD/B/gx+/gcz40wGBdXLyLSp7f6K7TeojMYzX2ZpgDvvyzdT9Fy3
	7NA/708zOnndo5We3iSp5I00lZcbZk9GVm8amD6BK7dPhwFpsimZ8DRfPZ46MUPmktvWkEzzcKV
	1V+MAXiB/eyWTnnRBjoAeU8V6iYyln8RMDoitu9uC2LyexfplJzEB1uPbfcv+dZ/up819IHWRhd
	O1B1pzcWBAEF+mhLcBUzzsttjg2oWN/nc5ri6Qtw9HLwb2mcy4=
X-Received: by 2002:a05:600c:6291:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48a85e75173mr71825495e9.7.1777591796193;
        Thu, 30 Apr 2026 16:29:56 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:55 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 4/7] nvmet: delay requests
Date: Thu, 30 Apr 2026 17:29:10 -0600
Message-ID: <20260430232913.129271-5-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_162958_137306_7E2658D3 
X-CRM114-Status: GOOD (  13.80  )
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

From: Chris Leech <cleech@redhat.com>

Allow requests to be delayed for testing.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/core.c  | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e534ad312275..c5028f1fc458 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -6,7 +6,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/jiffies.h>
 #include <linux/rculist.h>
+#include <linux/workqueue.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
@@ -1891,6 +1893,34 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
 }
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+static void nvmet_delayed_execute_req(struct work_struct *work) {
+	struct nvmet_req *req =
+		container_of(to_delayed_work(work), struct nvmet_req, req_work);
+	req->execute(req);
+}
+
+void nvmet_execute_request(struct nvmet_req *req) {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int delay_count;
+	u32 delay_msec;
+
+	if (unlikely(req->sq->qid == 0))
+		return req->execute(req);
+
+	if (ctrl) {
+		delay_count = atomic_dec_if_positive(&ctrl->delay_count) + 1;
+		delay_msec = ctrl->delay_msec;
+	}
+	if (!(ctrl && delay_count && delay_msec))
+		return req->execute(req);
+
+	INIT_DELAYED_WORK(&req->req_work, nvmet_delayed_execute_req);
+	queue_delayed_work(nvmet_wq, &req->req_work, msecs_to_jiffies(delay_msec));
+}
+EXPORT_SYMBOL_GPL(nvmet_execute_request);
+#endif
+
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index beade281164a..845072cf4fae 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -511,6 +511,9 @@ struct nvmet_req {
 	u16			error_loc;
 	u64			error_slba;
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+	struct delayed_work	req_work;
+#endif
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
@@ -998,5 +1001,10 @@ struct nvmet_feat_arbitration {
 	u8		ab;
 };
 
+#if IS_ENABLED(CONFIG_NVME_TARGET_DELAY_REQUESTS)
+void nvmet_execute_request(struct nvmet_req *req);
+#else
 static inline void nvmet_execute_request(struct nvmet_req *req) { req->execute(req); }
+#endif
+
 #endif /* _NVMET_H */
-- 
2.54.0


