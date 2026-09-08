Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0DCC79F9E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=80T2oZVVcgfFnia9V8I4pTBGAd79dFldYCjqWecVuOY=; b=YCuQmsKLFcIwx6ZcGQtVihwAlp
	8HkW/dfRtJXjuLwczsNQR44Bwhj7bRs547Sea0j6E9TMqZB9jHsvuVz9YuI377fJXHAdKEqGRDt7z
	hqxpT20Omqh1E9vgAJ/NvYhCBJ5L9Nx/2fMsy6BNYCv4lZFGZxVzKNGwsbLkDCtEkv7MPEIKo2lib
	lsUjd6zhF3mqKUGcPr/1n+5fPPk1NUi6EevtROg301DNF2FTzrBG2hUOC/4CDEVluQh+LopHhsEl4
	dIob+qasFA27hv8bSsQOvvOac4DT9vD2j2Q/OnxN6HNoSFzm+l/fM/vUF8CP4+xajQbeMUIIfK8UM
	huP4BITw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3kNt-00000007sfN-1DuQ;
	Tue, 08 Sep 2026 01:12:25 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3kNq-00000007sf2-3wTh
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 01:12:24 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ceab75934dso38187215ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2026 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788829941; x=1789434741; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=80T2oZVVcgfFnia9V8I4pTBGAd79dFldYCjqWecVuOY=;
        b=l/Dw04a08dLK63IyTI4BVOlJsGWYkuyF4bcqNoE1/c1+ekRUrmMth1pQGi3uoXgPqI
         9ZnwISmwaFr11wwfmmbDbtO/sw+zfQHj4ko7qeczU2vW19DvmGmR2a9tjLZi0t/yJhOl
         x67ZEnHacTnGMGrWvo/SYrucF4qpceS7KXzKTqqLRLEOw5/taZ7iO91pDD7W6FsZGiB0
         mlfKJ24uMeUciSG4Sck+JFKTbnh5tJWfc8m4mkoBWvG30PND9YpdK0magUh8rXmc8uLw
         Sy2WEOiOsNtS3EHiY25o02TIzBEUdWKtjn15bshzorWVF+kZo12HJoX3seqI81/6thMD
         fL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788829941; x=1789434741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80T2oZVVcgfFnia9V8I4pTBGAd79dFldYCjqWecVuOY=;
        b=TxSRSbAn39MdiEOZ4Ln6jV/1rs0mi5vaakXXIv/huw3dh7kvxc3AHzeH2Cy4TkF4dP
         TkvRIxCSO3W6qx2JmXIy6uvbtUZl7BFvZaEtV/ZAr525TxXiZcQH7GVp+JYgT/3ag3+7
         zu6h34En76kLCxCVsHGGUNyKXxAFddFTCOJV3sp8j6FpwXDLWxlCw7jV2N1eJ7AGmTKk
         WUlmpiSBljveb/TViin5tzSSmbuCftEY5DgHTsMdn1fpplNosomFIa8d0dTH+WaAYJZK
         AWsUP/y/WKcGUKGnxBQLHhh8wZkGtImoK71y0meEGFavFw24dNIviCtB2cumGLjJxlUC
         ekLQ==
X-Gm-Message-State: AFuF++m1z7NOb425S+OAbECCr/859K0mz9AXLzEK4QRhEhf315lV19av
	bD1HBk+n2HbV3R+D7n/66NiOkqyWP28tpvWzEmNCViLZcmRPBO2AL83r
X-Gm-Gg: AYBFou3S1g6AaD14NzlZmHdgrtZliFtHdHUo4/mTxDjD6EBGQU9B796i0utEbZqVTaG
	gs4YzsGovE1e3Eg8p+Epp09J1xZIizxAAvo4pU2S6xjUQNAJBRIZIYaIyMSpgazEBvvGhjS0Nl0
	d+6EShIK3Uh3h9gU8tiyZ5RpoWFGTahXTqCfM/IsXb2v0eK5srl2S4vAiewXBKPJ71FeEVtcpBR
	Xxcx8KZZig7rY2NqvjrdP5lV7q7V5/5nfZZYrfFcRT8XPwrY4SJn/95A9v0jglzStzUNmLMRxJ2
	lSIWOSBCcI8697CXKBQfzd4g2oJ/SaDKkIfTe1agFjgMBBfaFK9KdqxEB8VwXn6YDfFNGbi1vA7
	mYwt+T4msJngHZifalyoayUQfhZmCzAKbbVhyh5ElJm+qurW/8+e/JVreYamTNiTaAa6FUHDHfr
	2CPEiToHlp47RlU2vj5tZ7JzjEjskRvz+Fr58UDKMXJFIRLSldBvb4trzhShSCKrxeHgAA5tPZW
	PNKOe40L5glyCETFkp+tY2MOilQwOVCrv7WUp4xOajEFxP3Upk97lq6TNh9KYzKUQIzrA==
