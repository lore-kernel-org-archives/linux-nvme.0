Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EFAC433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:16:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290DD20672
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TADsVJtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290DD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TxmC9zhZLJwGE1L7HVN0AN807UXOMMrUZ0X+WKOxM6Q=; b=TADsVJtAQHsAe4isqx3155QXD
	R4vri3FkX88TKArw45PsOPdEFOTGmyBHAVsPpWeUCiPJlziE7VLtc6B56SaGXJKzRjRMAh4ptvUXt
	jKh1WHU+VpUxbIZQV7jJkGExEsp63jT5yFDwLYliR0qszbA3Vstt0ZYoD5wcXXyz6SK5XUjndU7gc
	D3pBRLxQnEalGdHEWFWQdPJ1JzLxqZcj+3ypGFvH7/hAfccWwZpAVeqlzNdpDmyzN+Lw8iIhwLj+7
	ZVULB4p4SPfgGZGMu+FJr/YHE3CFUVuCZr/Q+OyUM/FEk7V1rsKU0XdnE95+3H27Q9qDcrXEfQ47I
	3mo17Ajyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Kmr-0003tW-3i; Tue, 28 Jul 2020 08:16:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Kmp-0003sn-3a
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 08:16:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DA19768B05; Tue, 28 Jul 2020 10:16:32 +0200 (CEST)
Date: Tue, 28 Jul 2020 10:16:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
Message-ID: <20200728081632.GA22985@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
 <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
 <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
 <20200728080223.GA22321@lst.de>
 <93ab83e5-2293-2b78-32dc-af08463f4a24@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93ab83e5-2293-2b78-32dc-af08463f4a24@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_041635_288691_63CFA006 
X-CRM114-Status: GOOD (  26.57  )
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
Cc: Martin Wilck <mwilck@suse.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2020 at 10:14:14AM +0200, Hannes Reinecke wrote:
> On 7/28/20 10:02 AM, Christoph Hellwig wrote:
> > On Tue, Jul 28, 2020 at 08:25:18AM +0200, Hannes Reinecke wrote:
> >>> Maybe instead of the early return put the following condition on else?
> >>
> >> That depends on whether we want to have a fallback to __nvme_find_path() or 
> >> not. With your suggestion we would lose that; I'd rather keep it.
> > 
> > Why would we want to fall back?  nvme_round_robin_path only
> > returns NULL in case there is a single disabled path, in which
> > case __nvme_find_path won't find anything either.  I'd go for something
> > like this:
> > 
> > ---
> > From 4f578364a3d15898c7d715315a3371b2f71db416 Mon Sep 17 00:00:00 2001
> > From: Hannes Reinecke <hare@suse.de>
> > Date: Mon, 27 Jul 2020 18:08:03 +0200
> > Subject: nvme-multipath: do not fall back to __nvme_find_path() for
> >  non-optimized paths
> > 
> > When nvme_round_robin_path() finds a valid namespace we should be using it;
> > falling back to __nvme_find_path() for non-optimized paths will cause the
> > result from nvme_round_robin_path() to be ignored for non-optimized paths.
> > 
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/multipath.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 93c70e1591de8f..3ded54d2c9c6ad 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -281,10 +281,13 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> >  	struct nvme_ns *ns;
> >  
> >  	ns = srcu_dereference(head->current_path[node], &head->srcu);
> > -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
> > -		ns = nvme_round_robin_path(head, node, ns);
> > -	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
> > -		ns = __nvme_find_path(head, node);
> > +	if (unlikely(!ns))
> > +		return __nvme_find_path(head, node);
> > +
> > +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> > +		return nvme_round_robin_path(head, node, ns);
> > +	if (unlikely(!nvme_path_is_optimized(ns)))
> > +		return __nvme_find_path(head, node);
> >  	return ns;
> >  }
> >  
> > 
> 
> Yes, that would work, too.
> 
> Should I resend?

No need, I can apply it with the modification.   But if you have a
RR test setup it would be great to run it through that again, just in
case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
