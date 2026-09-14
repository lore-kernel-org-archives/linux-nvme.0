Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C0C88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d557gZf0kQLnN5ks4fRtXfuibYO4fdRPh2H7XrhfAd0=; b=tQ61wMy6umYCBsu9SZkFDzXvVB
	003Et2rHgdUbMgbK0fHRfsDSYDr2DPMrwrEaFvL9QDXnG111HN/nUyn+iQ+B9N5cshJiRI2obYiL5
	oy6lqHhB5AU7n5lry9qli7DHKl/EfznW1P8S5S8qQy8RziSmG9SKYK3TfrBJOJN/kQFqTkW4JiUXz
	ls1o8iF+n8A/Aiy3YxgWklJeI+HPulDEkvdwzyPyJZOoxMUJOpGSdgy+e8QmiV1EcNNVi5kB3VHfR
	oQICX8TTlrknCfXmjtQ8pHSdpyU+QAKGm7NeUAg1Ze6Fr/ABTMWKUgvkebmEUfqY1lVYnejZkg/da
	GOOjKcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61RA-00000002cPY-1suc;
	Mon, 14 Sep 2026 07:49:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61R8-00000002cOC-14l3
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 07:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789372149; x=1820908149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HkJdccRbWSWBEM29K26GlU8jodZoRD1SOUzq6f0wzzg=;
  b=rtuRB4+2IfyI1IvcOwHAU8Lz17OjFUKL/hR8y1fQcL3WxodCgXIclmgK
   RAWQAceiTOBpXm/2b39TI01n8zKp5p+vCryQVf+uziKJoWpu7VbPclnxg
   q25cT+FhjuHx9SiJSoJ4o7dlXSIt3Nc5GZy1LkNvNRFd0H7BCD8nWQ8iW
   VYCthjFBkODUwitq92IFm9OewyI4V3W328iJQ+uXZEjTTBzlb+pijRmA6
   Wget+Iuv3XPcTrQC3w1CshbqzWYlEsDWP+D0aLKoOV+OcAqy9Rbu7Xw6O
   gOJR3dWXzxMW+he2PaqmQqXTYNmN4Wm1uWhdFHaDZycsFMVAZWbPQGo/Z
   g==;
X-CSE-ConnectionGUID: Im+ZW0s/TbiZBom8y0b+RQ==
X-CSE-MsgGUID: heNCqPBYQXKax8w4K7DIKQ==
X-IronPort-AV: E=Sophos;i="6.27,102,1786982400"; 
   d="scan'208";a="154022889"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2026 15:49:08 +0800
X-CSE-ConnectionGUID: JqblM9MXScumHBxCFjx9Tw==
X-CSE-MsgGUID: OVSNJMLVQr6OTX/2ysEhQg==
IronPort-SDR: 6aa7a6e7_aGcGibrhggqbl46d6o5bUOTlvTerEAtAB0cu+FXbOzS5QaC
 lDm7bi18+cgsAaRO0rcF/zrsWyPwgKVJCLVhT3A==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2026 00:48:55 -0700
X-CSE-ConnectionGUID: 0GXaDqaSQemLU8qs9H+mYA==
X-CSE-MsgGUID: htW+/yy5Qs2MUr15g4Oo2g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 14 Sep 2026 00:48:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Dumazet <edumazet@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] nvme-tcp: do not use dynamic lockdep key for socket instances
Date: Mon, 14 Sep 2026 16:48:51 +0900
Message-ID: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_004910_345457_84BB2F67 
X-CRM114-Status: GOOD (  13.85  )
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Keith and the maintainers, please consider this series for upstream.
The commit 19bdb70c77d3 tried to avoid a lockdep WARN issue, but it
was imperfect. With Eric's help, I propose this series as a better
solution.

Eric, FYI, I prepared the second patch with your authorship and your
SoB tag. Thanks for the fix idea.


Commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per
socket instance") introduced the dynamic lockdep key to avoid a lockdep
WARN. However, it had a bug in lockdep key lifetime management and
caused another WARN [1]. The first patch in this series reverts the
commit to avoid the WARN.

Reverting 19bdb70c77d3 re-exposes two lockdep WARNs that it had
suppressed. The first one was observed with the blktests test case
nvme/005, which was caused by the lock chain below:

  set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu

This WARN needs no patch in this series: it is already cut by the merged
commit 0ba6912f7e97 by Eric in the v7.3-rc2 tag, which removes the
"sk_lock -> cpu_hotplug_lock" dependency. This series therefore depends
on that commit being present.

The second WARN was observed with the blktests test case nvme/062, which
was caused by the dependency newly added for TLS support. The second
patch in this series delays the socket reclassification timing to cut
the dependency.

With this series applied on v7.3-rc2, nvme/005 and nvme/062 pass with no
lockdep splat.

[1] https://lore.kernel.org/lkml/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/


Eric Dumazet (1):
  nvme-tcp: delay nvme_tcp_reclassify_socket()

Shin'ichiro Kawasaki (1):
  Revert "nvme-tcp: lockdep: use dynamic lockdep keys per socket
    instance"

 drivers/nvme/host/tcp.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

-- 
2.54.0


