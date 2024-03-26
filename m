Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E53C54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2U/gxGmB2tyeGn9Iyzt6Fp8mx15cyP2e/5Pt2LzN4Hs=; b=wN1FPqJp8iQlt/hJFFU+bFnfIX
	ZMoaL4Vp/57Ob1zCPOHJGtIYsxSOhK16G4pT5KvTw0vGL0tlYAxz/BXKVUKjJ8PSZwGUvGygWPJ2U
	wW6eDqIpq1H7b1eiU0RLvVtnrJp8coNGkQ9dhGg9L2eVW09pQOs5cvDsGjSP4IqgCZfpeRVvGGRKV
	Gtq1WaClxEer3cZ9mJ8u2OzI3qvAWv9qQ+YsJSav1B05dD/C4C2qGyhDHEjqrmrs9IQPMZtZQIw08
	s0Wemtr0X4Zl1ruh6AzHEw/2K1jTmeAkX52NAokAgd05pJhIofaQffAD+8fUWoKhwRxmwNME8DZBm
	XVl9OEgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8rk-00000005DtO-3943;
	Tue, 26 Mar 2024 15:37:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8qA-00000005D50-1Fve
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 15:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2U/gxGmB2tyeGn9Iyzt6Fp8mx15cyP2e/5Pt2LzN4Hs=; b=IHla6gVGrqkTkj02E1Wi9I5jU8
	seTGswAJ7aVHXnZ98UOmgGNlPfm5xPetnxIVwm5taUDMVEdxMw/JB0+3HMNSrURq/v03Hb7tZAi0Q
	hl/3bfANXU+Ubn9xvdiZMZy4xOkuPcciyuDju7ML0NV72ZQRyhjpbhLD2JH8orfo1D5nVOuXRZmra
	oTEZy+Kb62J6sExXlsabJVcAcXukQtNIOZITeQ/5OuvBlVQ87CHvzeZvnizigY2s6fMT1vgt/KgRu
	KkcAzRz79mrx+x5spZR7e7U205jmJeqoRxtNGspDQ9srUcCmSi6bBkyaFoUe/Dfot+bttbSrcjjRb
	BcWm2DQA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8q7-0000000HGi2-0FlM
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 15:35:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8B864612B7;
	Tue, 26 Mar 2024 15:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857AEC433C7;
	Tue, 26 Mar 2024 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467345;
	bh=+NvJmxYGsuSk9QvPxWPrs/QuQrrlwDBVa5xA8JoGAxk=;
	h=From:To:Cc:Subject:Date:From;
	b=DaQZgJvNsJUyeVi6igAjGhE3GF3jr1Y6Vl/QEu8cr66A2UoCuBMOol3abtzAzpytz
	 ZEcsP+AUr6/Tq1TRhnX4RhoylECDumO1XfTOqSr04PiPVUZLWqh1Np0TNhj5lhL55+
	 ulvWjzXhQUyoVWuHmzS7fS4NS/Yji9O9wYhG/m2O5xB8k1aRwzVRoUnoidlDWWRMzp
	 vuPyd3IZBdZPWJd/9TRkIN6AMyXiDbK4ojUxGy82RSOad7AIViBfTJri3jUFhl62iO
	 8RamkzF+r5XaOqHoGOWoWRPhcJOewRVokUeE5I4w4yaT0UOUijGmZbcWTcvS8cHlFf
	 S/MPk2gJueq0Q==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RFC 0/2] block,nvme: latency-based I/O scheduler
Date: Tue, 26 Mar 2024 16:35:27 +0100
Message-Id: <20240326153529.75989-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_153551_426793_649C78E5 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nodelat' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script I'm getting:
  WRITE: bw=531MiB/s (556MB/s), 33.2MiB/s-52.4MiB/s
  (34.8MB/s-54.9MB/s), io=4096MiB (4295MB), run=4888-7718msec
    WRITE: bw=539MiB/s (566MB/s), 33.7MiB/s-50.9MiB/s
  (35.3MB/s-53.3MB/s), io=4096MiB (4295MB), run=5033-7594msec
     READ: bw=898MiB/s (942MB/s), 56.1MiB/s-75.4MiB/s
  (58.9MB/s-79.0MB/s), io=4096MiB (4295MB), run=3397-4560msec
     READ: bw=1023MiB/s (1072MB/s), 63.9MiB/s-75.1MiB/s
  (67.0MB/s-78.8MB/s), io=4096MiB (4295MB), run=3408-4005msec

for 'round-robin' and

  WRITE: bw=574MiB/s (601MB/s), 35.8MiB/s-45.5MiB/s
  (37.6MB/s-47.7MB/s), io=4096MiB (4295MB), run=5629-7142msec
    WRITE: bw=639MiB/s (670MB/s), 39.9MiB/s-47.5MiB/s
  (41.9MB/s-49.8MB/s), io=4096MiB (4295MB), run=5388-6408msec
     READ: bw=1024MiB/s (1074MB/s), 64.0MiB/s-73.7MiB/s
  (67.1MB/s-77.2MB/s), io=4096MiB (4295MB), run=3475-4000msec
     READ: bw=1013MiB/s (1063MB/s), 63.3MiB/s-72.6MiB/s
  (66.4MB/s-76.2MB/s), io=4096MiB (4295MB), run=3524-4042msec
  
for 'latency' with 'decay' set to 10.
That's on a 32G FC testbed running against a brd target,
fio running with 16 thread.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

 block/Kconfig                 |   7 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nodelat.c           | 368 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/multipath.c |  46 ++++-
 drivers/nvme/host/nvme.h      |   2 +
 include/linux/blk-mq.h        |  11 +
 8 files changed, 439 insertions(+), 4 deletions(-)
 create mode 100644 block/blk-nodelat.c

-- 
2.35.3


