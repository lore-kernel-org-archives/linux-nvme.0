Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A8DC43602
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JzTahqbJIGFsTQPAMqduH2v9Y2mo0ojfy5QvuRc2Qgg=; b=xJ8HlSNmH99DKz8M9l0ANEnkRN
	6QRmYH1nDjqd4M+7hSsnhmw4r+Z8dnFO9IaRR7i2Zocf1wjTb00l1a++SDCYxR9jI4aw5mHgtVYWF
	k+fA+WYvzesMYGZsIwzfL2xPUSRy52LNNTtTJkUcH6xBHkQN3rwQR9BfHVuvsTJwh1jIpReyUya5k
	rvRjyEEBOZUFMw0BEKGpiYrlEHT5BmaBjgKOxRh/4AqtVk69ASco+cAts7Y6C+ub8hrs8iUmkQI1q
	BjNDMQ97S7U6gfxTS436tKUGu7LXd90NagRLRdB4VKcXnhIL6hepPtipLQ+aOKHtFBsdj+BKIQbxB
	jG0XVgKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4fB-0000000EvNs-12E1;
	Tue, 07 Jul 2026 12:12:33 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4f8-0000000EvMY-39IR
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 12:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783426348; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JzTahqbJIGFsTQPAMqduH2v9Y2mo0ojfy5QvuRc2Qgg=;
	b=jyD+9bud75N9En0vg3s/oE6hFXQx25GY0fpJ7RnMxbcwA81JRz38il1WmYR5YBCdu7CSYxoJGPX30O+WNsJ+YM8WyvOW/gw+WA220466SczkWKTuQsivvXmoLBNyf5fm3oO6nW9rTAIvI48XBklL9bE+vcgxTjyTJpXEk5tcpw8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6dVpNS_1783426347;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6dVpNS_1783426347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 20:12:27 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v4 0/3] nvme: add ABI documentation for sysfs and configfs interfaces
Date: Tue,  7 Jul 2026 20:12:24 +0800
Message-ID: <20260707121227.2274769-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_051230_953108_9F9D4876 
X-CRM114-Status: GOOD (  12.21  )
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

The NVMe host sysfs interfaces and target configfs interfaces lack
ABI documentation under Documentation/ABI/. This series adds the
missing documentation and updates MAINTAINERS accordingly.

Each attribute entry has been traced back to its original introducing
commit via git archaeology to provide accurate Date, KernelVersion,
and Contact information.

This documentation was created with the assistance of AI (Claude)
for git history tracing and document formatting.

Patch 1 adds Documentation/ABI/stable/sysfs-nvme for host sysfs.
Patch 2 adds Documentation/ABI/stable/configfs-nvmet for target configfs.
Patch 3 adds missing F: entries in MAINTAINERS for NVMe documentation.

v3->v4:
 - Move the documentation from Documentation/ABI/testing/ to
   Documentation/ABI/stable/, since the NVMe host sysfs and target
   configfs interfaces are long-established, stable ABI (Daniel Wagner).
 - Add Reviewed-by tag from Daniel Wagner in the first patch, and from
   Nilay Shroff in all three patches, thanks.

v2->v3:
 - sysfs: document the namespace diagnostic counters as two separate
   entries, one for non-multipath configurations (/sys/block/nvmeXnY/)
   and one for multipath configurations (/sys/block/nvmeXcYnZ/ per-path
   and /sys/block/nvmeXnY/ head), so the actual sysfs location of each
   counter is obvious without per-attribute visibility notes.
 - sysfs: keep all diagnostic counters (controller and namespace)
   adjacent for easier browsing.
 - sysfs: document the per-path attributes ana_grpid, ana_state,
   queue_depth and numa_nodes under /sys/block/nvmeXcYnZ/ to reflect
   their real location, dropping the now-redundant "only visible on
   per-path devices" wording.
 - Add Reviewed-by tag from Hannes Reinecke in the first two patches,
   thanks.

v1->v2:
 - sysfs: group all TLS attributes together and reorganize the file by
   device class (controller, namespace, subsystem), keeping related
   attributes grouped within each class; split the combined
   passthru_err_log_enabled entry into controller and namespace entries.
 - configfs: group attributes by object type (ports, subsystems,
   hosts), merge dhchap_dhgroup into the DH-HMAC-CHAP host
   authentication entry, and split the combined ANA and PI-enable
   entries into separate port and subsystem entries.
 - Add Reviewed-by tag from Hannes Reinecke in the third patch, thanks.

Guixin Liu (3):
  nvme: add ABI documentation for host sysfs interfaces
  nvmet: add ABI documentation for target configfs interfaces
  MAINTAINERS: add missing NVMe documentation files

 Documentation/ABI/stable/configfs-nvmet | 352 ++++++++++++++++++
 Documentation/ABI/stable/sysfs-nvme     | 453 ++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-nvme    |  13 -
 MAINTAINERS                             |   4 +
 4 files changed, 809 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/stable/configfs-nvmet
 create mode 100644 Documentation/ABI/stable/sysfs-nvme
 delete mode 100644 Documentation/ABI/testing/sysfs-nvme

-- 
2.43.7


