Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F63C98314
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 06:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BLjTucnskYFPnXZ/t5mCS2g+YhXjILPqbJ46OorNHF4=; b=NZDplLAdliN4toyQnFuN9F0/db
	X+gRvBjnPs9cCbNSh4QKlziH59NnOIJ6In2tQIa/U/syeInuagZZyj+drHumCzz4LpRI/gnBFzLaP
	5xLMifxFGTdjBDJZag32JdchLbFJr2XXax48rIk62+3ec2hT6vpvJ+4OHepP7y9Hm+OrJfStERgEp
	/ILM0UVT+p8oZjvVlIlubrkCThvDlQQmrjWqb4nlpyVHp2akLO+Z3Aq2JDLD8wmnUmJvPXAlbyrOn
	bRBPJXP1V8H57WBITZShQpQXw1Gx5c5NuMRQCZJVF/9gyncAaEe0kLpH960hVGuq1iY2YyXW5OXf4
	IbBAf64Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ck1-0000000A8L0-0qH8;
	Thu, 24 Sep 2026 06:15:33 +0000
Received: from out28-218.mail.aliyun.com ([115.124.28.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9cjy-0000000A8Jy-00ql
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 06:15:32 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9211186|0.1179926;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.148357-0.00344818-0.848195;FP=7738451504425728954|3|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jLtpbfj_1790230515;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpbfj_1790230515 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:22 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Liao Xuan <liaoxuan@hygon.cn>
Subject: [PATCH 0/3] Add adaptive NVMe link rate switching function
Date: Thu, 24 Sep 2026 14:15:10 +0800
Message-ID: <cover.1790222172.git.liaoxuan@hygon.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_231530_384608_606D107C 
X-CRM114-Status: GOOD (  12.08  )
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

From: Liao Xuan <liaoxuan@hygon.cn>

NVMe devices are commonly left trained at the maximum PCIe link rate
even when there is little or no I/O activity, which wastes power in
both the device and the surrounding platform.

This series adds adaptive PCIe link rate switching to the NVMe host
driver. The link is downgraded to a configurable minimum rate when
I/O activity is low to save power, and upgraded back to the maximum
supported rate as soon as the workload requires it, so that peak
performance is maintained under load.

The amount of transferred data is accumulated on the submission path
with per-CPU counters and evaluated by a per-controller timer. The
switch threshold is derived from the bandwidth of the minimum and
maximum link rates such that the extra time required to transfer the
data at the minimum rate does not exceed the estimated link retraining
time. The controller queues are frozen while the link is retrained
and resumed afterwards, so no I/O is lost or times out during the
switch.

The main functions of each patch are as follows:
1. Patch 1 adds the core switching functionality. It uses the target
link speed interface of the PCIe bandwidth controller, which is
exported for this purpose.

2. Patch 2 adds hysteresis and idle detection to the switching policy.
The link is upgraded immediately once the threshold is exceeded, but
only downgraded after a number of consecutive below-threshold windows,
which prevents excessive rate toggling under fluctuating workloads.
Monitoring is stopped after a period of inactivity and re-armed by the
next I/O.

3. Patch 3 exposes the switching parameters (enable, monitor_interval,
min_speed, up_threshold, down_threshold) via sysfs so that the
power/performance trade-off can be tuned at runtime without a reboot.

The feature is currently enabled on Hygon platforms.

Liao Xuan (3):
  nvme: Add adaptive PCIe link rate switching function
  nvme: Add hysteresis and idle detection to link rate switching
  nvme: Expose link rate switching tunables via sysfs

 drivers/nvme/host/Kconfig        |  10 +
 drivers/nvme/host/Makefile       |   1 +
 drivers/nvme/host/core.c         |   4 +
 drivers/nvme/host/nvme.h         |  50 ++++
 drivers/nvme/host/pci.c          |   4 +
 drivers/nvme/host/speed_switch.c | 424 +++++++++++++++++++++++++++++++
 drivers/nvme/host/sysfs.c        | 143 +++++++++++
 drivers/pci/pcie/bwctrl.c        |   1 +
 8 files changed, 637 insertions(+)
 create mode 100644 drivers/nvme/host/speed_switch.c

-- 
2.43.0


