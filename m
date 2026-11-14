Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9EB606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PaooLdYi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAVzUn3Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=E39AX+G/jh7TUAATD8FoQ3LTHbJD9uA3ozmx0gOpFaM=; b=PaooLdYiwXBdfy
	YCUlFi3OJGnW1L29zaWj7gzVHSYjOweh8Xi/f4QdI3ojlfE/WyQReS9XbsJSqKGt63ErcMl47PN0q
	eoc26vWFYoHIQk6r41w/wwTi17ViJGWxclwmu54WgHpb9fqBa/0RGr3yujujuX1nW/DLzTtDkcyC0
	/JN042g/8sSGe9VbFxmjS3q/isTG+pPytyDzlua//HZMZdz86uKGPzmZfhHVTmD6/HReuczhPzP7v
	qcryVNH0PgCAsR6I6vTb7WgfWrUGqgr/OadbFf4ex51cfVfpxbGIj3vie2pYYGowRoj5knytj61yc
	L0Viean8Aw5dy4hKDIPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFG-0000000GBDd-3Rx6;
	Sat, 14 Nov 2026 13:56:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDS3-0000000G3aI-3Af2
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:05:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B31E40C46;
	Sat, 14 Nov 2026 13:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C8A1F000CC;
	Sat, 14 Nov 2026 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661551;
	bh=E39AX+G/jh7TUAATD8FoQ3LTHbJD9uA3ozmx0gOpFaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RAVzUn3YihPEfR8QNXiJZ4kO+0Ww2rPP5SABGZnl60hGUL2Z0RR98pxZaO/RoCDhp
	 vFYwvxbUW2TAi/HXFTMH17UIgslNBpCFe+PegPbRAYGSEPrqXonsLU/7Mi83e0RghI
	 czwaB96M9lWGq2+Bal8IV3hGZe6UTMGaixjoty54b98sTD+UZ2KloakvmTGKcP2Jtj
	 qKh6CkT3Y7cwABFcxmNSwVcEj2qVq/VdVxme/wkozCtmB2Ld1vYY0zFO17PwNCJ9q8
	 9qOOW7IJz3w0BfWgmHzKZBLNseME+eb0Q9TOZs/6zDxRI/611bKgvwwKnGnKZ+bkRy
	 yOh/Udy9zGjgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:43 +0100
Subject: [PATCH RFC v2 02/42] nvmet: check that the file backend supports
 ->{read,write}_iter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-2-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=brauner@kernel.org;
 h=from:subject:message-id; bh=//ir9fc9dMVqltiEAJAlWV+b7M4aWVaisbvAL6AhlSg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iMn4JfhIyMuq+MC8pis+ES5tTa9bd7/WXjzJ/vXPK
 QH3uOszOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbys5OR4c7lBycqbVyqBPoK
 F7087SO3W5fzvW6nkVvw5Mw915xkFRn+qe1OU1wTfjyRac5dfqezqXvv/Qotu/+h6FShzocNC3+
 l8QAA
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

The file backend calls ->read_iter() and ->write_iter() of the backing
file directly but never checks that they exist. Everything that isn't a
block device ends up in the file backend. So a namespace pointing to a
file without them calls a NULL pointer on its first I/O. Only
buffered_io=1 gets that far as the O_DIRECT open fails for such files.

Refuse them when the namespace is enabled the same way zloop does since
commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
->{read,write}_iter").

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932ee..dfa8aa46188c8 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 
+	if (!ns->file->f_op->read_iter || !ns->file->f_op->write_iter) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	nvmet_file_ns_revalidate(ns);
 
 	/*

-- 
2.53.0


