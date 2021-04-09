Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CCC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:44:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F026115C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F026115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=whqksQNYnPSUV21s8FQ1V3EUUZbd4Vqw522PsbSM1gY=; b=Il843wXuct4axCY1WBs0NyPYG
	WOQ6igqoMcolTOJ2DAJwJ+fLVfrKw5nJqbqN9yx5M0Aj2lsbxgKdJ2iNExtCPo7kAmZybnYke+mcK
	bxXSk2c571wBB7bsOZG9FfP/zCWKpNTuxTWqFuagz5/dQ42fmmYhzHSOsTV4RK/nZRKZXu2tCjF71
	qp+AIluNGgBlvABRQd/ftxnTwUGz6d9waGZDXS+IMakmk9Ty3lgMpLb4RtWN0zLXsCGHmV29kNzZ9
	8qxY/hy7g/yqzo9PxaMOtepx7AhmjC32t6sTYV7T5gxW1oxc2EeWUrMhx2ptqmoMFGi6P9otahO/1
	SZoxz5sSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUng5-000IUT-LO; Fri, 09 Apr 2021 09:43:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnfn-000IR7-QU
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 09:43:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB5E6611C1;
 Fri,  9 Apr 2021 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1617961410;
 bh=Dj05UCVcx4wOD8bjMGlyIdpYgd/Rj1GMWa63lFLlKT8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VS8wMxVJw2IZPQyASbKNR5kW0xS/aGvl04b/iozEMiWlzFp67MxLoQVY4Wu0UXUQr
 9mYCY3lG2299Oxxgtk2Wp00FcDiI19m6u/WuqLM8+uJSmm7+Pf7fxt5Mf/ugwwT1th
 5ly9sQTLwTCuEOzIVifC97Uc+uEt0WC4IoqAul4A=
Date: Fri, 9 Apr 2021 11:43:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH stable/5.4..5.8] nvme-mpath: replace direct_make_request
 with generic_make_request
Message-ID: <YHAhv+ruvQwB3bM9@kroah.com>
References: <20210402200841.347696-1-sagi@grimberg.me>
 <YGgG2TAA9TNqM9S6@kroah.com>
 <00e36c71-9f2c-5b38-96fd-3d471382f6ac@grimberg.me>
 <20210407052806.GA18573@lst.de>
 <a1674400-b265-6506-71cb-fd893d3f52c4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1674400-b265-6506-71cb-fd893d3f52c4@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_104332_703665_BF44F360 
X-CRM114-Status: GOOD (  19.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 07, 2021 at 04:18:30PM -0700, Sagi Grimberg wrote:
> 
> > > > > Hence, we need to fix all the kernels that were before submit_bio_noacct was
> > > > > introduced.
> > > > 
> > > > Why can we not just add submit_bio_noacct to the 5.4 kernel to correct
> > > > this?  What commit id is that?
> > > 
> > > Hey Greg,
> > > 
> > > submit_bio_noacct was applied as part of a rework by Christoph that I
> > > didn't feel was suitable as a stable candidate. The commit-id is:
> > > ed00aabd5eb9fb44d6aff1173234a2e911b9fead
> > 
> > submit_bio_noacct really is just a new name for generic_make_request,
> > as the old one was horribly misleading.  So this does use
> > submit_bio_noacct, just with its old name.
> 
> commit ed00aabd5eb9fb44d6aff1173234a2e911b9fead does not apply
> cleanly on any of these kernels, so I think it's better to take this
> small one-liner instead of trying to fit a commit that changes the
> name treewide.
> 
> Greg, what is your preference? backporting
> ed00aabd5eb9fb44d6aff1173234a2e911b9fead to the various kernels
> or to take this isolated one?

I took just this change now, thanks.

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
