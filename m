Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923CC4727F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F332087D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2vS2h5v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFOTZQtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F332087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lV5pIvcP80yd24zHSdDtE4JT34jgq1KsZXrsIdA0mqg=; b=P2vS2h5v86I18fidtXM4Zg8qWm
	CPlfbZLcq67SKXDrQNNuLKLAN4fEn//hOprDe4UleejUdYe8QQAnUGtx2vYJdOS2D3v/zunKqyeNO
	mTmNGC+x+fCHPOMqJIY8JQ7zYQ9NWcnF2F44ydJgNHaHOFtZqSGBc3H6Rk+Bp5fN4DbeQgD3JbSf+
	NrR2maj0jy3PnndaVywltdKgxSNf5BJGTXdDbkB1a+cu2Mj8N9+ymP7vJrQkgzb/NlIqLK5N+PFnj
	1sb9iPyNAnbdjbtDwX/jBW6n+nz8a/NXjGAuBPxHD6TJjFngGhU87xBaT0FvbE9peD7czKIGJe/ki
	hEY5FFkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNoaD-0006Tp-Rr; Thu, 01 Oct 2020 02:44:37 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNoaA-0006TS-8y
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 02:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601520273; x=1633056273;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qOeMzX4eS2PN2XKofDqxYhLXooXqkhY1qgM6yDQjsKA=;
 b=nFOTZQtZYWEqupYCQ893mCEbHvYxru0ZnWf9PxAuWH1M8rDb3hUHL9UU
 ethcr1I9fwUUElwZIKgzvQxWRAuPOsm4VLwisoOiH7Zsus14ouCUDNV3u
 6FXnVwuexk8jryPN922m87SUOLGDjLlD83RyxG2SErfSRJW7y3f2n+VPo
 fyEbmKHfEq2TbEKELO5cf32tXNFzjrCwmGWGhvz7/uXdQ1NGEQsDf99oT
 5Xem58UO1+AV8BYeCJ5cuZJTHAd/JuUgcyPrwL+Mur+bbZzyk1xt6CNhh
 1/t/g5tXqGxNDwhqVemw1ZCjKo0jvB3Yz1a5xiRIyAknnJjlMugYWqLWR A==;
IronPort-SDR: KPqs7MLxaF75DIzcmqd8HYYQ5zAhUDE5A4QRBxledJDpOsgfC8rDCyl02IhxCcc/EsYGRcC/LN
 rDCzbbMRFvLvXSH6N7MV1y4WXzAdCOtZNCoFhoWhROiY6cLl+akDkDuu1+MJijYENFWx7pUC1H
 VPWu7205h8AA1BgojbUfiyJCkBPrDtFbBanpAAFH4yHExt2nAxGUrd/fO8UUMSe0a7dyMh5KMv
 mVWTDT8v55qPEIDcNVi8OjwCjMUDUGpHAw/4eG1pzXPopR0ssWuIch71iP7PWmvqpkCfnCLpmk
 CW8=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="258461427"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 10:44:30 +0800
IronPort-SDR: gJVrUu2rA4TcykCAa9krrBDnUtxTbzE1We0a9fb8eS4k63wVZThFG/fuEwC+eQ0tZsi+bWg4IR
 xp194XIoT0Bg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 19:31:23 -0700
IronPort-SDR: gtvPdovOMpsfaycytHI4H4hxDJ0J8z4PDpMH4e1csSfQeoe7zJO1mTsgtCH7rkaw8I4Qw6OOfO
 Ws0HEnS22ECQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 19:44:30 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvmet: allow target to export readonly ns
Date: Wed, 30 Sep 2020 19:44:24 -0700
Message-Id: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_224434_524075_ECC11B4E 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: mruijter@primelogic.nl, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series allows target to export the read-only ns. The first
patch adds the new ns readonly configfs attr which user can set to make
ns read-only.

Last two patches allows user to open the ns in the read-only mode since
by default we open the ns in read-write mode which will fail if ns
device is set to read-only.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: allow readonly bdev-ns to be configured
  nvmet: allow readonly file-ns to be configured

mruijter@primelogic.nl (1):
  nvmet: allow user to set the ns readonly

 drivers/nvme/target/configfs.c    | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  4 ++--
 drivers/nvme/target/io-cmd-file.c |  2 +-
 3 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
