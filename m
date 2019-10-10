Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FEC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:17:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5642067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uxj0R1p3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxTMPCha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5642067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9pEonVb/5C1yL4dS5GeoNnZ801KsUUtVNADM2YuZsBM=; b=Uxj0R1p3vRrXuN
	PmQNM/naM1HOf3gSJbTyW+ILGzTKqp5DxbWx6GI32cNUXLff13pL1nu8r+IXPsWIPYvbTol450FuA
	vF1h4YYJhwspDOWxxJXrSdhdjfCAu2fmW4IJ0q1vGHaCu2zreTj8wWr5RzzNA2k+kXB9seJuik4+Y
	bAZpVgTytivKOIygN9OrorIuDZ+x7agcFMK15q8DTjASwdmzYeILpMH9M6MeFPdJUfjaKwVXflrND
	iAFjpK3xCyeRtIiLYVrpZW+M6X6U8bcBB62AZKPyi2B+Iw/SlhJc/MfBfRNkveSONBfS5hiBv+8va
	qy/o5XecRfdjvUZ+7FFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIb89-0007nu-IC; Thu, 10 Oct 2019 16:17:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIb87-0007nO-GL
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:17:32 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DED62067B;
 Thu, 10 Oct 2019 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570724250;
 bh=Y6KdujtOMtbhgHxBOW9OyEAY/vpIhs9wwmnQqKvqo+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hxTMPChaWMjL0V1LzwvyNy8jQlmGR83cv3sVwjlTxTV/I/b+ILnj61FoAf1R4cXWq
 5WfQOxLVzh7tGD3s7rC6dUD6pko13lUP5sR7F4qgizncKAk3XLyscPC1DPYqvv46qP
 19u9wOCCsGzmTNm2tNtInJco1CCRSjLBF0OFtIvo=
Date: Fri, 11 Oct 2019 01:17:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 4/5] nvme: Prevent resets during paused controller state
Message-ID: <20191010161727.GA22430@washi1.fujisawa.hgst.com>
References: <20191010160527.22376-1-kbusch@kernel.org>
 <20191010160527.22376-5-kbusch@kernel.org>
 <20191010160911.GA1868@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010160911.GA1868@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_091731_565703_A272CFE9 
X-CRM114-Status: GOOD (  17.03  )
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
Cc: Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 06:09:11PM +0200, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 01:05:26AM +0900, Keith Busch wrote:
> > +/*
> > + * Use this function to proceed with scheduling reset_work for a controller
> > + * that had previously been set to the resetting state. This is intended for
> > + * code paths that can't be interrupted by other reset attempts.
> > + */
> > +static int nvme_reset_schedule(struct nvme_ctrl *ctrl)
> > +{
> > +	if (ctrl->state != NVME_CTRL_RESETTING)
> > +		return -EBUSY;
> > +	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
> > +		return -EBUSY;
> > +	return 0;
> > +}
> > +
> >  int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> >  {
> >  	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > @@ -3829,13 +3843,13 @@ static void nvme_fw_act_work(struct work_struct *work)
> >  		if (time_after(jiffies, fw_act_timeout)) {
> >  			dev_warn(ctrl->device,
> >  				"Fw activation timeout, reset controller\n");
> > -			nvme_reset_ctrl(ctrl);
> > -			break;
> > +			nvme_reset_schedule(ctrl);
> > +			return;
> 
> I don't really see a point in that nvme_reset_schedule helper,
> especially as the name is a little confusing.  Moving the comment here
> and just open coding a
> 
> 			if (ctrl->state == NVME_CTRL_RESETTING)
> 				queue_work(nvme_reset_wq, &ctrl->reset_work))
> 
> would seem much more obvious and matches the nvme_handle_aen_notice
> side.

Until a moment ago, I thought nvme_reset_wq was a local static, which is
why I needed to provide an exportable function so drivers can schedule on
it. I see now that symbolis exported for some reason despite no external
users, but since it is exported, we can duplicate this "if (RESETTING)
queue_work()" stuff from the pci driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
