Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11000C433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA72420775
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dSdgSJvb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SmailwzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PmAGIEvSyiwBAbL18MnYi7YkPkFiVnOD2iCztmA8SDw=; b=dSdgSJvbQtDZ3ZAl1qMAsvpzs3
	i992DcOqONmKTd1DE74DdE+hMznzV6Df1Q5wheIH+6AezKXc923iUSorU5NyxfN/Pm/Wx1Gje6xJw
	GrF3xHN2C3IyHa0/+ZxV2j7Vbe0sAA2Gs9kDQulD9cFpy9cpdnR1oOMq0nZ7H+QYr6GFy5V2vC0T+
	jRv9pfwwf3nLAmsqLPQM0RlwtdJZYF054sMcWn2Hn37lNtF9OWNZTc7w3GjnPA44JSItt2qOvKvNU
	LIiOadCf3p9Gnq++FxoMKDyhvtz7lR2H8bUtWfsK15D7Q/gmUU0AQc9N5ofVsMRXn6xGmuK9weke4
	cnOc7BLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzPU-0003un-M5; Fri, 04 Sep 2020 00:16:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzPP-0003uA-RU
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178612; x=1630714612;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TeOjUo/6GEXUUfuiqdHQb08NCghxacYHPgkP4xOCH60=;
 b=SmailwzSxJp2yfnXQdExdbnsjwH7fsviOeLwfxnRNQHIHA6f4wCJZ3Ds
 Xb6IcJoGFxIAlMyqdDpXeV5tVg8R4w17ifcomZ0rKSOIrSO+R9S3CcM8J
 l8mADp+BwXAMxovTG5MqPM9e6uYvxG5sWHAUIS1+4cNq3wPpL/cTaQzgT
 6HOjbQe6Uoj3hIEx218sVuesoIFgScSkjfVMdxIcpeSl9r7scqetxTJYy
 4/ViZZIqWCDafOdrWW7aFMbyHT0JvcJZJod1eIer+IVIAftUddjEBL2Y6
 31KpZ3RN1ch34YnfpwMCJ/oJiFXWcIGMjmrBq6KLq7KZN0sGIhxBgNoI6 Q==;
IronPort-SDR: xJaIftwwZhRrW2vB8xActWzafUxWZovQ05qFyNufuLSjuF3W0c3UUh06zTYknsSDzq6sAtC3vu
 A1LGlVCti4tynt4ppyHzNFhVNSvzBY3D4Uy+op0wx/MbXBsLfKO6WjqdHvzGAg8drTC5xFv9dV
 nN7BdAfaYdR1BXP+acCODTJ+x07csRYSSzl2V/zXT/DQaBf6crr/NIer0FYb3NFXEKT+5FyVVr
 i/emRFfglGttObZK8KwqFoXESclbU2We5JwShPJ3F9T1XaK/MQ7ZwKV2HbVbJPH57f1/oCrbjC
 3so=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146532557"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:16:48 +0800
IronPort-SDR: UnYLBV/RrvZmqNlhevUS81i2x/LZfJ5RA08sjJP09FLDkjADq4ECF5SI1QAsU4Gm6Jd8Ke5PPV
 rEB+nQqGjQzw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 17:03:20 -0700
IronPort-SDR: cuj6J99QiEnMjs9Vp7FXb9/b7bJ8xl0Mm4zsTRlmG3y6t+6hMqw7P8KzUkaiKlLI/OlbmCy2Iq
 tXImLhIVJOBQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 17:16:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/6] nvme-core: timeout related fixes and cleanup
Date: Thu,  3 Sep 2020 17:16:20 -0700
Message-Id: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_201652_270279_9CD64FA7 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: keith.busch@intel.com, hch@lst.de,
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

* Changes from V1:-

1. Instead of using qid to decide IO or ADMIN timeout use request
   queue's queuedata whch we only set for non admin queue
   __nvme_submit_sync_cmd().
2. Add second patch to set IO timeout for nvme_submit_user_cmd().
3. Set the NVMeOF passthru ctrl timeout values with default values from
   nvme-core module.
4. Add admin and I/O timeout configfs attributes for NVMeOF passthru
   controller.

Chaitanya Kulkarni (6):
  nvme-core: use I/O timeout in submit sync cmd
  nvme-core: use I/O timeout in nvme_submit_user_cmd
  nvmet: set default timeout for passthru requests
  nvmet: add passthru admin timeout value attr
  nvmet: add passthru io timeout value attr
  nvme: use consistent macro name for timeout

 drivers/nvme/host/core.c       | 19 ++++++++--
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/lightnvm.c   |  2 +-
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/host/pci.c        |  8 ++--
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c | 68 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/nvmet.h    |  2 +
 drivers/nvme/target/passthru.c | 10 +++++
 11 files changed, 105 insertions(+), 14 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
