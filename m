Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD43C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 17:59:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE7B22263
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NrI/UkKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE7B22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RiqOX4ZrRwW7VW2cZvNMZYCMfRDYM6ovjR3vUjkv+uQ=; b=NrI/UkKs7/594z9fRIm/8xyeB
	oHp7XMgA5+K6wdF7231cCpKLc8Jt9DeV7yM8z+v2IfO2qT7jsgtCDH+6TBXgClaQ7i/bMsAtSdrg5
	T+2HkmNzCkDZrLjtO+H1FdqhnuoPUApHggJA8O/mRIr2d+2l8cgrUZvXiP8RjyRJm3dufLeOExty2
	SRibM/rHoxbWMSv8GWLtk5S5J63QAVo+53AiL8RsK997IoZk0ne2a34telbcsCBTOs/RJ/jtuUUy1
	jTj5DG9nnS/1NrBA6ffdCc+fUju1PJwC+llN5+Tm5CzSnVCVgilMoOgT4WqigPwzEJIheclsblWcS
	nRe6Jti4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kT7XY-0002CA-Dl; Thu, 15 Oct 2020 17:59:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT7XW-0002BY-8Y
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 17:59:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0D4EF68B02; Thu, 15 Oct 2020 19:59:44 +0200 (CEST)
Date: Thu, 15 Oct 2020 19:59:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: set passthrough command gendisk
Message-ID: <20201015175943.GA23361@lst.de>
References: <20201014203845.1400053-1-kbusch@kernel.org>
 <20201015074222.GA14082@lst.de>
 <20201015144548.GA1401094@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015144548.GA1401094@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_135946_419722_8589625A 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 15, 2020 at 07:45:48AM -0700, Keith Busch wrote:
> On Thu, Oct 15, 2020 at 09:42:22AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 14, 2020 at 01:38:45PM -0700, Keith Busch wrote:
> > > The nvme event traces for IO commands are reporting the wrong QID
> > > because we never set the request's gendisk. Set this parameter if the
> > > passthrough command is being sent through an IO queue.
> > 
> > Why do we event need the check for a non-NULL disk in nvme_req_qid?
> 
> It's the criteria we use to know if we're tracing an Admin vs IO
> command. I suppose we could change the criteria we check rather than set
> the disk parameter. Maybe rq->queue->queuedata instead of rq->bd_disk.
> Would you prefer that?

Yes, I think that makes much more sense.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
