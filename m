Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59301CF9C5B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2024 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=81aBKjWDfUQzVlF0OsFTIEVcSlSoUwa15V4LyMwlH9Q=; b=CPAou0Wt6IuRG2A7rg6JhQnoWq
	xyuwP6xbukWSP/OfQoRnPEzHla2aCbfrheKSl1/WMTfcaMMqJSOfZ+SbleCV33RTJOEv5Plg2KYb4
	TMiULKwAxmPxdrT5E6eK5GWYUjMLj/Hzg2C3WCNC4Y0yfAViyF8gNuMFr6ZU+ZvRekFEyrqOviQ52
	MXEFLKrfQYURxQkRNcAoCwF9zoDKJghGYfKGzKqn8LSEBuy1rRBS7i9919xjU/jn+FoYe8F7RFY1N
	ruoMOunyKqjYYmmZcJFBcP2zoCb/68j/8ky2+ruTQEz5P/8eHtE9fDGBRxTLJl1ZvfVI80S7kPX4a
	zXJt3TnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssc1Q-0000000GNR8-0bFa;
	Mon, 23 Sep 2024 05:54:08 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssc1N-0000000GNQK-01lt
	for linux-nvme@lists.infradead.org;
	Mon, 23 Sep 2024 05:54:06 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-206aee40676so31312005ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 22:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727070844; x=1727675644; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81aBKjWDfUQzVlF0OsFTIEVcSlSoUwa15V4LyMwlH9Q=;
        b=HQvNXqJpSta6trpN3OJQtNzITH21Ew/SVUAU5gNfBfeDRCcL0Ko0ZsR3roJg+Peq0R
         F+hB/vt65EufCf2h0Mkzk3BqPuLGlv4cW72c9f5R0+18XXxrrlhYZBBm4uqd2vgc52HV
         tB3JmkHuiFh++owubPnwAA2tEL+AZR0TXKBTE+ga9DaeyCfcnkd1TzzYpS3WJj0H55ky
         2kc6LVzB7pNyH5z6dWY9dAaLMj6XA7cHLgbouCWz86xfuFTTD/et8fXItoJImfXXulhl
         D6I0QPFVeGhS6wym5LwS0uC6KMstNnDz3yJ220zLlZdDi4iX/nz1reypXOdFyRRtSFWZ
         1tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727070844; x=1727675644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81aBKjWDfUQzVlF0OsFTIEVcSlSoUwa15V4LyMwlH9Q=;
        b=KZxEA4kgXQgRrM5Cs1kku9xfZM+UUb0DOW1RgU71Sp+RHWDdRqKZJ0CLFnzZGyFwcb
         dhH6lTCY/iUJQYXnoAq+Gta1mi2yZpyeOkYR5TV1xJ8xNAUlTRtr4rPABQZjMbo9PFG1
         /HC3gRwm5hq7wSLdaNY/P9ZKYn001EwsEMhJXI3cWwodVZcL9hTAtRERNW9QSWvKO68h
         JJHWzd289TyEo7tzTSxOryK7f6Lgv47MY770puIz/fo1HFnRFfK5yhzob1+QV+U0reO2
         DWj3ujpGaNAHrTWP/CyFe7b3B4SpYShlvYIW3pWl+2J3mo0EFAp+yGuDqtN1wpm3/rSc
         hqUA==
X-Gm-Message-State: AOJu0YwlJJ58YtD1tjOa/eSxqnPuXIwJ+Er9ZPO7II5Ijzy2Q0cVDP+c
	dQPqN44DJV+IUrT0r5Yx07KGQniiazCHYmkGATxFUOuuET+lJPpVaVAtGQ==
X-Google-Smtp-Source: AGHT+IG3YesSno4A4MaIg7KsjUu2nGONrjQPeYGyTYqCS9C1lk0e+eHdcnu4qJ54Y5uzJhDMNLphzQ==
X-Received: by 2002:a17:902:c94c:b0:205:4a37:b2ac with SMTP id d9443c01a7336-208d83c8698mr159442715ad.34.1727070843754;
        Sun, 22 Sep 2024 22:54:03 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:ba23:ec81:7b64:46d9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1724sm126486745ad.131.2024.09.22.22.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:54:03 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: combine NVME_CTRL_ATTR and NVME_CTRL_CTRATT definitions
