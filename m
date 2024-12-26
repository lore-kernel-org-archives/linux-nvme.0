Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58EBE77188
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Dec 2024 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=; b=h2NWorX7/pOjX0qxVIb3Q9XqrX
	jkMHRNR5ruiQV/gVXvtyFph/rrB/jfICtrIj+Lq8Dd+nHipooLzRHhHxwYA6FbuKGuGjMCkzDkh/e
	bAS7wYRS58/WuiiY3yqWxOaiQnnmjccAaBo8UTrCfwduH67eQahykqxMrTTOVhRLd2DSw2OLaeXvo
	1FHvUPJItkCSpNXGAdofT/DwtgvqIcRk/secwIEXy8qy3Y93hv0C/yC0Z9FAOojll33TjhphlPp4R
	+5Smq5ySovFFV0NZyFzVgFM3cn/OR7mjGePpCQH6V3LujqT5U9RtFzXlumsPza5gyY+X/A5sWaAvs
	9YJ2TDvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQjww-0000000FVwp-1PUh;
	Thu, 26 Dec 2024 09:14:34 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQjwq-0000000FVwL-1HSI
	for linux-nvme@lists.infradead.org;
	Thu, 26 Dec 2024 09:14:29 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-215770613dbso52205735ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Dec 2024 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735204467; x=1735809267; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=;
        b=mdJceNDy/Zq9yy7l4c1wmmyWHq5DxvdsMEHW+6MAngmTTQ3OZ8GwIjIPAm5uY/Mr0e
         tAYFw9qaWGLL+QV5CYigqH6HjgvEJ1HljH405fasqRfZe9lR+tBbBT87+2wHZME7JKIC
         zpvVbunfLYGpu/I5vbrRiVt5zq3p1CtVKHX0Bu3Ino0yGhBR4nqMf7gNdNnYGa+49T90
         Puoh0iPT4q0CYr3anLjjt5KZSCwGJJHwqJiC8khXtPaxoakPXkZFqHCuO9qKl8CYcC1+
         aM3Rf9yLiksaUhIoyF2tWJX+JegGO9bFQlfo1AicAtLYRdYS6e9XCMuKvV4PXvZRx1Oh
         hDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735204467; x=1735809267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=;
        b=DRxuvvXCj/BrCxR01E3qjHO9HBRk6py9jBuO+7idQoCoy9aCTgex18C4e+jEofOWFL
         q3i/BxklabxJ5BUROUAERQIMO2LgYhrHC49mU7KiTTwjk2jT2aJpawKBmRoYdRAXyRNp
         qhLoY5j7J72dUfwbIwHoSmJmqkZO1qvasey95cO1bZDVxXqDUtvRJdGaAP8N3+DTz/3N
         hHH61iaW9589d6ModGt7QdP2Dwcgo0E15iniyGOLDprg1ZCjW8GEdI0x+oK2MhRhxXAX
         nTUfDWGy36Y8ckG1c3wbyXBrPRE3y/reUhx0B7XLD0JSw9PCwHTKV5TPEw3l8UJpFruX
         uV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3LFZDQ/bbAuyNXHhv3MEP3y6zSZR5wp20c5rOOmy1jLompuJI3gcwPrvCOdHxdy9gKfL4eJKcfaBL@lists.infradead.org
X-Gm-Message-State: AOJu0YzSY6DRjwTFddvCNfZyOke5slJCAf3mmJKjhk70pEKdKpI4se0L
	jhJC1+NMzAk9iL1tttonKItIN1wd0lPz6YMuR4ejYU4zRWojOm7S
X-Gm-Gg: ASbGncsPE2/4znMPcCE3qIkuGxwtrMRqUiAJEnaSl70fDoxwmCN6kYDzfusl+JQcmO+
	O4FWkKqe6qj+Yv4D/6cwSGK8X7iuCoThWaOletH3c72lu6wxnlyqT2LcBpzFLpqe863j0WJ5AA9
	gLDXZFA59w3kwPuT5+jRai4+NfQSMn+CI4is+supL1Io9ACnvuo0QJxt1PfVbwbzVFTVIv+ogLA
	VPwIytHYMgrsphys+AAdDA6IqiMzFRdeMaOx5Y+XbIJFxoHP79L/T6uQByhpTdJNvwc+ns=
X-Google-Smtp-Source: AGHT+IEOBHqXUmOzyotxhs3wGIge9btnL6d4lDsSjbWe+s52fbOBUT32V2yHItC2kgcocvbQr0OqIw==
X-Received: by 2002:a17:902:d4cf:b0:216:2426:767f with SMTP id d9443c01a7336-219e6f25d6bmr264940005ad.49.1735204466701;
        Thu, 26 Dec 2024 01:14:26 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5aad:aa2:cbe0:3ae3:20:fe15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02ac2sm115845255ad.272.2024.12.26.01.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 01:14:26 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: 
Cc: evepolonium@gmail.com,
	James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: add DIF support for intergrity metadata
Date: Thu, 26 Dec 2024 14:44:15 +0530
Message-Id: <20241226091415.354329-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_011428_355564_06F910D8 
X-CRM114-Status: GOOD (  15.67  )
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

This patch enhances the NVMe over Fibre Channel (NVMe-FC) driver to 
handle requests with integrity metadata (DIF).

- Added the inclusion of `<linux/blk-integrity.h>` to enable integrity operations.
- Implemented support for mapping integrity metadata using `blk_rq_map_integrity_sg`.
- Ensures proper handling of requests with integrity metadata, including error cases where mapping fails.

This update improves the reliability of data integrity checks in environments utilizing DIF.

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 drivers/nvme/host/fc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94..d0343133413f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -17,6 +17,7 @@
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
 #include <linux/blk-mq-pci.h>
+#include <linux/blk-integrity.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
@@ -2620,10 +2621,16 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 		freq->sg_cnt = 0;
 		return -EFAULT;
 	}
-
-	/*
-	 * TODO: blk_integrity_rq(rq)  for DIF
-	 */
+	/* Handle requests with integrity metadata (DIF) */
+	if (blk_integrity_rq(rq)) {
+		ret = blk_rq_map_integrity_sg(rq, freq->sg_table.sgl);
+		if (ret < 0) {
+			sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
+			freq->sg_cnt = 0;
+			return -EFAULT;
+		}
+		freq->sg_cnt += ret;
+	}
 	return 0;
 }
 
-- 
2.39.5


