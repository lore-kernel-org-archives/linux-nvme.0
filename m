Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F2CD4F5E
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edsBSL+SaPE67HXzxXKqJpO41lDkEnVkc2jVW/R7AaQ=; b=jVlRsEtcoZQr+GulLX7bu0ATzD
	GmC7p7Yp/0wOiASyu/Zji9pGYXBrGgx0DA3l4O1J2y1RwujV628ImpVKZXIv3tXV/IxmtSqzPVZvG
	10ciA9KVLkxuUfJ1E2e2jcNlD7M4w17p8HX2v/RKDWCyswWbYlEEyCkCZ4UEHWKi7QB4/EyfS23GI
	RuolBliXcfmCPneW/RuKLE1m0dlFbBsDRTf3hjQRSECBvnNS/MeHFzt1rZ1GYn5wg1/QVNxbni/mN
	1QGAag99lo+4Dk2i+iHeoW3cOTiy8dViHNtyZLIbyyKekMEGDmOHMYwUVOv0xmFaI+NjXezOt42KV
	AiinIAFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPyj7-0000000787u-0fZe;
	Thu, 21 May 2026 08:25:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPyj5-0000000785X-0DDU
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 08:25:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C179268BFE; Thu, 21 May 2026 10:25:49 +0200 (CEST)
Date: Thu, 21 May 2026 10:25:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all
 transports
Message-ID: <20260521082549.GA11208@lst.de>
References: <20260515071248.2689513-1-coshi036@gmail.com> <ag4Y5R1X0gkZbU-g@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4Y5R1X0gkZbU-g@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_012555_248200_5B6D67FB 
X-CRM114-Status: GOOD (  22.55  )
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

On Wed, May 20, 2026 at 02:26:13PM -0600, Keith Busch wrote:
> On Fri, May 15, 2026 at 03:12:48AM -0400, Chao Shi wrote:
> > Per NVMe 2.0a section 5.27.1.12 and the transport binding wording,
> > PCIe MAY support KATO. Reserve one admin tag on all transports so
> > the host is ready when a controller accepts the feature. Fabrics
> > keeps two, the second being for the connect command.
> > 
> > A quirk-based approach was considered but no PCIe controller
> > documented to declare KAS != 0 was found (two enterprise SSDs tested
> > locally report KAS=0), so an allowlist has no entries today.
> 
> I totally get it's optional for PCIe, but that also means it's the
> host's option on whether it wants to use it, and there's no requirement
> we have to. We just need the driver react correctly when someone tries
> to do it.
> 
> I am skeptical anyone would produce a PCIe device that supports it, but
> let's say someone does: what is the use case motivating enabling this
> optional feature in this driver? If it's just because the option is
> there, then I think we can just reject the user command submitting the
> feature for PCIe transports, like I earlier suggested. Requiring an
> active command will just harm idle power states.

I don't think that's quite the point.  We'd have to add special
filtering to fix the reproducer.  Compared to that just reserving
a tag and officially supporting the feature is much easier and a much
better story.

