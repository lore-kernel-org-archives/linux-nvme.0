Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF77C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9C8207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSMNipqd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qRYPRoIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9C8207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S/enP2wFG9QNj84wg7GQbGL2MBSiUkZbvJipXfxX6MM=; b=sSMNipqdxD+I+Dw3rdi/V0Xkm
	0I4pxuGaSa5Jyen92hYMk40Mgr0IkQD2uC8JjGVitsMJ0M7wjiNvz1ioaMrz8dCxrytombIxd1Ta7
	I5hhknlS+HR8V3KvzGDlr3BDQI0IlkUmhN55LgeApiOcatERcHdt60EIyKT+s8sZmBVdT67f3vaVM
	6phVJ3bSdClfsInr42AcD+mw4tF4I6IhcRopUskT5atEMhNXUCcqr1zUWWX2QOroL4Cppt/qx+f9Z
	eEJ5zR6H1qVvlyoCR+99qUYJiw1bKL/aZqIpJijsP/1N6FTTjMmkPlMEhm7wGvU9ZWQFbfTj13gM9
	xkBVZl25A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsGs-0005Rm-TN; Mon, 31 Aug 2020 22:27:26 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsGq-0005Qk-CX
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912844; x=1630448844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TMgAc+94RegLJW04jTzG+eWTNP4gmnHoJc0cNLT9fms=;
 b=qRYPRoIfiDe3bzC4+XmT3ykGgR2gWbFy8PlSTScMR1434s60v4GUFML/
 Mx7IzZLm8lL0wmnWBDOj/c+K3CeFnfWQqaFuFiDPrb1FUK0ku7nF7hNXZ
 52ZMO+CBJvjn2EWfZ4zlbxSxYZvslO9M4w5FBsI+doAMEGle121mzWLg1
 t0a6M9htxvaf/4eXtcudOD0oStri/YuUolOH/mtx/gWRC8oBSDEE2n4aV
 XdQMZ3iUuv+KylpZIS9MLNHx/Kcy7TvKdOC8R/7mcO5EPyE3CVPqFb1Vy
 lIsMVP68tm5tShn59XyM1TPBMRCfCPltqksT4tmqU1Lcp6F5Xv50BGzVE Q==;
IronPort-SDR: l57ppC3TfniSofGSiRBm6HrMTQTl2EZoYHjbWO/UL+PV5zOnyrRaXcrsn20Q7ruBoK4jHCz4gP
 pyJiFqudtlXjqDtTZeDVZFcmfVhCNaq+J4paluBeEpx2wHxhtXaR/+n+ypqgQrAz8yLARxL6Fr
 2Z5OvVzGnaI4lmVJbLI6X6ZL3sru6eTjrc2JhniRJ799xdX7Wa7CXodOHoYOhNZgvdlSFjAToD
 Bc8tPv2U4faZIxnEZlipL4dyccGR60iB3PaoR4bo93evvof8Wj5TiB+cGvzLeAn8xqC3+NsCYy
 EXQ=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="150600853"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:24 +0800
IronPort-SDR: 6vfs3OUIe1F0UrPsuGTfmJxO5KRRBe9WKd5OU70K99/Pg59ljHn8da8dZ8eqXN4U76KiOecs6w
 Ttf5xyXZke7g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:14:51 -0700
IronPort-SDR: 2UUCOAZTj1kcqIj9QRszfIbGKnfEng8W7RQNoY57mOUF22eWCRQzfD61jKs+ZZm9ZpNFweYFnI
 wUn/V2GFf71g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:23 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 02/12] nvmet: for pt I/O commands use likely for ns check
Date: Mon, 31 Aug 2020 15:26:57 -0700
Message-Id: <20200831222707.35611-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182724_686127_5CE75C27 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
when accessing passthru controller. Since for I/O commands ns is always
present and the condition is marked as likely. Annotate post request
submission ns check with likely which is dependent on earlier the ns
check likely condition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240..18e96eda39b1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -268,7 +268,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 				      nvmet_passthru_req_done);
 	}
 
-	if (ns)
+	if (likely(ns))
 		nvme_put_ns(ns);
 
 	return;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
