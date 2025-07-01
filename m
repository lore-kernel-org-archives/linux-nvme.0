Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC84C83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJ8y0PzGFf5PD7LMarUocV/8a84K0y4CIjPrM9ordDM=; b=DPSLXbjB1W09Pj3n7ZNMcGvOAv
	gfgij2o3qTaVt9kxY/yQ9w6Yjd2Tgev1gdUOWCyB7Q5koynxldngEDGeAv1Akb9iuyJy4OK3Ah1Re
	2WyuBW7tMKgnJG7UcWlOJ9/0LVYIOzNJ+dmNRI9ELchPWuv8ViuHgCeszx4f0YrFCjJMyjRAGd/T3
	UxALewhxDzGyxknA0SbCQlFIi8rEWH/XiKG4kVxnX8yinjtryAjz7mkM3qzMI3EQdZI++MKe0DlBc
	899Mr2i5Pv3UM7dkE5g+JhszlMGi0C/3a1XJ1Dxqc/FJE4zvIQzIik9CzUDGkza9sIKfMle8tFFCy
	djJ1AA+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbDB-00000005Y1u-1f5Q;
	Tue, 01 Jul 2025 13:39:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWZg7-00000004y5T-1LJo
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 12:01:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C771C44489;
	Tue,  1 Jul 2025 12:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4647C4CEEB;
	Tue,  1 Jul 2025 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371294;
	bh=Ve2jWkUY7Kco8qr8eXLeveQqpfYfuVWQzfdfLKDRfSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEeP5CN4D96Xof3lUeWOZq5kQVZ7As6qgXQJ+ZVOWulMkKg1SsV7pEcbmA40Q+3Cf
	 0kM710txoJdS2GTbF+7CWVJOzBREkzgDya6XBMBUQ5Sd2wcowJtnGQJcB42WwFgYc2
	 9OnkmabB6qG7uKK/PG3jU0ecNGZh6KSAQMa6/hWoiJnYrVXLZAOiX05cJSJBAzEJSQ
	 gRG9W3sdo/A7Z1TRijbJ49SJk6U9SGZz1sNAIakruHpAbHjzCKJrgFNsr1aWKa0z9H
	 xoODuRK3rSU+3W7fF5pnIuwZwyHu4qVVmDClkSXfnC6fRlP/Iup5YOBkz2dVpS4F1c
	 cyvilMj4huWcQ==
From: Christian Brauner <brauner@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	gost.dev@samsung.com,
	vincent.fu@samsung.com,
	jack@suse.cz,
	anuj1072538@gmail.com,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	martin.petersen@oracle.com,
	ebiggers@kernel.org,
	adilger@dilger.ca
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and protection info capabilities
Date: Tue,  1 Jul 2025 14:01:17 +0200
Message-ID: <20250701-abreden-rohkost-a0c293481b42@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
References: <20250630090548.3317-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=brauner@kernel.org; h=from:subject:message-id; bh=Ve2jWkUY7Kco8qr8eXLeveQqpfYfuVWQzfdfLKDRfSM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQknxN75MRyd/PiQ5JXj/wQbuLSu2fukbHgvmHLC/8Fx w+t3D2/rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAid48xMqyzkzDW3sER9D89 SPm21bwpawozbEPuMy969V6FLSlrITsjw2ot+bUZNcv9avvZ703+8bGnrjlII9OyWpBl6wIR/uT fHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_050136_405249_77775CDF 
X-CRM114-Status: GOOD (  13.29  )
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

On Mon, 30 Jun 2025 14:35:44 +0530, Anuj Gupta wrote:
> This patch series adds a new ioctl to query metadata and integrity
> capability.
> 
> Patch 1 renames tuple_size field to metadata_size
> Patch 2 adds a pi_tuple_size field in blk_integrity struct which is later
> used to export this value to the user as well.
> Patch 3 allows computing right pi_offset value.
> Patch 4 introduces a new ioctl to query integrity capability.
> 
> [...]

Applied to the vfs-6.17.integrity branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.integrity branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.integrity

[1/4] block: rename tuple_size field in blk_integrity to metadata_size
      https://git.kernel.org/vfs/vfs/c/c6603b1d6556
[2/4] block: introduce pi_tuple_size field in blk_integrity
      https://git.kernel.org/vfs/vfs/c/76e45252a4ce
[3/4] nvme: set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
      https://git.kernel.org/vfs/vfs/c/f3ee50659148
[4/4] fs: add ioctl to query metadata and protection info capabilities
      https://git.kernel.org/vfs/vfs/c/9eb22f7fedfc