Date: Mon, 23 Sep 2024 14:53:23 +0900
Message-ID: <20240923055350.33246-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_225405_075611_8516A903 
X-CRM114-Status: GOOD (  14.54  )
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

Also added some new NVME_CTRL_CTRATT definitions.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c        | 10 +++++-----
 drivers/nvme/target/admin-cmd.c |  4 ++--
 include/linux/nvme.h            | 19 ++++++++++++-------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca9959a8fb9e..cdda168bbb18 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1273,7 +1273,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 	 * command completion can postpone sending a keep alive command
 	 * by up to twice the delay between runs.
 	 */
-	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+	if (ctrl->ctratt & NVME_CTRL_CTRATT_TBKAS)
 		delay /= 2;
 	return delay;
 }
@@ -1343,7 +1343,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 
 	ctrl->ka_last_check_time = jiffies;
 
-	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
+	if ((ctrl->ctratt & NVME_CTRL_CTRATT_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
@@ -1913,7 +1913,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return;
 
-	if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+	if (nvm && (ctrl->ctratt & NVME_CTRL_CTRATT_ELBAS)) {
 		nvme_configure_pi_elbas(head, id, nvm);
 	} else {
 		head->pi_size = sizeof(struct t10_pi_tuple);
@@ -2137,7 +2137,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+	if (ns->ctrl->ctratt & NVME_CTRL_CTRATT_ELBAS) {
 		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
 		if (ret < 0)
 			goto out;
@@ -2541,7 +2541,7 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
 	/* Don't bother enabling the feature if retry delay is not reported */
 	if (ctrl->crdt[0])
 		acre = NVME_ENABLE_ACRE;
-	if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
+	if (ctrl->ctratt & NVME_CTRL_CTRATT_ELBAS)
 		lbafee = NVME_ENABLE_LBAFEE;
 
 	if (!acre && !lbafee)
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 954d4c074770..799c2e61e9ec 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -401,8 +401,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
-		NVME_CTRL_ATTR_TBKAS);
+	id->ctratt = cpu_to_le32(NVME_CTRL_CTRATT_128_ID |
+		NVME_CTRL_CTRATT_TBKAS);
 
 	id->oacs = 0;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..c48e7f3fa09b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -271,12 +271,6 @@ enum {
 	NVME_PS_FLAGS_NON_OP_STATE	= 1 << 1,
 };
 
-enum nvme_ctrl_attr {
-	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
-	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
-	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
-};
-
 struct nvme_id_ctrl {
 	__le16			vid;
 	__le16			ssvid;
@@ -375,7 +369,7 @@ enum {
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
-	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_SEC_SUPP			= 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
@@ -386,8 +380,19 @@ enum {
 	NVME_CTRL_CTRATT_READ_RECV_LVLS		= 1 << 3,
 	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= 1 << 4,
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
+	NVME_CTRL_CTRATT_TBKAS			= 1 << 6,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
+	NVME_CTRL_CTRATT_SQ_ASSOCIATIONS	= 1 << 8,
 	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
+	NVME_CTRL_CTRATT_MDS			= 1 << 10,
+	NVME_CTRL_CTRATT_FIXED_CAP		= 1 << 11,
+	NVME_CTRL_CTRATT_VARIABLE_CAP		= 1 << 12,
+	NVME_CTRL_CTRATT_DEL_ENDURANCE_GROUPS	= 1 << 13,
+	NVME_CTRL_CTRATT_DEL_NVM_SETS		= 1 << 14,
+	NVME_CTRL_CTRATT_ELBAS			= 1 << 15,
+	NVME_CTRL_CTRATT_MEM			= 1 << 16,
+	NVME_CTRL_CTRATT_HMBR			= 1 << 17,
+	NVME_CTRL_CTRATT_FDPS			= 1 << 19,
 };
 
 struct nvme_lbaf {
-- 
2.43.0


