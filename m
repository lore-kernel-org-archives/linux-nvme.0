Return-Path: <SRS0=WNe8=AW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D7C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 20:35:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C563320720
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2020 20:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p6hRKYBd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kQRtrijs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C563320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AsD6Dv0w7LdjFQqoZ69E6qagKcWzLixmcyi9xqWr/V4=; b=p6hRKYBdO5eLcSjQcT00/6QaFL
	7FxzbFOq8nrU0vrOFjv2bbrupcUckfHN7HI2KVMCoJ9YSudEmsNH+e8vrJftUnkgpoAli5aRUvDNF
	d85xRAYiaDX+n7OY7rdhQLcfH4jfUqHtKktS5qIswgaMTqqY2fDZfZ352y9hSJWk7XO3muj1+2H2a
	RDN65X2qvCwSAosRZo8x81iZYjVJI533QObFwDeUir8GVOunsukhFJk+a29U7MSxNbm7Oi+qw0SJK
	b5cEzwQLxssN/kPD6iLTENHM/y8EZSy3kCOcp596OAilG/MWA1q7AeMov5mLIz26Jtl5WGMVRyh2B
	UPe7uB3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juMDN-000801-Jm; Sat, 11 Jul 2020 20:35:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juMDJ-0007yq-Dr
 for linux-nvme@lists.infradead.org; Sat, 11 Jul 2020 20:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594499714; x=1626035714;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0HYA5Ah9nQyAvgw8ZGOGeIFwU2g1EYEpNYq07+fGTvM=;
 b=kQRtrijs0PNVoHWkQcl2ITTgAZvJrYQEDPmmNFZv53n1i90HyTIcz88c
 NqEl6Q/URtBNyK2NkjC7p5Jg5eitMxPBDU1n6debt8AXIByno4LM2YncF
 I6IDTpsNiIxjGWYM8/KhFi1CJYWFKneC4pbwPr6bgcMh7Yay0NRorDD63
 6y6DV+UHX6reqype7Ia5F1rjtqPxFSsYlteSfHR3LyVWvJZ9Nlw+/jGgB
 VI4JeR4/JOcCJ1kzsp7E49b6sGwLptRwHFVvhe2CH3AGP1/Qnj9GqWG2E
 6PY7DZa6MHFz1+nf1umE2aRZVCQsdpBLzC6IDhN9fAPFvpsMh5ruy2XJx Q==;
IronPort-SDR: zvmExrx4lZrV1y/kf2xIBVnVbbiaX+i1ZkApP8KZd/lBa6Rm+JuIa/UOG53L9CszcznHglOfUB
 MuGmXbFznzo81sTm1iZ2sJK7MvJEaqT2H1b9oQSU3a//HTGpNwLNZoEuTtZZt++W8xjXJ6NHho
 LXc12GO1dier9SF9RekYpqhho0OtXV/2zalfTGeBaX3XvQ0gUTvrQNEOMzpd8bmEHh7OzmhCZM
 AGLnvEsBDO2JjiB2Pp5DLnuYDjdlOvSJvaIiUVFK6Ba/B4zU6dHpO4AE+aE6aABMXcPsM31yNA
 f3Q=
X-IronPort-AV: E=Sophos;i="5.75,340,1589212800"; d="scan'208";a="143528827"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2020 04:35:05 +0800
IronPort-SDR: LLOn1AGPplRy0JidJfHRI7NBb3mTWBpgLjFjBCfter/gSaRQKMUL3n6vTM74G33OJYx0piJgc0
 CUCjPOtsmJaQCr6/sfB70Ya8C4qbCPOCs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2020 13:23:04 -0700
IronPort-SDR: pwcf14Fb/zSX1eAVpBWVblkBEjDW0xpF0cnu+B/yIO5CS00dL9g6uwD4ynEYiXsC6abPNpNtPU
 J3W6tVuRISMQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2020 13:35:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@ls.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH V3 0/2] nvme: fix iod size calculation in nvme_probe()
Date: Sat, 11 Jul 2020 13:34:52 -0700
Message-Id: <20200711203454.9091-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200711_163513_721377_85179603 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch series which fixes the IO size calulation in the
nvme_probe.

The first patch replaces the ctrl->page_size with a macro. The second
patch calculates the maximum value based on NVMe PRP and SGL size.

I've tested this patch with different block sizes 4k-128k on NVMe QEMU
and NVMe PCIe (non-SGL) controller.

Regards,
Chaitanya

* Changes from V2:-
-------------------

1. Modify commit log for patch 1.
2. Repalace ilog2(NVME_CTRL_PAGE_SIZE) ->  NVME_CTRL_PAGE_SHIFT.

* Changes from V1:-
-------------------

1. Remove the ctrl->page_size and use macro instead.
2. Get rid of the conditional operater and use max_t() for SGL vs PRP
   size calulation.

Chaitanya Kulkarni (2):
  nvme-core: replace ctrl page size with a macro
  nvme-pci: use max of PRP or SGL for iod size

 drivers/nvme/host/core.c | 19 ++++---------
 drivers/nvme/host/nvme.h |  9 +++++-
 drivers/nvme/host/pci.c  | 60 +++++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 45 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
