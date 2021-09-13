Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF82E610D2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF82E610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wSfF4h71BmcIGVsKdL1ruK/43YMNY5KhHu9Rx+Sx28M=; b=CU1S+bOfDRxgzO
	ZEG8tYYMhU0J4M54nyCu34qAuwmoBg/ZEl6hR9muWeqs9/pyEYyBmz3UaSJPUplubV/YX30Djo43Y
	KiVO/IpPV2hPi/Yx0vIks1Ii7RpA52LPILQQxHTL90v3ZfLtXMoSMPrDE8qY3op/oR58VnoJmBJcV
	mC6Z5WcdDgyBzAWC7lOBrkDVd7CQ3iXGjWXeEDW7wSSQ1jFnVLM6M/J4CEcEhdTQu2z7axQJ6O3jf
	TpAKslOg83NigpAcDzwojX7PegrKQ0IGppi29GU4p+yh74Cfut2w/n2rgXnseNDwmy/YyOvRxMyoN
	zZffcikJk72SJ/+2SCbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPplH-002h78-PI; Mon, 13 Sep 2021 17:28:55 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mPpib-002gGS-4q; Mon, 13 Sep 2021 17:26:09 +0000
Date: Mon, 13 Sep 2021 10:26:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/8] scsi/sr: add error handling support for add_disk()
Message-ID: <YT+JsQ7pgtz0E2ZK@bombadil.infradead.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-3-mcgrof@kernel.org> <YTbCQdieHG07Bz8W@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTbCQdieHG07Bz8W@T590>
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

On Tue, Sep 07, 2021 at 09:37:05AM +0800, Ming Lei wrote:
> On Mon, Aug 30, 2021 at 02:25:32PM -0700, Luis Chamberlain wrote:
> > We never checked for errors on add_disk() as this function
> > returned void. Now that this is fixed, use the shiny new
> > error handling.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/scsi/sr.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> > index 2942a4ec9bdd..72fd21844367 100644
> > --- a/drivers/scsi/sr.c
> > +++ b/drivers/scsi/sr.c
> > @@ -779,7 +779,10 @@ static int sr_probe(struct device *dev)
> >  	dev_set_drvdata(dev, cd);
> >  	disk->flags |= GENHD_FL_REMOVABLE;
> >  	sr_revalidate_disk(cd);
> > -	device_add_disk(&sdev->sdev_gendev, disk, NULL);
> > +
> > +	error = device_add_disk(&sdev->sdev_gendev, disk, NULL);
> > +	if (error)
> > +		goto fail_minor;
> 
> You don't undo register_cdrom(), maybe you can use kref_put(&cd->kref, sr_kref_release);
> to simplify the error handling.

Works with me, thanks!

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
