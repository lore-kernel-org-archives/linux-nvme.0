Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6FC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:02:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3EC206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j2kx8Vzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3EC206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i62c8eyfHaa3B1Bkl6wym8m66QRw6s01DcZ4T8rZ5A0=; b=j2kx8VzjSZaxQnnC3niFA8qPm
	/eQ+lYQpcdUa2JF+NCwU7Nq2D0Thjndqo07kGOVwn/74fquDIb2vGMyY0LIDU2B2k5moBH2zpLJZY
	eB1mVYbb6MdtADrlXgrIqkZJkmugW73Gie2F80ntV44hLKlHkxGMOZRD5Vkv9DUEq1E3ZuVpJAV+6
	p9LKzIO1vQllPKb15GtKcs1EPBr2r2b4ocloZ2HWHsnAWqLXliuHgZymlXUC6kFKl7I2baz2vLLCs
	fP3VN0vbxUOsg0Mv4HX35FhoWOKNTS1AJSLUR8v4TGSyE/J6mTzS9kirH5DAA+mOaRiQGibWhHqL1
	CI+Ulem9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85w3-0006gt-1L; Tue, 18 Aug 2020 18:02:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85w0-0006gG-1T
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 18:02:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 998FC68AFE; Tue, 18 Aug 2020 20:02:05 +0200 (CEST)
Date: Tue, 18 Aug 2020 20:02:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: skip noiob for zoned devices
Message-ID: <20200818180205.GA29087@lst.de>
References: <20200818162941.2674340-1-kbusch@kernel.org>
 <20200818172504.GA28474@lst.de>
 <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_140208_237569_719B106C 
X-CRM114-Status: GOOD (  19.99  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 10:50:54AM -0700, Keith Busch wrote:
> On Tue, Aug 18, 2020 at 07:25:04PM +0200, Christoph Hellwig wrote:
> > > -	if (iob)
> > > -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> > > +	if (iob) {
> > > +		if (!blk_queue_is_zoned(disk->queue))
> > > +			blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> > > +		else if (!(disk->flags & GENHD_FL_UP))
> > > +			pr_warn("%s: zone namespace has unused IO boundary:%u\n",
> > > +				disk->disk_name, iob);
> > 
> > This has some overly long line and looks fairly convoluted, what
> > about something like:
> > 
> > 	if (iob) {
> > 		unsigned int chunk_sectors = rounddown_pow_of_two(iob);
> 
> Unrelated to this particular patch, but ... why is this rounddown here?
> While we can't use chunk_sectors if it is not a power of two, but what
> benefit are we expecting to get from using the wrong boundary just
> because it's convenient to our block stack?

True, might make sense to add a validity check instead.

>  
> > 		if (blk_queue_is_zoned(disk->queue) &&
> > 		    chunk_sectors > blk_queue_zone_sectors(disk->queue))
> 
> I don't think we should skip iob just for the case where chunk_sectors
> is the larger value. A smaller value still ruins things like
> blk_queue_zone_sectors() and blk_queue_zone_no().
> 
> Also, we call blk_revalidate_disk_zones() after the iob check, so the
> blk_queue_zone_sectors() hasn't been initialized for this revalidate.
> 
> > 			pr_warn("%s: ignoring too large IO boundary: %u\n",
> > 				disk->disk_name, iob);
> 
> We don't want to emit a repeated warning on every disk revalidation, so
> I added the check for GENHD_FL_UP to warn only on the very first disk
> validation.

Ok.  Maybe we just need to move the whole thing into a helper to look
less confusing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
