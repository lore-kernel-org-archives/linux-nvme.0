Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D39C4167D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X42Kg9IFwc819P9OtEJDfZzP00rm5gAtaEzPDtzXLHg=; b=YQXsd3eoRpZeWzT+WYtmugNvxt
	FPJIH+v4EFm5Ohf+OaXQvxk0jQu1m6u+iaWNROxSJRKylV1kMXpT1TaZ7tE8szOadnc5W5x//44z3
	dsJhejN9A/2bl/goZR0X+gIYtIGz187mKDNAT06JxE6JFD/D+s8pBVOABeAqo432YLGQeVJXebcLL
	LQtz0ZQ5poNTC3MogR+BUGNKZUQK631FHaYIjomS7N5ghY868khuVErha0+vaeoNe0NcUbTJTQMWa
	ep4Rvs0XBEZbXDbTTDLA5OARTa+n+YVvgpAk60nNEg9X8/PbXjJTsEez7UDYu42TC5D3rx1KO5o+6
	g+3MhP0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8We-007C9h-0J;
	Wed, 01 Nov 2023 10:32:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8WX-007C7c-0R
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 10:32:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C544C2185A;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698834749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X42Kg9IFwc819P9OtEJDfZzP00rm5gAtaEzPDtzXLHg=;
	b=yyDQZFZrfXkFmYJwfCsz16qxMsHNv+KV3Y7BnPEDFOE78ZhpyjPnnyTGef1Rnt58xWwoBO
	Opa7hFAbS1XRUc1wTooSlVbAvzQUCYEntTrEPduFnozisNGEfTzsp4F8thCT+H0PxN6nZI
	FXOjfQTz6t8K4fhOa//TY16ZXHJOJF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698834749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X42Kg9IFwc819P9OtEJDfZzP00rm5gAtaEzPDtzXLHg=;
	b=MzLDhOu35HUH521kn1PumjkAQw0wdMNrQIRQ2QVaLPF+fT0zNYXWlh6uZQ4DN/ETPW6B4j
	/AdZqfquNefWKmAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 803602D03B;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B513C51ECA09; Wed,  1 Nov 2023 11:32:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on install_queue()
Date: Wed,  1 Nov 2023 11:32:27 +0100
Message-Id: <20231101103228.136570-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101103228.136570-1-hare@suse.de>
References: <20231101103228.136570-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_033233_317535_721E320C 
X-CRM114-Status: GOOD (  13.62  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_rdma_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that check for pending queue in disconnecting status,
and return 'controller busy' until all disconnects are completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/rdma.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..eaeb94a9e863 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1583,8 +1583,18 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	}
 
 	if (queue->host_qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
+		struct nvmet_rdma_queue *q;
+		int pending = 0;
+
+		mutex_lock(&nvmet_rdma_queue_mutex);
+		list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
+			if (q->state == NVMET_RDMA_Q_DISCONNECTING)
+				pending++;
+		}
+		mutex_unlock(&nvmet_rdma_queue_mutex);
+		/* Retry for pending controller teardown */
+		if (pending)
+			return NVME_SC_CONNECT_CTRL_BUSY;
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
-- 
2.35.3


