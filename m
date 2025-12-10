Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB363D3B9A9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 05:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6LKg0SV4LL0l2JpS3Zy+2nr0QlibAnC7sl8Fwl53oU=; b=chgMbnGPX1UdcHTAKjPAdtWKzX
	ExcvkPxfkWXUkK5+HzrVTT1s5xPUsqBuOBbGern/KO2jG+fHTBwuZU+RBlXJTAeJYDiXRlDGkPlDl
	bkVK8Uyacpr+RWebBzLvzGTDWMMi2PJbFbD5k1efMV9cTli+GG2yaE11NDCD3EHVPY3b9D56JYLGc
	L1N1j67PQrR8Tx6NRoevBR42qbhNyxX97X0llSZAiGXaZr/8sznOmd90+z4ApxqQkFUNGKvxwpKTw
	Lkx+2XNZcNvfIqH/7BT+q+JxtWZqgLMMmkOfvDR8QHF4lgagHQWWGKFNU/9KOZpJg9i6CqMIdb8CN
	qqktfDaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTCLh-0000000F722-2K1v;
	Wed, 10 Dec 2025 05:02:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTCLf-0000000F71g-2rzc
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 05:02:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C493402F0;
	Wed, 10 Dec 2025 05:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D163C16AAE;
	Wed, 10 Dec 2025 05:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765342966;
	bh=42jNbugG8pQMKeJ4tz3Pjm7eLLC93En4NGjVSBZpYbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/AJcOAx8MXzCC4B+fbKn0hohRkdJx/GXvEOOTs+6u77i1jZu6ODvObJB4IdCYUpI
	 cZ4HHnoWTg6h1BEVa2FXEMwqNyMCA/NtJFQFw/jOJn6vyarKEvpI2yNv6Sg9DCHUpB
	 4qE20e6EcSu6gWXLQNClrxw/uqprCeoxX41TjAVf0xEq/F6wvQly89DTd83ikOhc+8
	 zz8fIidPoFCalyWUMFDHqaha2G7vFmM35xNQA0Q7fhExIDPtQ15hW1M6dTX0kT7DCC
	 5TRnpIhjGJwu96NpnRQdie4jiCfsv8nCN/CiGAVUAGb8meAwowjP7MfRq3F7qEmN7K
	 mSyq3SAXBVWGQ==
Date: Wed, 10 Dec 2025 14:02:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
Message-ID: <aTj-8-_tHHY7q5C0@kbusch-mbp>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_210247_759382_7014E3DE 
X-CRM114-Status: GOOD (  17.49  )
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

On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
> got the following warning after a kernel update on Thurstday, leading to a
> panic and fs corruption. I didn't capture the first warning but I'm pretty
> sure it was the same. It's reproducible but I didn't bisect since it
> borked my fs. The only hint I can give is that v6.18 worked. Is this a
> known issue? Anything I should try?

Could you check if your nvme device supports SGLs? There are some new
features in 6.19 that would allow merging IO that wouldn't have happened
before. You can check from command line:

  # nvme id-ctrl /dev/nvme0 | grep sgl

Replace "nvme0" with whatever your instance was named if it's not using
the 0 suffix.

What I'm thinking happened is that you had an IO that could be coalesced
in IOVA space at one point, and then when that request was completed and
later reused. The new request merged bio's that could not coalesce, and
the problem with that is that we never reinitialize the iova state, so
we're using the old context. And if that is what's happening, here's a
quick fix:

---
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index e9108ccaf4b06..7bff480d666e2 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -199,6 +199,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	if (blk_can_dma_map_iova(req, dma_dev) &&
 	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
+	state->__size = 0;
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }

--

