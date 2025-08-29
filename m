Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE29CA1000
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fjrew8JTEZGlHuKnba61MOuxan5lOzmGdEYMxX+gwJA=; b=BvQ8ji11a7ZCjW
	LKxVcx+kohHkiso5471U33xKdIm+4ZmGu+e8ZCwK/dHb5k5Pt2FUC6B/TsJXTR2j6M23Oj1z4B154
	7l/ZY4K8v9RGz2mz9r1bDPCvtp5/lOKLlOZL3+szmXaP26HWwM2amMzNRAc4uPnTCcfvhlR1p4Z8A
	A7+jlPpZT/shWU7NR76BXwDqYIJbBst0tLkDP+UwnDdaf1Mi8ih+XuraoqqhRDmYqu2T22KNXz0oW
	4Q6eYsxZcu6/qyvNjBQedBFKe7RZ1YgE+ajvHArIC8kY5/Cm1pQyogTP0553BsJmMrsStTD9E2PiJ
	iQYZ7DC74HRovf+dxp3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4tK-00000006l04-0586;
	Fri, 29 Aug 2025 19:36:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1AT-00000006Dp4-0gli
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:37:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 901F3601B7;
	Fri, 29 Aug 2025 15:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9143C4CEF5;
	Fri, 29 Aug 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481852;
	bh=6pYeQyWaLKkJ+BDYnkitu7taheegSWA/VRkcoPPeuFc=;
	h=From:Subject:Date:To:Cc:From;
	b=pIjAQDXyzdlj5WrHtUK2PprPk85Eox3uJ3Ll++ZaxwmNCzgc800J5dZEjnEoscpxK
	 g7VE/Bftpxl7dDT4AfYcYUmgEKc7Mn+HgWHmpjme1OWhagExjmCKnkDa3gYc5wnPyY
	 QxZE2eZUWMNIvFJWZZfLfuE+K26s1THlRE6hFad43AnHPQU67lb0alisdvAZDHmwo7
	 RHbDkgf6V65UMj7HSPudQBM0CJFNgxprxKc2FY6tyYK7WKkL0FzLyT6RP8PJ4B49TX
	 9+sF/C+zO9f2DLb14/ORluMiD5lKRuTpBllfggv+6lPIenyIJhSLgBs17TYH2xW57L
	 S7LhsAXeGX0QA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
Date: Fri, 29 Aug 2025 17:37:24 +0200
Message-Id: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTJsWgC/y3MQQ5AMBCF4avIrE3StCmNq4gFNZiFokWIuLsGy
 +8l778gkGcKUCQXeNo58OQiVJqAHWrXE3IbDVJILYw06PaRsLMYTmexaWyuapVJrVuIl9lTx8e
 bK6vPnpYtVtd/vO8HWH0sE3MAAAA=
X-Change-ID: 20250828-nvme-fc-sync-bbc73a36255d
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

Another attempt to get the nvme/041 fixed. I've decided to make the
synchronous connect an opt-in feature, so that we don't break existing
users. I need to do some changes for libnvme and nvme-cli so all works
fine when users update either the userspace or kernel.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
v3:
 - rebased to current master
 - use explicit initial connect flag to distiguish between retry and
   initial connect. Necessary to keep nvme/061 working.
 - added 'nvme-fc: refactore nvme_fc_reconnect_or_delete'
 - updated commit messages

v2:
 - renamed flag to connect_async, default false
 - add info to commit message why nvme-fc is different
 - merged connect_async with 'nvme-fc: wait for
   initial connect attempt to finish'
 - https://lore.kernel.org/all/20240221132404.6311-1-dwagner@suse.de/

v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
 - https://lore.kernel.org/linux-nvme/20240219131531.15134-1-dwagner@suse.de/

v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

---
Daniel Wagner (4):
      nvme-fabrics: introduce ref-counting for nvmf_ctrl_options
      nvme-fc: reorganize ctrl ref-counting and cleanup code
      nvme-fc: refactore nvme_fc_reconnect_or_delete
      nvme-fc: wait for initial connect attempt to finish

 drivers/nvme/host/fabrics.c |  40 ++++++++-
 drivers/nvme/host/fabrics.h |   9 +-
 drivers/nvme/host/fc.c      | 212 ++++++++++++++++++++++----------------------
 drivers/nvme/host/rdma.c    |  18 ++--
 drivers/nvme/host/tcp.c     |  21 +++--
 drivers/nvme/target/loop.c  |  19 ++--
 6 files changed, 192 insertions(+), 127 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250828-nvme-fc-sync-bbc73a36255d

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


