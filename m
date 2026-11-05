Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3360606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AcapDA8n;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yWTcE9F2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R38wR8CDz3j/Q9CrYxyDDPo0PiiNIwi0sXO1kaYVmCI=; b=AcapDA8nH1C38Z
	K3wJUqZGYb9kwCw1eGNbNujEIQ7ZWygZiJeeStu8rYrHlcfWVxQ++Gtd/wS2ZyXTpf0vxG3A464Iw
	fugN7nYIzF6tiQ+AyQLErQj0OskKo6kVaxDEsUmew9sHwWekmMsqXlj8+SWWr8FpF7UG6TDdu19S5
	z0lsYr+lNc9SSCR29S2KV5Kp1awiq1DSBwElNwuFPC8qn9o67GSXCGZfhpGrYbK0RN5vyarksoDMc
	jDacAHK0Rg9E38jlDU3LTyI2Krw1zr0CUExocUFyiXiZ7ExTWPa49lQM+tutARd9e+Lfm1XZFfUPU
	NrPFDenvVQiwFP6HvltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwe-00000007Xal-1qAQ;
	Thu, 05 Nov 2026 02:11:16 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwX-00000007XPi-3JyM
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844668; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R38wR8CDz3j/Q9CrYxyDDPo0PiiNIwi0sXO1kaYVmCI=;
	b=yWTcE9F2jTpLMNfqxiCdmFqBwV5hNAY8lxMqAf97pmAyeolQee1QKqzNwb6AgsuuP3v19+e4uA9jMNmB6/Wac39XkFTBt1Z80TnMYI63ZVAm715zEP7neQghZ8ytm7oZcQozfnDwpNefcUeibKCG2Bdf81/KEQG4d4HSQZTt+xg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE7BnO5_1793844666;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE7BnO5_1793844666 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:11:06 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 9/9] nvmet-pci-epf: don't drain the never-populated SQ list
Date: Thu,  5 Nov 2026 10:10:51 +0800
Message-ID: <20261105021051.1667222-10-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261105021051.1667222-1-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181110_026036_3A66F07E 
X-CRM114-Status: UNSURE (   9.52  )
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


