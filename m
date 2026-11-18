Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEB606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fLYXWbk9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xn1ubuxI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=UmAp+lPSTg1wEXiU70K+MxkikZ60keP/cKOQ7HRBb4s=; b=fLYXWbk9pmJXj+f2j6GGsbND7F
	HA8BFcNlXam+nKUOryr50Ya4APXo0Ay0t9XrSw57y4tTV+mDD6pEVhuoY8ynOYiDnfNNOiDDm+q0I
	RtibBen7jiRsAzAfJ0O8iENrpgl9I0VNk7cRpCR/JG2ypzsgk2UhqIm3Daw033Jw2KI0IDah0UJR7
	00FOBwYI68pOz/bTSAeHRiBRLOPil2pq7qP/raZohyFYiq9uiViQ0ZzT6n5NiBs/6mb+K3/MYrjMr
	YsnvVPjKNLUNK8bvyUn4F6ErZYU72tkG9SRP1tkQO1s6m60UlJURp+99QY+dWeTv/Ytnsw6iDyHTd
	3gG1R9Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTU86-00000007QIF-3yRK;
	Wed, 18 Nov 2026 01:06:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTU85-00000007QI4-3n3c
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 01:06:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E17343B12;
	Wed, 18 Nov 2026 01:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E11F000C8;
	Wed, 18 Nov 2026 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963989;
	bh=UmAp+lPSTg1wEXiU70K+MxkikZ60keP/cKOQ7HRBb4s=;
	h=Date:From:To:Cc:Subject;
	b=Xn1ubuxI/cstndeLRpMVU9C3nBVX3YzwhN1uEEQjaKBk//g8ysJa/nfa+8YZ4uT1g
	 fJTyf3ybw1xX/puMeoCRxq4RN/dX8HQLE6UuEKbbavEn2dZbOxepMHrt6atzC6zi+Z
	 oVf2CJfnYQkOsKMjG76ip+YVZDWas74otj3+vJHh8cswThoS9mDSHnPeiU8yaAY6VZ
	 b+KgWKkk/Au4XqWGSIc6bkafawBlL2HvR+XkOsRrGIC7XNthT6iCE+M8zBRkwwWzCE
	 cl0aH7C+gzWFCA13H/XUeWovb2rkKMh/Q4KVe3tPAcZYVnMZYAeQQDtXuZ2JtmxJd9
	 bp+WXLJbtdqeQ==
Date: Tue, 17 Nov 2026 18:06:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: [GIT PULL] nvme fixes for Linux 7.4
Message-ID: <avz6E9jYgGkRVmx5@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 28f7d31c2aeb350df9a0116093fade0a840fb4ce:

  Merge tag 'nvme-7.4-2026-11-05' of git://git.infradead.org/nvme into block-7.4 (2026-11-05 13:47:13 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.4-2026-11-17

for you to fetch changes up to 68099cf27253a8c89d703a282d3d811446d9453b:

  nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret (2026-11-16 07:42:49 -0800)

----------------------------------------------------------------
nvme fixes for Linux 7.4

- Fix TLS handling of non-data records on a live queue and wait for an
  in-flight handshake callback
- DH-HMAC-CHAP fixes: use the parsed key offset on host and target,
  synchronize secret removal, clean up DH group state on failure, and
  securely free secrets
- Fix short reads/writes and range check overflows in the target file
  backend
- Fix transport error handling in loop, tcp, fc and fcloop, and validate
  R2T offsets, inline data and queue IDs
- Remove namespaces in parallel
- Fix gendisk leak and subsystem lock deadlock on namespace and
  controller setup failures
- Stop asynchronous event work before ANA teardown
- Fix suspend when disabling the HMB fails
- Reject invalid timeout and reconnect_delay values
- Various target fixes for log pages, zns identify, write protect, PR
  allocations and ANA group IDs
- Merge duplicate PCI ID quirk entries
- Various dead code cleanups

----------------------------------------------------------------
Andrew Stellman (1):
      nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs

Avi Weiss (1):
      nvme-tcp: wait for in-flight TLS handshake callback

