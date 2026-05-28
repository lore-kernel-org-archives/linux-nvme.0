Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99739CD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2LJir5NYveamozdEogI+01xu/ZbFXYpoE1MTH8bCSu8=; b=jyMltvufc/zd5IUtTpsMS60dDC
	kYQkWjqwdgTRqcVTFaIKg+t5uNi3MeDqG41LP/4gVHlvcK6AE9KB/PjcPkLfpda8rZaKeE30MXu1L
	9WXZb3tII1bdjRzF2N1sAlmfnZn0L6rsWeLkXbV6HwWnMAWCoMsGlokvmZXpwQDqbyPH/t9Vg76Z9
	BKdlJy6/tSmsuTbPfu7tt2LicRdJ0hDfohwVl/EnEX3nauwRIMQJtgmxGOTWOPOuVMzRDnH3zDrVB
	vmDDfbjDKq8LcAKzMJ6bHvo25/gej/tyRj4xKRfWDOYXQkgrxhp52RZK/h5vVLo6pOaWnyZY35PDn
	+KL6cJcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR9e-000000052BJ-1zJS;
	Thu, 28 May 2026 03:11:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR9b-000000052AU-2zfo
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:11:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EF9D43936;
	Thu, 28 May 2026 03:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65E11F000E9;
	Thu, 28 May 2026 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937886;
	bh=2LJir5NYveamozdEogI+01xu/ZbFXYpoE1MTH8bCSu8=;
	h=From:To:Cc:Subject:Date;
	b=Dejd0qhbEWMn6LN2R0CyuK49/u5lyOIhBYROqn3lwGDQ6OU9B48kD+Ow3PGcbdQna
	 kha0836A0cQNMi3SHjvBSLHdoUUZGPKKD+1rNli9fhE01MZCh2lFgzikkyITxKAj4F
	 xAsUcVdNkkfASv1Z54YGvrHVXlKilinraqZdhHeh8ZFonFNzRPNJZnoI1fleN3nZpX
	 PMbM6Xjb+6iA1t/hJ+7nWTgvPx2XvsT8KFZpCED4/FIPoz/TtDvbyejEHjBi+cCpil
	 EuMQzUEV737HxzZLxEj1GFT/cjGtqkjPj5CguYmHYPf1ISkj7e9LiM/gnHmv5OxnxW
	 YmVdLlrSMJWxQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 00/11] NVMe over MPTCP
Date: Thu, 28 May 2026 11:10:34 +0800
Message-ID: <cover.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_201127_807011_1C01B3FB 
X-CRM114-Status: GOOD (  11.23  )
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

From: Geliang Tang <tanggeliang@kylinos.cn>

This series (previously named "MPTCP support to NVMe over TCP") had three
RFC versions sent to Hannes in May 2025, with subsequent revisions based on
his input. Following that, I initiated the process of upstreaming the
dependent "mptcp: implement .read_sock" series, which was merged into the
Linux kernel in February 2026.

After several rounds of iteration on the MPTCP mailing list, this set
addresses all the reviewer comments (including Sashiko's) and fixes the
identified issues.

This topic was presented as a discussion item at LSF/MM/BPF 2026.
During the "NVMe over MPTCP" [1] discussion at the conference, it was
concluded that MPTCP should be treated as a new transport type, rather than
a TCP variant. A request will be submitted to the NVMe working group to
officially allocate a transport value for MPTCP.

This series runs without any user space changes (libnvme, nvme-cli).
Later, MPTCP KTLS support will be added, and a follow-up series will be
sent to enable TLS for NVMe over MPTCP.

Based on NVMe Multipath and Block Multiqueue, each TCP queue is converted
into one MPTCP queue. This is achieved by abstracting six socket helpers
(set_nodelay, set_reuseaddr, no_linger, etc.) into per-transport
structures. Inside each MPTCP queue, multiple subflows using different
IP addresses aggregate multi-NIC bandwidth and provide fail-over
resilience.

Patch 10 demonstrates that with a single NVMe multipath configuration and
four network interfaces, MPTCP achieves four times the bandwidth of TCP.
Patch 11 demonstrates that with four NVMe multipath paths, using the
round-robin I/O policy and a lossy four-interface environment, MPTCP
still achieves four times the bandwidth of TCP.

[1]
https://lore.kernel.org/linux-nvme/a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org/

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Geliang Tang (11):
  nvmet-tcp: define accept tcp_proto struct
  nvmet-tcp: implement accept mptcp proto
  nvmet-tcp: define listen socket ops
  nvmet-tcp: register target mptcp transport
  nvmet-tcp: implement mptcp listen socket ops
  nvme-fabrics: compare transport in ip_options_match
  nvme-tcp: define host tcp_proto struct
  nvme-tcp: register host mptcp transport
  nvme-tcp: implement host mptcp proto
  selftests: mptcp: add nvme over mptcp test
  selftests: mptcp: nvme: add iopolicy tests

 drivers/nvme/host/fabrics.c                   |   1 +
 drivers/nvme/host/tcp.c                       | 101 ++++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     | 128 +++++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  31 ++
 net/mptcp/sockopt.c                           | 149 +++++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  12 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 397 ++++++++++++++++++
 11 files changed, 813 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0


