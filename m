Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA4D767F1
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LIXbyaTfssNAyjGRH62B+/Wf9jW1JYzFaYHYfgpeAWA=; b=pQrCFKD0Ltrh2gdhrEFJzbeobZ
	IZnfWmAHcnRRb6xImUkozKpHRVpjMNU0zq7gYJ094zGkF+lG78jgstOPGKOSWT95tvhLdIL2tKkDq
	KJoxCs25w74G3NBf3SPo87q8l1gHhlVPvmKk3Bk6FjF24xr3+0bTVwnSIXPiOsePlF6nlOLTRymAN
	LhfOMMniAvQzwC6qoqlC6LLduh23skvImHtcWapRFy5Hfg2Y1jI8tm2ohYSH9ZiJcTnYW2wEeNxxL
	VTCUScK08/aaexDsYzuU1QPwgfeolsxuq96CYKkpj4lDmrQyTKONm/u5koXvrHcinHp28kBkjED3w
	bwXtNBtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Z3O-00000004MXP-35wi;
	Thu, 31 Oct 2024 17:33:50 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Z3L-00000004MVz-3McT
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 17:33:49 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-539e4908837so153924e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730396026; x=1731000826; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIXbyaTfssNAyjGRH62B+/Wf9jW1JYzFaYHYfgpeAWA=;
        b=BZFXGXKMUM6/AbwXZib7MEv85SICmuReH0/sbG6vR159KtCovgCZgQmhEns/uc55bz
         8dR9AExZUbK1/Hlrszr9Mv1qmw+6Izx2DwVLK8hrKhv7EuapzJHEEODtffabO1JcMyBW
         xJaSqdca1H7c1GM66H7I6Q9eZe4vNXDBhldrX3zQyMzE4awB/q9of3E9ORJC4aPY55xv
         ZeTtDPgB2+tfDEAgDB29IY2HQONAj65VFIc5PJ9O1VKe/ZBcpctX3XsUJQBAs7IaQ+Ol
         hFGH4sEcxj/ySLThiilc+RafX/0D2gptWwH3cr03hhYNK5wjDYE0oQlUkYMyDB4/ughQ
         MgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396026; x=1731000826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIXbyaTfssNAyjGRH62B+/Wf9jW1JYzFaYHYfgpeAWA=;
        b=n4vEn4gI4O9vxCHwlvqYEMnL+TYHtb/vZE5wICbJUUamk0Zag2BhKA/Q9OsvRyGQiD
         EEwYKy88yciY4s/v3lc4x+kx+ZXjMLVLIJ+UKEjwpVnMBiKF9leLDiy7SsTcogFLrJ6t
         7JpqhDsqT2FDiyz+PRGx1heOBKzZGO3yRTb7geFdrT5CmYu8GxFMBq93WToFUg4tLwmh
         nHBQL0VV6W9JeBghl4WAayrhpOtC3MIk4ce1gbQ3o8qWYswzW3gFt0P2G/Hgt+r3OyXp
         AzwPEEjbcgFxjli2q+vDqzICdi54n9n8ByXYvRW4OGA8Dhi589hpPBdtUJMT76zUDJfW
         dwPg==
X-Forwarded-Encrypted: i=1; AJvYcCWVDA0bw3ybtT6vRw7l6CVucndsIFEmvuBcq2s8JfCIPD7YDdl9vleyztI4AyekUHHWVnubFJMQl8WX@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6ClBcIgjo+LH2aA5Mfao3G8wdPo2dsKgrqNdlHW/GNYwpk7gt
	k8dOvmYqMPYE46Pf99vRIbI4duJqvzl9DgkhSAEbgIkKJizP+srL
X-Google-Smtp-Source: AGHT+IHuM9wLydex6CXCJYt8RpMld+KpUmO1ocY+CUO2ZVzT1y6Hymj5lWWus0GILDLZ60xO3FUJdQ==
X-Received: by 2002:ac2:4c52:0:b0:52f:287:a083 with SMTP id 2adb3069b0e04-53b34728fd9mr3123365e87.0.1730396025338;
        Thu, 31 Oct 2024 10:33:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-121-216.nat.spd-mgts.ru. [109.252.121.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde09adsm272401e87.263.2024.10.31.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:33:44 -0700 (PDT)
From: George Rurikov <grurikov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: MrRurikov <grurikov@gmal.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	George Rurikov <g.ryurikov@securitycode.ru>
Subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
Date: Thu, 31 Oct 2024 20:33:27 +0300
Message-Id: <20241031173327.663-1-grurikov@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_103347_869338_17A75937 
X-CRM114-Status: GOOD (  13.32  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: MrRurikov <grurikov@gmal.com>

After having been assigned to a NULL value at rdma.c:1758, pointer 'queue'
is passed as 1st parameter in call to function
'nvmet_rdma_queue_established' at rdma.c:1773, as 1st parameter in call
to function 'nvmet_rdma_queue_disconnect' at rdma.c:1787 and as 2nd
parameter in call to function 'nvmet_rdma_queue_connect_fail' at
rdma.c:1800, where it is dereferenced.

I understand, that driver is confident that the
RDMA_CM_EVENT_CONNECT_REQUEST event will occur first and perform
initialization, but maliciously prepared hardware could send events in
violation of the protocol. Nothing guarantees that the sequence of events 
will start with RDMA_CM_EVENT_CONNECT_REQUEST.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: e1a2ee249b19 ("nvmet-rdma: Fix use after free in nvmet_rdma_cm_handler()")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/nvme/target/rdma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b6264fa5803..becebc95f349 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		ret = nvmet_rdma_queue_connect(cm_id, event);
 		break;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		nvmet_rdma_queue_established(queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_established(queue);
+			break;
+		}
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		if (!queue) {
 			struct nvmet_rdma_port *port = cm_id->context;
@@ -1782,8 +1784,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		nvmet_rdma_queue_disconnect(queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_disconnect(queue);
+			break;
+		}
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		ret = nvmet_rdma_device_removal(cm_id, queue);
 		break;
@@ -1793,8 +1797,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		fallthrough;
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
-		nvmet_rdma_queue_connect_fail(cm_id, queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_connect_fail(cm_id, queue);
+			break;
+		}
 	default:
 		pr_err("received unrecognized RDMA CM event %d\n",
 			event->event);
-- 
2.34.1


