Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB7E8FDB0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Dec 2025 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RDD+4AZjb5jy8rH4mCTP8p/da+orH/MxAX6wbIo8W58=; b=z2ylCoqr/203u+ApQOJ3BST7jf
	xkGVudY++wKHGAxix268mL/kFmJryMOrdTsyVYdkO8Fe6CoEjMSQxPEw1f28GMtRmb3dh7IQ24ymh
	adKDgqrJKhYJ0094dK7r7ULa7ElsUQ1B70oNTFMvfvdhDNIqRsIyapknuwsaupH6f+cfGTs/Zl74g
	hWVxmzpVBchnWtbWb1ZAh6XxxG0rwo4OMeGHGR4QsTB1/QZD9FIv7zljXruPAJd/TnHwXr4Skemu9
	vKEd69jYYq5PT6RgZhPA7wxes4imt1DvOzft2IQzWQtKWKOgjE8XaScV5fFn/tDHbsR3riAdZmPLc
	AibfrsyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZC1N-00000001Lhg-2bd8;
	Fri, 26 Dec 2025 17:54:37 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZC1F-00000001LhB-1qdb
	for linux-nvme@lists.infradead.org;
	Fri, 26 Dec 2025 17:54:30 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b98983bae80so6459012a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Dec 2025 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766771668; x=1767376468; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDD+4AZjb5jy8rH4mCTP8p/da+orH/MxAX6wbIo8W58=;
        b=kC2y9FtMRHi0P0cpiscJa/74BRpnPh75rYe4QttTSUChK+KgP4OxpjYjTq5iDqv1z8
         cX851baJG+kQfnRLCY6zCdY8dYfU8o3UWcbmp2CRvgHBm1GpsQ8zu5fXDnzAq5Kad1st
         kVplGBYKYCRIZgtP85RFDsbAF4eNzCPCY5Q2AT3LmfTFbSH7Lyq6goY9sN5OnEIjd0dp
         oVAuJ9+FRqAgHybEkM1qrTCxD3/8D5TRzL/a0lwmXfc/rQE+s2GYpOf+N4DyRNtwlCEm
         pBBwyWreI+HLDguVYM001MPERiLx7Rie6oXaapqiTpSWJ8m+Xl+geBa+qjiDgKRXgGtZ
         2hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766771668; x=1767376468;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDD+4AZjb5jy8rH4mCTP8p/da+orH/MxAX6wbIo8W58=;
        b=AwFTqMT42MAK2IProkZUtcP7JdFiyBQRsjNQWuFZRZaG+ocvTiuubszvoMeCAGQIu9
         v1Bv3XSAS5sP+R0Qbg55Yz0m6oC+82Gd2y/uKQPoi/WWw6dfJdspmika/LSWoY0XboTK
         waqkpZrQKnP9sKsf09FH4b5dMSxRbmS55kMokjZMhAjEgNjzU/FoCrCZxEO3p/dZMzPu
         HxmLbsnnRLchPwPciLIX1Q3aOGrHf3q5gc51pc8lRDGtIx/BF24P7075Q8q2+2lXq9f1
         UmtttqHDTs1a3A1qlJ6qWaSAao6fRlAw+No0k2hdh769Q43LIWNd0LjD1j0zFTCy5q63
         IIJQ==
X-Gm-Message-State: AOJu0YxdH+Mgkad5dK4eGFhK0EuanNWqzaihG5d2iIo61yZ1X7/HD1cE
	KxqSLeMHLdaQoO3FtpWMEqe+NWpe2vJhxSYJTu5CvYA+lvKzzT9t4KWG
X-Gm-Gg: AY/fxX5layLRqKI7Lt5kGjxHsdo4LPI1Ygazro8BTx8gqKMFkgWkw1jIybg37/D8NSS
	xA1tf3qRggrtRMx1t+Vu0yKy9Xyfc7zHae2zndw7s3BEgK86jm+4F74wlps7p/dt8hr2AzjeXP0
	qA2gggmMZzIfOQzKx4TWbjaspy0dhwnBJJU7dSjpgIuE5QpiYJYFurp12DIn6p9l345SBr5Yti1
	bmzUa07Lhk3eFJRIuItR2LsB+06J/oksgSZFmJXF3geFqEGTUA74eLW0MO6uzJp6nXruWPZayA1
	dbDCIg/RHJFaB9kLp/uxOX8kOVplzXdRvGoEJW2IkUB2cDvLBsTosuc5dFmdJF47UoAhtpTVwI+
	vTKFGs5yTduU3/3impeLRGKjKhnGUd+6jzi2iTJEJdzYFP/dw07upjVv5RUN/W1MsPCLaVVNsVI
	ucnGoXwrqCevv03AwlIj5ExA==
X-Google-Smtp-Source: AGHT+IGT4BXgwvcgfN1XwVI7hxe02ZWZz2JOxOkM2rm2GdH33vbYynGiBY9lZ3IEMxxK1ofhA8PBBg==
X-Received: by 2002:a05:7300:f58b:b0:2ae:6118:dbce with SMTP id 5a478bee46e88-2b05ec05052mr12098473eec.10.1766771668220;
        Fri, 26 Dec 2025 09:54:28 -0800 (PST)
