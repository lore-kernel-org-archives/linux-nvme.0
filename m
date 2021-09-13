Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60776C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:25:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E7960ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21E7960ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Bzy6e2TWA6PY+3H8OcfUP1nUHZi93DHeFXTFlZcIl4=; b=HzX0i5/463UjMf
	vyvcdJwQx68zo9GizJ3R2EGdBZllrWxH07aEgjQ1b4wEN0fNT2oZcsn5hNyRrtXaDUUbMQZa/Be7Y
	AEE+PwfKOvGEqGBUgH3fK81xgFt0EYDpYx8VhKN/jLWkovnj7Xy6bH7MGf7KQJaRWPQNoICuxW9pR
	0O6pfMeCk615bDcvyaSk2DrIpjTNZaco6h4mzD3RBfxnh0BLq2vPdmlYq5VK+SFaSaEqG370+KvNz
	UTxTsAopgeR/vNLrmRj+CgiBN6t9NZpKncj3VKAATpwhsVA8O4cU3KWle3pl6JhuNylM0atlTLTpV
	g049HXeR0chxja/zhCSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPphe-002fv0-I4; Mon, 13 Sep 2021 17:25:10 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mPpe0-002eih-G4; Mon, 13 Sep 2021 17:21:24 +0000
Date: Mon, 13 Sep 2021 10:21:24 -0700
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
Subject: Re: [PATCH v3 1/8] scsi/sd: add error handling support for add_disk()
Message-ID: <YT+IlJnSZzG0j0ON@bombadil.infradead.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-2-mcgrof@kernel.org> <YTbAYyo0+rqUZ+L0@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTbAYyo0+rqUZ+L0@T590>
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

On Tue, Sep 07, 2021 at 09:29:07AM +0800, Ming Lei wrote:
> On Mon, Aug 30, 2021 at 02:25:31PM -0700, Luis Chamberlain wrote:
> > We never checked for errors on add_disk() as this function
> > returned void. Now that this is fixed, use the shiny new
> > error handling.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/scsi/sd.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 610ebba0d66e..8c1273fff23e 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3487,7 +3487,11 @@ static int sd_probe(struct device *dev)
> >  		pm_runtime_set_autosuspend_delay(dev,
> >  			sdp->host->hostt->rpm_autosuspend_delay);
> >  	}
> > -	device_add_disk(dev, gd, NULL);
> > +
> > +	error = device_add_disk(dev, gd, NULL);
> > +	if (error)
> > +		goto out_free_index;
> > +
> 
> The error handling is actually wrong, see 
> 
> 	https://lore.kernel.org/linux-scsi/c93f3010-13c9-e07f-1458-b6b47a27057b@acm.org/T/#t
> 
> Maybe you can base on that patch.

Done, thanks!

 Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
