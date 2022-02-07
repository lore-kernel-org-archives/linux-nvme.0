Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B88C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=STukwnHLJ5JlQRTYdPROsCoSZDqNrbFLjrqiynzZIGo=; b=j+Uz9620UJDbJmgN58QVklSDVV
	tPcFlsZzY3z8fYaMGAEO9NwpF3WdydORqNN47ClDrJmBffIXQfIGHJq3TQTLX0OXhfX7Jo0bltipH
	y9sJMdPypZq/WVzH/7Ivn4K8oJyGmj8tAw+aR9lmY5WhmbrInAcIUUanwp16g8RZTQUWiKZYMAAQ4
	WPHMHGXuSNCYAU5pStR37XG/6OOphUDsdqb2pqIlgRypGd2KHJ66F/fIFsKtGKFi76weu6vudzprL
	+5z5SMdJws/1RVQjlBSJWYKjvgb4xLaF6+LUeYslOvxTR4xBAVD7IHC5S3gmo1Ir1hiJqRiYYezQV
	d7GXDRRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHDQi-00ByBJ-W7; Mon, 07 Feb 2022 23:28:21 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHDQf-00ByAC-On
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 23:28:18 +0000
Received: by mail-ed1-x536.google.com with SMTP id da4so11588120edb.4
 for <linux-nvme@lists.infradead.org>; Mon, 07 Feb 2022 15:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=STukwnHLJ5JlQRTYdPROsCoSZDqNrbFLjrqiynzZIGo=;
 b=V1LxTsspX/2KvteenHDf18lalZxHNEVBq4cfehyDGPcEMldBsF1aN+NyubcTrnYnZP
 grCXV5UnY7xQB3Yf4Pbs77nsnZDwdkrh4g3rHHu7AFYi20uhNplepumFGBZa+phjsarp
 Y+z9CZ9nxLRzdcqOq80GxU85D0BQTw5NaiCUXxhE70ABGJiPv8slPFiW0XA3opcK4Pm+
 eoUs+lyeDd6OabER4VzIqTzv7h5UKHhnYCrWzSYkpTZVdI3UmnsBi5tYnbgT5RpDTfyx
 yxRpg3fyXDz1likmSTgfNhK4gortG49lQ1p48V/9Kiq5qujXRLFoLg1Cfe4cdBCc/rPy
 mY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=STukwnHLJ5JlQRTYdPROsCoSZDqNrbFLjrqiynzZIGo=;
 b=3TwFdlpjw6npusvce+LGExhN1T49aDIQhLTtnPg/596/aV786/QJobPsYsAN9UUpuY
 lif8vZP98beg1nMMOc1CcWQcB6szOoGEUZ3Nca7DNMpRDqaT+YSzpZtnsl0B+0csR20U
 mc4tG7ArYJRDCIVfvLJpaqohHsd3a262F2bzmcDSA8E8l1ggwsS4L3oKquw6h5nwgNdR
 v97VTsdWjrG7sSuce438jEZXSda1X1yVx0fwRH/XUOiiEU483ZMf27ZQkjRI8FXL+3z9
 DVWz4pCMrHLuLfFHHncV3cSldYvcWqhusw4GlvX0qGhPeCU5Fz1IkkIfB9duyOzERws8
 Lydw==
X-Gm-Message-State: AOAM533UoUVN56I3i1VkwQSd/Oyt6Tj4CscdOei0Yz+JuNQKKgxZkHs5
 0J5zDVUqTSEAc1+/13zoSI8=
X-Google-Smtp-Source: ABdhPJxFIkBlfI0ZUVxiZnz5qy93KNnZAceYCmxedK9MI9MRjx1vOEdwSVgvmh6jaNA4WY4bL0LTxw==
X-Received: by 2002:aa7:dd15:: with SMTP id i21mr1759125edv.198.1644276495213; 
 Mon, 07 Feb 2022 15:28:15 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip
 (p200300c58721e9801b2c6bc4bf3c75fd.dip0.t-ipconnect.de.
 [2003:c5:8721:e980:1b2c:6bc4:bf3c:75fd])
 by smtp.gmail.com with ESMTPSA id j12sm1776765ejc.83.2022.02.07.15.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 15:28:14 -0800 (PST)
From: Bean Huo <huobean@gmail.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	beanhuo@micron.com
Subject: [PATCH] nvme: add nvme_complete_req tracepoint for batched completion
Date: Tue,  8 Feb 2022 00:28:06 +0100
Message-Id: <20220207232806.411801-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_152817_824260_CA86876B 
X-CRM114-Status: GOOD (  10.23  )
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

From: Bean Huo <beanhuo@micron.com>

Add NVMe request completion trace in nvme_complete_batch_req() because
nvme:nvme_complete_req tracepoint is missing in case of request batched
completion.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..eaf0b18ff29e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -368,6 +368,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_complete_batch_req(struct request *req)
 {
+	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 	nvme_end_req_zoned(req);
 }
-- 
2.25.1


