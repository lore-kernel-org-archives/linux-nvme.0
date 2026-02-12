Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56C3ECD6F7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gytecfs+kP5fchWx6J1Ofd0aFrBgmLt6dmTW76I3c3s=; b=4tE1oKdE21oRkwFusH/54DmTcF
	MJtvswxcl8QEmtarjd5OCtXm0PrDoIv+L2iyGGbSoYefDlLf7GQdZMjFuULHT1cqraWKTxflCt9v2
	U2T+fi2F/tzd6EFaI0BuMwgXLyDctDrLZz9DahkYLugTiXODRcIzsqfbc9905dd6nMKqXWsExJPFM
	xXyoPqdDvH+NaUJ/jedpPWS/Sj5MyKZzeHs3Cxb1G8NMNUw/8tvmT+eP5ks1TSPd6AUAY65g1RyF7
	Lrc9XA/dYSc9elv1M0qu9imqYNyeWCUBwnzxQKTy1iLiMpxnN47IlcdTeEzV57RC6c+53l/lbSG4i
	dzU7arXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqLbc-00000001Gwp-2FV8;
	Thu, 12 Feb 2026 01:34:56 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqLba-00000001GwS-0vyU
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 01:34:55 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82311f4070cso944779b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 11 Feb 2026 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770860093; x=1771464893; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gytecfs+kP5fchWx6J1Ofd0aFrBgmLt6dmTW76I3c3s=;
        b=PtbDUvDO+l5uJf4HsEHKE9ohsy2HG4e29tR5BJbuIfYc54TGH/4chxM8YTs1CV8xB9
         t4N8KcTRLWzGdfsV4figD7Nna6nrt8MPT37UD6CmXWeOpsFqRvg6TbReJmxNbSjlGr78
         A/Awtt/db1Q2wOoDRQyvf4eSC7d97eFzgjfr3FH9ykY5TIi4jgmHL0cIJhPCVemqeH55
         Wk65FE6qEFqjx0oHljnY6YEHcNf6r+m8oaUnApeyBg6Nr7g9fm6MUfB6+sdU+8pWluse
         zXN62PJC+oTATzGoe1XbgMKUqQeQiYs6qxlIMdxvEeTjXDFf0DmYoEFM5WnX/QmSy41y
         mQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770860093; x=1771464893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gytecfs+kP5fchWx6J1Ofd0aFrBgmLt6dmTW76I3c3s=;
        b=VM+wE8xMW9cG8X9YIWnR5Usn18GrZge7ePD9PYZFKMOZgjGevGubL09Zl2WM3Xkkq4
         GidGcVKpe8zoIcAzq9JovET7KS1iAOM++P+R7nrGkHBQbGxOgtbfFEDvraKm4KAyUTHe
         W4hDONIUemKmK2gOxPIYpb01w7af6rEs03y+YYc1kFy8MiXfmjh69IOSd5EleLXlYMHZ
         ntJmazTGdJ6LLxnILjQNq761+NyLqrxF3IxwHSp0h6gMfgwnVQ3ASUn+3SGKSU/s0WvJ
         V6hreQZb6ziPkubjN+05hjLRGdbrQc5iZL0OtztTqxzPT2+8dptBmgQYZyHo2kxmZBmy
         nrIg==
X-Forwarded-Encrypted: i=1; AJvYcCXzQdD5dhX/OM1tGZTOzcCXRXULTGqadnPR50h0peDf845i92Lm/4mTRs0+V1pRb1yQ3c1ZD3dXnWrv@lists.infradead.org
X-Gm-Message-State: AOJu0YzSWfQJseHX1sLCPN9kbxMlSvaOq6CUiLbxPigNjbY8Yjitz+VM
	wv3i/TYXMPRmn88s60hokOE7JrL7+jJNFCN4GEW7gUMQNQYfNEzPrOjl