X-Received: by 2002:a17:903:284:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2db125ca396mr357386085ad.5.1788829940861;
        Mon, 07 Sep 2026 18:12:20 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d455sm51362855ad.30.2026.09.07.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 18:12:20 -0700 (PDT)
From: yupeng <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v1] nvmet: add cgroup_path to charge namespace I/O to a cgroup
Date: Mon,  7 Sep 2026 18:12:14 -0700
Message-ID: <20260908011214.11344-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_181223_028102_7FCFF3A4 
X-CRM114-Status: GOOD (  43.47  )
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

From: Peng Yu <yupeng0921@gmail.com>

Consider a server that carves several logical volumes out of one physical
volume and exports each volume to a different user over NVMe-oF.  What the
administrator wants there is a quality of service limit per volume: one
user must not be able to starve the others, and the whole set must not
saturate the physical volume they share.

The cgroup v2 io controller already expresses that, but it does not reach
this I/O.  A target command arrives over the wire and is executed by a
kernel worker thread, so there is no user process whose cgroup it could
inherit and every bio the target submits lands in the root cgroup.  An
io.max line naming one of those logical volumes therefore has no effect at
all, and the group's io.stat is never charged.

Add an optional per-namespace configfs attribute, cgroup_path.  When it is
set, the path is resolved at namespace enable time to the io controller
state of that cgroup v2 group, and the I/O the target submits for the
namespace is charged to it.  From there on this is existing io.max
machinery.  The association travels with the bio as the block layer remaps
and clones it, so an io.max line naming a logical volume limits that
volume, and a line naming the physical volume below them limits the total,
because the io controller enforces a limit over the group it is written in
and every group below that one.  Pointing several namespaces at one group
gives those namespaces a combined budget.

For a block device backed namespace nvmet allocates the read and write bios
itself, and each of them is associated with bio_associate_blkg_from_css().
Discard, write zeroes and the flush issued when Namespace Write Protect is
set do not allocate their bios here, the block layer helpers do that
internally, so those calls are bracketed with kthread_associate_blkcg() and
the bios pick the group up from the thread that executes the command.  A
file backed namespace is opened O_DIRECT unless buffered_io is set, so its
bios are allocated inside ->read_iter and ->write_iter before they return;
the same bracket around the file operation charges them, and around
vfs_fsync() and vfs_fallocate() for flush, discard and write zeroes.  This
is the mechanism the loop driver has used since commit d4478e92d618
("block/loop: make loop cgroup aware") to submit I/O on behalf of another
cgroup.

A namespace that has both cgroup_path and buffered_io set fails to enable
with -EINVAL, because buffered writes are handed to writeback, which runs
later in a thread that knows nothing about the namespace.  buffered_io is
also what selects the file backend for a block device, so this one rule
covers both.

The css is taken in nvmet_ns_enable() before the namespace becomes visible
to commands and released in nvmet_ns_dev_disable(), which
nvmet_ns_disable() only reaches after percpu_ref_kill() and the wait for
disable_done have drained every in-flight request.  The I/O path can
therefore read ns->blkcg_css without any further locking.

kthread_associate_blkcg() stores the association in the calling kernel
thread, so the part that is charged through the thread only works where a
kernel thread is what executes the command.  That holds for the tcp, rdma,
loop and pci-epf transports, which all execute commands from a workqueue.
nvmet-fc executes them in whatever context its low level driver provides,
and where that is not a kernel thread the I/O is charged to whichever group
that context belongs to instead.  The per-bio association used for the bios
nvmet allocates itself does not depend on the calling context.

