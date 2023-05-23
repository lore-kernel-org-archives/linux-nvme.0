Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B5C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G6+SidhthmUWW0pWZsLmfPzXnfIJfQ1i+Vck8waSr4c=; b=vdS+WfkFjrIaM1GgGYhY4j0WJ/
	oOyXxOI4WX6HB/yINU7F1j1xAR+JxwAad5LFKixxvzqenpNHUmS8YvAP+u/yHGA6jaaUeRa57WWYm
	rdBpTeJZ5Jf5OgypbsrqEc9O08aQxTZeYp4SzC3e8c762WkwpHNeb6wxXrb6kzRZwYnrvv4+qYOmX
	ipn7XT/c+M8+STaMc8MkwrV6fnmC6W/L2asqBbch0WvZ863NPK4kaBH1kJAX7kpR6Sis+L3UyotPV
	liNpPNmGS6/t5KI7V4Y/jPU6BmwIZ0tCauMmvd4JWVlYAdP1l88ytooGuI5Y+j9oUaT+K8iXWSoOc
	QdZt431A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1ULB-00AhfL-1D;
	Tue, 23 May 2023 15:54:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1UL7-00Ahdk-2g
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 15:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684857258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G6+SidhthmUWW0pWZsLmfPzXnfIJfQ1i+Vck8waSr4c=;
	b=QvfAUjITibqG2V4EEqrqmWCJI9GzHGm5jMjb9AimHlcICaASop4+B+ongbQyenko+iJB0x
	v11KBbBdm+0mjg+KA8i1vKOgvew3PFCCncXcqLu4/L7tcnYhCI9/zgaNSF+F0jONwEEcrK
	Pdb6hGNUgItlmJFN7U4WMfHU2uT5oCg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-3qNpfRQMMqyGilhX4A6y_g-1; Tue, 23 May 2023 11:54:13 -0400
X-MC-Unique: 3qNpfRQMMqyGilhX4A6y_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417A61C0A58B;
	Tue, 23 May 2023 15:54:11 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6B6492B00;
	Tue, 23 May 2023 15:54:09 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: jgg@ziepe.ca
Cc: leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	parav@mellanox.com
Subject: [PATCH] Revert "IB/core: Fix use workqueue without WQ_MEM_RECLAIM"
Date: Tue, 23 May 2023 17:54:08 +0200
Message-Id: <20230523155408.48594-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_085422_117954_BF997765 
X-CRM114-Status: GOOD (  13.69  )
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

when nvme_rdma_reconnect_ctrl_work() fails, it flushes
the ib_addr:process_one_req() work but the latter is enqueued
on addr_wq which has been marked as "!WQ_MEM_RECLAIM".

workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
[nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

Call Trace:
__flush_work.isra.0+0xbf/0x230
__cancel_work_timer+0x103/0x190
? rdma_resolve_ip+0x257/0x2f0 [ib_core]
? __dev_printk+0x2d/0x69
rdma_addr_cancel+0x8e/0xc0 [ib_core]
_destroy_id+0x1b/0x270 [rdma_cm]
nvme_rdma_alloc_queue.cold+0x4b/0x5c [nvme_rdma]
nvme_rdma_configure_admin_queue+0x1e/0x2f0 [nvme_rdma]
nvme_rdma_setup_ctrl+0x1e/0x220 [nvme_rdma]
nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]

This has been introduced by
commit 39baf10310e6 ("IB/core: Fix use workqueue without WQ_MEM_RECLAIM")

Since nvme_rdma_reconnect_work() needs to flush process_one_req(), we
have to restore the WQ_MEM_RECLAIM flag on the addr_wq workqueue.

This reverts commit 39baf10310e6669564a485b55267fae70a4e44ae.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0..5c36d01ebf0b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -872,7 +872,7 @@ static struct notifier_block nb = {
 
 int addr_init(void)
 {
-	addr_wq = alloc_ordered_workqueue("ib_addr", 0);
+	addr_wq = alloc_ordered_workqueue("ib_addr", WQ_MEM_RECLAIM);
 	if (!addr_wq)
 		return -ENOMEM;
 
-- 
2.39.1


