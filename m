Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A06FC98321
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W4sbofbV0Vp/e+ibflMz4Gbn9twO9I95w5NKpZpnM/s=; b=z1LOsEwBIpwbw2CXHJU/bBkOX/
	8QKfoaVNzBvf1kuuU0tCdezzTIlo/mPQj9ZE2QXN35NRdI+UHNJM6W02Co7S99Xcme09kF7lDDzKw
	iOddLRr+SEGjO9cWU59WcVV5+uiZ3xOnbZkFJXeTy9wa1eXLm9yHqp/UWGAiux+6qxmGntWQ3Hr+t
	cXBNB/43eESVWu/e+Cr2ILQ3qOpPoB/sINfmVPh/tSmECXsiFg1bilwzZbpLZ39jYzvYC6Jm3Ce4n
	+eeye6Kqw8DXkPkEdMCEov1AHiNZTbMaBiaMuQ/e8BG38Cyyu6u5qdEuUQNNDtGZus/5m8cFDN2z4
	kznKh5yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA7kC-0000000Dlh9-2PbP;
	Fri, 25 Sep 2026 15:21:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA7kB-0000000Dlgs-2QvC
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 15:21:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6F8B60136;
	Fri, 25 Sep 2026 15:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756001F000FF;
	Fri, 25 Sep 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349706;
	bh=W4sbofbV0Vp/e+ibflMz4Gbn9twO9I95w5NKpZpnM/s=;
	h=Date:From:To:Cc:Subject;
	b=JMA8NxZ3dIz8WFjZNQ0pTnUUoqUmCLebfxw0NTfgiY3jR/CtS2DSDfPC9ekw9aW3f
	 KTaqS4QQUe2b241cCe+S+4pYQbVpeOH2kD05DSkVE4Uy55+WF0VGO28Z/Rh972QIDF
	 5GSgqjf9cQtA0UFcLvsFmQyzEZA1t3RfhLfAZsNfJG5FQWCk2DwA8qearc5mx478Eb
	 FYcTg1LjsJQcu68EQNWobLI1mA8m+bdbB4y2ByuKksbKFUq59OEnwsLsdHxRie/VyB
	 67dCOOY1cogTsOfBWq6M6L2B2tznxEO4yzxgRAF91rO8+BPHRi572v3bIWj4lhfJ0w
	 dD9sQnC44VkjA==
Date: Fri, 25 Sep 2026 09:21:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 7.3
Message-ID: <araRiDRUWyvJBca4@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 5067d4ba713961d8ccea1e06cd4c453793f3121e:

  sunvdc: fix -EIO issue due to lack of retries (2026-09-10 14:45:59 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.3-2026-09-25

for you to fetch changes up to 4a5e49ba0abb8b4328d6318c9aef0c0121f95507:

  nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known (2026-09-25 08:06:22 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.3

 - Fix use-after-free of the command effects log on multipath heads
 - Fix target namespace disable race with in-flight I/O and attribute
   changes
 - Fix out-of-bounds write in in-band authentication
 - Fix out-of-bounds reads parsing SGL segments and ANA logs
 - Fix zoned limits on multipath heads when the zone info query fails
 - Fix reservation preempt and abort matching against a nil host id
 - Fix lockdep key lifetime by reverting the per-socket dynamic keys and
   delaying socket reclassification past the TLS handshake
 - Fix controller reset and delete races that trigger spurious warnings
 - Add a dma pool alignment quirk for the Micron 4100AT
 - Preserve the target namespace device path on allocation failure
 - Fix -Wformat-security build warnings

----------------------------------------------------------------
Arnd Bergmann (2):
      nvme: work around -Wformat-security warning
      nvme: work around all -Wformat-security warnings

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT

Daehyeon Ko (2):
      nvme-multipath: fix underflow in ANA log bounds checks
      nvmet: pci-epf: reject too-short SGL segments

Eric Dumazet (1):
      nvme-tcp: delay nvme_tcp_reclassify_socket()

Guixin Liu (2):
      nvmet: copy the hostid into the ctrl before creating PR pc_refs
      nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known

Julian Sun (1):
      nvmet: preserve device path on allocation failure

Maurizio Lombardi (2):
      nvme-fc: do not warn on controller removal race
      nvme: do not reset controllers in NVME_CTRL_NEW state

Nilay Shroff (2):
      nvmet: defer setting ns->enabled to false in nvmet_ns_disable()
      nvmet: don't allow I/O admission after percpu ns reference is killed

Shin'ichiro Kawasaki (1):
      Revert "nvme-tcp: lockdep: use dynamic lockdep keys per socket instance"

Weiming Shi (1):
      nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

Yao Sang (1):
      nvme: fix command effects log lifetime for multipath heads

 drivers/nvme/host/core.c               | 63 +++++++++++++++-------------------
 drivers/nvme/host/fc.c                 |  2 +-
 drivers/nvme/host/multipath.c          | 19 +++++-----
 drivers/nvme/host/nvme.h               |  9 ++---
 drivers/nvme/host/pci.c                |  2 ++
 drivers/nvme/host/sysfs.c              |  4 +--
 drivers/nvme/host/tcp.c                | 39 +++++++--------------
 drivers/nvme/target/configfs.c         |  9 +++--
 drivers/nvme/target/core.c             | 33 +++++++++++-------
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 drivers/nvme/target/nvmet.h            |  2 ++
 drivers/nvme/target/pci-epf.c          |  3 ++
 12 files changed, 91 insertions(+), 96 deletions(-)


