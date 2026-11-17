Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA3606A323
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zNfdcSvI;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=AmRHx9UY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=lAbvIquq6eN3EU/HV67PNZGDW00wmyx7R71DbgJixRo=; b=zNfdcSvIeFeJGhcsrUUmz88/Xv
	FIxR+OjMV+vf889TcKU0s9/DHwxs55F4nuXWxsIh+lDHhefDoCIPh1rFaRbGr9ya4c8yMwDrjBQsK
	o9HA0zj4twurit+2kpaBJK6wWq0X4dYgBPjzbqn4Sljmse7Yx7HLD63I8nOJwZywgjHKTvzcfK+It
	xjOsYtG4OSdd+mZWABBHafVaSRBv0VzQBbNSihLa/lCqEK7RZ1yueUxlUWow+oMJBnIDvTO99Se08
	FjxmbK31s3OUUs6j+tKKn9T268l5K2mJ5APbrYIEI6VwQAJmv9LFRNW5nmrkYvNwuCptMZWOGqtgn
	TRMuKDKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTHPT-00000005S2x-1fqX;
	Tue, 17 Nov 2026 11:31:35 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTHPQ-00000005S1h-2g2o
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 11:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794915092; x=1826451092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2axHprejUkEX2g/CWgFDV7gmso5xZUAiGQ78yKq+d4k=;
  b=AmRHx9UYf9xLIkCXXpcKgcIt6kvIzYEcLBIHajvYMdMqWMggM+ueZHNj
   sRXqFxg4BP5KabRrDul78uEHc70N4qNef74uEY+05XIfSeeQIQzMX/8TU
   tggMkRNpXV7tCBrfQzeriBI3CARTxS7p+YWC7GtydsGwIVTcxs9zWrrmc
   r73xZD1Tr75wPX8+MjEq9RBMWvS5THr/0PtqfxORwXJn7iuN+3zLtSugA
   0FIcT5L/slVjk+3auZi7P5LsslgAKW/QnKSZ/nMzrqnej/wMrEd022mfd
   7fOINVy5BXlmqKUf4JyrpMDZ5ip7HjyxGYCcrHuUH28rAOCjikV2s4Jzy
   g==;
X-CSE-ConnectionGUID: GzMD3TusTrKKBnrNiKXY2w==
X-CSE-MsgGUID: hr4Ddt+pQRqcC2ianG4BCQ==
X-IronPort-AV: E=Sophos;i="6.27,218,1786982400"; 
   d="scan'208";a="159475137"
