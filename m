Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F70220675
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiQvANKq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jMDWpVqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F70220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MyUsBSkrMHXTFG87ewFe0lf/1cSut8JcmSn0kqTWJic=; b=jiQvANKqUWjajG4wWEo2iwFDnQ
	Ro/AszJZLerHKS4nskJEtS6CG+DUQPQqjNes2b37St4iZmSMbuJSUP3lAdzqbhzTGRS1dL0/JC4c9
	NaKi3oLEjMm6I1v2Na3ApBwjGTxC6UGmZlvXYPxMmdWj+mutjksmd56oAVDhfyrmV1Qy0pgGu4lHN
	TjlqBouMKvzGT++FfBrlUv++W+DG+S/YZQr4aqXY3qqDFgZ2LQ1RB0SHtEbP2vnwX6xPJQOAMNcle
	OqOLTn4acq96a+XHIzAUrOVAfsg8IJiwZReweLTcktd/H4z8CIY8cAMUfcPUmelxZh1DtejfuxihH
	rbM49igA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqSRB-0001sY-HR; Wed, 01 Jul 2020 02:25:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqSR8-0001rX-6x
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 02:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593570346; x=1625106346;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Z7O1zSGPkir2aBL+MAd85pq2z6k9+mJEcpUx03SPhNY=;
 b=jMDWpVqVxYLuUQQzqCmvDQGSnUgv5HO2ZVvSrBVVa3PpBDbjyrQVKezD
 4lhu3AzqBldCRwqM4AL4QFtNJaDNiNjqLiLOLRmxEKj8RZh3ZAxs5KQtg
 RO2u0YmEILuTJoUyrHxyJundvq5/HeA4lhoUGusLxHwn4CaxGnQYlr0y2
 yrzb2GH3J4uUI1PPU0qXPmpoT+tqV6+quaT3yK4s1tzX78cjG3heYIkAf
 1dUrVGntSXeG8az4tgxKgygI+ZUV5O7oQCPagJ1kKZjwt9Fzwz07AU5is
 eaJRqBye9L4/UEoPzrwDlyvzCWdlLzWBWj1VFBAR6K/eAq/dlfflcNcsq w==;
IronPort-SDR: fVOfp7dp4alzHzvnRNqm1BVSLKDQQrZ+HMSidwi2iqdXHvcbDO0FyjBJQ16LaZOh8BRg7k5fPD
 xwF6DlQwwQDITYUuRmv3SHMNye7FgnBMUSDdV0tV489sN84iPdhh51GMBIG4kmNHAdfYx91TTv
 97mLmduARipaMoDLsFXanEm8mNsG8YO3lZY4kUrIY98spKZGuwkGPQ7fQlyeKX2gD1oKQBvWb9
 15rxeOL3D8IS1L4u9LOhGjfeFftP252unidF+GL8/nREnUvKK0e7Ea3aJK1y+IFH0cWyUFb6/x
 0QE=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="244355877"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 10:25:42 +0800
IronPort-SDR: 3e27HskvUoKBW17LlBpL3NCmvG2+ZwurHOo/bAkVuZgAX1/NBsyCXuDqiQ84/Zxb3ETm3IOBbs
 iIq2IAnycTW7qqZ6ayQxKybugM2GdCXF0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 19:13:37 -0700
IronPort-SDR: 327d1oR25pwyZIkALi8o0e1f42w65mzUJe0QpYMqi7nIJmT1ILAofJDOeSor2apqrKmY4XOQgh
 oVaaP6T15I/w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 19:25:20 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org
Subject: [PATCH V2 0/2] nvme: replace linked list with xarray for ns tracking
Date: Tue, 30 Jun 2020 19:25:15 -0700
Message-Id: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_222522_440023_2ACEC2E9 
X-CRM114-Status: UNSURE (   8.21  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series which replaces ctrl->namespaces with
xarray for host-core and target-core. We can see following
performance improvement when running fio with 32 parallel jobs where
first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
detailed performance numbers. 

Please consider this for nvme-5.9.

Regards,
Chaitanya

[1] XArray vs linked list performance comparision with NVMeOF nvme-loop
target with each namespace backed by unique null block device :-

Bandwidth ~16.4198% increase with Xarray :-
-----------------------------------------------------------------------

default-1.fio.log:  read:  IOPS=820k,  BW=3204MiB/s  (3360MB/s)(188GiB/60002msec)
default-2.fio.log:  read:  IOPS=835k,  BW=3260MiB/s  (3418MB/s)(191GiB/60002msec)
default-3.fio.log:  read:  IOPS=834k,  BW=3257MiB/s  (3415MB/s)(191GiB/60001msec)
xarray-1.fio.log:   read:  IOPS=966k,  BW=3772MiB/s  (3955MB/s)(221GiB/60003msec)
xarray-2.fio.log:   read:  IOPS=966k,  BW=3775MiB/s  (3958MB/s)(221GiB/60002msec)
xarray-3.fio.log:   read:  IOPS=965k,  BW=3769MiB/s  (3952MB/s)(221GiB/60002msec)

Latency ~25% decrease with Xarray :-
------------------------------------------------------------------------

default-1.fio.log:  slat  (usec):  min=8,  max=26066,  avg=25.18,  stdev=47.72
default-2.fio.log:  slat  (usec):  min=8,  max=907,    avg=20.24,  stdev=7.36
default-3.fio.log:  slat  (usec):  min=8,  max=723,    avg=20.21,  stdev=7.16
xarray-1.fio.log:   slat  (usec):  min=8,  max=639,    avg=14.84,  stdev=1.50
xarray-2.fio.log:   slat  (usec):  min=8,  max=840,    avg=14.84,  stdev=1.51
xarray-3.fio.log:   slat  (usec):  min=8,  max=2161,   avg=15.08,  stdev=9.56

CPU usage ~12.2807% decrease with Xarray :-
-----------------------------------------------------------------------

default-1.fio.log:  cpu  :  usr=3.92%,  sys=57.25%,  ctx=2159595,  majf=0,  minf=2807
default-2.fio.log:  cpu  :  usr=3.98%,  sys=57.99%,  ctx=1565139,  majf=0,  minf=2425
default-3.fio.log:  cpu  :  usr=3.99%,  sys=57.85%,  ctx=1563792,  majf=0,  minf=2977
xarray-1.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1810927,  majf=0,  minf=2478
xarray-2.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1812184,  majf=0,  minf=2176
xarray-3.fio.log:   cpu  :  usr=4.49%,  sys=50.86%,  ctx=1816963,  majf=0,  minf=2736

Change from V1:-

1. Use xarray instead of rcu locks.

Chaitanya Kulkarni (2):
  nvme-core: use xarray for ctrl ns tracking
  nvmet: use xarray for ctrl ns storing

 drivers/nvme/host/core.c        | 235 +++++++++++++++++++-------------
 drivers/nvme/host/multipath.c   |  15 +-
 drivers/nvme/host/nvme.h        |   5 +-
 drivers/nvme/target/admin-cmd.c |  25 ++--
 drivers/nvme/target/core.c      |  77 +++++------
 drivers/nvme/target/nvmet.h     |   3 +-
 6 files changed, 192 insertions(+), 168 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
