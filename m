Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7D2CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+0xWRA8LZGr8NhjjDPmMP9Km9GlqhdcfCG+GwkZQaC4=; b=va3HBLRDEKyYO9
	cIEMD3RuQE6Igrw2+EE92a40zoWx4ioyByPQzwrhkgOoK2YNQZ3AhWu13nrQFfKhuFrT+0A+5ORUv
	8Xj2GmCJN6k8epwToMtmTSC61kzEv2JK8l3ElczsVUUMvr7IJS3iiYRqB3kUO15KQb3EUU7t+tyAp
	5Pnri4YG2kPzUE6Mm4C7iE7E3nqg/IHt3W9I6SYPOxkVj3MPZoVKtwl9jmZuYD9u5WRXD8rp5QiXe
	IrXTMi0Ybewh2FRqe7MgsMo69+9FdIIn7kGttKNcv49yN1jxM1CiYzGFpVjjrtZ/5HVYBIDmeVFF/
	LwGd2YonQfhGqnmZOaXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUie-00000002AUF-2KYg;
	Fri, 19 Jun 2026 08:36:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUid-00000002AU8-1ej6
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:36:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8524C40185;
	Fri, 19 Jun 2026 08:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C036D1F000E9;
	Fri, 19 Jun 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858214;
	bh=+0xWRA8LZGr8NhjjDPmMP9Km9GlqhdcfCG+GwkZQaC4=;
	h=From:Subject:Date:To:Cc;
	b=jPpxFmfuTd1UzQ1dicUHNhpFC/9WvA5mKW92jWWhrVXDPT9fwP/qZHiOaPY56CznG
	 nNMU6uKpyAQnkiMLY3PkWPjhhLJUl61lbxkvL508xibuBNGSQYG6u1DPK+Q10RvA6i
	 x8JsHHE3ncpNcZ9AVV2UCLk6paq5I8mjC9pT1rlRS34M2tSSeX1Mo2BYjPodiJj/kS
	 FPxnhADy5/dwvgPWZE+T2EmmwrggdeQlkzhFrZzsqHvVGG5KVmx1tF8lUvKqKS93K6
	 fPP2ySqL8z8G3yJevaIs7EGXjpaV9ELK8iQZTkpM6iiLWKzuCY61AxNkYZuCHRPAs+
	 ofLqHL3uxoimQ==
From: hare@kernel.org
Subject: [PATCH RFC v2 00/12] namespace-aware configfs
Date: Fri, 19 Jun 2026 10:36:40 +0200
Message-Id: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJn/NGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NL3eT8vLTM9LRi3bxi3SRTcxOLJGMzMyBSAuooKEpNy6wAmxatFOT
 mrBRbWwsAzOH4tWIAAAA=
X-Change-ID: 20260619-configfs-ns-b5748b366366
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3515;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=4WnUnn5+hWO+h3ivDAtlJLmFZkMrglyzFTY+tJ7QgjY=;
 b=eRD9VDey/sZ2GUJ8NW92l2ZbbNrykTYDvxkRhsLeZUSvi9fa68w/2ff+Hjo+5U4DcpGvD74j1
 FTJikKgJWD7DzDXI57EAEJSObMt1ASwB46WEk8YywRVJlwGD95/Q3Of
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
Hannes Reinecke (12):
      fs/configfs: rework configfs_is_root()
      fs/configfs: dynamically allocate super_info
      fs/configfs: separate out configfs_{link,unlink}_root()
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/namespace: implement mnt_clone_direct()
      fs/configfs: switch to get_tree_keyed()
      fs/configfs: open-code simple_pin_fs()
      nvmet: make discovery subsystem dynamic
      nvmet: per net-namespace port list
      nvmet: make configfs setup namespace aware

 drivers/nvme/target/configfs.c  | 203 ++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  36 +++---
 drivers/nvme/target/discovery.c |  91 +++++++++++----
 drivers/nvme/target/nvmet.h     |  15 ++-
 drivers/nvme/target/tcp.c       |   6 +-
 fs/configfs/configfs_internal.h |  23 +++-
 fs/configfs/dir.c               | 183 ++++++++++++++++++++++++-----
 fs/configfs/mount.c             | 248 +++++++++++++++++++++++++++++++++-------
 fs/namespace.c                  |  11 ++
 include/linux/configfs.h        |   8 ++
 include/linux/mount.h           |   1 +
 11 files changed, 668 insertions(+), 157 deletions(-)
---
base-commit: 66affa37cfac0aec061cc4bcf4a065b0c52f7e19
change-id: 20260619-configfs-ns-b5748b366366

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


