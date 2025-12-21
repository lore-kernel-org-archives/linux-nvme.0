Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F94E67482
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6/4PdDkK325eCTawTD9HSWjcdgXFVKGULVX1QePMHQ=; b=ysOAQ/KICezpr2xQBKAlIDz+nW
	HOxg5euqosQN5emZEK5fnqHfC7hEq2SXZizg8viqh5RjCH7fZXKoKrd6M3ilmuEafTTRLVU7iTl2f
	vWnpP+PVvUrXwsxxI566Zt1srEiWNIoqX3zkYU8O8O6Dt0bpYmE8cPsqvVArQp1KAAJfe6WEBXJSM
	hVaY7U56Bynq5X1/Uizq54MQnOsPfS0aB3S+vPHECjdG8inmPtE1xXRJfqLKincXM1WqcsYbp9NWp
	G16xNLruHLemx6BlBSWjOqXVw4se3u+vwRotupBFz+V3OtwnS48Z56xdG1Mcp6UGlXJCylEbW+FXP
	3QUZYKog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwc-0000000CmZT-43oG;
	Sun, 21 Dec 2025 21:26:26 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwZ-0000000CmXu-0805
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 21:26:24 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso2100878a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Dec 2025 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352382; x=1766957182; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6/4PdDkK325eCTawTD9HSWjcdgXFVKGULVX1QePMHQ=;
        b=UPy/dNMNpxnMGx0agrgG6YojGSoyqyVBcnZe3MLa8ckO5YXxdlRotIJKlfVPPqVZuq
         0QJIpRxJ0+IwHqpaeBikSnn+bwlnWwyV7ZukGpFefDhM79CBhq1u2fkT/6abv3XmtJd3
         JWpCxm0/MCPB5dtcI7COIJH0V0wiKYtLghl84x3gW/8Qd3h4NRLekjnYsoNpgoy5LkPj
         9hGI6+x0jAhOmCaOAMf58y1zJlSdoFBYJWY9j7SPw3EOLHXFBCZ8SRntKf/NdowuL6Oy
         QQgk+93x38RHns264/MJA7y7WBxLH4Ujmr40SFODYe3/NAEGpj71Hm9L9t/fLpQB2aPE
         J6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352382; x=1766957182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6/4PdDkK325eCTawTD9HSWjcdgXFVKGULVX1QePMHQ=;
        b=H9yLVBd3RLfFXdxP1PJcFiNoxg4VIWi/nkayC660iJnSPJAIDtHjzexYjyXWAhxt80
         OC3LUNWLzrlITMzN0Y/T1Oc2AbO8BisjaHqwPmn5pO1QAZy0FvOXQcEGlzv4s8Gwrgud
         /LpKONuMAGwY6+ThEA76rZQ64N7YOeUYP71++Orjar+r2UJGH62M/+TFjVA+LDXz+IYZ
         KoHErf2W8Edycyal/FMLsYaZeZ4XRVqN2wbuOAjkGRzTFoSt9Oun77TKJJf0Y7t3bWfZ
         sBemVruLeJHTgrNfebslC4jqeCwRwspI2j8q65xyvxzepxXOopMTQyx7NXsfJmm1kJ/c
         tW4A==
X-Gm-Message-State: AOJu0YwVj3D3hp4CeECInthE54z1BxiR5OMbneDMWbYOJbrWPIvasavA
	rMG4KDpI8o2OavgR5PSRj4b+/4DflWkEd78pW5lghREQvHYocSKZ6xkyMjImZw==
X-Gm-Gg: AY/fxX7B6uogOah3b2IyiQRxTCawG1SQ6G+CWmLrEG+VIctJIYbShqsIcrsyX64RVhK
	Bh9mL/0ZiE1ibiYt3aIfvA2UxE3y0jRQxBN9Rk5yDdezIYJe4vmoXP/RtaiIzJRsAIlcwUHjmJ7
	Vp9/VWi3ZCdEZEZSYHcP5x2ipFk3X7CeftUw3PAIAzYsOV57LrzxtnZ65V7zsN8MhGGCewVMgnj
	UZLH/qDbzvH2zHWk/gMLmgUNAlSet/TdE3pY2NQ1I/riTa974UrinWVX9CxaUyHUOxiVGtDz4G5
	wT2bOoFUARNTiJ7Ak6KJbRikheC2L4E2fZcJYwGuvQzcpx+RLyVe+9hnCBxm8tnxFqNmFGcQeK7
	IQer7Br5o55mkmS8uem99zmcj88IvtL/aWxCh+HvoMXu+NEh1DPIKYztFoyo4cn/YTelGgH9IIW
	UjtAHLCK27El1lVXJOVSnbyGI/qmlGx/tN
X-Google-Smtp-Source: AGHT+IGrpVW5CVFaMaE62yphLWemUMvRSMIiTPPm20ZRA5pTWKNsm1voy2OyOGq/LkzD8vOlHtH+NA==
X-Received: by 2002:a05:7300:8813:b0:2ab:ca55:b760 with SMTP id 5a478bee46e88-2b05ecda39fmr9489118eec.43.1766352381981;
        Sun, 21 Dec 2025 13:26:21 -0800 (PST)
