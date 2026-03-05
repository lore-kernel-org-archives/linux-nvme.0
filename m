Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E17F47CCE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HQMoFpZFPnY9iExqsKENry4ZRR79ZPh5u7A7J7oYrH8=; b=R30PKWH+e15oV0YECGUsQFGhwg
	bwzYuNIagA26o1qekbXp9kxyxAeuV9XGAJYv9H8LTKYhaKNRd/KROQur1UpQKouZLbtrJkZ0R25NP
	ogZRQ1MxlzcmSrkiRzQtMW+XwTS0FO8PobAd4WDEplzIuF5Fhfo9Uy4B7Mq6dB8WRS3IfQp+wA2EJ
	d3mr3k4Uzs5VoJgbRZb70qERuPHMxYJDsgz/Djp8OYtKzUMgsLZxHLjhB5ao8QZjKNYoCqB1Xl3C7
	sXwnAd7EHF4PbJgda5cMulQEJIq+O11lLGEBTs9X5mnT8ls7E/1ILm9GWJz8XfA0eWk+P9LYyjmjq
	xqOOXziQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyFJ3-00000002X90-1yWB;
	Thu, 05 Mar 2026 20:28:25 +0000
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyFIz-00000002X8E-1D5S
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 20:28:23 +0000
Received: by mail-dl1-x124a.google.com with SMTP id a92af1059eb24-1277896014fso16891222c88.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2026 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772742500; x=1773347300; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQMoFpZFPnY9iExqsKENry4ZRR79ZPh5u7A7J7oYrH8=;
        b=z+pYO/jdlO5nOkDepgYACNuaPbPF/j9mimH9q07OJnR4AW3Fi1gKfYnL2//Hhjkx3O
         KCmsoDM7F3ZYC0myKoyVaqt9ImZ9+F2wvfvJUHcDiechWT3QmGIvm3GDpiAGC89IQcdx
         qyRCjjm/SsCpLnRZPVJ6lq6gY6h9QxIoSDo9i85VnnXihiKYmcVHeDrkrV41/XJkMYXC
         pnrb8vhiqwBIgdM444zJc54zJgET4XKzp5JfZd1+um7A9LcZh3VriLrjmLpkwjo5I9wf
         bZAlXSGUf+f1eMtErkOha0NQDdDu7dl0hwoBqXADNtv4fgN7B1x9+cUNmMMuvwRq7Awc
         ApRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772742500; x=1773347300;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQMoFpZFPnY9iExqsKENry4ZRR79ZPh5u7A7J7oYrH8=;
        b=ZDeP8m9JUjFOOvRxnNSdx7kPPHmIQO6Srik0HqXxmDye664rrge68KwEJxoQVSkLjR
         bnAyf541teNyE3+ismtoN0PlevJcf+GrPJW89UPJqhNh71dBDz/0dbWi3c7uC2lQK+ck
         cIGHkh0J13SW4NIDL/kuTjPTdNoiIDg3LxTZ9Zotoau5ArRjV9Ag3oBqQ73XFCIg+ITC
         iL1UaOSD6EzGc7bFGmRBG6vh452uIBQ8bSQoQM5wsNLYqBM079Ac5yq7otDo2MqCt2iU
         czoMlqHAaV/Ur3bCmK+HKSEGJRq9nUSZ/kqqvA/1vTn4zvuaA2Rl4opTFx3viCuWJVbZ
         bI2g==
X-Forwarded-Encrypted: i=1; AJvYcCVlGEu4aTeLqtIFHRYU1QUofGCxH/6S3Ayiwo31zvfJT0jiBG2xsB+6+eHiWNRLpZ4b1KSFNRgMm90b@lists.infradead.org
X-Gm-Message-State: AOJu0YxLJJxPl/hZCuOYf1D+dD7ZYc6vO2r28IEarDpLmgthU37r/Hyu
	Oev3r82+8k1Wh3dNsitRbTop0zgSq08iiT7/C1uBJZGsLsVwu0LRPd6KIXGbnBdJQRAQ2QM3Hjx
	UbRnqQfzcMX6X0ZhM0+Ls5Q==
X-Received: from dlam21-n1.prod.google.com ([2002:a05:701b:2095:10b0:127:89b6:8d2a])
 (user=robertpang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ba4:b0:11b:7824:5c97 with SMTP id a92af1059eb24-128b70ebd92mr3414667c88.40.1772742499786;
 Thu, 05 Mar 2026 12:28:19 -0800 (PST)
Date: Thu,  5 Mar 2026 12:27:32 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305202735.1773922-1-robertpang@google.com>
Subject: [PATCH] nvme: honor NVME_QUIRK_DEALLOCATE_ZEROES for unmap Write Zeroes
From: Robert Pang <robertpang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com, 
	chengzhihao1@huawei.com, djwong@kernel.org, john.g.garry@oracle.com, 
	martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu, 
	yangerkun@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com, 
	robertpang@google.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_122821_332472_7952C8A9 
X-CRM114-Status: GOOD (  13.63  )
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

Currently, the NVMe driver sets max_hw_wzeroes_unmap_sectors to indicate the
support for unmap Write Zeroes based strictly on the Deallocate Logical Block
Features (dlfeat) in the Identify Namespace data (commit 545fb46e5bc6 "nvme: set
max_hw_wzeroes_unmap_sectors if device supports DEAC bit").

However, certain devices already use the NVME_QUIRK_DEALLOCATE_ZEROES quirk to
indicate that they deterministically return zeroes after a deallocate/discard
operation to support the Write Zeroes operation in nvme_setup_write_zeroes().
For these devices, it is appropriate to treat them as supporting the unmap Write
Zeroes operation.

Update nvme_update_disk_info() to allow the presence of the DEALLOCATE_ZEROES
quirk (combined with DSM support) to set max_hw_wzeroes_unmap_sectors to enable
the support for unmap Write Zeroes. This ensures consistency with how these
devices are handled elsewhere in the driver.

Signed-off-by: Robert Pang <robertpang@google.com>
Link: https://lore.kernel.org/linux-ext4/20260225000531.3658802-1-robertpang@google.com/T/#m5e776f78ecb7631372d82a5cb3d11f8f1f8afe06
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..3f5dd3f867e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
 	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
 		lim->max_write_zeroes_sectors = UINT_MAX;
-	else
+		lim->max_hw_wzeroes_unmap_sectors = UINT_MAX;
+	} else
 		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
 	return valid;
 }
-- 
2.53.0.473.g4a7958ca14-goog


