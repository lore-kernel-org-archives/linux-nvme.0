Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AF4C3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KhvlomGhuCDiEa0dzQUMpaPBS/9wT6fCgMflrFecjrs=; b=ZtKjuqeDXwPtvdQBz1GyfqrnOd
	tKJ1No099TNqkmr0+osOTNGAiWlGnpOI50Fh5cFiiL7lIq6BDQaMA9Qay+EjfYJaloISw9Cm1qVij
	IdCXyFlgRmtzFOxM++VwbptYCaPOZLDyjlIqVFCv7w1eYyAVjFuLKL3YIajjZTyrba8UtqVli2WWJ
	rUjnBiMK6fEQcNScIi6p1+ZQnwXLXdD7AFVO0VHipSx1GicmXItpfhWkdwwY4VVq3AxlTlpfYebAJ
	/dL6rEKXclVywkhTehqfsuBDgv9QuSieaS144bOu81i3PsE2fHDG7u6wc2cXcx5tioMBmVTH/FJZM
	Hn+KzTcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjm-00000009brh-17v6;
	Tue, 16 Jul 2024 07:36:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcji-00000009boZ-1tbW
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 37A33CE0FCB;
	Tue, 16 Jul 2024 07:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A87FC116B1;
	Tue, 16 Jul 2024 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115391;
	bh=oX4loWSWAwXmU8FVahJIkdF+egKphwLBJUcv23g4KIo=;
	h=From:To:Cc:Subject:Date:From;
	b=f/uE8en6+/R2TfscN93UIRG975Zq0HYVgsc1c0tgRH1wF1gBZIMrBBuMs3nbEHzok
	 fWSJvl76BHWo2RTr6Qw30EkfIhSUgBxbRxoTMa7woWZqwC5HXYPATyNlK8ol3CGWiR
	 dmoQn+v1Bi3+UxNSp9yRtID1u625QBpIL2hfm9kRzIdR7nvh2hlUtt90Sf/kuQ60Hm
	 j0BsQ6Y6UqFTSzmXc8mQmnJJAR+c8gWjVAqnkIOfxJJul+ywrZ8WuKMMFwNjhh7vc4
	 /SZoGM4/Y10YtsEe4SXEdgqC5X1X3XHjNh7bnn9UTX4mCsHIicvg517vVnTIezqwYB
	 vgyDKuCcnCGKw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/8] nvme-tcp: improve scalability
Date: Tue, 16 Jul 2024 09:36:08 +0200
Message-Id: <20240716073616.84417-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003634_879304_F7A775F2 
X-CRM114-Status: GOOD (  10.38  )
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

for workloads with a lot of controllers we run into workqueue contention,
where the single workqueue is not able to service requests fast enough,
leading to spurious I/O errors and connect resets during high load.
One culprit here was a lock contention on the callbacks, where we
acquired the 'sk_callback_lock()' on every callback. As we are dealing
with parallel rx and tx flows this induces quite a lot of contention.
I have also added instrumentation to analyse I/O flows, by adding
a I/O stall debug messages and added debugfs entries to display
detailed statistics for each queue.

All performance number are derived from the 'tiobench-example.fio'
sample from the fio sources, running on a 96 core machine with one,
two, or four subsystem and two paths, each path exposing 32 queues.
Backend is nvmet using an Intel DC P3700 NVMe SSD.

write performance:
baseline:
1 subsys, 4k seq:  bw=523MiB/s (548MB/s), 16.3MiB/s-19.0MiB/s (17.1MB/s-20.0MB/s)
1 subsys, 4k rand: bw=502MiB/s (526MB/s), 15.7MiB/s-21.5MiB/s (16.4MB/s-22.5MB/s)
2 subsys, 4k seq:  bw=420MiB/s (440MB/s), 2804KiB/s-4790KiB/s (2871kB/s-4905kB/s)
2 subsys, 4k rand: bw=416MiB/s (436MB/s), 2814KiB/s-5503KiB/s (2881kB/s-5635kB/s)
4 subsys, 4k seq:  bw=409MiB/s (429MB/s), 1990KiB/s-8396KiB/s (2038kB/s-8598kB/s)
4 subsys, 4k rand: bw=386MiB/s (405MB/s), 2024KiB/s-6314KiB/s (2072kB/s-6466kB/s)

