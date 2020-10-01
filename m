Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F7C4741F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553D22087D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mgzzY20W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDxZLvPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553D22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AsFIEMgoD9DWg35gSkh1I0767rvq/cqBtggMfr5BeM0=; b=mgzzY20W9gI9JBh90/HgFlfA3
	vp3OhAzfvn0GUHf5T1PR3kMWvnuWrjYDseRSZ0WSMFOwwEF2kFegaOV+mrUhdxf+NSEL/k+UiBYIH
	EaZrih3lLCG5hXU+ZThqTvZ46KuWFbOTxtn13/mKXzA2mRkWO7JDjmXiIhxeCicL55UBtVn6EGYm9
	fXSURgP3Wh93SPi0kNKNcTNPPuDj3zgGGeoFO5vBwxK6RMe16azVj0ObPgN+rCr0qh143FiBsB9Rj
	P6bjT8CO9wR+XFpuM/09PYnqeYjY+nVJ0BIRyoC8PnOisqZu4M3R1ZBwH5du5cHHBwHf51GjhEAiQ
	neDts4VbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNoaW-0006Wq-6X; Thu, 01 Oct 2020 02:44:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNoaT-0006WA-HF
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 02:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601520294; x=1633056294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FeCIJ/Ys6QieVn7vfhZqaj3dhhZXn/DZQITwTaf4Qbs=;
 b=UDxZLvPUZFmTS27kXd+unTqtVH0e5Ykx7RjRRHTkPvzvlRv/248feksp
 APtmMqQSoQ/V+2MZTl7ZBp6CI5GiSUQPGGG+co5ofUTy8cJMesi3spKFw
 porPjNydMAOilakhlIhGoLh7Mv9N0e4eiClVb+DI4OHi6DjjVuPpxGKx6
 RUlY3vuMHN0RfjFjkCeP1kD0Le1lhhC5CLX40eU6FoJdNetaOH8w9hhDv
 nNIyPosDSBGhDH+kkQhGD2davK7Vo3Prk0+mnMiKPF9HuyymW1LFfNx7c
 iOEbtq2Brewa4U1rynMOwcRqJRzNwCKZfkm697Qr2Z4gJ7VUgUn+qDcIB w==;
IronPort-SDR: INlPxKjy4bzqFdlaL+KIRc7VWe/ie+KNnl78sNlH+YZZUaXOWr+BeUQlXm/AkkIylztqsVeIqn
 nvOYy6gu8FaCfn5s9kBpCkEybjZjP3n5p0YneRKFMQPqSSp5ea203L5EehWPlLCnYbrSmMx4rK
 EZ0Rfz8ls3V86wWB0Ir2p0T/uOrF/jz9jtb+CAXDYOAFsC097MakwLJU5xpTdqlokMiYoYNvD4
 Ox31s57kIwEnsZdhXxoqt6LsVzBespD/pGwcfB+pWlTbL+cB3mDfxELnsHyXJutAXtL+nKIfpf
 uuU=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="148747652"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 10:44:53 +0800
IronPort-SDR: ss0NaUKAVlqfHttQaDylvEy6sDdyHXo3x0tx7CTrmlq54TMY+cdbfcV0xhUcZR95kSKZ3Xdsza
 zHrrydVKhj8w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 19:30:50 -0700
IronPort-SDR: 43PukTcszLXKanIlEGKIlmSmzg1GC94yuHtLd08nFomher3GJUmj9an2MfVdCGgzkO+wUvEn4D
 /Z73a9kvqsRw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 19:44:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvmet: allow readonly file-ns to be configured
Date: Wed, 30 Sep 2020 19:44:27 -0700
Message-Id: <20201001024427.40753-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
References: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_224453_714219_C25A8535 
X-CRM114-Status: GOOD (  14.78  )
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

Right now we open file-ns in read-write mode. This doesn't allow us to
export the file which is marked read-only.

Allow user to export the readonly file by considering the ns->readonly
configfs attribute when opening the file. Use O_RDWR when ns->readonly
is not set.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..46f3ac3eae8e 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -41,7 +41,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
-	int flags = O_RDWR | O_LARGEFILE;
+	int flags = (ns->readonly ? O_RDONLY : O_RDWR) | O_LARGEFILE;
 	int ret;
 
 	if (!ns->buffered_io)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
