Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4921C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:23:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE570206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWXbos33";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qgri9WZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE570206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kA65YlrmjNfZ76YPQOnOoPXSvoPh/1kuH8r9Op/83LU=; b=fWXbos33dduPVtF70q+sIRkyn
	2XRSsRxrUw/G89ulvKnWOiGrRtM63C2gb0DZ9voDpqZsZy3vqIQ6DYgxzY2lv3/DiOnvgsMc0Qyfm
	shpl3FpAyQp5PmtYoWAbGomPT1mLHu7kBnZ66nGPXKhCp3Dn2h4MVUugO7njnoQNVVW18KH5oJsl+
	eEdA1XcPELLttwDxpSXV4VkmkhKW5OQ7Vuam8Q5ezvn+9VEmpuP2nJoF3jLbLrDoZVHdTjkyK139I
	92Rlns3DS9HaLNXtgnkJRvVDggu7WLYu2nT/hCTNGbk2xSarOk+TG9LjCs40WNomVvdzMzkp/EzFm
	0x5QHVFdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomS1-00011Y-NT; Fri, 26 Jun 2020 11:23:21 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolDx-0000h7-3k
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Et36kuz8GJ4W+6t7TUrmrw81u91sfzlJugZes+cvdA8=; b=Qgri9WZfKBHYKANyJEa93LIZP1
 YOLKYZIHhO69b4sp/M7KpQ/FsWu+WXQIINdNGWjaAYBrPp8KtpaYYkhaP47YLAtnenpU0EiI2Lkam
 VeOUCaMFuw9j56ciQAPRDgsc1zpUjP8MYUecFPn9fWHGAEqf2H6NR2OEdz40ZR3k6VAFk3/aPV0UD
 3DNpw0xjdopH6R/GKsiLmdrv58XiCB+2Odr0XkQtbeo6VusPEH55hh2MapGloP+CA5soGUxdk06Px
 V4Qk+yz+tYmzWQC9lOt0SiBmf2yK0TVIHGZUoRuIaYN55+ssqevr0fsdxRKESCKp0DYzONAurnBsW
 AjcGMKrA==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jol5z-0001g9-0y
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:56:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB65168CFC; Fri, 26 Jun 2020 11:17:58 +0200 (CEST)
Date: Fri, 26 Jun 2020 11:17:58 +0200
From: "hch@lst.de" <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626091758.GA27903@lst.de>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091113.GB26616@lst.de>
 <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_105632_461539_D95BE4FC 
X-CRM114-Status: GOOD (  25.76  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 26, 2020 at 09:15:14AM +0000, Damien Le Moal wrote:
> On 2020/06/26 18:11, hch@lst.de wrote:
> > On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:
> >> As long as you keep ZNS namespace report itself as being "host-managed" like
> >> ZBC/ZAC disks, we need the consistency and common interface. If you break that,
> >> the meaning of the zoned model queue attribute disappears and an application or
> >> in-kernel user cannot rely on this model anymore to know how the drive will behave.
> > 
> > We just need a way to expose to applications that new feature are
> > supported.  Just like we did with zone capacity support.  That is why
> > we added the feature flags to uapi zone structure.
> > 
> >> Think of a file system, or any other in-kernel user. If they have to change
> >> their code based on the device type (NVMe vs SCSI), then the zoned block device
> >> interface is broken. Right now, that is not the case, everything works equally
> >> well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
> >> do not define. But that is still consistent with the host-managed model since
> >> conventional zones are optional.
> > 
> > That is why we have the feature flag.  That user should not know the
> > underlying transport or spec.  But it can reliably discover "this thing
> > support zone capacity" or "this thing supports offline zones" or even
> > nasty thing like "this zone can time out when open" which are much
> > harder to deal with.
> > 
> >> For this particular patch, there is currently no in-kernel user, and it is not
> >> clear how this will be useful to applications. At least please clarify this. And
> > 
> > The main user is the ioctl.  And if you think about how offline zones are
> > (suppose to) be used driving this from management tools in userspace
> > actually totally make sense.  Unlike for example open/close all which
> > just don't make sense as primitives to start with.
> 
> OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the current
> zone management plumbing well, I think. So the patch can be significantly
> simplified (no need for the new zone management op function with flags).

Yes, I'm all for reusing the existing plumbing and style as much as
possible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
