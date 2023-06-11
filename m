Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D4EC77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jun 2023 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G4F42X28cPOOOe2ZAcaL8nHvp5WVPsAhFgmUSvRppkM=; b=V1AjN5EPLpVBPY3zZ40BmG5k1Q
	lqjcjnaPnEN29/SfE0dv3FTFGYuvbOSFWKLqfs2zWuNgRJkLVK57VTuklg9xZrZMAv9bGoo00cHRE
	vf4G9K7Ax2wqRSDdRdc76B+kcYCJcZToLtCwPs9+e+L3CtWJdYFjRBGBpS+C6W81/Y+AQEyBC3DXt
	jFMZecmZFMXoDOZfbQEdP6NZ0+tPtHJQezZX6S8lYJB9s6WNiukAigPk2fJXcUibwpOq4zueEHQUe
	a2Uu/r2iptsxPZ8z8ucaeZepRemD4U7KZof71ocgcG6B6PumPMRCyaAchz7dYBHkwfkXMFivS3EZK
	3XnHB8Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8JS8-000nZI-01;
	Sun, 11 Jun 2023 11:41:48 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8JS5-000nYY-05
	for linux-nvme@lists.infradead.org;
	Sun, 11 Jun 2023 11:41:46 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso4700571a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 11 Jun 2023 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686483701; x=1689075701;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4F42X28cPOOOe2ZAcaL8nHvp5WVPsAhFgmUSvRppkM=;
        b=M9PRMX2XRt9dtsCQhJsPt9tR1m5I9V0B8MIwNQQ7VI+SGBIa9AVqeTIhK0M6bpDiSb
         nRvYQOX4xatrKjOUNS4wVIO4+8APb+FjocpflVYNWYxFGHIV5dEyUfBSJR/pqpoyCqyh
         0m0G8bKJ6IKNNBd44cqr/zktl2isAQrZyxOJxByQSQ984YvWJul1O7mjVNdA+K/bjpOH
         1nLM0H9UE6G0gqXPIWuYj29ZfPNCCDIjMgKFauR33gQ7TWzy009QrDvXboFlWhIFi569
         4C/uk1bCG9tnfEEb9cjJHtMP8Czoz+6Ow/tfP7PZEaTp0m4zjdE/wquOdIaJZVrYDNfs
         yh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686483701; x=1689075701;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4F42X28cPOOOe2ZAcaL8nHvp5WVPsAhFgmUSvRppkM=;
        b=UugemtVjSlYaskrVdiMzv1YhzqRgm8L7FPYV/ATEi+HrHSLS+OGI6Okz2Iw77CN9Cv
         TFi21mwr4cEo1QTtI0D6qhzgIs66+tdcyQOpLR2ihBHPT5Re69nw3IvZIBgsxnNA1WAy
         g2GtTVTynAriNS9qzUtfu6/XnmeEiIKf2nTUjkvy/XWYEZz/po5pfKXmXRrKuJZ1y2X5
         YjHAsQHFcF7Yt1bnyriH5rxJfEo3zULgNXKR1o8mxc5sD+1CXJgUiAtW0TawZjq3Z/va
         BnEiBUdaSXGTN7UVelteSU3rACnC34zBQRRWMWkwE9GVA1KRHsQZts5QZGZTZ2rbJpzq
         kKhQ==
X-Gm-Message-State: AC+VfDzBFQhG3J8NzADC4f4ja0wskjrJD9YueI4JpXm7m81So944pSSX
	YdK0C0EaiExMpkdIwL7d55I=
X-Google-Smtp-Source: ACHHUZ7PoiVe7AbBq40hxFbakP4HF1ARLZGu43MozI4Fcmp73CNEaRCdXbh/WgW0zF2kawniy8Ek3w==
X-Received: by 2002:a17:906:58d2:b0:96f:f19b:887a with SMTP id e18-20020a17090658d200b0096ff19b887amr7230557ejs.56.1686483700663;
        Sun, 11 Jun 2023 04:41:40 -0700 (PDT)
Received: from ?IPV6:2a02:908:825:7380:d41a:eda:b7e2:a0de? ([2a02:908:825:7380:d41a:eda:b7e2:a0de])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906825000b0096ace550467sm3780377ejx.176.2023.06.11.04.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 04:41:40 -0700 (PDT)
Message-ID: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Date: Sun, 11 Jun 2023 13:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
From: Nils Kruse <nilskruse97@gmail.com>
Subject: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_044145_071127_D648CE2B 
X-CRM114-Status: GOOD (  12.46  )
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

Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids 
for disk.

Signed-off-by: Nils Kruse <nilskruse97@gmail.com>
---
  drivers/nvme/host/pci.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60f51155a6d2..de5e4c7e4bc9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3395,7 +3395,8 @@ static const struct pci_device_id nvme_id_table[] = {
      { PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
          .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
      { PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+                NVME_QUIRK_BOGUS_NID, },
      { PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
          .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
      { PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
-- 
2.41.0



