Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDEFC25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OUjQnxYzptd3jr3rpOALpRW9VtJfeXZt7RzDyIvJawU=; b=rWhKj3xsO8HW4J/c+LQPYoR/fB
	coKMcWRjw6EllKaa/K72sbe+fhpiFhLFdt8qo7C0uMJq3eM59ZoNxNk1Gno48AIFYV/htI2J1P8Ih
	TRfzGbWVNOzLf7h7xjiCvpVLjguRERowQKebil+bz16UZspRnGumpYqBwRGfhbyk6PDiG+f/q+X/V
	ZmyxNOp1x9Gb3BMIp57A6McvB4n+8ci39RmCRdrSxX5vjUQfa5XJ/crGBEvsuyJ9g5K2dC2kuj03d
	kNB21XyUkuQ/RZI1GDvK5YqLWPTzKWYm9t06c4Dm34zAC5V/dM3yqTeurHmBuWSR0PkR/8Ss8rjEO
	nLZKi3Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELlx-00000001B1J-2tUe;
	Tue, 04 Jun 2024 04:27:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELlu-00000001B0V-3nqr
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:27:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2E5F68D15; Tue,  4 Jun 2024 06:27:38 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:27:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, ceph-devel@vger.kernel.org,
	dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, idryomov@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
Message-ID: <20240604042738.GA28853@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240530142417.146696-2-ofir.gal@volumez.com> <8d0c198f-9c15-4a8f-957a-2e4aecddd2e5@grimberg.me> <23821101-adf0-4e38-a894-fb05a19cb9c3@volumez.com> <86e60615-9286-4c9c-bffc-72304bd3cc1f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e60615-9286-4c9c-bffc-72304bd3cc1f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_212743_114518_75F175B1 
X-CRM114-Status: GOOD (  17.97  )
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

On Tue, Jun 04, 2024 at 12:27:06AM +0300, Sagi Grimberg wrote:
>>> I still don't understand how a page in the middle of a contiguous range ends
>>> up coming from the slab while others don't.
>> I haven't investigate the origin of the IO
>> yet. I suspect the first 2 pages are the superblocks of the raid
>> (mdp_superblock_1 and bitmap_super_s) and the rest of the IO is the bitmap.
>
> Well, if these indeed are different origins and just *happen* to be a 
> mixture
> of slab originated pages and non-slab pages combined together in a single 
> bio of a bvec entry,
> I'd suspect that it would be more beneficial to split the bvec (essentially 
> not allow bio_add_page
> to append the page to tail bvec depending on a queue limit (similar to how 
> we handle sg gaps).

So you want to add a PageSlab check to bvec_try_merge_page?  That sounds
fairly expensive..


