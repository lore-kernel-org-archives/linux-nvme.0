Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AF606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=niTHIfQ+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVdhpRk4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ugeAAa5F7S8jo7o22VRNVHZRCEghXnRG4QSs0z+gWeQ=; b=niTHIfQ+lPnvJZciiIUZVdUqRR
	sO62IRFkvwwHZcw2HI3inCWA0ogRQrpq3QTknsfJWWLcZ39T/gZMzXPymslTtV7WNSIYPFrTArtiw
	EtB+RJJ556KwxqqnFHRVWOZ6WGkR9aDzxH1UkL97OWUnSH/5XJBNZucoS64db6QnA9u5QrzbUTNV5
	Eer+O5gVfNMOsTya0PvlBbtFci2/wIwnM62q02sjxKDKqjBuFj8b8cS+Qy3QHarg8HQYKuckM0dTv
	Y2mOa+KPOLzrVJKRBu1zGT1bxROjvmmK5SGNoP3OuBhMgBLiCpPOULJgek6b19mu+bC8xGpFWBcrj
	Nt6Z4How==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwg4-00000002az3-0alD;
	Mon, 16 Nov 2026 13:23:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwg3-00000002ays-2eLe
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:23:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 14AD4615A7;
	Mon, 16 Nov 2026 13:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD1F1F000C4;
	Mon, 16 Nov 2026 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794835398;
	bh=ugeAAa5F7S8jo7o22VRNVHZRCEghXnRG4QSs0z+gWeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVdhpRk49/rwmMkR2Jud38KOYWBE8eCd8fYpApx6gg7JhlrTG+NmRdk+94MetwqgH
	 NZGwa2e8anIBp0KxnE0LOtT8/RmP6GjIZSLksjgDdD/Wwj2BtfDbH+Vz0MgPndNK7Q
	 x9jdZYmPYLBNvm5CgAdHMugjPsk+7Pv12AtWVwAZi+19j04TzVA3F1oE6N1kNd/7tO
	 tOhQLWtGwQ6BS8LceKUuBTeirwIN85EAfRv/JLP+ilx8md+ACPvUE0/WwefbgPgkoQ
	 1BQQ/U8W8pdcpoRKzwoWXaA0FKUm5hVBA5xnNnD7EK7K7McdqkITK4A6oHdbmISsNt
	 B2L5Ae5AFK0tA==
Date: Mon, 16 Nov 2026 14:23:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, bpf@vger.kernel.org, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2 02/17] fs: add kiocb_write_iter() and
 kiocb_end_write_iter()
Message-ID: <20261116-windungen-freuden-zander-0e6ef798e54c@brauner>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
 <sashiko-outbox-216937@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-216937@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:30:59AM +0000, sashiko-bot@kernel.org wrote:
> Should kiocb_write_iter() check S_ISREG(file_inode(iocb->ki_filp)->i_mode)
> before taking freeze protection and setting IOCB_WRITE, the way
> file_start_write(), aio_write() and io_kiocb_start_write() do?

Eeew, no. That check alone would bring the bug back for these drivers.

blkdev_write_iter() calls file_update_time() which dirties the device
node's inode on the filesystem the node lives on. And write(2) on such a
node modifies a frozen filesystem today for the same reason.

For FIFOs we skip the time update on a frozen filesystem instead of
blocking (cf. 7e775f46a125f ("fs/pipe.c: skip file_update_time on frozen
fs")). If we change file_update_time() to do that for all special files
then kiocb_write_iter() can take the S_ISREG() check.

> Without an S_ISREG() check, writes to a block device node whose hosting
> filesystem is frozen will block in sb_start_write() (or fail with -EAGAIN for
> IOCB_NOWAIT), and will deadlock if that filesystem is mounted on or
> flushing through the virtual block device during freeze_super().

That can't happen. The node is opened when the device is set up so its
filesystem can't be mounted on that device.

