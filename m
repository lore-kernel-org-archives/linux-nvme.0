Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12DCC19F2A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/GLQo1oIeD25DBuWlw/hNTcNmhBAh4DcPv1Bq9auhQ=; b=PbgwmRUt6dhwow6jbHI69+3CVl
	RMDx4p38EGjU9sJxMVlpvD1dDlrz/7dQEmMgHl8D954Fc2nE+Srv9ltSkaJMGfa2M6q0R0lUE1ErP
	ReuU8IozWFVJBEJtL7mSmDwC0dBjcs7qVyTeCsRvgZ03xpHbkaHDrYXIsgVOFqt/gnPrvgZUc/P+i
	9LpMszL0RjsCHlwOeNc2HdNIfY+EUM94+Wt/6HUPbh3eMomyRW7j7OVTaqI5ruUOZ7Qdmnz4XWNz4
	g4H2YThSjLAAV5X72GZdbnz63HjQq2ywN/MGTVPOkYF8jI+sTja7Mh51wcWD19nr9EaMtR3YvQ+eR
	AjuZBHng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLq4w-00DZoO-M7; Wed, 10 Aug 2022 18:05:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLq4s-00DZmc-TE
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 18:05:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1326142C;
	Wed, 10 Aug 2022 18:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11174C433D6;
	Wed, 10 Aug 2022 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660154708;
	bh=nhGr02sSN89GKEkq7FccjXFENhz9XIFY79Zk1MeBFDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giwdIhQSTRjg1XY592kRRArKEADaCYIFb0IfSAf5vSAAqZPkITd1VNS31sKmvjLHY
	 QZ5zTWD7x1qLyuh8xA3n7RFw4wR4aV4jBH78K2xHiYXQqMtPpepIUoftftH8NkARnz
	 froPTiPS0sbSWrcTJfKFysqmONFj/cExjXFDlcbqP1hTZrLlkVKbG0IlQYZ7h7519j
	 8jkQEU3HBANrmut4RcNOvhGZVr5yQBobhJGMqjYraFsHrpXfdjbgVU+drNYU2ER9Su
	 qD/ARUaZVD70Uc79Am1rehEVjBKYpmXPabLA1gSTrBhfCCwlKEiW+RwKzxvC9KxCcx
	 VFEPcUyWeyo1g==
Date: Wed, 10 Aug 2022 12:05:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <YvPzUSx87VkwSH2C@kbusch-mbp.dhcp.thefacebook.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220809064613.GA9040@lst.de>
 <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com>
 <20220809184137.GB15107@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809184137.GB15107@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_110511_009702_7A2C8418 
X-CRM114-Status: GOOD (  20.89  )
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

On Tue, Aug 09, 2022 at 08:41:37PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 10:46:04AM -0600, Keith Busch wrote:
> 
> > For swiotlb, though, we can error out the mapping if the requested memory uses
> > swiotlb with the device: the driver's .dma_map() can return ENOTSUPP if
> > is_swiotlb_buffer() is true. Would that be more acceptable?
> 
> No, is_swiotlb_buffer and similar are not exported APIs.

The functions are implemented under 'include/linux/', indistinguishable from
exported APIs. I think I understand why they are there, but they look the same
as exported functions from a driver perspective.

> More importantly with the various secure hypervisor schemes swiotlb is
> unfortunately actually massively increasing these days.  On those systems all
> streaming mappings use swiotlb.  And the only way to get any kind of
> half-decent I/O performance would be the "special" premapped allocator, which
> is another reason why I'd like to see it.

Perhaps I'm being daft, but I'm totally missing why I should care if swiotlb
leverages this feature. If you're using that, you've traded performance for
security or compatibility already. If this idea can be used to make it perform
better, then great, but that shouldn't be the reason to hold this up IMO.

This optimization needs to be easy to reach if we expect anyone to use it.
Working with arbitrary user addresses with minimal additions to the user ABI
was deliberate. If you want a special allocator, we can always add one later;
this series doesn't affect that.

If this has potential to starve system resource though, I can constrain it to
specific users like CAP_SYS_ADMIN, or maybe only memory allocated from
hugetlbfs. Or perhaps a more complicated scheme of shuffling dma mapping
resources on demand if that is an improvement over the status quo.

