Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9811C48BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 02:46:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EA9613E4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 02:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EA9613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1/G/EFcdW0UTYoh/3LYlEO942jRVUb6O/BMPP701QYw=; b=l5QyuBXW1JWDWu
	uPHXiiQd4oqB/vcxqrDKvUE2W15ZGrLVKcxsHrzzNdyrfGE3LPZTPWPPeMARRVbErWLio5W+jkczF
	Fzc92hdX5PS2ML6PgC25oe5h5fd6ekGE2BzsYZGRKpSARu8dJtfg8GsIqfdpvF1OY1vQeHhXOjmPz
	wcu4j5FR6JYEIAhZeJcomATSZ2AOL4HwZ1+GxP6ASU5CAnUcO/41aOiQ8rJXjK3vS58Q+fJ6VGGYL
	5UyXD43bxe2PFnKAaKvIzAH0mssvM3jRUgi+9Fref0tE0pKDK0P6tYu0J1jL4sgusZBrPRTuImA58
	VG8TJvWzb9PSc3mZBc/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrAhW-00GW0i-CF; Thu, 10 Jun 2021 02:45:46 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrAhT-00GVzN-5t
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 02:45:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623293152; x=1654829152;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n5YJqjbNo508Kwsn2jHNm1E10eukJ4tHlJatMIsFBOU=;
 b=TrX65zXMBELCIaH2ehVvCA0QMwfUfYukk+8CnbkbMOv5LQgFgkBQr9sS
 00zdlM1hCi5Cx7EkgecbRJx0/gyaPfSoXId4ZXEeJA+uzU1RQYCCTEl7n
 WVYlhAVZrfyK4Xtjt5fSiVJmhKzV6tMn2Ymp35uYboxd2gjmbRhH/Vild
 QoYcZMXI5MRgUn2Tmbx0vsd/QIKdmud1hxln3PuR+pqBnnRieS1DUm/3D
 ZzI7v3l0vXGq4EjSNHcFdSiXlGQ9qfZvRhm0K1vvKXc7jKxz2VPVVg0Hh
 6tZui8mvtrV6a3+h33iCu+W1m9He+alInvMz8XPGhyNx6xGFbMUOEX1DD Q==;
IronPort-SDR: Iz9fqb5bclwHAshi/u8JXYVZOvDW+rLT4Equ1AIOeX70z1gKUT1WK1briMz1lPTR327honpiZb
 e6qAhfKxr3u7KDWcPR+tBmNOKs9YhsW7HywMiRsezLvbjJaRRWcO5ZEQVt8sSJA5pzp3jrQhrT
 ZHOknI9FS00AFbJcEzYKH+tBz9MNnW0InpUqwrQRzUSc3Hlv6DAfBK5r/klAGE0yNM5ydVcdVZ
 pzA9XzrN8o5G2qUssZt6DRMf69z+wChlKc9S7kuwM/lZOJUM6jUXDI3aDrDKihgxpPkpqqFTpQ
 fFE=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="275200132"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 10:45:49 +0800
IronPort-SDR: Cg+H2KrFV9szByMiEjQrgQUXx3UuuTo9YSIvKvG+K6KB37d2VyZsMvP+Y934pBEESc+RxFWK0s
 wSlubSZZyYnxCUXVKk+d4pR4iflZ2c1xMtcaxyVmNnrRS7rWfgyAYuO/8BrQDv+NuWI6FndbKW
 OGI0fZnnNFmQvNQ08tlhXU2wGdLezXekmlKiRNTtUZrC4JEWATZqhHqfCdZ8xPGx1uCn97Vz3s
 ms9PQfu0pF9cHkvS3ilWcek6yetkMdp35HK0EjRIz7FhL+bbBvg5KhUdSfMxh9TKkaDroGMH5v
 0DDnN1TWPvdlBfpyfDCRbBqX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:23:20 -0700
IronPort-SDR: RDFBgDuHNYGN/GBCEvzHmb6af3S3dUD2KURkcN0l7iXclUUnwU6q/n3rYaB0+pWZmOygiK5HNT
 UNvs98g4jGA8wIdWpQJaX/0rg49v4Oi/R+rZYA7BfRbTZQQkh05i6CPzk4Jd51HG+ys1vvt9H0
 KocHGoC5lvFRfGpYEs8sfnbECWjQC8w/zkM4yze5wtL4kHq20vJj1k0d6smjeDdnrFFxvR4YPQ
 u5hCd+S8Gn5IjQxoW2glUMlCVDEHaYICVF56xAhRlK/3Qp5hoYAQtkdYv2DpYZZUTraGVuzvyT
 +BQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 19:45:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Date: Wed,  9 Jun 2021 19:45:39 -0700
Message-Id: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_194544_102943_3083866B 
X-CRM114-Status: UNSURE (   7.90  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This reverts commit 8872c159c7a83daf633768cee7a7ef7154010341. This is
needed to move forward with the blktests for now, without this patch
all the testcases result in the error :-

[ 3502.072798] nvme nvme1: Invalid MNAN value 1024

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/multipath.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 23573fe3fc7d..a501917d4c6e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -813,13 +813,6 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
-	if (!ctrl->max_namespaces ||
-	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
-		dev_err(ctrl->device,
-			"Invalid MNAN value %u\n", ctrl->max_namespaces);
-		return -EINVAL;
-	}
-
 	ctrl->anacap = id->anacap;
 	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
