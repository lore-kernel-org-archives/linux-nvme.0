Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FC606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ebm+gT1Z;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fyRNq49r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R38wR8CDz3j/Q9CrYxyDDPo0PiiNIwi0sXO1kaYVmCI=; b=ebm+gT1ZR0QQho
	9f2hImCYM0oqJ40eTVXHcrzyUQGB0KJCb6CmWMiosvCOUv0sW2MJhZfdQsHOJ55AFDyr4pweHU4OH
	JGD1lgAhTg9dmAPuCqZkNujkKPSC0yPTgDBMzI39hpvFZhaZoI2s6lsVOeAmBEMV9KjjKtYbhWB1S
	vZreDFqY+4sKZiyBk0pdfDizZFmwfisinsejEuy9MiQi43RL1M7T3xgot+oGI0bXAcBSXwStTGMAN
	5bjg+AoFknf4ha/ipXJot7kSO4IT1Z+2qqWMxn21jpx3r+TOBmRSiz5wokX8yJGOOM9zsnbA9VvRn
	LxKBQG+PqI/YpKmUooNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gJ-0000000B46o-3jXS;
	Fri, 06 Nov 2026 02:27:55 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gG-0000000B3xO-1iAf
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932070; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R38wR8CDz3j/Q9CrYxyDDPo0PiiNIwi0sXO1kaYVmCI=;
	b=fyRNq49rJUiODNcvQXJSlpB61kY/x+cyZH4ssC0BOUW01EepZOAD49qXigjDcqxfNmIV/dWALA70+T7JgQ/alZbG0LX18Szb3+q3YUnCDwyQkH0qOP7i9p6aEtphib7d4jY68X2SLb7l0+zAwGonXj5zxUOaKTXrJGJQjINWYAY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2Nv8_1793932069;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2Nv8_1793932069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:49 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 9/9] nvmet-pci-epf: don't drain the never-populated SQ list
Date: Fri,  6 Nov 2026 10:27:36 +0800
Message-ID: <20261106022736.3582824-10-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182752_625783_9964D4EA 
X-CRM114-Status: UNSURE (   9.79  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_pci_epf_delete_sq() calls nvmet_pci_epf_drain_queue() on the
submission queue, but IOD links are only ever added to the completion
queue list, so the SQ list is always empty and the call is a no-op.
Remove it.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pci-epf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a8df176c1a57..e5781e538a4a 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1432,8 +1432,6 @@ static u16 nvmet_pci_epf_delete_sq(struct nvmet_ctrl *tctrl, u16 sqid)
 	destroy_workqueue(sq->iod_wq);
 	sq->iod_wq = NULL;
 
-	nvmet_pci_epf_drain_queue(sq);
-
 	if (sq->nvme_sq.ctrl)
 		nvmet_sq_destroy(&sq->nvme_sq);
 
-- 
2.43.7


