Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F1C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5063A64DF2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5063A64DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UVEvwMQ7SL8y/YIU0SASwrMKh9B/waijW+8H7CdNUJ0=; b=CG5DOaiSKB82n4Jd7hd2w+dpF
	AC36rgo+OB0SSnwaMGpt+JwzWSXKsYE53u9AifnxQhzVVelS9MrQxungm9oP1lTn+S8IGWISq2DBr
	G5R5ZlXh4A2BJE8PCm1uRKSjhEtXzR8WUkoHt1rA2S1MHrH9P92n3fwal84f/k1UG1f/AL95EembX
	zllSTQ0GFFVyGbN2mfaUZydMV7dpPptsMssg2+JS2XfQuHb7IZ25+JMN1qL6UTLeHfBK3v22lpGX5
	kTJHqXN5bTw9SBJQhkayMECEDhYBKlifvJ8TPWZhuCjQ2V4+N37ZcsV4UNSNalItqz4d36cjbafnn
	kFJ3B5cbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxS-0004SS-4t; Mon, 01 Mar 2021 02:06:50 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxQ-0004Rk-8g
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564409; x=1646100409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ahM8Ai94W/AmGqQIWRJ3E/03uQ4JvoEHUB7AFuwZayQ=;
 b=ibjTmIxFWWV+mhsAomaG3zGFRT+izsyDrZuVVDWsD7j+IQts1d1VCKaI
 HuUm+3MqDlHZHBDU61EhMcR3UKOX7IisCBIaZNCGYl3rPb6Nxgpv8Qpzz
 wp+PnWuQd0JZl/MdhGUDmP46Bdq6XYGa7vN+o7U6A6qcecIfrLnQhFY6X
 Juq4nFz4pBNGZMCR0NwNE8IMh36x3nEn+F0JrvIxskaFBU19tqX4yr9uU
 ATxsvnWtcImFddPS4Swc/rFob1BTZkxIxNj8ciUM6tQ6VEtigLZxwAn8V
 iNiRWHj8i9BpxLsR2XrTqelep/UDuN0zdtFjMacVEtXUKyUlqOvW51xMi Q==;
IronPort-SDR: 6rnlQyUis0nuuCQ0jNIPhIQew6TTVrag5U4nv9Tw3ZnRNfaUee6fsLPn+58r2sMkQiU6lswVKR
 wBCZwj0Fx4/l1l67PF8G80boXV8aRaRDda9ccG/Sx8tHQZ5GzjNB8rQwtCAd0EZHCqrYmBIial
 aQs2cCjbQAS/mAGQhYEB31DkWmBwpbtPtXrue7hGjFybKxv0ZwoZ4lbupdeTD7EkWT8hSCwugI
 6VkP9BBKt5G27l5m4yqgNjUXyCWA9eXtY1E2NvmcmGtLS/w3Fp6ptkutrcM03rS68zukqaHkek
 zOo=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="162191630"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:06:48 +0800
IronPort-SDR: S9isI3avlAZ5vjiEHgTeWfH64EI7PSvztUhyUrk6CNVbW5jpEpH4xw5j3R/Aj8frVkvtWESkxu
 RSbknFrKMBgB0NMk6ZAX9kwPiNvpv71C9UfebacWaXTfOQkvPycvOSqZN3YEWwjyu/geekN9c8
 QD6B5NcgNO+OCy6n+Wv0h4gQ4vzeFcH26VfAeOiwjSx3IwHrZ/zJIZGUIKSoQIyg7muqazPrad
 Bos2fBwtjY1ngWXv+mHnQUspCtI580jKuDtHpWpBENEcRJFWqV1uLmkMWxDjR6l0b7gN2Pdxhz
 RMLwjlXOwqCK7yrYvsPYRkB8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:49:56 -0800
IronPort-SDR: aJd/o/4i2l7H4njYSnoy9oe4s4tptNsygJRjjIIsqdBjVjSYWh/YmZDNVA9R4HG+Gux2rAPPe2
 F5+pf5NdnUiyQvcNzxzclE2oHme9t/yBT19USWGc+p2kCQ0MQevTP85i68bxFI3wG/HP9KYj/C
 b7e4iDPkhbQS/Vb8uz8PJ0TWe4LWTpn6qX3iNVvC1H88CE3Nva9EMAAL7VVIuKlAYcjMByQB1x
 TiwkBKOgV/NISf9r8oGtfE33+lD70dIInlnA39c0BaG470u/aP7yZz0tUjxY5Ohf06zF2dK60U
 JYg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:06:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/8] nvme-core: use likely in nvme_init_request()
Date: Sun, 28 Feb 2021 18:06:07 -0800
Message-Id: <20210301020611.18669-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210648_456311_639A4110 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For NVMeOF Target passthru backend we allocate the passthru request with
nvme_alloc_request(). The functions :-

nvmet_passthru_execute_cmd()
 nvme_alloc_request()
  nvme_init_request()

are in the fast path for I/O commands.

In nvme_init_request() we set the timeout based on the
req->q->queuedata check & that is always true for the I/O commands
coming from the passthru backend which are high frequency commands.

Annotate req->q->queuedata check with likely() in nvme_init_request().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 484866e52ba7..dab18472e39f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -589,7 +589,7 @@ static inline unsigned int nvme_req_op(struct nvme_command *cmd)
 static inline void nvme_init_request(struct request *req,
 		struct nvme_command *cmd)
 {
-	if (req->q->queuedata)
+	if (likely(req->q->queuedata))
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
 		req->timeout = NVME_ADMIN_TIMEOUT;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
