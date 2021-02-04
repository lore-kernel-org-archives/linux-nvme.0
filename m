Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5ECC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 02:42:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFA164F41
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 02:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFA164F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aJRwVgrpZUjx/WMdy9thjsrg/j2tHcGHra9pxLX/M1o=; b=v5r210SSPnH7v2V2EToVVOYiD
	e5VyKoiV66pQDPqFG07DD93tEa4HjqH9mDRNGIr61Rz5sPT5+vp0vuhzNaB+0UlwEYOFtoKuxZPWu
	soZjQfKryIlVwujyKd9Ns1gf/y0HDdaRhOTgVlhwpul6rqC1YNki4C0+ucyTepR6zhyC8YMFlUx2l
	N5btpRRH3/QIuZxy20/SHbkI5IzDEiiTgoMEbpRbvdjA34SC+QmCEYzq9/pROlhFuWm76Ib7/QyzO
	uJG4X/OWMQFRgLyMHBaXZnzNpwwenP/JOhuNWLN1ktelSpCEsOR+HhTk8SxyKZRC06tFgHmNVlzYB
	tb2Yxn9+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7UbD-0004TI-Sm; Thu, 04 Feb 2021 02:42:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7UbC-0004St-6W
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 02:42:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017F264F41;
 Thu,  4 Feb 2021 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612406543;
 bh=A7oD/DpDZu9kTkdz7SaDkbdeV8p423bHuSZr0I/57Wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EPW5N4SB+BNXvrGWhhhtkWp3YvZSO1DjLMRsE7aZ32RADo+TaebnoCm3uzC3o1DlT
 gsW04tErOWOXiR8awc6OmW9YiLbyytTUU9aahrsjPBlxGkDZTRMT1VHoua3oVloPpx
 LaKqLkEWjSgH1sfqGQZGZyLUxHTm7gQ7eQbvLnOOJgICL/JZDQv5YSof3oSM9qJkrm
 G5KZdl9+kv6vORIYoJpCdyK4X/ofudiHUC56E3o/mCRBjsWVfqpFRgsE0X7VVhjVQx
 SEm5Yjxllevh2PAi5nwkeWAoGrSx//EEC/n1o/tZgrgScSXWCF1Pgojjqp6y0/ZY17
 bRVpqlQUrHNjA==
Date: Wed, 3 Feb 2021 18:42:20 -0800
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Message-ID: <20210204024220.GE2182779@dhcp-10-100-145-180.wdc.com>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
 <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
 <20210203165203.GA2182779@dhcp-10-100-145-180.wdc.com>
 <8b1fc5ef-4c6b-4fa3-7cb1-b42ed71e7413@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b1fc5ef-4c6b-4fa3-7cb1-b42ed71e7413@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_214226_425104_7A3A3BB9 
X-CRM114-Status: GOOD (  30.60  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 02:19:44PM -0800, Sagi Grimberg wrote:
> =

> =

> On 2/3/21 8:52 AM, Keith Busch wrote:
> > On Wed, Feb 03, 2021 at 01:31:13PM +0100, Martin Wilck wrote:
> > > On Tue, 2021-02-02 at 08:58 +0100, Christoph Hellwig wrote:
> > > > On Tue, Feb 02, 2021 at 01:59:51AM +0100, mwilck@suse.com=A0wrote:
> > > > > From: Martin Wilck <mwilck@suse.com>
> > > > > =

> > > > > While a controller is still connecting, ctrl->subsys is NULL and
> > > > > thus reading the controller's "subsysnqn" sysfs attribute returns
> > > > > "(efault)". This happens all the time when user space processes
> > > > > "add" events for NVMe controller devices.
> > > > > =

> > > > > Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
> > > > > if ctrl->subsys isn't initialized yet.
> > > > =

> > > > This is just papering over symptoms.=A0 We should not be sending
> > > > events or display sysfs files until the controlle is live.
> > > =

> > > I don't follow.=A0What's wrong with a "connecting" controller device =
in
> > > sysfs?
> > > =

> > > Controllers can loose connectivity any time. What's the difference
> > > between a controller that is reconnecting after a connection loss and=
 a
> > > freshly created controller that's just not live yet?=A0You wouldn't
> > > delete the former from sysfs, I suppose.
> > > =

> > >  From the user space point of view, it's the same, a controller device
> > > that is not in usable state. I don't see a general problem with that.
> > > Seeing a controller appear in connecting state might actually be usef=
ul
> > > for user space.
> > > =

> > > The subsysnqn attribute is correct for controllers that were once
> > > connected and lost connectivity. My patch was only intended to fix the
> > > "just created and never connected" case, where it is not, nothing mor=
e.
> > =

> > I think Christoph is suggesting just wait until we have all the
> > properties the driver exports rather than specifically exporting only
> > during a 'live' state. Something like this (untested) should do the
> > trick:
> > =

> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1a3cdc6b1036..4c0258d7eb91 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3069,6 +3069,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >   		if (ret)
> >   			goto out_free;
> > +		ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
> > +		if (ret)
> > +			goto out_free;
> =

> This happens on every reset, we should probably just do this once?

Right, and while the function is invoked on each reset, the above code
sequence happens only once. You can't immediately tell from looking at
the diff, but it's in the 'if (!ctrl->identified)' code block.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
