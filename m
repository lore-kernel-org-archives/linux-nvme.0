Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D039606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EDYmYtXn;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=q6mlqvkv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=rwyAiipvPUdq1t9DZx/8rtx5Yx8q1PZ2jWSAbu1tTY4=; b=EDYmYtXnn+3/j54kONu3ggSqJi
	6uKTeyGiBHASHr5zg0WnYTA+lC+qllvFmA1BPxpKhEjaLdXWr9CujA3zjmF6cwbkn0z/vTK81uGbp
	a4mUaTgzhtFL7G9Y+am7X52NB4TzD4cg+zlVgSR+pR+JZ0ODG8eQN1Fj055iFPNdwKJTATI+tKkR8
	nVd/4Z3AwQwV11PHr9EkUzQEekoVsi+jZZpfTgvyo84S6pZg/Sm26e33RoJzrXLUjHUeLDI9dM/s0
	eXABPyqY4p10VXKtgvddU8HdOkkdOSyOHIbsbqP06N0YLgIer/TGdzNdOFmiNByGTtUDckN7sSgS2
	b4JN+D3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLzRy-00000006bAd-2RKl;
	Wed, 28 Oct 2026 08:56:02 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLzRu-00000006b9z-4AZT
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 08:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793177757; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rwyAiipvPUdq1t9DZx/8rtx5Yx8q1PZ2jWSAbu1tTY4=;
	b=q6mlqvkvghxg1A6Avy+LmfnfNxt1kHkPqM9lsFdAs9c8sn3FC9ZyHpi5dltK2eG5GbueEnuhU4IcQ/kjczOW9zpS0tQ6igI3sPNmFpHZGr33yr6ED7tfMRS1dyNa/ArE7jRJlh17ZziGgdbRGIqMPnWoFtglVbP7569vYq6GOZ4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDgG0oE_1793177756;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDgG0oE_1793177756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 16:55:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: Free the old negotiation state when restarting authentication
Date: Wed, 28 Oct 2026 16:55:51 +0800
Message-ID: <20261028085551.918428-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_015559_717450_4453D186 
X-CRM114-Status: GOOD (  11.64  )
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

Restarting a DH-HMAC-CHAP negotiation with SEND(NEGOTIATE) resets
sq->dhchap_step but does not release the previous c1/c2/skey, which
are only freed in nvmet_auth_sq_free() at teardown.  The next
CHALLENGE/REPLY exchange then overwrites those pointers with fresh
allocations.

An unauthenticated host can repeat the negotiate message endlessly,
leaking a few dozen bytes per round and slowly exhausting target
memory.

Clear the old negotiation state with nvmet_auth_sq_free() before
setting up the new one.  Also reset dhchap_skey_len to zero: if a DH
session key was already established, a following round with dhvlen=0
would otherwise pass a NULL skey with a stale non-zero length to the
HMAC code and dereference it.

Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Changes since v1:
- Also reset dhchap_skey_len when clearing the old negotiation state,
  so a following round with dhvlen=0 cannot pass a NULL skey with a
  stale non-zero length to the HMAC code (Sashiko AI review)
 drivers/nvme/target/auth.c             | 1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 1680e5e6839c..574025730834 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -237,6 +237,7 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 	sq->dhchap_c2 = NULL;
 	kfree(sq->dhchap_skey);
 	sq->dhchap_skey = NULL;
+	sq->dhchap_skey_len = 0;
 }
 
 void nvmet_auth_sq_destroy(struct nvmet_sq *sq)
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bc49b48cdd63..3d9840d37a8b 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -330,6 +330,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			/* Restart negotiation */
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
+			nvmet_auth_sq_free(req->sq);
 			if (!req->sq->qid) {
 				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
 								 true);
-- 
2.43.7


