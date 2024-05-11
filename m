Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8684C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqAu8Pps5JqAT8IXH8R703iSyYY7OAg7iaYI1DF/DG4=; b=MwBIn0tajxNE4tsQrcfcjkohk/
	ZiRUW4fdNasi2bkFRZ5mgkjlAG4Kf420mW00HWqIXUPEfyOyDUKfp16PTno1Z9fwJvV4VktQnm3UE
	1zsXQ2k7QmNjh9HZJz0+uFo+loAQoljkeFZILkJzT1bvaju1ToP10MdN7CHRxKZJLmGYQRCG7ftFf
	8H51B51MluN7Q0DljtblR5X9Nck7ukiQAQIWrkPAryxX/AjPjl9uHiqjFb54fkjeCgai9ppJCeN5v
	14VaguULHlN5NAZnI0G1HlgkIfvgKvhQ6v13uBKsbX14yT7STIpi+fzDnBChE7D56wKHUCXqmlop5
	CW+GgkbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vsC-00000008tSk-18aR;
	Sat, 11 May 2024 23:11:24 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vsA-00000008tSQ-1kAK;
	Sat, 11 May 2024 23:11:22 +0000
Date: Sat, 11 May 2024 16:11:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj_7GjhpWtY-ZOjr@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj6hotHEsOSL9h1K@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6hotHEsOSL9h1K@casper.infradead.org>
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

On Fri, May 10, 2024 at 11:37:22PM +0100, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Don't set the capacity to zero for when logical block size > PAGE_SIZE
> > as the block device with iomap aops support allocating block cache with
> > a minimum folio order.
> 
> It feels like this should be something the block layer does rather than
> something an individual block driver does.  Is there similar code to
> rip out of sd.c?  Or other block drivers?

Each block driver must be tested and set a max if its below what the page
cache supports.

  Luis

