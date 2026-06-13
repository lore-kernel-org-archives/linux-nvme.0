Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8FECD8CA8
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RP6aowk3kWOKY3IKdbIH/MdxPMRZ1g9CatphPpQNHL4=; b=YmJJsA3lDQPgsi2Uw0erLb0naZ
	JH3DPruhdcrUf7Td4pBfy4VrnagiMMcj6kU+p+4MzqgupQLFZV5tm88qTREYeLPqBva4lS8gFi0Vc
	6If7vv5WivJ7rP1s1s+s/NWMntTXx199EYLvap07KAgCBwnF1WjQthKjfPBVwN9f3vBJTm2WlLw+Q
	/QfWucryyfGlSCch19YVJa+7sWBVf7078GJj32drQR70MNYQKpOm54Nb/Hqs/YYaxSj9cHR3cZiB1
	9Di5Z1bucynJ+KRn40j2XhU1bo/5UyrKVkwYRE8VyQpNPeFbcy4oa1foDtcJWiWBXNcTfGfYLNB8W
	dBRoJ1tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKF-0000000CE0h-1Voe;
	Sat, 13 Jun 2026 11:14:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMK9-0000000CE0Y-0BDa
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:14:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 151E660018;
	Sat, 13 Jun 2026 11:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B66B1F000E9;
	Sat, 13 Jun 2026 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349286;
	bh=RP6aowk3kWOKY3IKdbIH/MdxPMRZ1g9CatphPpQNHL4=;
	h=From:To:Cc:Subject:Date;
	b=Sw6GVLzxcedzMFXJJhd7e/5JUAsYai57CMeHZqyufopRatJxbe0nXKIOKOAd/dwvs
	 OHWxZ9ss2bdcj3XpGOlEAH2UrWVFd0hcF3G4TByQBICjA70pVj5cOqrOnHFruv7Y5P
	 3RAT3aCfeGwPFkUoyyd9ENM3tf57KrYxni2b03DznXRcFDnkwYlcl3YTpL39O3zfeh
	 v07JxhIivIN/oyBrtS7Liuh/oinwwaHVuk6NLP3GpJTCCqyxKSpi2fjJFzq8oBpPQe
	 qxGfIa+5XGiQ+mJY5WAkzT47upFeAtF6zZCL6NfwioN5WyU/1+DLI7yodnMjDetH7I
	 BHO96VMLmpo5g==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [RFC PATCH 0/8] namespace-aware configfs
Date: Sat, 13 Jun 2026 13:14:29 +0200
Message-ID: <20260613111437.101763-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
The configfs 'root' entries are stored in 'configfs_super_info' which
is stored in an xarray using the namespace ID as the index.
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
- The current cloning mechanism is not really a hierarchy, but rather
  always using the default namespace to find registered subsystems.
  Meaning you can only call 'register_subsystem()' for the default
  namespace. But then one shouldn't call modprobe in a container, so
  that's okay I guess.
- The original content of the configfs remains visible even from
  within the container, and the new 'mount' will just overlay that.
  Ideally I would have the container start off with an empty
  /sys/kernel/config to avoid configuration issues. But again I've
  no idea how to do that (or if it's even possible).

Otherwise, as usual, commands and reviews are welcome.

Hannes Reinecke (8):
  fs/configfs: rework configfs_is_root()
  fs/configfs: dynamically allocate super_info
  fs/configfs: separate out configfs_{link,unlink}_root()
  fs/namespace: implement mnt_clone_direct()
  fs/configfs: add superblock as attribute to configfs_pin_fs()
  fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
  fs/configfs: switch to get_tree_keyed()
  nvmet: make configfs setup namespace aware

 drivers/nvme/target/configfs.c  | 183 ++++++++++++++++++++++-----
 drivers/nvme/target/core.c      |  35 +++---
 drivers/nvme/target/discovery.c | 101 +++++++++++----
 drivers/nvme/target/nvmet.h     |  13 +-
 fs/configfs/configfs_internal.h |  21 +++-
 fs/configfs/dir.c               | 167 +++++++++++++++++++-----
 fs/configfs/mount.c             | 216 +++++++++++++++++++++++++++-----
 fs/namespace.c                  |  11 ++
 include/linux/configfs.h        |   7 ++
 include/linux/mount.h           |   1 +
 11 files changed, 615 insertions(+), 144 deletions(-)

-- 
2.51.0


