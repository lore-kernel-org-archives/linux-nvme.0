Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F25606B480
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kZD6yfLa;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAmKiFKv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vlnGjiz0WitO6a++5wfKz3FIFE4QfP7og6wENObjkjQ=; b=kZD6yfLaPwOeu1
	Vs8KZrlVtUYmn7ccx+nyeJ9WccrBE+tYAqToILBw4vA95R9wriQqaDAZyfdA+8H3Zg5hUTEPG0CaF
	vn1ByIzqA6ipxd9Ep/p8FO0eqaCj1Q56M5L0CAMfh/HC4eLXc2BuZVPA4QIa5qdj+da8WGtFWnWrD
	RHm5F3yaZ0FqWucLO5K+Jri+nkSZqFfy3B0FGPk5tpdrGhO/v4jS6Qa5OMITOsTxN3yZM36nB+6Uz
	n01Kp9dmVTVEIZYoY4ytrFuHtwTOI5Tfz+VykH98F8qtKQv8PmB/GMlp0OzpBSNriUG/KnKORxIji
	KcTkL9rCjKNFXWxUUvDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJE-0000000FpQ6-0c86;
	Sat, 14 Nov 2026 10:48:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJC-0000000FpNv-0rcc
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 50ED34376A;
	Sat, 14 Nov 2026 10:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A31F000C5;
	Sat, 14 Nov 2026 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653313;
	bh=vlnGjiz0WitO6a++5wfKz3FIFE4QfP7og6wENObjkjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YAmKiFKvxF2dqJ70rHRHIFzWFOSENglPJ7iVVtlJMeJPizgjDyjwhj1/ROXABd4Et
	 bS2LB9Ar8T/0BNx16VCKlFg2fabI/kYgKN6KizzxYI5hiXrnQTHWsqMD/vVhp0iJw6
	 BSh3zGBgjYZNG2gGvg840yNfMmHJsvEL8e0NiGtV60KvyTSoQnhMOfIvmGvHR/12L1
	 6O92HQnZ5CbQImtytcFhNmkbwvgKXh/wZFcE7DrlN8z5jJwVu0pRBV+DH48kGKy4a6
	 uhb9TA2ol473UTjKLxFsdZUDTZPbBtK2UOzRFmB4BQI/sDP67dC+HHuUTOorpen3/E
	 JmS8GlEYJRJ6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:19 +0100
Subject: [PATCH 12/12] nfsd: take freeze protection for the truncate on
 open
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-12-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d7TUoTxYNm2vxq8SD7MXgIqBY32W95I8i/PEQ3ekloQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sPFiW6704Ye5dNmFuomL3BbsvtPb+kPxGdPsVa67P
 7o82+3+p6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi174z/LMOSc6Mqtz59FDO
 3c8h5icXPbZ7tY73LsfkZuud07ee1rvEyPBrFbv4LU3zRP5kzytbKn/yzmRlu/9aLmLORO6HIS/
 6wlgB
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

An OPEN that truncates an existing file ends up in nfsd4_truncate()
which calls nfsd_setattr() on the already verified file handle. For a
verified file handle nfsd_setattr() leaves fh_want_write() to the
caller but nfsd4_truncate() never takes it, and do_lookup_open() has
dropped its own write access by then. So a freeze of the exported
filesystem that lands in between lets the truncate modify a frozen
filesystem.

Take write access around nfsd_setattr() like nfsd4_setattr() does.

Fixes: 9f67f189939e ("nfsd: notify_change needs elevated write count")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfsd/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1de6c6d757c3e..e561903b9180f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6681,11 +6681,19 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &iattr,
 	};
+	__be32 status;
+	int err;
+
 	if (!open->op_truncate)
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &attrs, NULL);
+	err = fh_want_write(fh);
+	if (err)
+		return nfserrno(err);
+	status = nfsd_setattr(rqstp, fh, &attrs, NULL);
+	fh_drop_write(fh);
+	return status;
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,

-- 
2.53.0


