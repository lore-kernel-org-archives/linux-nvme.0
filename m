Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46691C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0721964EAA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0721964EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oc/K2uNxmMtQfh9IOeJQSlLxFsW9+1Yvt427Hh4/RCQ=; b=eRfhMVZtkhAUyCc32N7/iCQhW
	K0d56sNknmJXexl5c8K/JLeLRDBulIBE9qCA9q8qizLh0rHBOVof5NvbVRjnRtX3QoTJE5LYn1srw
	6Ma2rkblLo25q4OMLYRHLslp0MboMlenNOUokqi5qjlAiea0CuJIM9iSYaspiHyiXzQywK//Wd1S7
	7A3Zx/r3viLV7mCPLRhplxFVshmPTYpamhK4BxzmiUdKZsHjJjdg4QF8tY5SEccyHZxmbaso4+av2
	aoLaJsFrzOQKkkmZoNKiPpis69Oy+/NuVtskTRKeJ5Gck+ed+Qjyi55WVL5tlrKig+hOk/zM7v1ZS
	POY1ZGtQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KL9-00039a-6W; Tue, 09 Feb 2021 04:09:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKn-0002zV-8q
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843745; x=1644379745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OJAynS3Kv/UlTyycM5j8QungtTUtwyaJ38ZPqHX5QPA=;
 b=IoG9ld+wRQmhzL4CJvdd9YK6pDKRs7PmGWRjghyZcj5EPZRdL2ZwFfN/
 VL0FJZpVlk/3rKMJS3v+YnYzR+0GtZOQ0MjbwHqgic3wh7y8m15Tm+QXc
 hpZxyEKyv1m1AGZaNtVmzosUNjZ0+OuvAtXpahkiAuJc/dzyBLznshTZa
 fn0379o6WM65I9AIoaFIc+Lm8GUlKxkLi2ZpGvcqsKEakkRi+rz/hhZOQ
 EYINbkVl/vB8s/4mBnFmeZdHje32FOlJdAnIcedbC+m+Zyb25bRfRGAiB
 IB5PHcKINqv9CscG3yECs92tPwRHhQl99b7WglTWaM8McQGTjwEotQ9Ig g==;
IronPort-SDR: SqvEarM82hjlaBRHzpiqPsk8k1yDnGCRFuVzYgGK1xHhBo0e/uC4GOg+8SN072c2olaQIN3oVG
 1SH990vnc1CHf+8lfhxPNbsGZmvUcuj8XkPPzi5IhBi2nTSA9Rhn4Iblyu/pONsncwOox6HRCb
 lX9ELGlqoLY+4rIx/PnI1P/58FqKncydAuChsssONhyZ/LWVpV4+OLt478dsZAxRMfF485X1lT
 CZEpLUjQG0Za8x+yeMhkO8QiP7noMlYk6TtWpa8sjrJERO6SXyQW4UURc2i/bRTSWZh0sI+dYR
 CN0=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970529"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:09:04 +0800
IronPort-SDR: yv3eQt0h8uhFW6MczLII1WH3PYI/wqvucI21uCcrW21q8ByE6SSMmGr9hCo9d1s5RXwi1GTdju
 +jRfvxmceutKSsIJHYCzrur/cdyxe2AfmCMowjB8YvpzFONYkXbTmtgQJKCJ6hX9ZDhg7LLy73
 kxK6DzfiewoLlaljdodKFEl19FcX0ZNAZYhxl0urAhYfNx4XsA3BGglOwG1VChRCuGgmDBUKT6
 W6OI6CQ/h078wfL5aIYVbfAr+TZxrS+oNpfMQSSabsvc394+BxjkgOJy8X58L1SHbrGHpOp0OC
 +I0wsMz8bgAwH+NH9VK6XT6S
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:58 -0800
IronPort-SDR: 4+675NJ7Oj4l11/vdyzxO21009iaGEVqkVjpXB9eG2flKJhTxOaWFost9aJF8fou/JDhh2wUQI
 PkAqUUg6UpTpqu7OVIn373iU/eL97/MEsIZw07antqjgWl72HnyY1FrcRBr2JhkdbGZ1Lses54
 lDbzxWAbuLPebPIjyVYrSr4NGuVdhut+1PKCTwsbxr2GIMxRFO6tAXJUQ5/21KSgHXQdl9QrXo
 +bC70tp4HH2IaAWzyBOcRVhi2hvqN7NvlvwWaPSQDkHiQ85ssTzqXLRbzBLzQsUBlB5htO2RZo
 0xM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:09:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 11/11] nvmet: remove else at the end of the function
Date: Mon,  8 Feb 2021 20:08:43 -0800
Message-Id: <20210209040843.45572-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230905_498999_3BD348FA 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_parse_io_cmd() returns value from
nvmet_file_parse_io_cmd() or nvmet_bdev_parse_io_cmd() based on which
backend is set for the request. Remove the else and just return the
value from nvmet_bdev_parse_io_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 32221f98f1cc..1d5516272530 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -882,8 +882,8 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 
 	if (req->ns->file)
 		return nvmet_file_parse_io_cmd(req);
-	else
-		return nvmet_bdev_parse_io_cmd(req);
+
+	return nvmet_bdev_parse_io_cmd(req);
 }
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
