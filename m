Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C1C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493622083E
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RNjXMYYx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XCXMcUOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493622083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DWquNKprcRplv7VZQ2O6ei3DIIpRy8+C6p15t56kUHE=; b=RNjXMYYxO5S43AMCVFUM1nOUZ
	kL5cMicVwAbuPz/m9KDGHR0iozLK9+oybfdhE+0y9OvnmuehL/2nqEcydciNMsmEY8Innw/dXvOOV
	g6elkH2Sav9FNf80r04UtQA7h3YVDYr7i69Egb6zKWIhqqiNxKJSNxZmc++zucetGUvyNftjsKrt+
	hWmZ/oXJs04x/fSSyguL1YeEtneHdJ4WSZfD0reL+XKp03mLEF4V+LlU3ckK3FFabguoMmiNJKUIk
	u9VhyhL5pR4TI5692O2hHExdJKvkTDQ1cJ7PLnzmIyErbsX683rqzOjvZnmi2pd1CtgyrXAot8U6D
	0oXtF2Huw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsH2-0005VK-5d; Mon, 31 Aug 2020 22:27:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsGx-0005Qk-F3
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912851; x=1630448851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pK8Ll9mElogL1iR0Iz26aObwe4wrGe3aNATupjA5hoM=;
 b=XCXMcUOAreW438/V/mmBtZT6rv24GtaZt2t+xZu7PQb3M3r1rLwRPCXq
 plNG8+H91WQ1BFYefDE9xHRCnOAUK6etvV7j29FNzBamwsRmhFRvEDbpk
 0opcUmlQCIT4AZVlbwmW6PXFNE9p/Y77ijUsxVguoZyrYvvWw5rLtPcJL
 C0NDF7JQJXLRk/qInpHOQTb5S2IcgDpNfck9NcNqSpfb1NpfW6bbyg+x+
 1SVbLi0XBRu9T4wtRJFUWGqyQDGdykHiBI5WzeBP9G7DI1AFWHcdecq/B
 sN89ueg1aE7wKCqLaZMUmiD7pD5XTMaA/zKQWVAa7/KPVhkIU3KC2bzev Q==;
IronPort-SDR: 3OHnwudg65iJbKmr/k6IhcJvTJlILo5mOpqsrg+HqmETfkpwM50R9OWXyjgVdeGMkcjrKUNMaf
 MYfewGLyt4pnUxehjA4NfzyzQgtnVdKU3mFhx371jktfrPppWB5re7RHU660e6Jtf2Iq80GzxK
 K30d3rdKDBWyGpdeXCdu8xeGh41v7Zq+5s69cua7VBuldAPfkz+PFUFiqjamuDB3QKY3op6zJm
 31v6JSD4JfSPJNCNp2JcTZaBGd5fiVlbiB8kjihWnskgW54kAiKrpZd4j0tmgG5ERic/6GfBUa
 jw4=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="150600861"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:31 +0800
IronPort-SDR: ppkwMoB0lTdaZh7iCJbD7aN+GBux50uR7dXKc7GLZBdQSPWd2+4e/VNBd40SS+UYnJyhXg7Ed8
 9Nm5wzfDHVsA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:14:59 -0700
IronPort-SDR: vdLm8t6zcGaBj2pxWfreKk83SJTfMqiw5pGzWculjTNT4IiFLV76uoXzBofEM0XP4ZLtKI6615
 y40K45k+i6uQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:31 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 04/12] nvmet: use consistent type for op_flag
Date: Mon, 31 Aug 2020 15:26:59 -0700
Message-Id: <20200831222707.35611-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182731_658268_1198BB5A 
X-CRM114-Status: GOOD (  14.58  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In function nvmet_passthru_map_sg() we set the bio->bi_opf ored with
req_op and op_flags set based on the NVMe cmd. The variable bio->bi_opf
is declared as unsigned int use same type for op_flag.

Also, adjust the order according to new length.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed By: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 15dd63e14227..682291fb6d7b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -180,9 +180,9 @@ static void nvmet_passthru_req_done(struct request *rq,
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
+	unsigned int op_flags = 0;
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
-	int op_flags = 0;
 	struct bio *bio;
 	int i, ret;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
