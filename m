Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBC60A5BC8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C9fv0Rm+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUBzj8rd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=i8O0jdpykiNB8SwGgODz3acyFz22/17AhWFONkzhh/g=; b=C9fv0Rm+qP/te5
	Iu7EEgZnRhnJxsk/LLpMZVQWR+NI++vaOmKxBm4+Bet+8yVCRekmo/urFNv6VJWJY+l55OmL0qnc2
	RSziPNCEh/UyqSdymgWhOtTkEHU9ifh9E+tCnM8hYk59FIgSDg563ZrvVMkE8N9JUs9g/GbOqGNM7
	2HKfkJ5r/ScCvBRkH0Pacrj3L/GDTEJ+HP/hO8OCuAu0qW1qbwfWJSt17rWFUHGBdSqV9JUrH//lr
	z8E6xWDx7PZzsYRQlcK5JQqBcmLc/UusTSgqUQ0MzDTdEW65yO+bJ/J7JoRGZmrZ2Elbw/jWrq1cw
	Z0CnnH8kDXvlZdCtkmfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWS-000000025NL-2Wdv;
	Mon, 16 Nov 2026 11:05:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWR-000000025M5-3Oy3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 44C69628FE;
	Mon, 16 Nov 2026 11:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F871F0181F;
	Mon, 16 Nov 2026 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827115;
	bh=i8O0jdpykiNB8SwGgODz3acyFz22/17AhWFONkzhh/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EUBzj8rdNpxkagJSBg7wcf9wBRgmeYEHqgbMlEejIEvBFFBhnNYMUGGEHzxWMg0hZ
	 LyIBdubhmLQQF5f1+O8j7EHv+97DTc5JxXnBnnDbdRTkvNp7b6kCE2QlqKyr030qtf
	 ZQT0wfryidm3UcE4gPDS2XMHCUh9EnruAWBkQAHUEDYuvOvRBYzB7T6Be0mHdHhMK+
	 c5sNBl+ZGGpXlDSc6q3HMSHIgO8Duicz2lNKPHnUpz7zS5POXtG36hs2JFLFBaUAlL
	 qXU6IIaD/vqpkaktX5aVAaqYMeiv3ooKezFeHOWYRfp4nGGvwdNfxQAPXaxhd260nv
	 kahpjT8C0w64Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:52 +0100
Subject: [PATCH v2 12/17] ovl: take freeze protection when storing the uuid
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-12-ecc4a2aac40e@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iEqLSnloc6x/kvA8qf87o60wvCftihDv39CzS/x68mo=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGr64yvIYGRKYpcyDI7foAEx48sCbXXrr2tiH4XzGg+SJ4/Ha
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmr64ysACgkQkcYbwGV43KKg3gEAj87k
 b/pDhchb2tEdJEkXgBi6fLBU6mCmFqJ5E75UmgEBANAEc8kQgCTSmcKpnwq1Bk35rMwZLkityEE
 R25Yx9RUO
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

ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
upper root. That happens after ovl_make_workdir() dropped its write
access to the upper mount and before ovl_get_indexdir() takes it
again. So a freeze of the upper filesystem that lands in between lets
the mount modify a frozen filesystem.

Take write access to the upper mount around the xattr update.

Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
Cc: stable@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/overlayfs/util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 521717209b2e4..67aa7b71e9c83 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Try to store persistent uuid */
 	set = true;
-	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
-			   UUID_SIZE);
+	res = mnt_want_write(ovl_upper_mnt(ofs));
+	if (!res) {
+		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
+				   uuid.b, UUID_SIZE);
+		mnt_drop_write(ovl_upper_mnt(ofs));
+	}
 	if (res)
 		goto fail;
 

-- 
2.53.0


