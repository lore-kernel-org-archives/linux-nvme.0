Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969F606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yn9FKyHS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQA/sxsh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5VuE4/weECRM9eIO6+lamMRzkXENJc2tSdRrjKtP/6E=; b=yn9FKyHSvR2BkZ
	sA7nmjoJ0ZvOcWWqr7QOxYltB4qmiEUl+pm/33IybsRwT++85tXt9vJswi2kIOlQ0/8uLEc4hhS2k
	jLo1IBayc06Gp9aqoBMzrcchQn5sZjXKAkWoxL0XMJNCesPldOI4MIiBDvbsLTl3pje7zYA1XY3SW
	DNBvGXkNneuFGo6jnsYVhHk69/W4I/NhcGaq3HZfgLomHhkgkVDrtaTe/7S7N6E0EtuwWzk+RF+UY
	b/ror0Ab4fviPFtg+Y6QR70CHpq48WvdGYBdRl84UJYufyKzXRyojreIPHJyPb6hPhaLBdrAGEuPl
	2vCg/E3FXUQAll5Wu+nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhA-00000007jeP-2n8Q;
	Wed, 11 Nov 2026 21:17:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi0T-00000003EfU-2XWv
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D6824487E;
	Tue, 10 Nov 2026 09:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77511F008A3;
	Tue, 10 Nov 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302349;
	bh=5VuE4/weECRM9eIO6+lamMRzkXENJc2tSdRrjKtP/6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iQA/sxshAM8lgjVZtwQBlBlt6Ccgq/KLZUd+ak37Q2oUOuNb3EKD2IEz5QKL7HSuJ
	 PzfYZUUU9t4mHJQyXpGh/FegWtFPckXXEaWIZpe18Dzveuhdh412cFkoYX9U6GHhAs
	 FA3mIwVRbXfRG/foFS7hgF8f2XdzXBVoA2mbPV/1dW+mNpe42vnBoqn1KQUo3a7IH3
	 OShJM3zaQPTgLbpL8PYQYa3MhajH2yuDWbFWTSzcixuX/GpsV21irhlminf8YwjK3i
	 FcMM/10RV269QdY1WwY6VGtRQ1P449Wk5bY3A8Uk5z3MdBjKp3IUMwp4dCZ2nOAdUX
	 a+oxx0hQk158g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:44 +0100
Subject: [PATCH RFC 28/41] ocfs2: use fc_init_pseudo() for dlmfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-28-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
In-Reply-To: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IdNufAsq5EGNNcdE9WV9rVN1DCJjWbb8v/riZT7kRA0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDl3LqF3BIxnOW7s6R69N3au4r1m0WSo7rUW0tPb
 d3ziC+no5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJLTjEydK1aEV6R03Dp6Qur
 9ReajrtK9AT09OsHms5fHf0wofDSUkaGzj38rmzbCz87b5+14Zu8c8plz01rglO+aJ1tSLofN8u
 eDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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

Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ocfs2/dlmfs/dlmfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index d3bfcada3e3b..1789ec96dc13 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -563,6 +564,7 @@ static const struct fs_context_operations dlmfs_context_ops = {
 
 static int dlmfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &dlmfs_context_ops;
 
 	return 0;

-- 
2.53.0


