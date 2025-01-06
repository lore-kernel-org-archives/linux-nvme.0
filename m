Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC776E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 08:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5OSSHtlh5FPTXeoNeKBaq2mv0nToARhEzErQPPIDk0E=; b=aOo8TqWNub+4gSc4q92dZJ4mSp
	0fcyMZPvDMnN/2KJ5UxTGix2QQQO4FthJ/tg3CCNPeJC5FoevIjMisW/GvAm544OlHHGkRqK+2Ios
	P6AvaLxuw9lNe1H3YvRWQqsixYzraFk6Nn5m5Fmfg8gcaRO1EyjGMeqk5bnRflTX1EoAE3kpkpWNZ
	RccK8csbMsyqljPp7NZ6jWmu/HoISxK6T6e83Uv2IR2CeN/s4+diSAnU8Arh79p7IrcqwaoENZHM6
	x26t/uqjG+4GuSdv8z5XZhLNJDNVJNsEBIuToZ0UCVh2GkmcU/Bajz5FeiQfVJoUviFUfYKxNvM6m
	QIMmo1/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiU1-00000000Ve5-28zs;
	Mon, 06 Jan 2025 08:29:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiTy-00000000Vci-44jg
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 08:29:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE4A668BFE; Mon,  6 Jan 2025 09:29:02 +0100 (CET)
Date: Mon, 6 Jan 2025 09:29:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <20250106082902.GC18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3tOn4C5i096owJc@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_002907_148997_DE6DDCBB 
X-CRM114-Status: GOOD (  15.75  )
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

On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> As I mentioned in another thread, freezing queue may not be needed in
> ->store(), so let's discuss and confirm if it is needed here first.
> 
> https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/

We do need the freezing.  What you're proposing is playing fast and loose
which is going to get us in trouble.  While most (all?) limits are simple
scalars, you often can't update just one without the others without
having coherent state.  Having coherent state was the entire point of
the atomic queue limit updates.


