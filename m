Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749B606C296
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tle881dD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Af+KKCs4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pjbhVx2fs5v7PEkUYOgJa+aS4bC1ZGO8oQVzHBWC01U=; b=tle881dDGRrgvg
	GPm/uOi6djpwcU76F4v0eHAgi4PBKEehpb5n/qcv7eU0XliJoF0+/yXfNVZB8rOz+Z/iqzHzDb2Ak
	uvveA6B5j/d4e02gXwhRrdh61qb6Jg4zyDyWUN4i0lDPhlKI/dnjDTlUGO34fcJVWywTRL/hVetKk
	Je1Y5czHFdhlJ8AXBerh3IyfNPneyanqXMtMdpCuX/jMwVNoW9ZWufosJ2tA+oMkT5cj7mIe+moQi
	SaoLLl8zvIyh0O1B3eBS/lFho/idrXWmFMr/hI6iU60BdUktyEt4CxCP+dqoMaUcLJWsW5MU/kP0Q
	Rctvi9TOfZiDpjFy0UoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJ1-0000000FpDp-0ydx;
	Sat, 14 Nov 2026 10:48:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJ0-0000000FpCI-14nE
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B158361DB2;
	Sat, 14 Nov 2026 10:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7AC1F000C5;
	Sat, 14 Nov 2026 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653301;
	bh=pjbhVx2fs5v7PEkUYOgJa+aS4bC1ZGO8oQVzHBWC01U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Af+KKCs45CAl7fomaGE+uUOySiwEadp9iG1LotBHwhmhbghDQTIHCPSuh6eDy1e0P
	 Fnd1yVYV2Y5wDitIEf/NJcz++yTe0hJZbxOjRSoaQMibUYt4hRs15JM/1YKCmWuwHs
	 3hjcXUrJjY4kESZeln2Z+kqoXaLfu/Rin3xwffDJbUAG9liYRqNnu/4HZRUBCHGmil
	 ef8H4xARIwaAZM0JMbVOL2nhyeZWBNJj5g6BcBLFmyUsVhRxG5HpU9MplP3aYwCqXo
	 m2gm6RCzHr5UE46ZXE3xH8jPlFrd7uZBmAgT5xivoAioLXGpHADKB3F4ybToeszXwK
	 unVsVQJuFNETA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:16 +0100
Subject: [PATCH 09/12] coredump: take freeze protection for the truncate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-9-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=brauner@kernel.org;
 h=from:subject:message-id; bh=34ncq8Kdq+MSTLVnNDtgt7r/DShig8xHabTi/tdVmLw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sHE//KxCTm/yQQbrTLaAG2s4RYXWfBTX5mt5mD7ZT
 2gfb7NYRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+PWH4X+bDXclb0HDtNpeZ
 5PPGQxfuqW20XvRg28kO7XU7H+XMaGJk+NGZaeWr687tmjInzW3nouY5zUEmt8+0ccY1NunfOPW
 QCQA=
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

coredump_file() truncates the core file after filp_open() returned.
The open took freeze protection for the create but dropped it again
before returning and coredump_write() only takes it for the dump
itself. So a freeze that lands in between lets the truncate modify a
frozen filesystem.

Take freeze protection around the truncate like do_ftruncate() does.

Fixes: 14da9200140f ("fs: Protect write paths by sb_start_write - sb_end_write")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 82ef9d115999a..cc6a0c7e48ce2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1060,8 +1060,10 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 	}
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return false;
-	if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
-		return false;
+	scoped_guard(super_write, inode->i_sb) {
+		if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
+			return false;
+	}
 
 	cprm->file = no_free_ptr(file);
 	return true;

-- 
2.53.0


