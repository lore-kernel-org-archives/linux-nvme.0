Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE8EC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g9zwVG1cp8bLJOC3M2QCD9cZL0oVPbj19z9nNt6v7Z8=; b=S1VeOyTkAgZmHHuvuskn7vfN3I
	o8yUnPqwNVE12RizlFpulXZ08wGCvZCLK+StO1+nIyhISdgpVPoOTw97ZHfc+YFjbTTC53X0ZAWZy
	oLNNRB3gkat5XemwMBGo6hlt+6w/3VNGlzumxKagkxT9Km2F87LEqsiDxC09LLp1gFZ8kvoNqh6F0
	IzGYENxDAKiE7N76Z9Yx5nyUjL/zXqaFfqhTy5mww+0By22ggYPjNUvzruCR0m7LVUF8WgJC1dE6B
	yFdDYWALKA0O2WiEXZYGATwuWObn3TmbDnstvygcn+TRMUSIq91FR2mIK+o32gf5YlUYm7QTnN6QW
	TOgbnUOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGJ5-0000000BfpU-1rcr;
	Tue, 20 May 2025 06:18:31 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGIz-0000000Bfnx-3LKb
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 06:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747721905; x=1779257905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2IjHJijPK1a1H6AmVJUi3osLKpro3mwDC8gTRWA9EPw=;
  b=h81c3trkUe85075YruXoD1lwJhQ0j/YYfpbDGzg2rVVuSpp/akLC53of
   UWNEN4aNnI480GGN4IPyBDvXibCP0Dzy3epu055P+2iQw60bwOat81+f7
   R/4HgKTtE7ebd9T1Xr4eyLSmGx6XTP5gOzs/Bty3CxbC16Ay6qDPrx+TQ
   /yrUl+GVCme1OJwmfzm+kjR2lnDfYGg4K+bvzkJQPeT23uTupMJ7FsqMc
   vxWQwzxI3mbVOuc9qCzSG5b9v2ZoGItlBH4/L3S/2WdgJWzT1GJPkrae3
   AeyroVByEq/7mpiaTWMw34XSX/nYQ0N9f6TMHVVnbK0D8wpOpBz++Yi49
   A==;
X-CSE-ConnectionGUID: lSiozDPbQnmRK0LWcKXL9Q==
X-CSE-MsgGUID: yDAwM7gRRKO9zMzcPCpxjA==
X-IronPort-AV: E=Sophos;i="6.15,302,1739808000"; 
   d="scan'208";a="88516359"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 14:18:22 +0800
IronPort-SDR: 682c1069_mnZ/3ryB0WwkiXF3VblmwiWenSjiywXtgCJBZt+Iq+pfZvd
 VoDVigFhaivajlZ6LXRALP+ZlkjdwIeor9rzKng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2025 22:17:30 -0700
WDCIronportException: Internal
Received: from 5cg21741nf.ad.shared (HELO shinmob.wdc.com) ([10.224.163.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2025 23:18:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: check that nvme-cli supports json output format
Date: Tue, 20 May 2025 15:18:17 +0900
Message-ID: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_231825_912532_16208137 
X-CRM114-Status: GOOD (  13.20  )
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

The commit 444f0df9f0c5 ("nvme: check for controller device in
_nvme_connect_subsys()") assumed that the nvme command always supports
json output format. However, when nvme-cli is built on a system without
the json-c library, the nvme command does not support the format. This
leads to silent failures in many test cases in the nvme test group [1].

This series address the problem. The first patch introduces a helper
function to prepare for the fix. The second patch fixes the problem by
checking that the nvme command supports the json format.

[1] https://lore.kernel.org/linux-nvme/20250519054905.GA6156@lst.de/

Shin'ichiro Kawasaki (2):
  common/nvme: introduce _have_nvme_cli_with_json_support()
  nvme/rc, md/001: check that nvme-cli supports json output format

 common/nvme   | 12 +++++++++++-
 tests/md/001  |  1 +
 tests/nvme/rc |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.49.0


