Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4672C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QMjfKMTJ6h8tydJeU13gi6c5mCCUp4VI53AIm0nHTRQ=; b=D/HSRcdcXbHOBOg8SjorlRGgG2
	gbdZvoRcdIMQiXr2sja6BnvxGL5BOyLNRxxMr6+9SHdoKaoJM+yRgM7iMcj9T0ZhbNUXKAUSNpC2O
	zUZvF287vaROMS8jIZaU2M/skVuJh2ZhHpoxYvpOFx2oShPHmPyJO85S0LuXxtK/3lOKqUlO/kIjP
	Pv9puPLhCi/Gc0zU7Yk7dDfLoKS6NNTierMl/xqBJoyXUCm3fI8i/C5dA9iL1bU0o6eJpnU8J7M2w
	5hyz2cY9hE7oVlrahuXx+AHIeWDaxIKWBxVtaTHSdYLZqhKJKpa8jf7oh6BKOIgdkOPimEgo/PnKJ
	xsN9wNZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qypSd-00AyVV-0d;
	Fri, 03 Nov 2023 08:23:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qypSX-00AyTr-2M
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 08:23:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D7DB67373; Fri,  3 Nov 2023 09:23:06 +0100 (CET)
Date: Fri, 3 Nov 2023 09:23:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Message-ID: <20231103082305.GA17096@lst.de>
References: <20231102141903.66515-1-hare@suse.de> <20231102141903.66515-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102141903.66515-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_012317_929443_255380A1 
X-CRM114-Status: GOOD (  14.45  )
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

On Thu, Nov 02, 2023 at 03:19:02PM +0100, Hannes Reinecke wrote:
> nvmet_rdma_install_queue() is driven from the ->io_work workqueue
> function, but will call flush_workqueue() which might trigger
> ->release_work() which in itself calls flush_work on ->io_work.
> 
> To avoid that move the check for any pending queue disconnects
> to the 'install_queue()' callback. This replicates what the tcp
> code is already doing, and also allows us to return a
> 'controller busy' connect response until all disconnects
> are completed.

So what are hosts going to do when they see NVME_SC_CONNECT_CTRL_BUSY?

I see no special casing for it in our host side code.

