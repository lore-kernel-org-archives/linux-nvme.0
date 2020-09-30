Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1276DC2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:12:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A4B20754
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 06:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/rEngq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4B20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LA/AKozjjX8hYIElv8mAJVv+RIl65waZzU1jw7WN+Po=; b=H/rEngq8RcESSS3Kwm/iBDJEo
	X5Bnph4rp5FBphwj5dKus9pddXRLQ9SbJ2bnD0EHx5NpOqqW8rSX6iwCK6pzciGCr4R9cHZKQnV/l
	N48NgBqptJUdrXQs60C6gwvvH8420icUbITtJmyDLOOr9o5SSy42zAuelIW8TbzzFEdlYYZplmiGC
	LJ2W5sujTQSXx6BC3LPJY4wBVq6wfvKsmNWk9M+UbiLRDi0BvdXWFKi5FQwlUIB2IxqMXSEjGGy1i
	fp9Nyk9QBr8oxoSXvDiSvARXWvHMQ1J5qGFSKEsJWnWQc6agbWzQE+yOEBUuyA6sWNzJn9bKtkTW3
	ybh9bRnHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNVLt-0008SN-3L; Wed, 30 Sep 2020 06:12:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNVLp-0008R4-Si
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 06:12:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DE5BF67373; Wed, 30 Sep 2020 08:12:25 +0200 (CEST)
Date: Wed, 30 Sep 2020 08:12:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Message-ID: <20200930061225.GA1939@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-14-hch@lst.de>
 <BYAPR04MB4965A6DFE5D488DDAA31876D86320@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965A6DFE5D488DDAA31876D86320@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_021230_062944_CE4C7D9C 
X-CRM114-Status: GOOD (  20.29  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 09:52:17PM +0000, Chaitanya Kulkarni wrote:
> On 9/28/20 05:46, Christoph Hellwig wrote:
> > Only set the queue limits once we have the real block size.  This also
> > updates the limits on a rescan if needed.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/core.c | 46 ++++++++++++++++++----------------------
> >  1 file changed, 21 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 910198c3e0bbd1..bb630d5fcb9647 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2010,6 +2010,26 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> >  	return 0;
> >  }
> >  
> > +static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> > +		struct request_queue *q)
> > +{
> > +	bool vwc = false;
> nit:- If we are initializing vwc why not :-
> 
>  bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT ? true : false;
> 
> and get rid of the if before call to blk_queue_write_cache() that way
> 
> all blk_queue_XXX() calls will look smooth.
> 
> Irrespective of that, looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This is just a code move.  Feel free to send an incremental cleanup.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
