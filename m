Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A0C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 12:37:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA39364EB4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 12:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA39364EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KUESVnvuZTPNrAeAgS5xO5VDu/qpyLoSuGyjhRCusyc=; b=gI5yGNkmQO8/heziKUuCd/CUV
	RezALZ5EkTEJ3MNUi0Jik8X1Y3gcj83EhGs041YWkooFX705Awn4xp4p3KSs7GRlhhy2yAMmLvHXI
	ioo5lcn2w/EYndMsEqANOmvwwPLiq8P/+Efuv5fpzxelHh/vMLRI0ldC4aynWE+FsVTL5YaaLXmnP
	3lfTgNnjESbrdA1UvJY9WvWNY0f5C1cMpVNjHK3QHQV+N3DPTfRQ8I6E03891dAIt/WFzISpMADf9
	uoJDNSDgdEa/zsgYQP5aHyH4FFdEhV1opEqDLD/wSHFJff8OqX8AlPg1DS/QYvpWqwOk29M4rnOkc
	3KBBfcvqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9SH0-0001Gl-9j; Tue, 09 Feb 2021 12:37:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9SGx-0001Fy-4g
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 12:37:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CCFB3ADCD;
 Tue,  9 Feb 2021 12:37:36 +0000 (UTC)
Date: Tue, 9 Feb 2021 13:37:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210209123736.pkfb2aokt47n3jw5@beryllium.lan>
References: <20210119064318.124415-1-hare@suse.de>
 <20210119145632.GD54031@roeck-us.net>
 <1093bedb-9b6d-b365-85d0-de8ef7eceb95@suse.de>
 <efddf566-a5a1-cda0-5fec-5e8a1d6bffb3@roeck-us.net>
 <20210127163555.GA22717@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127163555.GA22717@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_073739_436841_A710A466 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Guenter Roeck <linux@roeck-us.net>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 05:35:55PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 19, 2021 at 09:54:30PM -0800, Guenter Roeck wrote:
> > It needs lm-sensors version 3.5.0 or later. Older versions
> > don't support a device hierarchy.
>
> Hannes, did you get a chance to test this with lm-sensors?

I gave it a go. All looks good.

Tested-by: Daniel Wagner <dwagner@suse.de>


  dolin:~/:[0]# sensors --version
  sensors version 3.5.0 with libsensors version 3.5.0

Baseline:

  dolin:~/:[0]# sensors
  coretemp-isa-0000
  Adapter: ISA adapter
  Package id 0:  +36.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 0:        +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 1:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 2:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 3:        +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 4:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 8:        +27.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 9:        +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 10:       +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 11:       +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 12:       +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)

  nvme-virtual-0
  Adapter: Virtual device
  Composite:   -273.1=B0C

  nvme-virtual-0
  Adapter: Virtual device
  Composite:   -273.1=B0C
  [...]


With the patch:

  dolin:~/:[0]# sensors
  coretemp-isa-0000
  Adapter: ISA adapter
  Package id 0:  +38.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 0:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 1:        +31.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 2:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 3:        +30.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 4:        +29.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 8:        +30.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 9:        +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 10:       +30.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 11:       +30.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)
  Core 12:       +28.0=B0C  (high =3D +67.0=B0C, crit =3D +77.0=B0C)

  nvme-virtual-0
  Adapter: Virtual device
  Composite:   -273.1=B0C

  nvme-virtual-0
  Adapter: Virtual device
  Composite:   -273.1=B0C
  [...]


  dolin:~/:[0]# find /sys -name hwmon*
  /sys/kernel/debug/tracing/events/hwmon
  /sys/kernel/debug/tracing/events/hwmon/hwmon_attr_show
  /sys/kernel/debug/tracing/events/hwmon/hwmon_attr_store
  /sys/kernel/debug/tracing/events/hwmon/hwmon_attr_show_string
  /sys/class/hwmon
  /sys/class/hwmon/hwmon16
  /sys/class/hwmon/hwmon14
  /sys/class/hwmon/hwmon8
  /sys/class/hwmon/hwmon12
  /sys/class/hwmon/hwmon6
  /sys/class/hwmon/hwmon20
  /sys/class/hwmon/hwmon10
  /sys/class/hwmon/hwmon4
  /sys/class/hwmon/hwmon19
  /sys/class/hwmon/hwmon2
  /sys/class/hwmon/hwmon17
  /sys/class/hwmon/hwmon0
  /sys/class/hwmon/hwmon15
  /sys/class/hwmon/hwmon9
  /sys/class/hwmon/hwmon13
  /sys/class/hwmon/hwmon7
  /sys/class/hwmon/hwmon11
  /sys/class/hwmon/hwmon5
  /sys/class/hwmon/hwmon3
  /sys/class/hwmon/hwmon18
  /sys/class/hwmon/hwmon1
  /sys/devices/platform/coretemp.3/hwmon
  /sys/devices/platform/coretemp.3/hwmon/hwmon19
  /sys/devices/platform/coretemp.1/hwmon
  /sys/devices/platform/coretemp.1/hwmon/hwmon17
  /sys/devices/platform/coretemp.2/hwmon
  /sys/devices/platform/coretemp.2/hwmon/hwmon18
  /sys/devices/platform/coretemp.0/hwmon
  /sys/devices/platform/coretemp.0/hwmon/hwmon16
  /sys/devices/pci0000:00/0000:00:02.2/0000:03:00.0/hwmon
  /sys/devices/pci0000:00/0000:00:02.2/0000:03:00.0/hwmon/hwmon20
  /sys/devices/virtual/nvme-fabrics/ctl/nvme23/hwmon11
  /sys/devices/virtual/nvme-fabrics/ctl/nvme7/hwmon1
  /sys/devices/virtual/nvme-fabrics/ctl/nvme21/hwmon9
  /sys/devices/virtual/nvme-fabrics/ctl/nvme18/hwmon6
  /sys/devices/virtual/nvme-fabrics/ctl/nvme26/hwmon14
  /sys/devices/virtual/nvme-fabrics/ctl/nvme16/hwmon4
  /sys/devices/virtual/nvme-fabrics/ctl/nvme24/hwmon12
  /sys/devices/virtual/nvme-fabrics/ctl/nvme14/hwmon2
  /sys/devices/virtual/nvme-fabrics/ctl/nvme22/hwmon10
  /sys/devices/virtual/nvme-fabrics/ctl/nvme6/hwmon0
  /sys/devices/virtual/nvme-fabrics/ctl/nvme20/hwmon8
  /sys/devices/virtual/nvme-fabrics/ctl/nvme19/hwmon7
  /sys/devices/virtual/nvme-fabrics/ctl/nvme27/hwmon15
  /sys/devices/virtual/nvme-fabrics/ctl/nvme17/hwmon5
  /sys/devices/virtual/nvme-fabrics/ctl/nvme25/hwmon13
  /sys/devices/virtual/nvme-fabrics/ctl/nvme15/hwmon3
  =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
