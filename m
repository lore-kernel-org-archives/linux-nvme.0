Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A73C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0A421655
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 03:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aB7CczuV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RzciTKQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0A421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WHZlg2DPei6SSZMQEpktebsHc76GLfPeITAlpcLmhM8=; b=aB7
	CczuVLip23SgpbzZPmqKMkvbA0gI8Icjn8zqOAthEiL9w9zr0pDLMxHMaVfY8WkfhhCDJjQDaKZB9
	CeD9AM+D25hZNQHgEFu6aLkz1TBTFMfw2vmJcOmgmYCfHp4CLR+HP6AirSqs5UqqrZ39U995JDjgJ
	VnW6Mqczj29lltpxYVsMg5w7CrjdGtIXqrS/6ef8HEWmWx1ooXX+z85HPO/XfE9hsRwf9/tYdSQCr
	J2xbhid0+ZVi7srcUV+7I8qCtHYmqXpVy3uC9XtJzG5/ZL5XgdJeTXVTrCMDqpOuJ3DAdzvLgaf/F
	6ozGcPTip8VTuKhc6S5/Q6LTIGObq8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIOVn-00039a-FT; Wed, 16 Sep 2020 03:53:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIOVe-000350-VB
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 03:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600228411; x=1631764411;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=muusl7RsXy26xOqBiBCDJvLFUxxfctnTSFanqdX+7es=;
 b=RzciTKQzccPVCxuT3hHUjBlZzzR0v4LiW4VDLLrBuMyxWyNoXgFu6d30
 qR87oVmCSbrlhD7ox5fNgMJgrb6lVJ2pVLkcVBxtw99FpLyYabYovWWwe
 x1LNqffNZ/AC8+4IhMpVqHKpIcRSXAotUKJaQeXMQ9j/DQ4Ztbe0mfejD
 SxrXONLfJE9YF11uxjS6cPdMUl4Z/GZCpcPuNzqqJCFyrdF3OgMKZd+hq
 P42J36d6dnir+7y6a5AqilqnLKiZ/IUDmdORxFVySMVbe73OGIeodBv9I
 znoHDwBKmadUJquLlglv60jsFshPXy2wEtP1udaV3tkUz4CN2tucsZh6c g==;
IronPort-SDR: mYDKH1xiaZCowO7ip3UVNqPXSbjZya1PgyaIq5fGv0qNrtyWC3HwrkJT/no7wOhVxkP9E7g4dC
 pscfTbTW2O6bSqDoShyd8kGoFaWEX9iUJmiO3ZBRwyRfNyFxVHYSaZrwB9lRNIEhjFdcf7KUlC
 I8/BLZPF/4i9K1BTLaV7ASF3fMxmffZuQWS0dwSS9yHTisbdkQirdFAA6yXGVPtkl8m60lKRpQ
 XwZWjGMfEWM7i3o/oEOVaoaWRQGT0xiZ6tn8rhKUq8F4+7A3OjUU5Y/CXbLVn+svW7zjroUvQn
 R8o=
X-IronPort-AV: E=Sophos;i="5.76,431,1592841600"; d="scan'208";a="148717381"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 11:53:29 +0800
IronPort-SDR: YraA048kRjio2N9bNgT9QD+3JuibQNv1tZinwgOaJgQYrTJIrfqTGDYHVg26ekeV6zvUgdYsUg
 2lPgxZzFxQ2A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 20:39:44 -0700
IronPort-SDR: IZcoqL1hw82rmwItbaRcEqPLIIk0nFJNMv796w7Q1axLah6Q3qW3gATfG4BQSIZRhMPZqr+E2p
 p3q6rEUHHcvQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 20:53:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme: fix module ref count Oops
Date: Tue, 15 Sep 2020 20:53:24 -0700
Message-Id: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_235331_203344_6A28E369 
X-CRM114-Status: GOOD (  12.92  )
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
Content-Type: multipart/mixed; boundary="===============8396170738823535813=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============8396170738823535813==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

For nvme-ctrl char device we don't currently get the ctrl's module
refcount. This leads to the Oops. In this series, we get/put the 
module refcount in nvme-ctrl char dev open/release, lift the file
opening from the host-core to caller in the NVMeOF target
passthru and take the ctrl refcount in into the 
nvmet_passthru_ctrl_enable().

-Chaitanya

Changes from V1: -

1. Move last patch to get the module refcount to start of the series.
2. De-couple the module refcount get/put from nvme_dev_open() and
   nvme_dev_release().

Chaitanya Kulkarni (2):
  nvme-core: fix nvme module ref count Oops
  nvme: decouple nvme_get_ctrl() from file open

 drivers/nvme/host/core.c       | 28 +++++++++++++++++-----------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 19 +++++++++++++++----
 4 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.22.1



--===============8396170738823535813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8396170738823535813==--
