Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E2DC369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XBMNUFfE2AeTHIXskwTEs0bOV1pDNiLtFtXLgXdjcmg=; b=Juhu7iB5NW5F2e
	8UccFK/OZtjxytMyhe9jS0utJiYlpnquhWIqWQNoF2AWDjrJbKlUWpEWUCU2xKVwIOOp9IlEGG2A1
	rnMIDTEes16p1TsmGq3QEo9OB5npUAxVAKNOWMasuk9k686BqKoeXAOL72izUeRmu7nyEQabAawHc
	XGezqB7XZ7bpbY/mRUeVgdMBrUuafBTAD5S16L4SduCOjAE8BogTKoFuU5XQFb0CkwLuC1Z2Knm6K
	L8EWtOSzabXAup1PC3Wo0qVDfGham++5GeL6l1nRbPCF2iQ+Uw/U7AytZfwniaI+7PwrHPKKq4DE6
	QVe9yQJw16Q+0P9Pl+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qMy-0000000ALzX-37Xq;
	Thu, 10 Apr 2025 11:46:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHQ-0000000AKnh-1mkc
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4D1915C1043;
	Thu, 10 Apr 2025 11:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A884AC4CEDD;
	Thu, 10 Apr 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285271;
	bh=78Det0/D9k2bLPYo0jadQ6JWc+orCxvNYIetRM+uM4g=;
	h=From:Subject:Date:To:Cc:From;
	b=E+PckHIlJ+E6OH6AvZWwt8WCv9JzmvqF3ksK9DWs5x5ih9lyl3/5N/5cDojixGOtH
	 fN8Yp/Z2YuAj3jfDPHAPxOor5hFOnxoOKU63BxdMazU9NbN9bioBTfoZNtGMLj2gUE
	 DqjJPi5oHXH7MWT3/DMwzD8HXuFJhOuivhe6G3S3MfH4nQuqWJIEDjxUapIzXdodUM
	 dVu/NHpi4dBngkhf7MXfrwW3JsjA9cIqUpMpeuVnMjh4Jg9ZZG0n9ImDZtDQB8Fc5E
	 t4gziRXQVrFSk90X5AG9eWE2eUg8DYL3Sl4OW9VsORxVw0Mri8UNvHfHuMKv6ItzYP
	 1T3K2EkUIv70Q==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v4 00/14] nvmet-fcloop: track resources via reference
 counting
Date: Thu, 10 Apr 2025 13:41:03 +0200
Message-Id: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCu92cC/2WQS07DMABErxJ5jZF/ddKuuAdi4Tjj1qK1UztYo
 Kp3x02QIGE5I70nzdxIRvLI5NDcSELx2cdQg3pqiD2ZcAT1Q81EMLFjgisaygUTdfYc40iNVvt
 Wdn0LDVKRMcH5z1n3+lbzyecppq/ZXvij/REJvRYVThm1rB86OSgJbV7ekQLOzzEdycNUxC8tO
 d/QotLOKmZ7rTDgPy3/0t2GlpVmOwfLnGXC6RV9X2YlXD/qOdOyjVyQs5nPOTSzVbGNdTRpojF
 gmSY7AbtvTX2qX+vv35Bw9pKDAQAA
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044112_582572_C6ED920B 
X-CRM114-Status: GOOD (  14.96  )
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

The main changes are the reordering (so that the tests pass for each
patch) and holding the lock in fcloop_nport_alloc. Also I've
splitted the different changes so that it is simpler to follow, e.g.
'nvmet-fcloop: refactor fcloop_delete_local_port'

Note blktests nvme/030 test is likely to fail if the
70-nvmf-autoconnect.rules is active. In this case two discovery are
running in parallel and nvme-cli/libnvme gets out of sync. I don't see a
problem in blktests, but maybe I am just blind:

nvme/030 (tr=fc) (ensure the discovery generation counter is updated appropriately) [failed]
    runtime  1.843s  ...  1.719s
    --- tests/nvme/030.out      2023-08-30 08:39:08.428409596 +0000
    +++ /tmp/blktests/nodev_tr_fc/nvme/030.out.bad      2025-04-10 10:56:05.146372112 +0000
    @@ -1,2 +1,6 @@
     Running nvme/030
    +Failed to open ctrl nvme1, errno 11
    +Failed to open ctrl nvme1, errno 11
    +failed to get discovery log: Bad file descriptor

The host, target and fcloop work just fine:

[ 1434.556136] run blktests nvme/030 at 2025-04-10 10:56:03
[ 1434.779180] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1434.858814] nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1434.860275] (NULL device *): {0:0} Association created
[ 1434.861773] nvmet: Created discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:a94a718e-09b2-4b5b-898a-116845846761.
[ 1434.864704] nvme nvme1: NVME-FC{0}: controller connect complete
[ 1434.865082] nvme nvme1: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:a94a718e-09b2-4b5b-898a-116845846761
[ 1434.871357] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1434.953940] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[ 1434.954581] (NULL device *): {0:0} Association deleted
[ 1435.007936] (NULL device *): {0:0} Association freed
[ 1435.009560] (NULL device *): Disconnect LS failed: No Association
[ 1435.060507] nvme nvme2: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1435.061682] (NULL device *): {0:0} Association created
[ 1435.062499] nvmet: Created discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1435.064831] nvme nvme2: NVME-FC{1}: controller connect complete
[ 1435.065244] nvme nvme2: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1435.070407] nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1435.143134] (NULL device *): {0:0} Association deleted
[ 1435.181772] (NULL device *): {0:0} Association freed
[ 1435.182360] (NULL device *): Disconnect LS failed: No Association

When disabling the udev rule this test will pass.

This series goes on top of [1]. I've already collected some more patches,
e.g. fixing the '(NULL device *)' log output. But let's get this first
sorted out.

[1] https://lore.kernel.org/all/20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org/

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v4:
- reordered patches so that they pass the tests each on of its own
- addressed feedback from Christop, Hannes and James.
- hold lock while looking up nport and insert nport operation in fcloop_nport_alloc
- dropped patches from 20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org
- Link to v3: https://lore.kernel.org/r/20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org

Changes in v3:
- fixed memory leaks
- allocates fcloop_lsreq in fcloop directly
- prevent double free due to unregister race
- collected tags
- Link to v2: https://lore.kernel.org/r/20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org

Changes in v2:
- drop tport and rport ref counting, use implicit synchronisation
- a bunch of additional fixes in existing ref countig
- replaced kref with refcount
- Link to v1: https://lore.kernel.org/r/20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org

---
Daniel Wagner (14):
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: refactor fcloop_nport_alloc and track lport
      nvmet-fcloop: refactor fcloop_delete_local_port
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: access fcpreq only when holding reqlock
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fcloop: don't wait for lport cleanup
      nvmet-fcloop: drop response if targetport is gone
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvme-fc: do not reference lsrsp after failure

 drivers/nvme/host/fc.c       |  13 +-
 drivers/nvme/target/fc.c     |  85 +++++++--
 drivers/nvme/target/fcloop.c | 437 ++++++++++++++++++++++++++++---------------
 3 files changed, 364 insertions(+), 171 deletions(-)
---
base-commit: 70289ae5cac4d3a39575405aaf63330486cea030
change-id: 20250214-nvmet-fcloop-a649738b7e6e
prerequisite-message-id: 20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org
prerequisite-patch-id: 5609b665472db8125a4f1f920968cc39c96183d2
prerequisite-patch-id: 2a94f274688ff575b94f91f89f200cc909baf45c
prerequisite-patch-id: b16688fc6fa83015f2c4a0c51d2efc332489ec82
prerequisite-patch-id: 69de6f3a56ef97a0c538aeb0dddb55e23f75145f
prerequisite-patch-id: 22b574d0f00c75602bde3bd57830558b9f254be9
prerequisite-patch-id: 2c152988159cdbd472319c5e53e389512f814eaf
prerequisite-patch-id: db9c266ce9b624a93e670212034daae7a65975df
prerequisite-patch-id: 9441bab1a48608cab69f198afed7f5cc05832306

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


