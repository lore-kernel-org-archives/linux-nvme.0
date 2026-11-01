Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E29606A324
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Nov 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CCLJerwa;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S81lFJCp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=; b=CCLJerwafAkBepqwiCbvojI4Dj
	Em7S/R6EX1fwCA2iXhFsQJyFfM5HXJ1T2lSOfBgpI1QshJedMBYau8HWSTr3b/Yu00NTXf17ObFgY
	UkXVBljfr4aeTLQXMlwCiuHbL9byurR47yow5R3A0D5goeAIL4iPUTbcBH9sc1jttyC8WhvErH39c
	1mIKLUgUF76Q0K6gcMy84JgQGIarCN1mK1WE691bS+LE0IJW+qzr/4+0Gtez5XCKmtZ9pp3KOKwDg
	mldw5aKGPgncrjdJy6+r7wDPoqqpyrlPkI5Cb+J1cCTCtIb8IMkwtZgIZoTAowAnWluyFf0BoKQ4b
	Nn+8+dfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNZRf-0000000EiUP-1nTw;
	Sun, 01 Nov 2026 17:34:15 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNZRc-0000000EiU4-3RJC
	for linux-nvme@lists.infradead.org;
	Sun, 01 Nov 2026 17:34:13 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-369f33df08eso4619652eec.0
        for <linux-nvme@lists.infradead.org>; Sun, 01 Nov 2026 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554451; x=1794159251; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=;
        b=S81lFJCpR3cXXPjsBVVStmQkIjmRjTL5mFHzTLdboiAVwbSA6rRYRVKWT6tBWE3D92
         05JDsdWeuMfPelsYXRZ3WfA3n06N3k8SO3vXrC731DmqoVIn1L6Y4DccB79LFVUsas1k
         vQYPaCrqO+LYxF2z+eM2RE+goVD5LXVGB/P+CZ1S+VhiERbGegyuDYi0+GRBD2nFwjCe
         X3nBmubITBBxkZY6EjIokbDKUCxlimr4+n0nAfxqN6fOFTmHuLgmGBeLEN9feBcvrYFJ
         2J2qkL7ywWiVM2AMmBaaF7FJcGfDCUm3ZXvYogxPrjYRMnKprxR0UyrArpamONg2h19s
         np9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554451; x=1794159251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=;
        b=feD2GLIL7lkimhXMGGQ1G2OIaHkzAot2QXeVthgQwyx9GsLU7b15cTC74pHOjzMptl
         Soz4gkDdRTQwTo+RFIus32iq1qhT9WiAz+pdjga0f7PVJi/lGUGIoOd3lz71qatJg42a
         Y2KIBJGCVxWk6AN8NnIs72tZXedbC//nW4GiXFh6gLePSUdZXTID0az88ZXimvfxh0E0
         1zS5FhoqKA4czWlZ0JE0cEbUDmuFVKyGSHljObL10mH08donWmUPTh59qK/P2edkWpuk
         P+b2Xe6zsF4ntYCz+Bu/aQdIgnO3mf5ROBMyWYG56JiQL0zq2AUEc6MTVv7od8MVctbE
         YOLQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8K3f+AwQ5H7EBwVP1XV8eZ649WvNUi9NWkanb/wACKhN9SnBk7Tm5LScEfrLH1SOKGbh5oIFfXQts@lists.infradead.org
X-Gm-Message-State: APuU4Z8xe4oYGrrgItZYmzH4FD2/QPtZ60V0SxsODvJNr4jdQub6feVK
	WykuOYcGn+FACbtAwulEdCLycKZ7EwIxBhNOxO3aIRMk4YV3Mgwn2qBO3ZtBGFhzCUw=
X-Gm-Gg: AYBFou2Po+ax64rySqZwbG7yHaHd+iLSnJrOKhola8zjOTUBkcnxd8xJF4MNyIBdhHj
	QD2AZnxd/KYKF4vZXlPRZkC03YeIap5TWnikAZKG2uk5J3wzCKVe7gaZy3k4f4WvBCeNpZ3G/tb
	IxS5cdthal0uLg9so90SYZLmHCyaizUmnvluDNGutflZsKzCU2GftMdKwke4H1PjAGID3Gt1OgS
	5j76DhBBq1chUqteKhzfaIuzMCcE66RV+qD6qaptAPd72cgtLKmAAKuEbLqkS1deA1lVYBMQZ70
	0ShUcIufmQOvhmMHU9JS2Y20jNdzzZUHuyrANZ3bpAD2p0pdDR3JsP0bFygldhzXsrEEITv4IFE
	fmoxKxTbfmOxOfxK9vlWpt1RwIYSVuu7wTuqi2eijunXDOa6oeLi0syQtDpyuCl24QFDlncGya/
	EoG8uj/JqtWnk4hFB1doKKOWbns+DFthdH+tTeZDZ7/4rTvygVpaLZQoOS0UfvF2zJBhhY8/R/5
	L1y4EimjTyuPcDfWjsN2WPxMGXo/j2hkSoXy+3qe9xtlDOPbS1gECE+SCjuNLn9uch2pxn2yBY5
	TIWL54Pa6MOULwHtSQNcqfzzrhqg7Vj0PpvIjK6hTpA9I0uBXgDwgK46pA+x/bioFQ==
