Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483AFC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A49D6105A
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A49D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUE4WbuV8lK1Nz6PJXlZMOXMayJPwHKJdW2By0TYiG4=; b=VvfgsJySJypkLv
	hFTTVsbyNQ1eSPNl3j4rsZ1c5Neb1BDdGWgJWzr0layF+8BANawxOKyx7de739XDVHAJecnst+FQu
	fNOwYyVu+jc+l816HYPXHHGBmiSqsMwOk86g0/kB3k/7f4o8pZQMEEJ+gNQWuIj75r4qvYz9qJgr9
	78IcP8UDdkQY0TpMa640GT+KMBCgLcKzY0KgQqogKWFxIi6VWZWnaHRTsQcgYs5a53rXvIz6LMzKU
	Ct2K1xpGCNQ9VWv4baHddvifnWyAIwzR6JDwcnG3PWiBHY/hAgeyn3JM2DcgCgGll/nd7p9kORuM/
	NZaGVKMYx66N7kUBUd+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltdpm-007qXj-QH; Wed, 16 Jun 2021 22:16:30 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltdpS-007qWA-Om
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 22:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623881771; x=1655417771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Lhp9Dn1aV+fRcUaFkhwelfKe7WMGd84XfY3J5eFB/c=;
 b=MC6MrrX/eZyUcvXrPUGA8EQZEMSTA0O6KNnqs1WV8IqFTP1D53KCoJH+
 Yv0oC+PC9aBI/Lbc64o7VQc7llhs18lDSNGJe8TR0I0onsQNXH9WUO3Sq
 SLJejKKEW1rEHN+j4bMSA7mEghgvB1sFefCrLG8qEP9d9ib56ktyPIOik
 d3g45UxeeSgf1FxYeiNswrsVwFbSA6DfHHKsYNI9kcodv/6n4H+R+xuwu
 /9pkevQ+EJYSdoUGmTxFxKg1oyjMZLv/jFn0DHq3HusE0gFn2Wt/KBYcP
 RX7qOSa9KjuqhSWozOQOXOsPS2zLGHYYKwFr0jp8/Uav/NqujloGagGWz A==;
IronPort-SDR: J1ZZZBgMx+dOGsQpePBmdNRwOTKzM7cxrGjoZCLCQQMzi8KBGZ9/ATOvOry3ZMw2WQU19ypksO
 shQB3tbxtxmGoH+HmDUw9BSVoPAX/gnbWeV6S/MuyFqSu/hFITvPSwIk4CFaTIW5ngEwl26RSV
 sJmKEM1Q52H7PM7eo1TU8/Mq44MGYI5GD4qVxSbKiFJCamCa7aJBgxLVt0CTGYSahqiE7iHF4+
 Pn+3bGiHlp85CzVXFTmPen64EHQOC/plLrDwNFttg3/TZbTA1z3JXIMyrtbBqv5xlwNDbLkkNw
 wR8=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; d="scan'208";a="172703065"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2021 06:16:10 +0800
IronPort-SDR: zFTDNjPYInn6nrmqkUSOK8P7KIBdiGNKKNe0MAWLq4JLNAmugy9X/z25VDGDea7y1YX7VtcEYU
 PHo7dtYCGlQd0kkK/HEXLUf9DdBthKx3vboU/cQX1w6pcSDxiqrtfDg7OcnLny66jM04bvxv6i
 /J9sYJ6Cd8myvVmmbXqa65+FE5RALGTeVcEbnRaPeXxMK6/vGqwoYVjI8HAp/CzKGcD5hnTEpQ
 67Kfsf+QFJN2xwhAVBo0ihZMkkfTJrbn+Q274TuLJ17fjzqWLxYYDzu/Ub0nTwzepzXkDqLBfT
 de27bowAIQHF9Ci/J+rhS2ML
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 14:53:37 -0700
IronPort-SDR: ycptSqYOksv8H0B9mVdC7sz3XcZ7xMPcS1AF5aXd6Le5PkvjPFgKB27mF/ffTxjUonn+W9Wdep
 YomTo6tS9ciR3wP1waHBk0CO3AxbWrB7SSTWjfVN7j/aswu6rQscg/J1mbspFhI6THB4cVHD7z
 Du+30wgmqs0XvcKSh0KexEEn11J8H0h+XFcFkdJAbIKqB3JkdwKwnV+OkXqZmjdNp8HyUyeWCm
 0pv44CVf+3CSNnO42bOWmmkKwTqVjv0LmG3ciFYw+mRqOO5j2bS8wa10dJ2sZ9H75fw9S53K3s
 NzY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2021 15:16:10 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/3] nvmet: remove zeroout memset call for struct
Date: Wed, 16 Jun 2021 15:15:51 -0700
Message-Id: <20210616221553.55914-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
References: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_151610_905216_A2BEE774 
X-CRM114-Status: GOOD (  13.12  )
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

Declare and initialize structure variables to zero values so that we can
remove zeroout memset calls in the target/rdma.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7d607f435e36..891174ccd44b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1257,7 +1257,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 
 static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 {
-	struct ib_qp_init_attr qp_attr;
+	struct ib_qp_init_attr qp_attr = { };
 	struct nvmet_rdma_device *ndev = queue->dev;
 	int nr_cqe, ret, i, factor;
 
@@ -1275,7 +1275,6 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		goto out;
 	}
 
-	memset(&qp_attr, 0, sizeof(qp_attr));
 	qp_attr.qp_context = queue;
 	qp_attr.event_handler = nvmet_rdma_qp_event;
 	qp_attr.send_cq = queue->cq;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
