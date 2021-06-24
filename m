Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE9C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 06:36:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F91613C7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 06:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F91613C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sU6kJlThuz2BSEaNZp8qpvSxWVVkUW1bFNGvlCnFO4E=; b=NnK0pD4ambtkcp
	Y9jsI8wOM/b0T5sqtW4aQ/oAHr0TE8Pbf+Q8A/0+5JgRPEAWeRVbPK6DPb39RNsuZaaSsEKUjDHLt
	9UaRi3qV7/jLOjVFKtDn9WVRFmJN7Na/oSnRT+oh1ClufODCb/QQTx1iTqQLaJmGw5wuDMTgncHhq
	GMNoXYGBJ5jof1V5euVfedPVGrLtbmujd5Dm8sUJcPlhe09iV3QRrCg868SpCoBi+4K11AkVOj3pp
	HY06xN6WRT4OnsiGXKOUysW67yUq4lyiWJ+Vp1polCehY8hZmaxZWsBMI/zHhMQ/vf9atz6i7ICpA
	5GUkg432KNPFl4Q8IYaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwIxx-00D05c-BY; Thu, 24 Jun 2021 06:35:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwIxu-00D04z-2g
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 06:35:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6D49D68AFE; Thu, 24 Jun 2021 08:35:51 +0200 (CEST)
Date: Thu, 24 Jun 2021 08:35:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, martin.belanger@dell.com,
 aelior@marvell.com, okulkarni@marvell.com, smalin@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead
 dev_get_by_name for OPT_HOST_IFACE
Message-ID: <20210624063551.GB26612@lst.de>
References: <20210618133956.10637-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618133956.10637-1-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_233554_321934_73265503 
X-CRM114-Status: GOOD (  17.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've applied the slightly updated version below to make it a little
more clear what is going on:

---
From 9de7d173c10b6be09fe9d5b7010ef182465897a1 Mon Sep 17 00:00:00 2001
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
Date: Fri, 18 Jun 2021 16:39:56 +0300
Subject: nvme-tcp: use __dev_get_by_name instead dev_get_by_name for
 OPT_HOST_IFACE

dev_get_by_name() finds network device by name but it also increases the
reference count.

If a nvme-tcp queue is present and the network device driver is removed
before nvme_tcp, we will face the following continuous log:

  "kernel:unregister_netdevice: waiting for <eth> to become free. Usage count = 2"

And rmmod further halts. Similar case arises during reboot/shutdown
with nvme-tcp queue present and both never completes.

To fix this, use __dev_get_by_name() which finds network device by
name without increasing any reference counter.

Fixes: 3ede8f72a9a2 ("nvme-tcp: allow selecting the network interface for connections")
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
[hch: remove the ->ndev member entirely]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c7bd37103cf4..2b46c6e0226f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -123,7 +123,6 @@ struct nvme_tcp_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
-	struct net_device	*ndev;
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	err_work;
@@ -2533,8 +2532,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		ctrl->ndev = dev_get_by_name(&init_net, opts->host_iface);
-		if (!ctrl->ndev) {
+		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
