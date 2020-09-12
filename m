Return-Path: <SRS0=MiaI=CV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA92C43461
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2020 06:41:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F726214D8
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2020 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFQ56cUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F726214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PRdts1X9HbPJMvfWXSUSQeGpxnq0reIADFrbybeKQS8=; b=RFQ56cUpv1M97fcvzuIVd908K
	g1rsCa0rY7BUoWcTVHqYmJbTp9DfHW4h1+RIwnoZ0mKoOo4P0LOcBJqsFNcz3DJ9/M/bR6dHVhwPt
	hx1HrLSx7RQtrg9dn584Zt4tOQf2Pwm9zmiVFzTSU8ZRqO+k7fDSkuE+m4Q5g2yBYdYKEPyfhc9WH
	ciEoG2PYbfYWECSi9/p6v6ZOo9Cpx023iEwO4grCgSVBhVgzJCbobmo33weUMpjobfyKfics0YHGs
	q1x02oRL0soYgF5Sl3unuaOtl04+42FtRf+KMoKyXDVnFfeU5iALK9d1Xg+4HCo9BZVgWOGwKZ02h
	OBQ9Kru6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGzDl-0007Nz-Ng; Sat, 12 Sep 2020 06:41:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGzDf-0007Mb-LL
 for linux-nvme@lists.infradead.org; Sat, 12 Sep 2020 06:41:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 81D0868B02; Sat, 12 Sep 2020 08:41:04 +0200 (CEST)
Date: Sat, 12 Sep 2020 08:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200912064104.GA19223@lst.de>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200912_024107_844605_981EF879 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 09:35:31AM +0000, Damien Le Moal wrote:
> On 2020/09/11 15:10, Christoph Hellwig wrote:
> > On Thu, Sep 10, 2020 at 10:25:24PM +0000, Damien Le Moal wrote:
> >>> I'm not sure this is the best idea, we probably need specific error codes
> >>> if we want file systems to be aware of the limit.
> >>
> >> Do you mean something else than -EBUSY being returned to the user by the block
> >> layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
> >> blk_status_to_errno() ?
> > 
> > My primary aim is a different BLK_STS_ code.  But given that I think
> > that we should not map different BLK_STS_ codes to the same errno if
> > we can avoid it, we should probably also use a different errno.
> > 
> 
> Hmm. Beside EBUSY, I do not see a nice existing errno that we can reuse. May be
> ENOSR (out of stream resources) ? Or do we define a new one ? EZBUSY ?
> 
> And indeed if we define a new BLK_STS_ZONE_RESOURCE and map that to EBUSY,
> errno_to_blkstatus() will get confused.

Yes, you need to pick a new error.  I don't really care which one,
most of the mappings are pretty odd anyway.

> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