Received: from h199-255-45-15.hgst.com (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2026 19:31:31 +0800
X-CSE-ConnectionGUID: ZALjej8uR9+WMTB576uqHg==
X-CSE-MsgGUID: rKRrRsUvQlahCsP7vPRBQg==
IronPort-SDR: 6afc3b13_hgFTuJJIUUfFKdw+CnqsxBdyqRHfoXdPSvIJV0NFgrVUP4W
 Dx7Ox1vzequvKheZ3qovtjsGyNbWF4+EJGVZDuw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2026 03:31:31 -0800
X-CSE-ConnectionGUID: HJciZE7ZS8iLUQoo1ESQyw==
X-CSE-MsgGUID: lAPvm1lySd6fs36D2ne1ng==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 17 Nov 2026 03:31:30 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-rdma@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] RDMA/cma: Use a separate lockdep class for the listening cm_id
Date: Tue, 17 Nov 2026 20:31:29 +0900
Message-ID: <20261117113129.746490-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_033132_720886_98EF8C87 
X-CRM114-Status: GOOD (  15.50  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), the host can send commands on an I/O queue before the
target has seen RDMA_CM_EVENT_ESTABLISHED for that queue. nvmet-rdma
keeps such commands on queue->rsp_wait_list and executes them from
nvmet_rdma_cm_handler() when the ESTABLISHED event arrives, that is,
with the handler_mutex of the queue's cm_id held. Executing a connect
command takes nvmet_config_sem, which creates a handler_mutex ->
nvmet_config_sem dependency. This is the reverse of the order in
nvmet_port_subsys_drop_link(), which holds nvmet_config_sem and calls
rdma_destroy_id() on the port's listening cm_id via
nvmet_disable_port(). Lockdep reports the warning below when blktests
nvme/004 or nvme/031 is run repeatedly with the rdma transport and the
rxe driver:

    WARNING: possible circular locking dependency detected
    rm/7346 is trying to acquire lock:
     (&id_priv->handler_mutex){+.+.}-{4:4}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
    but task is already holding lock:
     (nvmet_config_sem){++++}-{4:4}, at: nvmet_port_subsys_drop_link+0x52/0x340 [nvmet]

    -> #1 (nvmet_config_sem){++++}-{4:4}:
           down_read+0xa6/0x530
           nvmet_find_get_subsys+0x1f4/0x630 [nvmet]
           nvmet_ctrl_find_get+0xaa/0x320 [nvmet]
           nvmet_execute_io_connect+0x1e0/0x480 [nvmet]
           nvmet_rdma_execute_command+0x18e/0x480 [nvmet_rdma]
           nvmet_rdma_handle_command+0x428/0xb30 [nvmet_rdma]
           nvmet_rdma_cm_handler+0x8a8/0x30f0 [nvmet_rdma]
           cma_cm_event_handler+0xb0/0x3c0 [rdma_cm]
           cma_ib_handler+0x28a/0x9b0 [rdma_cm]
           cm_process_work+0x4b/0x3e0 [ib_cm]
           cm_work_handler+0x2485/0xac10 [ib_cm]

    -> #0 (&id_priv->handler_mutex){+.+.}-{4:4}:
           rdma_destroy_id+0x17/0x20 [rdma_cm]
           nvmet_rdma_disable_port+0x44/0x300 [nvmet_rdma]
           nvmet_rdma_remove_port+0x42/0x60 [nvmet_rdma]
           nvmet_disable_port+0x120/0x1f0 [nvmet]
           nvmet_port_subsys_drop_link+0x261/0x340 [nvmet]
           configfs_unlink+0x36d/0x790
           vfs_unlink+0x278/0xb40
           filename_unlinkat+0x31d/0x670
           __x64_sys_unlinkat+0xae/0x100

    other info that might help us debug this:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(nvmet_config_sem);
                                   lock(&id_priv->handler_mutex);
                                   lock(nvmet_config_sem);
      lock(&id_priv->handler_mutex);

     *** DEADLOCK ***

However, the two handler_mutex instances belong to different cm_ids. The
one held during command execution belongs to a connected queue's cm_id,
while the one taken by rdma_destroy_id() belongs to the listening cm_id.
nvmet-rdma does not take nvmet_config_sem while handling events of the
listening cm_id, so this is not a real deadlock. Lockdep cannot
distinguish the two because all handler_mutex instances share a single
lock class.

To avoid the false-positive WARN, assign a separate lockdep class to the
handler_mutex of a listening cm_id at the start of rdma_listen().

Link: https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/
Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
* Changes from RFC v1
- Instead of the new helper function, do the reclassfication in rdma_listen()
- Link to RFC v1: https://lore.kernel.org/linux-rdma/20261108120154.148824-1-shinichiro.kawasaki@wdc.com/

 drivers/infiniband/core/cma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 337a49d1acf7..b3678ddc79a4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3949,6 +3949,13 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 		container_of(id, struct rdma_id_private, id);
 	int ret;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	static struct lock_class_key cma_listen_handler_mutex_key;
+
+	lockdep_set_class(&id_priv->handler_mutex,
+			  &cma_listen_handler_mutex_key);
+#endif
+
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_LISTEN)) {
 		struct sockaddr_in any_in = {
 			.sin_family = AF_INET,
-- 
2.56.0


