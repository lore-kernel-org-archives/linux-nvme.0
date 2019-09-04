Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4B8C3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE972339D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uod2pNro";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHS6x1AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE972339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZLYApdlTesLy87jxK1Ib5utmnC8VnpnrthCXPxgMv5M=; b=Uod2pNro68ZYuF
	GrR0cuLZp2zImTHkmo9LrHbXVDcOCgOTAmeQ0tduDr9Uak2vpSCt9BSkVV17JWl68EE+qDctAudR9
	h9sfiGjABKgBdcK2uvl7YzTUGD8+lb/aOLnMrZrRvef39AYBn3omVxJ3sF9RG3r8K1/LqInV8Asr0
	aRrY0d2VLLkhuegjUrFJyqo1HYVopNJ9bwyff6pFunEO3UqzpcM9krBy0CNM3iPIP7+TDVzhCab9b
	bOEOmptHzCu8WE6q1e2A9rd6KQZ7A4Wd3sEhpfBMJ+S3eDM4rdzO4Jrj8IP50AkaD9u0420HzDQjw
	ET8OCBFfZ1s3ln+aU4Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Nnc-0008UK-RN; Wed, 04 Sep 2019 05:25:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5NnZ-0008Ts-Hb
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 05:25:42 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 04C802339D;
 Wed,  4 Sep 2019 05:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567574740;
 bh=CXNu9IN1Uq+0JFc0kjRWO1y9r0+ATS28FSmG0b0t2mk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NHS6x1AV4wFH2nBQ/fs186BvlLSw8U4EgEYYBHRQle4S+DEKxvQ8C/hiKfdTTkgXM
 WpXCxyb72sNYUSsGaZQLxZxjt9YMfseuWBDqFeZuGg+of3G70kT8FpQ3meUUbNzkV/
 kTNyNEDxSMKSUaitSylkwH88KhVhUza8BemG3+oA=
Date: Wed, 4 Sep 2019 07:25:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190904052538.GB17236@kroah.com>
References: <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
 <20190902193341.GA28723@kroah.com>
 <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_222541_607525_BD363160 
X-CRM114-Status: GOOD (  22.90  )
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
Cc: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 06:35:30PM -0700, Sagi Grimberg wrote:
> 
> > > Still don't understand how this is ok...
> > > 
> > > I have /dev/nvme0 represents a network endpoint that I would discover
> > > from, it is raising me an event to do a discovery operation (namely to
> > > issue an ioctl to it) so my udev code calls a systemd script.
> > > 
> > > By the time I actually get to do that, /dev/nvme0 represents now a new
> > > network endpoint (where the event is no longer relevant to). I would
> > > rather the discovery to explicitly fail than to give me something
> > > different, so we pass some arguments that we verify in the operation.
> > > 
> > > Its a stretch case, but it was raised by people as a potential issue.
> > 
> > Ok, and how do you handle this same thing for something like /dev/sda ?
> > (hint, it isn't new, and is something we solved over a decade ago)
> > 
> > If you worry about stuff like this, use a persistant device naming
> > scheme and have your device node be pointed to by a symlink.  Create
> > that symlink by using the information in the initial 'ADD' uevent.
> > 
> > That way, when userspace opens the device node, it "knows" exactly which
> > one it opens.  It sounds like you have a bunch of metadata to describe
> > these uniquely, so pass that in the ADD event, not in some other crazy
> > non-standard manner.
> 
> We could send these variables when adding the device and then validating
> them using a rich-text-explanatory symlink. Seems slightly backwards to
> me, but that would work too.

That's the way the driver model is expected to work, instead of having
to do crazy device-specific stuff.

> We create the char device using device_add (in nvme_init_subsystem),
> I didn't find any way to append env variables to that ADD uevent.

You do that in your uevent or dev_uevent callback like all other
subsystems.  Nothing "new" to do here, again, it's been working fine for
everyone else for well over a decade now :)

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
