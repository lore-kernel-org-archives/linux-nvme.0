Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B9C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA212205ED
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA212205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p/JdAhgbPKWyvvSO5QrcCllamvyoKQ7x+iJWOQ/tWvw=; b=W/cOiYtvTZRH4E2RZaPjO/wVA
	1SGCEEYYGdNdDD0ZzFwgUlGHQfAQABHBKctOeJtplKVkg1AXpJBjdZuZ6HzHqRyhDThLAtLkIcm7t
	DZO6TwoTz/vl0IGVC7XHsX7dm18IkL3oI9Y89ySumH+wBm7riILXM3sl2nHEXgBHKc21aTZOd0Vom
	IrViTVcWGtjLtO6ajDTXVlTMjmP2dJ3u5tRzWMBiYr3cY//40T7DYPWDGTA06Qd+7tFzSu76LfnUJ
	teKAi8Y6+Z5RMioCJWsZ18C9Rg+shbBvaBdogbwx9ba29vkbNj5gX5tz14GdT4LvdsDJEaCyKC9AM
	QSVBQ4bTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLYd-0005jV-71; Wed, 02 Dec 2020 06:24:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLYZ-0005h5-Io
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890881; x=1638426881;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
 b=cOR4cHaUE/Q814CnuuJkSHNGN/t2XMum+B70987y+2toXaJSz7eluFkV
 alLmzjEvOJYhOcfk4sMx6tAlaiwuw5VKZAA+KBukevhMGu1bF5LJQ2shC
 KoiKw4jwVDfyRtabnYcowH2yphLTP8nfTXSCIOZbRtiQqEVbJoiL3TSSU
 vmTzISILblKKuHYNvwil+dDtaVtNTwBjDl73tg/MF8F/dg3vZ7bz4S9Ix
 VtXHDJKb8Uz6dric+5n0/Wrwues81LqASTuP+PKxo9YTNj5xHNVJXGyKU
 wz6fb9BUKVh5wDAgwHoWp8HuEZMX7garNHcbyNKqlIx+ZIeTwdziONYF7 Q==;
IronPort-SDR: pyLfFbcL0sUg+ci/1DyI6hFZNbCqdV9RTiJtbsTTAcJVMm1wOfyH/dXIBtNazJxi62JuvnegeV
 UGbjZtpUDNZqoefRtWoRL/2MF0FMrndUdsTuGLcgqmZlLGT39uUwgonH7qvq6hG3Nw0+HUExeU
 ONB+dlvpzX7njLVuw3sOYW504YO5HzUlj6TGaWhGWBeI2WV3eJLDalkkEnt9VK+7FIju4bhJ0n
 GREJMNxn1AXGCHwqL1cmaP9KDalt/g0n68SSbs4ZMzCRIMC/Spn9FsmQqcpHh8xegVdFRReDsT
 pMs=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="257684167"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:34:37 +0800
IronPort-SDR: izN37iAAQwJv7lfTI9Aw7Js4YK090fiNupwF2MnroFH8HFAIyQAxNhqh2I2PdwDQosDvW7n1Hb
 3YtoVuRft+DkJaIxBYlxlfDSekhA6nFiE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:09:35 -0800
IronPort-SDR: pBQWN2G/rG01ZtfZmZxyR1JoaSnr0hctnDIfC2fg5Qi3qzSlOZAhl7P3HVUfMpjNGA0ULBA/K6
 O7h4KZUNikNw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:24:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 9/9] nvmet: add ZNS based I/O cmds handlers
Date: Tue,  1 Dec 2020 22:22:27 -0800
Message-Id: <20201202062227.9826-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012403_784216_AB6B3277 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e1f6d59dd341..25dcd0544d5d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
