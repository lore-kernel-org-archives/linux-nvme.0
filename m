Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAC60A3808
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hOGcwv37;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H40xH7L5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=726hiCwS88TGvIdtuykXMk2SiBm2dzdYT7UT/Qe3T98=; b=hOGcwv37iHVQUr
	yAsoMBxbcZIkLVitlRBG07zzgl4nIN6dVowPBAcFwd6u9FiFj5qLuf6oVMnHxGstYO/KCMUybvvoR
	njc9PZubDK4+QfY2OmHPBN6p3MTVlFbd6ny55fhwdhKFBRikUXTVU7YbbNSSzfbowjFqWDTGDp7vo
	XMvKL3c3XWyKUdRULBtAoSijGvgNA4DV54Da9UoOiY6dY8o+97Y7DpAZLx7bBDTXiICxouZrztvdN
	0BoVBoi1OJIsrFh4P1u5VN54/tFfIGPJYWNhNMwOVgn4LGc+9eTstJ3GwEYhaxAM8vPSr0d8vjoNA
	d40+GQV7E0j+80SdhRzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVq-000000024f3-48eB;
	Mon, 16 Nov 2026 11:04:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVp-000000024eC-362R
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E90846273;
	Mon, 16 Nov 2026 11:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212F1F000C4;
	Mon, 16 Nov 2026 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827077;
	bh=726hiCwS88TGvIdtuykXMk2SiBm2dzdYT7UT/Qe3T98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H40xH7L57ZEDZz7B+7LIQF2jQ/Xf2m6GTvcanzWxjnL8UjfgFbGG1wvTlstwfnipJ
	 ZYebSMKBzmZ4lwUKVPoyrje4WPuxGo8fOZdjd+15EgtH3bMNTghsrUXngiXAgFqzZ1
	 pZwJVWhcEcC98kYL8ck/smYBHqAxlI1bHYT9ln4mAiXwnlFbS59vZ1cSlr6ZyWyZs4
	 ox7gdEb7OhR1T31Ob0agig8q65ON49URlthX+/fmJ8vcVD4xmOaKi12A9/SABvO1f4
	 99quiZTKYHLD/hQUzWM8QBKgH7c33XxhL1hel5yYqVPAxQUW2opEv+dPb3VNq2Xdcb
	 oARYOOtu/aLQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:43 +0100
Subject: [PATCH v2 03/17] fs: add file_write guard
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-3-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+PyXE2DjqfV9gzlbEjY4C40DfRKNqWnhjaRkPLLRvfw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqx49Vsiy3qXgJnHLG4vF3+7/MXDMA73M86Pi61+p
 f4LTD26s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAim34x/LOaP0mtdX066139
 16Y3Ocv/HbjhHpEcfKUprlagUVK87QwjQ/+foMaVL3U4n82qbtl0UpF/b5q3UtnZb1fCBDwzb31
 w4QYA
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

Add a guard for file_start_write() and file_end_write().

Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b66a09fb686a..c156a326e8c89 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2782,6 +2782,11 @@ static inline void file_end_write(struct file *file)
 	sb_end_write(file_inode(file)->i_sb);
 }
 
+DEFINE_GUARD(file_write,
+	     struct file *,
+	     file_start_write(_T),
+	     file_end_write(_T))
+
 /**
  * kiocb_start_write - get write access to a superblock for async file io
  * @iocb: the io context we want to submit the write with

-- 
2.53.0


