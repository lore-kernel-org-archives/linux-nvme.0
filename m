Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F6606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WbEkjG4j;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgjMN56K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8CwpxM6nYTuBn1diZMKE8u8L7OG7WlbpBDnW4TTBYyk=; b=WbEkjG4jIPUoTP
	7AsoO5rwK+IcXIYKBj8yJtjovvLJzjGRW4nz3/F0/g1EhFB2/LVGmbgUGbkQBM+SWZlXarJWwV1mT
	iOXFc7Cx1+lUK6aRMatT+wFYnBmTnEWRIEmQsFlekc2jJvH8BNXKlAl2SXnGK99Ial9CwZwYdUotd
	2NK/W9NfbRo8qtk+O4SGjnffFx2WNs78EKfAZYSbj3SQQ2LHEJRslxx5M0NAQdf3X8HNBxjlyTKS+
	LRgKiNReUCbg+N9f8oMAFMmK7l10r1DVj11+M1HOicnvYHrTRM74NPRQicVZuMLcok+LJb/xe9kZC
	oOWnHm+PifZvXgnFV6cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw01-00000002PBo-0YkA;
	Mon, 16 Nov 2026 12:39:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSucO-0000000281k-2Qre
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:11:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AA1162967;
	Mon, 16 Nov 2026 11:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B31F000C5;
	Mon, 16 Nov 2026 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827483;
	bh=8CwpxM6nYTuBn1diZMKE8u8L7OG7WlbpBDnW4TTBYyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TgjMN56KOGGjy4LWUYsZ8zVo89DB80z6mNiJUIXdyCxzkfdDPL0CceRNnYEB5ZMAg
	 PvkD68BWJ9caW2s/BGPrGC91Iq9CXON0BvEYC4o9C6G7FIaTwo+zxVlOEz2OOHPj5k
	 4vXH0MjVLq/jft4abkooK+ZUvlfxnZFbaMziEvjtIgG2hkF85u9Jdu0B1Z0thxS1Vt
	 ZGARk4NS/4O6UY4E9/nGiGeDdufCKu3ZzScYIpnsUw2WoGqih1dN6XANIxyQsbx8j7
	 /P5GGzoXoUbjqBYgg50FlLRHJWxCQQmcH0xslfduPPlaC1VbV4Z1ZBjTDb0GhtHuP2
	 ZujQbdQe5sKRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:16 +0100
Subject: [PATCH RFC v3 43/44] acct: refuse files on pseudo filesystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-43-8cbbea1cf34f@kernel.org>
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
 Alexander Mikhalitsyn <alex@amutable.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TBLyDKw5rIlrAxe1WyLhAIBRdo8Sa0ool6FMcens/Cw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9ejzBrFZos83lvdOmyU1dbrg+U5ejPTdxwtWo7L1VD
 VNiDrWpdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE7zkjQ4fU9EqupZErcpbM
 YdFl11N9/mKWoNrBrC3H9UQXrluybwojw9s/fcqVr01abSYZ5cX71J9+ofyxLFboXoAX66kl1eu
 TOQE=
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

acct(2) already refuses to write its records to files on kernel internal
filesystems and to procfs and sysfs files. It recognizes the latter two
by FS_USERNS_MOUNT_RESTRICTED which misses every other pseudo
filesystem. So a cgroup2 or binfmt_misc file is accepted as the
accounting file.

The records are written with the credentials of whoever turned on
accounting so this isn't abusable the way loop is. But files on pseudo
filesystems aren't a place to store accounting records. Use
file_check_backing() to refuse all of them.

SB_NOUSER doesn't need to be checked separately anymore. It is only
raised by pseudo filesystems and by tmpfs instances that are either
kernel internal or can't be mounted.

Suggested-by: Alexander Mikhalitsyn <alex@amutable.com>
Link: https://lore.kernel.org/r/ae189903d4cda27130317a9312d94b53d07415ba.camel@amutable.com
Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/acct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index c440d43479ca5..0c502f778fde0 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -245,11 +245,11 @@ static int acct_on(const char __user *name)
 		return -EACCES;
 
 	/* Exclude kernel internal filesystems. */
-	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT))
+	if (file_inode(file)->i_sb->s_flags & SB_KERNMOUNT)
 		return -EINVAL;
 
-	/* Exclude procfs and sysfs. */
-	if (file_inode(file)->i_sb->s_type->fs_flags & FS_USERNS_MOUNT_RESTRICTED)
+	/* Exclude pseudo filesystems. */
+	if (file_check_backing(file, 0, 0))
 		return -EINVAL;
 
 	if (!(file->f_mode & FMODE_CAN_WRITE))

-- 
2.53.0


