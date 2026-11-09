Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC92606A33A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KQ5Xix7G;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f4fW++mh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jSWKQrfCUAmL8sZEabRSPhfS3U6uXGmNDJ+WfFuaYqY=; b=KQ5Xix7GmnQOT+
	zXfmFcDjjfeLXTPGGLGm0Dl6yXbcIRNDpqadncOUPOHhbta8dvTUgaS0rbS6dYxHhY+MFI+nnSSOH
	WFZ+sOPdAkUK7xRJpdEhp982nng32uU+AglINp/bD+kSfZ068U5I6Z6SbvQ4nfihRJqp7FnKDyXzC
	PTBqP79QKWF3bV7Pmo4mD0UZ+OV6FMLJ12KP2d7Hr4gCQSMUDi1H83GRIhQVOLptpWtavhbbZBFb1
	ATJTE1/xdPJBWJ3nYKhFiM+rhEm7S0ZajX9PlnOqjPYZj65bgQaeobcE2uaQs3z6bnYiuHhC1S0Yz
	m75SN7eBi2uN4upAK1qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF6A-0000000H7hn-1gdS;
	Mon, 09 Nov 2026 02:27:06 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF64-0000000H7d6-2g03
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191217; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jSWKQrfCUAmL8sZEabRSPhfS3U6uXGmNDJ+WfFuaYqY=;
	b=f4fW++mhOYy/75/R15LQ3hAx1SqrTfC9Ddu2837D70WlUX5d5MyBmanyVpJYTgWn8l9ODwJQJuHFcC2t+EyEE5gEZ5HEEEMLejkqExAy/Kejfvo6xtU059sWDdBxehA+dTME8hdk5m23VD2/oivYw5V9BGhzFUZjcX2VhUWRU/c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEI5jqY_1794191215;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEI5jqY_1794191215 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 5/5] nvmet: use GFP_KERNEL for PR allocations
Date: Mon,  9 Nov 2026 10:26:46 +0800
Message-ID: <20261109022646.290792-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182700_832230_D21CD3F5 
X-CRM114-Status: GOOD (  12.47  )
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

nvmet_pr_update_reg_attr() and nvmet_pr_alloc_and_insert_pc_ref()
allocate with GFP_ATOMIC, but both run in sleepable context: the PR
command handlers execute from the transport workqueues and take the
pr_sem semaphore, and the pc_ref allocation is reached from the
connect and configfs paths. The latter function even passes
GFP_KERNEL to the percpu_ref_init() in the same scope, so the
GFP_ATOMIC only raises the failure rate for no reason.

Switch both allocations to GFP_KERNEL.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa..026653ce338f 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -335,7 +335,7 @@ static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
 		return NVME_SC_SUCCESS;
 	}
 
-	new = kmalloc_obj(*new, GFP_ATOMIC);
+	new = kmalloc_obj(*new, GFP_KERNEL);
 	if (!new)
 		return NVME_SC_INTERNAL;
 
@@ -1040,7 +1040,7 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	int ret;
 
-	pc_ref = kmalloc_obj(*pc_ref, GFP_ATOMIC);
+	pc_ref = kmalloc_obj(*pc_ref, GFP_KERNEL);
 	if (!pc_ref)
 		return  -ENOMEM;
 
-- 
2.43.7


