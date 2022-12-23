Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECC2C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NlcIbrvAYv8k4irT80qgnasXuOdtRChl00T25AgRYTE=; b=mqYrncoL8Zx7z2aY6/APhVKnEG
	J4XvhcBSEDaxvQWsGnnaiZxSKkTPcO7cqhudMagQjTZNa6nBqrhkPfpxjQU9xzHVbvXltSt1iH3BW
	k1zaj+EUavTHhJ1d5Zc7Rcw6I3cXZiTX7f0X716pT50BaYdwZRF1PApF5y8QVc5Vd+gftF6M5tQSS
	PtVjWbEdz5yeSpk8hKCRy2aHDT+xrpjAMTH7ia+yRcDs4Y1RFFCFR4Qi9iCerftOeNCkcvhfkpZkZ
	fBzH7dXPmeG1kKs80qVsvxqam1eZgMtVKxomCtcNt9J3YrDgqxWux/QMOd9QWKqq3gzwnWx2jRFtw
	wnP7GDyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cJx-004hke-K6; Fri, 23 Dec 2022 07:18:21 +0000
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cJs-004hgv-J3; Fri, 23 Dec 2022 07:18:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: only allow unprivileged passthrough for commands without effects v4
Date: Fri, 23 Dec 2022 08:18:08 +0100
Message-Id: <20221223071814.43564-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
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

Hi all,

this series first fixes a few minor issues in the CES log support in the
host and target drivers and then uses the log to deny unprivileged
passthrough of commands that have effects, where the only practically
relevant effect is the modification of contents of the data stored in the
namespace.

Changes since v3:
 - clear NVME_CMD_EFFECTS_CSE_MASK for I/O commands

Changes since v2:
 - drop various cleanups and aim for a minimum viable fix for 6.2
 - fix the NVME_CMD_EFFECTS_CSE_MASK definition
 - don't allow unprivilged passthrough without a Commands Supported and
   Effects log

Changes since v1:
 - make sure ctrl->effects an nshead->effects is always available
 - initializse known effects at init time
 - remove the use_workqueue field in nvmet_req
 - fix up a commit message

Diffstat:
 drivers/nvme/host/core.c        |   32 ++++++++++++++++++++++++++------
 drivers/nvme/host/ioctl.c       |   28 ++++++++++++++++++++++++----
 drivers/nvme/target/admin-cmd.c |   37 +++++++++++++++++++++----------------
 drivers/nvme/target/passthru.c  |   11 +++++------
 include/linux/nvme.h            |    4 +++-
 5 files changed, 79 insertions(+), 33 deletions(-)

