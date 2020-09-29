Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA2C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:29:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCB5208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BLeujj5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCB5208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QDcmIs3YiglQb6ahlhVHLwg5F/Me1BPTYLyi48ZZn3w=; b=BLeujj5IF2YFHbbuz0hIhxxzX
	DHubUOu/1w8sCm/AO5d6wjtJ5Fzxg8ZAVeuhTATRUFPywBdTF3/gbcknvs2f1TAvNG0aPJ2Fgsa+N
	TNV+yfz2Z3rrVvdz4I+lynge1fobgP5RXSa88txPchkLHe34GAmCHfsM8dVOEdnjNf6+Crro0oMAE
	k5X2AM8SosM9/G7a3mqaCK/1p5NJ4eUbfAQdUxz7/w8Po4hK1rhSHPaO1IPsNxljZnSe6MQW3bi69
	pX1rGzV9cgGY7ewIJrXA9LZNu58LJu8rq/40VPUT0U46qRfn3zx90B75AeTg3M5pl5CCtnWWxts/p
	ZKLL+2skQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKNA-0003jh-9H; Tue, 29 Sep 2020 18:29:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKN7-0003jC-GZ
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:29:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 409DF67373; Tue, 29 Sep 2020 20:29:03 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:29:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 07/20] nvme: lift the check for an unallocated
 namespace into nvme_identify_ns
Message-ID: <20200929182902.GB12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-8-hch@lst.de>
 <CY4PR04MB375113A310FAD26E94323EB7E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375113A310FAD26E94323EB7E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_142905_652166_1F7BCBDC 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 02:27:37PM +0000, Damien Le Moal wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index fede487f6e043f..7b1423c7e7fc58 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1381,9 +1381,16 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
> >  	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
> >  	if (error) {
> >  		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
> > -		kfree(*id);
> > +		goto out_free_id;
> >  	}
> >  
> > +	error = -ENODEV;
> 
> You could move this inside the if.

I could.  This is a pretty common style in Linux code, though.

> > @@ -3913,9 +3915,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> >  	if (ret)
> >  		goto out_free_queue;
> >  
> > -	if (id->ncap == 0)	/* no namespace (legacy quirk) */
> > -		goto out_free_id;
> 
> There is a call to nvme_identify_ns() above this, and I guess it is OK to assume
> that that function will never return success if the ns cap is 0, right ?
> If so, then this change looks OK.

Well, ensuring that nvme_identify_ns returns an error if NCAP is 0 is
all that this patch does in addition to removing the checks in the
callers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
