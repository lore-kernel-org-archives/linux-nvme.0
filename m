Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C14C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:15:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A7464E05
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A7464E05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KeyZIyACzqATpnCyYw4wqjUmRBgwy+ZdsKNCREZX3EM=; b=2MVhJIeeqXpGRGYw3u1+1sIVQm
	erBoBn9uBfazAfCNa613zPD6vahUVfFPR5MsKTIkEz9O362teIkec1vYQ4gQD/Yc8qD/FKUbhKZ4D
	V8fUnMcs4nSYYVGOkRHGhwXfyFhcy/srUABo+0bGFDWW2BohEzN/Q/YCxl6JCEqYFST9Fo6yUdbd8
	m51OFDldpDT1GqoJKkUWBKZFEye2XA3wK1cs/6NEvTBMVDVegrMihz4RZYN1ntLq+xe4OUFHPph1o
	98B+JQvEKezKEXfQSj4DTdyMi25bqJjd5hoVE0ML3OnjlrotNTzngOi6d86B+0iji9nJtZnNpppjT
	4rGCdjOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGV3-0000qg-1H; Thu, 11 Feb 2021 18:15:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGV0-0000po-IY
 for linux-nvme@merlin.infradead.org; Thu, 11 Feb 2021 18:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=1+jRkia4Eg99jOUPw9DGzfatdzoYmm+SnqtsPt/EHxo=; b=OoEiXDQpFCDeKQJ5wdSjg3LDR6
 Hgn60QMNT8E2MhqlsQXVbZzAGjaiB4cnhjopx6AdpjVFSzM2ihuZD0mr74Mc0J11b4P5odAq/nr5d
 WZF+xtyK/oNjcNHDsJquvoLfoa3f7XjsmkOrggMY5J1bdH/qwV9Yh4YIWbDs0lIitBQQ1/y79Edxz
 e12+Uao+EcfpVSpYe90DGkEynYxuqsvjpeDBAuQ6hWBNfHIorZRnTsf9gC0DcQTEaxabcE+bjIHwR
 WEeneCgK8D9lpHOtw/KLcaO4+v1h+FOoMlobeSELNRB3faXFkPTECXeBL0642cQCEN3lmHUF7o4F1
 PW6bMxkA==;
Received: from [2001:4bb8:18c:3398:1d2c:8bc5:1480:8e26] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lAGUx-00AaNh-SU; Thu, 11 Feb 2021 18:15:29 +0000
Date: Thu, 11 Feb 2021 19:15:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] second round of nvme updates for 5.12
Message-ID: <YCV0PmcdMDOeQp5Q@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Note that we have some issues with the previous updates.  We're working
fast on fixes for those, but in the meantime I think it is good to get
these changes out to you and into linux-next.


The following changes since commit 6751c1e3cff3aa763c760c08862627069a37b50e:

  bcache: Avoid comma separated statements (2021-02-10 08:06:00 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-2021-02-11

for you to fetch changes up to e11e5116171dedeaf63735931e72ad5de0f30ed5:

  nvme-tcp: fix crash triggered with a dataless request submission (2021-02-11 08:04:51 +0100)

----------------------------------------------------------------
nvme updates for 5.12:

 - fix multipath handling of ->queue_rq errors (Chao Leng)
 - nvmet cleanups (Chaitanya Kulkarni)
 - add a quirk for buggy Amazon controller (Filippo Sironi)
 - avoid devm allocations in nvme-hwmon that don't interact well with
   fabrics (Hannes Reinecke)
 - sysfs cleanups (Jiapeng Chong)
 - fix nr_zones for multipath (Keith Busch)
 - nvme-tcp crash fix for no-data commands (Sagi Grimberg)
 - nvmet-tcp fixes (Sagi Grimberg)
 - add a missing __rcu annotation (me)

----------------------------------------------------------------
Chaitanya Kulkarni (10):
      nvmet: set status to 0 in case for invalid nsid
      nvmet: return uniform error for invalid ns
      nvmet: make nvmet_find_namespace() req based
      nvmet: remove extra variable in id-ns handler
      nvmet: add helper to report invalid opcode
      nvmet: use invalid cmd opcode helper
      nvmet: use invalid cmd opcode helper
      nvmet: use min of device_path and disk len
      nvmet: add nvmet_req_subsys() helper
      nvmet: remove else at the end of the function

Chao Leng (4):
      blk-mq: introduce blk_mq_set_request_complete
      nvme: introduce a nvme_host_path_error helper
      nvme-fabrics: avoid double completions in nvmf_fail_nonready_command
      nvme-rdma: handle nvme_rdma_post_send failures better

Christoph Hellwig (1):
      nvmet-fc: add a missing __rcu annotation to nvmet_fc_tgt_assoc.queues

Filippo Sironi (1):
      nvme: add 48-bit DMA address quirk for Amazon NVMe controllers

Hannes Reinecke (1):
      nvme-hwmon: rework to avoid devm allocation

Jiapeng Chong (1):
      nvme: convert sysfs sprintf/snprintf family to sysfs_emit

Keith Busch (1):
      nvme-multipath: set nr_zones for zoned namespaces

Sagi Grimberg (3):
      nvmet-tcp: fix receive data digest calculation for multiple h2cdata PDUs
      nvmet-tcp: fix potential race of tcp socket closing accept_work
      nvme-tcp: fix crash triggered with a dataless request submission

 drivers/nvme/host/core.c          | 26 +++++++++++++----
 drivers/nvme/host/fabrics.c       |  6 +---
 drivers/nvme/host/hwmon.c         | 31 +++++++++++++-------
 drivers/nvme/host/multipath.c     |  4 +++
 drivers/nvme/host/nvme.h          | 15 ++++++++++
 drivers/nvme/host/pci.c           | 21 +++++++++++++-
 drivers/nvme/host/rdma.c          |  4 ++-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   | 59 ++++++++++++++++-----------------------
 drivers/nvme/target/core.c        | 37 +++++++++++++++---------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  5 +---
 drivers/nvme/target/io-cmd-file.c |  5 +---
 drivers/nvme/target/nvmet.h       | 10 +++++--
 drivers/nvme/target/passthru.c    |  6 ++--
 drivers/nvme/target/tcp.c         | 59 ++++++++++++++++++++++++++++-----------
 drivers/nvme/target/trace.h       |  9 ++++--
 include/linux/blk-mq.h            | 12 ++++++++
 18 files changed, 208 insertions(+), 105 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
