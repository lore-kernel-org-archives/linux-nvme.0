Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92277C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4+VPVrEvAirLqZiWVZYoYvI4jVjW6qDX0zSalgUX7s=; b=zRoWB3CVf//Izmz1GXsPyIjqvB
	q7LO3PdJkDnxBGpdolgaVehJNA6V16nNPXkKEQIUq6MI1ts0DAiKGK2KmwQyCN5LEpuoM24h8rS4X
	a8SU670Ryj4EaD4TgO3p4iW8CSTjLpP6jOu4mVJTirAVQcxHZ+BJ3QpMs2GeTNo2sX7rQhmrZSmGk
	dmencXLhDeAuYSVyyrCoxufpcZW1sWemNeuN82bMqn0YxursHglvMgQj54ph+q5dwGoe7GwcypK/h
	dc2wOGAlP77P1KwI00RymtpuD0x6XFWUH6ppeFW7ZfJxpooYZEXKCMCZ0IHNNQzx+6e56YvB5d+fw
	s0O4phig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDEuQ-00000002PqS-0c5S;
	Fri, 09 May 2025 04:00:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDEUG-00000002NLv-1ewo
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 03:33:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 256D968BEB; Fri,  9 May 2025 05:33:19 +0200 (CEST)
Date: Fri, 9 May 2025 05:33:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: lock per namespace in nvme_poll_irqdisable
Message-ID: <20250509033318.GA27794@lst.de>
References: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org> <aBz0iLWpLUQR4rtX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBz0iLWpLUQR4rtX@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_203324_574168_E6D33745 
X-CRM114-Status: GOOD (  14.82  )
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

On Thu, May 08, 2025 at 12:14:32PM -0600, Keith Busch wrote:
> On Thu, May 08, 2025 at 04:57:06PM +0200, Daniel Wagner wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > We need to lock this queue for that condition because the timeout work
> > executes per-namespace.
> > 
> > Reported-by: Hannes Reinecke <hare@kernel.org>
> > Closes: https://lore.kernel.org/all/20240902130728.1999-1-hare@kernel.org/
> > Fixes: a0fa9647a54e ("NVMe: add blk polling support")
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> 
> Looks good to me
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

This is originally attributed to you, so this review is a bit odd..

