Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF06C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 02:51:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F98613BC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 02:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F98613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8g39i1PEuHpIN2qeCe29eoGjNUlfxfgzI9T8F0YRGLY=; b=Idhtcu3ZXE83kpJg/nC2LzZY6
	/IOvzo1ez1t7mpIxO1x99dU28S4mzDB/nRfaPZbuk3vOk4Cri5rO6wrHAr0tPP78ewHpHxLgkj2U6
	33b64+N+6VkiOIOjLAedzaAYu1U35KLY7oiPMyTMRskApK9wom0l1KslVwjKLrXrL8HTGUrNwRCIx
	XrEtkjwZXIvdmQReYep/QmI3ynEx/bHMfmxKWxXEhmlSAEZGWLhY3lkcfgnBmHSySKNjlsexBrK/w
	1z5WAawGmkUMIcq8GFKPJILCeN2Aa175jaocP/wQCS7EJ3GrfNOh7DqNKfOImhrSn9RIvRRsOTXIU
	qs8zA9ccQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leU60-002x9f-QZ; Thu, 06 May 2021 02:50:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leU5y-002x9P-8S
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 02:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=EDQJyJIKv979rMf5UYmqMhG+/T+qxAvQw60fZFrcp5Y=; b=dTbr+z/DpOX6HPgt6TnwE16ea7
 3tVdrkJseXumT/3dtWJvjaoj5UHpTJWy/MNZ12a/qBtog+Rv8Y1wSSVSsQzCnvlHVbFPmc0ef4ngX
 k7MwmlDoasnU2KsGiHIXjTQLCMBKMg7BmjjkeTXMAEhmvb/8fFu8ZZi+D8J5qz0VuIt2jmWQFdXcr
 KyXpGO4DPIodjAgeiMOxv/X2auxG9lCX4QmG5heZTFEGh+meThXK6XzvRQcM6IHzAZSliowozGCoS
 IYoQW7TvoPVdm/Nln7LIoTZUsvrtqOwm3G/uAkG/NL2M9xatCSojsdL+BRo8dzSUqgor2w9oqLLNb
 5HmdcryQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leU5u-005WnJ-Iq
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 02:50:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 468C7613B4;
 Thu,  6 May 2021 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620269429;
 bh=za7FH8u1om+ySOsX7XRbjEqxEP/ER0jYj2776Z08VVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8Fx95sqzThiGDWQNbAlvLDb7I0tu7oA/MaeSJHfck6YVntuVS/1nPO8dKDcNTzbQ
 RvrhSKdlHLc5GyjroKeRwwzypuBYnHk1NnLzGs7NgePBq2TpOVoLMSd3uaB2eyhmPA
 Oda67XMr0Ix7SC89Rh8Ro0s+wgti5ycn6rc3n2cJL384Fiq8ge0vd/zXzyAStldk6l
 HRK39LUV2LjVvdnZDg7lIscbFV2bfNNFTd/gQ8NirNVWa1nMeUfL6JVcAnv2jSXUaf
 Fvn6Jvsw3BXMFHDauttdXI75JTTgNC9BTHgl9Leiop2SCtZWpWLviLMjjeyyewFKCf
 6KFfiZ/VieLUg==
Date: Wed, 5 May 2021 19:50:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210506025027.GA1187199@dhcp-10-100-145-180.wdc.com>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
 <6a43fe69-e73a-07f8-f050-8116add83074@suse.de>
 <8a274c79-6db8-a21b-e60e-4e73a9d139b5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a274c79-6db8-a21b-e60e-4e73a9d139b5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_195030_683792_4BCE24F8 
X-CRM114-Status: GOOD (  37.26  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 05, 2021 at 01:40:29PM -0700, Sagi Grimberg wrote:
> =

> > > > > > As stated in the v3 review this is an incompatible change.=A0 W=
e'll need
> > > > > > the queue_if_no_path attribute first, and default it to on to k=
eep
> > > > > > compatability.
> > > > > > =

> > > > > =

> > > > > That is what I tried the last time, but the direction I got was t=
o treat
> > > > > both, NVMe-PCI and NVMe-oF identically:
> > > > > (https://lore.kernel.org/linux-nvme/34e5c178-8bc4-68d3-8374-fbc1b=
451b6e8@grimberg.me/)
> > > > =

> > > > Yes, I'm not sure I understand your comment Christoph. This address=
es an
> > > > issue with mdraid where hot unplug+replug does not restore the devi=
ce to
> > > > the raid group (pci and fabrics alike), where before multipath this=
 used
> > > > to work.
> > > > =

> > > > queue_if_no_path is a dm-multipath feature so I'm not entirely clear
> > > > what is the concern? mdraid on nvme (pci/fabrics) used to work a ce=
rtain
> > > > way, with the introduction of nvme-mpath the behavior was broken (a=
s far
> > > > as I understand from Hannes).
> > > > =

> > > > My thinking is that if we want queue_if_no_path functionality in nv=
me
> > > > mpath we should have it explicitly stated properly such that people
> > > > that actually need it will use it and have mdraid function correctly
> > > > again. Also, queue_if_no_path applies really if all the paths are
> > > > gone in the sense they are completely removed, and doesn't apply
> > > > to controller reset/reconnect.
> > > > =

> > > > I agree we should probably have queue_if_no_path attribute on the
> > > > mpath device, but it doesn't sound right to default it to true given
> > > > that it breaks mdraid stacking on top of it..
> > > =

> > > If you want "queue_if_no_path" behavior, can't you just set really hi=
gh
> > > reconnect_delay and ctrl_loss_tmo values? That prevents the path from
> > > being deleted while it is unreachable, then restart IO on the existing
> > > path once connection is re-established.
> > > =

> > Precisely my thinking.
> > We _could_ add a queue_if_no_path attribute, but we can also achieve the
> > same behaviour by setting the ctrl_loss_tmo value to infinity.
> > Provided we can change it on the fly, though; but it not that's easily
> > fixed.
> > =

> > In fact, that's what we recommend to our customers to avoid the bug
> > fixed by this patch.
> =

> You can change ctrl_loss_tmo on the fly. How does that address the
> issue? the original issue is ctrl_loss_tmo expires for fabrics? or
> pci unplug (which ctrl_loss_tmo does not apply to it)?

PCI aside, the ctrl_loss_tmo parameter can be used to have IO queue on
the head's bio_list whilst no path is available. That's what
"queue_if_no_path" would provide too, right?

The main difference AFAICS is that "ctrl_loss_tmo" applies to individual
paths, where "queue_if_no_path" would apply to the "head", but I'm not
sure that detail matters.

Regarding PCI, we could add the property there, but disconnecting a
local PCIe device does seem like a different scenario than losing
connection to a remote target.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
