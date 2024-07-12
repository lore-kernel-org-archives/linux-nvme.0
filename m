Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC29C3DA4B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VghSScXg0SnQ65hjRgRRdsd386IPCF3v3rBLbMWrDA4=; b=KxXpSeDIT6V8+xk/tIReDtA8+K
	dK77JItd0PSB7lzhcExJifkx3jtrr/VSOF1KfNowpXyNkrYcvhjjXNPsBYV3ak8j7nCXcFnQGsqa0
	fiumT5BRXYYvMKu2JEu1uZxfzl1AeKaxAax29FVE4W6JCxjX+64SKRn7oa9YeDvzfXJIdURBXRYWX
	fR5WRyrx7CdY9F1Yx1bL+wPPeim9FzLd8Nj5D0g9VxdO++Koy/2irUELjwvapoXVAB9TL2o850+pq
	GtowpHK0Ql46vL2nB4DE1fWr5NQaephgEgE/+kFIjnMiWBXSGOXPR8pn76qsGDKmPwtjYYd1Uj/Ou
	r8bf8VuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSGtn-00000000G2j-2QLf;
	Fri, 12 Jul 2024 14:05:23 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSGtU-00000000Fy3-1JFf
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 14:05:05 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-7035b2947a4so1104260a34.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Jul 2024 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793102; x=1721397902; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VghSScXg0SnQ65hjRgRRdsd386IPCF3v3rBLbMWrDA4=;
        b=M4lUJzgnGSFtlMuTdH399rbnaG4ZnIcCvlRSI3P+ruHgklgs1pHxFb7zwV85ApIMLl
         t0J/4r/quTNdhEizsR5IMfWC4e9aWnR347+1GI7MhW3SK8jR0GDshxG6yeOSQyjms44W
         YmKYojyHZLt9bNida9B0GL2vrQv8rSU/RIRPvtMpriXJI7vULmmCxh7mVM8Q6bAV/ep2
         HMkdBEDV96OSr+K6P4rWiECen7dq3W30ZuYns5/kqZfPKccQ1JhtQhU6/+FhQB5cHXVK
         9lMBW1qStNmsNnXMxlFUL1WmD8fzdM8es3DQdZKbQa6XYcLqMCaeoG5jXDis2VxPUQmC
         GhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793102; x=1721397902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VghSScXg0SnQ65hjRgRRdsd386IPCF3v3rBLbMWrDA4=;
        b=nbHQSnfSnQHAh1Hr66QbY4PfH/N14FVbIjIhHQCqZVSCQc/v9i/4UzqIySr1NlIoYf
         LbsiQB2TCHFdj3CtFZ4hSxptmrCrXDYYSVx4+fS2C6WkWXTlMplpF8uuEzYrMsuHtMEo
         gLGGILSEmCaOIWhzDo9QC9DkLagMRbRqOwivATASQQzTigGjXzJ1qKXK4SJdExYSC15C
         IFkWaJxSM7tBolKI109Oq4wt28Z3PY54JNoH/e7DM1Ja4OtRB51p993khGTHSOL3pKuD
         qaZhnd4WZKdSzNtsrwdWunZRTACmWMUzPsqeXh0Q4lzrZUUlqiTI8Iml6lFM0t/DsZ8b
         gnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD60+mrDsF37ZQCYuWsVeUfTp51oq3AlimnaBhgaFyF9T3yr/wAsz5/oojsf67VUuPqdhR9lzdEQAmKD2hpP+2u2C4ePOjOY8KlT0FWO8=
X-Gm-Message-State: AOJu0YzcaZgNl02jpYKRjAPJks8lwIsnywqNpA9YGYAlQ7ONkTe6ebvs
	ih8SwkO0isCQHwuMdi2LxXw2JoUfOjvpZHqgh4a3sqFJYnO8Rsdigkvtt0piA+c=
X-Google-Smtp-Source: AGHT+IFA0p4jpx4ZTZg5gSmdCsyYovFZ3XvuMQom8jLmz1vaX/2ViXszD44aiF1MHSHh4j1LYznztQ==
X-Received: by 2002:a9d:759a:0:b0:703:7a17:f267 with SMTP id 46e09a7af769-7037a17f53dmr12708239a34.26.1720793102310;
        Fri, 12 Jul 2024 07:05:02 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70559902e6esm847390a34.35.2024.07.12.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:05:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:04:59 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme: apple: remove some dead code
Message-ID: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_070504_380722_724B17B5 
X-CRM114-Status: GOOD (  12.26  )
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

platform_get_irq() never returns zero so we can remove his dead code.
Checking for zero is a historical artifact from over ten years ago.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/host/apple.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1387dc459a3..f5a3a4e8b1e5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1417,10 +1417,6 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 		ret = anv->irq;
 		goto put_dev;
 	}
-	if (!anv->irq) {
-		ret = -ENXIO;
-		goto put_dev;
-	}
 
 	anv->mmio_coproc = devm_platform_ioremap_resource_byname(pdev, "ans");
 	if (IS_ERR(anv->mmio_coproc)) {
-- 
2.43.0


