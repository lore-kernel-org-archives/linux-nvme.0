Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1764FC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KS1IqRY+fm9eRQBhqcB1sTNLUafq0+ttSwC8SM6aXo8=; b=2/CbgsybXsKpufmIghMuOw9JZS
	s7qo8M7KGmEoIMgDknFYfidc5azX//dOgvdbhd0fFmi8qmXQn8zpwP4WEIIAf0SGKFv562u+73xkx
	45a+vsVPum9Af/srCnUjMf7IcM4LNiCc5UyXgEtkmCo0G3a/LHwXHXn0aceyK+YfGjlDmycL+VzPa
	sIh0Qxmt/5Kx42K4gny63a6iRVTPvJVF0JHilRd8R2bEr6LDZtbqDedXphEmV3Az6KQFc9saLvMHg
	s6Ja4Q8A+GW9Z9GE1dp93mKhbmAyPqL3lkPLuvtMRXNhHLU9PWQZV4Q1beQIzdDv4a9tDJlIEGpCa
	aRahPBDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB7E-00B6r1-Fu; Sun, 13 Nov 2022 11:25:32 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6N-00B6Pe-1U
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:40 +0000
Received: by mail-wr1-f44.google.com with SMTP id j15so12421409wrq.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS1IqRY+fm9eRQBhqcB1sTNLUafq0+ttSwC8SM6aXo8=;
        b=xeVeHb9651n0gz4vll1lqNwv27zoq3X1nKYrN3YDYonBQeVDMpaOKHYHZ/tkPJf6R/
         RdRXlhuFKV0pbjxHmo7/nIzQU81ArHxPJS5+GjgiDi/d48WPa5rFpyIF7taKsUUFgbSi
         FqL3g/aMItNh2JtbzIZrTOe08eDoa19QRqb/gC2gVowB2sF5XRcpwotBBOgVSQ5qn+pt
         14dqXmV96QTFscPfiR82fy3/MIPFnQJ5PgEXVqlc6SOzGwppGmFCfOvMX0Q0RdbHHQLN
         pacdUiI6J/vRxanXHPAu1x6Sw/gcQdjElgbaA1gOCOtwa6MVToSaqI4UjgAyxPAoaGMy
         EfWA==
X-Gm-Message-State: ANoB5plILztn16k2E3eEtPjALKEyJj96Gf4Vp7N97x3fIvwtlQbkxiN3
	pL5RarcDU3+62LvFCaW7fs0dF4tg5jE=
X-Google-Smtp-Source: AA0mqf7b6kwcMPdFNVPOF1J0lwojfYrzpV++Zid+29ErXdTw8VHvqRCGEljRIIiUp1mSDpxOSOGC+w==
X-Received: by 2002:adf:cd8d:0:b0:22e:398:d533 with SMTP id q13-20020adfcd8d000000b0022e0398d533mr5276767wrj.410.1668338677515;
        Sun, 13 Nov 2022 03:24:37 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:37 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 09/20] nvme-auth: don't keep long lived 4k dhchap buffer
Date: Sun, 13 Nov 2022 13:24:13 +0200
Message-Id: <20221113112424.1049834-10-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032439_105388_6BE58323 
X-CRM114-Status: GOOD (  18.50  )
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

dhchap structure is per-queue, it is wasteful to keep it for the entire
lifetime of the queue. Allocate it dynamically and get rid of it after
authentication. We don't need kzalloc because all accessors are clearing
it before writing to it.

Also, remove redundant chap buf_size which is always 4096, use a define
instead.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 45 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e7e4a00ee37e..4d288333b0fd 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -13,6 +13,8 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 
+#define CHAP_BUF_SIZE 4096
+
 struct nvme_dhchap_queue_context {
 	struct list_head entry;
 	struct work_struct auth_work;
@@ -20,7 +22,6 @@ struct nvme_dhchap_queue_context {
 	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
 	void *buf;
-	size_t buf_size;
 	int qid;
 	int error;
 	u32 s1;
@@ -112,7 +113,7 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
 	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
 	}
@@ -147,7 +148,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	const char *gid_name = nvme_auth_dhgroup_name(data->dhgid);
 	const char *hmac_name, *kpp_name;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return NVME_SC_INVALID_FIELD;
 	}
@@ -302,7 +303,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	if (chap->host_key_len)
 		size += chap->host_key_len;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
 	}
@@ -347,7 +348,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	if (ctrl->ctrl_key)
 		size += chap->hash_len;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return NVME_SC_INVALID_FIELD;
 	}
@@ -674,6 +675,8 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
+	kfree(chap->buf);
+	chap->buf = NULL;
 }
 
 static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
@@ -683,7 +686,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
-	kfree(chap->buf);
 	kfree(chap);
 }
 
@@ -695,6 +697,16 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	size_t tl;
 	int ret = 0;
 
+	/*
+	 * Allocate a large enough buffer for the entire negotiation:
+	 * 4k is enough to ffdhe8192.
+	 */
+	chap->buf = kmalloc(CHAP_BUF_SIZE, GFP_KERNEL);
+	if (!chap->buf) {
+		chap->error = -ENOMEM;
+		return;
+	}
+
 	chap->transaction = ctrl->transaction++;
 
 	/* DH-HMAC-CHAP Step 1: send negotiate */
@@ -716,8 +728,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d receive challenge\n",
 		__func__, chap->qid);
 
-	memset(chap->buf, 0, chap->buf_size);
-	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	memset(chap->buf, 0, CHAP_BUF_SIZE);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, CHAP_BUF_SIZE, false);
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "qid %d failed to receive challenge, %s %d\n",
@@ -779,8 +791,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d receive success1\n",
 		__func__, chap->qid);
 
-	memset(chap->buf, 0, chap->buf_size);
-	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	memset(chap->buf, 0, CHAP_BUF_SIZE);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, CHAP_BUF_SIZE, false);
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "qid %d failed to receive success1, %s %d\n",
@@ -876,19 +888,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 	}
 	chap->qid = qid;
 	chap->ctrl = ctrl;
-
-	/*
-	 * Allocate a large enough buffer for the entire negotiation:
-	 * 4k should be enough to ffdhe8192.
-	 */
-	chap->buf_size = 4096;
-	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
-	if (!chap->buf) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		kfree(chap);
-		return -ENOMEM;
-	}
-
 	INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	list_add(&chap->entry, &ctrl->dhchap_auth_list);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-- 
2.34.1


