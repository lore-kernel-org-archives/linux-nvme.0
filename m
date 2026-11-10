Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB49606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k6aJ7tgg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT+iOXhf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XL0wpOwuozhlRhYNz0JipJ6kxKX4QenBWX0X6ItK/K0=; b=k6aJ7tgges4fQR
	h8tyyOTRjPUblw2+VS3Gjlb5e201JLo3O82Eip7sisIz4bRmwiJxnYnuJ/hkFzdf/St3741TmM1Cr
	Evq8BvUSyNYcWm7y2XYYTEHGwU1mFG6RZwWmXR/CiuW6FuGaXCCZxNu+gcZLRxYBWYXJDwGHWNY+w
	G2F4ZS6Rr5qXgX0IG4YOaBgAdPASuM/cNW1olG+DeM8m62j/CQEynbhQv2XULW+MjztcRSTT09BC6
	Cxp1EGNVOWwBAWQF5NBrEcl3rFzLspEYJpDklOf+TS8bEx97nOdln59+Cn6+HKQ9ZQFdylwJPJQgI
	7Lw4fkQUGmUkTY8rv/xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhJ-00000007k0I-02U7;
	Wed, 11 Nov 2026 21:17:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi11-00000003Ena-2m5W
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5BB224087D;
	Tue, 10 Nov 2026 09:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A91F008A4;
	Tue, 10 Nov 2026 09:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302383;
	bh=XL0wpOwuozhlRhYNz0JipJ6kxKX4QenBWX0X6ItK/K0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CT+iOXhfdXS9EjWhCPxyMwbc6qpk2mfT/FYG65nH7AnMeSTgDu4gtnvPph9s+gyJQ
	 ZvCsMu20agRk/DN1s3jOLTDIaiE9C33mbBH7UBmpmq1UA5VoUIzICSYA9Tg4ndMgTH
	 NUHn4RW/Rt1Efr1DcrgvT2Czb0YSTQrx0YgABhREHnhLrge2ohMdRAEXc8ARjQ95GB
	 N91PcDylNuNGgoO+A1oWCOdoVMTmydTR6bkBvDN7xjUC6o/rf57lsPcqiLH9lVYbog
	 fqTRi61Xug5bUX+nw+zLWjcrBruwnR9lQKJTUUtPpS/C/b7PBRlfrij5xhG51EYia0
	 M4TkDbL2tSeqg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:49 +0100
Subject: [PATCH RFC 33/41] fs: add file_is_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fWtwbOqSVGrzkIOODqoKjdbZebK5p812wmLNWmDsq10=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDr3MIVGoy6T1c42Fn1zN66UCnoG5vsrbwj8gcLt
 77hOtpb11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRhFRGhmevWgXzbBfJf9i+
 0PPiiVlFPwKL+Fc/UFjp/vmC/tGfMw8y/FNqqr0U8TxATPOxjuYj+fU+8bu+/uDa1s7jnDCrjX2
 /FhMA
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

Add a helper to check whether a file is a regular file on a pseudo
filesystem. Only regular files count. Device nodes on pseudo filesystems
such as devpts, binderfs or the block devices on bdevfs are what they
are.

Look at the inode that actually provides the data via d_real_inode().
overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
securityfs as lower layers and reads of such an overlayfs file are
served by the file on the pseudo filesystem. Checking the overlayfs
inode would miss that.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/fs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..407ffb6342ec 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2553,6 +2553,18 @@ static inline const struct inode *file_user_inode(const struct file *f)
 	return file_inode(f);
 }
 
+/*
+ * Regular files on pseudo filesystems are kernel interfaces and must not be
+ * used as storage. Look through stacking filesystems at the inode that
+ * provides the data.
+ */
+static inline bool file_is_pseudo(const struct file *file)
+{
+	const struct inode *inode = d_real_inode(file->f_path.dentry);
+
+	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags & SB_I_PSEUDO);
+}
+
 static inline struct file *file_clone_open(struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);

-- 
2.53.0


