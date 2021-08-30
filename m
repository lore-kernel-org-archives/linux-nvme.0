Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD5C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 20:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7461260FC0
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 20:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7461260FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+pqg2jeeFQjOtH65I4h6Pg9QT+lRdPgA3ki0P5j8X+s=; b=tQ2zHiLhZ55pOO
	Qs65kmL+1qYVQ7gPzNS+2zjbjAcG/rRIyUJj44f62LTZZZNGGYn+bqZzjJP8X1NGpSvK1h4aq2qVm
	3bTC2srLEDbj9C5kamw/qH06920CdA8BVKhNdrr1/RRuV824ZUqLljVGkOdoUh94QyWdtIdS33AEV
	DT5Ss9y6e2PqxJgN7rnt404gPyb3oz6tV8acglLgFWbLadQOEt66sQygV7OUCanuL9T0BIpxEYcVp
	cnDKnSl6NNZrFiyzS0yCus+3+2ir8XllqOO9gVB3mzlpokge53s8GzK0pS53USFlBzMMgImWtnIBh
	zc0LXH0whyocvNFeYNXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKo6b-000WvS-3T; Mon, 30 Aug 2021 20:42:09 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKo6Z-000Wv2-7h; Mon, 30 Aug 2021 20:42:07 +0000
Date: Mon, 30 Aug 2021 13:42:07 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hare@suse.de, bvanassche@acm.org,
 ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mmc/core/block: add error handling support for
 add_disk()
Message-ID: <YS1Cn6yMbpQGFOYe@bombadil.infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-7-mcgrof@kernel.org>
 <YSSN+eac2aCFXTAA@infradead.org>
 <YSkyHINtV/djFEej@bombadil.infradead.org>
 <YSnme1mfHS/HCguW@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSnme1mfHS/HCguW@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Aug 28, 2021 at 08:32:11AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 11:42:36AM -0700, Luis Chamberlain wrote:
> > > >  	if (area_type == MMC_BLK_DATA_AREA_MAIN)
> > > >  		dev_set_drvdata(&card->dev, md);
> > > > -	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> > > > +	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> > > > +	if (ret)
> > > > +		goto out;
> > > 
> > > This needs to do a blk_cleanup_queue and also te kfree of md.
> > 
> > If mmc_blk_alloc_parts() fails mmc_blk_remove_req() is called which
> > does both for us?
> 
> Yes, but only for the main gendisk, and those parts already added to
> the list which happens after device_add_disk succeeded.

Ah yes I see that now. Will fix up. The tag also needs to be cleaned up.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