Received: from [192.168.5.81] ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffad66fsm54112002eec.4.2025.12.26.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 09:54:27 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Date: Fri, 26 Dec 2025 09:54:19 -0800
Subject: [PATCH v2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-nvme_ns_validation-v2-1-0e1b3a142553@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMvLTmkC/x2MQQqAIBAAvxJ7TrANKfpKhGy51UJZaEgQ/T3pO
 DAzD0QOwhG64oHASaIcPgOWBUwr+YWVuMyAGk2FaJRPO1sfbaJNHF1ZV3WlSTdE7Ygj5PAMPMv
 9T/vhfT86JQe5ZAAAAA==
X-Change-ID: 20251225-nvme_ns_validation-310a07aa8b2b
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=1m9qiFtkq9lRrMzjv95185/VZrcaM0nqScvCTtc8M+o=;
 b=owEBbQKS/ZANAwAKAXT5fTREJs3IAcsmYgBpTsvTkK7tAJytUupLnOJngWO1jaRQYrrTtebpl
 PGxSrvSsFiJAjMEAAEKAB0WIQQAohViG04SVxUVrcd0+X00RCbNyAUCaU7L0wAKCRB0+X00RCbN
 yOyDEACtHZqrXeVMeJJD7/2FtpbTKKFyIYMHGkiitO95lNbKoKFJJ2fZ+W5nc/NlV8h/E6g3P7N
 okGukoxdVWexBmv2fwoo3yLF6KAsxeFdC+kDYw5v1zP4KYQCGLPXcS6dysCId1yBX9Envc3YLty
 aXxi+PLLXSt7jr98dOm3a6axq6s6dOZE5sHUgnEGoXQX8ORdLUN3BTRgwReYd6T1YkWGJpkAYwD
 hmgEqz+g5uE4ybpCyWplTZkJrJJoZElcSMp9VmHP07mxdE1kBl/JJ6oZNq7CcUy/U4N9RxPArda
 BEQzuZvPMcCOVzM+PV8A5OcWj38/KWDLsOPkWRF6S9v2k1ITCEtpmu2VMk0BTPNP8XnTwfWhvxB
 93QQJgdvtEX2rAT6KuKk4kD6n3q3zDL2By2MlOTvJ+QVLi5qbaXcca8oHcXQ/GqEkEh5YudlsGM
 PS2NfW/GnJTetkvzsExfR5zpgmPwpNmvtRHdUFWp2VxpT4tvkduSUCSE2o/rwkjkEozfB4IF6Om
 MJR3GWewFwDLSu5ToPhRS7lnbJXVcYHUe8Gun18uP86zkAPEKnQGmQ6atdIWi/4rMDHRn7jwa+N
 eU6Q2OtPxZ624hRU3dqKgcG5/j06AtpwdQrabYDuMnmIoqRyLSG2ys2jXwySxBUhCsCneC5/nGh
 3eDJjV7jNnXJdeg==
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251226_095429_685480_CA413728 
X-CRM114-Status: GOOD (  21.74  )
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
Rather, delayed retries should be performed on the namespace validation
process.

This handles non-fatal issues more robustly, by retrying a few times before
giving up and removing the namespace. The number of retries is set
to 3 and the interval between retries is set to 3 seconds.

The retries are handled locally. Upon success then end. Upon fatal error
then remove the namespace before ending. Upon non-fatal error, retry
until the max retry amount is hit before ending.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- Simplify retry logic with local loop instead of delayed work.
---
 drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f1f4d0b3c570de285a5eb17bb08e..6cd1ce4a60af55e5673e5fd0ec2053a028fae4f2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4289,23 +4289,44 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+	unsigned int i;
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
+		dev_err(ns->ctrl->device, "identifiers changed for nsid %d\n",
+			ns->head->ns_id);
 		goto out;
 	}
 
-	ret = nvme_update_ns_info(ns, info);
+	for (i = 0; i <= NVME_NS_VALIDATION_MAX_RETRIES; i++) {
+		ret = nvme_update_ns_info(ns, info);
+		if (ret == 0)
+			return;
+
+		if (ret > 0 && (ret & NVME_STATUS_DNR))
+			goto out;
+
+		if (i == NVME_NS_VALIDATION_MAX_RETRIES) {
+			dev_err(ns->ctrl->device,
+				"validation failed for nsid %d after %d retries\n",
+				ns->head->ns_id,
+				NVME_NS_VALIDATION_MAX_RETRIES);
+			return;
+		}
+
+		dev_warn(ns->ctrl->device,
+			 "validation failed for nsid %d, retry %d/%d in %dms\n",
+			 ns->head->ns_id, i + 1, NVME_NS_VALIDATION_MAX_RETRIES,
+			 NVME_NS_VALIDATION_RETRY_INTERVAL);
+
+		msleep(NVME_NS_VALIDATION_RETRY_INTERVAL);
+	}
+
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
+	 * device.
 	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
-		nvme_ns_remove(ns);
+	nvme_ns_remove(ns);
 }
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c5c42777bd9309a983ef0196c1b95..dcbdc7fa8af0cb838b3f1a774d4c67fa69a00050 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -46,6 +46,12 @@ extern unsigned int admin_timeout;
 #define NVME_CTRL_PAGE_SHIFT	12
 #define NVME_CTRL_PAGE_SIZE	(1 << NVME_CTRL_PAGE_SHIFT)
 
+/*
+ * Default to 3 retries in intervals of 3000ms for namespace validation
+ */
+#define NVME_NS_VALIDATION_MAX_RETRIES 3
+#define NVME_NS_VALIDATION_RETRY_INTERVAL 3000
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;

---
base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
change-id: 20251225-nvme_ns_validation-310a07aa8b2b

Best regards,
-- 
Alex Tran <alex.t.tran@gmail.com>


