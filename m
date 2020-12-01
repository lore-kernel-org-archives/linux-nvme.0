Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D37C64E8A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1F220725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJzhCbzZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NGLXBKsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QmZbNxz276iLlLPnV5+LNvJULN4MWuYMQCDbJpiL+8k=; b=EJzhCbzZjozlZMkfeFQvFS4Wo
	A8guhMmSPlsKjUo3tUlv6A46yp0Myv8txs+bbEEheu+pPwnna+PRcXU6WqhXu4VLj465Tv0TgLpcr
	wc0SMfeN9/wAByTaVMrnvpFSdCzr+mSTHZZ8jxAgamp8wcH8TcbMZCM4zgcsuuKwWSEXnzlxceACJ
	ApXQZjcibPm/hJhTcASojRpZ+KZeDaIqepcrkwCcPeuu4nY/9AzdMFXb9xB1s7Jshl5Y8RlJJ4U+3
	9bFCVlWiSnQbs3I2pHmeZ8f/jOHrm7u3Tqg0S2IODXYiXw09tgamxQtTCMXS2ubQkoiAwwWXdxD1I
	tfIY6nJhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx4Y-00005F-S7; Tue, 01 Dec 2020 04:15:26 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx4S-0008U0-Aw
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796120; x=1638332120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
 b=NGLXBKsTVhOdj+IcEnZrNEubgXA10Cvn+xomUHzp9kI8SB/E6soFIg9S
 6Ag5EW8H3QxLHE0+mz6W0F6ax63b/Au8APFUWys4XMqU7Vu8gG2aBs8KE
 I7x2Y8tYsQKDs19gE0NMcC7q8g0EkVUpNR3kJ6Tt2UGSsEp5zReuxuP6h
 Y3x3w2TdYmQyAYy4vSisCVgKOoNbAg5WDwnvY8xL1V3MF/1mveJOjD81I
 7le4j0x5M6N9Iwg2BAOQkz8w3+5wfSDFW+as0qIouQtaKN34zFgyrXfYA
 rlH/CsGAPIM8X6j5jtH5Xi2wwiXf7h08QmEGRRXmiy7JNbQ8vJzQYwtA1 Q==;
IronPort-SDR: AvasBPqYV5UNgX6Jryb2pP4/5uPJ0f8XhEOSBwChVeBlGrWO8j770H+b5PoMQ4DP1oaYqpvVTL
 WunfGoRxmGZdD33xKQfvCAKzH5w3NGcvi+XQbavppiLwrTUT5XmXzeWLZQaVuDu7xGYnyDEd1W
 qYu/UJHzY5701RDx3i0LPRA/0bgIqy4YBZ3nXnSecoj6SB9HTwE7a1agZgrVhE/+PHIqG9/R1q
 vpFTm26sru0s01g0mLyx+r5uARXZ3oPppcBNlDddFSoL9FMH6gfiG3IkSvFCVPu5txEBf2Zpbr
 51I=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="158346979"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:19 +0800
IronPort-SDR: X73dPZ4g3wZTEGoOsP/EYWOb9QAJAYbe4KkkTfUOLOb9qr8CWp9JZn3tcaEA89NgNSqJYZqolo
 uLii1lw0qC+7VnUvn/FxFy4yt2AnmlXbA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:59:32 -0800
IronPort-SDR: //xZ+qNsQRcAGeKCluZYuo0aHD1Fp1gdnJAggnvul6GPdSwObZMVXcGJymVr1bni4SUp1y9Rwi
 3XYh8f/KljCg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:19 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 7/9] nvmet: add zns cmd effects to support zbdev
Date: Mon, 30 Nov 2020 20:14:14 -0800
Message-Id: <20201201041416.16293-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231520_585322_A28B6778 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
