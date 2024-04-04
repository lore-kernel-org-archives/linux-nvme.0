Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7181CD1288
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e+TWigf5NcPvyOnw7saZvcMkm/5biXuUhOhLWHqSS0w=; b=beI3r8lMkKN0HMBFlgbXdwpA1g
	eOpeWIjEfRe8G3RxByLgQB2aw67sTncrazdRoJGEjQ5N1jLTeiOOxwK/7+SfucrMCi57inycPEpjU
	MNyeFSpbI1vo+fTe7ZXL4AqH+noSzRmJNEh0i8tt3oIF3Vhwl7OXmbry+iYmYzU22HfELkNa8AD0g
	SKdIsGDuCI1g0XqzRxzEDPG7LyTd3hq2scMLS7aeCqD1QVb4pjZ0amBUH1urvxpdo/zm2PDGN07e7
	4gYvIrk4oyQorpH+rHJvKnGn4Unrc35IlyX8D1boE81gT5NjqmDpy3+QUYsSPlZl6b8PpqjklzJGZ
	m9ydl8wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsUPt-00000004I37-1gCw;
	Thu, 04 Apr 2024 21:14:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsUPq-00000004I2b-0mkq
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 21:14:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 399F761770;
	Thu,  4 Apr 2024 21:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70986C433F1;
	Thu,  4 Apr 2024 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265272;
	bh=ciwjEoIduPsk7nGPQqW7xbd2pM/oT+BddQO32l5bDI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlLQtw2rbxj/SuR1EodSXMB9fpwJpwKRjwZiDfgj7XcMOblH3KrcFqEuKUU6oWhpR
	 KIWfMmJM8wQrHCswrKvjmWuqeK4z8gP3eT/WOIe2/1rRokEVtXs9j8KZoQli3/nhsU
	 YR7H1emuAlIk6fo4rRugY56o0twaMthpzJjOZCX3FUB3G+hagaKpLWa9MTlQGUi+jH
	 jsdTjk9dUBiONouoY+Y5jyPkVKvQiGkUrzjYeaTO4JLN+mWTPYk0OZDx6B9KfxbX4c
	 5Y6SzEp8P56KojsL1CxxJjGx2iHvfrUVjN4B7um9g5vqchAkqFiWFaE/aT3Kka4e1a
	 OAf271BSPScAQ==
Date: Thu, 4 Apr 2024 15:14:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Message-ID: <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403141756.88233-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_141434_293096_7AF19EC4 
X-CRM114-Status: GOOD (  11.25  )
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

On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
> 
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>   latency tracker
> - a 'latency' nvme I/O policy
 
Whatever happened with the io-depth based path selector? That should
naturally align with the lower latency path, and that metric is cheaper
to track.

