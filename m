Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BDC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F0761492
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 00:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F0761492
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:From:Subject:Mime-Version:Message-Id:Date:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5x7hyLGYa75CQG7pYBgD9PMns3nrGRKDgGNtHLjZQPg=; b=WVCdjAlVjE523TY4sPVcUiG6J9
	hYoionrPfMdGWLWHXUblSdU3s/pMmzdl+SmNWH21ksN8sJWyoTZfa1G2TCoONvc+FmBC8+RqokX4/
	WI5dWuqFRBzKK+p8igeIOzMEGgivb37leXdRJfVo1hrG7RpEnmSBStsbABuHmKSxF+DLZFDnXMPZE
	XnyXtTl8iVWWHQnVAqXGpdQ7rUl4kk1YBB6J8YhD/qVMYrWUrMEvY0FORKgf8cPqokbQOT+PZ8PKi
	6P9GQjwhMNaODEho8K9w/YzQXdKl+SPRtf71QhNmD7SVDSFUDi1r250uJ/bU1oUPPHLn1D2W93FyN
	r9WQ5W2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4vKr-0006FU-99; Thu, 28 Jan 2021 00:38:57 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4vKi-0006Ew-Lm
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 00:38:49 +0000
Received: by mail-pf1-x449.google.com with SMTP id n123so2379668pfn.10
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to;
 bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=ika8x4rgJdL4GFh0YJshUwWatHQjTXQ6jtilrMjzjB5sX9mt0EINzDY8IG5gykxg+V
 gtt0xZreieN+Cl9Zk4vH0z+L75qd0s7an5EkYb64eAua3UBdHun+3RuVtNay74rRmljF
 w5FPFyJlgdiwd0MdSbvafLRju/MC00+cfc/WbLCEtHZUfpqz6G5N0GL3pImWJyq728PK
 YpGO0gtXK2jnCNQoOP//2fEhqOtPi8l/Kif+ts7PTih+MaXF9ASUVT2b7QL1viThPJSu
 nBl/vQz8MYZ+b63p0HxtEj+3y1yHtHp8vbQsXi2xfJj8uwDwMO5ETL38SDXURD71ibF7
 ChIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to; bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
 b=P44n/J2t4YgG9FMSR5C93IZBbDphI7eQvdKhHqPQKgmlUvO10X0rUAYRcca/EuoBMQ
 BNQmhTePMYsI3nLp8KoEqQShkTpwtMXy0J90airEDADz5w5j8vB5j3dKrQyO9ekGmRJm
 /G6HQd8+HtJ+ZH2l/CgDC4pH2gFby2qW9vbwBtYHxS0oVbRCR0zR0EW87zuC5jOsA4r9
 yhgctp1DM3sh8BLnQX6ohdGKtyIhhpfbylEDr/X6bxjiYrP9pPVzs2i66zpH7M7GuJng
 yxtw/ZfZZ0Vco03wGGNDD2B4ZVQTjgHXYgYG1w14lFWk+c1ho1IXiltix3IOb/64vBmy
 zVKw==
X-Gm-Message-State: AOAM531UgLb8b0aTd+DcnMujbp7JZR3PUeZTWbfm5IZ4X6BhwWZONLvf
 3jJtYuSOaPpbf4OFaIMvWr81JopfrA==
X-Google-Smtp-Source: ABdhPJxZSrbWZzQDr55mdPo+6c30/Ybjdp+n6lXqVs1jxzQEstypPUxE0mNfzMHFA3Zn+gC3p6cqscaGjw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:902:67:b029:de:c5e0:87ca with SMTP id
 94-20020a1709020067b02900dec5e087camr13986024pla.64.1611794321730; Wed, 27
 Jan 2021 16:38:41 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:26 -0800
Message-Id: <20210128003829.1892018-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/3] Adding offset keeping option when mapping data via
 SWIOTLB.*
From: Jianxiong Gao <jxgao@google.com>
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_193848_761464_9B752103 
X-CRM114-Status: GOOD (  12.19  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
patch adds an option to make sure the mapped data preserves its
offset of the orginal addrss.

Without the patch when creating xfs formatted disk on NVMe backends,
with swiotlb=force in kernel boot option, creates the following error:
meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
mkfs.xfs: pwrite failed: Input/output error

Jianxiong Gao (3):
  Adding page_offset_mask to device_dma_parameters
  Add swiotlb offset preserving mapping when
    dma_dma_parameters->page_offset_mask is non zero.
  Adding device_dma_parameters->offset_preserve_mask to NVMe driver.

 drivers/nvme/host/pci.c     |  4 ++++
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 kernel/dma/swiotlb.c        | 16 +++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
