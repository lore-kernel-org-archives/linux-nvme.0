Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14085C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U4Z5Jx5jSDqapmBfICcwqgCAhJ/Eu8f9VkZfNSzqSxk=; b=uhZS0aIn9bNyJJC61LoWcbts1c
	KB246HZaWdF9wKtLC7+05u8INAVTPlS1hmTQ2zblkmIzufR3O4mPqSbvRhnX0qv64q+yDDp1cR/2Z
	1TfU97QoNqiBtdUjOOdGh4YohCzuEeIIfRt+hp0pgokVNoinAnnfWvNsGx+oJmWxGt1qFRICfSnmO
	j+WsRL0fZNzhqvbc/pMpQSOggDkNO8nyr8hjg7aZsQaQg5I4DkA24yeYRa/hL5bDy2U9cL9CO7ZCe
	C8xbxzr5sKl8reXUfzBDGKx2YbVENY01l2DzMts153qVy4eV042K2JVAXddEDVylG7iVugk6kRlqW
	EvHScafw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov8wF-00GiRF-7A; Wed, 16 Nov 2022 03:18:11 +0000
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov8wB-00GiQ0-O7
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 03:18:10 +0000
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13b23e29e36so18629041fac.8
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 19:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4Z5Jx5jSDqapmBfICcwqgCAhJ/Eu8f9VkZfNSzqSxk=;
        b=e03KKfYWggNEz/9DWg+mSCQj4mr86dWqeuMBrN9WfsudhzOCLOEhtsTrCahn0EF9M2
         8Oxuls/Y5tmd1aZh2sHTT9oAhVUKu9r0RSakSyqNRfW95XYaftpb370FsCnDxcJdToHR
         Tbr1KlrAYU3IpulI9CbQbpH9VfzCLtX5/hg2dRhSnxWPm0Np2UlLJLNQat0rhHFDY+nw
         vn+d4mZCNhjxkxtr7+pxAlWs7KaH1detBh+WpJLiRosepOMuPZZCznJVI3G9Sl8HiTgN
         l39/+tuZZUYVF9hAagWSZGt96iqEikaMbsjU+0m14Y5EDM4iy5T24fC56vq1uEtb8iOq
         g/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4Z5Jx5jSDqapmBfICcwqgCAhJ/Eu8f9VkZfNSzqSxk=;
        b=narrRs0iOx7xCvUZoppgVMU99MnqLti/qO18fmJSYrRhIWJU8E/lHg5NMtnrY0MGC2
         HdcGMOgN3mg0NKTC91NWCj0hT5Rbsg3b/r07+QNBssR/zm7w4KqV5mKzqIRyY5OW5jVQ
         5LFoD+1ZHukd4ZlltEDkCymh3KERR67nrcBAffZUaS3gO/98Gn+BRC8SF4h5XxJ99xXb
         pOIJinLQQ3ndcBnBVIwqgdZEszByAQNi9PgGaIE6QhhG5S8/FihmmZN/edGsTyQp2MRx
         oXK3KVluaFSDRox6DbPJ50NsQxJJH6gV0Y3FEPYci6e0mzbd6oZktdMFxzuXWFRjR6ol
         WD5w==
X-Gm-Message-State: ANoB5pkq94xfj0iOnkW6cXgEX+Bhiwla7Lz3nxvKgDR/klqsBo3YM2Xb
	rAbJAhXIta9VLOkI4QWb/HAHPUvlQCM9UA==
X-Google-Smtp-Source: AA0mqf7QWkvwlPE8V8FZCZxZWymPpW+ObYGR7uDeOuNYIuMqQkUYqQcNr4UU7twmHwv7ijrjgO01YA==
X-Received: by 2002:a05:6870:888d:b0:13d:6f6d:781d with SMTP id m13-20020a056870888d00b0013d6f6d781dmr743283oam.126.1668568681822;
        Tue, 15 Nov 2022 19:18:01 -0800 (PST)
Received: from tiag1.localhost ([24.152.82.85])
        by smtp.gmail.com with ESMTPSA id n10-20020a4ac70a000000b0049f07909c5fsm5605791ooq.3.2022.11.15.19.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:18:01 -0800 (PST)
From: Tiago Dias Ferreira <tiagodfer@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hch@infradead.org,
	Tiago Dias Ferreira <tiagodfer@gmail.com>
Subject: [PATCH] Add quirk for Netac NV7000 NVMe SSD.
Date: Wed, 16 Nov 2022 00:17:56 -0300
Message-Id: <20221116031756.4987-1-tiagodfer@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_191807_799805_06B39777 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Tiago Dias Ferreira <tiagodfer@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 02b5578773a1..b7212344bb67 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3519,6 +3519,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-- 
2.38.1


