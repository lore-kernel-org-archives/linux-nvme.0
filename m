Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9A606A332
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=voEq6lSi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqGsamIv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lnImahtJn5lfCdVuO4byE9DJbFXiWtZ50f1CyF0t2Q8=; b=voEq6lSix4rubM
	Ikji7DRkSbLC7j8xuwtDtb7J1AjoxXFALuFiGRA2jiHWsp3Jj5ZmBILW1XlU6/EPftLYSmy5derg0
	fKA66v2fgKB1ijX/X9CjyUibmsDxFCDAE/lsl4QQqUANHe7bpiAtl13pklKrMwpNHm80Z4KVojq+W
	OnU7fO/WJA96sLfE2nk24sL0svvjWHSfKg80XJgRTMRFks2h1VPtph6RiFE2rvvj8gEZwNNO44BdV
	hUhZVfoOaINPi0IhlQv+Y3zwx5LwkdGvffiIeHYI7KMIs+Kk1zfZqvf5Su1rAYIKzVrvGhxtp2YXZ
	R8285ZrFS1X//PiHRNZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhJ-00000007k1Z-26Ud;
	Wed, 11 Nov 2026 21:17:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi18-00000003EpU-3bKn
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FA0563819;
	Tue, 10 Nov 2026 09:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DA11F0089F;
	Tue, 10 Nov 2026 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302390;
	bh=lnImahtJn5lfCdVuO4byE9DJbFXiWtZ50f1CyF0t2Q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WqGsamIv3dtdaZQphHLu2DsjqE2y3/FcP3C64OYa+8HjMiTSq+RUo0e7SVbClrF0O
	 Rn64RbDtjIQ3O+Vwx+jQosyxP133oDpbH9LaXZygD1MM6NsgOa8bfIBMBWinhY4voF
	 I9LMB4dtUD9EnoSvdxBHOJx1kUnEZi+cO6zl0AnUxitmo0r0cS4AhTxoDqU/IE3/8N
	 uJ4rAQbKeN2qr/1Nlrm7L9UeP+8U9vKXU8KBqCqhmY0R54patPnEALsIObSrmc3hKW
	 Bz6GWE9fyD5MsVicN0uDrDB/5zSB2xN3jmDYfNnm8pkYJ/yFyaHVRy4YEgK/zJNLVt
	 IxoVCfI/XEEcA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:50 +0100
Subject: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
 backing files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=brauner@kernel.org;
 h=from:subject:message-id; bh=chnbD225AeAwL2r22LyY9vS4RRPeXQFSJ1x6B/QmHi8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erD71lG1GUFqk8J3zhE9HKjc6rfqomb6Dp9nHvd2b
 viaPiNickcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE7v5lZPgek5sy6Z/MydVb
 5OSibJ/WcXMc/DFdcI1ZQY3Sv+l7b1ow/OHYs+VfAseimIV2yX857n1k8RKW83f7u2n9y0MtbJd
 Ss1gB
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

Currently loop accepts any regular file that implements ->read_iter() as
a backing file and any that also implements ->write_iter() as a writable
one. That includes files on procfs, sysfs and other pseudo filesystems.
For example, /proc/kcore attaches read-only as a loop device the size of
the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
attributes attach read-write as 4096 byte loop devices. Writing a block
to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
changes the THP setting.

That's not just nonsensical, it can be abused. Loop calls ->read_iter()
and ->write_iter() of the backing file directly from its worker which
runs with kernel credentials. But pseudo files enforce part of their
access rules at read and write time against current. Dozens of sysfs
->show() and ->store() methods call capable(). Behind a loop device all
of these checks are done against the loop worker instead of the task
that opened the file. And setting up a loop device requires no
capabilities, only access to the device nodes. So on v7.4-rc1:

- uid 0 without any capabilities can't write to /sys/kernel/reboot/mode
  as mode_store() requires CAP_SYS_BOOT. Writing "warm" through a loop
  device works.

- uid 0 without any capabilities can't read the files in
  /sys/firmware/dmi/entries/*/ as dmi_sysfs_attr_show() requires
  CAP_SYS_ADMIN. Reading them through a loop device works.

- An unprivileged container that was handed a loop device can't change
  gro_flush_timeout of its own network devices as
  gro_flush_timeout_store() requires CAP_NET_ADMIN in the initial user
  namespace. Writing it through a loop device works.

The same goes for hard_offline_page, the md and sd attributes, rfkill
and others.

Refuse files on pseudo filesystems as loop backing files. Note that
file_is_pseudo() looks through overlayfs so stacking overlayfs on top of
sysfs doesn't get around this.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c96e35c3ef42..1482580a1979 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -537,6 +537,9 @@ static int loop_check_backing_file(struct file *file)
 	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
 		return -EINVAL;
 
+	if (file_is_pseudo(file))
+		return -EINVAL;
+
 	return 0;
 }
 

-- 
2.53.0


