Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC68606A88C
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aNGhI1+0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcXfZPnX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QUiIdf/VXbV/3ThxPnfV55Q6xZ2QK1e/5J9j2REhcqI=; b=aNGhI1+0qbE/Z7
	XJyv7hRTF//nVwPL76DcuoJfD2FamkuRBqz3gf8AygmWHNlDUoZdjWOQhgZODKZi9e/jLnhUa+YsC
	ZsSe0fqHtSyFxDEHoho7n+RpxbZ57Wr/IZkIcumtwCYPx17yM5Sjco4DN1mfvzOdhgWtantAzKt0Q
	srzeIPWlaVvI8Nf8X9m7ClEpCyLDlCmL4MGN+28kmhx9ji0pJDQUg/tCyTZqctfIvvz/PMKjckMuN
	4Sp/HvBTvdTTkKurhr05H5ar/h2SFLE0XFx31uCcePmlqwC+sYEWn1r+9mcvpGNbHNT+b8jDIVctZ
	XZyDdDnqYHeyxWGeZusw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJ5-0000000FpHh-1Yuk;
	Sat, 14 Nov 2026 10:48:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJ4-0000000FpGb-0VUD
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E36861D20;
	Sat, 14 Nov 2026 10:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAF31F000C4;
	Sat, 14 Nov 2026 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653305;
	bh=QUiIdf/VXbV/3ThxPnfV55Q6xZ2QK1e/5J9j2REhcqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BcXfZPnX5DH/q7oonex9fT/X+rYPbVzVy3SW8M9e5hd6juWGS+HlERHxEjzACVrWT
	 k/xsHiR/TzavqXyiEx+BvO+ulqU7CJNTn0G+w2Yf7KDHtRAn6T0Ld3J/ry3nL2uUgm
	 MAmMat2Qq9HaH0IbfVUywDsu3PlXMeRX82taYMOWVq0pUJsTi4rNT9l/Er2ZBxChZR
	 3+QNLG2lgMmNYxqY2uHhFcpaWpXeJtIZK/EaloCyD99lbVa012popFxpwQJSF61Q9Y
	 FvcivKzsCbsC41MFq6RoKMNXRY/C4XLQwozR0nCOPUiS351pDqTUQg3GZnNEU8OCxw
	 7FOW7ni0TRhIQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:17 +0100
Subject: [PATCH 10/12] ovl: take freeze protection when storing the uuid
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
In-Reply-To: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R/ypmBhSroYAV5t6Q2PaspAYXgGUjYczfSSW/iihK8s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sPGourqiPc/vyWQ10RnH7ljd/Jo/d73s5wTlKgefl
 tom8zWtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP52cjwh2vJz8XmJRNvKJac
 fW+x7P2GHtZGMdtdB52SnXdI8pqtOM/w3/VZWYSjmNZqWaXnvsaqXpOn3N6T9e997NS5/pf1KvY
 IMQMA
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

ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
upper root. That happens after ovl_make_workdir() dropped its write
access to the upper mount and before ovl_get_indexdir() takes it
again. So a freeze of the upper filesystem that lands in between lets
the mount modify a frozen filesystem.

Take write access to the upper mount around the xattr update.

Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/overlayfs/util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 521717209b2e4..67aa7b71e9c83 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Try to store persistent uuid */
 	set = true;
-	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
-			   UUID_SIZE);
+	res = mnt_want_write(ovl_upper_mnt(ofs));
+	if (!res) {
+		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
+				   uuid.b, UUID_SIZE);
+		mnt_drop_write(ovl_upper_mnt(ofs));
+	}
 	if (res)
 		goto fail;
 

-- 
2.53.0


