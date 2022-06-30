Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E479C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 00:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xHLzqhdmSUC5xgvu9G6wjC9oEMAIsHrvQ9mzkeyVhJ0=; b=cul8M83ELlzaItWNWrJMMUY4Yc
	Woxln92qjxNU/rIICY6WswB5d+Nt66FmDgpOmi3gCpApsy9Rs//+maJr3+TnFovccZC6tvCjXWNkE
	7NGymXCae/3kZSV8mhUQ48aX2tZ6M9WhVbgdrSDzMMaxcXjSn5yZfDwnh7CR3BVSqT0v0N4hZW51P
	to/MdF0+hymtF3tOrwrZubtmc2LMSdH2FQRuJIkH9glrIZQS+qp890+IDmJINoW3BLRIHqOaSLQ5c
	2KVaUVSkxoFEIGW4oOuu/Mie3Rs3ZYFrZCvlqpTwiQayKhvK33lrtWir4SEymm70UtDqkOE9Pp6En
	9Ek5XDDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6i5E-00EYKq-Fu; Thu, 30 Jun 2022 00:31:00 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6i5C-00EYKM-5v
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 00:30:59 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101b4f9e825so23689920fac.5
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jun 2022 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=petrosoftdesign-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=xHLzqhdmSUC5xgvu9G6wjC9oEMAIsHrvQ9mzkeyVhJ0=;
        b=V4x/Mm5KjUhgkQmZdK7BsfH6d7MKb1MZxtZEWm6ueyM6bjEs1eFRd6itwRR+fvADJV
         fKALHmhK7DA1fHRbrrvRe3tZbF30MzG4mOF/+0h3LnNiSaXAIB8tsS3a9aK/IDet6TZV
         KUsxG0bsVeBXYg7wFse/DJ9lMrZYVnPA5hJtLvU5UqkLGIGZggA4DvhvtPFyO05b+83N
         UNxc67SPuZkm82oEhCgOou5JVAFPzrT6zIplx+dh+z19nZdV/zlmzir9BYy2hQVJMBt+
         CPmgvsNqUf9CphbZMFQNwQ85TloB0emHyygnCfdl49u1vYED2wA6I0zkYn0cIDhyFGW/
         Sjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=xHLzqhdmSUC5xgvu9G6wjC9oEMAIsHrvQ9mzkeyVhJ0=;
        b=HAsckW28BSBsI94N1XMhDQATQSnuh2VgKeShtqQvl2s1WZYy3+R2AQbqsGn+d3TZgo
         e8WzkU6q5k5iOlLaKgafwGQZCbcJq1QeKyLFe/bRgK4Xk2HpCC5O/2GGbYTg/mIOKzqy
         f1XoY0Chzzullg/gc5ieAm1I73tBdcql5qujvD6v7mgLgB9dYtAPsqqTQIK95n3vJYO6
         uvKdGJXpV9SWPqskQuNczCKZeDDB2JPH23HevuCBQG1x8PIk90XSP5y3KOyrhxSLm1z8
         G9pfgGlUqYbpa+U6DBmmSdgZqXG0R4AEpCSHlXklW48K8/6L1hfsndKW/0FRGjwm0kRu
         WRzQ==
X-Gm-Message-State: AJIora9MQVpmY0+chld3MUvZJ2zYcht5nhZcq0cup7ugqH4o4qokwaBg
	7xSekRXVVetdqDHIrcvCRXydpDREgwFm7Q/T
X-Google-Smtp-Source: AGRyM1u2TZN/E7EDukx5tWLXoQloiPbaf57XOuS1pfpzdYH5W/9Ar6s0IOmw0X4W4h5xIU4vT9AqHQ==
X-Received: by 2002:a05:6870:4708:b0:e6:134b:1b04 with SMTP id b8-20020a056870470800b000e6134b1b04mr4670843oaq.85.1656549055720;
        Wed, 29 Jun 2022 17:30:55 -0700 (PDT)
Received: from evolucao.localdomain ([177.70.93.142])
        by smtp.gmail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm10538885ote.9.2022.06.29.17.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:30:55 -0700 (PDT)
Received: from localhost (evolucao.localdomain [127.0.0.1])
	by evolucao.localdomain (Postfix) with ESMTP id C2D412FC00C7;
	Wed, 29 Jun 2022 21:30:53 -0300 (-03)
Date: Wed, 29 Jun 2022 21:30:53 -0300 (-03)
From: Lamarque Vieira Souza <lamarque@petrosoftdesign.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1
Message-ID: <d4c05d27-841-fe67-9b1b-7be98799d59f@petrosoftdesign.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-224739264-1656549053=:16991"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_173058_570699_0C62E1A2 
X-CRM114-Status: GOOD (  12.47  )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-224739264-1656549053=:16991
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

ADATA IM2P33F8ABR1 reports bogus eui64 values that appear to be the same
across all drives. Quirk them out so they are not marked as "non globally
unique" duplicates.

Co-developed-by: Felipe de Jesus Araujo da Conceição <felipe.conceicao@petrosoftdesign.com>
Signed-off-by: Felipe de Jesus Araujo da Conceição <felipe.conceicao@petrosoftdesign.com>
Signed-off-by: Lamarque V. Souza <lamarque.souza@petrosoftdesign.com>

Cc: stable@vger.kernel.org
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7b24ee17285..0c7494ac3ca2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3469,6 +3469,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1cc1, 0x33f8),   /* ADATA IM2P33F8ABR1 1 TB */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
-- 
2.31.1

--8323328-224739264-1656549053=:16991--

