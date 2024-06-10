Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3BC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+WXKG1N/dYvXslR5SCfWvICuVAGmKrtp7skvWmfUZq8=; b=xVmvkB+WpcM4jjjv+4Du9RxDyh
	8mSMz5RI0s8TDffN6H7T0c/6VRbYEHOsUJpMXo68+wF1dJvjFKExHAwx1DoEyr2UsdKVX8DkK0X/v
	XzFh5f+WbJDjargEXemdr6/+6YJ3ZK2TjdEUcSIyy+CtZ9RZ+nblfQbOgu+I0Elx5zPjUwtk31mY5
	GToOzTt0tM/fZInKzFPd5lD4H7zqlXqz6ukDGtIw0+dC/PtoQzN9O3Z48qokkBR+6sgdY/dM3AhT/
	ExP1rLDmabrEUDlJEbF2TmqDK9jO7dr/llhr5jtbW/8pzWUYogEdOptBHs1X/i1pAXrZ6DG++2C8b
	AEK9eQfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe9h-000000050rV-2c9q;
	Mon, 10 Jun 2024 12:29:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe9f-000000050r3-0gvy
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 12:29:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75B3D67373; Mon, 10 Jun 2024 14:29:39 +0200 (CEST)
Date: Mon, 10 Jun 2024 14:29:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
	Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240610122939.GA21899@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de> <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_052943_387869_179FB022 
X-CRM114-Status: GOOD (  20.49  )
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

On Mon, Jun 03, 2024 at 10:09:26AM +0300, Sagi Grimberg wrote:
>> IETF has standardized a generic data placement protocol, which is
>> part of iWarp.  Even if folks don't like RDMA it exists to solve
>> exactly these kinds of problems of data placement.
>
> iWARP changes the wire protocol.

Compared to plain NVMe over TCP that's a bit of an understatement :)

> Is your comment to just go make people
> use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?

I don't know to be honest.  In many ways just using RDMA instead of
NVMe/TCP would solve all the problems this is trying to solve, but
there are enough big customers that have religious concerns about
the use of RDMA.

So if people want to use something that looks non-RDMA but have the
same benefits we have to reinvent it quite similarly under a different
name.  Looking at DDP and what we can learn from it without bringing
the Verbs API along might be one way to do that.

Another would be to figure out what amount of similarity and what
amount of state we need in an on the wire protocol to have an
efficient header splitting in the NIC, either hard coded or even
better downloadable using something like eBPF.

> That would be great, but what does a "vendor independent without hooks" 
> look like from
> your perspective? I'd love having this translate to standard (and some new) 
> socket operations,
> but I could not find a way that this can be done given the current 
> architecture.

Any amount of calls into NIC/offload drivers from NVMe is a nogo.


