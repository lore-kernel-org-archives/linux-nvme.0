Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F39606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C4bP0s+b;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFkCPZLO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=64fy1ZrurHksDYaEdeBVzwJEogDQqSWMHixC8IXM43k=; b=C4bP0s+bBGK3bS
	o5Il0v8pO7LhcwYp9r55eLfFjYQ71cPgN621Ge5USlrQk2PZPohT10+hEP+FDPN6YErmRDfTFbXp8
	d5rHFLWfO44iKv66MUiHMi/yNjmF18AMb+nExIVVHHWiw3rfIyBS/9HSnQ0M8Tk2omoHBuRHuEtIZ
	jqdOJtpLOUapw2g05bDmcRdppjHWT2ZJWzuMmqnc4k/c787JS8ZPcbQRK716oLFBCpPvj/pZaEz71
	k+lOg2nEwEP7Yfzz1Ya/6t7odwgEwhQabnY/dwW4Ds/8kce8yr2/MzQmVjwd9+l+02hSdsU1+KacS
	Z/jgBRuCZH1e/IXpNt1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzt-00000002Ol7-00gb;
	Mon, 16 Nov 2026 12:39:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSubD-000000027hw-3f3R
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:10:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E44A6292B;
	Mon, 16 Nov 2026 11:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483D51F000C5;
	Mon, 16 Nov 2026 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827410;
	bh=64fy1ZrurHksDYaEdeBVzwJEogDQqSWMHixC8IXM43k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XFkCPZLOyT6temTwAkvo4voI/JBsg/Z4henG9tv1l4AP+unIyDGq5gVd+SYbfTNkW
	 J2q+A4W9ncbFM3o2CJeB1KlGFOQOyWo8ySYnVIO/5YximXo+mSB8h+1obwLjCcGEvW
	 A1UXSeiotXqdUuyPaAj9hOORnO/ihLGR8bgH8DCMlnoWpdtPxHllMf91dA7wxs97Eq
	 yjHuVmibG1NowwYf+Q8JcoJLbSPOUKYKONh6M5SqznmTuA/gM7dxnMZNsRN9PfbJft
	 +J4kIRFgBCIHj5EPRzp5FFbIDcQ2AbpmpaJCmFvcccbVtq7fFVdRiQ+kdhPCTlwHV7
	 761XGVhpeq4Nw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:06 +0100
Subject: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo
 filesystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Smh6T1OxDytywEa5/SA4YQOn0qat/3OEFq2S8CKkHFQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9etzKv1zn0/fF8VbJ056U/V2j8fZ05/RKp3DlWuv16
 b/0c+MfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkkz0jw/FI3n9/PH4HhZ1d
 ys8rckDxnqnu2en5RiGRkRGiO5TUohkZnmV/WFDrXXLFbNEWtocf1uvk3Hommj2NYaaXF8OJCE4
 pHgA=
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

The data of a metacopy file can live in a data-only layer. overlayfs
doesn't look that data up when it looks up the file. It only remembers
the absolute redirect and looks up the data lazily the first time
someone needs it. So until then nothing can tell which filesystem holds
the data of such a file.

But a data-only layer has no business being a pseudo filesystem in the
first place. All it does is hold the data of metacopy files and the
regular files of a pseudo filesystem are kernel interfaces, not storage.
So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
mount time.

Data-only layers can be added via the "::" separator in "lowerdir=" and
via "datadir+" by path or by file descriptor. All of them end up at the
end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
of them.

Note that regular lower layers on pseudo filesystems are left alone.
Stacking overlayfs on top of sysfs keeps working.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/overlayfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 39d4d57dec230..719c2569dfeaf 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
 
+		/* Pseudo filesystems don't hold data for metacopy files. */
+		if (i >= ctx->nr - ctx->nr_data &&
+		    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
+			pr_err("filesystem on %s not supported as data-only layer\n",
+			       l->name);
+			return ERR_PTR(-EINVAL);
+		}
+
 		err = ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stack_depth);
 		if (err)
 			return ERR_PTR(err);

-- 
2.53.0


