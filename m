Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BDC71156
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0BA207FF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlEjBdyd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MW2QUGf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0BA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CSYgwzITO1Z223Tcb29tyPSFl49MxOEXHKBab1nOaDc=; b=UlEjBdyddwDufkLvu0Bl2J9Mt
	ij0bbfp+2GXdwl6h7ZAI4bUfAF0r0tH2XRj9zjFJs8CUsqUVceIPvLBuHOFEUK/waRw5dUK2yvkDr
	4E4pi1uzkrlVg8kFyrN7pn34WcoJhJ73zSOtbM7LXhER/3kOVHv0NqvusFiiykLSYC0PH9zQa5dGk
	T3m0nnHzVDiqfvP1A2Sf/sWHbwJm8Sje2ajMfCMUmFqA8p41SwbULMXVTonG90N1WTYwvLHBEvj6r
	12qogIqeS2K1b7xzI27VmTN25U3TbeGpf3GXg0pMNcbRVS6Yi0vvY+tzrlpXrlPmxZKQ1f+puZpRM
	+5L/7Eilg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx4e-00007K-9R; Tue, 01 Dec 2020 04:15:32 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx4a-00005c-43
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796128; x=1638332128;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
 b=MW2QUGf97hlHpK9KDTVab7B5HFv92/0Vc5pMvD2NpDqBcC0FQxise2EZ
 gJgdBL9A20HToNBkUNCrvUvSzWQgDzGbHXEkQDQKj1qWtEynUoVxKmExB
 PQ2cs51+mep/WauxQxvww8HA219CcpE5+WYHnOSUzDUl2cSofsLmRlF47
 VnnfFSzcCkefs3nmOZoXsXJ1bFf9s7jG8tUJmNNUS/5eouwsFB4HjNebJ
 amISk2LfZM49fQ8GhOQNbXvyIA00Iglqv7amqpjGVGnm1QFmGG1zifz7o
 RCFxrZ6mSFLYSc816sCaWvLZc4xRRr7pW4V8kHN1ye1epAR3HucVzQp16 w==;
IronPort-SDR: zfPbYtuhwqzOSYayxFrOAAyZpYzoe5nUsZFuMxG4tNKQXLHa2NnmSnCL6O+a5/yHXHGqpje/ye
 3jk44qEDDemLoNqvDX+hkWL/enscmx1CgrJPponmywxUr+FLGKzlq5bXge6elJQYKCdP1aKZA/
 Porr6RYGkME6cz5WgfLdqyhkZpuC+azJuXHrt56f6uZklWTaghUgWtB+gqlt8e6RNXol0TRmHI
 POjRXbi51ewn1gMwDIFSi0tW7yZ8JCgMPlsszXWtfULl53eyAfbgwjYZ1QO8+xIi02a/bOvHLN
 rQs=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="264005923"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:27 +0800
IronPort-SDR: RPQ1/C2zMhlRrkNdirAMe2JEMfY7VM6XORcyOw37HGLNtOZQOuC8JMOvTYsFOYWfy5RKlxj0mF
 TLfWcYOUaRy3znnK2WW/A9uGE8D3C79rQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 20:01:03 -0800
IronPort-SDR: oOK355WftzbW+cpLDbRUEOgaJ9Q54PUztkfR5GVdew0njI760zH51zNV2nucOhyUy42YzZnvQf
 NVwIxHV2/ttw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:27 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 8/9] nvmet: add zns bdev config support
Date: Mon, 30 Nov 2020 20:14:15 -0800
Message-Id: <20201201041416.16293-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231528_317357_BCA15D28 
X-CRM114-Status: GOOD (  12.56  )
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

For zbd based bdev backend we need to override the ns->blksize_shift
with the physical block size instead of using the logical block size
so that SMR drives will not result in an error.

Update the nvmet_bdev_ns_enable() to reflect that.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..e1f6d59dd341 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_enable(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
