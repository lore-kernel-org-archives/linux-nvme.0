Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA51606A336
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3mkvvIz8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIJ0bZ6Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5v6oTkZQz6qlfBhdJSuXnvnO8rYqx/rzC+7+Nl5/OGM=; b=3mkvvIz8Qu6Z9d
	TwIbqLHJreuHDxfDHn8EG20plPtYSVs33aEb4k2Fgb1T+ISGqYf40cdz1+avinUKjZIlyarQkdpwB
	1Y+rUb9oXqVXCLnnRnouV0VES1zJtDJzo31rxYsGMo+P7YymFWZYElRjW+42xrObQ2AR09tsBAdZR
	jCxJf+mfyvkxfIEl1trC1lZkLyLiJylare4dhvAXAsKjSiTXzToT2pH3LeY7ZWcBjgNbN7r9yba6r
	q7V7KiXFuMobDykR+NmLPWEYfIzNs0ilrM37L9e5M0KA4roXQYulYmhJD4leBwXs0XzwqKF3SDJYP
	brKG6oCCZP7NXhYJQeNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhN-00000007kEm-3wzN;
	Wed, 11 Nov 2026 21:17:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi1h-00000003F0o-28jD
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:20:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF33663821;
	Tue, 10 Nov 2026 09:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515E81F0089F;
	Tue, 10 Nov 2026 09:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302424;
	bh=5v6oTkZQz6qlfBhdJSuXnvnO8rYqx/rzC+7+Nl5/OGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eIJ0bZ6YykzyfYaq0uQnsLuPNj+m0vg4MOIRUUV7WyIHrzOWlMn5BpzKyvQO1xQnK
	 lIgHxLYXr0xM6gXAPduca8fCpGnrbXmRu3n7sX++lmrPokRdnMxOQCvAaieuNDey1/
	 rDMY2lnbcyTg88AQ5EnW+l0uOlH6KcCfGavMFZPvkrzrCwVDMo4o1H9usL4RbMeid9
	 8ju7v6AtrNpyzqVV8uy5DYhL2Vr+eLE/ymRsWc8pcaS97R4A8Z95dfIgLeSJCXVpWi
	 mDeT0clD8WfcFmQfLKdl3Rcurbo/W+eyqIPzNmzhefzjE4bnqF8y5kxjx80v9c4Gko
	 v/as+SN9c7AFA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:55 +0100
Subject: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5CZmEVUvUM8phb7GCUC0PbdIONUtutPPh5jN88b8MUg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9enDwpOymfbk/lix9c8OUO8H7nMDJjqNuYfXt8RN5b
 SZ7VM/p6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIsgXDP81qmQUMxt7JIhtj
 H769H+D76yOfp7vrv8Uv+XNqFL+3cjL8szGK7szT6zNcPi0pgC3zv/C19XHNGld3L/vwMHyKxLW
 bjAA=
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

fsg_lun_open() takes any regular file as the backing file of a LUN. The
file-storage kthread then reads and writes it with kernel_read() and
kernel_write() on behalf of the USB host. With a procfs or sysfs file
behind a LUN the host gets to read and write kernel interfaces with
kernel credentials. Refuse files on pseudo filesystems just like loop
does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/function/storage_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index 75831f2c7abe..83683ade20c2 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 		goto out;
 	}
 
+	if (file_is_pseudo(filp)) {
+		LINFO(curlun, "file on a pseudo filesystem: %s\n", filename);
+		goto out;
+	}
+
 	/*
 	 * If we can't read the file, it's no good.
 	 * If we can't write the file, use it read-only.

-- 
2.53.0


