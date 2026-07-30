Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EED0C54FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 04:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tWZbSUCOnYdPxY374isKzLqFNgLoB0MwVU423wB/jAA=; b=RWjFXw/Vxz2KQJEsT161YmxU9E
	n1M0NBCmEI4sr6PTx83GV9qgncCLeBAzzO8o1DYtAhAYr9oWgKcSyojRNKHtbpxOtPY5SHZhhOeRC
	cUvriOA+/U3MMHhubb4COpa4Vy0YpWbIp0WP4XKNdg84On35EMkXy6O0J8/agKICpiUTc8Hv1qaD6
	R0WxXdK2H1Kv5kOE9+AilpAed3dHRIK4gX6jTvk6gmnoa1QvrWrTQs+AONwIFHPmtv2X+nXcH4gIm
	ry1JNXbPbNteDct+g2U0TT8n8g7QBC8Mt1grBqXAz4xCGHej0rQZTPxcsnHkCzC6oda5Qm0997tex
	tTeWhHpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQY-00000009Trd-0S2R;
	Thu, 30 Jul 2026 04:31:26 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQP-00000009Tjj-2eP4
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 04:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785385871; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tWZbSUCOnYdPxY374isKzLqFNgLoB0MwVU423wB/jAA=;
	b=FS19ViVi5ko7rJyuT7gytd6QP1RjG+eY/nJ22pndnu9pZkVDByQvp2ZC2+EPqa9nYBXk0TEIUbI634sQijqnXBXC2SClM7/68xwKe3xqKi9W3VvMQDKxDbB/fIYBa0GxXyET3JhKCSj4SmxhG/VXgiIDQ2F/rrMXni7GgJJDbZk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X83p0Gy_1785385870;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X83p0Gy_1785385870 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 12:31:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] nvme: a few error-path and validation fixes
Date: Thu, 30 Jul 2026 12:31:01 +0800
Message-ID: <20260730043105.3071328-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_213118_406736_99BCB4C2 
X-CRM114-Status: GOOD (  10.79  )
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

This series collects four independent fixes found while auditing error
and command-processing paths in the NVMe host and target drivers. Each
is standalone; they only share the same subsystem.

  1. nvmet: an Identify CNS 07h (active NS list for a command set)
     dereferences req->ns, which is always NULL on that path -> NULL
     pointer oops. Also fixes the filter to test the iterated ns->csi.

  2. nvmet: nvmet_ns_enable() ignores the percpu_ref_init() return value
     and reports success to userspace when it fails, leaving the ns dead.

  3. nvme-pci: the per-NUMA-node descriptor DMA pools, created lazily on
     admin tag set allocation, are only freed in nvme_remove(); a probe
     failure after that point leaks them.

  4. nvme: nvme_query_fdp_info() trusts the device-supplied nruhsd count
     and can read past the fixed-size RUH status buffer (heap OOB read).

Found by code audit. #1 and #2 are functional/crash fixes; #3 is a
resource leak; #4 is device-triggered hardening. Compile-tested.

Guixin Liu (4):
  nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()
  nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
  nvme-pci: release descriptor pools on probe failure
  nvme: clamp FDP placement handle count to the buffer size

 drivers/nvme/host/core.c        | 1 +
 drivers/nvme/host/pci.c         | 1 +
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
-- 
2.43.7


