Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B88C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:09:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7729207FB
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KYTWjCgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7729207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wX/ZXioJoRK6m8qRH4c2gkGtVXRMoVcmeiR718kgFN4=; b=KYTWjCgVH0yWB4wDehIJ7gdvw
	KTVnoRTFhwDentIxBbuTC2KuLPeny9GpN2PibjO7hDBBHiRu2f1JOUFnL4rbuIG8hALTYART36ylH
	SiSvtGaP+0n4LIRQCEWw77ZDze07UkKwKnUk7mSdehYt3p0opgxMVEhkw2irHdFYUA9R5hdgOF0On
	/XN0yR35OAymonw04imSZv2Ic4YCGNukXgRCAmfJy01jNuHHTQGjajoan7pw/RlOt0StT2dkO+PEK
	2uYk6+pbMvK0JF6wOwRn+JHCR35Zo5l/OjdzgLS9jk9NEuW/RgUVuYpGFcWkloA69B01QRQzKKwsv
	pxoGqqoJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAT5V-0001Qj-Ag; Tue, 25 Aug 2020 07:09:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAT5T-0001Ps-1J
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 07:09:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B38B568BEB; Tue, 25 Aug 2020 09:09:40 +0200 (CEST)
Date: Tue, 25 Aug 2020 09:09:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock
 in 'nvmet_fc_fod_op_done()'
Message-ID: <20200825070940.GD29268@lst.de>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
 <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
 <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_030943_218276_0095FFB7 
X-CRM114-Status: GOOD (  23.60  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, chaitanya.kulkarni@wdc.com,
 kernel-janitors@vger.kernel.org, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 24, 2020 at 02:16:30PM -0700, Keith Busch wrote:
> On Mon, Aug 24, 2020 at 01:00:11PM -0700, Sagi Grimberg wrote:
> > > The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> > > in this function.
> > > 
> > > Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> > > interruptions are disabled at that point, according to surrounding code.
> > > 
> > > Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Not tested, only based on what looks logical to me according to
> > > surrounding code
> > > ---
> > >   drivers/nvme/target/fc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > > index 55bafd56166a..e6861cc10e7d 100644
> > > --- a/drivers/nvme/target/fc.c
> > > +++ b/drivers/nvme/target/fc.c
> > > @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
> > >   			return;
> > >   		if (fcpreq->fcp_error ||
> > >   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> > > -			spin_lock(&fod->flock);
> > > +			spin_lock_irqsave(&fod->flock, flags);
> > >   			fod->abort = true;
> > > -			spin_unlock(&fod->flock);
> > > +			spin_unlock_irqrestore(&fod->flock, flags);
> > >   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
> > >   			return;
> > > 
> > 
> > James, can I get a reviewed-by from you on this?
> 
> afaics, the lock just serializes single writes, in which
> WRITE/READ_ONCE() can handle that without a lock, right?

It synchronizes a few fields, sometimes taken over multiple updates.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