patched:
1 subsys, 4k seq:  bw=440MiB/s (461MB/s), 13.7MiB/s-16.1MiB/s (14.4MB/s-16.8MB/s)
1 subsys, 4k rand: bw=427MiB/s (448MB/s), 13.4MiB/s-16.2MiB/s (13.0MB/s-16.0MB/s)
2 subsys, 4k seq:  bw=506MiB/s (531MB/s), 3581KiB/s-4493KiB/s (3667kB/s-4601kB/s)
2 subsys, 4k rand: bw=494MiB/s (518MB/s), 3630KiB/s-4421KiB/s (3717kB/s-4528kB/s)
4 subsys, 4k seq:  bw=457MiB/s (479MB/s), 2564KiB/s-8297KiB/s (2625kB/s-8496kB/s)
4 subsys, 4k rand: bw=424MiB/s (444MB/s), 2509KiB/s-9414KiB/s (2570kB/s-9640kB/s)

read performance:
baseline:
1 subsys, 4k seq:  bw=389MiB/s (408MB/s), 12.2MiB/s-18.1MiB/s (12.7MB/s-18.0MB/s)
1 subsys, 4k rand: bw=430MiB/s (451MB/s), 13.5MiB/s-19.2MiB/s (14.1MB/s-20.2MB/s)
2 subsys, 4k seq:  bw=377MiB/s (395MB/s), 2603KiB/s-3987KiB/s (2666kB/s-4083kB/s)
2 subsys, 4k rand: bw=377MiB/s (395MB/s), 2431KiB/s-5403KiB/s (2489kB/s-5533kB/s)
4 subsys, 4k seq:  bw=139MiB/s (146MB/s), 197KiB/s-11.1MiB/s (202kB/s-11.6MB/s)
4 subsys, 4k rand: bw=352MiB/s (369MB/s), 1360KiB/s-13.9MiB/s (1392kB/s-14.6MB/s)

patched:
1 subsys, 4k seq:  bw=405MiB/s (425MB/s), 2.7MiB/s-14.7MiB/s (13.3MB/s-15.4MB/s)
1 subsys, 4k rand: bw=427MiB/s (447MB/s), 13.3MiB/s-16.1MiB/s (13.0MB/s-16.9MB/s)
2 subsys, 4k seq:  bw=411MiB/s (431MB/s), 2462KiB/s-4523KiB/s (2522kB/s-4632kB/s)
2 subsys, 4k rand: bw=392MiB/s (411MB/s), 2258KiB/s-4220KiB/s (2312kB/s-4321kB/s)
4 subsys, 4k seq:  bw=378MiB/s (397MB/s), 1859KiB/s-8110KiB/s (1904kB/s-8305kB/s)
4 subsys, 4k rand: bw=326MiB/s (342MB/s), 1781KiB/s-4499KiB/s (1823kB/s-4607kB/s)

Keep in mind that there is a lot of fluctuation in the performance
numbers, especially in the baseline.

Changes to the initial submission:
- Make the changes independent from the 'wq_unbound' parameter
- Drop changes to the workqueue
- Add patch to improve rx/tx fairness

Changes to v2:
- Reworked patchset
- Switch deadline counter to microseconds instead of jiffies
- Add debug message for I/O stall debugging
- Add debugfs entries with I/O statistics
- Reduce callback lock contention

Hannes Reinecke (8):
  nvme-tcp: switch TX deadline to microseconds and make it configurable
  nvme-tcp: io_work stall debugging
  nvme-tcp: re-init request list entries
  nvme-tcp: improve stall debugging
  nvme-tcp: debugfs entries for latency statistics
  nvme-tcp: reduce callback lock contention
  nvme-tcp: check for SOCK_NOSPACE before sending
  nvme-tcp: align I/O cpu with blk-mq mapping

 drivers/nvme/host/tcp.c | 384 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 351 insertions(+), 33 deletions(-)

-- 
2.35.3


