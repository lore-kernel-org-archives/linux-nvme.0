Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E60C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHn62m/Gwdf45O/um3ubf9RIkkaIFdBJc3cgAqYDmzQ=; b=L7BAhc+tfBipncUU1iWG9MZ20o
	lbhmetfOC4vlPVlBadzVbndXfZeSDyrNoXBBujiPoYLUepjqQ/NFAn17Ey4x4yggU7QDh9Da9ZYsU
	tBDUUB+qq/ayX+uepTlSIHHg1Z7RvsqZXzRo7gNGDTEqyZf36438lRFUw1fb9zYIEPNGbf9o9PUxC
	zBOSskyiNhQ6U9VkiOFHasO/JytYFev5z3ZKE3o0WoG+unjJyR6ChS90pdqDPm0/u1b3Sfgda/uY5
	Qsj11NpqPif2pLgIYRZ3riOk0OnGiwVxD/9PDCGp32TguWb4FNaqUlQ0lc9juEE+lO72dtFdHjD39
	aaA0hIeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYU6-002q1P-7Q; Tue, 23 Nov 2021 16:17:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mpYU3-002q0i-6V; Tue, 23 Nov 2021 16:17:27 +0000
Date: Tue, 23 Nov 2021 08:17:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
Message-ID: <YZ0UFxo/LV5V8laX@infradead.org>
References: <20211111132135.19216-1-dwagner@suse.de>
 <YZfakf32dXVFhK5E@infradead.org>
 <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
 <YZyDGRhyjYJu+9jK@infradead.org>
 <064b3972-dab4-c31b-b5c9-b0d9b1475ebe@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064b3972-dab4-c31b-b5c9-b0d9b1475ebe@grimberg.me>
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

On Tue, Nov 23, 2021 at 11:05:37AM +0200, Sagi Grimberg wrote:
> 
> > > > Thanks,
> > > > 
> > > > applied to nvme-5.16.
> > > 
> > > I thought this is not needed upstream. Daniel?
> > 
> > Why?
> 
> The correspondence on v1 of this patch concluded that it
> is not needed for upstream.

I'll drop it for now then.

