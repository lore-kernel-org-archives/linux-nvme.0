Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030E7CDB470
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dwJksdIzMwz2uxNEIudYReLSHRnKiNyII3cysFwTREY=; b=s4U0nGtxwdcY0c
	4rWTVgXOw8Y3NPrpUkeyXZWUSnPJNoceJcJ3pLnpidY9tNKUctFIa1VObb0UpuFu9ohRRQVNt7sKZ
	vb9xdj5bsBbvcLoFrAFzCd343fZp9Ues0Nhd12Km6Xe7IzkPxv+N++LECQdtS0RgI/++K5xsOou8N
	WmxBtGFupBH3jIIvXrvA6F6Fa3WCgER4liyxR2eoXVIAqIMGFlbxVukC2Rxdd4+da2y7znIUmvR1u
	+b16wK6BAgjmDLSsdTK77f62TCz0kq4otX6eCzRsI+XzgqPaprR3uQeVeLnM/7qwDCUWKljTCnLDz
	Bp5awbL/YYmZsLSBuseA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEi-00000005zD3-0qpD;
	Tue, 23 Jun 2026 09:16:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEg-00000005zCm-2hjG
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99D3C60052;
	Tue, 23 Jun 2026 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17431F000E9;
	Tue, 23 Jun 2026 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206161;
	bh=dwJksdIzMwz2uxNEIudYReLSHRnKiNyII3cysFwTREY=;
	h=From:Subject:Date:To:Cc;
	b=VNaKgmFmznQyoeBulK2m9ac4kiPLoAR5JPsaxOdisC7FWIf3vYYbj6lRKounZbT6U
	 /+6LumlFCNSd5GgF4g2EZ1H02pFT2iHEqAIlv40GpnhseIE11drxjSvcc3DZoNdxNW
	 SQOXGkj8Ws376UM43KATbYphopYWFowsCK/safTm8l0SSMVI3O81QxJnwmzRqa0It1
	 B/CXZ5GgxmthzDbx3NcFYPIqwz5JY86m0eDgG3B5mnqmMolIyftsuL1aBv79O/PUYy
	 m2t5nvXsjDW3sLav1I+bO1iDLSsHk+fqHto9IomYNlKWfsFRfzTyrN4EwdiwPnEURL
	 YN/xyKjcTrMvg==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RFC v3 00/12] namespace-aware configfs
Date: Tue, 23 Jun 2026 11:15:45 +0200
Message-Id: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFOOmoC/22NQQrCMBREr1L+2khMa5q6EgQP4Fa6MMlP+qkkk
 khRSu9uyFqYzZthZlbImAgznJoVEi6UKYYC7a4BMz2CR0a2MAguJJeHgZkYHHmXWchMH/tO6Vb
 KIiiNV0JHn7p2h9v1AmMxJ8rvmL71YRE1+ju2CMaZEs72fOi0suY8Ywr43MfkYdy27QcOPuYBr
 AAAAA==
X-Change-ID: 20260619-configfs-ns-b5748b366366
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=3779;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=2fGGWS0P4+GqP7BDsbXG+4M0kJfHb/Qy81cW24j0Es8=;
 b=7NedXzaZugWH2oJPuKLHBA6vecxoG9Jg3H+7rVkhZp6LR3ZBzVif3pMuzDOsvpBbVamfRC7Xa
 hcCBwWaKnaPCaxTGLqZV94tb4GYUJxtlIOVPabw481xAhY3Qrt7BaFJ
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
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

Hey all,

during discussions at LSF/MM I thought it would be quite helpful
to make configfs namespace aware, such that one could do:

unshare --mnt
mount -t configfs none /sys/kernel/config

and get a new instance of configfs. This will allow to have distinct
configurations for each namespace.
This is particularly helpful if you want to run eg nvmet in a container;
with this patchset each container can have its own configuration, and
one can simulate a multi-node nvmet cluster using containers.

How it works:
The configfs 'root' entries are stored in 'configfs_super_info', which
can be looked up from an xarray using the (network) namespace ID as the index.
A configfs subsystem can be converted to be namespace aware by implementing
the new subsyste callbacks 'fill_subsystem()' and 'clear_subsystem', which
are responsible for populating the subsystem structure.
Upon registration via 'register_subsystem()' the subsystem is put in a
linked list within 'configfs_super_info'. So when mount() is called from
a different namespace this list is traversed, and new subsystems are created
in the new namespace using the callbacks.

Open Issues:
- I've added a new function 'mnt_clone_direct()' to clone the vfsmount
  entry (the original code just did a simple_pin_fs()). Not sure if
  that's correct. Christian?
- Ideally I would love to make the whole thing work without having
  to mount a new configfs instance from within the container.
  Again, not sure if that's possible.
- I've decided to base it off the net namespace (and not any namespace).
  That makes implementation easier, but requires the various subsystems
  to actually _use_ the network namespace.
  The current use-case (nvmet) does that, so it works for me :-)

Otherwise, as usual, commands and reviews are welcome.

Changes to the original submission:
- Changed to use 'net' namespace instead of 'mnt' namespace
- Smaller fixes as suggested by sashiko.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
Changes in v3:
- Split off nvmet patches
- kbuild robot fixes
- Simplify namespace selection
- Link to v2: https://lore.kernel.org/r/20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org

---
Hannes Reinecke (12):
      fs/configfs: rework configfs_is_root()
      fs/configfs: dynamically allocate super_info
      fs/configfs: separate out configfs_{link,unlink}_root()
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
      fs/namespace: implement mnt_clone_direct()
      fs/configfs: switch to get_tree_keyed()
      fs/configfs: open-code simple_pin_fs()
      nvmet: make discovery subsystem dynamic
      nvmet: per net-namespace port list
      nvmet: make configfs setup namespace aware
      nvmet: enable transports for net namespaces

 drivers/nvme/target/configfs.c  | 206 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  36 +++---
 drivers/nvme/target/discovery.c |  91 +++++++++++----
 drivers/nvme/target/loop.c      |   4 +
 drivers/nvme/target/nvmet.h     |  15 ++-
 drivers/nvme/target/rdma.c      |   6 +-
 drivers/nvme/target/tcp.c       |   6 +-
 fs/configfs/configfs_internal.h |  23 +++-
 fs/configfs/dir.c               | 188 +++++++++++++++++++++++++-----
 fs/configfs/mount.c             | 248 +++++++++++++++++++++++++++++++++-------
 fs/namespace.c                  |  11 ++
 include/linux/configfs.h        |   8 ++
 include/linux/mount.h           |   1 +
 13 files changed, 682 insertions(+), 161 deletions(-)
---
base-commit: 66affa37cfac0aec061cc4bcf4a065b0c52f7e19
change-id: 20260619-configfs-ns-b5748b366366

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


