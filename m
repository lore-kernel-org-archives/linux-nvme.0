Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BC606A33B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aGGVffIV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7dE9sA0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=X0sCUEjvhiXaIlHtE/D1yfoet6A6Fo7cZoSOfG4Vvvk=; b=aGGVffIVn3wJH3
	g/Yqk6LPcYjh0y1raKNY5i5tNRqIXgBHfTF2uNWCPkyuMeoUHAHk6df5l4WzUQxq+9sfmC4m+vtRD
	lcvXkCIv2Xc45Dy4l++R4WPVNxF89MtIbN2JDWQij7hYfb8eSEXLb2aCBWMoJ1ProyAqwYX8oAX3x
	o6GAb6nEmUdYFmRDoQtbHd9wMp/IE7UKrJqO945pQZy1fR8VO1rVqAj891Ai3lMDcyGdwZhcdWnu1
	U/NqDRVOOYnCmw1AcBhXE167CoX9BDDQmZl5NAreJQSJDK5TdCq2q06T+2i5YWtGKwdkmxB1VU9FR
	mTsfKXKa4F0cZsYaYC+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVi-000000024aV-39OO;
	Mon, 16 Nov 2026 11:04:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVh-000000024ZW-1kHf
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18C9440205;
	Mon, 16 Nov 2026 11:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D271F000C5;
	Mon, 16 Nov 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827069;
	bh=X0sCUEjvhiXaIlHtE/D1yfoet6A6Fo7cZoSOfG4Vvvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E7dE9sA0NFotPY1Hmpef+yX6EVKmyEZjdmuQiS8zkWmLEf6oVBg+P/y8u1iC2VsSf
	 KPFC2A4GL6EeWGTtHTjKLv6vVEn8sZOuxZf4rZDtykol7l3CrYlsW4T5mw0xu3qBEV
	 7LznvLrzKaJzA3n9bv7cM4XtzgxsAusUReLQh/BKFnpTJ7/UCaxlryrmTSIrwOcoqE
	 qvpgsPpdJ04xOOR5fvds3g+sn2Nwc1+6noHYyPsEea6wmsIvtnWKeLd/KXdZWSySQQ
	 7gMZBSnpJRRXACcnPvNdyZKeXOAu+0rozTj2AnvAhz8vKrDYBWHwpHEYvetpCpeRSi
	 YvGw33FnbFpFA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:41 +0100
Subject: [PATCH v2 01/17] fs: add kiocb_start_write_trylock()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-1-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NKIuUXH/Pq/hGo26my0gWyXbRVtNRh9yNGadVxnLh0A=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGr64x6jr5HzBoMm9JHxVLP/a5mgPg3IDGB3pF70rIslLrhdQ
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmr64x4ACgkQkcYbwGV43KLhWQEAqyQj
 7ka5/1GeFoOdt2YbWBYlOiN+vUkCDQMESc0F4i4BALZH1O+ebV3EQlAyMawIipKAH2lTL5MbwYU
 m5tZ0Xy8M
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

kiocb_start_write() waits until a frozen filesystem is thawed. A
nonblocking submission can't use it. io_uring open-codes the trylock
variant for its IOCB_NOWAIT writes.

Add kiocb_start_write_trylock() next to kiocb_start_write() and use it
in io_uring. kiocb_write_iter() is going to need it as well.

No functional changes.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/fs.h | 22 ++++++++++++++++++++++
 io_uring/rw.c      |  9 +--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c4..eefc2c9d4af19 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2801,6 +2801,28 @@ static inline void kiocb_start_write(struct kiocb *iocb)
 	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * kiocb_start_write_trylock - try to get write access to a superblock for
+ *			       async file io
+ * @iocb: the io context we want to submit the write with
+ *
+ * This is kiocb_start_write() for a submission that must not wait until a
+ * frozen filesystem is thawed. Should be matched with a call to
+ * kiocb_end_write() if it succeeds.
+ *
+ * Return: true if write access was acquired, false if it wasn't.
+ */
+static inline bool kiocb_start_write_trylock(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!sb_start_write_trylock(inode->i_sb))
+		return false;
+	/* Fool lockdep just like kiocb_start_write() does. */
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	return true;
+}
+
 /**
  * kiocb_end_write - drop write access to a superblock after async file io
  * @iocb: the io context we sumbitted the write with
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 3a8559ff4dc66..a0a16fc521455 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1095,9 +1095,6 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 
 static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
 {
-	struct inode *inode;
-	bool ret;
-
 	if (!(req->flags & REQ_F_ISREG))
 		return true;
 	if (!(kiocb->ki_flags & IOCB_NOWAIT)) {
@@ -1105,11 +1102,7 @@ static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
 		return true;
 	}
 
-	inode = file_inode(kiocb->ki_filp);
-	ret = sb_start_write_trylock(inode->i_sb);
-	if (ret)
-		__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
-	return ret;
+	return kiocb_start_write_trylock(kiocb);
 }
 
 int io_write(struct io_kiocb *req, unsigned int issue_flags)

-- 
2.53.0


