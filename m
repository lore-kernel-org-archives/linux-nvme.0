Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1936C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VURtLsCsheoHqUG/IiAQsbhuE3CnqnAMdWrv2Tw6ats=; b=E5V0qrAGVcxGXF+6LONRPKg40M
	1n/ab4GkJU+fNCTXILz6aZBHFYFi8jgbTao1Gu5Zm08ITl8KG4IrqH0eX2PeqYHXCFMuC/WdB+mTM
	nsaUi/soR5cetCWPpn2mR+C6GkfP7unUAOkuSu7KWOTlB7TPq+IqkCpCaxXww0woS4ejiG/e0wBUF
	dvh6gUgQYzxj6xxdJfBjAMpis8tZ5h/Z+sb25mwyr9sX1QauNGLFh8rjsAJIygy4Ik/qWLKUDt8Mt
	rl9ibCwqcl/1SdDRS4+6RSAOrApTEwyj9GHaaGfVM+DDQtLMsg7Eobit4xy7f6tENnDVZxwgLt8Gy
	Iw5FQSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEVi-00000004sJH-1rEp;
	Wed, 31 Jan 2024 17:36:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEVd-00000004sGO-3Vjm
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:36:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 69DDD617B5;
	Wed, 31 Jan 2024 17:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC5C433F1;
	Wed, 31 Jan 2024 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706722584;
	bh=JEiHDHiKLc9mO49XTL/YjxeNXWJjtGoFC/K7RPv0yrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gV9Byq1vBTrvzrjy+bUIkeMsC6BH/CCtrOTL/+Gwoxto58u0M/lUE/Z6yogIQEacB
	 xoAuix4c9fujK3OLD8u9Pr8LeSz5UnPilVYSPIhuXqhHO13vVAlA4CpDM/trfYQAzn
	 7khdHDYRrkMLGBXPQx2i8XkgIm2TMEaCX4ZxPpfL3a78Z6Ctgs0Q5oCXwXRbpaeQZt
	 QxHXBcfomQZhLCzbV0+JJ8mW5Z6yfd7NlPiFBLFmGmxfXTDRAJHUBELGCMLiwn1J1f
	 KgeU/E7VrFW04Y14asD0HkKB3/pxfZinJsMpDtzDHtY99TwUjTWvf45orVoByjFLag
	 IHW7x4osTs7WQ==
Date: Wed, 31 Jan 2024 10:36:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Message-ID: <ZbqFFRmZJKX8FkOU@kbusch-mbp.dhcp.thefacebook.com>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
 <20240129082256.63239-3-kanie@linux.alibaba.com>
 <37d84d79-6be4-47dc-9f3f-09bb9c5cae82@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d84d79-6be4-47dc-9f3f-09bb9c5cae82@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_093626_019856_1734410E 
X-CRM114-Status: GOOD (  19.42  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 29, 2024 at 11:09:38AM +0000, Chaitanya Kulkarni wrote:
> On 1/29/24 00:22, Guixin Liu wrote:
> > Add detailed parse of dsm command to make the trace log more
> > consistent and human-readable.
> >
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > ---
> >   drivers/nvme/host/trace.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> > index 95572c85b22a..b383d51c1a0c 100644
> > --- a/drivers/nvme/host/trace.c
> > +++ b/drivers/nvme/host/trace.c
> > @@ -153,10 +153,12 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
> >   static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
> >   {
> >   	const char *ret = trace_seq_buffer_ptr(p);
> > +	u8 nr = cdw10[0];
> > +	u8 idr = cdw10[4] & 0x1;
> > +	u8 idw = (cdw10[4] >> 1) & 0x1;
> > +	u8 ad = (cdw10[4] >> 2) & 0x1;
> >   
> > -	trace_seq_printf(p, "nr=%u, attributes=%u",
> > -			 get_unaligned_le32(cdw10),
> > -			 get_unaligned_le32(cdw10 + 4));
> > +	trace_seq_printf(p, "nr=%u, idr=%u, idw=%u, ad=%u", nr, idr, idw, ad);
> >   	trace_seq_putc(p, 0);
> >   
> >   	return ret;
> 
> I'm really not sure if we need to decode idw/idr as I've not seen those 
> fields so far
> used by anybody maybe I'm not aware here, but can you please provide a 
> usecase where
> you need these fields to be decoded ?

It's only reachable through passthrough. I'm not aware of a production
use case, but I know there are test cases that do muck with idr/idw
attributes.

I'm generally not a fan of decoding complex fields because it's not
forward compatible: a newer drive in an older linux can't trace command
bits that are currently reserved.

