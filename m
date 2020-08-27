Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38548C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:50:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676C206EB
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7/9Dkh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676C206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sSMyU+sYVY4C7bWx11X/m4R6/twAeSgX/k6Z/pFI6gw=; b=N7/9Dkh1YYUe+rBOcNd0vc/g2
	5ogW7rAGDkAhTCWfslwD4uPvi6K1m9i2mG6M2rXf94StZOxa4s85UI3GYyb0qYtK27UJb6R5Bbn6z
	1Y0hRNa0HI4vJjMgdOLYMHwCtdEKdGk2vmO/0z9Zx7rcx+CPy4Kur5uBnZhGP3u5fJHf2+tEcN22c
	0uMpu9zpJgCDFrBfqrQRuTotQ1wMu2PJ8PAgxfteQBE9JUPxf0DqCP1iCKzunD54jop2+gpiB1/6a
	OQ58YJZT3yNYEzMdnfJQ7FdB2arFDEKkg/95bB902aXgDhGEYboFWPBaGvF/Jla1FF6u61sRzXiqG
	zS9fEQ2Bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBL6t-0006aa-0t; Thu, 27 Aug 2020 16:50:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBL6p-0006Zs-FG
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 16:50:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE76C68C4E; Thu, 27 Aug 2020 18:50:40 +0200 (CEST)
Date: Thu, 27 Aug 2020 18:50:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200827165040.GA14404@lst.de>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <20200827160644.GA10869@lst.de>
 <20200827164405.GA2810820@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827164405.GA2810820@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_125044_392522_F6145F18 
X-CRM114-Status: GOOD (  15.87  )
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

On Thu, Aug 27, 2020 at 09:44:05AM -0700, Keith Busch wrote:
> On Thu, Aug 27, 2020 at 06:06:44PM +0200, Christoph Hellwig wrote:
> > On Thu, Aug 27, 2020 at 08:28:24AM -0700, Keith Busch wrote:
> > > +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> > > +		blk_queue_chunk_sectors(ns->queue, iob);
> > > +	else if (iob && !(disk->flags & GENHD_FL_UP))
> > > +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
> > > +			ns->head->ns_id, iob);
> > > +
> > 
> > Similar to the zoned stuff I just find this super hard to read.
> > 
> > I wonder if we need to untangle this a little.  Something like
> 
> That's fine. Do you want to see a prep patch splitting chunk settings
> first then power-of-2 check second, or okay as a single patch?

I don't really care, whatever suits best.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
