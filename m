Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30439C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTMmShUjmFx8p0HIQ7kHOdeT6UpbMfAq2iP4W3/s5TM=; b=n5UhbzFg08IK6x/TQkejv1Gi9Z
	sD+EYo8YpHiH5nOVyDHSbdyQsxpCzUG8UnBSghPG3We9ZOeGAS9EjcB7GAihGDMHyqbxmmJ55YPpT
	4jFCbwvpMk8WPcD6pcjaicG3NKSSWLwEV4YMWyYNquyF0TvZs4aFeJ4poKjS9wxrfh0P5Sm29bXqd
	UJoXCKVWblZFAS45rjaTX26/dxoqxreuGGT+nbD5u1RGEIdfDS36omVq7zGNNURuZDh4nu32cA3m4
	9ieErNVAsXQgOfcAxBvtq8AEhyJU7RUhwJ6AdSaUW06BlxVrXhC+AslN5FJKB2ZvGgIJrNmIBTCee
	w82oW87A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2Cc-005lMP-4B; Thu, 29 Sep 2022 22:40:22 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2CT-005lGv-Mo
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:40:14 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 15:40:10 -0700
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V2 2/2] nvme: All AENs of type notify generate an NVME_AEN uevent
Date: Thu, 29 Sep 2022 15:39:55 -0700
Message-ID: <20220929223955.3275715-3-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220929223955.3275715-1-clay.mayers@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_154013_815319_7ABADB06 
X-CRM114-Status: UNSURE (   9.05  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <clay.mayers@kioxia.com>

This enables user mode processing of all unhandled AENs of type NOTIFY.

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4fcc7aec5a8c..a3d8e6476af3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4753,11 +4753,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		queue_work(nvme_wq, &ctrl->ana_work);
 		break;
 #endif
-	case NVME_AER_NOTICE_DISC_CHANGED:
+	default:
 		ctrl->aen_result = result;
 		break;
-	default:
-		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
 	return requeue;
 }
-- 
2.27.0


