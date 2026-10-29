Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B2606A31D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ppIL/obA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlpyuQuP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=e480GSx6sWTfsoDyNTsUPHLIbZ8HIthuF61naTqYYj8=; b=ppIL/obAjw9JpO0pIlAOVLmw08
	ABFJM6/DQ/tfDDvwYqKdCRLGwK7mPvXLmTzV0VKhftTqaNfehSG2/DJ+cjQPdeJUBxTy9i7kR+JtN
	xLp8YluV38ykVAN6TpdCEZ3Fz90a216UeawxuQyhJc6nRKuSgBjEevVgpGIbuJPsaelhA+XT3bazN
	v9F23iq4UoRZPDP4wAXJl0/rHu/ceDZ7/GOlrgiIZxvNtsVfysGr3klwdbfDQi1escqXXgBSsn766
	gQKLYzWi2IfwvQcH9DBrXSr4h6W+jnlGsN0Za9XuJhoSgOK/nC2uhf1Jo6bLgiGkIwj+uvkhHDfPL
	O0bGhRBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRD8-00000009X3w-3RL9;
	Thu, 29 Oct 2026 14:34:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRD6-00000009X3k-2QM1
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 14:34:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79A266012A;
	Thu, 29 Oct 2026 14:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091721F01825;
	Thu, 29 Oct 2026 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284471;
	bh=e480GSx6sWTfsoDyNTsUPHLIbZ8HIthuF61naTqYYj8=;
	h=Date:From:To:Cc:Subject;
	b=MlpyuQuPp4eg70Kg6QnaTK6d71lg9QIBJCbPHGRN0ZQXupB6FxxSn332gBMrLpdSK
	 SprMRVc7LaKcg/O+YdFexVoNyxfA5+HmtBrgwrN4ME5eCqpbiIwjGtH8FrrKvGKYxJ
	 pDTpDuj/wAY9rk1lUd4aoV/BpBvvoeqUbQROTZPGYhipWqsCfp3DA/7pR+v6l8L1Ei
	 SU55dyrhOhlxSWFNzWqp8sxmoD/npLaJjbZoDjIj5Zc33qdJbTaQqw2ZumrOkqKHsc
	 QOlvHsTWyMZ/wlytOvDo8/x01PVlXs0w3M6GekoFSwOBM5DU5fJ9my4Bx8pG92Wczu
	 TWSzOPwrpCETQ==
Date: Thu, 29 Oct 2026 08:34:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 7.4
Message-ID: <auNZdZx2COp-NCyI@kbusch-mbp>
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

