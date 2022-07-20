Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2009C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 04:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VznV8NdwkqLryGhh9Q/KVPrJyajGhRQpj8qYol7iDY0=; b=AQnnVxkD33UIHNJBOQJUQj4mE5
	Nk1g05rFOXaoCeE3l1AR2xLidcr2fc15FDZJft5e7tChcu1wJBLsCkEoLGN6mNhZZN5EVDlcv7pzN
	+2MAFpshON8Foqne3jNgPq++mxQNfRB/1+WTM7oO41sFf1+d+Sf+P45ZuW4CcDVF4ksb6LmK4KNtN
	lQfGLjrYhLq+8xoP0mvrY1sJfzD0R34FPCtRLs+KFNEo7/YMDHlkvMa71cSBd7T4w5ea0cUKOTcUk
	s350Rx7cIyn/NUNn7f3FjRB6TjOkFuIDFRa95S8XhLDDSIWRcQopgzcf62XnQ0zjBg1crLm3/d0wE
	Ts/X0xOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE1JB-0009HN-NE; Wed, 20 Jul 2022 04:27:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE1J9-0009Ci-06
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 04:27:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6108968BEB; Wed, 20 Jul 2022 06:27:26 +0200 (CEST)
Date: Wed, 20 Jul 2022 06:27:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
Message-ID: <20220720042726.GA5574@lst.de>
References: <20220720015538.15838-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720015538.15838-1-nbowler@draconx.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_212735_208807_0B92CA12 
X-CRM114-Status: GOOD (  14.48  )
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

On Tue, Jul 19, 2022 at 09:55:38PM -0400, Nick Bowler wrote:
> Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
> the initialization of compat_ioctl from the nvme block_device_operations
> structures.
> 
> Presumably the expectation was that 32-bit ioctls would be directed
> through the regular handler but this is not the case: failing to assign
> .compat_ioctl actually means that the compat case is disabled entirely,
> and any attempt to submit nvme ioctls from 32-bit userspace fails
> outright with -ENOTTY.

I don't think wiring up the native version is the right thing to do,
this needs to be blkdev_compat_ptr_ioctl, just like we use
compat_ptr_ioctl for the character device nodes.

