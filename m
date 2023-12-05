Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF01FC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oB10QVTe+c+CgYOvy5QxnjWt08lgOt1hzLXeNOFE9D0=; b=fINI5SzOuWR3W3RMr136mDpSDH
	EL1UD1uxJmHOKmN9UxLnDXflhJWI9a2grhWIeCTnLg5WkzhY5gqhdVJZ4cgQh5tU0eoVo4bMybT2j
	YD/iD4ycOYGyo2jfupDL56v8Z93ZGbEpZs77onolx6yMahee9v4EDoiP5S5WgauK6Sx5XqRr2GZ6D
	qkkQR2t8+pJvLV+2/Icg9OZ0/Bj5wmxCXioqn6KcUmeue7GN+opmQ/WgRYyenqVsLj8iUvWTC5qvj
	2Sto1lLy6ykbWiQxY0slwpt17qfpOwMoe/NSQJyawNLDkTi2rGEQ2Y4Lzc3gSinEIJ/8xEr0b75WX
	wkLaGC5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAQ0F-006Wiy-1I;
	Tue, 05 Dec 2023 07:37:59 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAQ0B-006Wht-2m
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 07:37:57 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VxtSWoL_1701761865;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VxtSWoL_1701761865)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 15:37:51 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-fabrics: check ioccsz and iorcsz
Date: Tue,  5 Dec 2023 15:37:40 +0800
Message-Id: <1701761860-17623-2-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_233756_052044_670F96DE 
X-CRM114-Status: UNSURE (   8.44  )
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

Make sure that ioccsz and iorcsz returned by target
are correct before use it.

Per 2.0a base NVMe spec:
I/O Queue Command Capsule Supported Size (IOCCSZ): This field defines
the maximum I/O command capsule size in 16 byte units. The minimum value
that shall be indicated is 4 corresponding to 64 bytes.
I/O Queue Response Capsule Supported Size (IORCSZ): This field defines
the maximum I/O response capsule size in 16 byte units. The minimum
value that shall be indicated is 1 corresponding to 16 bytes.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4da6ee6..87db4a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3043,6 +3043,20 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
 
+	if (ctrl->ioccsz < 4) {
+		dev_err(ctrl->device,
+			"I/O queue command capsule supported size %d < 4\n",
+			ctrl->ioccsz);
+		return -EINVAL;
+	}
+
+	if (ctrl->iorcsz < 1) {
+		dev_err(ctrl->device,
+			"I/O queue response capsule supported size %d < 1\n",
+			ctrl->iorcsz);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1


