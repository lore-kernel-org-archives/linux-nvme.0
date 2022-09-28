Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0566C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=itjaVD9mdDZSYv9Yu7/OjmrmXvLT6huRYu03GvcMgRs=; b=O13IfXGviYWPieHVTQ8Zd59PxM
	+uEm1zHrgzYsTEyYtRaL44QazLR1BQbm4fSJROnc3I5eKFIFOPYU+/oJNitjwJ872axyGcDnrkeqB
	VBAq36gG4ec2vcuic9oWLJPQDPdYT7k5yv3g+GyUja1gJ4r7LafXRnxQLjlIDlYH1NhrZ3/+hLJSK
	9tNAL6Dz6CEYIfaEa46lI6aqjIbFJHK2NJro8edE1sO27qMCPsHXr6BfMbujFt0/eGm+CVAJuz70s
	UBq5t2H3/4zZEZ1y4jbUdDoNZ0LZexSR3Q7Hop+N+fa/auUW2RVWKOHOPPwI0R8fId+bU9zHKWd5H
	D8KaEVcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXZw-00GbTY-L5; Wed, 28 Sep 2022 13:58:24 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXZt-00GbSC-D6
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:58:22 +0000
Received: by mail-wr1-f50.google.com with SMTP id n10so19893048wrw.12
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=itjaVD9mdDZSYv9Yu7/OjmrmXvLT6huRYu03GvcMgRs=;
        b=YjmPeTJtRmfu2nAT5mQ1o1YFYX17FQ4gISlxSVh1Zi1ipmwqfXeNcnRWbc6zpo7vpK
         LtWNUNmcGmjZB4P3F5eDv3ajiJgInXiR3myWvkqHH9t4tvADzpgprGmKuzob2OI2oWYE
         0KL+nkxq18xjZIRWzU88MmXUC02+0HKGsKtWKrZ6uLkXTBEahG2AF9+dzrowX+AiKV1j
         YPHjIMwj7zaTG/Po6ZDHy9BuBM5PlFQ0nd3enLmh8Yq5cq7d5vMJAyQWnV9Oxg6jH1qe
         iaV2cbyTRBYfkTUF9XVp4Cr1fxZ651qgA60cS7JC1GdQfjnT7dSZaMNFGUY7q+V6KqXP
         +4nQ==
X-Gm-Message-State: ACrzQf1RaKsoaOHEjJ2vryRO7p3DtEehHdlwMxxapMNDD/BJQkgSpTHs
	KHgvNmH2fMzh46xltP5z951eDpeh0j4=
X-Google-Smtp-Source: AMsMyM4UR1NNjo+XVaKW4VmWWmwj2NU3wgzagDrAowg5DG9NZbqd9m7OY8W7BjITH7auMF2WGmqrxQ==
X-Received: by 2002:adf:e4c5:0:b0:22c:c92b:27ef with SMTP id v5-20020adfe4c5000000b0022cc92b27efmr2095474wrm.246.1664373498407;
        Wed, 28 Sep 2022 06:58:18 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c19c6000000b003b5054c6f87sm1813060wmz.21.2022.09.28.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:58:17 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: [PATCH] nvme-multipath: fix possible hang in live ns resize with ANA access
Date: Wed, 28 Sep 2022 16:58:16 +0300
Message-Id: <20220928135816.132213-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_065821_461995_659E4E9B 
X-CRM114-Status: GOOD (  17.51  )
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

When we revalidate paths as part of ns size change (as of commit e7d65803e2bb),
it is possible that during the path revalidation, the only paths that is IO
capable (i.e. optimized/non-optimized) are the ones that ns resize was not yet
informed to the host, which will cause inflight requests to be requeued (as we
have available paths but none are IO capable). These requests on the requeue
list are waiting for someone to resubmit them at some point.

The IO capable paths will eventually notify the ns resize change to the
host, but there is nothing that will kick the requeue list to resubmit the
queued requests.

Fix this by always kicking the requeue list, and if no IO capable path exists,
these requests will be queued again.

A typical log that indicates that IOs are requeued:
--
nvme nvme1: creating 4 I/O queues.
nvme nvme1: new ctrl: "testnqn1"
nvme nvme2: creating 4 I/O queues.
nvme nvme2: mapped 4/0/0 default/read/poll queues.
nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
nvme nvme1: rescanning namespaces.
nvme1n1: detected capacity change from 2097152 to 4194304
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
nvme nvme2: rescanning namespaces.
--

Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
I was easily capable to reproduce this regression with a small debug patch to nvmet
to have a 1 second delay between controller AENs:
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
 #include "trace.h"
 
 #include "nvmet.h"
+#include <linux/delay.h>
 
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
@@ -248,6 +249,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
                nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
                                NVME_AER_NOTICE_NS_CHANGED,
                                NVME_LOG_CHANGED_NS);
+               msleep(1000);
        }
 }

And expose a subsystem via two ports, one ANA 'optimized', and one ANA 'inaccessible'.

Then test file-backed ns resize duing I/O:
truncate --size=2G /tmp/f && echo 1 > /sys/kernel/config/nvmet/subsystems/testnqn1/namespaces/1/revalidate_size

 drivers/nvme/host/multipath.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6ef497c75a16..d532a78f24a2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -172,16 +172,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
+	struct nvme_ns *n;
 	sector_t capacity = get_capacity(head->disk);
 	int node;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (capacity != get_capacity(ns->disk))
-			clear_bit(NVME_NS_READY, &ns->flags);
+	list_for_each_entry_rcu(n, &head->list, siblings) {
+		if (capacity != get_capacity(n->disk))
+			clear_bit(NVME_NS_READY, &n->flags);
 	}
 
 	for_each_node(node)
 		rcu_assign_pointer(head->current_path[node], NULL);
+	nvme_kick_requeue_lists(ns->ctrl);
 }
 
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
-- 
2.34.1


