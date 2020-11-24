Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DFC2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 11:49:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C449206F7
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 11:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUPQoKZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C449206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HCkdOsH+gpnDZY/ztIyHJSWUE89vYNLhRSMPJBBuleQ=; b=dUPQoKZ3pzpYWskOhk26ycDPU
	TynDpef4MVEjf57y68XFYLqzd1blCEHxXTZE5mdOOhjVuNVMcFhZ2EDM4carbKET+Tr5CVRsyvIvX
	Xh1CHU2LrevcQpQToR5HVH5UxS91/1nyGqW1PnJUzJCdqmhf6Kk4MnMfRAdDVQMnvi3sA5OHIbLDw
	Cxmht8M4iVzUbMa6ORtEbDcxmTOzGUUThPX3hGA41xcG4QVsvHmaxLV92oRX2OaCcEIG3jxl33xuZ
	W2iuneyDgALjtypAO1eICY5CwfCIN6h91B0FOqP6QBIzTvqyHcXowa+M6BHmz/s7GQN0K5DtDMk0c
	cQHSzGVNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khWos-0004zd-LS; Tue, 24 Nov 2020 11:49:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khWop-0004z3-Ss
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 11:49:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E3A5F6736F; Tue, 24 Nov 2020 12:49:06 +0100 (CET)
Date: Tue, 24 Nov 2020 12:49:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH] [PATCH] Adding offset keeping option when mapping data
 via SWIOTLB.
Message-ID: <20201124114906.GA22619@lst.de>
References: <20201123221807.3344263-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201123221807.3344263-1-jxgao@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_064912_062750_F3C3428E 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: sagi@grimberg.me, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, kbusch@kernel.org, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 23, 2020 at 02:18:07PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
> booting with --swiotlb=force option and using NVMe as interface,
> running mkfs.xfs on Rhel fails because of the unalignment issue.
> This patch adds an option to make sure the mapped data preserves
> its offset of the orginal addrss. Tested on latest kernel that
> this patch fixes the issue.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

I think we actually need to do this by default.  There are plenty
of other hardware designs that rely on dma mapping not adding
offsets that did not exist, e.g. ahci and various RDMA NICs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