X-Received: by 2002:a05:7301:6194:10b0:369:f937:9a7a with SMTP id 5a478bee46e88-36a42437876mr12357251eec.34.1793554450978;
        Sun, 01 Nov 2026 09:34:10 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm25450066eec.5.2026.11.01.09.34.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 09:34:10 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: john.garry@linux.dev,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvme: Do not drop the cdev reference twice when cdev_device_add() fails
Date: Mon,  2 Nov 2026 01:34:00 +0800
Message-ID: <20261101173400.98931-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_093412_861196_E1E4E593 
X-CRM114-Status: GOOD (  19.85  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
namespace (or namespace head) before calling nvme_cdev_add(), to be
dropped by the char device's release, nvme_cdev_rel(), and drop it
themselves when nvme_cdev_add() fails.  But when cdev_device_add()
fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
has already dropped that reference: the caller drops it a second time.

The namespace (or head) is then freed while it is still in use.  With
one allocation failure injected into cdev_device_add() for a namespace
on an NVMe over loop controller, deleting the controller gives, with
native multipath:

  BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
  Write of size 4 at addr ff1100000a4ea078 by task init/1
   nvme_put_ns_head
   nvme_put_ns
   nvme_remove_namespaces
   nvme_do_delete_ctrl
   nvme_delete_ctrl_sync
   nvme_sysfs_delete
  Freed by task 1:
   kfree
   nvme_ns_remove
   nvme_remove_namespaces
  refcount_t: underflow; use-after-free.

and without it, a use-after-free of the namespace in
nvme_mpath_clear_ctrl_paths(), the namespace having been freed by the
last close of its block device, followed by a general protection fault.

Take the reference in nvme_cdev_add() instead, right before
cdev_device_add(), so that it is held exactly while the device can be
released, and let the callers neither take nor drop it.  The earlier
failures in nvme_cdev_add(), ida_alloc() and dev_set_name(), return
before the device is initialized and so before the reference is taken.

The problem was found with kbound, a static analysis prototype that
checks whether callers rely on an object after a callee returns a value
for which the callee may have released it, on v7.2.12; it is present
in mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested on QEMU (x86_64, KVM) with KASAN: a loop target
exporting a null_blk device, connected through /dev/nvme-fabrics, with
failslab failing each allocation under nvme_cdev_add() in turn, with
nvme_core.multipath=N and Y.  Before this patch, every failure in
cdev_device_add() (7 of 7 with each setting) gives the reports above;
with it nothing is reported, also with lockdep and kmemleak, which
finds no leak either.  A failure in dev_set_name() gives no report,
before and after.

Fixes: 9952f3882ecb ("nvme: fix cdev lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on next-20261030; the code this patch touches is the same
    there and in mainline, which it is based on.

 drivers/nvme/host/core.c      | 13 +++++++++++--
 drivers/nvme/host/multipath.c |  2 --
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af71d02b8476..f9d23e9d35ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3978,6 +3978,17 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
+	/*
+	 * Held for the lifetime of the cdev and dropped in nvme_cdev_rel(),
+	 * which also runs when cdev_device_add() fails.
+	 */
+	if (cdev_device->parent->class == &nvme_class)
+		nvme_get_ns(container_of(cdev_device, struct nvme_ns,
+					 cdev_device));
+	else
+		nvme_get_ns_head(container_of(cdev_device,
+					      struct nvme_ns_head,
+					      cdev_device));
 	ret = cdev_device_add(cdev, cdev_device);
 	if (ret)
 		put_device(cdev_device);
@@ -4010,13 +4021,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 {
 	ns->cdev_device.parent = ns->ctrl->device;
 
-	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&ns->cdev, &ns->cdev_device,
 			&nvme_ns_chr_fops, ns->ctrl->ops->module,
 			ns->ctrl->instance, ns->head->instance)) {
 		dev_err(ns->ctrl->device, "Unable to create the ng%dn%d device\n",
 			ns->ctrl->instance, ns->head->instance);
-		nvme_put_ns(ns);
 		return;
 	}
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56..ae8059366b57 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -681,14 +681,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	head->cdev_device.parent = &head->subsys->dev;
 
-	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&head->cdev, &head->cdev_device,
 			&nvme_ns_head_chr_fops, THIS_MODULE,
 			head->subsys->instance, head->instance)) {
 		dev_err(disk_to_dev(head->disk),
 			"Unable to create the ng%dn%d device\n",
 			head->subsys->instance, head->instance);
-		nvme_put_ns_head(head);
 		return;
 	}
 	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0


