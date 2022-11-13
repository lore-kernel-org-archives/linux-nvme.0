Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FFCC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhR9E7cVd0jPe1x+q7KA7P5nRf1syixc772MMv9VDc4=; b=d7+k7vrM0YUxFn6IBr97olXvUx
	vpCEImnhbgDqEymsbcCN624h32ZIEhAHbpqEavgowGIVPB43BXpsTCCsaprc9RcLyZ8CIkxeYbgGd
	Wh+eebI4iuTgwRPAd3P4SvhfwFlCmo+NBLVr5xxADt+EaW0fKbTIN2kJhYfDhQxIoPfUu4EPujPtI
	vX/AQxe9FynhR8L6rewot0SYJ78gBorwqWft+nx5ET+Aad2mRTv1Y5CQQdCfyT68DJQs2R1xzxikI
	8NnCHe346U0VUb1vEl84JOrXyxAfdYqZUAhh4mbQKojp5MiLsV0ridHwOwJAr6PUtxRqCLsBwnPFo
	6lgtWRPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB7z-00B7Bs-Tm; Sun, 13 Nov 2022 11:26:19 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6P-00B6Lw-LK
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:43 +0000
Received: by mail-wr1-f44.google.com with SMTP id k8so12427947wrh.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhR9E7cVd0jPe1x+q7KA7P5nRf1syixc772MMv9VDc4=;
        b=WK2bG2RLKFLHBnJWMaVFaDij3ULPn4MICeEo24KkmHh5MIVrbvDlwowhsMZU0DK5XM
         QRcw0ahbtAZTVJruSmFJcxcxeAmeewXATCf3KyjSQdNVrlnWUUIbRbgxIC7YEzebdPRt
         95P/YIpJlO3llZQK/Cle+OGSyXTn2UDzxA1v3+jfIWPiIsiav4RQUY7cntdhsETDdwPm
         ooTb8FHHpjgne8YAj3VMSNgyS8cDXVyP9SDRaFhTXje5lr9BorRPqdyAjJisuUOnz7k4
         EN3Yo4nwIZ90ILYxGBr/arWJcImJTaI3+ek5Xue9lPKMQfzZog5Yaf4jxiQEkaYBfAu8
         x4vg==
X-Gm-Message-State: ANoB5plphe9pYV8hL9Wth4UfsAq9fS0IDcTS1vK9/sk6WPF0cPDCugk1
	HDGLUDa3oPArpLqf3T9C53uT5Vwkb6M=
X-Google-Smtp-Source: AA0mqf7WkDzFfi9GoiDKYh9n5wujaFDx/FOsjI+8GntHyY4n09kZ+nxHTNR3ap31t/3PMHEIzU5osQ==
X-Received: by 2002:adf:ea47:0:b0:236:c5fc:5536 with SMTP id j7-20020adfea47000000b00236c5fc5536mr5138170wrn.664.1668338681029;
        Sun, 13 Nov 2022 03:24:41 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:40 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 12/20] nvme-auth: remove redundant deallocations
Date: Sun, 13 Nov 2022 13:24:16 +0200
Message-Id: <20221113112424.1049834-13-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032441_716703_B6F3262C 
X-CRM114-Status: GOOD (  11.80  )
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

These are now redundant as the dhchap context is
removed after authentication completes.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e6f07c7f76d0..b1f9883ef8e5 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -200,12 +200,6 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
-	/* Reset host response if the hash had been changed */
-	if (chap->hash_id != data->hashid) {
-		kfree(chap->host_response);
-		chap->host_response = NULL;
-	}
-
 	chap->hash_id = data->hashid;
 	chap->hash_len = data->hl;
 	dev_dbg(ctrl->device, "qid %d: selected hash %s\n",
@@ -222,14 +216,6 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
-	/* Clear host and controller key to avoid accidental reuse */
-	kfree_sensitive(chap->host_key);
-	chap->host_key = NULL;
-	chap->host_key_len = 0;
-	kfree_sensitive(chap->ctrl_key);
-	chap->ctrl_key = NULL;
-	chap->ctrl_key_len = 0;
-
 	if (chap->dhgroup_id == data->dhgid &&
 	    (data->dhgid == NVME_AUTH_DHGROUP_NULL || chap->dh_tfm)) {
 		dev_dbg(ctrl->device,
@@ -624,9 +610,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	if (ret) {
 		dev_dbg(ctrl->device,
 			"failed to generate public key, error %d\n", ret);
-		kfree(chap->host_key);
-		chap->host_key = NULL;
-		chap->host_key_len = 0;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
@@ -646,9 +629,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	if (ret) {
 		dev_dbg(ctrl->device,
 			"failed to generate shared secret, error %d\n", ret);
-		kfree_sensitive(chap->sess_key);
-		chap->sess_key = NULL;
-		chap->sess_key_len = 0;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
-- 
2.34.1


