Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3600C4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 13:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C657320856
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoM0pLG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C657320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BmJPobc67YO1kPZajlNnJGU2XxYbjHrS3Jqbfykq7BM=; b=XoM0pLG1sfqmA9
	feWwQtdzZ5YZPRk25gZFWetqtpWZpAwhv8mQAEVsKJd/5sygfzo8AgcyPgJnKVM9bHwX3ZIFc+zxt
	t/6iZ0jeKO0sV5sAdMT43meZJlJmxfHLa1O7s8xsXZ0XQwcQoZbym7+EB+pQmtOUAymSXFlargkgu
	c5+txUn5qr+xrjoAAWHz7usqc7f5Tsjdos1Cw7Tj/PsgKiieds5eJG7tVRrINvwjhW4IELibPqlte
	UvF5XeLyy7iKVTkKR2NBu6EF8PLCJQyOC7DLgAR27x+1b5uGsQKpc1K7szpgARBo5qJ/p/koDLCag
	iBfWbh486Twb/sM9sNhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAZyP-00007a-66; Wed, 18 Sep 2019 13:26:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAZyK-00006w-HH
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 13:26:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4020868B05; Wed, 18 Sep 2019 15:26:11 +0200 (CEST)
Date: Wed, 18 Sep 2019 15:26:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190918132611.GA16232@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
 <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_062616_725771_9F7C7FF0 
X-CRM114-Status: GOOD (  17.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Rakowski,
 Michal" <michal.rakowski@intel.com>, "axboe@fb.com" <axboe@fb.com>, "Baldyga,
 Robert" <robert.baldyga@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 17, 2019 at 10:39:09AM -0600, Keith Busch wrote:
> On Mon, Sep 16, 2019 at 12:13:24PM +0000, Baldyga, Robert wrote:
> > Ok, fair enough. We want to keep things hidden behind certain layers,
> > and that's definitely a good thing. But there is a problem with these
> > layers - they do not expose all the features. For example AFAIK there
> > is no clear way to use 512+8 format via block layer (nor even a way 
> > to get know that bdev is formatted to particular lbaf). It's impossible
> > to use it without layering violations, which nobody sees as a perfect
> > solution, but it is the only one that works.
> 
> I think your quickest path to supporting such a format is to consider
> each part separately, then bounce and interleave/unmix the data +
> metadata at another layer that understands how the data needs to be laid
> out in host memory. Something like this RFC here:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2018-February/015844.html
> 
> It appears connecting to infradead lists is a bit flaky at the moment,
> so not sure if you'll be able to read the above link right now.
> 
> Anyway, the RFC would have needed a bit of work to be considered, like
> using a mempool for the purpose, but it does generically make such
> formats usable through the block stack so maybe try flushing out that
> idea.

Even if we had a use case for that the bounce buffer is just too ugly
to live.  And I'm really sick and tired of Intel wasting our time for
their out of tree monster given that they haven't even tried helping
to improve the in-kernel write caching layers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
