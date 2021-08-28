Return-Path: <SRS0=poiV=NT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D727DC432BE
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:33:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DEF610C7
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96DEF610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=amSEx1Mvlw3veQH8aCdFSw4wwvDhe31wTqTTGx+X6co=; b=JEkD/zyOBJrBIp
	S43Usm4oSSI22U9oVcwEXPX1KWva2Z+kEWavaDu5ZzQrZErpNDP9VyCz2LrfeJjqNXjm3v4xxXR+h
	t2DMbLTNb4RQWdu+S/3EGpFkBT/J7WZIUgCkX2gDkZhpgfJbfhpm+L0xElo+9+t7Nhul/bENYq7op
	kIw8V5K2zBUXENVRmGFqyFaiY72o/+mZro5SIxwwiOw83sNq8JUt4dXSCdeuq71WzpGPpvb0rzEFg
	uBBnsw6z6crRkQJw6Khgc1vhKw4H6MQB5EwgeP6KHUTQWd+WdmVzBJ4V1QZ4qKnT793sBxJkI+Ct9
	sxPQ3Z6TVgccRb+YUKHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJspz-00Dqpa-EL; Sat, 28 Aug 2021 07:33:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJspy-00DqpB-AI
 for linux-nvme@bombadil.infradead.org; Sat, 28 Aug 2021 07:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=js+UWYNM8YPTLRZ9ERhhOXxsAZmGo7ttkBYVZv/l62E=; b=MtDOH/dQOYQf+MXWY+D5I7cimb
 fy2CtDFjdVWCJSJZeW/Rl27SSbUkyUrjto52ZO169qNA4fujxRkz0Kms4tueEF3gvcXnr25UPeEDi
 qDU19bQcmKoNRQVNAruP+mEqqE2ESkdMq5tdK6I5DYQ+YwO9YkK8K4d89WklXaPcP62ybMNyNO/if
 zoGFKk08exnNTbKFQS4wnvJTA0KuTRuvQA+29IZxpVKLOuRuqqL6xxLMTLgbBl1HulWZ5RXSqzqgZ
 zcPTqTVkvQI+gvE6tldn43E94bYVmTGPeUAvfvhx9LVWm2DZff3E2NSwpUj+IZYPn0EMwccIsj9Kc
 rYcMIPVg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mJsp1-00FNRa-6I; Sat, 28 Aug 2021 07:32:22 +0000
Date: Sat, 28 Aug 2021 08:32:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com,
 hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mmc/core/block: add error handling support for
 add_disk()
Message-ID: <YSnme1mfHS/HCguW@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-7-mcgrof@kernel.org>
 <YSSN+eac2aCFXTAA@infradead.org>
 <YSkyHINtV/djFEej@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSkyHINtV/djFEej@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Fri, Aug 27, 2021 at 11:42:36AM -0700, Luis Chamberlain wrote:
> > >  	if (area_type == MMC_BLK_DATA_AREA_MAIN)
> > >  		dev_set_drvdata(&card->dev, md);
> > > -	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> > > +	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> > > +	if (ret)
> > > +		goto out;
> > 
> > This needs to do a blk_cleanup_queue and also te kfree of md.
> 
> If mmc_blk_alloc_parts() fails mmc_blk_remove_req() is called which
> does both for us?

Yes, but only for the main gendisk, and those parts already added to
the list which happens after device_add_disk succeeded.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
