Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F69DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B3265092
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 05:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B3265092
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9mw1qAIjvjFR2jURtY3lpOqcImPRvzhwU7s3L0N7B00=; b=iFhMvc67fNOeadzVA9HpNl65d
	yEyoJqcMM7hOLBlc7jSnbEwg7KbQrLqNtwKqMKCfijX5ySJqO58oXNWSjEqg3z0ch6SSeUKBh8OO5
	UyVLkswgh8WXQzvyzLUDDv3WR8QprcxmF7NTBtneAllBhqG2/7wGKerxGm6EHYoxhQ8c0brQeGfy/
	rZgzSRy9WlTYGoNh2EDPBz9cyVR2w9M9LjVaHaVZekPibRElQhMx/nJzl6Lm/i945jIKE0sYJwvCv
	n9s27BB/Pnj1PhlDNVsAxg4Hdg+bZ3jocW4cbXpvxUYeBwILwxa7rs+MIUN3bM4xHSWoU/AJYJuXg
	iszY0ENcQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUTB-003lN0-Ov; Tue, 09 Mar 2021 04:59:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUSq-003lHc-Ga
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265964; x=1646801964;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VcCXK8drEYA+P0oOe1Hbh2nA3kULms4i2C1cgFOPBWg=;
 b=IUTMgzL6vcaYUIuku9v+2EJ+2dlMHKnGOM5Hh47nAoZylAX/ATlwgopY
 TNgQS1dOK6avbSLDkd9+YZifTPNT7cV0aiJ/KhqNalWAGv80/SZAe8mcX
 258tqqwy1YrOCOzu4XLpRwUDXT834tJO+CfLtQnFanvYACB1vNTymyF71
 bxlHjai9yV66LUdJk8h5s6lav78LH2gTWaH8+0Qc1HU5zosAkLqLgQWLJ
 8MgpjHgyGTyNrhhz+Ai/sKgs3YA6kbK6GEmcACRKng1qMqQCXdD6B/HwR
 o8c0nKaaVC+32sIdNFAr6qzJ54VqxmVEQDPocQX4+6QUafnNoG0wm0VmA w==;
IronPort-SDR: KtOEWx+DlwuHBZnT7ftxEhX70dpn+vS3nIdn8u5UfDmPRv/70Ygu/jMOpeYNKDio018EusC66S
 HxuKbTNgXi5QQzzA6uF8Fw7oQdD0d8F5siS7Pi1YVLl01lrEwriZRWMWWI3plmvBTmsZebQBlt
 riSbCDAi3jvLwYhmgrGGlCmNFkqV42BtfuzrvzrhTdeijFzYnSFbFm7JRZlh3xcE7/K3ZIMYDt
 2HBUuirC3jrcxSbyxiDZHWI+UI22mq8Wh73k0fmHX3yNDxErR5LbtkvRL282szKJWQkEC5ecAy
 kh4=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="272349232"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:59:22 +0800
IronPort-SDR: F6k7yezs9hFrEodVGLGP57vl4nUQUhLCoj7H7xMHOoxFNOjc7mwipdfGHKrpWvxwhtZ8VJyxUn
 TPyod3m7IdlnMVLr0o7S3Q2NIOVAe5WeXOjII6TPMuwwF1ugDHXmkoM+mQxZAgde6Eqtgyws0d
 /2AzSWQjXj8QvpLqIIB+kQAbdwoOuEaDvQ60JG2hsvUpsGc8WLZtijuWloeIcDoKqfZRT50MyW
 Q7vcZfK/s0t6XqRKUQgvjOqsfM4vaVt9Giy1/Cv8KVV9fCzB1t9XAUcWqiH+qGzz4QOfi2RuiT
 lwxM7Gf2e/0IbuimILcKCjP0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:40:21 -0800
IronPort-SDR: bVKPnuOvudgZb+QqGoNa/D4Prldp9CL9s//kzFZVw/mTwknENv1TTbeHq/WcEoTYtlo1mc2Bj2
 DJo5t4mveDoSA/4IUJGK4MVIgOe94UkFSWZHVDgOdFBCUeWWWcEloPUqrfC5wF8Zb292qolrYD
 0pPvEyFEjDIkMP+Ke+Lkk1UqSzMlSdPJV9i8kmxIhTECJF3sSTrekVStTmBf3FXvgKIg275WeP
 oYYbg2EY2md+OsHRDj9aXL5ciAXJZuOgX0iilrKsXtHaDoh016ivAeIHfIA4WMlkq3ww2dw6Hp
 lpc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:59:23 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 6/8] nvme-core: check ctrl css before setting up zns
Date: Mon,  8 Mar 2021 20:58:21 -0800
Message-Id: <20210309045823.18545-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045926_811004_36E41271 
X-CRM114-Status: GOOD (  11.48  )
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

In the nvme-core when setting up the ZNS in nvme_update_ns_info()
we currently don't check if ctrl supports the multi css. This can
lead to buggy controllers not having right fields set for the
multiple command sets.

Add a check by calling nvme_multi_css() in the nvme_update_ns_info()
to make sure controller support the multiple command sets.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..3a372db00b9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2217,6 +2217,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	nvme_update_disk_info(ns->disk, ns, id);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
+		if (!nvme_multi_css(ns->ctrl)) {
+			dev_warn(ns->ctrl->device,
+				"Command set not reported for nsid:%d\n",
+			ns->head->ns_id);
+			ret = -EINVAL;
+			goto out_unfreeze;
+		}
 		ret = nvme_update_zone_info(ns, lbaf);
 		if (ret)
 			goto out_unfreeze;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
