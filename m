Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3389C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B602078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MK+5OMVk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FZcG0L1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B602078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P8R360YSQcBcVPmDjE35HX5nO5GwkJ8hRRp5BTg8ULY=; b=MK+5OMVkev9BBBaFMCUrWEluV7
	bmvpImF9K9goeQewRKdoKQNW/ReGrIEkmNEEPnp9gpkXVwRovaN6sJwvt42JZJE/YjCLuBFf0nqi7
	fNESsfmC2Xg6/UwXHbGt6N5O1hTGwUYk7ZOZZ2/okfvJ7SDxLaxGJzifyywQ3ba9HU6UIOPaHG5kE
	N/Oab3mhVS+npO+I96MPYnnH1SV196XV5Upf8a5bUJOCq43AOXF0OyWauSNGwAhwHfwVDxCHBkGpM
	HliTj6dZpBx/03c9zbsd3Z9sud0JsH3X8kCBiatfqCI7FGQhii6kzSnpYaF+yeKqGR/9Bv5MDsXO2
	dfCr/KQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrF-0001Uf-1d; Tue, 15 Sep 2020 21:51:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrC-0001UE-J7
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206682; x=1631742682;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=slVQax0w9QtaYH2Vi1/vXEHGWB7yHAIV11MAwdKOYPU=;
 b=FZcG0L1yUx5854P2la0Kcwv0PZpjyz25fpmEv+7fMBXMTS1FNROols4/
 I/1mNDZz4XVnR52BHm5pLCnBtE6Scys1bH3JkBsaqeUlr2Z41cIQS447i
 edmXx0b40DwRY+SnFWZ5U4rPeqLzS/ien/jkeQkgP0XXiPigbybLqOWGo
 oWlUx3CQoYSG0AlrJPeZe7GBZD+3DN9QhOFlCJUaq6lUddlWLWkDqKzPj
 TdreypU+vvg4n32mxyEsh65YWUszZnNI9G5dQFmeKIjk1+u1oV5C31pDT
 9D7EWqDLuGcSFpTaN96EnHYoqrxN/0S9b/9PlYm4Gh8pmyX3jr4oZGpYy A==;
IronPort-SDR: KpLn24ZnGZaYlVqokdGKy9cFOjI7PCF2pwuweTOVgGX61cmTSQBBAWlVtx9JLRqIjmxaczizMy
 juLo4xwn/8QI2OstL3+ViIzI9G0U1RX4oaEvl3omD6jXZqbjWrMZUWBcqYzZo1Ht4Ln2j8iZO7
 bvMWGtWZXcMf11adp3eDiuqP0kfQNWizCslhyI/TcFTBIiKGpa7C579BMUm0GCDtGxhfX02Hrf
 cDqk9Pfv8Vbydn5780mFcB85SaH6Ls571A2BK5qFBzg83XRUhMKoAX46xZTAaNxQw70/L8+0wu
 ces=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147473461"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:51:21 +0800
IronPort-SDR: nTxDSVfp6Q2PisA8UJYNlzqxn8b7UdpQcnnrshNZHtzpUM/KD+hTNREiVq1QREUcIIXn6gj5e0
 fr7/EYlXWNow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:31 -0700
IronPort-SDR: XlZPyGPmaHPXWceyv8MrFrhimlWmDH0Cenl9A56cWyncz/qgb9VXKNgat1CpepqrRKUoUWg5tI
 U/OvrfcPx7/Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:51:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/7] nvme-core: timeout related fixes and cleanup
Date: Tue, 15 Sep 2020 14:51:11 -0700
Message-Id: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175122_785273_DC74B555 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series uses NVME_IO_TIMEOUT for the sync request submission
and user request submission when the timeout is not specified by the caller
and request queue data is set to NULL which is true for admin queue.

Also in this version, I've added timeout values setting for the NVMeOF
passthru controller given that passthru VUCs (both admin and I/O VUCs)
can differ in execution time than general-purpose admin and I/O command
set.

The last patch is just my personal preference, feel free to ignore it.

Regards,
Chaitanya

* Changes from V2:-

1. Introduce nvme_defalt_timeout() helper and use it in host/core.c.
2. Use nvme_default_timeout() in the lightnvme.c

* Changes from V1:-

1. Instead of using qid to decide IO or ADMIN timeout use request
   queue's queuedata whch we only set for non admin queue
   __nvme_submit_sync_cmd().
2. Add second patch to set IO timeout for nvme_submit_user_cmd().
3. Set the NVMeOF passthru ctrl timeout values with default values from
   nvme-core module.
4. Add admin and I/O timeout configfs attributes for NVMeOF passthru
   controller.

Chaitanya Kulkarni (7):
  nvme-core: use I/O timeout in submit sync cmd
  nvme-core: use I/O timeout in nvme_submit_user_cmd
  lightnvm: use I/O timeout in nvm submit user cmd
  nvmet: set default timeout for passthru requests
  nvmet: add passthru admin timeout value attr
  nvmet: add passthru io timeout value attr
  nvme: use consistent macro name for timeout

 drivers/nvme/host/core.c       |  6 +--
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/lightnvm.c   |  2 +-
 drivers/nvme/host/nvme.h       | 17 ++++++++-
 drivers/nvme/host/pci.c        |  8 ++--
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c | 68 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/nvmet.h    |  2 +
 drivers/nvme/target/passthru.c | 10 +++++
 11 files changed, 108 insertions(+), 13 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
