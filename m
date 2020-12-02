Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D49C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7508C22203
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7508C22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zzAvP6ATRxJLbFyq99w8no9v7FSfBoRMH1fMxnWsc8=; b=A+vnfVJZ2btUoM3OZ0Slq6/Zq
	B0ChVfq/KShB1fmoM/TaB2NgXa2iEyB9TOrpZKaQQJ1WAIZIDTEYy8nrtfuH3OCg2Cw/8dKIaIN87
	6Iqr7K+SIw1LcdVkw0pjGgDDt6Ai5/b4JKpXS5J5fj4tdozF9whsiD0KXMx21/WQv5thySfrKKgQ8
	WRHK9vO2bhGnPRUvRDDDGBWOT1vOGLOw2YQY11lTjKKMDEO8DmzG8GKTy6EhAzJxOhNBG5pf+2wf6
	fkt9EOGPQoJPZ0mTIplM7MZGRq2odA/dTykkUkV7Vvct3BgxcfQsSZ+wWJgjAiZ2Dcy4XNQlnfYBN
	7m8Qu3sDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLYC-0005Yc-60; Wed, 02 Dec 2020 06:23:40 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLY9-0005X2-VK
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890217; x=1638426217;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
 b=c0RlPJbz2ZmEoaeVdKLvUZbWDwrhuJ80o0YJeArUet9XfoOmlfJUmMVQ
 bi2jdtoom9VF1FEEtE1dAVbQJ/neXXysEUrDAcmviINfXID1ANkp5T1EC
 uRNQP2pf04AAhf+Pv7HTr5OMHIHQpL/rqfGJSqZithbSr6va45L5ycHps
 HepihDAA8oOMzn21MaMmuf15UoM7TpqLcKNyuAlxqcExSz+yIHdaVDf0l
 Hk5ObsUchSE2he7HJbApG17fiyu6BgnhyYv31T9ziyUx1BWCn8MQBDUJf
 fII537+Jf/OIxnyutq5ubfKEYAlElwIL8R5hWhN6qLHgHZPNnArOAW9NC g==;
IronPort-SDR: ZqM0A49PXFu8LaRb40qdAD6ZYE4rTpl49k6w8/FmFeNB1uWwYoqZuYl0WePHxjlWqRDENlolh3
 1FtO41fbJxJK5la07vM9NWF4mqpSXYWSJA1ERVVgOgt4md0gmJNu3GTIXfywj/n9ssGu2OvAxw
 AnaTggpcEcUTFiEVeIxkSg/BlSUQUtFTzWFqdJb1lHSneEYJTIq8uG5zT4z2bxJoMQeVc/BBfw
 5M9MoVN5rfwnJtilNimdW7wYtNeOk4zTqJBMhJvGJUsz+JEHQoXMIiyj4i22raft5ukOU2ujOX
 riQ=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="153932868"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:33 +0800
IronPort-SDR: 4nLzvUi0Qv6aSoMSx/7SVBtuSJ0tiBaMZv5Le0FO980mOyVQ1dHoLd5Of3L+0GWzKbd2dfQp3n
 q0iEOS7JPioJwXudBwmPHAdjR7HmPDVj4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:07:44 -0800
IronPort-SDR: zg3/OKT+VIIk3PyMmu7C/7OanNewa7QdNcxm71LM5rsyPJTpP40GpRbnVlBsOFpZUF+u2EvEYI
 KgII++6f+sTg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:33 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date: Tue,  1 Dec 2020 22:22:23 -0800
Message-Id: <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012338_148234_D7BD3AE2 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
host to identify the support for ZNS.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d4fc1bb1a318..e7d2b96cda6b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -650,6 +650,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_ns(req);
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_CS_CTRL:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ctrl(req);
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		return nvmet_execute_identify_nslist(req);
 	case NVME_ID_CNS_NS_DESC_LIST:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