X-Gm-Gg: AZuq6aJTwmEK5EPXPSe6/gJooV1j3LC34fvOXACTwmn2Tg/F0YKbYHAHpZuWPrTfECU
	/jzmsG8Zvw4kLM6wEERsJQ/xkjMucF7k/7W01YM8Uy+mMzlGIl6/qecM3FaRSJWiXCk8cbCuPTr
	KTcBjiFn2CJA40uOcs62OQ+cgbUA1jIBqpmNR0yjLPu543APhUy2Qdo9Sc/AnNRoUlFwAsYn8Ve
	/rvsLTIMTZm05OpNuS2HqjNY7Ae/LXLdLA4eZe/re4rZULpz5M5+WZcFjrVm6rQ4Tomqa635xcI
	fsqdnjAKMV/KfY5ejhyfGixJX7rTQkYYaXfXF+6YEWF4ZfoEjOXseYf7RyJxPhP+9L5sKaVCcLq
	uBGcrhmJRRaThI7RBh/JLT3M29JtKCSj+FmD1tMEPGjSnGDbqjIyFLGlsVdLO/Xrb4AY6aD0vVP
	MyRwZOOBVysZGXqNik7OQ2nGnPjRPadHbbVycQ+bYl14JA
X-Received: by 2002:a05:6a00:2347:b0:81f:32cc:b1fc with SMTP id d2e1a72fcca58-824b0cb94aamr844747b3a.3.1770860092934;
        Wed, 11 Feb 2026 17:34:52 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e80def7sm3974008b3a.44.2026.02.11.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:34:52 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: hch@lst.de
Cc: hare@suse.de,
	ioerts@kookmin.ac.kr,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	yjshin0438@gmail.com
Subject: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG: KASAN: slab-out-of-bounds)
Date: Thu, 12 Feb 2026 10:33:18 +0900
Message-ID: <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211160859.GA11869@lst.de>
References: <20260211160859.GA11869@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_173454_272473_5DE72DDF 
X-CRM114-Status: GOOD (  14.15  )
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

From: Yunje Shin <ioerts@kookmin.ac.kr>

AUTH_SEND negotiation requires at least one DH-HMAC-CHAP protocol descriptor.
Validate the payload length before parsing the negotiate payload to avoid
out-of-bounds reads.

KASAN splat:
[ 1224.388857] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send+0x1d24/0x2090
[ 1224.407035] The buggy address belongs to the cache kmalloc-8 of size 8
[ 1224.407998] allocated 8-byte region [ffff88800a6537c0, ffff88800a6537c8)
[ 1224.412412] page dumped because: kasan: bad access detected

Use struct_size() for minimum length computation and move the negotiate
restart flow into a helper so the call site stays compact.

Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
---
v2:
- use struct_size() for negotiate payload minimum length
- split negotiate handling into nvmet_restart_dhchap_auth() helper
- use NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD instead of NVMe status

drivers/nvme/target/fabrics-cmd-auth.c | 48 +++++++++++++++++---------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..3773980bcb1c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -231,6 +231,36 @@ u32 nvmet_auth_send_data_len(struct nvmet_req *req)
 	return le32_to_cpu(req->cmd->auth_send.tl);
 }
 
+static bool nvmet_restart_dhchap_auth(struct nvmet_req *req, void *d, u32 tl)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmf_auth_dhchap_negotiate_data *neg = d;
+	u8 dhchap_status;
+	size_t min_len = struct_size(neg, auth_protocol, 1);
+
+	if (tl < min_len) {
+		req->sq->dhchap_status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+		return false;
+	}
+
+	/* Restart negotiation */
+	pr_debug("%s: ctrl %d qid %d reset negotiation\n",
+		 __func__, ctrl->cntlid, req->sq->qid);
+	if (!req->sq->qid) {
+		dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+		if (dhchap_status) {
+			pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
+			       ctrl->cntlid);
+			req->sq->dhchap_status = dhchap_status;
+			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+			return false;
+		}
+	}
+	req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+	return true;
+}
+
 void nvmet_execute_auth_send(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -289,22 +319,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done_failure1;
 	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
 		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
-			/* Restart negotiation */
-			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
-				 __func__, ctrl->cntlid, req->sq->qid);
-			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
-				if (dhchap_status) {
-					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
-					       ctrl->cntlid);
-					req->sq->dhchap_status = dhchap_status;
-					req->sq->dhchap_step =
-						NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
-					goto done_kfree;
-				}
-			}
-			req->sq->dhchap_step =
-				NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+			if (!nvmet_restart_dhchap_auth(req, d, tl))
+				goto done_kfree;
 		} else if (data->auth_id != req->sq->dhchap_step)
 			goto done_failure1;
 		/* Validate negotiation parameters */
-- 
2.43.0

