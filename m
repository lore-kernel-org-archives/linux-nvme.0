Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FBC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:12:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0782078D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KL6umwyw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGpp3Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0782078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CszgQ3V4ILcdUb0tH29dTID17tI/8RZcuJqIdrpesXE=; b=KL6umwywcNLj6lQjnok4ZhGAc
	7pTYvnmAJ6FCsIOl0xLKCqd67d2+nxbJoiVM1cOVg+rXXFjnSroxKX8Y1M+rtTg/kP1VshJUbvpwo
	pt2leeSlcvBw44EkIUkYjygT14Y3NP9wKFiNjY2FlcL+dcMnjYYoFMBMLMJUu4c+Vq97FkyjPYzds
	0CZEfJiVn6SahdpJWJgsxKRSUA5m/GyWP51UZWYXgJ3sVo/qu867VvRvKDnXyFNALdEFOQg/wnAlx
	g7Pwgndl2L3LD++FbOokD02IgOfIScObX7SWfxxpFc1fLRiLfs4W95O7UNTaW0aXhkO0gEJZMrDyT
	PQ1UGXYVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6cJP-0002aP-TO; Fri, 14 Aug 2020 16:12:11 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6cJN-0002Zz-GO
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 16:12:10 +0000
Received: by mail-il1-x144.google.com with SMTP id j9so8863200ilc.11
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gRQztR56iu3aM7IPkfJ9L3Boyqvrwwaj0DJy4n3MiCE=;
 b=UMGpp3Q/qPHvVuL6uaJjaSEdhIz3jC/WbLrrgJGe5DhLnMP2ZpiMuRnI5GyTGS79Yz
 RlflnIt7ZgWY9kMX1lvqjl6uy19GbzRrVvnn4uPQkvplYmr53tZqXxNlP88wAWQVh4Rf
 Zd+rCnQ/rjwSQIx7KMcKTIkX9XVayS4q2Y+QdNZggMzBTFlWK+JCiXdG4LFW63gUlWKi
 1blFBNsmh7mlYgL1aY3WjOo8YIEffbMxIQXOLbwXc/qPUwoks/Fdl/FtNuWDPPE7J3F1
 8MScQLNczXCzU5nSeLfUzo/9t9HpsZFIU8Zp7ssST8H8YSLQq4G37Q22QIqvLoq5xSwJ
 UOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gRQztR56iu3aM7IPkfJ9L3Boyqvrwwaj0DJy4n3MiCE=;
 b=YxIQmahoawgNb1ak+B0OmJ30p+qq78bIcQa8BLa1DERc5Yi80l18zA2ENz5FV7L0MC
 3t6PJSFgDTXqw2t4n/IYM30AlFpijnbO9aXIbySPL3rX63LhhlOuUqc0HbLN8hcO3Edq
 2QpOEd5icDauUOvmu4szxxHDdXWTP00aK+x6ZQkV4T2yxyQlsh0cYzLjEVrfHoViwfnk
 FPwmS2KLqfy5J9vOX1UaGySjq+kz6hCGvN2HaCBzjF6JEcxqhlDEw22KZczL6ek1z+cP
 mDVEzqM2kGSrJgegYe8c/Zz8Me9AMfxQb6KB9J1gsEqUSNYSRX6gfTjJDkAsdGulsXQZ
 S12g==
X-Gm-Message-State: AOAM533Xxa9kn7YB+MyaL0QNA2mLNjVN/tfVf38QD7w4r8r3eV4wBeQ4
 hLbivDYUFa2Rt9MWlBxgRP/AleSGVKhqqYxxhPY=
X-Google-Smtp-Source: ABdhPJzUHPJH7IZhco2y/VyghwJqsaIiBDeryQlRsIEB6CIoj/XJJXMd6IswCHBxvtEreYF7+XAIc9PMNoZTvhyg7NI=
X-Received: by 2002:a92:ad01:: with SMTP id w1mr3264199ilh.301.1597421527773; 
 Fri, 14 Aug 2020 09:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Fri, 14 Aug 2020 12:11:56 -0400
Message-ID: <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_121209_573791_FA5B6B8F 
X-CRM114-Status: GOOD (  14.55  )
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

On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > >                        req->tag, nvmeq->qid);
> > > > -             nvme_dev_disable(dev, true);
> > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > +             nvme_dev_disable(dev, true);
> > > >               return BLK_EH_DONE;

> anymore. The driver is not reporting   non-response back for all
> cancelled requests, and that is probably not what we should be doing.

OK, thanks for the explanation. I think the bottom line here is to let the
probe function know and stop proceeding when there's an error.
I also don't see an obvious reason to set NVME_REQ_CANCELLED
after nvme_dev_disable(dev, true).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
