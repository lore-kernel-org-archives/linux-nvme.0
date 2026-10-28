Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD200606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=njyGVcGG;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Rw91/zGV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=WZ2xPtiG5hef/I6lFVpxhkZOEyQi2X/cHDM1tmnMiIg=; b=njyGVcGGYMbnTZWCf0r3ZuiVqf
	ahCuaGxpE9txj5Wmj/G/G/J8nWdIaQ8AYQMBr68wxWSnTCQMkl3TaryLmTxw7Zy7waVMS3ik03Axv
	idUEgbhHkZPew9iqtOzQpqjU2DlHhzn7/dRo6KRP6u59F8ERcva7G98JVa5mPEZNwjoh+2UEHb8oC
	lAhgnVqbNiCnoEsee2n88qJ3kkYxEXMnGMYCW51SepJWYvBEtJJ9FOdTNcFVv/+VpTksXdBlVOL0e
	18EwILllQtrCF37QTzrG7tRbmT2XV9NdJIPDPSB9YEyfDH1CI8ac3HlPdzZ9MKrLgq08br1IT3FrH
	7q5IT/OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxOs-00000006QT1-2Yo3;
	Wed, 28 Oct 2026 06:44:42 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxOp-00000006QRs-3WFt
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793169877; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WZ2xPtiG5hef/I6lFVpxhkZOEyQi2X/cHDM1tmnMiIg=;
	b=Rw91/zGVo3tq3jm9rA1r+nuA9gHt1G6kfvhBepP9QC7R4k+XAGhI6NXtzQ9JGQRFit66ny98QcJhhVQRXQkHG0PhmgfZfvQzfvp2o2vQjab1aqlXgjaCsTATH2lf8CBhxA+cCN4uh9jNwBFAT00xUGucQPOBM3RMYiFUdEMGja8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDg-j98_1793169876;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDg-j98_1793169876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 14:44:36 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Finish the blk plug when integrity allocation fails
Date: Wed, 28 Oct 2026 14:44:36 +0800
Message-ID: <20261028064436.550665-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_234440_053312_59CF32B8 
X-CRM114-Status: GOOD (  10.36  )
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

nvmet_bdev_execute_rw() starts a plug before building the bios, but
the two error exits taken when nvmet_bdev_alloc_bip() fails return
without calling blk_finish_plug().  current->plug is left pointing
at the stack frame of the returned function, so the next
blk_flush_plug() walks a stale list.

Route both failures through a common exit that finishes the plug.

Fixes: c6e3f13398123 ("nvmet: add metadata support for block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4e..4b7483bc9cc31 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -316,7 +316,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 							  &prot_miter);
 				if (unlikely(rc)) {
 					bio_io_error(bio);
-					return;
+					goto out_plug;
 				}
 			}
 
@@ -336,11 +336,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
 		if (unlikely(rc)) {
 			bio_io_error(bio);
-			return;
+			goto out_plug;
 		}
 	}
 
 	submit_bio(bio);
+out_plug:
 	blk_finish_plug(&plug);
 }
 
-- 
2.43.7


