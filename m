Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD35C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=avvqaRN2SjmRVsthHLPqt7SLtudB6a3Mbu7hhPbcWa4=; b=J00ea012JgxvaD4TYU1OF1DKM7
	5MqkyuWVad+lPTagY3lz2tv67A06kKy/eM0qfgb/rOjaLaDiyE2NVD24ML5oiKklmWY8BknnfYnLy
	oNqoVQGg/Mc8QFpKUZHrJI/xxjNfG4/E7gkMLg1mgqaTA9my3GNxEQXfZfA3EnWpSpNgZ2E+Yibzc
	zAQ/1+CzaYW9SfhKGM1XnghVQEdgV8D/qvoNGoR/1FqqdDJPi0z5VBLCJs92bk/knMKCtBw7nEM5d
	N1GJ6JZUvs9MBQz3SG9EHh71pspI67HYbHcOYf+6kEwiWWd1J757ZxxCOcIyikd8Q+UfJoKdTLfoy
	U+8Pddpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAvyP-00HaJ6-7W; Thu, 29 Dec 2022 16:41:41 +0000
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAvyM-00HaGJ-6u; Thu, 29 Dec 2022 16:41:38 +0000
Date: Thu, 29 Dec 2022 06:41:37 -1000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y63DQSUSW4aQlVJ+@infradead.org>
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

The following changes since commit 88d356ca41ba1c3effc2d4208dfbd4392f58cd6d:

  nvme-pci: update sqsize when adjusting the queue depth (2022-12-26 12:10:51 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-29

for you to fetch changes up to 76807fcd73b818eb9f245ef1035aed34ecdd9813:

  nvme-auth: fix smatch warning complaints (2022-12-28 06:26:35 -1000)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix various problems in handling the Command Supported and Effects log
   (Christoph Hellwig)
 - don't allow unprivileged passthrough of commands that don't transfer
   data but modify logical block content (Christoph Hellwig)
 - add a features and quirks policy document (Christoph Hellwig)
 - fix some really nasty code that was correct but made smatch complain
   (Sagi Grimberg)

----------------------------------------------------------------
Christoph Hellwig (7):
      docs, nvme: add a feature and quirk policy document
      nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
      nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
      nvmet: set the LBCC bit for commands that modify data
      nvmet: don't defer passthrough commands with trivial effects to the workqueue
      nvme: also return I/O command effects from nvme_command_effects
      nvme: consult the CSE log page for unprivileged passthrough

Sagi Grimberg (1):
      nvme-auth: fix smatch warning complaints

 .../maintainer/maintainer-entry-profile.rst        |  1 +
 Documentation/nvme/feature-and-quirk-policy.rst    | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/nvme/host/auth.c                           |  2 +-
 drivers/nvme/host/core.c                           | 32 +++++++--
 drivers/nvme/host/ioctl.c                          | 28 ++++++--
 drivers/nvme/target/admin-cmd.c                    | 37 ++++++-----
 drivers/nvme/target/passthru.c                     | 11 ++--
 include/linux/nvme.h                               |  4 +-
 9 files changed, 159 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/nvme/feature-and-quirk-policy.rst

