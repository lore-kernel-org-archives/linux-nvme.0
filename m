Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A1BC54722
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=; b=ltDLsnW8kYNubun8AwA6ueIVBn
	1FF1cYL709N5Pb3euJ9+O+g7ifBeL2ntUdGvKczxOd5EQdttHPDG8F+2GuQoKiYgs9NbnFoMApTBy
	33v4O/TRBoZ0U1xBdnpYzyFOOquE2YDbBGaQFW7JNYWZmhgghVEuf44QuigK+fWLt8SBG6GiN4/D6
	1PaAI892djh5O/1jZqT3+AZgk5N/PMgDzTHnsLPYKXKOtQAk7A0izQ0OQzwUlRIdVEFucw4ufB4aC
	dXwJHZ0nEMvgddZIRLAne94rcoRYhAZAI9uS+MTtM4F+NgCZjEMT4AcDLexp445ZKShUH4FJCCTkx
	iFcmVMnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgz-0000000Dy9W-3Rhw;
	Thu, 22 Aug 2024 18:37:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgv-0000000Dy5s-2Ftr
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:50 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-20219a0fe4dso11864325ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351868; x=1724956668; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=c9VXoEY7H79qVyf1fDpuIN6OXCYC5eVmkLuTSHgYyH+eDq9sx5v8zPUIQe5U8DJPb9
         HE/rxKykMY1aajLgDtqeL0w0giOwdG0KLsPQc20m8D2PA827LkdcRWnzPaV6WRO4xxQQ
         6t8pzFekZWh2owpiB+EqypmZbdZrrFCiMXK1FGnxa3fEU8cL50p+eBVs8fSsSW1xJ/a/
         AuWe4pjPu8xrcM/gCAqAygnkmzrYNuQ47U31eJLGjde15z9lPvuBAhppNNBd6tzR6D0c
         oxoGsDzQNm88WVFX4p/ouS1G1tsLvl38q1nr0MAmu0a7AVXhNM9PjJwP4QHmPT6fNAWB
         L/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351868; x=1724956668;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=Hj9OGyPtQJKx9MUcH5Sk56j2Tv1/OjFCPVoJxmqiqrMFT+WUasz8ixd5Fbl6hXilV3
         t0LpZO3EtUrag35RuAyaFa1/OdF2pLCA3RpqyiV7e0KpudPeICOzWMg64r0MC1yGN5VS
         UZdXyDa7XpWvmdG5dLbzOB6/qxHZ1gaRMp4CT3YRG3bIEw59/fcSAqk/797TKRya31rG
         uVcP6xfOBvoWnje7JTN5yUVOJUNrcZZvexI4S+Djol6lKopoZuou/Sm8Fo4W3EBhTqkY
         vO/57SjYCUhFrGPAgCo7frkfi8BfofmCEL8ia4AuMlQeCp4sXtOmbCVj4UZBpWT7f6f9
         H3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXVPlYytAoyC3V3sxmWLJtjQsisZtJx4FfoocVACdlmoZAdI94uajBT+jedwo0Pp6teT5ltLBFR4oLV@lists.infradead.org
X-Gm-Message-State: AOJu0YzwB5RwVlpuS1l2u9m0AmMsq1MEAM/B4U9G4b0VUTkrmK+pMDhe
	FpYCuGKvV6ygplmeEDRU9y0frJmjrT9ckbon130VWbr0j4yoXcZ1
X-Google-Smtp-Source: AGHT+IE5HU0h4JUoQwfjPC2hkmon5bCJZ8hz8HnwTaO4uEWN3UXUQmXUdXTWmLmVascnml4B3X8Sbw==
X-Received: by 2002:a17:902:d4ca:b0:202:162c:1f36 with SMTP id d9443c01a7336-20367d3b815mr78784005ad.36.1724351868111;
        Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:47 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Date: Thu, 22 Aug 2024 11:37:13 -0700
Message-Id: <20240822183718.1234-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113749_643977_80D2F6E0 
X-CRM114-Status: GOOD (  16.83  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

When a DMA map request is for a SGL, each SGL entry results in an
independent mapping operation. If the mapping requires a bounce buffer
due to running in a CoCo VM or due to swiotlb=force on the boot line,
swiotlb is invoked. If swiotlb throttling is enabled for the request,
each SGL entry results in a separate throttling operation. This is
problematic because a thread may be holding swiotlb memory while waiting
for memory to become free.

Resolve this problem by only allowing throttling on the 0th SGL
entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
unmap entry 0 so that the throttle isn't released until all swiotlb
memory has been freed.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This approach to SGLs muddies the line between DMA direct and swiotlb
throttling functionality. To keep the MAY_BLOCK attr fully generic, it
should propagate to the mapping of all SGL entries.

An alternate approach is to define an additional DMA attribute that
is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
attr is added by dma_direct_map_sg() when mapping SGL entries other
than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
is set and this new attr is not set.

This approach has a modest amount of additional complexity. Given
that we currently have no other users of the MAY_BLOCK attr, the
conceptual cleanliness may not be warranted until we do.

Thoughts?

 kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..80e03c0838d4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
+static void dma_direct_unmap_sgl_entry(struct device *dev,
+		struct scatterlist *sgl, enum dma_data_direction dir,
+		unsigned long attrs)
+
+{
+	if (sg_dma_is_bus_address(sgl))
+		sg_dma_unmark_bus_address(sgl);
+	else
+		dma_direct_unmap_page(dev, sgl->dma_address,
+				      sg_dma_len(sgl), dir, attrs);
+}
+
 /*
  * Unmaps segments, except for ones marked as pci_p2pdma which do not
  * require any further action as they contain a bus address.
@@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
-			sg_dma_unmark_bus_address(sg);
-		else
-			dma_direct_unmap_page(dev, sg->dma_address,
-					      sg_dma_len(sg), dir, attrs);
+		/*
+		 * Skip the 0th SGL entry in case this SGL consists of
+		 * throttled swiotlb mappings. In such a case, any other
+		 * entries should be unmapped first since unmapping the
+		 * 0th entry will release the throttle semaphore.
+		 */
+		if (!i)
+			continue;
+		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
 	}
+
+	/* Now do the 0th SGL entry */
+	if (nents)
+		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
 }
 #endif
 
@@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			ret = -EIO;
 			goto out_unmap;
 		}
+
+		/* Allow only the 0th SGL entry to block */
+		if (!i)
+			attrs &= ~DMA_ATTR_MAY_BLOCK;
+
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.25.1


