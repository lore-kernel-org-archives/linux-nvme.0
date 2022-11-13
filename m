Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B2C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HvOVmI+rRg1DIoeidXjfukKqY0EVa8OlHtvbl43oUjQ=; b=aefavwMAzKw0BGtzvGirqviz5w
	fsnHejiIUh457XvCT6yO93DGTCm/mSAA7wUPM/u/cdUzi5Q1qrs0HP4OivDUy85FjD/6YfN8Cccbp
	Dq12Ga27ioQvFUVn3jJttkWZav6YDmHInKbfy/59HZ80mvvhO6LfciOTvEC2T6dz2DwCWXUPsAMk6
	gAeeCTyxhNe1+6Lidqws3iyDLGlVwTPvOMBYUhADKHCakyTQXkkD5UI1R9qW3evSkJbWPLmVAN6sV
	f8wfZ2xNdIiDXrsw4EqN1I8rlZVLOgr1j63XbsZI5a1RrUBxZUSm8Z747IBjpG+4EFxl+Vs+kOFOf
	XTJcn3Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6r-00B6ev-Ic; Sun, 13 Nov 2022 11:25:09 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6K-00B6Oc-Im
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:37 +0000
Received: by mail-wr1-f44.google.com with SMTP id z14so12388947wrn.7
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvOVmI+rRg1DIoeidXjfukKqY0EVa8OlHtvbl43oUjQ=;
        b=uVRleTsXpRrO5vz8rp+zwz53e6HoYSWKOKgReqZ48IPSvvvPLyDwNg8sDcucItyalJ
         TikIUkRzAowbyIiQWjqkOGuf0/IPiu6uxsz4fO/VfnNfr0ilWMjie79uGYibpT7RQZkp
         OgLDods1DlKTUs476IiO+dERVNwDBgnoBeune57w+p1ZNQ0RuVEwU1J/4Ani5xWgxO0v
         w3uT1GciDLKhqXbCcHIq2apLA+3Zk9XWmRsGYGl+pSxNf0QRWKmMD5MlMeMalvj3Gawg
         /skCNUiZjj1AEU+jIK4GivnDzoHtwxpUJwffegVLGEwSW8iyvnaxOD1qSQ97ApF/a4GM
         vRzQ==
X-Gm-Message-State: ANoB5plfiukOn3FtDuXRKgTzab/EjCJqD8Wf5781mNPzKbMSYbcelnle
	Cm4X9qjcNDHSr3t+7OvMoUA7YyYLv5w=
X-Google-Smtp-Source: AA0mqf47sxmVaVIgmWHOD6j+YBiuHeCsJLCNzBfSEQlqBN4sdr/Yfi1G+oAr1qH5T7T0Q7z3t3CHVQ==
X-Received: by 2002:a5d:68d0:0:b0:236:74c5:1b2d with SMTP id p16-20020a5d68d0000000b0023674c51b2dmr5054863wrw.14.1668338675224;
        Sun, 13 Nov 2022 03:24:35 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:34 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 07/20] nvme-auth: don't override ctrl keys before validation
Date: Sun, 13 Nov 2022 13:24:11 +0200
Message-Id: <20221113112424.1049834-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032436_640509_34C0E893 
X-CRM114-Status: GOOD (  11.91  )
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

Replace ctrl ctrl_key/host_key only after nvme_auth_generate_key is successful.
Also, this fixes a bug where the keys are leaked.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f3513938f94..f2ae4ae33d68 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3745,13 +3745,17 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		struct nvme_dhchap_key *key, *host_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
+		host_key = ctrl->host_key;
+		ctrl->host_key = key;
+		nvme_auth_free_key(host_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
@@ -3795,13 +3799,17 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		struct nvme_dhchap_key *key, *ctrl_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
+		ctrl_key = ctrl->ctrl_key;
+		ctrl->ctrl_key = key;
+		nvme_auth_free_key(ctrl_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
-- 
2.34.1


