Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53782C3A59E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 19:33:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2273920674
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oGewRsBL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZNSSlw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2273920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z2WyV31ucq9OZOXdxw/Ejac1L4j0Y2l1PjM1yS58ZL0=; b=oGewRsBLQiT/MF
	M+V09yc8KBwXdu1Uq0uRd7BvxO05tU5/UdLgETc2YSM995YLt93DPAxavUtGrg4aK4hPFwzNdK4CG
	0QzM8EEoaBJtvrtfOiR70kBinQ2Obp92MaiHmNCd0gu3t+ruDa5C9R4EVoJWSDjuUo4U9mOV5Dwq2
	/lX0tW+24szzAEvcWY6Q1aLSLXjF8RwhCnYFIbPRBI8vFpZZ3EL2zofjx8BxI38VY/iHlKZss4P0x
	RAhQ/w3wk/aqMmw+HYIhLkEoWaLyNmbJNopaESjY650pE/K29SeGBDtXm6xbhknMj0uA/adDxITy3
	cbLFKXvTz30jgln+0MIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4s5E-0005hL-2r; Mon, 02 Sep 2019 19:33:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4s5B-0005gs-Hn
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 19:33:47 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8884A20674;
 Mon,  2 Sep 2019 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567452824;
 bh=PayzVtvb1IrG2V07glwrkJeACX2e/Z4eCtEZGxId41c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NZNSSlw7HOuJ+Pkrf+mxy/A6QUPTkfVDeOc3z7+mzfz1MCEPmzt9Cp8pzpgUn9qyT
 hMfq7dcAuT0T7Awc2humYKdVBjxAgHzHNtG4CffeVCM6W0QUA6tU9KOghWcw1za0Xz
 JN+wu3TrPCcQCYQgql9arF9gn3qSngy9Tpw3lrgA=
Date: Mon, 2 Sep 2019 21:33:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
Message-ID: <20190902193341.GA28723@kroah.com>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
 <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_123345_632030_46C38595 
X-CRM114-Status: GOOD (  27.32  )
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

On Fri, Aug 30, 2019 at 11:14:39AM -0700, Sagi Grimberg wrote:
> 
> > > > > > > You are correct that this information can be derived from sysfs, but the
> > > > > > > main reason why we add these here, is because in udev rule we can't
> > > > > > > just go ahead and start looking these up and parsing these..
> > > > > > > 
> > > > > > > We could send the discovery aen with NVME_CTRL_NAME and have
> > > > > > > then have systemd run something like:
> > > > > > > 
> > > > > > > nvme connect-all -d nvme0 --sysfs
> > > > > > > 
> > > > > > > and have nvme-cli retrieve all this stuff from sysfs?
> > > > > > 
> > > > > > Actually that may be a problem.
> > > > > > 
> > > > > > There could be a hypothetical case where after the event was fired
> > > > > > and before it was handled, the discovery controller went away and
> > > > > > came back again with a different controller instance, and the old
> > > > > > instance is now a different discovery controller.
> > > > > > 
> > > > > > This is why we need this information in the event. And we verify this
> > > > > > information in sysfs in nvme-cli.
> > > > > 
> > > > > Well, that must be a usual issue with uevents, right?  Don't we usually
> > > > > have a increasing serial number for that or something?
> > > > 
> > > > Yes we do, userspace should use it to order events.  Does udev not
> > > > handle that properly today?
> > > 
> > > The problem is not ordering of events, its really about the fact that
> > > the chardev can be removed and reallocated for a different controller
> > > (could be a completely different discovery controller) by the time
> > > that userspace handles the event.
> > 
> > So?  You will have gotten the remove and then new addition uevent in
> > order showing you this.  So your userspace code knows that something
> > went away and then came back properly so you should be kept in sync.
> 
> Still don't understand how this is ok...
> 
> I have /dev/nvme0 represents a network endpoint that I would discover
> from, it is raising me an event to do a discovery operation (namely to
> issue an ioctl to it) so my udev code calls a systemd script.
> 
> By the time I actually get to do that, /dev/nvme0 represents now a new
> network endpoint (where the event is no longer relevant to). I would
> rather the discovery to explicitly fail than to give me something
> different, so we pass some arguments that we verify in the operation.
> 
> Its a stretch case, but it was raised by people as a potential issue.

Ok, and how do you handle this same thing for something like /dev/sda ?
(hint, it isn't new, and is something we solved over a decade ago)

If you worry about stuff like this, use a persistant device naming
scheme and have your device node be pointed to by a symlink.  Create
that symlink by using the information in the initial 'ADD' uevent.

That way, when userspace opens the device node, it "knows" exactly which
one it opens.  It sounds like you have a bunch of metadata to describe
these uniquely, so pass that in the ADD event, not in some other crazy
non-standard manner.

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