Received: from [192.168.5.71] ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm24884636eec.2.2025.12.21.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:26:21 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sun, 21 Dec 2025 13:26:11 -0800
Subject: [PATCH 2/2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-nvme_ns_validation-v1-2-9f7a385707af@gmail.com>
References: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
In-Reply-To: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4315; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=xmdL83Sb0HpjieuD6YLEuwuBwU8sMDrI16GLhwFZlws=;
 b=owEBbQKS/ZANAwAKAXT5fTREJs3IAcsmYgBpSGX5yoG0OV7z6ig3L5a3OgZTx3dLApDtHklI/
 a4NO5X7QW6JAjMEAAEKAB0WIQQAohViG04SVxUVrcd0+X00RCbNyAUCaUhl+QAKCRB0+X00RCbN
 yHMVD/sH07MU0ZekxBsU3Drchr/G6M2ymIN6VpI3oZitiFcLRM+9EnU4AiIsS33R9AC4VpAF9ff
 wFoeoAIe0PMXlNG+R66jRzSu49P7h1mPnFa8naiB0k3HmmSfHduBEur/q1psjeOKdfADseDKnd0
 yOBRljY8TYWZPJab2PaDQpuMTVC8nu458DHnLy4AEtJaLiH2hFTNZDp7jRx6GYDDx1u5KWHBdlb
 /QbR2cGGl4OZEplvDJO/BrUgpY6TIp3ZV+GfXqtYNwGs6wfMn1/yyKuJ9RJcTu6Lvm2ygVvdwQz
 KAwvqrQh1qBRW7B2hwaQu4feiGka/XVgleUO4JR9c1hsLCCeadUc99RqFrsTDqPqr6dkkPvT/Nz
 U/sE0W8YChdnGUTBeXb7NSKoHe67cOnQNtWdE70rpxyklQLqtEtdxDuMM9qFsqgzJOcN3CQ1AjI
 OLVq+9ChMRhTmAXCL22Kz6Dl6Vez+9E+TJ59ORgmja/v8vuGK1GTu8C7xXNuoV/B24E7eqk8Bu6
 WoMjbFHvF7KmnAjMwQk6phESmU8M5O0Nhao8/Z1Aey7C/42eJfhy2jL9OZca2pWOQqjfaLuPPNT
 IKyUq1697hlwwaXDpMnaVeLRkX3YE44zgHztrL4X5rqUavQFopoPQE4tPfNvrSvtk5Cy890SsKU
 Bj95OQE5hDu2dLg==
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_132623_078616_8B132FE8 
X-CRM114-Status: GOOD (  22.07  )
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

If a non-fatal error is received during nvme namespace validation, it
should not be ignored and the namespace should not be removed immediately.
Rather, delayed retires should be performed on the namespace validation
process.

This handles non-fatal issues more robustly, by retrying a few times before
giving up and removing the namespace. The number of retries is set
to 3 and the interval between retries is set to 3 seconds.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/nvme/host/core.c | 43 +++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  9 +++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fab321e79b7cdbb89d96d950c1cc8c1128906770..2e208d894b27f85f7f6358eb697be262ce45aed6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -139,6 +139,7 @@ static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
 		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
+static void nvme_validate_ns_work(struct work_struct *work);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -4118,6 +4119,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
+	INIT_DELAYED_WORK(&ns->validate_work, nvme_validate_ns_work);
+
 	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
@@ -4215,6 +4218,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool last_path = false;
 
+	cancel_delayed_work_sync(&ns->validate_work);
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -4285,12 +4290,42 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
+	 * device, otherwise delayed retries are performed.
 	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
+	if (ret > 0 && (ret & NVME_STATUS_DNR)) {
 		nvme_ns_remove(ns);
+	} else if (ret > 0) {
+		if (ns->validate_retries < NVME_NS_VALIDATION_MAX_RETRIES) {
+			ns->validate_retries++;
+
+			if (!nvme_get_ns(ns))
+				return;
+
+			dev_warn(
+				ns->ctrl->device,
+				"validation failed for nsid %d, retry %d/%d in %ds\n",
+				ns->head->ns_id, ns->validate_retries,
+				NVME_NS_VALIDATION_MAX_RETRIES,
+				NVME_NS_VALIDATION_RETRY_INTERVAL);
+			memcpy(&ns->pending_info, info, sizeof(*info));
+			schedule_delayed_work(
+				&ns->validate_work,
+				NVME_NS_VALIDATION_RETRY_INTERVAL * HZ);
+		} else {
+			dev_err(ns->ctrl->device,
+				"validation failed for nsid %d after %d retries\n",
+				ns->head->ns_id,
+				NVME_NS_VALIDATION_MAX_RETRIES);
+		}
+	}
+}
+
+static void nvme_validate_ns_work(struct work_struct *work)
+{
+	struct nvme_ns *ns = container_of(to_delayed_work(work), struct nvme_ns,
+					  validate_work);
+	nvme_validate_ns(ns, &ns->pending_info);
+	nvme_put_ns(ns);
 }
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ff4e7213131298a1a019eaa3822ca26f857b2443..17a4123e5e4da9828ef5662acca54e6aa9fd3cb9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -46,6 +46,12 @@ extern unsigned int admin_timeout;
 #define NVME_CTRL_PAGE_SHIFT	12
 #define NVME_CTRL_PAGE_SIZE	(1 << NVME_CTRL_PAGE_SHIFT)
 
+/*
+ * Default to 3 retries in intervals of 3 seconds for namespace validation
+ */
+#define NVME_NS_VALIDATION_MAX_RETRIES 3
+#define NVME_NS_VALIDATION_RETRY_INTERVAL 3
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
@@ -565,6 +571,9 @@ struct nvme_ns {
 	struct device		cdev_device;
 
 	struct nvme_fault_inject fault_inject;
+	struct delayed_work validate_work;
+	struct nvme_ns_info pending_info;
+	unsigned int validate_retries;
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */

-- 
2.51.0


