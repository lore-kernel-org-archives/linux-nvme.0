Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548D606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=umCdi1ky;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoFWaj8p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NDK6iLGoU71raS2SgqQLHOQWV8qCulebQnSVWkxP4N8=; b=umCdi1kydgQSlV
	sGqpIwQoHhfcMhIAvRqLk/e7VMDX7RDyFrKTqLAaxtJEeujtHSZHZ6o5Jh5jkVpZ3nAiilRjieCA9
	woWfkIjVG2NMPyTA6TrSS2jEbJAAKaIFEngbonwMNRkak05apGb8FZqQemRph1TNHo2fWgrSTshX3
	/FL2f2iSfJpMwDHtPxbWWjkI+wwpnUOp3ZNNdI6q/0hG/fyta2wTpqmrK0pn0opTkboU7DH5QXIT1
	wVzF5YN/FPNikbbCaGcDCk6E0zjNxoadsjGZoCiOSvToQ4+02xJiZA+B2E705+8fZ7csySMrZj1IS
	Oi+5YZO0d7J0Ag0UUg/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFa-0000000GCAv-3Ng4;
	Sat, 14 Nov 2026 13:57:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDVm-0000000G4m7-0PNp
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:09:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A0EB627AF;
	Sat, 14 Nov 2026 13:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26C1F000C5;
	Sat, 14 Nov 2026 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661781;
	bh=NDK6iLGoU71raS2SgqQLHOQWV8qCulebQnSVWkxP4N8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hoFWaj8pvuO5W4IMFMMHBQHXMNLjNH8JHfJrDEmFAYaD9asZ5QMfu4dOUECaNFmWb
	 f5k0eyP7Kyys7O1qt1H853aLKDmH4CIdCdqekph1EhrZbDKl0mxNkgwIVT9HDOt3XC
	 O3bGQDa7op33lAEoqksi8s58BT8ulOMAO60OcbJMkq0yL+u5csuTYRPB7smWs86ksl
	 ospRai6EuGNd+GhCYkKlfBdmljxPJpsYewArnoRX5o2L7xJTjyoZG5c+NVbvTvPVPv
	 JUbdkCHF4KynQMxadnOeQj/61m6YmnVQxmfl/9pKanW0zQl5nFhfpaBX+TBYt4fp5N
	 X2KWpck2qoGkQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:16 +0100
Subject: [PATCH RFC v2 35/42] zloop: refuse zone files on pseudo
 filesystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-35-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FWktvag3hP7CxJ2aHsFycQWntpQ2NlX5K0UkpLEDOgs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iOmTbNEV636a62R6kHG9SdDEX8xMuUodXbnngjbwb
 l/iW72lo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJWJgz/E+5wxiw8Ms/ho0RZ
 slhBp+vsmI/Z9zf941dJmu0vfvbnSoa/svdmna/i63v7pKntle3q1EqNfZxyTU7nC55fEOXNvXy
 KEQA=
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

zloop opens its zone files by name below the base directory but a bind
mount can put any file there, including a procfs or sysfs file. Refuse
files on pseudo filesystems as zone files just like loop does by
switching to file_check_backing().

Note that the helper only accepts regular files. So far zloop took
anything with ->read_iter() and ->write_iter() as a zone file. That
includes character devices, FIFOs and block devices if someone put them
where zloop expects a zone file. Zone files are created by zloop itself
and zloop truncates them to size and to reset and finish zones which
only works for regular files. So refuse everything else.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bfc..6f79b9ddbbe00 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1132,10 +1132,9 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		return PTR_ERR(zone->file);
 	}
 
-	if (!zone->file->f_op->read_iter || !zone->file->f_op->write_iter) {
-		ret = -EINVAL;
+	ret = file_check_backing(zone->file, FMODE_READ | FMODE_WRITE, 0);
+	if (ret)
 		goto out_fput;
-	}
 
 	if (zlo->block_size) {
 		ret = zloop_get_block_size(zlo, zone);

-- 
2.53.0


