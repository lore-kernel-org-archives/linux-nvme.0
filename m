Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4115C0015E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4hagxJddz/qRHL2YZi/oAVrzDyHS5L1k+a+NywlZkU=; b=FOlHwUYrtSJ/AAzXGMPfka66No
	/nEDdEhydwM0k2F7ivtIpuTfpTqH31m6w9N1CBeKIi7J91Apa0OdqTz95W060uOe41bLs3dZwfGIo
	U+4PPEUJqw0a9e/qLvQXLMeKN+b6KOweSq2EWfvF4BGe6vBtrCAXDiY/933E7mp3oFq7hcv00VwtE
	DH0fXpEVdQp0q+koqstjQtWXYDViw5I7tqNuD9fgJAeWmcvy/e39HhwPpvIuN8JgRbdTd1clUHhA5
	754Yn2t5mgxPm5qiaGh1rEUunVtryfbX8bYCGgh5rAhN0ZPIuPmOJ9o0d5Z4PIEHMDSMpp9b7P47n
	6koreP1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyoA-004vgr-33;
	Mon, 24 Jul 2023 16:53:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyo9-004vgA-2S;
	Mon, 24 Jul 2023 16:53:17 +0000
Date: Mon, 24 Jul 2023 09:53:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 2/2] nvme: remove warning for shared ns when
 multipath=N
Message-ID: <ZL6sfR1MfTGsxnIj@infradead.org>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719084147.16272-3-dwagner@suse.de>
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

On Wed, Jul 19, 2023 at 10:41:47AM +0200, Daniel Wagner wrote:
> The default value for the module parameter multipath is Y, thus the user
> has actively chosen to set multipath to N to trigger this warning with
> shared namespaces.
> 
> There is at least one external mutlipathing module which conflict with
> the native multipathing feature (Dell's PowerPath module). In such setups

Why the fuck would we care?  Out of tree modules don't matter, and
certainly no one should ever even dare to bother upstream with them.

Stop this crap.

