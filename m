Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81124C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGKYLFPfUGJHtT00zVJnn7onAYX1D5CI2UtbLSnte14=; b=prHYQS8L1pTfta7QPvwaw6D1zQ
	HluRMWvcd0wqnS9gH52W4vSdDAWf2HbON76o0JNezgT8oNp20Ylg48aWZXJVGVrgLwxyA2OtOB/Go
	Id0VqyXCMt+c09HdV8aifQceN1XmC42d1Zof7QpeNyxTXp47gxhmj0RRo7aJMXSneAaNK+ae3TpnN
	FGf7iXeLmNRvoC9Zsc+a4o0mgDJZdy/lXKpWAbkiGnDMYdFdBw1pALQFhrxiOJZ7f96q9gNrVuQxf
	yHczLCT3S0jPP7xITkEmSPGaejuqqoe6+S0MSDcPlVdM1hBFmpW19z3wjnrwWANHEHSJ9JHwTjIsh
	InOGD/KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUxc-0000000Do2c-3TGK;
	Tue, 05 Mar 2024 13:36:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRwP-0000000D0mj-08jX
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:22:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6B2206145F;
	Tue,  5 Mar 2024 10:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9EC433F1;
	Tue,  5 Mar 2024 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634152;
	bh=EE9BRQu4WZxxi1OZrE2CKyiBDx8STpwb4qcA00ZbW2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJX1Tg5FKs34en7E/G+kuK/7egbMx0GJIJuNOqXoVHmxPxsk7TFDIK234lueOqawk
	 DfVy2OhjuiuyjZbXTM6acAkLylbMo160eDC1sJnVeoQgpcULEW38upnzWL1Lqr/7Rp
	 S+7/VEHx42Ezy9GnCvmGq1Ejj2VhvO/SSG68quM57xXQ+O9/+eROVha2xpE5zyY3cw
	 c+b8EhkxOF9+IM77zAXowcECpDsgxXJ/bZkKfOvKYzluPnpTdFWR0s9lad7fKI63HZ
	 R+ya0BlQN3UT9rbMc+IDO37qwGt3goNxjii9a+6PVBp0+Q1oZsJEax4jeolprYJrU7
	 8QlQEfR74JKGw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 01/16] mm/hmm: let users to tag specific PFNs
Date: Tue,  5 Mar 2024 12:22:02 +0200
Message-ID: <a77609c9c9a09214e38b04133e44eee67fe50ab0.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_022233_198594_903F91D6 
X-CRM114-Status: GOOD (  17.94  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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
Message-ID: <20240305102202.q7de1SMFDRfVPj-GGbKTZ6qb9f1bKms-qCTBnko1ryo@z>

From: Leon Romanovsky <leonro@nvidia.com>

Introduce new sticky flag, which isn't overwritten by HMM range fault.
Such flag allows users to tag specific PFNs with extra data in addition
to already filled by HMM.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/hmm.h |  3 +++
 mm/hmm.c            | 34 +++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 126a36571667..b90902baa593 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -23,6 +23,7 @@ struct mmu_interval_notifier;
  * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
  * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
  *                 fail. ie poisoned memory, special pages, no vma, etc
+ * HMM_PFN_STICKY - Flag preserved on input-to-output transformation
  *
  * On input:
  * 0                 - Return the current state of the page, do not fault it.
@@ -36,6 +37,8 @@ enum hmm_pfn_flags {
 	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
 	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
 	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
+	/* Sticky lag, carried from Input to Output */
+	HMM_PFN_STICKY = 1UL << (BITS_PER_LONG - 7),
 	HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 8),
 
 	/* Input flags */
diff --git a/mm/hmm.c b/mm/hmm.c
index 277ddcab4947..9645a72beec0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -44,8 +44,10 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 {
 	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
 
-	for (; addr < end; addr += PAGE_SIZE, i++)
-		range->hmm_pfns[i] = cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++) {
+		range->hmm_pfns[i] &= HMM_PFN_STICKY;
+		range->hmm_pfns[i] |= cpu_flags;
+	}
 	return 0;
 }
 
@@ -202,8 +204,10 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		return hmm_vma_fault(addr, end, required_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		hmm_pfns[i] = pfn | cpu_flags;
+	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		hmm_pfns[i] &= HMM_PFN_STICKY;
+		hmm_pfns[i] |= pfn | cpu_flags;
+	}
 	return 0;
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -236,7 +240,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
 			goto fault;
-		*hmm_pfn = 0;
+		*hmm_pfn = *hmm_pfn & HMM_PFN_STICKY;
 		return 0;
 	}
 
@@ -253,14 +257,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
+			*hmm_pfn = (*hmm_pfn & HMM_PFN_STICKY) | swp_offset_pfn(entry) | cpu_flags;
 			return 0;
 		}
 
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (!required_fault) {
-			*hmm_pfn = 0;
+			*hmm_pfn = *hmm_pfn & HMM_PFN_STICKY;
 			return 0;
 		}
 
@@ -304,11 +308,11 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
-		*hmm_pfn = HMM_PFN_ERROR;
+		*hmm_pfn = (*hmm_pfn & HMM_PFN_STICKY) | HMM_PFN_ERROR;
 		return 0;
 	}
 
-	*hmm_pfn = pte_pfn(pte) | cpu_flags;
+	*hmm_pfn = (*hmm_pfn & HMM_PFN_STICKY) | pte_pfn(pte) | cpu_flags;
 	return 0;
 
 fault:
@@ -453,8 +457,10 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn)
-			hmm_pfns[i] = pfn | cpu_flags;
+		for (i = 0; i < npages; ++i, ++pfn) {
+			hmm_pfns[i] &= HMM_PFN_STICKY;
+			hmm_pfns[i] |= pfn | cpu_flags;
+		}
 		goto out_unlock;
 	}
 
@@ -512,8 +518,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
-	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		range->hmm_pfns[i] = pfn | cpu_flags;
+	for (; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		range->hmm_pfns[i] &= HMM_PFN_STICKY;
+		range->hmm_pfns[i] |= pfn | cpu_flags;
+	}
 
 	spin_unlock(ptl);
 	return 0;
-- 
2.44.0


