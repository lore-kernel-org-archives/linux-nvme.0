Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B256073C6A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=32g5S7/A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0gNWaP6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6nxQGkR2+dQ77VXhMKkc6TeWhcz+nCP3lMiHG+fTsXY=; b=32g5S7/ATY1JvZ
	7S4OONKYOdHhRVEDtJyXD0N58JvSsgptIourNmYiDOCSd5ORhhbsugvDXeHzY8NBTUyokGXKBgk8Q
	xeFeO3WcVRJnvlUK2k2vgCAPgCjH8AbWs3xboMd/JLm9Q7qWP7XA6icR/M3RPk0Jd0BUe4LcSg20H
	ba1dq2WRO8HIjsgRo9WuHJ0wmnQZL3iFLpZW2AV59TeLDyQDTUHRi034QAsIf4mfZ2k57LOEK5M1D
	GjPCbzH5c9W2ZA4AgnuOeUiVBVTVX9iyANwZxJGV1S1LZIZk8mhtwpEHZnJcEyzYiMQw6qPdfaLap
	64O//TdqVLT53KfmDHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWi-000000025eR-17kU;
	Mon, 16 Nov 2026 11:05:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWd-000000025cN-44OP
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 69F436295A;
	Mon, 16 Nov 2026 11:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC38D1F00927;
	Mon, 16 Nov 2026 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827127;
	bh=6nxQGkR2+dQ77VXhMKkc6TeWhcz+nCP3lMiHG+fTsXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n0gNWaP6+UaJle+lzPIjzK+kyrdMuW2wim4FMgJ0DTFVHRkmRwb05GQtyZ4lcrEsr
	 WlFZlJjd6EHmIj8NzzqDTKy4RpNXFIE4ZB5YKinWiLIV4yE4N/uGMY+6QoW1uNGMzv
	 WoAeWTa83/6NZeA9JdwkbDDGa3YMvfBApWd5SppCS24LPewTESUQ0Ef4mKIVfC5vWA
	 Ir+k9QzWOr857A5zUwd6ZoxCqLRz8FoDlRyKmkMQqHSNs0HSYvIfzdmpkuYyXj0m6h
	 s6cTQ+4KoNp8FYesvPVXR2KA8ehz0xzT8rIyuF5ll1Hqf9UsF8qMO0hse7R038w17P
	 sCSrre2Hcixmw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:55 +0100
Subject: [PATCH v2 15/17] loop: use kiocb_write_iter()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-15-ecc4a2aac40e@kernel.org>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
 linux-nfs@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WndiNS7xqPSBhItB27WExsGLYYFKg/7/xrVo1D0g96o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqxXtP1Yx59vm07NWnTitsu3rH+TNSNvb/70UOxp1
 LaO6rdh3R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATUVnF8M+kT8HKTKFTvPkQ
 S/BFj+BK3YqMldUXL1zIzWvT36sSZwFU8bjpkNHbAwqTIjpDBdZwKp7cKMudIf2tb9GRoD9+b+U
 YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Use the new helpers instead of open-coding freeze protection for writes
to the backing file.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/loop.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d2f29aadabcc1..872d78006b131 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -325,8 +325,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
-	if (req_op(rq) == REQ_OP_WRITE)
-		kiocb_end_write(&cmd->iocb);
+	kiocb_end_write_iter(&cmd->iocb);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -395,10 +394,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		cmd->iocb.ki_flags = 0;
 	}
 
-	if (rw == ITER_SOURCE) {
-		kiocb_start_write(&cmd->iocb);
-		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	} else
+	if (rw == ITER_SOURCE)
+		ret = kiocb_write_iter(&cmd->iocb, &iter);
+	else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);

-- 
2.53.0


