Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE866CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 07:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8n8t85WNy1dIXj2EjGM955VLOxtS35yHHsy2/YTCXo=; b=0MqIMu+s1M/fJYaVOdSg0UU60p
	ye2oldu46wJFj2XVnskAgZ7Nr3KYLwK8GM2WGGlvoXSM4k0mDxzUhmQZDus2D27XWMgoMA2/wR6YP
	BCLqxxxOI6y4Byo0CJxNLudtCwm81sDexOG461zO9Io2ojwSbwMsMFKdbPdtKSU4GVwToO17i8Ss3
	/RNqdwWxIEQoy9bdmLtVlVGF91BejanGYcy5v2cdV8aB1M8BMgAcRd3YyWoM5ls8yNLZC9DFyx9ls
	MjtlFtWM9sn9k5XA0tWQviN4kLSDg6CKP9zKXg+9TQVaphJOGU4Sg2oNWmatuiRcDkGIiC7N/sHy5
	4Kbnvoaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbLM-00000003nSI-3Vs4;
	Wed, 20 May 2026 07:27:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbLK-00000003nRj-2dwq
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 07:27:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB85368BFE; Wed, 20 May 2026 09:27:46 +0200 (CEST)
Date: Wed, 20 May 2026 09:27:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com,
	coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <20260520072746.GD14937@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519172326.3462354-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_002750_808749_8F48FDCB 
X-CRM114-Status: GOOD (  18.24  )
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

On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme driver has long utilized a zero capacity to indicate the path
> isn't reachable, which creates a race condition with IO dispatch when
> paths are being detached on a live system: when the block layer rejects
> a bio early due to a capacity check failure, drivers with multipath
> support using the original bio have no interception point to redirect
> the bio to another path.

Trying to reverse-engineer - the problem is that the block-layer
code catches being beyond the capacity and directly completes the bio,
right?

IMHO the right fix is to get rid of the capacity hacks, and have a flag
we can catch in the nvme driver and complete through the mechanisms.

Having a callback into the driver for a specific error codition seems
odd.  And I think there's a bunch of cases where we could call this on
a bio the driver hasn't even seen yet, including from file system code.


