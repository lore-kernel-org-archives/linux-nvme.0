Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2BC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:16:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4112D2080C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IY+XLYq3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHj+AxsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4112D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sVjGyKZt0L1/Ismchd5l+FrXwK2OyJUtM+qh1/vV0dc=; b=IY+XLYq3BrI3y4CKmtuJANfCu
	cIleWv3QOoH6JA827lb51ntwBdsuGhpxia10JP5v+cXtV1jYolH9JGiGmsdsK9TuiqGVNhzhPOU31
	/0kxjdaUaADbChLu574ON9fLUVjSu+zNSLa5VioaYbdw5nvG27cwSTP+fSOBxe2O5cmsHqCrmd3OE
	VxtBkBw7IVC9EFW4I/8+W52DCJBqhE2xQFLsYBEV53bwJNw+XbCNb/6x7yUD1o9bYnbA5j0PEo3xu
	46TqDcmNLkFidp3Cf4gf0qk6ziRB91vj9bXVM6lTDo0rKByIauSqonKYwSVS48w76AqW5fAgkY2PR
	gW9CPBeRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBVor-0005r4-F4; Fri, 28 Aug 2020 04:16:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBVom-0005om-Qp
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 04:16:49 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8DFF42080C;
 Fri, 28 Aug 2020 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598588207;
 bh=/Pyxxqx/1ZuMOcLLl2KDUdwx3bT2weZ4zmg8PwNs07c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHj+AxsWC09zfqIaSn/xhmGo8R64oMRSYQHv6N8N43BG5Ny3j9E/45ppBJcoVWWHt
 uLJfKu5ha5/DbLEOzKJIDt20Rssu1HLO5rF06vB/NAJzZyZ8crsCceDZ3+nbhVaDx2
 a/+4zEqNOL4Sl6+eFUj50G+dg0PGJoyZjMVd/BuI=
Date: Thu, 27 Aug 2020 21:16:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200828041645.GB2784469@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_001649_039810_5145CE0B 
X-CRM114-Status: GOOD (  16.35  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 28, 2020 at 01:03:30AM +0000, Damien Le Moal wrote:
> On 2020/08/28 0:35, Keith Busch wrote:
> > The kernel requires a power of two for boundaries because that's the
> > only way it can efficiently split commands that cross them. A
> > controller, however, may report a non-power of two boundary.
> 
> I can understand that using a power of 2 limit for splitting can be more
> efficient CPU-wise, but I do not think the kernel "requires" such a limit
> alignment for splitting BIOs. BLK_SAFE_MAX_SECTORS is 255 after all. What I am
> missing here ?

Ah, those two limits are a bit different. The max sectors just checks
length, but chunk_sectors needs to consider length and offset, so
checking if an IO crosses the boundary requires division. For CPU
efficiency, power of 2 alignment is enforced through a BUG_ON() in
blk_queue_chunk_sectors().
 
> > -	if (iob && !blk_queue_is_zoned(ns->queue))
> > -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
> > +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> > +		blk_queue_chunk_sectors(ns->queue, iob);
> > +	else if (iob && !(disk->flags & GENHD_FL_UP))
> > +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
> > +			ns->head->ns_id, iob);
> 
> Isn't this going to generate a warning all the time for a ZNS drive ?

Yes, if a ZNS drive reports NOIOB, this will warn on it's initial
discovery.

As long as zone sizes reuse the queue's chunk_sectors, the zone size
needs to take precedence since it's more than just a hint compared to
NOIOB. If people complain about the warning, that may indicate we ought
to find a way to get around overloading the chunk_sectors queue limit,
but I suspect ZNS drives won't report an iob value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
