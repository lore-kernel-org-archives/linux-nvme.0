Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6296C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 15:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF16204EA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1fVWwXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF16204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qX6+amyTZMNftuF3WHy+yfTN3Z8IKbtUrY+UhflebE=; b=F1fVWwXEp0ULAB
	fDdLLs9SPTswTwjd9yQQBoW2G52Rdcjp3mj5ZEI+mow1nU5S9UgJ4XNnT9FmBZsbj5aEpgXw0Z+MP
	I4WJOf/Q3eharvyNv5e6oDmOvlPmGuguIvYMcCjGzSxvpr/0DO4gXr9y/msgsvUD1UywxFT08n6uT
	L5/nsoZvdofMTvgtoEZ0SBJX7u29w5rRh93jbMxvWc5/SDtIbmWSHzBZ0DkltaiFoZe14cWh+aR5Z
	k5oo7+JwDbqbG0a6scU2hcH9AxYXWyWFELjtJXi5qsNk4CdFH82BWM4rfwyZhDSKWLMz3LKEktGQR
	kqbJr5dFAkzRjVL6ZDUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbn8Y-0008Qn-Ku; Thu, 21 May 2020 15:29:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbn8V-0008QI-Hy
 for linux-nvme@lists.infradead.org; Thu, 21 May 2020 15:29:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B644668BEB; Thu, 21 May 2020 17:29:29 +0200 (CEST)
Date: Thu, 21 May 2020 17:29:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: set dma alignment to qword
Message-ID: <20200521152929.GA18535@lst.de>
References: <20200521022253.3268324-1-kbusch@kernel.org>
 <77425d7c-e8b8-b012-b1b3-c083b0b3af3c@grimberg.me>
 <20200521152820.GA3269657@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521152820.GA3269657@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_082931_743043_5B0199FD 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 21, 2020 at 08:28:20AM -0700, Keith Busch wrote:
> On Wed, May 20, 2020 at 11:05:51PM -0700, Sagi Grimberg wrote:
> > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 805d289e6cd9..ba860efd250d 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2283,6 +2283,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> > >   		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> > >   	}
> > >   	blk_queue_virt_boundary(q, ctrl->page_size - 1);
> > > +	blk_queue_dma_alignment(q, 7);
> > 
> > Shouldn't be an issue for rdma/tcp, think that it should also be OK for
> > FC as well but not sure.
> 
> Okay, just to be safe, I'll make this a nvme_ctrl_ops callback.

No callbacks please, especially without users.  If FC needs an override
we should just add a field to struct nvme_ctrl.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