For a file backed namespace what is charged is the I/O the file system
issues in the calling thread, which also means a tight limit slows that
work down.  Its journal and writeback threads are not covered, nor is the
flush a FUA write defers to the direct I/O completion, and a file system
that falls back to a buffered write inside ->write_iter leaves that
writeback uncharged too.  Charging is best effort in that sense, which is
why the attribute stays optional and off by default.

Attribute rules: cgroup v2 path, must start with '/'; writable only while
the namespace is disabled (-EBUSY otherwise); writing an empty line clears
it; enabling fails if the path does not resolve.  Unlike device_path, an
empty write is accepted, because there has to be a way to undo the
association.  The path is resolved with cgroup_get_from_path(), that is,
relative to the cgroup v2 root of the cgroup namespace of the process that
enables the namespace.  Enabling does not fail when the io controller is
not enabled in that group: cgroup_get_e_css() returns the closest ancestor
where it is, up to the root group, which is the same thing that happens to
a task in such a group.  That is resolved once, so enabling the controller
afterwards does not change what is charged until the namespace is disabled
and enabled again.  The attribute is only built when CONFIG_BLK_CGROUP is
enabled.  A passthru subsystem cannot have regular namespaces at all, so
the attribute never applies to one.

Removing the cgroup while the namespace is enabled is safe but not free.
The held reference keeps the css allocated, it does not keep it online, and
rmdir offlines the blkcg and destroys its blkgs.  A bio that carries the
css then misses the blkg lookup and takes the blkg_lookup_create() slow
path before settling on the closest ancestor that is still alive, on a
lock shared with everything else using the same device, so it costs
throughput.  A bio charged through the thread loses the association
instead, because css_tryget_online() fails on the offline css, and goes
straight to the root group.  I/O keeps running either way and nothing
leaks, but the removed group's limits stop applying.  Disabling and
re-enabling the namespace re-resolves the path.

Zone append is associated like any other data bio.  Zone management
commands are not: they are control plane operations, and a reset can be
issued for a whole device at once, where throttling would only stall the
command.

Tested on one host with four logical volumes carved out of a single
physical volume: two exported directly as block device backed namespaces
and two as O_DIRECT image files on xfs and ext4, each namespace in a cgroup
of its own and reached over nvme-tcp.  Without the patch an io.max line
naming a volume has no effect and the group's io.stat is never charged.
With it every limit holds to within 1% of the configured value on both
backends, at the logical volume and at the physical volume below it, two
namespaces sharing a group share one budget, a namespace without
cgroup_path is unaffected by the same lines, and the association itself
costs nothing measurable.  blktests nvme (loop and tcp transports, device
and file backends) shows no regressions.  The numbers are below the
diffstat.

Per Documentation/process/generated-content.rst: this work was done with AI
assistance (Claude, via Claude Code).  The design decisions - namespace
granularity, cgroup v2 only, resolution at enable time, rejecting
buffered_io, charging through the executing thread where nvmet does not own
the bio - were mine, taken in a structured design session; the model
produced the implementation, the test rig and the first drafts of this
changelog and the ABI text from those decisions.  Every number quoted here
came from the rig described below, not from the model.  I have read, built
and tested all of it and can defend it.  Per
Documentation/process/coding-assistants.rst there is no AI Signed-off-by
line; the Assisted-by trailers record the tool.

This was tried in 2023 with the cgroup associated to a target port instead
(link below); that thread stalled without a NAK and no v2 followed.  Review
objected that a port owns no thread and names no backing device, and that
covering only the block device backend was undesirable.  Here the
association is on the namespace, which is the object that names a backing
device, and both backends are covered.

Link: https://lore.kernel.org/linux-nvme/20230627100215.1206008-1-ofir.gal@volumez.com/
Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5 [Claude Code]
---
 Documentation/ABI/stable/configfs-nvmet | 53 ++++++++++++++++++
 drivers/nvme/target/configfs.c          | 62 +++++++++++++++++++++
 drivers/nvme/target/core.c              | 72 +++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c       | 19 ++++++-
 drivers/nvme/target/io-cmd-file.c       | 32 ++++++++++-
 drivers/nvme/target/nvmet.h             | 70 ++++++++++++++++++++++++
 drivers/nvme/target/zns.c               |  1 +
 7 files changed, 306 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/stable/configfs-nvmet
