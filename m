Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A7C55162
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e6wIUGPZqJ6JOv2WaAlzscVgB9OQreOJpvNocLa8LF8=; b=znRQcZ4gdaQ/Loht+H6zxxj0Po
	UZVc5DGdPU7H9CH4wa1vGTcLUN5K0dLb4ZnMd4PWmYTH65KXJguqZ7YuVz24B3r6eicAxmxpP8YMa
	9c84zP2R24BpdEXcpqxxiK6JJDP6JyLRCWF9gcttep6g3APc4Ot/4qoOydl/U2XyWoeuRFDW1M89Z
	0QHF31ky6fVdhUAR8VkIZ7hHnsTk9j5oomewvD4jJ1zHk28+LStYoXcC3SLOMYoBaEqdpOr9fkriw
	2lzf79xDmPplQQNClVz8T177P63F1FkXzHuZUD1qB6r6j3Zdd/awc7TN2pmd5GkSFZEyO2lKiCcAc
	riMqc0IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdni-0000000BfgW-3GUZ;
	Fri, 31 Jul 2026 03:20:46 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnf-0000000Bfee-2cnz
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468038; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e6wIUGPZqJ6JOv2WaAlzscVgB9OQreOJpvNocLa8LF8=;
	b=YcykkrhsvwspMYEZy+oASR54LmeNm7iCWqri5BR2VoNkpjRdjEDmMqbxTFVdQZ1dnXkUO9kRGCZVt3a2h2zYHAoB6Ayw7L0AhZiKbiBjsRudQ0S7b0PblCRbthQ3OVsPgAqBqBEESrY6EIC0haWJI0QyT0wb8jfqTKhQsYK+JCU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86jPkr_1785468036;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86jPkr_1785468036 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:36 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/5] nvme: a few error-path and validation fixes
Date: Fri, 31 Jul 2026 11:20:26 +0800
Message-ID: <20260731032031.1090755-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202044_116923_48155CCF 
X-CRM114-Status: GOOD (  12.50  )
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

This series collects independent fixes found while auditing error and
command-processing paths in the NVMe host and target drivers. Each is
standalone; they only share the same subsystem.

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

  5. nvme: follow-up to #4, suggested by Kanchan -- the RUH status buffer
     and the placement handle clamp used the odd S8_MAX - 1 value; raise
     the cap to the meaningful U8_MAX (bio->bi_write_stream is u8) and
     warn on overflow.

Found by code audit. #1 and #2 are functional/crash fixes; #3 is a
resource leak; #4 is device-triggered hardening; #5 tidies up the cap
introduced by #4.

A blktests regression test for #1 (Identify CNS 07h) will be sent
separately to the blktests list.

v1 -> v2:
  - Collected Reviewed-by tags from Hannes, Christoph, Kanchan and Nilay,
    thanks.
  - patch 1: added the observed NULL-deref oops splat to the commit log.
  - Added patch 5 (raise the FDP handle cap to U8_MAX and warn on
    overflow), as discussed on patch 4 with Keith, Christoph and Kanchan.

Guixin Liu (5):
  nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()
  nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
  nvme-pci: release descriptor pools on probe failure
  nvme: clamp FDP placement handle count to the buffer size
  nvme: raise FDP placement handle cap to U8_MAX and warn on overflow

 drivers/nvme/host/core.c        | 18 ++++++++++++++++--
 drivers/nvme/host/pci.c         |  1 +
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      |  3 ++-
 4 files changed, 20 insertions(+), 4 deletions(-)


base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
-- 
2.43.7


