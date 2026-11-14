Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23E606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nsrpqLuD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpJVcMTY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=r6ZhD6v1VAC9LFMiPIrPjYVjUm9OFEumnB2zMtz0O/0=; b=nsrpqLuDvwmg51
	Yr3aYL2xT+hYO9frZVBdcVmFj8aAgRgj+DC+DNZ85jd15crreaEq7eM3GV9Oq1vZIa36BHh5W2xXp
	Otfgc2BFFQjhtRq0yo+s1Di/C+at60wFP6iA8MzVvBu8GyoRgt+k5zdnXUPMc3sTRVxg5DaCKthVJ
	//R72xQZHa5EZC+oS0QtUJq9iZil5a8yPERl1VOm6nY4mpaR3OEqvfiZb7CagBAV94abYIgMaJmUK
	hJa3xk4H82RmBH2l7VIlXos4Is7bkm+BEeQ3eu8lhSjnFxbvOGIoPc6qsuY0ySqJrEcassdUYOsZz
	MV83Cb2+/fLey2G9Ls5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFG-0000000GBDk-3sxX;
	Sat, 14 Nov 2026 13:56:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDSA-0000000G3bt-00OL
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:05:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BDA3240B44;
	Sat, 14 Nov 2026 13:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E051F000C9;
	Sat, 14 Nov 2026 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661557;
	bh=r6ZhD6v1VAC9LFMiPIrPjYVjUm9OFEumnB2zMtz0O/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MpJVcMTYApPZc7VozOSSmaXGxWwwgxOxiDGjTzhesY26ZSs/xNhwwdDIDL0zR46b0
	 W24cPjHL9Gyz2tmsdI2SZ1yAOIBcFIhBnPjCrQg2xaMcZtEWnbfvhWfVUXxY1N/Y+1
	 x7BIMwdp4kJhjoQq27aXY340AMvCIq9P2DrFIOyfPVCPJ5xs9RWXl9JHBQYKOWuud8
	 wvITPU/pQjvqn+W9V89fmzuCuW4Cwhv2tpUp3HqbUNBmkJwQ0riUqK0zrXSlsQ65ZJ
	 l3Cj8QQbq5mCnD/EO8LJr58gJzqPZx/uTT9g4OZqsMUvqRomSCrCoZjw8Em01eokpW
	 /XnZdvsBfixeQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:44 +0100
Subject: [PATCH RFC v2 03/42] target: fileio: check that the backing file
 supports ->{read,write}_iter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-3-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+p5P27LAsW3o7uyqtxsmCGm9+GYqGVB9cSFLMBczGcU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iMncq/F3Gqdfy3ml2pz6Cf16VQLrWpz9Pe6Ltv6/x
 ysXsqqio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI7fzMyTDnBc2fvPj7dwBbt
 Y32T7r5v36qWePZ+2WHraW+0ZwvH32H4H/HwwN1Nz2oWldU/1cn9XNqxx+bkkusBpYfP2X5oK3x
 8nh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Sat, 14 Nov 2026 05:56:41 -0800
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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index ab9824a4852f1..a5391e57e9aa5 100644
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


