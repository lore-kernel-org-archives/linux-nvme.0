Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE44C43603
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E45B24673
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exhCmyGU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="im++QGAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E45B24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XDoe6f28XtxAm9PF77VJecntII5TFcVaAXcS13V7D94=; b=exhCmyGUx6qz3Q
	wmsH3rur5sUzsdfGpJ6PPJmek7sM3qRlkuhZ+jQs1Z2Rgcy+VyRHHmuJhk2re/QuuY7gNVKkGoWGV
	41vRBwW08dngIo8BlpyVmSdMhJ6A55QTmbVe16cRKYlv8NXulhXzB/DB3Af+Cc3/7vE+A7WDRAN9h
	KvP87agdH31yiC+N+ZEeKZwM34nTAdW0XqD7fx8NRPkKkar7DEkdNDfLqiXYQrbLSQ3cIoPYgx70+
	+iaYLMgk5DWXrvS17lWh/cNpC5NtqQs0Acp/eOlKzXLSg1Xr7RELUZRIYtjTohvIP88rqOzBZCpwn
	YqqaaWKTFcs+ulHBakNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idHAl-0000Gq-5d; Fri, 06 Dec 2019 17:13:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idHAW-0008So-AM
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 17:13:29 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44D542466E;
 Fri,  6 Dec 2019 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575652408;
 bh=2fM7Enkefh4JvOstfiZCpxzKEfXuTv7Rqzbp8hXHTLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=im++QGAUj3CDqO2Ti2FtyfDtDdre4Ye0VyhWBJ5RePvSpvNcuidYqufoczEsPG73h
 3F/+YEnjjFZPKH8JoG5Q1ZUno7HK8LboJkp6W9qpsyVrbbM82HRx0ZPxJS6nvQj/6K
 nlalpL6Og7DOLZl8NNiIK+wF1jKWFdEiHus4L5ig=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 2/3] nvme/pci Limit write queue sizes to possible cpus
Date: Sat,  7 Dec 2019 02:13:15 +0900
Message-Id: <20191206171316.2421-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206171316.2421-1-kbusch@kernel.org>
References: <20191206171316.2421-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191206_091328_375285_E976151E 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The driver can never use more queues of any type than the number of
possible CPUs. A larger parameter value causes the driver to allocate
more memory for IO queues than it could ever use. Limit the parameter
at module load time to the number of possible cpus.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7186f21ad899..6b6452486155 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3146,6 +3146,9 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
+
+	write_queues = min(write_queues, num_possible_cpus());
+	poll_queues = min(poll_queues, num_possible_cpus());
 	return pci_register_driver(&nvme_driver);
 }
 
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
