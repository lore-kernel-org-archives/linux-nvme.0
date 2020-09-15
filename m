Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED337C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:05:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FDF206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WoOSYy+p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I/xAohMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FDF206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3CQ7+xD2+++Z04e5d0eFuQln0K2nanVlLj137wnxYk0=; b=WoOSYy+pvd1pc9XEG5/wnidtFu
	cXzCvXqw+I86RkBndT/nprFnEuVjzFgcfr/NYH97UHfgCo1s6vxP14da7joccXRPr7Q2f/PffnWXR
	rTJjCPlx6QiZwqYS/BWqduPK05Gjai4CA8/KVxEGniUw6t25cIDGGjPSO/yuTpPdOgzA4ptMmM4FQ
	n1nHJtmfcBlD5Z2CiNcTYF5L0YGbO6Lu6XmhVYvnJBh0aV5EROFMx1AJrzrKjbBeve64Vs+H+7Fr0
	jQ7dW8EEnzVUbWBx7clUwgqV6Au3F7wyW+6AH3Sl6Nx+wxQsMXmfCpzH1c91TLY4z1pik5pjC+EW+
	ZUPPLP3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIK0V-0008R1-0U; Tue, 15 Sep 2020 23:05:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIK0S-0008QL-3w
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600211100; x=1631747100;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4wITtwn8GFzcUWOXyGmws8wNCalLdiXVJppP8zQraZ4=;
 b=I/xAohMw1tF/U8wItjkzAJCdVm8xqnEdP18Pdi1O5PCSoYW7+rJHUkRZ
 pIq4DFilpalXN4NvEi+9v4A3ZhT3EzpCvqcuYfs0QqvCyWnQ5oKMYSlED
 w+xbd5Z2L25zSHx16mOwe4L5jvBiXJXpTCcSOwMKvtxSyIdTBEeH+AJdG
 xZqh8krVpMmaQYKta7P1vmYcVLcMrP8OIC39zReF5/HozEP4c+LBUcyIM
 C8d68MbVVhFYClDa9K+Vf68sTUkUoW84BKEPc5eBZBW52hAjiUKpW3KT6
 jQUcnvWaGgzqUT0UlSxo6gK7yq/gGbY0wZ9m+Ua3r1DTSB27mt7v8XEOa Q==;
IronPort-SDR: 4JYH+TblNiK2vCa6N2Dz9iq7aYtbPODi94j1s25pyq7cvmwxtIulKv+fEmdiZqQNxgeVXtyHtm
 uejFT3TMtVeOHys/K89MN8hpluNOgXhD/9Aum5Vh184W7Kn7Z04yJ8/lRF6IktWQIciDr7PSW0
 mjYoZBPIrYcuTyyCbq6qUXY7lonw32tlrHaNK2Ij4oOL2ifB7n8p+fxSzQYISBf5Hiv9gUFasX
 wy4PXM+qbRzIAHj5+VhjHTZpkqCAQfvEJ8/q6O2VvwCdU3Fl8VLqzpoMrtBhnSZy6nj8M/6dtj
 KV8=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147477980"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 07:04:58 +0800
IronPort-SDR: egy9X+T7TJDrIAvf0mEj2orynr4K1R852h2DRd/nVGrCUH08wUBkQcu+U+YijaKjh4RQFIdecj
 6MMxHQmeqhNQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 15:51:13 -0700
IronPort-SDR: tyGlUoQ2dY/pAF02FyUNtT/IA32i1zJdYOK10/viOpA3/O2+pHbeduYh0LfH74PnFf42pA0Er5
 dn+Ef11q40UA==
WDCIronportException: Internal
Received: from zns.labspan.wdc.com (HELO zns.sc.wdc.com) ([10.6.137.48])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 16:04:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Date: Tue, 15 Sep 2020 16:04:56 -0700
Message-Id: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_190500_300927_A523B5ED 
X-CRM114-Status: GOOD (  15.22  )
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

Update nvme-loop transport with NVMF_OPT_CTRL_LOSS_TMO in allowed ops.
Without this patch following command fails on my setup :-

nvme_fabrics: invalid parameter 'ctrl_loss_tmo=%d'

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

P.S. I've not bisected the root cause as this is happening after
latest pull, let me know if that is needed in this case.

HEAD :- 
commit af5ad17854f9 ("nvme-tcp: fix kconfig dependency warning when !CRYPTO")

---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d6008cf66a2..f95cbe30e604 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -678,7 +678,7 @@ static struct nvmf_transport_ops nvme_loop_transport = {
 	.name		= "loop",
 	.module		= THIS_MODULE,
 	.create_ctrl	= nvme_loop_create_ctrl,
-	.allowed_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
 };
 
 static int __init nvme_loop_init_module(void)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
