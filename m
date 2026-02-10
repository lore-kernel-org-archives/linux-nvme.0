Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D507EA8133
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0Ks/Jzg5dqDNmTkM32ohGElf6TmJXnAvPys3oCm4Tw=; b=1eaB0cnKuxPABhreeKzBLMTBxo
	eweHofwZzgTNloDgnmxsbx7oJuVGfBuW5UXnyiR2wuWAX045pV+Phs9148D6verfOu0mwFAyxovSY
	A958Ox3HOR/8Fk5jVs3NPHSnNivjcwVGieycwCdST/CWbE3CYCbgXVOYTGl7HPkj6oyPHT8kj6vcN
	o1eLNRRNJHna05gPXbna1lJJDnydMdRXvV8HtTDF0Leq5XcA0DX/aTQhuOgHj1ew2CAdX7RzCD3RA
	1LAfd7xoCdALrLlDtc0rmM1qye/n9f4HUMVy37wNrvZRC0cN+YZP6KftnkM79NenKKMaOhmRgbvjb
	y4N/gwiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppsB-0000000H8eN-3Oe9;
	Tue, 10 Feb 2026 15:41:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpps9-0000000H8dM-0vCf;
	Tue, 10 Feb 2026 15:41:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B92D168CFE; Tue, 10 Feb 2026 16:41:50 +0100 (CET)
Date: Tue, 10 Feb 2026 16:41:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai@fnnas.com>,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, sven@kernel.org,
	j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect
 debugfs file creation
Message-ID: <20260210154150.GA2844@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoaWwI-sl5hK6s_@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_074153_402626_D2D443CD 
X-CRM114-Status: GOOD (  14.92  )
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

On Mon, Feb 09, 2026 at 10:33:15AM -0700, Keith Busch wrote:
> > This is not clear to me. Why are concurrent queue freezes not allowed
> > while debugfs attributes are created? I don't see any code in debugfs
> > that calls back into the block layer while creating debugfs attributes?
> > Did I perhaps overlook something?
> 
> I had to look up the original commit that introduced the WARN,
> 65d466b629847. The commit message says "Creating new debugfs entries can
> trigger fs reclaim", so that must be the path that enters back into the
> blaock layer request_queue.

Another way to solves this would be to scope all the debugs action
as NOIO context.

