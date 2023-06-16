Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0258EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ys6G0pTwp4aBI9CVuLkOfmcIUjHini73Gmj3fyYVl0E=; b=TkZW33hcNRJOT9b4RPplteEgdS
	8JeTp8VXgZLsLdajlQ7RQFc3Znb0QJ6TKpAO/o9GbYkPV5TlGalEEDwkQxqq5vBLJppz5U85rsot6
	CxawWd5CTR/5KYqvT/buxcvFboJy65pF/82RCNd/Hj/cAk4HGiKclz+mHsd+uSdr+UkEf+OZiwSHw
	BLIByhtqHUoaWFpVeWqZvkDuDAq7r/yzQBQDi5sRfA8maTOlJQhRdPZm9vxSkp26l6uSMQ4Kw35KE
	3QfOVK9I1SYaWslvTQjabNgTmXkgEflzjJsprSYIUQOh1a2Ua7yGLU7yAJn4tX90psG07+581NuG+
	q+xiQyTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qABai-000zOE-3C;
	Fri, 16 Jun 2023 15:42:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qABad-000zNF-0U
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 15:42:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4E160DDA;
	Fri, 16 Jun 2023 15:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E52C433C9;
	Fri, 16 Jun 2023 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686930136;
	bh=P11ngKNRhmZMFj7x+YlL9Erx/sRMBz3aL7vz8ORLxlk=;
	h=Date:From:To:Cc:Subject:From;
	b=l6yg6SsmB6yEfKQ8Nb9PawL//JBzEbeCN6Xre/Jy2Cy3QcAgd6+/HFHjRVW32ZWdv
	 XVsCu7GER0bVsVoMdxmDUVYPrc/vHG/TYikFVEMtNQWfBv+Pz8oVZZlXVo0jxu3hWW
	 U+rPaqyIcaQVpu/IfR9JkijLA9PXpm4lYdSpr716IaG5aoldl7zyre/mOvAwXUYemo
	 pEumNn+DtgFCS8Oa058TDtx1wBVHz/GWvVr/pLZDCzkuARZX+3sHD6qc6U7FMNmZC0
	 xCP4lfy9p1B9anCLMckz8o9MLPYLZknNChnYD2G8/OxSOQU3h2dLEcM4tH2jbYFyrb
	 j+QscxpGPQHBA==
Date: Fri, 16 Jun 2023 09:42:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: [GIT PULL] nvme-6.5 updates
Message-ID: <ZIyC1vvj9ZX7RkHq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_084219_285329_B5256C2F 
X-CRM114-Status: GOOD (  13.19  )
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

This is our first pull request for the 6.5 merge window. There will be a
minor conflict when merging to Linus' tree, and the resolution is to
simply delete the entire conflicting block.

The following changes since commit 4f1731df60f9033669f024d06ae26a6301260b55:

  blk-mq: fix potential io hang by wrong 'wake_batch' (2023-06-12 09:55:53 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.5-2023-06-16

for you to fetch changes up to 1c606f7f056b266a84482d5522d35bbbbed062db:

  nvme: forward port sysfs delete fix (2023-06-16 08:15:57 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.5

 - Various cleanups all around (Irvin, Chaitanya, Christophe)
 - Better struct packing (Christophe JAILLET)
 - Reduce controller error logs for optional commands (Keith)
 - Support for >=64KiB block sizes (Daniel Gomez)
 - Fabrics fixes and code organization (Max, Chaitanya, Daniel Wagner)

----------------------------------------------------------------
Chaitanya Kulkarni (8):
      nvme-core: fix memory leak in dhchap_secret_store
      nvme-core: fix memory leak in dhchap_ctrl_secret
      nvme-core: add missing fault-injection cleanup
      nvme-core: fix dev_pm_qos memleak
      nvmet-auth: remove unnecessary break after goto
      nvme-fcloop: no need to return from void function
      nvme-fabrics: error out to unlock the mutex
      nvme-fabrics: open code __nvmf_host_find()

Christophe JAILLET (6):
      nvmet: reorder fields in 'struct nvmet_sq'
      nvme: reorder fields in 'struct nvme_ctrl'
      nvmet: reorder fields in 'struct nvmf_ctrl_options'
      nvmet: reorder fields in 'struct nvme_dhchap_queue_context'
      nvmet: reorder fields in 'struct nvmefc_fcp_req'
      nvmet-auth: remove some dead code

Daniel Gomez (1):
      nvme: Increase block size variable size to 32-bit

Daniel Wagner (1):
      nvmet-fcloop: Do not wait on completion when unregister fails

Irvin Cote (3):
      nvme-pci: cleaning up nvme_pci_init_request
      nvme-core: remove redundant check from nvme_init_ns_head
      nvme-core: use nvme_ns_head_multipath instead of ns->head->disk

Keith Busch (3):
      nvme-fabrics: add queue setup helpers
      nvme: skip optional id ctrl csi if it failed
      nvme: forward port sysfs delete fix

Max Gurtovoy (5):
      nvme-rdma: fix typo in comment
      nvme-fabrics: unify common code in admin and io queue connect
      nvme-fabrics: check hostid using uuid_equal
      nvme-fabrics: prevent overriding of existing host
      nvme: move sysfs code to a dedicated sysfs.c file

 drivers/nvme/host/Makefile             |   2 +-
 drivers/nvme/host/auth.c               |   6 +--
 drivers/nvme/host/core.c               | 663 ++++++------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/nvme/host/fabrics.c            | 241 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 drivers/nvme/host/fabrics.h            |  21 +++++++---
 drivers/nvme/host/nvme.h               |  11 ++++--
 drivers/nvme/host/pci.c                |   3 +-
 drivers/nvme/host/rdma.c               |  81 +++------------------------------------
 drivers/nvme/host/sysfs.c              | 668 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c                |  92 +++-----------------------------------------
 drivers/nvme/target/fabrics-cmd-auth.c |  13 -------
 drivers/nvme/target/fcloop.c           |   5 +--
 drivers/nvme/target/nvmet.h            |   2 +-
 include/linux/nvme-fc-driver.h         |  10 ++---
 14 files changed, 903 insertions(+), 915 deletions(-)
 create mode 100644 drivers/nvme/host/sysfs.c

