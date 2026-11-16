Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128E606A337
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mdVAl/Qk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tsq4iuTK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BY87H/RnXilQq13XAhtvlglG6136WbkekRPXJvo2I3U=; b=mdVAl/QkFeLODE
	nojX5Jnwb14afGlkCQKIL2i7YinPCECj52/W4BNGa+H2QrB89VjEDPl/SAIY2FHKJUMRz9RZ0FH5g
	6YmtenYinfqy9ggpv2QHQ69z53BlgJmlMM2PfrpLj2czaWaWG1WIQb67B4BEfLL8ggaFiw4eTAzip
	DJBdKDkybE4DHlcJZDigJ8BKLvA4RJ8aom39SPJ1GT5C8JmmPdTf4kUUukFoP2RnHLhFS0pbJouF5
	zAGV2b206vfBuGVAAVWAjRxGyNVydF7K5qVs4smhytqNVpBxJbv4dE0CDR3HS01oB4OrmqL9Hqd3s
	sYvwZJUNAHNc8qqR7Beg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzx-00000002Oyt-0ARM;
	Mon, 16 Nov 2026 12:39:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSubv-000000027uM-0H3b
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:10:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82A4762972;
	Mon, 16 Nov 2026 11:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416851F000C5;
	Mon, 16 Nov 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827454;
	bh=BY87H/RnXilQq13XAhtvlglG6136WbkekRPXJvo2I3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tsq4iuTKRhulkomOLwfJCGY7RSUTospv3OqWJbcYQQFjEoKupjSCxw6Yy3rPq4pB9
	 +LrXvKA4rBly7ufMqZGGURI/PkATv40fMYkjtpqcL/tNHRyeTByFbJTZmujbH0d7/Q
	 HXCq2zQGevHC5tGi3GM/YXAFadxr211gKZs+efK2OMgZEBHzheaSEy+WXOjCe8RO5r
	 TJ2bRHJjwjB/ITjzevhBLxBTbfuTMUOIvIjO5xZFZMBmnzadWnSvOl1+uUswfItRJz
	 cvn+ZB4G6vMTJzmJfSaWRJJZDIQQXhCz05Bm/gc8LbBO51UdG9XgtkJRygpVExqJdR
	 0R8YByohYWTAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:12 +0100
Subject: [PATCH RFC v3 39/44] target: fileio: refuse files on pseudo
 filesystems as backing files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-39-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-mm@kvack.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Sashiko <sashiko-bot@kernel.org>, Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223; i=brauner@kernel.org;
 h=from:subject:message-id; bh=11gfWGw/ZwPDfVFtqD+CkdePFs+glK5xVNQbp3ek2T8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9etzj8cs54I/rlC7xuCARluu5a1aodKvyswTvkD6zv
 1dfVPVMRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETirBj+e2jMajfMFJqpekRG
 aqlo40Pe5TUVy7c/+DD7XlLpsaZOLoa/knzXPN++Mv3K99Ndbp9ymKjRnUWue9I2sb1mqWq5pLu
 bHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fd_dev_name can name any file including files on procfs or sysfs. The
initiator then gets to read and write kernel interfaces through the LUN
with kernel credentials. Refuse files on pseudo filesystems just like
loop does by switching to file_check_backing().

Do the same for the protection file. With DIF protection enabled the
fileio backend keeps the protection information in a second file. It is
named like the backing file with ".protection" appended and
fd_init_prot() opens it by path. Whatever that path leads to was taken
without any checks.

Note that the helper only accepts regular files and block devices as
backing file and only regular files as protection file. So far the
backing file could be anything with ->read_iter() and ->write_iter()
including character devices and FIFOs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206765@kernel.org
Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index a5391e57e9aa5..c747cc4a647ff 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -145,8 +145,8 @@ static int fd_configure_device(struct se_device *dev)
 	}
 	fd_dev->fd_file = file;
 
-	if (!file->f_op->read_iter || !file->f_op->write_iter) {
-		pr_err("FILEIO: %s lacks ->read_iter or ->write_iter\n",
+	if (file_check_backing(file, FMODE_READ | FMODE_WRITE, S_IFBLK)) {
+		pr_err("FILEIO: %s can't be used as a backing file\n",
 		       fd_dev->fd_dev_name);
 		ret = -EINVAL;
 		goto fail;
@@ -861,6 +861,12 @@ static int fd_init_prot(struct se_device *dev)
 		ret = PTR_ERR(prot_file);
 		return ret;
 	}
+
+	if (file_check_backing(prot_file, FMODE_READ | FMODE_WRITE, 0)) {
+		pr_err("FILEIO: %s can't be used as a protection file\n", buf);
+		filp_close(prot_file, NULL);
+		return -EINVAL;
+	}
 	fd_dev->fd_prot_file = prot_file;
 
 	return 0;

-- 
2.53.0


