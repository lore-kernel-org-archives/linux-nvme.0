Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC6DC48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 18:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C43613DC
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 18:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C43613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1xkwnUYvGIGK1atKMS+k4bG5aEuQvu8ZvmnRIM7nvo0=; b=hjaQyWUZ9lyW0w
	g/idZ0DgPTzVQ4GI4rozT6ntO9SSsccJM/f8ZC4S8DBGe6Suls2+YrxJj9yuYUjfw5mXq4DqmZ4VC
	KiSKXCLWGNtDvofGhNOG9yxuhnNRyjejB2uKXWgYtOK87P4iBwL1z+42prQLFODUnm+jGI/eFp6DC
	oKMY1BRxbC6FQOOsFvkEZN399kvC8XZpWcWkMrpdh7DV6PFdvq1cV6T2qFESRrQdT1Hn+BgfBhWBu
	lHaiSFw3eLz0usMW1fjyX3pUANR/4i9oG3IpPtR1/OOR/lDhlO/Nu1sF+KDJph5h5KgMzblrfimY3
	XhCVV4heX7/50co9k7wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr3BS-00FZfP-Ao; Wed, 09 Jun 2021 18:44:10 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr3BP-00FZeZ-9P
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 18:44:08 +0000
Received: by mail-wr1-x42b.google.com with SMTP id e11so16400847wrg.3
 for <linux-nvme@lists.infradead.org>; Wed, 09 Jun 2021 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=/OeoAGy1A3IEy3Gj7xVoOV+pgm3ejfFP6M33G2/qTsw=;
 b=pkyiwUcWdl2NTbfay2RmnndJmbGNmeF/TpRKXQlrM09uMItjvBrIuMW/yqfZXL6Zfj
 mWuImxuPnqlTYVHPBD5Zy6AAT/yXeXsJ3b/roRx448bStXeICJnt6cywkf/QblOyUwls
 tuLyNqScuMyfa+jJOHqL49vjyZ8UMTLs8a2nZu2G42tA5sQOsIr018nRTrTIJ88oyjRt
 wmLwn1OFIyLeJJKsiM/NGTkIjA7fmuh3e7ZleCZLQwtYF6JxYXOTWZiMR08kRvbja9UZ
 uCSQT1W16VwadtXZuZtPckPedy3bX3MgHMxglkSuHtDIlGl9Gn4blMIpe4I5fOGm9XAq
 RRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=/OeoAGy1A3IEy3Gj7xVoOV+pgm3ejfFP6M33G2/qTsw=;
 b=aOn4ZYD6ydvzxHxqq4nipW1ghVjDG4LA26jrSqH8TLzsN4AVpX764SapYDG52k2bQp
 QM84nU9yL9j7dV/Vp7zg67bkpB3U9zqLHMI1Syl0Wj57yX2OQH6bgKH5Z9bc/I0XNct+
 lD/6MbsiEmJK3EhzqHEpnLIZucsZ1bWBmJcKEftXHKseSiZ6SqGvW3O7JEjslKj69i2z
 csmX4GN2YOz6AGAeHYmVmLjSPaFl5j3BkzPoT4+e5Y1m7Lk50JeWLKZceFCCyj3iYU+l
 to9pJBXb+c4AlmevdXeBIZL7dq4XlWx162PnivljNQb1Giaj44y0cGes416zNW70qsMy
 CHTw==
X-Gm-Message-State: AOAM532nskly/M4H/l3C/RAjfj1oyrGWnsWmDyNy3VjcTmHayf+oKfNU
 5P4Vm8beUAmwkhar493rUm4=
X-Google-Smtp-Source: ABdhPJyqUYDNMxAjgCCKsq5G3Vq3A3JYH+56SAGroHWV29UQhmfk99mYGfD+gkI2OWijT1G7x88U/Q==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr1224843wrc.226.1623264244284; 
 Wed, 09 Jun 2021 11:44:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:3800:a9b1:fb24:eb4f:c8ac?
 (p200300ea8f293800a9b1fb24eb4fc8ac.dip0.t-ipconnect.de.
 [2003:ea:8f29:3800:a9b1:fb24:eb4f:c8ac])
 by smtp.googlemail.com with ESMTPSA id x18sm794930wrw.19.2021.06.09.11.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 11:44:03 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Subject: linux-next: NVME using PCI legacy interrupts only
Message-ID: <52371274-20bc-a150-a3ed-ba3e1305ad3e@gmail.com>
Date: Wed, 9 Jun 2021 20:43:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_114407_362894_99B4931A 
X-CRM114-Status: GOOD (  13.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I found that on linux-next from June 8th my nvme disk is using legacy
interrupts only. Some debugging lead me to irq_find_mapping() in
msi_domain_alloc() returning -EEXIST.

The nvme core first allocates a MSI-X interrupt for setup purposes
and later frees it and allocates the final number of MSI-X interrupts.

The following experimental change brought back the MSI-X interrupts.
This makes me think that somehow freeing a MSI-X interrupt doesn't
free it completely. I didn't see this behavior a few days ago,
therefore I think it's related to the recent changes to
irqdomain/genirq.

Didn't do a bisect yet, maybe you have an idea already.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b17070..8cc600819 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2381,7 +2381,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
         * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
         * adjust this later.
         */
-       result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+       result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
        if (result < 0)
                return result;



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
