Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9898DC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:42:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653B420829
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vlf+bJmp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="auPdDnyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653B420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WQVLDWzz3Wyb4dN9kbXkCipm/Q3jG+2Nslhkd5eb/vc=; b=vlf+bJmpdrPH2x/F2eJiBvJ6S
	kgtqW530GfA/3OIWVXG7cl3ULW5i6ut/z1TV5dT9ZhoIzyHWtEKI8nGIJEJN/lrYx7ANyxqFYAHLn
	PSwBXnLnA59c0OFWo3y7+asdxfsg5KlwoA4FcSlyIoQbsOj7o6DNXRAzW7qZZPqUV1dF62nwlZVu9
	jEhmVV2AESOfJbBsO/rglFO2G/7l+JJ+Bkkj4NQKeLfvhTyPGKV+eE48FNzPG+TqgKOETvo1JPuf6
	OixFkj5bTWvtCQxllvmH7U5zLS1i7wlihvAGBC4OW4N49nQTPCAZuqHAuN6zVwXGMC3sCMuq5tMBY
	8qy/R73xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bqo-0007yh-Tr; Fri, 14 Aug 2020 15:42:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bqm-0007yD-Pa
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:42:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A750C2074D;
 Fri, 14 Aug 2020 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597419756;
 bh=+up87sODqYUrxoIZ1gLOYF3UjeAagJtD1rwQwhmj+sU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=auPdDnywEkEQZk0vPg/NbewQ0pEX3D+Q+m5H0419IlYT8+910NKmGJScWULSYGe6E
 wkvKNjrPurKntZdHZGeBBNXtlflPAr5YX3Ow1nUlNnKLM6oIrb0FPcjYqXGen+HthJ
 riJoe9Wvp/0VBAfr66Vu9TCM3RdrDK0e7GC9jGpc=
Date: Fri, 14 Aug 2020 08:42:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_114236_926611_4C6960CA 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 11:37:20AM -0400, Tong Zhang wrote:
> On Fri, Aug 14, 2020 at 11:04 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > >               dev_warn_ratelimited(dev->ctrl.device,
> > >                        "I/O %d QID %d timeout, disable controller\n",
> > >                        req->tag, nvmeq->qid);
> > > -             nvme_dev_disable(dev, true);
> > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > +             nvme_dev_disable(dev, true);
> > >               return BLK_EH_DONE;
> >
> > Shouldn't this flag have been set in nvme_cancel_request()?
> 
> nvme_cancel_request() is not setting this flag to cancelled and this is causing

Right, I see that it doesn't, but I'm saying that it should. We used to
do something like that, and I'm struggling to recall why we're not
anymore. The driver is not reporting   non-response back for all
cancelled requests, and that is probably not what we should be doing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
