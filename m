Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467B7C982D0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JlHGMGQLKjtkoZ20RXH6pvWI6WX3arGtBMs1RNDDLiE=; b=zb8AF8MhMSXtL3h41aDn7tFFc8
	Q+DQfwF9+pxsxymQFSpbqNXEwlcYluJT10sMx8Ckyq7Tt86vBQX0GK0a0qaP/P+zqaSUZWqYCG7VA
	lGHrHEA2UC79F3c2AvaNZ4slatElhTV5NikdQCW5tiz1wblEzE33DlltNbTk/ZwEnipYo5tBm1Frm
	XIL6vNllwvULXXOflg/hWiSLv4hfd7p9Ixi4cMC1F0/lHGUgpz2H2CgezjvQYIl3cjd0pvLHbdmdu
	0pVh6r90JvK4Si8KFHjyg3n7ccmycBdds3gNTQkk4NKKL693iAG6C2nINZb+zQsf5wxhYfaBtJh14
	Y9+8eQ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x777f-0000000Aqb7-3xBt;
	Thu, 17 Sep 2026 08:05:35 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x777e-0000000Aqal-2SdZ
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:05:35 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccc02279so453512a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2026 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789632333; x=1790237133; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlHGMGQLKjtkoZ20RXH6pvWI6WX3arGtBMs1RNDDLiE=;
        b=qu2n9NcASUkXf4p8UOJjpO//+NatVhGFmlL9XQX4j/BWi041Xp60V/xTBFCjErg3uB
         HHvYCNnDFmytH/O+CZJysLyp+0LfiBfu0zyGFgnS4tGAF6nS/3p1egL/ddcePx5UQSQB
         uF8pkcCCnNNyIcoArNUkpIqORsPdzAaiCyy0YvN8GJsMV21Uet8sTglqBldR3MXVtCwK
         JsDaoFKpg5MrNNLlidGu/74XbZSFb3fK7w4HY1yyKqSl9aaBPlpU/4y20cCxtUhM/pvH
         56Rbx1TdVymz5ZOCpRMlXfVeNlEv8dnhuMcDkIYdHtdQQBJShPimn/gg8gCDhjjIsfGv
         8Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632333; x=1790237133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlHGMGQLKjtkoZ20RXH6pvWI6WX3arGtBMs1RNDDLiE=;
        b=tTBt42wHsHdheUGEiw7IzImOSbomaRj5VXMFmTmtIJaXVD1j5MoEP+YHVA/88NmCFS
         BHzbZLoIlJ7XUtRNPheNjj+VIq1GYPbNjphIVBq6ADrfp2WfFk+47hFZkTKDqZW58kPP
         q9+3nz6Z6hImL6FoK4kylONMRe0p4Nl52/SMgv0Um79O+hNuAjdzuRMx6sHL2r5KKiDe
         EeM8HG2RfSoaYjZy5lv0HCPNOznYzNM7WWghYU/CYOBErMyRbkHRDqVinLPzXE2dst1o
         iDYhIKQy5r6Rg+4VpJatHjUlEEmwSBcnDz4OuOWzOCAPResqJdbxznrYynWtvZ2XH5n5
         E//Q==
X-Gm-Message-State: AFuF++mexPWux0yFlcZeEw121SCA4xoGJpV/kyUve8McWVvuZMJ5HFgN
	nThVDELl/ecZ+Z0tIXTojCfkuTrLbkuGJYELZbK9ofJSnpl3xnlnpWBm
X-Gm-Gg: AYBFou31MiErmeNaWWekz9JsbPs3na4fgNzku425ZMePZRn2Dg1rePfgjyNQlbwRqnL
	hRGFH3oDEWNGGLhbhHuwClxhz6WqTp59apYm9xy8HkWdaxld4rddbd5MQazdNihQR+ZfAsgKhyL
	t4OgA6rb++6u3/y9NPKB121cRUIpdpLBqKtNiAXAj7TNWtKqO6JAtqirJDNN0SFFa2w7AUoUqeC
	Yqm0ogAmWhLRMZ1GHogL4fgZruh5d5D3cBNz6bVQlBiiSBp3vFaaQ/EspGnAjs2T9flSBGJ6uMi
	hMwJIFvIPQyCsLIbyoCLVEfgpVJW8zIQXnODccJ3LvjdhQbyVkC7WKyo5YT6k6jmPM7PoGmcmzO
	m3Ze12sSOskfsegn7drGGp3MWDgvSHTrvqj4mn0mTXZW4kXPw+iXqxU8Xaw7oNdttkLNYDInqx0
	k5ij2Yy6SlxQobVz98ijisl2xps5EanpX6lvtWrnkx16xr7Hc4KGafCi7gGvU3Jz0tVEL38I11y
	9OTB7+tHPOz/puUhbxHJg==
X-Received: by 2002:a17:90a:a88:b0:39e:24ab:9f82 with SMTP id 98e67ed59e1d1-39e24aba6abmr6998190a91.10.1789632333162;
        Thu, 17 Sep 2026 01:05:33 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c13f09408sm2723056eec.7.2026.09.17.01.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:05:32 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] nvme: auth: validate DHCHAP secret before stopping authentication
Date: Thu, 17 Sep 2026 08:04:24 +0000
Message-ID: <20260917080424.3544-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_010534_647110_CF5555E2 
X-CRM114-Status: GOOD (  12.80  )
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

The driver currently calls nvme_auth_stop() before checking if the new
secret key is valid. If a bad key is passed through sysfs, the key
parser fails and exits early.

Since nvme_auth_stop() was already called, the current authentication
session gets stopped. However, because the parser failed, the work
thread is never restarted. This leaves the NVMe controller stuck in a
stopped state until someone writes a valid key.

Fix this by validating the key before stopping authentication. If the
key is invalid, return an error immediately and leave the running state
machine untouched.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/host/sysfs.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 02a2490a9ed7..d6512b19752d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -825,7 +825,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvme_dhchap_key *key = NULL;
 	char *dhchap_secret;
+	int ret;
 
 	if (!ctrl->opts->dhchap_secret)
 		return -EINVAL;
@@ -838,16 +840,17 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	if (!dhchap_secret)
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, count);
-	nvme_auth_stop(ctrl);
+
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
-		int ret;
+		struct nvme_dhchap_key *host_key;
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
 			kfree(dhchap_secret);
 			return ret;
 		}
+
+		nvme_auth_stop(ctrl);
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -855,8 +858,11 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
-	} else
+	} else {
+		nvme_auth_stop(ctrl);
 		kfree(dhchap_secret);
+	}
+
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -883,7 +889,9 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvme_dhchap_key *key = NULL;
 	char *dhchap_secret;
+	int ret;
 
 	if (!ctrl->opts->dhchap_ctrl_secret)
 		return -EINVAL;
@@ -896,16 +904,17 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	if (!dhchap_secret)
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, count);
-	nvme_auth_stop(ctrl);
+
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
+		struct nvme_dhchap_key *ctrl_key;
 
 		ret = nvme_auth_parse_key(dhchap_secret, &key);
 		if (ret) {
 			kfree(dhchap_secret);
 			return ret;
 		}
+
+		nvme_auth_stop(ctrl);
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
@@ -913,8 +922,11 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
-	} else
+	} else {
+		nvme_auth_stop(ctrl);
 		kfree(dhchap_secret);
+	}
+
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.54.0


