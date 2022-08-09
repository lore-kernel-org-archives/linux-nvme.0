Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B908DC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ug8/Yy8mQ8I/PwtgZLIRBuakXErqYOuctRUto9HZrnw=; b=hqdYUk2bdscDMBkZldnHxHclua
	UM/286gFkz5nVhah0Mn6IDbB51aTPRceA01LBaQiGXinuR4d0Owa0h3ismWspDKXFK75Cifd+sfq5
	SEXXV53tGG2Q0h28jCuE35PeWmi+qFIEFA+3gBkuCX4vFOGCFmjvBHarOcAtgNqwdeNizZUuVLfyU
	jwji/kW73y/HssX+PQOQQE/WmvTMu9DyO9zzXGV7+QDI6Slx9GFQB7CETw75doCelNrp7dtD/2cbs
	kuztdaO1egDdAN6i0oZDe2X2afRSIp3dBU88zjFEpE2ZxPwpXnAWc6wAsW6mvrwg7izzD9STadWZ9
	vGVDBXyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUAh-005axO-IK; Tue, 09 Aug 2022 18:41:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUAf-005awP-GE
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 18:41:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE83A68AA6; Tue,  9 Aug 2022 20:41:37 +0200 (CEST)
Date: Tue, 9 Aug 2022 20:41:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <20220809184137.GB15107@lst.de>
References: <20220805162444.3985535-1-kbusch@fb.com> <20220809064613.GA9040@lst.de> <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_114141_719620_5DA5F3DA 
X-CRM114-Status: GOOD (  16.58  )
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

On Tue, Aug 09, 2022 at 10:46:04AM -0600, Keith Busch wrote:
> I am a bit reluctant to require a new memory allocator to use the feature. I'm
> also generally not concerned about the odd resource constrained IOMMU. User
> space drivers pre-map all their memory resources up front, and this is
> essentially the same concept.

Yes, it really isn't an issue for the modern iommus that support vfio,
but it is a limitation on the dma-api.  The old iommus aren't really the
issue, but..

> For swiotlb, though, we can error out the mapping if the requested memory uses
> swiotlb with the device: the driver's .dma_map() can return ENOTSUPP if
> is_swiotlb_buffer() is true. Would that be more acceptable?

No, is_swiotlb_buffer and similar are not exported APIs.  More importantly
with the various secure hypervisor schemes swiotlb is unfortunately
actually massively increasing these days.  On those systems all streaming
mappings use swiotlb.  And the only way to get any kind of half-decent
I/O performance would be the "special" premapped allocator, which is
another reason why I'd like to see it.

