Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8849BC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:51:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586052080C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zmfacb42";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xi2z/Ddt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586052080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lKBnyBC5b++FTR0TEBCsN5p4KI8XQ4aLx6ubr7h5aKw=; b=Zmfacb42C9RmXUD9HZb9P3OST
	SKYeb7yDh0me4OCJuB5M6gfLF42lZo6JTohxhH2hPQhd7dX88IRZiAtl7YqHhnvhdrNjG+jT3oyq6
	ev8zSB4DXEGgBH3aKvyPVeAEtDyQh51tF3k2Rk7zWUJt9cy5f5YnksuDHDZuW2/svUffUc7yYAc6y
	atfgOgKFOoml118ydTCM7Hu9Z0lLTvBTEjKnno/H3gCTIoS3C97r9ivR71mqyNLybdBdqRBFZsoXA
	7RykszuhQV1fsUjF2XVO0W8qgtgA3oiWMLFMG8X/p77H1izCy+YYM10tWNoa6A5aTK+InfFVx3uzp
	bC+fSFsdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85lE-0005ES-Lp; Tue, 18 Aug 2020 17:51:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85lB-0005DH-4q
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 17:50:58 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07BB72080C;
 Tue, 18 Aug 2020 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597773056;
 bh=s+DSNksl40l5EXB7SvWfjhAMaCbxGfdczLoK2A7VuyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xi2z/Ddtoq0dxGqlBQzSA9PjdKYK+xQLMbLuS5jir1IyPFYjrOIgCoW2RBSjyeX2l
 vZakBaeWwk6mhoU/o+srxZ2bFsJuMGSX1wCQOqq3FXLCbQcH7x+vxop6nVkG8mRHFd
 R1kNl87v0+OT2NtC+Kk8S3LVpTyXnASMvL/zG8A8=
Date: Tue, 18 Aug 2020 10:50:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3] nvme: skip noiob for zoned devices
Message-ID: <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818162941.2674340-1-kbusch@kernel.org>
 <20200818172504.GA28474@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818172504.GA28474@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_135058_011444_4E341561 
X-CRM114-Status: GOOD (  17.72  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 07:25:04PM +0200, Christoph Hellwig wrote:
> > -	if (iob)
> > -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> > +	if (iob) {
> > +		if (!blk_queue_is_zoned(disk->queue))
> > +			blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> > +		else if (!(disk->flags & GENHD_FL_UP))
> > +			pr_warn("%s: zone namespace has unused IO boundary:%u\n",
> > +				disk->disk_name, iob);
> 
> This has some overly long line and looks fairly convoluted, what
> about something like:
> 
> 	if (iob) {
> 		unsigned int chunk_sectors = rounddown_pow_of_two(iob);

Unrelated to this particular patch, but ... why is this rounddown here?
While we can't use chunk_sectors if it is not a power of two, but what
benefit are we expecting to get from using the wrong boundary just
because it's convenient to our block stack?
 
> 		if (blk_queue_is_zoned(disk->queue) &&
> 		    chunk_sectors > blk_queue_zone_sectors(disk->queue))

I don't think we should skip iob just for the case where chunk_sectors
is the larger value. A smaller value still ruins things like
blk_queue_zone_sectors() and blk_queue_zone_no().

Also, we call blk_revalidate_disk_zones() after the iob check, so the
blk_queue_zone_sectors() hasn't been initialized for this revalidate.

> 			pr_warn("%s: ignoring too large IO boundary: %u\n",
> 				disk->disk_name, iob);

We don't want to emit a repeated warning on every disk revalidation, so
I added the check for GENHD_FL_UP to warn only on the very first disk
validation.

> 		else
> 			blk_queue_chunk_sectors(ns->queue, chunk_sectors);
> 	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
