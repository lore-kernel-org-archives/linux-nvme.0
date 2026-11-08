Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48C606A320
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HFbR+2Aw;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=JIr48rfX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+Kv8RMGc4Kqj8bJLYodcw8xgNTV/EvlvmXAn+hqBBNQ=; b=HFbR+2AwfLvZxY
	t70iv0Yr1FYq+AmIIEM723lulMCIANrR4mmNhoXbjAN6z802h3f5WDZqi9jPEKLQWW8JHprorhKX7
	n4bCWmHkddMf9NbfQos3QHWTau7YLxUh3S8/yXO9UYIBpjh81nh9v65N3nb70qvzoMlf0wzOz4Ocu
	/6boCeeB2WKJbbN5/IXAfF+mYPLYOXvTR0PMfoSpYFDKSVY8oS2Ig0TIalLelq1WdpyUaIWfaAyI1
	ud/7FpCzGuZBVP2InPZGijIVV2LH0HdD2K/KPWCUkWH2OTFzaBV0dAa0+RTs9mDmSIE86kv3sV4D5
	92or6KA0TIA+yp9CDymw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1b2-0000000G6ev-1fLs;
	Sun, 08 Nov 2026 12:02:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1aw-0000000G6dk-3B0A
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 12:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794139318; x=1825675318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NiMau9ASQ4YTV/4lh6tafHs4DXijpsctEYFctn0SFw=;
  b=JIr48rfX7Jz9onkHmP13GTvX+wLfBRPfscwlULs8hD4zTPA2vyiG89mH
   bCY3y5P5Xm5dsXtnH1xAgPnpjZTFVfDydCahvomABJe3mo5h59HVWf0uz
   qHU3GX8yYAbWUfFwAq3eqxHO2eCuR2oC5MTp/id0Wz1iIIWIo5/N7aNkP
   PgwQlRKLO2Lz0pYG4rJgJ8IuNbb3MZMavKelB7Enjz73u2MyP52gM4OL8
   p0bsoy3kZsjfWyewb1dL/BvQ45JNhyd1/jjlFNWFMWIl1W8OHTQXkIXel
   s7+3AG1KIbZimyHnmqIn3o+PiyWi8NzNE+jLOO3WKFI+pE2CknKOPDVkR
   g==;
X-CSE-ConnectionGUID: NRRsi6buQcuCgscNCVRR1g==
X-CSE-MsgGUID: 3QmiRRDeQkK0hg6XceFOpg==
X-IronPort-AV: E=Sophos;i="6.27,202,1786982400"; 
   d="scan'208";a="158625199"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 20:01:58 +0800
X-CSE-ConnectionGUID: vXLTlGB0RVOBxqOksOUUSQ==
X-CSE-MsgGUID: VBnQNndbRCmJaslvzzyuiA==
IronPort-SDR: 6af064b6_VIDsLRz6kStJ/baDo86pYym+6uOvmFEZCIMSWZUVrt1qhdy
 S8GGRTrdHXLWteGxRdLmAb3npNKABFKsh+8fHkw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 04:01:58 -0800
X-CSE-ConnectionGUID: cmbr24pJTeiZUC8YzvYf3w==
X-CSE-MsgGUID: g36sCvGNTWeqlFIY6JJVNg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 08 Nov 2026 04:01:57 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC 1/2] RDMA/cma: Add rdma_reclassify_id_for_listen()
Date: Sun,  8 Nov 2026 21:01:53 +0900
Message-ID: <20261108120154.148824-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_040158_853629_AF8EF4D8 
X-CRM114-Status: GOOD (  15.64  )
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

Since the commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
allocation and startup"), the host sends commands on an I/O queue before
the target has seen RDMA_CM_EVENT_ESTABLISHED for that queue. nvmet-rdma
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
listening cm_id, so this is not a real deadlock. Lockdep handles the two
in the same manner because all handler_mutex instances share a single
lock class.

Add rdma_reclassify_id_for_listen(), which assigns a separate lockdep
class to the handler_mutex of a listening cm_id. rdma users can call it
right after creating the cm_id they listen on. A follow-up patch makes
nvmet-rdma call it.

Link: https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/infiniband/core/cma.c | 13 +++++++++++++
 include/rdma/rdma_cm.h        |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 337a49d1acf7..436e2467a36f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1064,6 +1064,19 @@ __rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
 }
 EXPORT_SYMBOL(__rdma_create_kernel_id);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key cma_listen_handler_mutex_key;
+void rdma_reclassify_id_for_listen(struct rdma_cm_id *id)
+{
+	struct rdma_id_private *id_priv;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	lockdep_set_class(&id_priv->handler_mutex,
+			  &cma_listen_handler_mutex_key);
+}
+EXPORT_SYMBOL(rdma_reclassify_id_for_listen);
+#endif
+
 struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
 				       void *context,
 				       enum rdma_ucm_port_space ps,
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index d639ff889e64..59dda4b0173e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -158,6 +158,12 @@ struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
 	__rdma_create_kernel_id(net, event_handler, context, ps, qp_type,      \
 				KBUILD_MODNAME)
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void rdma_reclassify_id_for_listen(struct rdma_cm_id *id);
+#else
+static inline void rdma_reclassify_id_for_listen(struct rdma_cm_id *id) {}
+#endif
+
 /**
   * rdma_destroy_id - Destroys an RDMA identifier.
   *
-- 
2.56.0


