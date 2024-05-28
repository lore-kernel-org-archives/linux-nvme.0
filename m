Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A25C25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lertXZ2ifo5sxidicD/0ENCz7TTpOSBLpvtzPtjpOE=; b=dUuOx7mDqYUsyLAK0LMCHUYnLt
	QaxlZYrFHoeMCaheh+d1bI1SHmxt+diEZxWA+Fy+OlF93j7vzNqINh0+2eAMH6MjHDwmFAKgvrP2N
	ndZPgcmo4MWHJdoANEH12W2AXy3ly0Gep1bwmHcuUsZuSQs/DJVRuTbhDqrfdIm7NmRVD8ZO6kt4U
	uvzpja0ZXKGPl63sO4sSGnzgZWyZ1hIe25+CQvcINbmHc1pPw9Kek3NRpZ3/QaCxZX8J1s2TM1WZB
	EHOlETp5Z5uS4zqHTtLY5UvWa6EP7MtbGTQMHlUl6rXt9nSGsa0BtsbESQDFZTJV2F2gfJ4wd6Jf5
	ICRUE/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0Qc-00000001WMr-3DIt;
	Tue, 28 May 2024 17:16:02 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC0QZ-00000001WLm-3Q7k
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 17:16:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A2A92CE137A;
	Tue, 28 May 2024 17:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6164EC3277B;
	Tue, 28 May 2024 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916554;
	bh=4ixa1wAJCEzH2PDVO9vNbV9hp4iiNcPG5cG483wMnnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9EKU6/A6EKAW2NsvZGEyicIAtDu87xiFRLjPzAGfIBFG3FIhN45HOSeHKnMglyko
	 AISV9d0vHZrA0M00pSzrrwwqY+/p0C0NVmNjH0pxzJ3R9+xReOKUCh/bpeJ6JH5gpT
	 3TXmQIvQk50C1gEFTRVzZiIPHdrreUuU0GoWxmyU1RvzLQcqAIHQlUta4wL7arF3uI
	 z2tpqWve7/T+2OMD1KMl/rZvRc6ESFJUZV+x329ulixXmtV5g0bmwGlZyQ97ySvUA4
	 T+mW0g97P1WkpO78ZqHk4KOEXgddaWyUqZWaUWT2bN62Sh0a0daOAbEaO2i9IHiphT
	 LbI3vAnYDZLLw==
Date: Tue, 28 May 2024 11:15:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com, sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCHv3] nvme: use srcu for iterating namespace list
Message-ID: <ZlYRSFwakKszJjWH@kbusch-mbp.dhcp.thefacebook.com>
References: <20240524155345.243814-1-kbusch@meta.com>
 <20240524164345.GC21444@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524164345.GC21444@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_101600_045939_5CC20D18 
X-CRM114-Status: GOOD (  10.69  )
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

On Fri, May 24, 2024 at 06:43:45PM +0200, Christoph Hellwig wrote:
> > -static inline bool nvme_get_ns(struct nvme_ns *ns)
> > +bool nvme_get_ns(struct nvme_ns *ns)
> >  {
> >  	return kref_get_unless_zero(&ns->kref);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(nvme_get_ns, NVME_TARGET_PASSTHRU);
> 
> What actually needs the export in nvmet?  AFAICS the export only grows
> a new user in ioctl.c.

Yes, I copied that from the "nvme_put_ns()", but you're right, this one
does not need to be exported. I've removed that and applied to
nvme-6.10. Thanks