index 36b587404ee7..3cdf3d0e20ad 100644
--- a/Documentation/ABI/stable/configfs-nvmet
+++ b/Documentation/ABI/stable/configfs-nvmet
@@ -350,3 +350,56 @@ Description:
 		Shows or sets the NQN of the discovery subsystem. The
 		value must be unique and not duplicate any existing
 		subsystem name.
+
+What:		/config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_path
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Peng Yu <yupeng0921@gmail.com>
+Description:
+		Shows or sets the path of the cgroup v2 group whose io
+		controller the I/O of this namespace is associated with,
+		given relative to the root of the cgroup v2 hierarchy (for
+		example "/nvmet/user1").  Cgroup I/O policies such as io.max
+		then apply to that I/O, and keep applying to it as it is
+		split and remapped further down the stack.
+
+		The value must begin with '/'; anything else is rejected with
+		EINVAL.  The namespace must be disabled before the attribute
+		can be changed, otherwise the write fails with EBUSY.
+		Writing an empty line clears the association.
+
+		The path is resolved when the namespace is enabled, in the
+		cgroup namespace of the process writing to "enable".
+		Enabling fails if the path does not resolve, or if
+		buffered_io is set: buffered writes are handed to writeback,
+		where there is nothing left to charge them to.
+
+		This file always reports the path that was written; the group
+		actually charged can be an ancestor of it.  If the io
+		controller is not enabled in the named group, the association
+		is made with the closest ancestor where it is, which may be
+		the root group.  That is resolved once, when the namespace is
+		enabled, so enabling the controller afterwards changes
+		nothing until the namespace is disabled and enabled again.
+
+		Removing the group while the namespace is enabled does not
+		stop the I/O or leak anything, but the limits stop applying:
+		the I/O charged per bio spills to the closest group that is
+		still alive, and the I/O charged through the executing thread
+		spills to the root group.
+
+		Part of the I/O is charged through the thread that executes
+		the command rather than per bio, because the target does not
+		allocate those bios itself: discard and write zeroes for a
+		block device backed namespace, the flush issued when
+		Namespace Write Protect is set, and all I/O of a file backed
+		namespace.  That only works where a kernel thread is what
+		executes the command, which the tcp, rdma, loop and pci-epf
+		transports always arrange; where a transport hands the
+		command to something else, that I/O is charged to whichever
+		group the executing context belongs to instead.  For a file
+		backed namespace the file system may also do part of the work
+		for a request in its own threads, which is not charged
+		either.
+
+		Only available when CONFIG_BLK_CGROUP is enabled.
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..999869268f7c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -561,6 +561,65 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+#ifdef CONFIG_BLK_CGROUP
+static ssize_t nvmet_ns_cgroup_path_show(struct config_item *item, char *page)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	ssize_t ret;
+
+	/* Against a concurrent store, which frees the old string. */
+	mutex_lock(&subsys->lock);
+	ret = snprintf(page, PAGE_SIZE, "%s\n",
+		       ns->cgroup_path ? ns->cgroup_path : "");
+	mutex_unlock(&subsys->lock);
+
+	return ret;
+}
+
+static ssize_t nvmet_ns_cgroup_path_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	size_t len;
+	int ret;
+
+	mutex_lock(&subsys->lock);
+	ret = -EBUSY;
+	if (ns->enabled)
+		goto out_unlock;
+
+	len = strcspn(page, "\n");
+	if (!len) {
+		/* An empty write clears the association. */
+		kfree(ns->cgroup_path);
+		ns->cgroup_path = NULL;
+		mutex_unlock(&subsys->lock);
+		return count;
+	}
+
+	ret = -EINVAL;
+	if (page[0] != '/' || len >= PATH_MAX)
+		goto out_unlock;
+
+	kfree(ns->cgroup_path);
+	ret = -ENOMEM;
+	ns->cgroup_path = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!ns->cgroup_path)
+		goto out_unlock;
+
+	mutex_unlock(&subsys->lock);
+	return count;
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, cgroup_path);
+#endif /* CONFIG_BLK_CGROUP */
+
 #ifdef CONFIG_PCI_P2PDMA
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
@@ -833,6 +892,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+#ifdef CONFIG_BLK_CGROUP
+	&nvmet_ns_attr_cgroup_path,
+#endif
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..b5dd5a51c6d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/cgroup.h>
 #include <linux/hex.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -474,8 +475,74 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+#ifdef CONFIG_BLK_CGROUP
