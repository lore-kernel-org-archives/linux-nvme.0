Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF587C43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 19:41:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E31C206A2
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 19:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YGKRXdQ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTB6MaJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E31C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tRqeQxOtDu+3wfrP0rG7QApMpV6VduQNvnZ2Qoikr44=; b=YGKRXdQ3j/plGth4Xlzpoeete
	B0+5TG5iRH76i021hUvZ7QAfQok6UbnG/Bou4on45oyv2NtaAr7m/Uf3n71PvLXTCPVaiIgS4QWgt
	NxUXmz1Qesli9kow9nSD6K+QONYQ7GCvxvk+kBfpQCCBNYnf8b5ilLL+YLD6plQNU3HMYwkVk7RgS
	4wrYAtSDLKUGY0o3GUGd/zaXo+kB1oTkTFX34Sy/B5F4AYnVuZkAq0g5pUBKvN68HIy7Y9cjhs6YL
	zLB4lSg1EvHnTELD/L63WWX26sw0d9OU6AgxizZndbi1cm0zlyEGLscS4tKpHax/T3i3gjLFFNy3V
	OHo7VC/Tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJMFi-0004Sf-DJ; Fri, 18 Sep 2020 19:41:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJMFg-0004SC-5I
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 19:41:00 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 40A7D206A2;
 Fri, 18 Sep 2020 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600458058;
 bh=IwIR6aotZiZz6If768azZzVDumAWo05x1JcIldWd4Bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hTB6MaJ8vlmyVCvLqDBkbU8PBPOgkTv2XnpdEREalwm0Del+ztISIfApVnQiZ+n0i
 /gmvpgIHh8RnIf1PGE4Cgfm7QGlcSWS7qeR1pQU5hMFU06jjMXhHhgKRjkBJKgQiIJ
 A8fgE/ddk2LfXs6XsMYUijB9nGsNKI4dMVxsX80Y=
Date: Fri, 18 Sep 2020 12:40:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCHv3 1/4] block: add zone specific block statuses
Message-ID: <20200918194056.GB4030837@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-2-kbusch@kernel.org>
 <SN4PR0401MB35983DBC8B0B97A4083CDF8B9B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35983DBC8B0B97A4083CDF8B9B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_154100_285225_7ACF457F 
X-CRM114-Status: GOOD (  17.51  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 18, 2020 at 01:31:44PM +0000, Johannes Thumshirn wrote:
> On 18/09/2020 01:18, Keith Busch wrote:
> > diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> > index f261a5c84170..2638d3446b79 100644
> > --- a/Documentation/block/queue-sysfs.rst
> > +++ b/Documentation/block/queue-sysfs.rst
> > @@ -124,6 +124,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
> >  EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
> >  If this value is 0, there is no limit.
> >  
> > +If the host attempts to exceed this limit, the driver should report this error
> > +with BLK_STS_ZONE_ACTIVE_RESOURCE, which user space may see as the EOVERFLOW
> > +errno.
> > +
> >  max_open_zones (RO)
> >  -------------------
> >  For zoned block devices (zoned attribute indicating "host-managed" or
> > @@ -131,6 +135,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
> >  EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
> >  If this value is 0, there is no limit.
> >  
> > +If the host attempts to exceed this limit, the driver should report this error
> > +with BLK_STS_ZONE_OPEN_RESOURCE, which user space may see as the ETOOMANYREFS
> > +errno.
> 
> Don't we also need to update some man pages in section 2?

Yes, good point. Those updates need to come from this repo

  https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

right? If so, I can send updates there once it looks like this is the
form that will be committed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
