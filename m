Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B645FC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UCf0MSKiFnQa9PBv04lGiMDCpXlPzx9WvSr/IxI7INQ=; b=0xZAOfDllrX7js6Xv7fqXZLDf1
	Wa4vL7I8bmo6ydlgydXNvEhvfqjBEcSJms49xhtJ44daWDmTu55d2ZgV6cEXEfxybghzszI9v3Fka
	bCPYLzXhPlO/lEPan/z4HRk7KgZy948ZqI0ntN3va/ApJgwpPuSFN6isVn718lt4ghMMFR0tRXUOV
	ssblCY8MsLRpWD9tpx8BbtXCu48sUjxcFJFuzWCydlR+Db4qKNMcAjfFI6xKjvClwA6lFz7vmV7F4
	kMRFJ1xnvE8Ccbg2Tlucl9d/pQ18B8t2zNkgwJC3ozjaXaZDOlI+a4XUr5tjKuYYozCzWrGgKecn3
	uXbcnqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXG-00000006hU2-3QSc;
	Wed, 26 Jun 2024 12:14:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXA-00000006hSS-1e6x
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:13:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EEE2F619E8;
	Wed, 26 Jun 2024 12:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5500DC2BD10;
	Wed, 26 Jun 2024 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404034;
	bh=+vLmKj8g6/H8Kq6QGGwvOumf+NNG1UB+NtaB/E5hrpg=;
	h=From:To:Cc:Subject:Date:From;
	b=SFjEXl5MHw2i1lCMz1d5NwINQtih0/QA7iatC+N7+DeY5jnUaDByh69uAUezQg0Rd
	 eKou5RDdGHg3iAgCNOLNt/Krq2Jz0+iKLc0RFVI8xFT1pFzWyxE3hNPlZmFUJZQWr9
	 TBZUu6IKgq3PCNRwoezoapiM8ErukekofQZPIJ+3cHEuU877TsJazwHN4jEwXwvADo
	 CsUU+D0+TxltPMNUA8yak2EsfSoHHX2mhRuHAxeZcpRbstv+Rg4/wooNgcuZHCeNTJ
	 7SNyDpSv4QAvfdDHvm9iNQ9JuJGLUFVx3wRfHkn2EdFwIZz/ActQ6cgO8jzUYI2wgP
	 XV7120PczJ+qg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/7] nvme-tcp scalability improvements
Date: Wed, 26 Jun 2024 14:13:40 +0200
Message-Id: <20240626121347.1116-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051356_505523_39A52F63 
X-CRM114-Status: GOOD (  12.67  )
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

we have had reports from partners that nvme-tcp suffers from scalability
problems with the number of controllers; they even managed to run into
a request timeout by just connecting enough controllers to the host.

Looking into it I have found several issues with the nvme-tcp implementation:
- the 'io_cpu' assignment is static, leading to the same calculation
  for each controller. Thus each queue with the same number is
  assigned the same CPU, leading to CPU starvation.
- The blk-mq cpu mapping is not taken into account when calculating
  the 'io_cpu' number, leading to excessive thread bouncing during I/O
- The socket state is not evaluating, so we're piling more and more
  requests onto the socket even when it's already full.

This patchset addresses these issues, leading to a better I/O
distribution for several controllers.

Performance for read increases from:
4k seq read: bw=368MiB/s (386MB/s), 11.5MiB/s-12.7MiB/s
  (12.1MB/s-13.3MB/s), io=16.0GiB (17.2GB), run=40444-44468msec
4k rand read: bw=360MiB/s (378MB/s), 11.3MiB/s-12.1MiB/s
  (11.8MB/s-12.7MB/s), io=16.0GiB (17.2GB), run=42310-45502msec
to:
4k seq read: bw=520MiB/s (545MB/s), 16.3MiB/s-21.1MiB/s
  (17.0MB/s-22.2MB/s), io=16.0GiB (17.2GB), run=24208-31505msec
4k rand read: bw=533MiB/s (559MB/s), 16.7MiB/s-22.2MiB/s
  (17.5MB/s-23.3MB/s), io=16.0GiB (17.2GB), run=23014-30731msec

However, peak write performance degrades from:
4k seq write: bw=657MiB/s (689MB/s), 20.5MiB/s-20.7MiB/s
  (21.5MB/s-21.8MB/s), io=16.0GiB (17.2GB), run=24678-24950msec
4k rand write: bw=687MiB/s (720MB/s), 21.5MiB/s-21.7MiB/s
  (22.5MB/s-22.8MB/s), io=16.0GiB (17.2GB), run=23559-23859msec
to:
4k seq write: bw=535MiB/s (561MB/s), 16.7MiB/s-19.9MiB/s
  (17.5MB/s-20.9MB/s), io=16.0GiB (17.2GB), run=25707-30624msec
4k rand write: bw=560MiB/s (587MB/s), 17.5MiB/s-22.3MiB/s
  (18.4MB/s-23.4MB/s), io=16.0GiB (17.2GB), run=22977-29248msec

which is not surprising, seeing that the original implementation would
be pushing as many writes as possible to the workqueue, with complete
disregard of the utilisation of the queue (which was precisely the
issue we're addressing here).

Hannes Reinecke (5):
  nvme-tcp: align I/O cpu with blk-mq mapping
  nvme-tcp: distribute queue affinity
  nvmet-tcp: add wq_unbound module parameter
  nvme-tcp: SOCK_NOSPACE handling
  nvme-tcp: make softirq_rx the default

Sagi Grimberg (2):
  net: micro-optimize skb_datagram_iter
  nvme-tcp: receive data in softirq

 drivers/nvme/host/tcp.c   | 126 ++++++++++++++++++++++++++++----------
 drivers/nvme/target/tcp.c |  34 +++++++---
 net/core/datagram.c       |   4 +-
 3 files changed, 122 insertions(+), 42 deletions(-)

-- 
2.35.3


