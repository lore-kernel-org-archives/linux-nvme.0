Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B2606A339
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w+nY547W;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPSzXz73
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YVy4G1eZ8haJVwqyLqtsl+I1DFI8cmbWjfidq7pwrZ4=; b=w+nY547WVelWhQ
	VC8kUewQfLV0J51AKomKvQGL1MGrI0JCSTrPOD/WsUTuHO+fucMJBYPTXr/ygZ8fbsfgHSB3/us3k
	VWFwcLahCaWG3BMjPIljLxvu5UMqBZigqAuRvPJlY9hY7vhDB5Um8tDcv7hxYEZF/IAUgG2HDpBgQ
	SuyYLTJYYKqrHIszEuL2SpfmAJ7nkKqZv8WtN7NaScJYqX85LajMj3VXacplk3y+K3s6rQP+NEVR/
	BizKQKaorS1xmfcBatBSU4wwGOuaJ4mQ5lNC/U7ANvM3YGDpuvSuhySCzEQxq5EugT45F2re776BB
	xAs6WVmFJ6hlM05x3NUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVm-000000024dA-3dKg;
	Mon, 16 Nov 2026 11:04:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVm-000000024c8-15Oq
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6404E62912;
	Mon, 16 Nov 2026 11:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D6C1F000C4;
	Mon, 16 Nov 2026 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827073;
	bh=YVy4G1eZ8haJVwqyLqtsl+I1DFI8cmbWjfidq7pwrZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fPSzXz73bjVa06/0iuO/37JnOSLJ9HRuT/+Z7E6XEb49sBBuYFQcpUletptQKreqO
	 D3AFX3jRKzrA6S5yC8NGtKQjLEhF7QhnoyA8aOWWk0DY7919niA7ghLb53siANFQgv
	 Ecrnxqoi4LK5xPlghNAoAqEexGlfv1c6VEJQZVWQ6cWxQDuK6MMZxRyf0x+jZQ18Bu
	 hldXu78p2ezjPZ3CfwG8x0GkHJ8fLE5LhJjsQKa+FmA3FdWcHiwwW1TJfkQHYeeCAT
	 9gYeUpu9DD98fu2Pm1bHW18gcae9wNb/4cI1CDs1AMrb9uZ6lx15MuNDPxzFreCaNW
	 A9rLmF4q1w5og==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:42 +0100
Subject: [PATCH v2 02/17] fs: add kiocb_write_iter() and
 kiocb_end_write_iter()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b1QjShsXrXl9uCeQCmrAqMQU14wS2tzSxu+AvqrM/tM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eiyfxCOx6XeMi/rNnAX/tY1CP5Z+/aBfxxSeIuH9k
 vHi3LXmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJT2L4p3lMV9+Ma9v9vIka
 rjL8q+7N25C7+IBDZQO3c5NErfXDKob/gRpvXq2Y/mf3AqGNbi1Tu71qPjXoROfsmVr2ctems4F
 vmQE=
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

Calling ->write_iter() with a kiocb of your own means taking freeze
protection, calling ->write_iter() and dropping freeze protection again
unless the write was queued. The completion callback then has to know
whether it completes a write that still holds freeze protection. loop
open-codes this and keys the completion on the request op. zloop, the
nvme target and target fileio need the same. Christoph pointed out that
open-coding this everywhere is fragile (cf. [1]).

Add kiocb_write_iter(). It takes freeze protection, marks the kiocb
with IOCB_WRITE like aio, io_uring and cachefiles do and calls
->write_iter(). If the write wasn't queued freeze protection is dropped
right away. With IOCB_NOWAIT it only tries to get freeze protection and
fails with -EAGAIN instead of waiting for the thaw.

kiocb_end_write_iter() drops freeze protection if the kiocb still holds
it and clears IOCB_WRITE. So a completion callback can call it for any
I/O. That matters for drivers that complete I/O that wasn't queued
through the same callback and for drivers that reuse their kiocbs.

[1]: https://lore.kernel.org/r/20261116064654.GA2964@lst.de

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/fs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index eefc2c9d4af19..0b66a09fb686a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2840,6 +2840,54 @@ static inline void kiocb_end_write(struct kiocb *iocb)
 	sb_end_write(inode->i_sb);
 }
 
+/**
+ * kiocb_end_write_iter - drop write access after kiocb_write_iter()
+ * @iocb: the io context the write was submitted with
+ *
+ * Drop write access if @iocb still holds it and clear IOCB_WRITE. This
+ * does nothing for reads and for writes kiocb_write_iter() already
+ * finished. So the completion callback can call it for any I/O.
+ */
+static inline void kiocb_end_write_iter(struct kiocb *iocb)
+{
+	if (!(iocb->ki_flags & IOCB_WRITE))
+		return;
+	iocb->ki_flags &= ~IOCB_WRITE;
+	kiocb_end_write(iocb);
+}
+
+/**
+ * kiocb_write_iter - submit a write with write access to the superblock
+ * @iocb: the io context to submit the write with
+ * @iter: the data to write
+ *
+ * Get write access, mark @iocb with IOCB_WRITE and call ->write_iter().
+ * A write that wasn't queued drops write access before this returns. A
+ * queued write keeps it until the completion callback calls
+ * kiocb_end_write_iter(). With IOCB_NOWAIT this fails with -EAGAIN
+ * instead of waiting for a frozen filesystem.
+ *
+ * Return: On success the number of bytes written or -EIOCBQUEUED is
+ *         returned. On failure a negative error code is returned.
+ */
+static inline ssize_t kiocb_write_iter(struct kiocb *iocb,
+				       struct iov_iter *iter)
+{
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!kiocb_start_write_trylock(iocb))
+			return -EAGAIN;
+	} else {
+		kiocb_start_write(iocb);
+	}
+	iocb->ki_flags |= IOCB_WRITE;
+	ret = iocb->ki_filp->f_op->write_iter(iocb, iter);
+	if (ret != -EIOCBQUEUED)
+		kiocb_end_write_iter(iocb);
+	return ret;
+}
+
 /*
  * This is used for regular files where some users -- especially the
  * currently executed binary in a process, previously handled via

-- 
2.53.0


