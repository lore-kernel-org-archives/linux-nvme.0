Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2F606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BJBsTlu2;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i0Pksm//
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=avgDFygq+bTMrVWGxNUoa9i5YYtwHH0XmPzpyN61+A8=; b=BJBsTlu2uE8jsd
	WRdyV6f7rkjgCnc+7dl+85KDdsUD591wdNtwcG3NVDyV4nUneyRMYxsBOGksCNhGWiYU8tqVvz0uy
	X2yuafLFau8B9bdEMJOgEpZQSOWYb0UKKr2im0SerRIrKa9hWhDQHhdjmemR5L/QK4COgXw0uxEsB
	azBPVupFT2MFqMEO7iXYH1CYfh7Gb9Zo2qvm/RG5hc3d53BtGxUa55bs39CUuPMaRA8ghksDxiYcL
	jd5uABaPKoKc8yeIn73O0jJzIFhrMLHdBc+5bL+U3WsLmhQ5Wb1e/7HlwAvEv3Z6688ySg6Jqw188
	8/Pru13ufAyF7zH2IpCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF7-0000000FqoR-0jbQ;
	Fri, 23 Oct 2026 08:03:13 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAEz-0000000FqiY-273N
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742583; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=avgDFygq+bTMrVWGxNUoa9i5YYtwHH0XmPzpyN61+A8=;
	b=i0Pksm//HdI192hDaPMk0bD1REwcJV7lkt+CbVkSGwoIFlQPdxvhVMTkW2BMT2KHbMjErJIvvVguoW58U2CYrMCPgsoSqIswM9Nls7JUjgQ/uIAQX90dKTUrfECjzxX73MgUA82yL2Z2+kDONClzifZOrxA2SYUwns2wPlUWj7Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLZI0R_1792742582;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLZI0R_1792742582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 03/11] nvme: export nvme_bdev_ops
Date: Fri, 23 Oct 2026 16:02:43 +0800
Message-ID: <20261023080251.2606443-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010305_717424_7FB68C59 
X-CRM114-Status: UNSURE (   8.24  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export the NVMe block device operations so that other subsystems can
recognize a block device as an NVMe namespace through its operations
pointer and reach the NVMe structures behind it.  The NVMe target FDP
bridge uses this to detect an NVMe backing device of a namespace.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7eb0f9fe6b18d..0099ce5730b20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2719,6 +2719,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
+EXPORT_SYMBOL_GPL(nvme_bdev_ops);
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
-- 
2.43.7


