Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE5606A331
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dx88tCMt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvPmWLG4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XPMkvKKanr3S4ASvEacFHPbaqJr5gbbk21MA5ahcXyQ=; b=dx88tCMt00CVzSWUVKGdpiYIGL
	lP6f2a630uNyPt33jdB39+PpjkQHWp7pfI6EEOMdhkaD7rZDPw7nUdmcwUK5pmA8rOf0bFGboWJXF
	5i4l8rw7MyBm/Lc+qEKrDu3bUmzv7bWZKP7qYQ5KsYNr58bsdJESeJjms00a7L3WMipsZfwmRlxuK
	OHq60Sy7VuFKzjCrgyDxVEu7loC9pj7KKvmevisR3gWS5ItribldCCjRXUZytd/eU8X7Rg35irBMz
	70V4pWeVjD758W9uBdeK8HIivwYw8sClH5a72DvUPVgdz3VHSPRL6bBqdwts4zIWFIce573Ji+7hw
	5WhEuf4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKBS-00000002XUl-1BsS;
	Mon, 26 Oct 2026 12:52:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKBQ-00000002XUb-28lX
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 12:52:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72D834352C;
	Mon, 26 Oct 2026 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E581F01825;
	Mon, 26 Oct 2026 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019131;
	bh=XPMkvKKanr3S4ASvEacFHPbaqJr5gbbk21MA5ahcXyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvPmWLG45mBwXRBon8X2v3XrT3faP2BZpi2WUmJ+HjFuN2V1Idl9awa45T8ZrC2YT
	 sbMEUGQZbMfn/WXrVrGNV/G6+FBIQD0RcYvRx0LLeGaXN20M4KYHp2jy2IPb2Y3n1p
	 8p1uX0OGgzRhTegWfftbe8bD3g4oIU3BuWCv1/bqoqdIUzTEQblKKP0fQalPEUV2hQ
	 nwzpLmwwNqqnwsphpTYQGJmYS1eYVFPXpaRFuc/jpZADCZjfxlAqZgZilN6IsLW3h5
	 +9BKSdlElOfRVkEclqQ7lbxj8NHE9zEW9LWJySd8ImugAzz9UrYW5ksvC+nO+1CKIE
	 kzFQwLbai3LfQ==
Message-ID: <sashiko-outbox-185248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] nvme: add debugfs helpers for NVMe drivers
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261026123411.1988949-5-nilay@linux.ibm.com>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <20261026123411.1988949-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:52:10 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme: missing debugfs_mutex and NOIO scope in nvme_debugfs_creat=
e_files()
--

commit cd2cc953bf8eddec233eaabc47f820bf78836863
Author: Nilay Shroff <nilay@linux.ibm.com>

nvme: add debugfs helpers for NVMe drivers

This patch introduces helper APIs and an attribute structure for NVMe
drivers to register and unregister seq_file-based debugfs entries on a
request queue's debugfs directory.

> diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
> new file mode 100644
> index 0000000000000..798fec4730f0a
> --- /dev/null
> +++ b/drivers/nvme/host/debugfs.c
> @@ -0,0 +1,133 @@

[ ... ]

> +static void nvme_debugfs_create_files(struct request_queue *q,
> +		const struct nvme_debugfs_attr *attr, void *data)
> +{
> +	if (WARN_ON_ONCE(!q->debugfs_dir))
> +		return;
> +
> +	for (; attr->name; attr++) {
> +		if (attr->is_visible && !attr->is_visible(data))
> +			continue;
> +		debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
> +				data, (void *)attr, &nvme_debugfs_fops);
> +	}
> +}

[Severity: Medium]
Should nvme_debugfs_create_files() hold q->debugfs_mutex and run under a
memalloc_noio_save() scope when accessing q->debugfs_dir and creating
debugfs files?

In include/linux/blkdev.h, struct request_queue documents that
debugfs_mutex serializes all debugfs metadata operations on debugfs_dir:

	struct dentry		*debugfs_dir;
	struct dentry		*sched_debugfs_dir;
	struct dentry		*rqos_debugfs_dir;
	/*
	 * Serializes all debugfs metadata operations using the above dentries.
	 */
	struct mutex		debugfs_mutex;

Furthermore, block/blk.h notes in blk_debugfs_lock_nomemsave() why NOIO
context is needed alongside debugfs_mutex (as introduced in commit
dfe48ea17973 ("blk-mq: use NOIO context to prevent deadlock during debugfs
creation")):

	/*
	 * debugfs directory and file creation can trigger fs reclaim, which can e=
nter
	 * back into the block layer request_queue. This can cause deadlock if the
	 * queue is frozen. Use NOIO context together with debugfs_mutex to preven=
t fs
	 * reclaim from triggering block I/O.
	 */

When nvme_alloc_ns() calls nvme_debugfs_register(ns->disk) after
device_add_disk(), the namespace is already on ctrl->namespaces and the
disk is live in sysfs, while blk_register_queue() has already dropped
blk_debugfs_lock(q). If the queue is concurrently frozen (for example, by
a controller reset calling nvme_start_freeze() or a sysfs write calling
blk_mq_freeze_queue()), could GFP_KERNEL allocations inside
debugfs_create_file_aux() trigger direct filesystem reclaim into the
frozen queue and deadlock, or race with concurrent blktrace, scheduler,
rqos, or queue teardown debugfs operations on q->debugfs_dir?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026123411.1988=
949-4-nilay@linux.ibm.com?part=3D1

