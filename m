Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F9606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M0hiejbh;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LRMAaj00
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=CdjUXPPMIEpAewE8Co7gN1O8xQFI2a3CrNWr/NRY6HM=; b=M0hiejbh5DOgDWWkxtDENgK63/
	hfjD/N8SHLZXzcI8TpL3jRiVa9HosexlfL8iRQtrPVJXBMgGcLMw6kx4AANmAtTCdFW7hC/reJT53
	qp/LPx4600m0Yb6VprO8rMUlW+FU8zjZN5PAyShiOMp1JUjDcpzXNF3dG/WtvSjZLmolEu+tCW8+0
	1/B8Jk9uU742ex7mk5S21AtW73b8kXoI5vjJK9vY/KbcLjn5exJi9aArzYZB+q9okPhqudb3rAmgq
	/QNGaFp0ui1jQXJwZU8LVNT2M16tWo03WPFhjyZYMEphEHf6Xt+LK95M2xPXKU+iklZzoPog5XP/L
	trCptS9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxOA-00000006QJq-0fRW;
	Wed, 28 Oct 2026 06:43:58 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxO5-00000006QJ8-38gx
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793169831; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CdjUXPPMIEpAewE8Co7gN1O8xQFI2a3CrNWr/NRY6HM=;
	b=LRMAaj005Ij7z1IwEk9ATYvtvV3oGYmTrUMm+0wLsZUah4oq/HK7ZHoqQ5smyv4xrFiLcH3+N+iKza/HNNJu0UnGR75nqL7Q3MPNS8nnAQZ3Q0TCRbwmnw3CgGXnTceuHZT8XA+2UpDKLz/TtpoAMv8Z/e0zrBH5u/L3X8izyqE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDfzdKA_1793169830;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDfzdKA_1793169830 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 14:43:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Free the old negotiation state when restarting authentication
Date: Wed, 28 Oct 2026 14:43:45 +0800
Message-ID: <20261028064345.544504-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_234354_260596_247BD1E7 
X-CRM114-Status: UNSURE (   9.24  )
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

Restarting a DH-HMAC-CHAP negotiation with SEND(NEGOTIATE) resets
sq->dhchap_step but does not release the previous c1/c2/skey, which
are only freed in nvmet_auth_sq_free() at teardown.  The next
CHALLENGE/REPLY exchange then overwrites those pointers with fresh
allocations.

An unauthenticated host can repeat the negotiate message endlessly,
leaking a few dozen bytes per round and slowly exhausting target
memory.

Clear the old negotiation state with nvmet_auth_sq_free() before
setting up the new one.

Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 1 file changed, 1 insertion(+)

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


