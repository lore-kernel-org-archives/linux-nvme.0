Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C6606A322
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fxtpjo20;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gXoDb9EZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SrtOqLPHEQesKMXWnC2VfE0FsZF53cDo8UzjqjuS/RE=; b=Fxtpjo20FO1r1S
	CF/c01KH4o00Xd8WnJluOZb2MEYGj9yxS40c5+DqCYn6IV8qBDPLLz8d1jLrKNNTRKCU651aaC1Cp
	AT32YPvgKEUDfmZtDyZxfLOnDP2cUJdSRjsEichDZLO+gzgWuBqmw+Ucc2ZdcRMIAgOq9eNdUz0LW
	qridaWqHSqWvA855xpK2Jh5BoPh8KdFDjtt5p5GpUllDWdAkIh8uQgjV4S3rnaYBPkHz7n+5V9rNU
	qaOSoR/j3hy5LffdPBdm2c/WQFihsYS+qjSMROXQx7KaxiXMDgvv7IYKb3SwpT6vBxaPqLbB6u3BG
	2gBk547C8/g3U/I4wnPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1b2-0000000G6f2-3cBs;
	Sun, 08 Nov 2026 12:02:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1ay-0000000G6eF-2iGj
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 12:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794139320; x=1825675320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=edMmME5am0w8M0ppsUjClJjEUbA7Gkdq3winU2NcTKE=;
  b=gXoDb9EZLaSSJrbdfxgBgGOfVrdBXGdWa0evh+WRrGLwXMHzaf87b/B4
   ICypFHVdPgDC0OOpi6J5GVY0vwOnvkEOnl6Yv4ImfBo/BknjsV6O8RvX/
   GmN8VPnE2Kc0bYFicAgwZJzPAp5vN4PbTpmZrZxlfmdqvq/76Cm1DdZ+R
   uTFkFo8gNBEd1pJIR2R8yQ0HZu3UPrfK71zseAV9BK6clCT3CGEeDYu3M
   OV+NVQjRdRiOk854baNPnBuqERzOPGbT60QpMfLDzolpzini6za8FKhF/
   MV7Q1MzoR9miVs4b/K9LUmGBbwxY3ETkCzysY3Jub2egeJI4crrdWE/+9
   g==;
X-CSE-ConnectionGUID: IqlleM0DTROMcupfv5SP0Q==
X-CSE-MsgGUID: c2haKc3gSI69TqJzgV8D6A==
X-IronPort-AV: E=Sophos;i="6.27,202,1786982400"; 
   d="scan'208";a="158625200"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 20:02:00 +0800
X-CSE-ConnectionGUID: ibt3oZiTR+asEmzEn5XsWw==
X-CSE-MsgGUID: o3K60T1SRwuP2BO1pB+9IQ==
IronPort-SDR: 6af064b8_A5z0w7ty+mclbhAl32NYTrcM8pRPQ8IyOQPTcIlgLr16qi5
 UxydrFFEdAZZFNkz1cLeQjBlH95XrvmgM8NhoOg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 04:02:00 -0800
X-CSE-ConnectionGUID: xkdL1M3HQaiFe5e0KrB2cA==
X-CSE-MsgGUID: VI+I45xdSyC7ABpjRQ766g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 08 Nov 2026 04:01:58 -0800
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
Subject: [PATCH RFC 2/2] nvmet-rdma: use a separate lockdep class for the listening cm_id
Date: Sun,  8 Nov 2026 21:01:54 +0900
Message-ID: <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_040200_718117_5091581F 
X-CRM114-Status: GOOD (  15.47  )
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
rdma_destroy_id() on the port's listening cm_id via nvmet_disable_port().
Lockdep then reports a possible circular locking dependency:

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(nvmet_config_sem);
                                   lock(&id_priv->handler_mutex);
                                   lock(nvmet_config_sem);
      lock(&id_priv->handler_mutex);

The warning is a false positive. The handler_mutex on CPU1 belongs to a
connected queue's cm_id, while the one on CPU0 belongs to the listening
cm_id, and nvmet-rdma does not take nvmet_config_sem while handling
events of the listening cm_id.

To silence the warning, call rdma_reclassify_id_for_listen() on the
listening cm_id right after it is created in nvmet_rdma_enable_port(),
so that its handler_mutex gets a lockdep class of its own.

This depends on the previous patch, which adds
rdma_reclassify_id_for_listen() to the RDMA CM.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Link: https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b9e39d1657d2..94f6d8edb517 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1914,6 +1914,8 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 		return PTR_ERR(cm_id);
 	}
 
+	rdma_reclassify_id_for_listen(cm_id);
+
 	/*
 	 * Allow both IPv4 and IPv6 sockets to bind a single port
 	 * at the same time.
-- 
2.56.0


