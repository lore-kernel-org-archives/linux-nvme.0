Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D4C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8986020731
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EBxT6f+B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMyqKpvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8986020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jp8qVDYsyiDQsdAFsbSB13+IhuP0tk5QL7s/3Dk3Z3g=; b=EBxT6f+BljZUAw9GKdwXvEHJp
	ePvEZ2ubUvYoCWHbrEp3xN1ziPfSgzrR2hKsRMvWLv+FkwOX4WZXxA+35I4NHoLF+cR1Q7vMMQcOM
	1vppJHamfEXpTp1rEDbc0Etqf7LKEha6r4YWVxrE1apMuchRloKOyPJ7Ru4Nkhm95JiMWOSJRaqvJ
	teZS7TCb/pBw0iCevB1vBJ895NBk20wtU6y4J80PVKFMEzrwFJ1/rZR17/hodaaDh6J12PeezxkV+
	SH3Tl6u/N6dTpLVK43Ds/cIZvA+2niuhu+yNsblxOJSthEx1pUI/A4IEvHKvSsQUfaClhWXJterSD
	m9q6djRAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIeY1-0000lJ-Cy; Wed, 16 Sep 2020 21:01:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIeXy-0000jo-M4
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 21:00:59 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 118DE20731;
 Wed, 16 Sep 2020 21:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600290057;
 bh=1uil2Nluygw+9/4s/GyCQXTq7E1rfNz6fwU/7AEnPqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DMyqKpvvkY3XIN43KJeBfEb7qGjX78cNMdWxmLgyidHf3+NvUJx199dGC4eEISPQL
 JizxkUz1N1IYIZddknPNqSJTPAugTHWlMWDf/hY2Y4ea4Tk9FOvxDLCUgrJ8+KGaXD
 hJ7TzRLKcO/C7dBlgvEmOy9udp8iwM8U88SG6nXM=
Date: Wed, 16 Sep 2020 14:00:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv2 2/2] nvme: translate zone resource errors
Message-ID: <20200916210054.GB3676296@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200915181230.3674743-1-kbusch@kernel.org>
 <20200915181230.3674743-2-kbusch@kernel.org>
 <CY4PR04MB37511B210DF4E12A481E0268E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37511B210DF4E12A481E0268E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_170058_806616_88AEE3FB 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2020 at 11:56:46PM +0000, Damien Le Moal wrote:
> On 2020/09/16 3:17, Keith Busch wrote:
> > Translate zoned resource errors to the appropriate blk_status_t.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> > v1->v2:
> > 
> >   Use BLK_STS_ZONE_RESOURCE instead of BLK_STS_DEV_RESOURCE
> > 
> >  drivers/nvme/host/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f3a61a24d45f..6d5c95a3e03c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -236,6 +236,9 @@ static blk_status_t nvme_error_status(u16 status)
> >  		return BLK_STS_NEXUS;
> >  	case NVME_SC_HOST_PATH_ERROR:
> >  		return BLK_STS_TRANSPORT;
> > +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> > +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> > +		return BLK_STS_ZONE_RESOURCE;
> 
> BLK_STS_ZONE_RESOURCE is used in the submission path to tell the block layer to
> "try again later because the target zone is locked". This is used by scsi for
> zone append emulation. So I think it may be better to define
> BLK_STS_DEV_ZONE_RESOURCE to avoid confusions, and that would also clearly
> indicate that the status comes from a command failed by the device, not the
> stack. Thoughts ?

I believe it's safe to use for the completion side since the special
handling is only for submission errors. But I agree this type of double
meaning could invite confusion. I'll send a v3 with your suggestion and
we'll see how that goes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
