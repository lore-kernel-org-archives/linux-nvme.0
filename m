Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C31606A8AE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vZ5GoRzY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ck/Fpf51
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1QF0+KKDPXTbJ0UkYlxOFTSFnDq8YOHfFuDVPMQMMME=; b=vZ5GoRzYncOdgP
	pOVuIz5APYpnhDRRHo76UcvHaIzne/y/S1+GFQOy/VeQjXGCPdQDB+plBaGVY1QoB58pUqNOLFFZ+
	fIE9jJurUnvR1uRst3dRG6D/5xmBL7JzWVlQttTMoEtm9n1gdaa8WY6Fpil1KYHkwKtYClsU+zMBI
	gh3JzXFJ8qexgVYbQhUQB2F46JIzm4XDoW4LAhL/IihaICia4qIe6eDPM4W5bG1BQhxirz+q34h93
	phu6crh210fS1lGvpii7i/kv5E5+KplNZ1ozckz29+hqurGAMv7W2JSVVnqcfkqwg42LEGwjm6rw0
	sTKTr6/Pw5so95U5P+Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWn-000000025nc-2ToM;
	Mon, 16 Nov 2026 11:05:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWm-000000025lB-0QIx
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86C3262947;
	Mon, 16 Nov 2026 11:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1521F000C6;
	Mon, 16 Nov 2026 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827135;
	bh=1QF0+KKDPXTbJ0UkYlxOFTSFnDq8YOHfFuDVPMQMMME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ck/Fpf51qFS3EHEddNfmsL1bIe8Taey8LjrZGzNMpgHEPuJ1VvtqdvBfaqG6qhxpE
	 mrvS+azIkIJJPAnJUWMmlL83WA2/8T+yNE+Q8o2SvCBwQw8MYdA1DMAdF/BvJXG4y8
	 d2j8oNmy9+IWdWgTdbtT87Gv6/psMcS4+lIam8QX4mcOoDUMYwgSTrzikk7HGB3fvq
	 e6KjCy8Rwjga2FSODjRJBeaHywt7cIh0nMaZ031BK6ucqMIOUZopgpVRZmUNNSkTll
	 AYR/aZepGfDfpKqRhXkb0qEqYqzZymz+CtzjtPuZqR4AozUUXGawQTMJLRC7yZTg8K
	 ZpjJq4FFpxmfA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:57 +0100
Subject: [PATCH v2 17/17] backing-file: use kiocb_end_write_iter()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-17-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ekRldUrgBiFG3YHdph7NV3YyVlYUFmWnca1eOlEjyD8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9emy47av6aq8f8tcaf53VT85reJav/Xmzjf5Cp/lGC
 3azfpaS7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIfmFGhi+LejYIbrW4lLA6
 XtKg3PbEi8KdggESFeHRX7r4pypxNjEyvN6uH8u0PHH5bZ+9XLv5PD+cZBe5cf0028OjegtCzaa
 +5gMA
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

vfs_iocb_iter_write() marks the kiocb with IOCB_WRITE now. Drop freeze
protection with kiocb_end_write_iter() in the completion callback and
get rid of aio->is_write.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/backing-file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 5780f60662d07..e86f5685758eb 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -106,8 +106,6 @@ struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
-	/* used for aio completion */
-	bool is_write;
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
@@ -148,9 +146,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
-	if (aio->is_write)
-		kiocb_end_write(iocb);
+	/* Pairs with kiocb_write_iter() in vfs_iocb_iter_write() */
+	kiocb_end_write_iter(iocb);
 
 	backing_aio_cleanup(aio, res);
 	orig_iocb->ki_complete(orig_iocb, res);
@@ -264,7 +261,6 @@ static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		return -ENOMEM;
 
 	aio->orig_iocb = iocb;
-	aio->is_write = true;
 	aio->end_write = end_write;
 	kiocb_clone(&aio->iocb, iocb, get_file(file));
 	aio->iocb.ki_flags = flags;

-- 
2.53.0


