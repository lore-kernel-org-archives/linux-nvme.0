Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E090C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:32:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056A860C3D
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A860C3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fl/W945KC5g1h9SZCStbGHF3Qo3Q7DX1KPSjC9WJbfA=; b=19RzF9A+XMzq6eQO2DXZTSZDl
	h/826LXo/huXYsbC0V2Yu9/R1wnyuyb+Av5CWI/dJoeeGM4SE7xijiARHuHZ3ISF4R1IMswTtiPKw
	Lf9rcXZTvRTS3vxwAnZoGC42ckvAReoDFSFHab8F3rqUqSehfZm7guRJhAQmekbZU4uOONzypXatz
	0lYdR9mpHQRxvy0oNIkKFqyxr+4ctvbqG2YvamJ/2IMbBwniHUQ4RO5mv4471+XCDT0JQRpTvEELG
	HgeOWLTAxe4g47zDHS5MfhHJ1u1vPDMAGyTul0PelJ55GC4yHl7ZIMCEbBecg7yVn4NqSXHoiCRQx
	jY9DCOB3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53fR-0003HP-ED; Thu, 28 Jan 2021 09:32:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53fP-0003GZ-Bv
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:32:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 13FDC68AFE; Thu, 28 Jan 2021 10:32:41 +0100 (CET)
Date: Thu, 28 Jan 2021 10:32:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v4 2/8] nvme: cleanup zone information initialization
Message-ID: <20210128093240.GA3212@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-3-damien.lemoal@wdc.com>
 <20210128091710.GA1959@lst.de>
 <BL0PR04MB6514F6AD357E545CBCAB877DE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514F6AD357E545CBCAB877DE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_043243_600085_1209915B 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 09:27:41AM +0000, Damien Le Moal wrote:
> 
> I tried that first, but it did not work. I end up with
> blk_revalidate_disk_zones() undefined error with !CONFIG_BLK_DEV_ZONED.
> This is because blk_queue_is_zoned() is *not* stubbed for !CONFIG_BLK_DEV_ZONED.
> It will simply always return 0/none in that case. We would need to have:

Hmm.  blk_queue_is_zoned is calls blk_queue_zoned_model, which
always returns BLK_ZONED_NONE for !CONFIG_BLK_DEV_ZONED, and I thought we
rely on that elsewhere in nvme.  That is a fairly recent change from me,
though.

> 
> if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && blk_queue_is_zoned()) {
> 	ret = blk_revalidate_disk_zones(ns->disk, NULL);
> 	...
> 
> Or stub blk_queue_is_zoned()...

If the above really doesn't work we should properly stub it out.

Anyway, I think we can go with your current patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and refine all the zoned stubs later.  I have a few more ideas for
improvements there anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
