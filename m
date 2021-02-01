Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C658C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF1564E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF1564E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GSiaTMy0CX3IyV3JNjRq6Rd8TX2gtrud+JyQ9hy2P8U=; b=UoGHTEunUfTgPnNINq4ijSfnX
	cnToNg2tPpeDu91/6j7eA6u9VGHoF2OCQuGILp4ZCY3Hb4zoVd9UbgMOw1IzbQvQnbjeiHFmSdjjn
	73C2FK2BIaLFu/frSyO9PokHTYOt1oyNDaGKQlyTfAYAnH8a26YEhei39awmRBbS5wseCjyGsIPW9
	UN00T9uSmxqqfgiIt6w3DOnHjy2zS3pqEfpS2Dd5itYW+gChMy8zICRtW3MvQ1opy2o3flyuAQAi0
	cZ2ynr3o1q3+AfK4Uq5QG6OzWoKy9IdzNY2lLx0JAUGmTosRYPp25/zsrP8PVSHRc87T6xGcZh1Uq
	nSuC7vuuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ryp-0004xe-7r; Mon, 01 Feb 2021 05:42:31 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Ryn-0004wq-D3
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158149; x=1643694149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3F4xUYPdQnfZt9mmZeuPH3+8yrbeCQQUZqt9f4El3sw=;
 b=EvIRwgdCSwhFbFkCrmC17GElSddHSWdtgdBK7D02oJC/vGRd4QZibV/U
 C9Ka89KV7sexkKWMPgfDTZMHwy93xWciElFYIWPpS0ICNojX2pGvTVoot
 W5JEg3zdgD0Df8LFBL/6MaBMbQaPv2uz67hV0zPSbmLgfROqKU9+Miel2
 mmNDhsWODdlnczVJIifQLlx0nw9GFHtkQOcRAsiR4OITcxB/1MYWObHcA
 Vm+37Hn1TgJXJhUi9j9BgUco7wWeahs7jn9Zylz7HxHTFWAj+7t0tqHpA
 gPzNnYQAzlPu/DVH/HXTT2B7NfJ6jiL9e5yp8D+hn69q4P/sjmvPp0lbZ w==;
IronPort-SDR: kwwnZLA4ERTFlBjMOL9PBkj9Zaj5/6Mm/LuwDQJqPszRieHPas/2g+XfaTbZVGEK0rKi455F1n
 yCGMIMKLwQOBY3trHvMv9u3QPOpdKaAqnUOMUFbBBeeXktT0nCUGZKFS/t+oCMOnE+AOXFnw4f
 RpqU3FxJeCJc/noxeKnAGBiUlSUJ2Trl6dzt8G2T/bLtKczwPHFtAKDzYnkx48R/aG8FJJZAXF
 ZLBrLy7tUKJ32bS4hN6949xrhdNJi7IbqWFeePTGJpPhIk7FMJMZ8ryGUAvC4pnPPWqsKh6H7n
 CPA=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="163231186"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:28 +0800
IronPort-SDR: b6o/FUsDPTKIvUF+ZQyab9N1f9MQDXTHC2EMjpOj/nwyLAoli69O72W5HbH/f+0Pox4mmkcWDd
 q7OEdnxPULVsdQXIewrXow/hdBAjvQDPHE7VVtkRorLQldDg5FvVdnQiTIoGZbxRHg4fdd8uOK
 ftMl/o93+dW8VZE8GFpFKPAwvoXOLG9xE6dRjTh8Ud1SBO0evH2AYX+YOMiP/6WxVuJQL3JJHb
 0f1Z2BjPrTrS04OdNd0PNFa4noerWIoRHUXv033mKds5pVrDECP4rZDHIMqDqxn21j0uifCyNI
 sYqLLQK4EfQOgKk6VzDvxWlP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:26:42 -0800
IronPort-SDR: a0s9XUSvrfwg5qshrJFkTvD4i+xBnog8QeQKHQpUEHwfD1sbJDtcjWbbmG1jkRrw8Yrt2ZxrJR
 N9ddfv4be/ryqIH/pH/aDDaob6TwyyIwIuWYl3pk7pigpFz5wR93hmQlOGld7/JB3fxRtBQqPR
 PTLFTJMb9AMben0Zv6NMFbI6CoOPJiyRrYZ43R59+iJOhf9ofpFgbKas7GzefaQf9mtNNGrU/Y
 ArnSMNfW3BS0l3sRmETBxMDdi9F11GJ1XfMUAJfbi5agXwzqkNGzXtT/K3V19A9AoNS4DYd8+1
 aGo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:29 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 06/10] nvmet: add helper to report invalid opcode
Date: Sun, 31 Jan 2021 21:41:34 -0800
Message-Id: <20210201054138.34324-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004229_676411_F80ED0C7 
X-CRM114-Status: GOOD (  14.16  )
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

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Add an helper and use it in block device backend to keep the code
and error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  5 +----
 drivers/nvme/target/nvmet.h       | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 23095bdfce06..105ef2b125cf 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -449,9 +449,6 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-		       req->sq->qid);
-		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6864fd916bb5..2572e386e2b3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -613,4 +613,24 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline u16 nvmet_report_invalid_opcode(struct nvmet_req *req)
+{
+	char *backend;
+
+	if (req->ns->bdev)
+		backend = "bdev";
+	else if (req->ns->file)
+		backend = "file";
+	else if (nvmet_req_passthru_ctrl(req))
+		backend = "passthru";
+	else
+		backend = "unknown";
+
+	pr_err("unhandled cmd %d on qid %d for %s backend\n",
+		req->cmd->common.opcode, req->sq->qid, backend);
+
+	req->error_loc = offsetof(struct nvme_common_command, opcode);
+	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
