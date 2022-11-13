Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B93C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tqolT6++aXgqDivSmvNwr859vMuGQPDPE14nhq5Fh8I=; b=Ebs7OVSFtOmtk4csNokCC4AHkL
	3Qz8vKRN7mxwmYLQOuayLBa5iqodK3wlHgcGF+XrTqfuQOHCUKw2pgaX4tpC3ernlbr1jWI5Nz5cI
	D40Z0wmzV8V5150tbslKF8N/MmID24j7Hxo+NjImA7gWRnTS+UrWDPxdx1LSbKU+BgSYGXD+SL7pc
	LiIIayxhbUpiWrNMIwrpJsX+6xIF61NmO78lccrywWWfLmgN8wi7RK9H7tBQe6Lo9FzYOZh9dyX9Z
	cWd7+XfFE9305KCdO50NXn2QffqG2xZ1RfLUZs2eMiII4vjJD62qYbY2QdGK2RXLgonoRSIaPBg61
	Srsu1WPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6K-00B6Oq-89; Sun, 13 Nov 2022 11:24:36 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6E-00B6Lw-4f
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id k8so12427456wrh.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqolT6++aXgqDivSmvNwr859vMuGQPDPE14nhq5Fh8I=;
        b=SF6IU2M9tBUfIh0P9eruJYOE4GSokhPYpyepj2s63DFMH2gHwbCKMEJ07JuS/uK/t+
         OrfHvdo+e6PMDOfwTxBPToSyNYdY3PVUNGBxBocz0+JSZXD9o5oe2hIqMcRwDWVvd6eO
         CiGazOBu5gxeA0Ng16EHjfpJp+BRqVzmt28ZK6YkVItZ4UQbGHDgi9M7LjNVBT5dcA8V
         5gGMri9FRAdR5lvEfLYOfqJ17DsQcs573SiIpZnukIlsZjWcys42t8PhrH59KNs0TQ/h
         pSBYPD+4cwBhXuB/S8tYjfO2jUJ+xXRS6gU+ITA/WPHAkr8h5CyWk+7LktxBxEWH0iLR
         02Hw==
X-Gm-Message-State: ANoB5pl5xglv8cu9QifYedOLS4F739MoIpgh3RYotrPG0w+wiIX7E7Xq
	OJ9CuAsuBnVQpdFyt8jJwiktpZXtc/4=
X-Google-Smtp-Source: AA0mqf6GoXXAXLTO4pdxVgOd0bxSewVsYRdwr9m6png429tAaQ4W0j3Tojs4XV4EeBnDHtp5zvKW0Q==
X-Received: by 2002:a5d:500b:0:b0:236:6e67:84a4 with SMTP id e11-20020a5d500b000000b002366e6784a4mr5118490wrt.181.1668338668043;
        Sun, 13 Nov 2022 03:24:28 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:27 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 01/20] nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
Date: Sun, 13 Nov 2022 13:24:05 +0200
Message-Id: <20221113112424.1049834-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032430_196446_29968DC8 
X-CRM114-Status: GOOD (  12.57  )
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

nvme_auth_[reset|free] operate on the controller while
__nvme_auth_[reset|free] operate on a chap struct (which maps to a queue
context). Rename it for clarity.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..d45333268fcf 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -654,7 +654,7 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
 	kfree_sensitive(chap->host_response);
 	chap->host_response = NULL;
@@ -676,9 +676,9 @@ static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 	memset(chap->c2, 0, sizeof(chap->c2));
 }
 
-static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	__nvme_auth_reset(chap);
+	nvme_auth_reset_dhchap(chap);
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
@@ -868,7 +868,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			flush_work(&chap->auth_work);
-			__nvme_auth_reset(chap);
+			nvme_auth_reset_dhchap(chap);
 			queue_work(nvme_wq, &chap->auth_work);
 			return 0;
 		}
@@ -928,7 +928,7 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		flush_work(&chap->auth_work);
-		__nvme_auth_reset(chap);
+		nvme_auth_reset_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
@@ -1002,7 +1002,7 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
 		list_del_init(&chap->entry);
 		flush_work(&chap->auth_work);
-		__nvme_auth_free(chap);
+		nvme_auth_free_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
-- 
2.34.1


