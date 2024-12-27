Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F5E7718E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2024 04:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=; b=pCoFJahLyf/cjxj1sQRLFDAmH/
	03weF50Li6wOe/4hh3JyXS6jAbkWjMg4He3QVnqJ/h9BzwS7gUlrQofJgW1raSHXa5gJyOXv4lmh/
	eCF53YiigTLrTUPfjoj0Mo76cO+vV9Wb+5kvlEgz2u8tpdl6CdE/JUee+1C+LZfT8kdlNTh4qB3LP
	gIir42aHogJu/Ua/H15bXcIScrBrtQYjZyIScsdFIeP/s1wvMeHfFLu9RJ3tbu6XjbbhNE8EdTgU6
	FeOSH4Gwat2ZENixTLuRTkKyaqVgD5yuDnjFD5IVHnGnjdVVxRKpdbKxFwJ78lS3X3tAL/swFmhoy
	yOuM/gsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tR1wu-0000000H24u-04Og;
	Fri, 27 Dec 2024 04:27:44 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tR1wq-0000000H24C-2S3x
	for linux-nvme@lists.infradead.org;
	Fri, 27 Dec 2024 04:27:41 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso6766292a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Dec 2024 20:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735273659; x=1735878459; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=;
        b=AQCkkDxry2CwLPC7QxDmkh4ElntGAmi/zeBUIh7DbPjIQ3M1WylgnCaqLkIbeKQvid
         pYebLots50NdwL/Usor4T7esJnL3baTlEtLr9mVwPhaDtxHGBtVL4LzQt4dB85JoERoa
         +iXXrQUPYDHy0p6QpvqYps4gGnAuvO6riVLQYV1TiUJPY3Y6dkxhx+2PzpHF/2+B6ytd
         ENqlKRSVCqvx+Ji9rpa07NbxaGABSrX0ltNv788q8DHWGxsj7gAbIJR4phEF+C6IBqcp
         bUXeBzh5NZ8uFRFvMk1aSuCvedCaIUygsxYVPMUiPPiOp1tuNaUsqQ7ijTfHuvHH+Mu1
         HPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735273659; x=1735878459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRxgseqYg6SG0Gngnlshhg45wwA+5RS6D8NBrS32Xz8=;
        b=tVOU8jSnyOKVkVOpfmjnIinBEbhLBH1BNDT8szjkKpkNnQrKRWlVUL//m7iixQORVp
         a0xd9WJpLMnUDsoDyRjwIohEMtW51u4B2nbN5dvN3CQeRiKiYiZoRxkljzt98Zcr7sUv
         DkTgrK9hKB+RCbXMERHAb4BWHKU5q2+1ek9Gx8xWxicfAf0mGwYLBLiVPgfZOdFzwXjH
         BFTI1SRTD5OIQ6a77kvF6W3byGBVxrdP/NKRJLUFaR/kKewCOS+5uTxxJyXoEzrOWPXh
         AyryiCN1iAva2YGOHiyqIbkeqzUIbqddgQvUXasSPzYsOk6UGrrMZdNgF5RitmDIKhrh
         Zu9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbv83gzIwO2uMgmprWluE7VlrquBqXPCaTs7DsF7wW3BbQlBnnvBC1zLC1XYna2icFa0MuXr3M1iO4@lists.infradead.org
X-Gm-Message-State: AOJu0YwlCq+tVw/anLj8mUWp/01jdwzJiLeSzfcTPENi48dwKMq71/5G
	iiearDGtjcjR5+95P/Vn8rJ5ABrM7SV2OeehtpPCGPCX/EipVldg
X-Gm-Gg: ASbGncuraZ0ju+NlDQitq4IJsf+OMnRk5ONsj9zx/7Xuh/KixwDhosZQ3zDI3vXotyP
	beUjmwGVEzRV5bjGHpvdgvNVXWUFaf4PTI1P12bmrH60sQ+9DKs1gKagDzhjdeIdhDUl9Y1VLnZ
	P4+7B2Qg3bYuNhS41Q2AkWqeBRQ3VdTBY1xgHwea8RD8OhAW6bgNUa+s+xwWF/FqxblqGw1ZqMV
	e7QZUSH6o4pvku1e7BfA4E16izo0mzZLzDfZWKDHmWbump5e1jCo/n3IM0gklOqltCRzfMd
X-Google-Smtp-Source: AGHT+IGv89AUUOutOfm8ub4l6JvI+DQQ3VE0xPH3k5o8wPtnuHYt9mUFowB98LzlS4IdSaX+VAodAw==
X-Received: by 2002:a17:90b:54cb:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f452dfd2eamr38816193a91.7.1735273659375;
        Thu, 26 Dec 2024 20:27:39 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5abf:6c2:8c3c:dbc6:d773:4c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882d11sm14856128a91.39.2024.12.26.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 20:27:38 -0800 (PST)
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
Date: Fri, 27 Dec 2024 09:57:22 +0530
Message-Id: <20241227042722.1184-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_202740_645533_66AE5724 
X-CRM114-Status: GOOD (  15.14  )
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


