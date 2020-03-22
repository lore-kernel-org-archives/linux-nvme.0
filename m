Return-Path: <SRS0=x4Ox=5H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46944C4332B
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182CC2072E
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNCaQgsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182CC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9lQNRk0y77po1Bj1liFlmn5vUD9LoI8ZRtAHB+9KHY0=; b=UNC
	aQgsIve4D5ibTUYLnxctvrFmUKuYOxLxJ45VD/NloykfpUy76SrZC5t2bdOza6VU4No4g1z4chSuG
	++idzsKN4IHCnFI3oIHfhUIXUakCSbVjWB5xP5UQvb22Ws/WM6poN+jNXCtzArcycpQbsYYfyfoF1
	sPau55citCtSxiS/nnsW1Es4Hm1YoORThPtnhrBKlHmjZBDcplUqK9MWkM35WVhXILWX8+1aa+Dh1
	dhGyG0wGjGXa5dkzRb9nBAKD0S6g1q2GUo1QAr+4PsQshPQgTiQoQUhSZxpq0WU46a6vyIQ+5pKKA
	Wj+zS8rkW0+369nGJ//igBb767DQGMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jG4tV-0007dY-QE; Sun, 22 Mar 2020 18:00:17 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jG4tK-0006Z0-4U
 for linux-nvme@lists.infradead.org; Sun, 22 Mar 2020 18:00:08 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 22 Mar 2020 19:59:57 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02MHxvS9004810;
 Sun, 22 Mar 2020 19:59:57 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/6 V2] nvme: Fixes for deleting a ctrl before it was created
Date: Sun, 22 Mar 2020 19:59:43 +0200
Message-Id: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200322_110006_594789_C7F3CB70 
X-CRM114-Status: UNSURE (   8.40  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Shlomi Nimrodi <shlomin@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The patchset starts with small cleanups, continue with the fixs and ends
with adding new warnings.
Calling nvme_sysfs_delete() when the controller is in the middle of
creation may cause several bugs. If the controller is in NEW state we
remove delete_controller file and don't delete the controller. The user
will not be able to use nvme disconnect command on that controller again,
although the controller may be active. Other bugs may happen if the
controller is in the middle of create_ctrl callback and
nvme_do_delete_ctrl() starts. For example, freeing I/O tagset at
nvme_do_delete_ctrl() before it was created or controller use after free
at create_ctrl callback.

Changes from v1:
 - Added Reviewed-by signatures
 - Patches reordering
 - New patches (2/6 and 3/6)
 - Split to 2 WARN_ON_ONCE (Patches 5/6 and 6/6)

Israel Rukshin (6):
  nvme: Remove unused return code from nvme_delete_ctrl_sync
  nvme-pci: Make nvme_pci_free_ctrl symmetric to nvme_probe
  nvme: Fix ctrl use-after-free during sysfs deletion
  nvme: Fix controller creation races with teardown flow
  nvme-rdma: Add warning on state change failure at nvme_rdma_setup_ctrl
  nvme-tcp: Add warning on state change failure at nvme_tcp_setup_ctrl

 drivers/nvme/host/core.c   | 18 ++++++++++--------
 drivers/nvme/host/fc.c     |  3 ---
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    | 10 ++++------
 drivers/nvme/host/rdma.c   |  9 ++++++---
 drivers/nvme/host/tcp.c    |  9 ++++++---
 drivers/nvme/target/loop.c |  3 ---
 7 files changed, 27 insertions(+), 26 deletions(-)

-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