Guixin Liu (10):
      nvme-pci: remove write-only NVMEQ_DELETE_ERROR flag
      nvme-fc: remove dead seqno field in nvme_fc_queue
      nvme-auth: remove dead entry field in nvme_dhchap_queue_context
      nvme-fabrics: remove dead hostnqn already-assigned check
      nvme: drop unreachable "off" case in reconnect_delay_show()
      nvmet-fc: remove dead fields in nvmet_fc_ls_iod and nvmet_fc_tgt_queue
      nvmet: remove unreachable "pcie" entry from the address family map
      nvmet: passthru: remove unreachable break statements
      nvmet-pci-epf: don't drain the never-populated SQ list
      nvmet: use GFP_KERNEL for PR allocations

Kyle Smith (1):
      nvme: Fix potential gendisk leak in nvme_alloc_ns

Mani Tofigh (1):
      nvme: fix deadlock on nvme_subsystems_lock in nvme_init_subsystem()

Martin Belanger (3):
      nvme-tcp: use an aligned buffer for the TLS record type
      nvme-tcp: move the TLS record read loop into a helper
      nvme-tcp: consume TLS records without application data

Martin George (2):
      nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets
      nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret

Platon Miller (1):
      nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table

Qiliang Yuan (1):
      nvme: remove namespaces in parallel

Shao Mingyin (13):
      nvmet: zero the entire Get Log Page transfer buffer
      nvmet: zns: return the namespace lookup error for Identify
      nvme: reject invalid reconnect_delay sysfs values
      nvme-auth: use the parsed offset for the DH-CHAP key
      nvmet: handle short reads and writes in the file backend
      nvmet: use overflow-safe range checks in the file backend
      nvmet-auth: store the DH-CHAP key offset instead of hardcoding it
      nvme-loop: release the target request when SG setup fails
      nvmet-tcp: only wait for in-capsule data for inline SGLs
      nvme-tcp: require the R2T offset to match the data sent
      nvmet-fcloop: free the LS request when delivery fails
      nvmet-fc: reject duplicate queue IDs on Create Connection
      nvmet: roll back queue bindings on connection failure

Sreeraj S Kurup (3):
      nvmet: clean up DH group state on initialization failure
      nvmet: reject invalid write-protect feature values
      nvmet: synchronize DH-CHAP secret removal

Yaohan Li (1):
      nvme: stop asynchronous event work before ANA teardown

Yingjie Wang (1):
      nvme: avoid wrapping admin_timeout and io_timeout

Yuho Choi (1):
      nvme-pci: shut down the controller if disabling the HMB fails on suspend

 Documentation/ABI/stable/sysfs-nvme |   3 +-
 drivers/nvme/common/auth.c          |   6 +-
 drivers/nvme/host/auth.c            |   1 -
 drivers/nvme/host/core.c            |  44 ++++++---
 drivers/nvme/host/fabrics.c         |  10 +--
 drivers/nvme/host/fc.c              |   1 -
 drivers/nvme/host/multipath.c       |   7 ++
 drivers/nvme/host/nvme.h            |  13 ++-
 drivers/nvme/host/pci.c             |  35 +++-----
 drivers/nvme/host/sysfs.c           |  17 ++--
 drivers/nvme/host/tcp.c             | 175 ++++++++++++++++++++++++++++--------
 drivers/nvme/target/admin-cmd.c     |  52 ++++++++---
 drivers/nvme/target/auth.c          |  83 ++++++++++-------
 drivers/nvme/target/configfs.c      |   9 +-
 drivers/nvme/target/fabrics-cmd.c   |   3 +
 drivers/nvme/target/fc.c            |  16 ++--
 drivers/nvme/target/fcloop.c        |   2 +
 drivers/nvme/target/io-cmd-file.c   |  47 +++++++---
 drivers/nvme/target/loop.c          |   1 +
 drivers/nvme/target/nvmet.h         |   2 +
 drivers/nvme/target/passthru.c      |   2 -
 drivers/nvme/target/pci-epf.c       |   2 -
 drivers/nvme/target/pr.c            |  10 ++-
 drivers/nvme/target/tcp.c           |  42 ++++++---
 drivers/nvme/target/zns.c           |   3 +-
 25 files changed, 401 insertions(+), 185 deletions(-)


