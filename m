Return-Path: <SRS0=EcNd=W3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80779C3A59B
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C9623431
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SbNInI5O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f8X74QUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9623431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=DLgiu+aQXPwd76RHzICIFhlnR9hgeTu16O0Po+ngPyE=; b=SbN
	InI5OeTmXEvOIYEo4PI9dDPb7jxBE16oKVMzMC/8RdcZyN42DOVrgV/PodIJ87rX+XZlqCyeqg3ch
	mVyv+6o6YTVK7JWuZ8rcGtRPOfuVG2XRrOjrOrGjUG5eMzdNIL+1ODvMxQEBHqn7zsJJumMbQHPrJ
	6JvlPE1Eu/xAgFQFmX1f60K7/fwCNX49zrgeI5Nz4MxGtXgIOihm67n/dQnFJrxGkMFDPDt/fLycU
	yqEf5S70kdpyMpBrFQSF2YSeYjHaefgQGOSZoMIEseBCQdlvzK/6v2C+CRT3/VFf4cq/M35aRbJLV
	n2JkS50zrwB5YVMBaBPtpL5+g/DChPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3qqr-0002rm-1O; Sat, 31 Aug 2019 00:02:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3qqo-0002rK-Bw
 for linux-nvme@lists.infradead.org; Sat, 31 Aug 2019 00:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567209763; x=1598745763;
 h=from:to:cc:subject:date:message-id;
 bh=20XJsaG/cU0nP5w2E+p/qCfcKCXjR+3hPsHUqX639vI=;
 b=f8X74QUuwP2KpkfS66aztJEda3mbErOQ0lIShVvcOI5tCsgZ1dVlyJ8l
 z8KlmJ5LZDUiAUrjXamdaGZte0tRF0VDz3cG4E2Bbdabd0/fqXZslqiIT
 SzDD0hUyyfI8r7TiAmL37a/x1EPRZMmoBn/CkAuEq6ttoxSGqeKELPkt5
 OPYR0jqqJoWL52ywtT8r5JjIL+00vJb+P1Dal9GA65X3x96GIAb6pSZKG
 fjWDOqPrcrXPe0MrJOxFQciYU6SM/wm6mbEDGQXV4/8Ni5xcZe7Uate17
 MhHGmiq1CA4E56+sjoNHFQplqjh8iMCh3tTbnFFxQ5fkxEwqeDEricAQa Q==;
IronPort-SDR: i5MhCCuVziOD0lXvYBgD9K9qcXIBhvPLLqy33tUnAuqyeXCUTk8qNZfbzjbhvw9chhpCMZQk2X
 JhChc2HtF+kpDrEv9RHseVYUmZcxqzEQ6eI1/YuaXraVsdcHBsO5Sgv8tQIXeWAXojUs9X/WpE
 3pnznLEUBiH5pvQQlCy7mOvmcE5I41KMYaYDtjjjjXYaOEEkZ+iYIEIgbAcmXqE1d2Ocf1Oyzv
 oi9fn5VAX7D5FR+XTDHZUO0OEmJOBot5mK6a5wJIl/EKIuQvKLaMUIXFrsnJPeYrO68PQXqxZi
 xKA=
X-IronPort-AV: E=Sophos;i="5.64,449,1559491200"; d="scan'208";a="121646016"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 08:02:38 +0800
IronPort-SDR: 6C+HnGIulHV3AaizxVe9evZlApU+DU6VSAMswQ6cdxYxtsKqmHFJDwxfxLVfIaAurBAZs1ylqj
 YgudIl5JvZAsd5cJlyV0bh4/h4XGaorH/PyCqfU4HPBsnQgdJyOGZTAyaKPViB65oflDI51EYk
 So59sSWiw5QxxpAEoqdNvtOIYjBiMJ0cPHBAk1tdCK+3raXufBtMUNFxYO1OhPS+m6tBzRKXqM
 6q5CfFA+8Dgwqx2TmcnZ5M5m2M93lsCmc1LCr5DJ2pehPO4FKUzOD3XpOhfCEZtNel5O0k8CwE
 rLqO8ZLopeL28aGErNSveHMp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2019 16:59:43 -0700
IronPort-SDR: 4H09yevGEUHtgzfFceHQweJpad6Z5naHYjQf/kFWHxKzs22IfNozpNO8Lhg83z+U3QfTIZeHA0
 hnrieoV9jYxlwseP07eXszeKLOKwONO7r9Q1raHGvylSaF/kVkES3QXo1GBJyvf8r6+cDcPAeN
 t0fZVvZL6bGjrInNs54tuLxRdlmjQMi8iIs5VUCVN1PxZPmoS5jxjyNB7/6bXN6yebsqMyftGi
 FY2fQPyzc/N+Y8WSKp5++fsdhoskUKtk8/MwTRz3VQHYvWGmkSYiyi+BvEDrraGngVhcgkNtcS
 HJs=
WDCIronportException: Internal
Received: from qemu.hgst.com ([10.202.66.53])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Aug 2019 17:02:38 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: cleanup work queue flags
Date: Fri, 30 Aug 2019 17:02:35 -0700
Message-Id: <20190831000235.7400-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_170242_542674_DA9FF9D6 
X-CRM114-Status: UNSURE (   9.52  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Over the period of time there are three workqueues been added to the
nvme-core which all share same flags :-

nvme-wq :-
commit 9a6327d2f25b ("nvme: Move transports to use nvme-core workqueue")

nvme-reset-wq :-
nvme-delete-wq :-
commit b227c59b9b5b
("nvme: host delete_work and reset_work on separate workqueues")

This is a pure cleanup patch which defines a new macro for common
workqueue flags used to initialize for nvme-wq, nvme-reset-wq,
nvme-delete-wq and avoids the repetition of the flags in 
nvme_core_init().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0b1ff8d54e48..555d9efa76cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -61,6 +61,7 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+#define NVME_WQ_FLAGS (WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS)
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -4055,18 +4056,15 @@ static int __init nvme_core_init(void)
 
 	_nvme_check_size();
 
-	nvme_wq = alloc_workqueue("nvme-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_wq = alloc_workqueue("nvme-wq", NVME_WQ_FLAGS, 0);
 	if (!nvme_wq)
 		goto out;
 
-	nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_reset_wq = alloc_workqueue("nvme-reset-wq", NVME_WQ_FLAGS, 0);
 	if (!nvme_reset_wq)
 		goto destroy_wq;
 
-	nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	nvme_delete_wq = alloc_workqueue("nvme-delete-wq", NVME_WQ_FLAGS, 0);
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
-- 
2.17.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
