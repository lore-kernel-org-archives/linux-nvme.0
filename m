Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1443C433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5FB2075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cKvCtI34";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F/fRbv/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5FB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pShSoT+CT8hYREXbsBIvvryp/z47FneURSMsVI/X8Gw=; b=cKvCtI34ol6o1rkPkHf9TAwDvu
	7UW3kpeuvQoeAsFxgrPPEwz8ly32AvN+OKa5GMenJ9UpxSi9lHs/zx1p+RVVnzASN3Hf47Hgxwqgv
	rnTzTQi9TpUy9MDHpNrC3GWkltN7HolJ7tv4/gq9a1hoKqpqW50qzUmM54xdu15AoYrwdOHMD9KkK
	sNgJ+MtnNr28tbUTABQ6t0WjN2KAdP9nPidgCt5JIrVfK8bIuTOcEzZE9RiozQIXPAZq2aL8jcpYT
	xtciW4BYV7mANyJ5yo39x/mAfPjQ9dfQDw+xGQ2w9DSg2fYNICCOGD1JK9DpyVPHa83+Nx42LBFwu
	IrCcCY9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE1eD-0005x1-Pa; Fri, 04 Sep 2020 02:40:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE1eA-0005wa-C3
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 02:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599187214; x=1630723214;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+HOEVMLNcq3A9hY5Hk7yAaT100fBusS0Yy83NzBbSo4=;
 b=F/fRbv/2QcSouRQRQoIDkm3WMCwGFLEMraGEi8z+CeBQHTH69ADc/K7E
 Edxf92Igz6gf4R7kahvWz4l+e4tned09LGyi+ukTeDCgmkX/4wEI8nGhZ
 +Q9yN/cPjUQWOCRwdsKqaTuvGGxfsFPpl45SvsbgklC5aIVxdEVUgNAyX
 g8qkG77OZk1GsOprJ7iu3kw/tCRbzHovzs+WlCKhAkRKKKBkzYLogcIso
 /qH2LHzy91iVKrm0UJlWvuAxA6up5GL6LvwOS0fbrrtBpbOj+Lhw/Xjqt
 50TUI4tC6y9/SV8M1BXDwmbNB/UDvzhp1nAv7+eEfJdqMAOiHGQFa05T9 A==;
IronPort-SDR: LSOyMvF2Qs1Yp49NZ9QPyJ1FxICDOQaaM+caL4VDYIWV21h+FwCD1mmbWFktGasyIq7ws7PNkI
 4TOxesJfXy6eVhcbMbqj9kok6b1i3/5pIg73JRBm2+g7eJDfWSjHbs2qjhaO8Y5ddx2KGFmejj
 6UP2B1RUKZjJZ2uIS+eoF9Cx6iFqQDQs/x0hjEaGkDalA6M6jU5N9BQjlebMNZ6y3VvVB9/1nz
 Oaykh2QhEW5ZxgE9yZdLefsdvqrK1mX+18lzMUrb9QXXDHOHkCSRevumr3D6H3Qsq2RdKV41YU
 HDM=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146476410"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 10:40:12 +0800
IronPort-SDR: TutkDafM/zvXhEvxWFDYL0bTdym7eZSM85mOdtx1Disj2yRc9xQivwkJ4WyIqv/U48ObiSQMg1
 JJgIvXbEAqMA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 19:26:45 -0700
IronPort-SDR: tCB4jwzb/QdIoKGnno8sSdRj7P3HJjM4A5LuIO+OxDYiHQUXZ6gVd9ARJIZ4bHF1nvViWMxX9g
 utMJVVrKPn6g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 19:40:12 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvme: fix module ref count Oops
Date: Thu,  3 Sep 2020 19:39:26 -0700
Message-Id: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_224014_623333_04CCD648 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

As per the comment on the latest version of the passthru cleanup and 
fixes V2 this patch seires isolates refcount bug-fix patches.

The patch series is formatted in to bottom up manner with first two
patches are the prep patches to create require infrastructure to fix
the module refcount bug and third patch actually fixes the bug.

Regards,
Chaitanya

Chaitanya Kulkarni (3):
  nvme: decouple nvme_ctrl_get_by_path()
  nvme: move get/put ctrl into dev open/release
  nvme-core: fix nvme module ref count Oops

 drivers/nvme/host/core.c       | 29 ++++++++++++++++++++---------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 24 +++++++++++++++---------
 4 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
