Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC26C4742C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC57B20720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wVvsjpFJ";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="Klbu4mdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC57B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UXOjFJPWf9R/ONWsUggNAv71VcQ+4EVLp3EIdLurX7E=; b=wVvsjpFJi1hVGz5gAHxoz3hgv
	QorVkS3ZTonXaa+1i9rE+7c2KkuzQDdEdsmmfQV9MY27U7Y6o61LZ1vPfvzESrDN0WyZVm4oUEsLr
	b0neg0RI0zBcKyGZbN05gtACFa8wzvqJpFcJZowWZMOp4K7yzPpd6/neZihH0A7qe1DrHjOpcUmva
	3IwcsT9mYvInzo90IXF3Jd8w2BakZ1aRhI+n2Ih6mdwCSaIH65VaWhf0gEKzQwqbY4tZ0NutDyq9e
	KzqYfSgtj2/jzQUtgaaWvjEgHWlqMOQUIMU+Pig2uJd2lrz7bGl8ZVMiVHqkIX12u/t3n2Jleaj6n
	9KbLMGYXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeQ-0000Eq-5x; Thu, 29 Oct 2020 23:48:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHeN-0000Do-Bu
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604016113; x=1635552113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nCkPfnGdRxEglVLF7rwRQqcpKKKgEXT/JGMUS/phUYM=;
 b=Klbu4mdpO99VMNEFGnqs/jpl8PLbltQHmrHs2wpy4JSfHpFHAwmpm+LR
 8+N2b76y4Qfj88hOgcqsU3xa327n65Rt3t4GjYgxiY8TK/8W0HC/4SAmQ
 OY0Ob7C01VmuwU6wQLBbb/UDI7ukveQ2bgM+0p6l7aA4vftYwKe4CCpvn
 DJdFj7k8ijYLIhmiWujJm3oqYoygrD6fzYblUWJMlaFVSKcTlRRpJVO4E
 MVa7iB2rHJxRTWXnyquRnlya7QaXOq4WmwwkXp+BMvNtm1WagBa/4G8Qs
 /3CpJa28/QEDQUCrPDAjZb7XWRtbxUzE1wJgGoillzVievCc0fUVVhbHp w==;
IronPort-SDR: 5nuDheoGEeLEc9HMnGl9qGPOb0tWb8TFBGNE/VMJcy3+skUcgZl44sWJzLEmHdYrwc+gEGpu5p
 op1Uhk8eVOYLE9F+p7yXu9O6UKMr8fxXH41d8q0WflFLeF6pe6Oi2hWXGlLuM35sAz+wDKVCL0
 nplzBJfdaIWc/wHCI32EdzilNfFrd5zLh+AYTa3v6XUsmRSSd/4FUuFsnKJSiYMFD/M0T+/JrV
 KU4tSwD9QjdRXlzeRcDUN47UT5IisCHHtfeyUwUNiYu8hfyFyM09WxgKKHOVn4QAurBkQVSb1Q
 Sc4=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="254830200"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 08:01:52 +0800
IronPort-SDR: iH3MNPa0/20y22wI+E3+ITlHVznaFnE7VKI/Op4khMVdZV8MxNOwIh3LmMJYoz8eDPaPglXfOF
 GFUi9Att6ZhXblrkf1RgCFwlFMj9cO8Zrx55K1crlTMBUXaS1PmJRXsj7G39FHQrnfSszyvQP3
 Tt59qFw96SI62fiHhT2AYKZucFckCqCKx0hzgS37DqijlXf7VFvGeEYBMplWAaxLRl6wbKsCGG
 yY6SW4TCky1RZWSNL0iYYClKYIGDXdppksqOzEH+UI3RV5G85djZxUmPwNIR5iAwbQbNzdiGzf
 UNcjyFFpTL2shEmQTb0lR6tR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:33:15 -0700
IronPort-SDR: 2VigBc4AGH2OeT8yXlhhCjVcrm7zWZAHiZ8YbnEiQUZjSnrdxKIp8kur2DyQyACNbS2yNLmZC1
 /WvpJUr28ylhx/VXe/d6wXr5X3NZS47HzsmvpkHABBPG4BQzbVxe/OcJvQtgG7TfnGb6dGvWvL
 MXuNB9Wl9Olli+wBxg0qZERmqL44zi++udCNxM+9cbTTSSqd3geDlLnepUg5XEXs7e8xNZjn4L
 Rxotlf8TlRJYrp/cPsMUMAdKIZaBGAeI1V+Czk1sZbQKMz51t7oJb3wac6DLjTplgb3cyH3gyu
 ZJE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:48:10 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 4/7] nvmet: set default timeout for passthru requests
Date: Thu, 29 Oct 2020 16:47:36 -0700
Message-Id: <20201029234739.21266-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194811_550172_F81F0B2D 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_passthru_execute_cmd() we don't set the default timeout values
for passthru requests. Use the default values ro set the passthru
request timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8ee94f056898..da23485352d2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -250,6 +250,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