+/*
+ * Resolve the configured cgroup to the io controller state that the I/O path
+ * charges the namespace's bios to.  The reference is held for as long as the
+ * namespace is enabled, and enabling happens before the namespace becomes
+ * visible to commands, so the I/O path can read ns->blkcg_css without any
+ * further locking.
+ */
+static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	struct cgroup *cgrp;
+
+	if (!ns->cgroup_path)
+		return 0;
+
+	/*
+	 * Buffered writes are handed to writeback, which runs later in a
+	 * thread that knows nothing about this namespace, so there would be
+	 * nothing left to charge the I/O to.
+	 */
+	if (ns->buffered_io) {
+		pr_err("cgroup_path is not supported with buffered_io: %s\n",
+		       ns->device_path);
+		return -EINVAL;
+	}
+
+	cgrp = cgroup_get_from_path(ns->cgroup_path);
+	if (IS_ERR(cgrp)) {
+		pr_err("failed to resolve cgroup path %s: %ld\n",
+		       ns->cgroup_path, PTR_ERR(cgrp));
+		return PTR_ERR(cgrp);
+	}
+
+	ns->blkcg_css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	cgroup_put(cgrp);
+	return 0;
+}
+
+static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->blkcg_css) {
+		css_put(ns->blkcg_css);
+		ns->blkcg_css = NULL;
+	}
+}
+
+static void nvmet_blkcg_ns_free(struct nvmet_ns *ns)
+{
+	kfree(ns->cgroup_path);
+}
+#else
+static inline int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	return 0;
+}
+
+static inline void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+}
+
+static inline void nvmet_blkcg_ns_free(struct nvmet_ns *ns)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 {
+	nvmet_blkcg_ns_disable(ns);
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
 }
@@ -602,6 +669,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_unlock;
 
+	ret = nvmet_blkcg_ns_enable(ns);
+	if (ret)
+		goto out_dev_disable;
+
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
 		goto out_dev_disable;
@@ -699,6 +770,7 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	up_write(&nvmet_ana_sem);
 
 	kfree(ns->device_path);
+	nvmet_blkcg_ns_free(ns);
 	kfree(ns);
 }
 
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..4a59f819137e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -297,6 +297,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
 				GFP_KERNEL);
 	}
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
@@ -322,6 +323,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
 					opf, GFP_KERNEL);
+			nvmet_blkcg_set_bio(req->ns, bio);
 			bio->bi_iter.bi_sector = sector;
 
 			bio_chain(bio, prev);
@@ -358,6 +360,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 	bio_init(bio, req->ns->bdev, req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
 
@@ -366,10 +369,17 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	bool associated;
+	int ret;
+
 	if (!bdev_write_cache(req->ns->bdev))
 		return 0;
 
-	if (blkdev_issue_flush(req->ns->bdev))
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = blkdev_issue_flush(req->ns->bdev);
+	nvmet_blkcg_end(associated);
+
+	if (ret)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	return 0;
 }
@@ -380,9 +390,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
 	sector_t nr_sects;
+	bool associated;
 	int i;
 	u16 status = NVME_SC_SUCCESS;
 
+	associated = nvmet_blkcg_begin(ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 				sizeof(range));
@@ -394,6 +406,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
 	}
+	nvmet_blkcg_end(associated);
 
 	if (bio) {
 		bio->bi_private = req;
@@ -431,6 +444,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	struct bio *bio = NULL;
 	sector_t sector;
 	sector_t nr_sector;
+	bool associated;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, 0))
@@ -440,8 +454,11 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
+	nvmet_blkcg_end(associated);
+
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f927..f7c7b055e5b2 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -79,6 +79,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
 	struct iov_iter iter;
+	bool associated;
+	ssize_t ret;
 	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -97,7 +99,19 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
