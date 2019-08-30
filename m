Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B66C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AF923429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkKWrLqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AF923429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7+0YPZ8rwCINE4E8XBfY6dQmcddYzYBtWnczqAO50LM=; b=kkKWrLqfGnfjvzUhL6ha70u8nQ
	X1od1xtSuK58DqCvmC3AoBIVbmbPQ+Cw6749IV2ZmZ+bEvZfG39nzE9clpIyOSUI0WaO2C7vLJR3K
	02DUad00TYIzfra4V7oW+AgkaiivsrPC34tUwPuNGULZSppaI1Nm3WIu+GbcrD4/pIz6hjPFaRKwS
	aVFk0skPY8tmy6T5dapKYzHnmrj5vgNJH1O1H4dtOY4pTVOO2sCA6eeG7fmyq3Z/XbYSlpkXNj0xf
	2t0O4zZ57Qh+C5v11V+iUg3vYtGkO9iTThj3w+BQBhK1Ne5I2jVXNE9hlx0vXpb75LPNYmNli2ehy
	uE4s4yxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mQo-0003KX-Nm; Fri, 30 Aug 2019 19:19:34 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mQV-00030j-A4; Fri, 30 Aug 2019 19:19:15 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v10 2/7] nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR
 send failed
Date: Fri, 30 Aug 2019 12:19:09 -0700
Message-Id: <20190830191914.29713-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830191914.29713-1-sagi@grimberg.me>
References: <20190830191914.29713-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a more appropriate error status for a transport error
detected by us (the host).

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2d8ba31cb691..0a0263a364f2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -842,7 +842,7 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 {
-	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_DATA_XFER_ERROR);
+	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
 }
 
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