The following changes since commit 40d070cbb1906896d6fd65c39722d2411830ed9f:

  block: restore the iterator when rejecting a misaligned bio (2026-10-20 11:11:45 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.4-2026-10-28

for you to fetch changes up to 89480d137bf0d943a82c64f86ae2407a15276b5e:

  nvmet: don't clear sq->ctrl for a Connect with sqsize 0 (2026-10-28 11:41:43 -0700)

----------------------------------------------------------------
nvme updates for Linux 7.4

 - Fix regressions from the parallel nvme-tcp I/O queue setup: request
   PDU sizing with header digest, a NULL controller dereference when
   reconnecting with more queues, and early lock initialization
 - Handle TLS control records in nvme-tcp: skip records arriving ahead
   of the ICResp, and start error recovery when the socket read fails
 - Fix an nvme-tcp io_work priority inversion stalling I/O
 - Fix nvme-tcp address attribute race with queue teardown
 - Validate the TLS handshake timeout parameters for host and target
 - Fix fabrics connects with isolated CPUs and queue mapping bugs
 - Fix early boot hang and buffer size for the nvme.quirks parameter
 - Fix nvme-rdma NULL metadata SGL dereference with T10-PI
 - Fix ANA underflow check and an nvme-fc discovery reference leak
 - Fix nvme-loop BUG() when a namespace scan races a reset
 - Target port and configfs locking fixes, and port removal races
 - Target auth fixes for CHALLENGE failure and negotiation handling
 - Target fc fixes for a connection use-after-free, read data on failed
   commands, and admin queue allocation failure teardown
 - Target rdma fix for short connection requests
 - Target rdma fix for inline SGL out-of-bounds write
 - Target rdma refcount, locking, and module unload fixes
 - Target pci-epf SGL length and error status fixes
 - Target NULL dereference fixes for pci-epf and debugfs
 - Target ZNS NUMD overflow check
 - Target Connect fix for a controller leak with a zero queue size
 - Target fixes for a metadata SGL double-free and a leaked blk plug
 - Target fix for truncated large discards
 - Misc cleanups

----------------------------------------------------------------
Andrea Parri (4):
      nvmet-fc: only send read data for successful commands
      nvmet: zns: reject a NUMD whose byte count wraps
      nvmet: pci-epf: report transport errors in command completions
      nvmet: pci-epf: require SGLs to match the command data length

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Avi Weiss (1):
      nvmet: prevent double-free after metadata SGL allocation failure

Chris Mason (4):
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0

Christian Aurich Zanettini Martins (3):
      nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
      nvme-tcp: fix request PDU size when header digest is enabled
      nvme-tcp: fix NULL queue->ctrl dereference on reconnect

Daniel Wagner (4):
      nvme-tcp: initialize pf_cache_lock when allocating the controller
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

Guixin Liu (4):
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvme-tcp: Validate the queue state under the queue lock in the address attribute
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Josef Bacik (7):
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet: fix NULL dereference of PCI endpoint targets
      nvmet-tcp: stop listening when a port is removed
      nvmet: fix NULL dereference in debugfs host_traddr
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset

Martin Belanger (2):
      nvme-tcp: start error recovery when read_sock fails
      nvme-tcp: skip TLS control records while waiting for the ICResp

Martin George (3):
      nvme-auth: update error log in nvme_auth_submit()
      nvme-multipath: avoid size_t underflow in ANA log bounds checks
      nvme-fc: fix reference leak in nvme_fc_nvme_discovery_store()

Maurizio Lombardi (2):
      nvme-pci: fix early boot hang with nvme.quirks parameter
      nvme-pci: increase quirks_param buffer size to 256 bytes

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Seiji Nishikawa (1):
      nvme-tcp: fix io_work priority inversion when send_mutex is held

Shao Mingyin (1):
      nvmet-auth: fix error handling on CHALLENGE failure

Weiming Shi (1):
      nvmet-rdma: reject short connection requests

Yehyeong Lee (1):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()

Yingjie Wang (2):
      nvmet-tcp: validate the TLS handshake timeout
      nvme-tcp: validate the TLS handshake timeout

Yu Zhang (1):
      nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()

 Documentation/admin-guide/kernel-parameters.txt |  10 +
 drivers/nvme/host/auth.c                        |   6 +-
 drivers/nvme/host/fabrics.c                     |  30 ++-
 drivers/nvme/host/fc.c                          |   7 +-
 drivers/nvme/host/multipath.c                   |   4 +-
 drivers/nvme/host/pci.c                         |   4 +-
 drivers/nvme/host/rdma.c                        |   2 +-
 drivers/nvme/host/tcp.c                         | 309 +++++++++++++++++++-----
 drivers/nvme/target/auth.c                      |   1 +
 drivers/nvme/target/configfs.c                  |  26 +-
 drivers/nvme/target/core.c                      |  16 +-
 drivers/nvme/target/fabrics-cmd-auth.c          |  11 +-
 drivers/nvme/target/fabrics-cmd.c               |   3 +-
 drivers/nvme/target/fc.c                        |  18 +-
 drivers/nvme/target/io-cmd-bdev.c               |   8 +-
 drivers/nvme/target/loop.c                      |   2 -
 drivers/nvme/target/nvmet.h                     |   3 +-
 drivers/nvme/target/pci-epf.c                   |  30 ++-
 drivers/nvme/target/rdma.c                      |  31 ++-
 drivers/nvme/target/tcp.c                       |  33 ++-
 drivers/nvme/target/zns.c                       |  12 +-
 21 files changed, 436 insertions(+), 130 deletions(-)


