Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D99DC433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B834520708
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zOeEDeK/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mOt57Kd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B834520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4gPDxqq+tcExGmMkk0y3okVpvcqg2xSU/8dgY+FKEpw=; b=zOeEDeK/+6f4A+UQcpWHTu9k7C
	3qPrne0pPrjc25CuZ4e15+mpMAE0uCuewA/mcriPrPl2+KOW1Cp8vTBTbRh7Vw4PZy/lLmCiYUXdz
	dj9OC0qXarhJ1dSvWYdlfW7o/b+E3lZ5Y+aB8hYDmapYBnHvTXOpeKOGuueN9Z7df3NhX5fRMtVy6
	RWP4tV3dGrMafsZafc0ap3q4MLz91Dcp6i4lMKVn62/BI0w0pLsrx5wrodTlB+2cMbXNfAurmwMK3
	QbL3Le51dgskmHONNys4mBPKPrCd+rJAWaZkxA4oXI4UuvWpuNTj0jSRIzdmatzt3YhFyUngW9f/b
	cG7jtuHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyQE-0007OC-04; Wed, 08 Jul 2020 00:58:50 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyQ9-0007N5-LU
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 00:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594169925; x=1625705925;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=l6Cy6dWfU9gfEk4kvtUZrJOBbggfhrqDa/UKRT63zWw=;
 b=mOt57Kd8qP8RCAkuLaGgWaKkNJMtAdLqXhzxMxBU+JF99eu04rTJrcMj
 Qz2dCvWTO8Xw+RErlYJzLu/Hdw9o/5LURZXWqsuWe4ZszAage1TkNtFlD
 yY8PYnk6NTowSyo8kzHTLHrsl/5nNAJWPiUagoo9lZHsASl5R8S8NO4kf
 lZm4PWfYloP43TzQkuUi9S4zbCukOsUG9xqLLvfIDhFA3Rjk+oUV6Qhbe
 Ktqr2LBgsmx49nVfFuD4wH6uuE3cG3enipQeih8f1ldCYEEHsbG3Huu22
 oZxCgzAub2JsFm9F6kVKYO2pFTUqccTQ8Es6peYDvQtskrrYhNoBTE3ZQ Q==;
IronPort-SDR: iufs1FlBxsfNfyVSe3vGRCc9sk5lfmbFiMvpzxiD4qJT4lGhv/yyzkMuJxAmE2ju25Sq+shxW8
 r39iioCKF2lxTr2kF5GGgxPk6HjzTN6NXZP092G51gcN4OXm9fa+un7ROvr635bQh7WxqR1wCt
 vmqWLJT8FokKUiwxj/3pJIDaA5KIU1ap1eNcqsHBrdbKMPK1YTbwnirqZRzGpkjE8yTECxByn5
 5e7wS7Ev3sihIOX8kOzrZwcVkVdZjys1xPrVgKqd040og8kb3Y8WSTS5N00Js+D2+LfRPtqmej
 oBc=
X-IronPort-AV: E=Sophos;i="5.75,325,1589212800"; d="scan'208";a="143204229"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 08:58:40 +0800
IronPort-SDR: 6AjhgeQBj4zK+YpyshQVqAXfJElil6nO01/4SjrH0QwCQ050FdKw/QnIYI3lGuc5BWS2XaKXtq
 jchDGmSVZSIFB0dGdDCJT79qTnGhBYj3Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 17:47:19 -0700
IronPort-SDR: cbd63F+laYAxdQqLo2SJOotaRU9x+BBDKmrRBie2+4mI620mW+arTZjNuQeiWkk9y+tOp3bpia
 qVSMj/tuz1UQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jul 2020 17:58:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 0/4] nvme: fix iod size calculation in nvme_probe()
Date: Tue,  7 Jul 2020 17:58:27 -0700
Message-Id: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_205845_861705_3E8FDFD2 
X-CRM114-Status: GOOD (  11.64  )
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
nvme_probe. First two patches are prep patches needed to get the right
value so that we can avoid oops in nvme_npages.

The third patch calculates the maximum value based on NVMe PRP and SGL
size.

The last patch has a fix for checkpatch reported warnings which were
present in the existing code prior to this patch-series.

I've tested this patch with different block sizes 4k-128k on NVMe QEMU
and NVMe PCIe (non-SGL) controller.

Regards,
Chaitanya

Chaitanya Kulkarni (4):
  nvme-core: use macro for ctrl page size default value
  nvme-pci: don't use ctrl page size value in probe
  nvme-pci: use max of PRP or SGL for iod size
  nvme-core: fix checkpatch warnings

 drivers/nvme/host/core.c | 15 +++++----------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  | 24 +++++++++++++++---------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
