Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A79C4727E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EEC206CA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3T7eKNqT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gel68s3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EEC206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bvm4SflfFfoXbCaH4180xjz73KccryNl5kqCxgdLcP8=; b=3T7eKNqTXItN6LZVvTUh/XEHU
	lphmcWJnYpqZ9thpudBwsf90oOl91k1xo8HiLbTlUkK6Gkny4OhzR6+NnyLxMYA1LkRl46TMHDTIi
	rAuL5Lua0Y1S51CjOn/yNobWPtCxO292xKaWHdFuyQV2bbBG6uFAXuYapro2kRpzE/piO+r4QoxWV
	9UeVRLN489MfdZ9GOLNxzBmZW/Z8iz6LEul7OiIwqLiTq5uXb3h5RNRScAij+z9Lb+tOosEbQNzFY
	spcte+cjoVtIM02PGARWJveEcZgMBd86AUK7zZBEMtr5z3La06uHflCZxHydCjjFulXJOFENafWdq
	OwZKsf+eQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOBFx-0004vf-Gg; Fri, 02 Oct 2020 02:57:13 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOBFv-0004ut-Hx
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 02:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601607431; x=1633143431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=62QXZU/oioU1XnMoy/by0IRUsdtEYQRJWqvChOF7wzw=;
 b=gel68s3gdR++R/uTuV1ik3Fv+R2Kq8TEns1c5+MzOuQaDyo7Ei5wmdA2
 mn5hDp+jqAcyTyt/XMTIjD7hcYXTJiUf9vD6374fZc/bcgkL1+uGpGdbz
 kygPrHiaL5JMpH/4vs7Kvpku6v33sf2YofKypZMW42QnqtI6hELky5vZ2
 OCo9NtBhT6RI8AX53zvPex7R41yQ6atMux4bSQv5cluhhl9ojbVjAHyMj
 yk+vThepRmjNs+6AChZsD6JtoHK7VTS/xrkAXOjBiq2LfIa7AkdPWKYg4
 +pBffjINb1i1kwQmbj/Ff27rwI/rYXQIzzQa+KUvRh4vTz5ZkzryZrE+F g==;
IronPort-SDR: J6nTiLJTGfJP2os9DFzoj771AmZsSnLHAV9u5ZkYcEeoaNr00AudfPBGLdAXNsSCHX1kj9n03w
 HZ5NHYi9fSgp9Mxtmct4sh8GfBWVdw2Cz4wvm9UHMw4SedkQwbK34y40GH/HaalRVeTVuvTcsk
 FsA/4SuDz4lm9lUhDXvLqd6lN3bVnbJ2vJ5b/ZV4oRAhBwmVV4mcZtE8EhThj4C8HaCJ2pLW/H
 mBeVVmPNvQXcNsNlYd5LnSgOHATNkfxi8Db+KzHZhF5q6ROS3mU+MSv9s+m4PISlYnzbCWR4ey
 L9A=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="150086628"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 10:57:10 +0800
IronPort-SDR: sjdsrNXuEIv0h644Qhutt2X2zwph/eI7v8qlELgUhrwtyuxEXw6HUHImcMYsiSC776fdwdWhmP
 KR5HfLjs9uKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 19:44:02 -0700
IronPort-SDR: PxA6Xdb/p+OUXH+9HZfQrSByN7VMgnARVVYt/bdzOratcgX1REDPnPe2InbP9yrB0QUdtGfJnN
 HFq0u196C4jQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 19:57:12 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/4] nvmet: allow readonly bdev-ns to be configured
Date: Thu,  1 Oct 2020 19:56:48 -0700
Message-Id: <20201002025649.30724-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
References: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_225711_719041_5C1D8D9F 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now we open bdev-ns in read-write mode. This doesn't allow us to
export the bdev which is marked read-only using blockdev --setro.

Allow user to export the readonly bdev by considering the
ns->write_protect configfs attribute when opening the bdev. Use
FMODE_WRITE when ns->write_protect is not set.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..0e6b5312ad1e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -65,10 +65,10 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
+	fmode_t mode = (ns->write_protect ? 0 : FMODE_WRITE) | FMODE_READ;
 	int ret;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, mode, NULL);
 	if (IS_ERR(ns->bdev)) {
 		ret = PTR_ERR(ns->bdev);
 		if (ret != -ENOTBLK) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
