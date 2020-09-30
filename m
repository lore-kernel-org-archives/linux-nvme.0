Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C49C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:24:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E782074B
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ofq5GLbi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iA4cMgVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E782074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yrz0hxsudGv57yPKFXuWQUg14h6VKiWeFxnC88n8P9E=; b=ofq5GLbi0mZwtF5pq+D5srZToz
	TM0lVpWzGMZ+CW5A0zRCGr14Q7HJ19hz3xgrlbxseNhbnjS5ylxNtfqudnpHuGhpfNRHOgKrX2ted
	5LySO4kaoYC+KJR4gfCoStYJKYiRAnNCzwGo6/jDy+x2kVkeCNpgzlddg5A6IpFfsMLGxrMcnwcbk
	Oji83ybkg8M41DtaEEn+FBwKl8mOVwhC7jmXtxabDTYJBbC02W9HVyiZi+OHqTLOz1vZgo8GkPbTF
	v6ITxIkfcAqjM5kUJ0FmTLLdonhTtgWtCoxdgCKmYYG+2P3dSzXNv2rAPEjdarMohRWLxINI0QL5i
	P/boF5bQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNTfG-0003Pg-DF; Wed, 30 Sep 2020 04:24:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNTfD-0003PN-5f
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 04:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601439862; x=1632975862;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FLZ0IUK4/IQySAO2wmeYPBeRA1OMFcjWle0+BCQyzoM=;
 b=iA4cMgVOcmmRGQBNtt+PDnJS1lDZLb12DS8nXh9GhtbWCi42YBKn0NCD
 S3F2Q1dDeeWSqP/lvOxuY83P5+NnzIT2OibDDESYdI/llLaWZWtdGdf40
 kUeOBZUT7L95QbVoThviSKcb3bShsKDTDMcjmtFSUe15F9UO4NNBfzng2
 WtfRtzYL6KJv31B4N0/tkCadPjXk34RJcqrZ4OsNs7bHj+myWEKriijYU
 2Dt07BLEe2ioi8F0jBVrS6udYIxe7It2tnzwcJDKKXvHW/xQRJW9oTeUb
 O1D+U+d5R2HzPbzJKogoWu9lsyaYJzcg+JNBoeaaNZJ8uAwFVVShTyqvZ g==;
IronPort-SDR: PkY15iWW7FOgGpC71CJMpcD7T/doNXN0q79+OOipcqoHBY6I9H/KYRq+YV0ffOQtTRwxyFOCbi
 YRLon9c/flO3X6l780L+ZttF6pBFvmIXjUkKWM4TKnkHjDkwMQjJtBCIyk1g/alw9QrFU0eJom
 JAQMADJ2hwTWxKu9P1g1dJ7K/uu0o9AfXpe2iOMvgckX+kejBEKE1I0qJHCvrxuDVYuHKMDM3w
 t4OzxQqTZz4BD6WOT5sEZT9ipbxWwwqDHCnwYYQG20wgY9qoonh7kLrmZbHYuDq8w+qP3KLude
 WgU=
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; d="scan'208";a="258361758"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 12:24:18 +0800
IronPort-SDR: SnpExCj11mJqmeB2LW66c+Mhe8Z3ONerq4gc1+cqi+TQdnMr206NZQpOyQWvKgap9UkY7tGIq4
 qgDWoKsRk/4Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 21:11:11 -0700
IronPort-SDR: qVRe6JOJYBWiah0h+INETZ/uAcReQAxumQU/DSNLM1u5p/PelIfKsZg7fwyNQSjyIl54XQ7OoO
 Hx1joUmuNqdw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Sep 2020 21:24:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-loop: don't put ctrl on nvme_init_ctrl error
Date: Tue, 29 Sep 2020 21:24:17 -0700
Message-Id: <20200930042417.36268-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_002423_402043_F4375474 
X-CRM114-Status: GOOD (  15.68  )
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

The function nvme_init_ctrl() gets the ctrl reference & when it fails it
does put the ctrl reference in the error unwind code.

When creating loop ctrl in nvme_loop_create_ctrl() if nvme_init_ctrl()
returns non zero (i.e. error) value it jumps to the "out_put_ctrl" label
which calls nvme_put_ctrl(), that will lead to douple ctrl put in error
unwind path.

Update nvme_loop_create_ctrl() such that this patch removes the
"out_put_ctrl" label, add a new "out" label after nvme_put_ctrl() in
error unwind path and jump to newly added label when nvme_init_ctrl()
call retuns an error.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9da5ab755095..acc7352f9764 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -567,7 +567,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)
-		goto out_put_ctrl;
+		goto out;
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
@@ -627,8 +627,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
-out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
+out:
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
