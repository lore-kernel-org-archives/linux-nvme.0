Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B06073C7A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XWFmP0J3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJf/sVnW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Up4QcDgioDZqUrec7no2Sv6eS8z1skBOes4Nvk8uSaY=; b=XWFmP0J39pX2iR
	8hKSKLKUdA96+wMP+GJ5Az86hSyJzAaPhq94viyu5DibBgwXr0nTLoPkwCpTeV+3lh/Nkac9EIpK4
	m1KDSEDCgrKc8PqHid4hAKg5xvtzb9RkoYbxM95ajAm2F1aU3YJPJ5M9Zk3PA6p3D81Rg0Te6AeSY
	qG0pRiWybUVBKtaPiGV8L+5u8pfq3Z1vwm+s1ONKBitZUz/eCkGQt0VGiugFDpTO86VcXA3BiGTBa
	0eW7dmtg+JQNjaTfLSMufmgUgArobuoIPyJ4p4oSU5Xl/4AQpGG9I5wpZ+2R2PEMD+CbTCkYbYmTM
	+OAt609l6fB2pQwfMO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWj-000000025i5-1nJM;
	Mon, 16 Nov 2026 11:05:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWi-000000025ed-0Cd0
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 669D662961;
	Mon, 16 Nov 2026 11:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DAB1F00926;
	Mon, 16 Nov 2026 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827131;
	bh=Up4QcDgioDZqUrec7no2Sv6eS8z1skBOes4Nvk8uSaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UJf/sVnWA5PbX7ZnzaL5uM5WD2CNUwQM2ooXztogsWbtOE1shubZUqTcSwkLkRFQq
	 FAhnv2rRmOrIR9n6e15wIFY5690R32XIGNOE5nneN5BsA/53klUD4O2b3SjyXye+2l
	 tFOKWD662r/pcXHsBEn5J7I8x7L37ljUXyU3b7esgv4TQdDYtYBaDDuxpiAUlOutx4
	 hfico32rbTfgNCKvOCfMnwrZIHczpPeZC4/trq8cZ2uwAzDdy103/i+3g4/bF3ydnq
	 PvCytT/H66q3RwtTUpQh2d9/XVkkHy2eBh4HCZ8X90WETLxPbZgmuIzsEVrV79ouWe
	 cBtvTC9Ei56Cw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:56 +0100
Subject: [PATCH v2 16/17] fs: use kiocb_write_iter() in
 vfs_iocb_iter_write()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-16-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MCaMNnJkL9G2ZH6ZyKJ0L2XRF9HMQi7Wd1t5jXBxpyk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9emxwMOyM8JrvK5ZdNFvFsuCiy8fCH8/Wpcn/1vXM/
 Dw5Ush4d0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE0qQYGdpNBeuZ5rlJmD4p
 SHz5Yu19p9yF99dum3W/kEe8ipXliTMjwy652s4dFQEfzqgFmQnbOc7+1+OT/fVc45rT9tvjp1m
 +YQIA
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

vfs_iocb_iter_write() open-codes what kiocb_write_iter() does. Use it.
The kiocb is marked with IOCB_WRITE now so the caller can drop freeze
protection with kiocb_end_write_iter().

This also means that an IOCB_NOWAIT write fails with -EAGAIN instead of
waiting for a frozen filesystem. No caller passes IOCB_NOWAIT today.
overlayfs and fuse passthrough don't set FMODE_NOWAIT and cachefiles
and nfsd don't ask for it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/read_write.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 6767283108991..eca0aa73e5a4d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -923,7 +923,7 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 EXPORT_SYMBOL(vfs_iter_read);
 
 /*
- * Caller is responsible for calling kiocb_end_write() on completion
+ * Caller is responsible for calling kiocb_end_write_iter() on completion
  * if async iocb was queued.
  */
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
@@ -946,10 +946,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	kiocb_start_write(iocb);
-	ret = file->f_op->write_iter(iocb, iter);
-	if (ret != -EIOCBQUEUED)
-		kiocb_end_write(iocb);
+	ret = kiocb_write_iter(iocb, iter);
 	if (ret > 0)
 		fsnotify_modify(file);
 

-- 
2.53.0


