Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEFDC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMvAy89a66UCLlgiGPflNi1+xuVA8gOFMsCo5SdmSwg=; b=W2Gb4GaIaBID+0bF7sBx7ZUhdt
	k2GBLVrAD8VysYwibUswvz7ZgmgUy5/a6GAAr7LkJOgS+eqZSCGwBoeE1W4jvmVl7OBc2HE8wgw20
	uOpJrTbmYQVMTaADE05haJ9Q+m9xod4DnZp5v3Bo4/DAf17NnlV2taJ0q5QbR/RAWEIBtiGAcReX/
	ohwTi/7V9K2fEjxWrYKk51AgtrMjTESvQUxQ0oQQBpAwtOp+1j/wwtE2LbnGRcYh/s5MEi7bIhwM3
	1zSXHAJCDUZyfT/VnYm+BS2QWKLM3mw6qf+gd51AdoTkTvUpu7KUHtd52FbGWenZvHtnufmQCSRQD
	8l5IKF5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8j9f-00BEZu-0S;
	Thu, 30 Nov 2023 15:40:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8j9c-00BEZO-1I
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 15:40:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5EBB661EEC;
	Thu, 30 Nov 2023 15:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B09C433C7;
	Thu, 30 Nov 2023 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701358839;
	bh=ZTVfapY6eFJbXkpEoXlis8PefK5ahpb2RshcXY+T6e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRneiiivDbXU6+l1bkB2+Az/katXKhV0+3nm1ne5oA9sU6rmNDKCpTI+LALWfTRMZ
	 5Q1DphHG8vC+ECfpVVLXk3Xy0p7p9iToWx/NSPhSuficv3Lw3B2xn8+nu+exZ/i+Ps
	 bswOgPiq6XRvhZn1BwxkKA4XkgxeIOZL213skN2BXS3KG7xZwzLdzj1mQmUEnpWyFc
	 lUl91iCuJ0ggizH9APFYz7reuITVBp5wJnmZQMTVEoF/21h1CkoV9IzpUotCuMidPY
	 Ft+MDvjJj+iDCd3HjiATp8OeQJLaf/BLxHQ5iOS9aB5DGdQD0YZW61j0mwlwxqORqS
	 xpeifwRrW5dNQ==
Date: Thu, 30 Nov 2023 08:40:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-rdma: fix nvme_ctrl_state() conversion
Message-ID: <ZWis9PdlUobMqzUY@kbusch-mbp>
References: <20231130134210.133103-1-hare@kernel.org>
 <690fe488-ff5e-418d-af45-fe567e02ff87@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690fe488-ff5e-418d-af45-fe567e02ff87@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_074040_509327_0C2615DA 
X-CRM114-Status: GOOD (  11.85  )
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

On Thu, Nov 30, 2023 at 07:42:13AM -0700, Jens Axboe wrote:
> On 11/30/23 6:42 AM, hare@kernel.org wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > The argument to nvme_ctrl_state() is 'struct nvme_ctrl'.
> > 
> > Fixes: b59ea0f40072 ("nvme: introduce helper function to get ctrl state")
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> The kerneltest bot has been complaining about this one for a few days,
> it should get folded into the offending commit however.

Mea culpa... I thought I'd tested my usual allconfig before pushing, but
it was the minimal config instead.

I've folded the fix in, will push shortly.

