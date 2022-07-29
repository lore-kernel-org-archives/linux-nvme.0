Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F389C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pcJ9P5wFSxVhxuqwOWBx2Qxjk8Jd6Uf/DH/RLeo42A=; b=y1OTAqUntWLottQGJO8JWpzCqu
	KAvsF9wPX7xOGVOCdDYd9wsMSDpo37SAfwsjHWXCU/9p/Z933ArU57wM3Jy+n4Etro4xqZRVhoahh
	3QWXeo3rbAFGq4pI/fM2BjAY5Or3s/x/eHOcKTHRTWD1PHzI4PY7XhNkIqJQ7LoekaSA9In0LwaPZ
	P1QNG6ln+XYDqp+zK+uKwAxl6CCq3srw5nW6PeTPpHx6xtf0yYaemJTcSk+SuD3/KlL58QP6eKZ0S
	Ce28rDEkP50HXs4Kdu5t62jEbgFSTcl/pmQXT+VqMZ5UOpWh9s91oRonxGJvew55PvNyhEOwtbZ8z
	bJcd2jqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHRrM-005sIK-CP; Fri, 29 Jul 2022 15:25:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHRrJ-005sGA-CL
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 15:25:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 04EE761B69;
	Fri, 29 Jul 2022 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D836C433D6;
	Fri, 29 Jul 2022 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659108299;
	bh=LFlCr6OVhujr6+o6RA2+9JeMl/SUi546oLQUd6VXns4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4RY8sxJl3OmVvC2A1KbM4L8A+CKmnPrfLOuRSpbX2B3ym2irlsMdvt/BloQtgnKC
	 I7mUEaDQ9VN2lgCyhZvyUWzASYKTkOPQlNhpnEK1SO49nNMbK4UnJ7mxJxTmwPg4Mn
	 S3sMgogX3YF3+crfDkdvI6ma5kP+P1f0VCxQDP+bKlPGB7GVfEETtJ2ISuAzJWAvmF
	 Ci1AAO6TqGCrQIPOCi4i4hD12cxDw0UWzt7JTak3IV1fwfibwQ/JWge4MpH6GT8P0+
	 AULEmO+tpMKiwnyEBEiXDhisSkzF90DUbSEpOJLS8a8xzP1veOrG88p2nCHAAQVkHK
	 2toqRaHMUMEkw==
Date: Fri, 29 Jul 2022 09:24:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 4/5] nvme-pci: iod nents fits in s8
Message-ID: <YuP7xzqopNSaP62U@kbusch-mbp.dhcp.thefacebook.com>
References: <20220728221152.538648-1-kbusch@fb.com>
 <20220728221152.538648-5-kbusch@fb.com>
 <20220729132121.GB28052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729132121.GB28052@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_082501_481084_00282731 
X-CRM114-Status: GOOD (  23.09  )
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

On Fri, Jul 29, 2022 at 03:21:21PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 28, 2022 at 03:11:50PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The maximum number of 'nents' allowed by the queue limit is 127, which
> > fits in an 's8'.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 9e5bbf4e3e07..546de3c2000b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -229,7 +229,7 @@ struct nvme_iod {
> >  	bool use_sgl;
> >  	bool aborted;
> >  	s8 npages;		/* In the PRP list. 0 means small pool in use */
> > -	int nents;		/* Used in scatterlist */
> > +	s8 nents;		/* Used in scatterlist */
> 
> Can we please have a BUILD_BUG_ON to protect us from an increased
> max_segments?  As I can totally see us incrementing that at some point,
> and the limit is somewhat close.

Yes, will do. Also, this one is only ever assigned unsigned values, so I'll
make this a u8 in the next version.