-	return call_iter(iocb, &iter);
+	/*
+	 * cgroup_path requires buffered_io to be off, so a namespace that has
+	 * one is opened O_DIRECT and the bios for this transfer are normally
+	 * allocated and submitted before call_iter() returns, where they pick
+	 * the cgroup up from this thread.  A file system that falls back to a
+	 * buffered write internally leaves its writeback uncharged, which is
+	 * why this is documented as best effort.
+	 */
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = call_iter(iocb, &iter);
+	nvmet_blkcg_end(associated);
+
+	return ret;
 }
 
 static void nvmet_file_io_done(struct kiocb *iocb, long ret)
@@ -251,7 +265,14 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	bool associated;
+	int ret;
+
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = vfs_fsync(req->ns->file, 1);
+	nvmet_blkcg_end(associated);
+
+	return errno_to_nvme_status(req, ret);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
@@ -274,10 +295,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
 	loff_t offset, len;
+	bool associated;
 	u16 status = 0;
 	int ret;
 	int i;
 
+	associated = nvmet_blkcg_begin(req->ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
@@ -300,6 +323,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		}
 	}
+	nvmet_blkcg_end(associated);
 
 	nvmet_req_complete(req, status);
 }
@@ -336,6 +360,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	bool associated;
 	int ret;
 
 	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
@@ -347,7 +372,10 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 		return;
 	}
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	nvmet_blkcg_end(associated);
+
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..216277af2fa3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -18,6 +18,7 @@
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
+#include <linux/kthread.h>
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
 #include <linux/kfifo.h>
@@ -114,6 +115,15 @@ struct nvmet_ns {
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
+#ifdef CONFIG_BLK_CGROUP
+	const char		*cgroup_path;
+	/*
+	 * Resolved from ->cgroup_path when the namespace is enabled and
+	 * released when it is disabled, so it has the same lifetime and
+	 * visibility rules as ->bdev and ->file.
+	 */
+	struct cgroup_subsys_state *blkcg_css;
+#endif
 
 	struct config_group	device_group;
 	struct config_group	group;
@@ -732,6 +742,66 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+#ifdef CONFIG_BLK_CGROUP
+/*
+ * Charge @bio to the cgroup configured for @ns.  The association travels with
+ * the bio as the block layer remaps and clones it, so an io.max line naming a
+ * device below the namespace applies to this I/O too.
+ */
+static inline void nvmet_blkcg_set_bio(struct nvmet_ns *ns, struct bio *bio)
+{
+	if (ns->blkcg_css)
+		bio_associate_blkg_from_css(bio, ns->blkcg_css);
+}
+
+/*
+ * Charge the I/O of a helper that allocates its bios internally, where there
+ * is no bio for nvmet to associate: the block layer's discard, write zeroes
+ * and flush helpers, and the file backend's ->read_iter and ->write_iter.
+ * Those bios are allocated in the calling thread and take the cgroup from its
+ * kthread association, the mechanism the loop driver uses for the same reason.
+ *
+ * kthread_associate_blkcg() stores the association in the calling kernel
+ * thread, which is only the right thing to do when that thread is executing
+ * this command: in_task() rules out an interrupt, where current has nothing
+ * to do with the command, and PF_KTHREAD rules out a user task, whose own
+ * association must not be taken over.
+ *
+ * The return value of begin() decides whether end() clears the association
+ * again, so that the two can never disagree.  end() must not look at the
+ * namespace: once the bracketed call returns the request may already have
+ * been completed and freed.  kthread_associate_blkcg() replaces rather than
+ * stacks, so these brackets must not nest; no command needs more than one.
+ */
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	if (!ns->blkcg_css || !in_task() || !(current->flags & PF_KTHREAD))
+		return false;
+
+	kthread_associate_blkcg(ns->blkcg_css);
+	return true;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+	if (associated)
+		kthread_associate_blkcg(NULL);
+}
+#else
+static inline void nvmet_blkcg_set_bio(struct nvmet_ns *ns, struct bio *bio)
+{
+}
+
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	return false;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 23a17c02abee..1de1f0e1ef1c 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -580,6 +580,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		bio = bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
 	}
 
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
 	bio->bi_iter.bi_sector = sect;
 	bio->bi_private = req;
-- 
2.53.0


