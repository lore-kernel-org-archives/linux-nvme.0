Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3282C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P0oXVcG2QGVt8vzokiAjcIRWu1b8OEnhGZbX3WzYKYw=; b=kjDBOoCKhTf0rV0f4yqpDkBUsK
	ocbsQKHxjjk6e6Vyba1Nc6j0sURXTErq51un1F2F5ojipE/jkFKI0fw3pV+OLNJ2jLa3CROxm/mVL
	wfeJQQcIrsYruxe7xj0FaocLGbgBZ9dJvLfCxDL7URqddz1x85z4Hyup4FOYYE0LcpAEtyD0NFiC4
	6GSMmbxB5u4GWDU4A6sdrDMN6xH/ZRq60Z1mYZyjP4JeKci0cYjjHSx+Xa8wFjELOppee17ly2sxj
	yaOvFFoRYaNNuclciwT3AYboDL5l6WuTgk5GMZipxWWjenUB0gkWvwAWvuYJajF6blCidu0F25CBo
	Mv0c4Xzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZB5-0000000BOtZ-1a7j;
	Mon, 06 Jul 2026 02:35:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgZB1-0000000BOsn-2Yyc
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 02:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=P0oXVcG2QGVt8vzokiAjcIRWu1b8OEnhGZbX3WzYKYw=; b=mtA/8o5iH/7PDoaar9BKN3luRM
	Kgvvf6OvNJxRI51zUANCw/JTWWvh0k1LCBVffQrqO81lc8n/mbzXhi/2vzq0fTuZ2tk8FsRM8391j
	jLEEkU0xeoWGmlZ6aIAw90QmEYW7ws8Te2txaE/BXaMuVVoZ2foG3nVIS5T3J+SsKrDqluTmKwdOs
	7+8RjjIx4iSHzlDKR1LZZKDdxRiwfTH0AriP1dQKzNO5PQ5DXbVeagRwKRGsQLuGqmyFn+G/UsiAg
	gVijCOqqL3KABBHg1yjxwxJiKe71zeoPzo7DGVcNPhA+v7q8y6HzUncvLWdX9iGBXKFph8ZRZnd5o
	ItM42TXg==;
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgZAi-000000067i3-1K7N
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 02:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783305286; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P0oXVcG2QGVt8vzokiAjcIRWu1b8OEnhGZbX3WzYKYw=;
	b=GuKkStElcE5s67YDuinRw5hmYvpfgUKhIOAwBdisOQrrPZR7KN+eqe7+oHYY6YG82OUOkMeTgMpk0Dy0mk5IE56k9BBuZk3hwqvQYT2cS0NF2LdwJnOwnU0k16GlwI4HG+7U0rbwTWQ/ktzx1mlU6pUxoNjeTYuhsMgUwEBN6V4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6PH231_1783305285;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6PH231_1783305285 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 10:34:45 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v3 0/3] nvme: add ABI documentation for sysfs and configfs interfaces
Date: Mon,  6 Jul 2026 10:34:36 +0800
Message-ID: <20260706023439.3054578-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_033502_478121_F222B297 
X-CRM114-Status: GOOD (  11.50  )
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

Patch 1 adds Documentation/ABI/testing/sysfs-nvme for host sysfs.
Patch 2 adds Documentation/ABI/testing/configfs-nvmet for target configfs.
Patch 3 adds missing F: entries in MAINTAINERS for NVMe documentation.

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

 Documentation/ABI/testing/configfs-nvmet | 352 +++++++++++++++++
 Documentation/ABI/testing/sysfs-nvme     | 460 ++++++++++++++++++++++-
 MAINTAINERS                              |   4 +
 3 files changed, 806 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-nvmet

-- 
2.43.7


