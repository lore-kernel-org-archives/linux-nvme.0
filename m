Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0003606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dPxLXYHm;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RTna/DCx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=a1IOTzrjdFc7BU0YcPKtvgXJU9gYIiwEGKdbbaqr9NA=; b=dPxLXYHmCiGaxejydjQVSGRmr/
	cU+HxVOIKuNot99Nnc1R58JPGXQk3EH5hoAZwOUyQA5J0pzAQp1q/nmEIDeBi0MST2annuuxU5yFS
	2HnYbxSETD4Qast8SmHbECzoaufLzdGpvYpcgc/6v5mQIDFlHuXfDotnPOkwNcTJq6a5tZc0ylwFB
	FkLXdrx1YwC0Ve2pq8091LhzCK5trpd1jZd7+rtiR/6m8suu1LczzDTjNI+G/VPWkNv8nrFFkg2bE
	TaOXfV+9Cy9dFEZcmG28c3iemaECh90EmohDmAsEBqC4Pu7wFOpo/5CQCfMNvFJe4AEcybik8FHwP
	ddGUyycw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxOZ-00000006QO1-1vwF;
	Wed, 28 Oct 2026 06:44:23 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxOX-00000006QN7-03OP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793169859; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a1IOTzrjdFc7BU0YcPKtvgXJU9gYIiwEGKdbbaqr9NA=;
	b=RTna/DCxJMHxsfRlDTHjJ2uSFzMoiHFlHVtweE42sAmzoRzfR19cd+2naMEsBh45z/euHIVB9Y/FelfNko6EnNLfZVb+slfXLq+VreHhgsy/nmt2XzsJAcCBT8qOJ9wOufSt2eVjCHv/FDfTJq9VqC2nApC/t3caf6OfY8GQ3qQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDfuPsJ_1793169857;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDfuPsJ_1793169857 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 14:44:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Check the admin queue before reading its TLS key in debugfs
Date: Wed, 28 Oct 2026 14:44:17 +0800
Message-ID: <20261028064417.548948-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_234421_191330_F6B7C833 
X-CRM114-Status: GOOD (  11.61  )
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

nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] unconditionally,
but the admin queue is not installed yet while the controller is
being created, and sqs[0] is set to NULL again when it is destroyed.
Reading the tls_key debugfs entry in either window crashes the kernel.

Only query the queue's TLS key when the admin queue is present and
report 0 otherwise.

Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..a27a501fe61a 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -136,8 +136,10 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
 static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
 {
 	struct nvmet_ctrl *ctrl = m->private;
-	key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
+	key_serial_t keyid = 0;
 
+	if (ctrl->sqs[0])
+		keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
 	seq_printf(m, "%08x\n", keyid);
 	return 0;
 }
-- 
2.43.7


