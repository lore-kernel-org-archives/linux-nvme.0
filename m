Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78214C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zJhQUMYCZEmFeAJVf4TYYWzusKGcCiCwl6yCYU1DmkY=; b=1MQjnHfjJVUKqDJvYue8m46Aem
	yhP/lqkyUF2EJrMb0sHu+hR6r5KclJmhfQbtD99VsKtllqHxiY7UvEzaY6R4WaftbALlxmhD/oDv5
	FOz3UBgQ9T1AD/GeK/mRIGfXszzcd9aaqhvw9hVt5xX/JONeNknv1HXejGTcT1SVu9ey2K+E39Kyy
	WWrd5PGZWWWpYir6dz52LqyUS6tp+zs/0ew0tqOoPQ1jVjQPd2sExEclsj9GnaXHRMd/QcwR+PaWH
	Htc9dOIaIuIVIk9B2iVF4jti/paykOZr8iyShEZqmOfc90NYmRV1+kAYF18pBVZhCl1+tFveWqd5f
	wf0kzNsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCLIu-007EHn-UR; Fri, 15 Jul 2022 13:24:24 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCLIo-007EG6-UH
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 13:24:20 +0000
Received: by mail-wm1-x334.google.com with SMTP id b6so2279579wmq.5
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJhQUMYCZEmFeAJVf4TYYWzusKGcCiCwl6yCYU1DmkY=;
        b=lTCwIrTi40aVylTJM0ugG97hRPG08sXGUP/QN1brdfq3yxnZGSmx5Q/jQi/x5SEVZ9
         d69rqOCiOuS3dkNvbolerb+f8/K9qZIrqfC0LMlHQnkYEDBJR5katfwScceaJRDHJ8np
         sDlUo7FE/btrwmbzrSxLpSMzxZMIH6xLAuC2ieJiR3ljj+f0n1RCTQBBw+3qFDWxk2vX
         amrM/VM/S+Tv7DaEAqqcJALDUHkBcCzwwYusndJl1O9UUVdCyVE6Yx1VpeYv+EvXOtWy
         0z9ebp+r2lY4wxxAc6XMLN4mhFlyNgyiD7Tws33bEstvTxWMrl2SwBDbk8BcuMv55Z96
         WzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJhQUMYCZEmFeAJVf4TYYWzusKGcCiCwl6yCYU1DmkY=;
        b=MlxGO1zsfzxmTPR/jQ5Xp7l3HBiouNRz7LLcqrx6iQlN46I2pXWQ9e1Rxj41ufoLEc
         VenJLyFwp3qR4hVVVPDa/gjXHxoCxzH/UeJRL33C1RyrGy7eqUiHOGWOd8GtnbF0SnUU
         dQIx7mQAQMWbCXW3dQ1NDZXaR749D93xVELdNZLtShAmTFL4dj8bY/xlLBMjSo7MYqf5
         +M0t98044vh0m01nByHqZIrPvYrt61uzdj0QCCliikaFcb4yIRSZpKnY6sti8b3xFUA1
         ZX+KfRJtnRa0Qp1dm75Lq2Xj+G/zWYEyqIyAwm46EP5+zPyXu9FHxSiVztczEDxRY5PD
         5l2w==
X-Gm-Message-State: AJIora/GsTKpS96tV4mNkGjLs0Bb/gRkz8euPo9/7OO3gDYqrhj+cLz8
	AZU1Sdk4L+rLJqIwhVLy2vU=
X-Google-Smtp-Source: AGRyM1tmaQIYhbcwqUbI5/O4ZkgdwAVDAQWlsKB3fIw8jJG87a/FlVQrnB/cibtVidZE7ukUvpMpsg==
X-Received: by 2002:a05:600c:19ca:b0:3a1:9897:410e with SMTP id u10-20020a05600c19ca00b003a19897410emr14708128wmq.88.1657891454598;
        Fri, 15 Jul 2022 06:24:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm3823636wrn.69.2022.07.15.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:24:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet-auth: Fix a couple of spelling mistakes
Date: Fri, 15 Jul 2022 14:24:13 +0100
Message-Id: <20220715132413.301017-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_062418_997693_5E63765F 
X-CRM114-Status: GOOD (  11.56  )
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

There are a couple of spelling mistakes in pr_warn and pr_debug messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/common/auth.c | 2 +-
 drivers/nvme/target/auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 0c86ebce59d2..f93d369b8850 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -346,7 +346,7 @@ int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 
 	hmac_name = nvme_auth_hmac_name(hmac_id);
 	if (!hmac_name) {
-		pr_warn("%s: invalid hash algoritm %d\n",
+		pr_warn("%s: invalid hash algorithm %d\n",
 			__func__, hmac_id);
 		ret = -EINVAL;
 		goto out_free_key;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index bf92435c783c..b41c7bbcc436 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -515,7 +515,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					  req->sq->dhchap_skey,
 					  req->sq->dhchap_skey_len);
 	if (ret)
-		pr_debug("failed to compute shared secred, err %d\n", ret);
+		pr_debug("failed to compute shared secret, err %d\n", ret);
 	else
 		pr_debug("%s: shared secret %*ph\n", __func__,
 			 (int)req->sq->dhchap_skey_len,
-- 
2.35.3


