Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB7C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F27920656
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iImk/Sav";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpOTfHk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F27920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6a8mDDsoGS4rppbhL7C6aXuFyS6OoAMyfZOnkTLHSPE=; b=iImk/SavCdbl28vM3t0GGMyC7
	v4oXwHcIeZcbmcWapeOp5NqF29UusrsKTM6qiEWoPNwaJTIAJdGe7946XOruYUQ/v9NzfM3JSly9R
	MmuBJGEuAbMdSuAGI73TELnW/Mr/izQ9DvNfRz14C69POyCnuJimerzCkk8dOdkwiNZFEu2ckx3j7
	Ycym84yK612tNVmGYWVzoxazEr4kHFAlyWLLRaPq8dtrdnf/2fV5VRGBYTzDBj9c8XAPn6QHAM5wO
	Wy4uNJ+f0aR7ICMzjXJUbRYO4prfL3NBxu99xPSBxOKQlVXs3bWsfSlkgt2FOaQMeJlTRwEr5/2BM
	M5svm7Kng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAJpV-0004Dj-Cw; Mon, 24 Aug 2020 21:16:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAJpS-000466-Uw
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 21:16:35 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0CE320656;
 Mon, 24 Aug 2020 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598303793;
 bh=bMwSIUJxidH1jwKdmC7QlpS4TW0Anq7UGTDHM8k3fHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SpOTfHk2CXMDsfLK6lm7CL7onktig8FvN0P57wGCPWdjM5lkMPs8hNmcFPoGurfZ4
 RDxterLnBGp+mIwgInC2vqBiCWoyxaQfbtD3XVbdUii1lM0WWqBEMpQC1/Dl28qIKK
 msXMqz8bWtJI9k78c9TdXEOJ/UnR8x6JOeOCVpEA=
Date: Mon, 24 Aug 2020 14:16:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in
 'nvmet_fc_fod_op_done()'
Message-ID: <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
 <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_171635_083411_9BBC612C 
X-CRM114-Status: GOOD (  23.14  )
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
Cc: chaitanya.kulkarni@wdc.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 24, 2020 at 01:00:11PM -0700, Sagi Grimberg wrote:
> > The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> > in this function.
> > 
> > Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> > interruptions are disabled at that point, according to surrounding code.
> > 
> > Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Not tested, only based on what looks logical to me according to
> > surrounding code
> > ---
> >   drivers/nvme/target/fc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > index 55bafd56166a..e6861cc10e7d 100644
> > --- a/drivers/nvme/target/fc.c
> > +++ b/drivers/nvme/target/fc.c
> > @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
> >   			return;
> >   		if (fcpreq->fcp_error ||
> >   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> > -			spin_lock(&fod->flock);
> > +			spin_lock_irqsave(&fod->flock, flags);
> >   			fod->abort = true;
> > -			spin_unlock(&fod->flock);
> > +			spin_unlock_irqrestore(&fod->flock, flags);
> >   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
> >   			return;
> > 
> 
> James, can I get a reviewed-by from you on this?

afaics, the lock just serializes single writes, in which
WRITE/READ_ONCE() can handle that without a lock, right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
