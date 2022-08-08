Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F3BC00140
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Aug 2022 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWkJTJXK/JiTgPEFo7NseuTSDz/fI2MPzkdphRttrQ8=; b=s4FkuXleTlcwb+IN/x0cj3NOFT
	mVN9JDXYjrgmslCoYReFwzOCBWS0L/vR5FrTdwFPRvgu3KYwC1LtVDfQ68uX+N1ErhNfRZd6vQODn
	BBjXWHP5bzVX4iC6a4ftF4tFOnCHCZAK+IO8DBVKE12PtXlPW7XxyVxh08ZGUv5rgC8rYlMaMAKfE
	mHREx9v2FIByKBVxfNv4CcBS3PZQCfBpasMAWbKOlJ6v7dtP8GX63MUbWQtjaSsVIqUI41EKjTles
	TYmQuc4/3q+OnCFLyoj9Rl8E2gE7c8avNGMyReXkW59ylGX7d6m1COQjpO7BgPfc3tNifjU/hQ5lz
	VDTKwtKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4gd-00Eh4u-GA; Mon, 08 Aug 2022 15:28:59 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4gb-00Eh2h-3L
	for linux-nvme@lists.infradead.org; Mon, 08 Aug 2022 15:28:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A26C4B80E25;
	Mon,  8 Aug 2022 15:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9187AC433D6;
	Mon,  8 Aug 2022 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659972533;
	bh=lpFQdsjZh8wL+uNBQDVltfnf7Gcs7geIK2yl0gZEZis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuabrMO3JhQYKj/lsRfa4eWTX5vJ/OD5elQ3cp0RJFhxmFivmc3uRLkaTf9DoIe5p
	 uBMCFwueUu+gmYNgHmsBBLIRJcRbgWsGfyul8JIm+fhLaMUYQLQAC/9/UWG+CTvckC
	 JL7A5Geed95RZ04FGpBOY8uJJrc8XgUNtNHupCWjiEr0pLg2i58LwXvXlyjXHP+LeK
	 urpTTbYRmuOxN6i+H6oUa1pVSnfzLMFLUzT2NQM/4qr6rQHTCaUVWa6PCQxUfta/Ic
	 idtNv4fQOtRMvL4hr5zKZR4ham7kYrM5t3MLhIkgA/E1vR5cfhPnISAjWdLWBwBZgR
	 Ai3mjsGZTfhvA==
Date: Mon, 8 Aug 2022 09:28:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 2/7] file: add ops to dma map bvec
Message-ID: <YvErsVTIQqTykcbq@kbusch-mbp>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220805162444.3985535-3-kbusch@fb.com>
 <20220808002124.GG3861211@dread.disaster.area>
 <YvBjRfy4XzzBajTX@casper.infradead.org>
 <20220808021501.GH3861211@dread.disaster.area>
 <YvB5pbsfM6QuR5Y7@casper.infradead.org>
 <20220808073134.GI3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808073134.GI3861211@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_082857_322704_C4F901BF 
X-CRM114-Status: GOOD (  21.26  )
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

On Mon, Aug 08, 2022 at 05:31:34PM +1000, Dave Chinner wrote:
> On Mon, Aug 08, 2022 at 03:49:09AM +0100, Matthew Wilcox wrote:
> 
> > So you hot-unplug the failed
> > device, plug in a new NVMe drive and add it to the RAID.  The pages now
> > need to be DMA mapped to that new PCI device.
> 
> yup, and now the dma tags for the mappings to that sub-device return
> errors, which then tell the application that it needs to remap the
> dma buffers it is using.
> 
> That's just bog standard error handling - if a bdev goes away,
> access to the dma tags have to return IO errors, and it is up to the
> application level (i.e. the io_uring code) to handle that sanely.

I didn't think anyone should see IO errors in such scenarios. This feature is
more of an optional optimization, and everything should work as it does today
if a tag becomes invalid.

For md raid or multi-device filesystem, I imagined this would return dma tag
that demuxes to dma tags of the member devices. If any particular member device
doesn't have a dma tag for whatever reason, the filesystem or md would
transparently fall back to the registered bvec that it currently uses when it
needs to do IO to that device.

If you do a RAID hot-swap, MD could request a new dma tag for the new device
without io_uring knowing about the event. MD can continue servicing new IO
referencing its dma tag, and use the new device's tag only once the setup is
complete.

I'm not familiar enough with the networking side, but I thought the file level
abstraction would allow similar handling without io_uring's knowledge.

