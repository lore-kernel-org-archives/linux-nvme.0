Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F47606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EjuYaWtL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acdAWRI/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Gz0dTGlDVhd9jZuYoUkGX2lhrZ2264KU/6i6/t2s/qo=; b=EjuYaWtLqqNiCX
	RouHOVbsbzWTTuQNpE2p3S1h+qCsrmbbuPxOP603mozq+VwSMLego3UAhENt3T5h+v/CbTiPLkFmg
	LKvxTEb2rpnCi6unn/MH0X65PnoHdSKF/6l3StARDtLDQhfOO3LGHhNNVLAA+ZqqZfH9jppKsqGjt
	fgZYvY8cib1sZwPS4Usu1PdaHjfyO+d/TG3aa7fxyoVAUXZm2AxqiayNdcmuaKDoHRrpF7bXF+uYH
	mnegk4atgszBjIsoJa9wytNEtTAocCJBZykTuqdAqau6TInXgWAyTCtO7FGmSkY75TARqCtUIvYnN
	E6QZt3tm3N9M+JPF4DaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgm-00000007ile-2OTj;
	Wed, 11 Nov 2026 21:17:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhxj-00000003E2B-0EaR
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:16:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 733C845A20;
	Tue, 10 Nov 2026 09:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C141F008A1;
	Tue, 10 Nov 2026 09:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302178;
	bh=Gz0dTGlDVhd9jZuYoUkGX2lhrZ2264KU/6i6/t2s/qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=acdAWRI/NWQPeclSOSX1wx7aC0LKlluyS9cBSHJE3wkVd14QHiIc1fpuayPl5zd9i
	 5PlhWZ8zSjOW5F7hXCq+D2EWuxi2Yrz1KJQlfH1Ws82ExeUkKbKfMFv5OMJs6qDQtI
	 ivCs99Ag2xwlyttYhxW0mBoIpqSeDBKB/Xe0M7/566QfleEO1qmr3PSFpcBtLu8M6e
	 5uWOAFdagIG3gFGLfEvUEG0K5TUu2qe/wFq2GlzIwzmGbP9NF8Xz91S/ezjMWkYxIR
	 Zb5P2oATbJq5OI9cQHCzsF+MUW36ITw3fxTIvJMhFJgrnQP7+jVDlJirwJqu0ZS1tv
	 BoiZzSLVXO0sA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:19 +0100
Subject: [PATCH RFC 03/41] target: fileio: check that the backing file
 supports ->{read,write}_iter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-3-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g97QydFuuV3EqmGP6aEJJCN8xS9I93EqcEv7IXzLvEc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9ejDdONKlhY2V6c704xvOGr9csfDBT5O8DNkZzTyrW
 b98EX/9taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/p2MDOcnH/48I1xZ3H7D
 LsGX5rOm8IRo3DUzvJispdniOMP59DKGP3xBbsX6KZxq27yLJyS8Ft2xaLrf8V2fbigcXhGYuPX
 dSW4A
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

With fd_async_io=1 the fileio backend calls ->read_iter() and
->write_iter() of the backing file directly. The synchronous path goes
through vfs_iter_read() and vfs_iter_write() which check for them but
the aio path doesn't. So a backing file without them calls a NULL
pointer on its first I/O.

Refuse such files when configuring the device. On the synchronous path
every read or write that needed the missing method failed with EINVAL
anyway.

Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct and async I/O")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index ab9824a4852f..a5391e57e9aa 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device *dev)
 		goto fail;
 	}
 	fd_dev->fd_file = file;
+
+	if (!file->f_op->read_iter || !file->f_op->write_iter) {
+		pr_err("FILEIO: %s lacks ->read_iter or ->write_iter\n",
+		       fd_dev->fd_dev_name);
+		ret = -EINVAL;
+		goto fail;
+	}
+
 	/*
 	 * If using a block backend with this struct file, we extract
 	 * fd_dev->fd_[block,dev]_size from struct block_device.

-- 
2.53.0


