Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D5CFF885A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4Sn0Uz7C3eCLnaBIcGNIfl1zUDw9GPLIKPhW/M1Vxg=; b=KmShRJVsvrSl1gM0vCHaWvXIW2
	Ouo1P+EVofiGuKtvqERRryihU+k2bAb4KWor+Cl6Ml293mIDhnaQDz2M5PGEHFDMToBE/zScZXyyZ
	9x2zFHBgtkMy57ZAKdG1B5nmtYRPLHTIpSQWDCrUXZ4AfVQj0RLauSTx15J8ZJGSnApe2loJ3yw9J
	mmhsSlEq/9ht2D0TKHQWnLxSOBTwMMsgM3E2kx6fKgLTPrDwOpe2ALHIoGdcMkvQPj4T5jczoCP7e
	Ed32vXoNM3tFcPn4W4oprHr7NzOTRlVfJKEd7h68VASnsWAE1H62+oezpseGvuGTcrUmVH6xNYPTE
	syHrgtgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEN-0000000DpoG-3wRS;
	Fri, 24 Apr 2026 22:42:39 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEK-0000000DplB-0VME
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2Sdl6qHkz1XQmtj;
	Fri, 24 Apr 2026 22:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070549; x=1779662550; bh=M4Sn0
	Uz7C3eCLnaBIcGNIfl1zUDw9GPLIKPhW/M1Vxg=; b=pt4+D8Qj7X6MJ7nHuhssD
	sYl351Aj1OMODaqbj+TntAA1Lwxb9V/Rqgcafvt3louxmvbrJWhLBKCrnNqFjN+S
	YBySRkVQ5UqiMliEmod3wt15o7m1cA/39Qb7qqM5+9IkLh9TqXuIKqePk+q1JI8b
	MEYE49l82YJOnS7WL0jTEN7TCfn9ubfwBHGQY+JNpaJgxKRDS4YnLx2kNZOzSplk
	Z77yTPnGsU8NjfKygHC2qdBJYv7AU5MuIoah7A6yE/DXvnAL8VollsMS7DIyPnYw
	t7W79i4s0gziLRp2Tgqve/iwYQ6EzBZcma5HRWskCAxktvtFQhD+G74j8gPoEoz1
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Sy708VsVJXAT; Fri, 24 Apr 2026 22:42:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2SdX4pb7z1XLHZJ;
	Fri, 24 Apr 2026 22:42:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/12] fs/read_write: Generalize generic_copy_file_checks()
Date: Fri, 24 Apr 2026 15:41:55 -0700
Message-ID: <20260424224201.1949243-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To: <20260424224201.1949243-1-bvanassche@acm.org>
References: <20260424224201.1949243-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154236_201990_8518B0FD 
X-CRM114-Status: GOOD (  13.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anuj Gupta <anuj20.g@samsung.com>

Prepare for adding copy_file_range() support for block devices by making
the following changes:
 - Change file_inode(file) into file->f_mapping->host. Although only one
   inode is associated with regular files, two inodes are associated
   with block devices. file->f_mapping->host is the primary block device
   inode.
 - Change S_ISREG() into S_ISREG() || S_ISBLK().
 - Add an inode->i_mode & S_IFMT check that verifies that source and
   destination have the same type (block device or regular file).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
[ bvanassche: rewrote patch description ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 50bff7edc91f..d6fba5afff94 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1484,8 +1484,8 @@ static int generic_copy_file_checks(struct file *fi=
le_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in =3D file_inode(file_in);
-	struct inode *inode_out =3D file_inode(file_out);
+	struct inode *inode_in =3D file_in->f_mapping->host;
+	struct inode *inode_out =3D file_out->f_mapping->host;
 	uint64_t count =3D *req_count;
 	loff_t size_in;
 	int ret;
@@ -1791,7 +1791,9 @@ int generic_file_rw_checks(struct file *file_in, st=
ruct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) !=3D (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
=20
 	if (!(file_in->f_mode & FMODE_READ) ||

