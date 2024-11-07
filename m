Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB91FD4334A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfayBfGKwjkSrJ71gG04SZiBwn1WIYpDSn6qnnKfLUI=; b=PyCGh2ixmhOYV9fd7ZPe7MhIY3
	+MUylgUDR0N/smR/AgrPJ7e4mh5cIa4qzLQGGNNZcFXGa5GAuQNTVps4aKDaQClSfQDocktpaOeQi
	XeIGS1dxs74u5OudrijfSfdN5vQUabhHN+H5xLRuzCD91sOdDGuq/PhFs4QmLfDoJlDqb1sITxKmq
	pi5t4UNMlFcmeoV9VUZ4RLNFtmQh4C5WvcnZ9he/Ld5sEfyQJO8Gh8PeW324flH5W4xloeakMazbS
	+TFbyjBOUgAV19aT1jCXDz2eoAXffwHV3WS/C0VlDnKGaVnGOro65dkJfM6vvB4J+dikTAeK07ttd
	BwmlSiVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sn-00000006dzz-0CKY;
	Thu, 07 Nov 2024 11:14:09 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sf-00000006dsC-3p5o
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978041; x=1762514041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4zs7monpFFNZIQAw/znu4gc9jhT9GfhkfYdW1ZD5Ps=;
  b=oBmMEbmEAl5Z4em3vgI/afAEGieFdPzuo9D076fWAogAwi1va2bJHMNz
   2M8ewo5TP6ZhhzwLwWDgtu/1oZhxcNYyHXNpnEcsD4bnmYGgIijMFl2jZ
   A/mz2txuzB4zQW/W9DQcSU24O2iMwgbrst+MMnidgfM/m7pCahHDypYEN
   DUm6gM5BbH4Hd/0EJjhzNijWLFFGBrkCdTuNpRxaZL0AZrmXBNnwWORN4
   a+EuuMEH8dq/LC0T6ix/zO9MxHgAXGRgPayyhf6ccAFSKhRnxHMy+fXxr
   ZZQPPooCrJ56uIGXZ/ebK6voRe0G6I2QNjX+IEs0DZGhuRctc+wgNA3kz
   w==;
X-CSE-ConnectionGUID: RwVG4w4aTA2jkzMtiY0wmA==
X-CSE-MsgGUID: gQs2jc9fQhillwOwvBy9Vw==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851684"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:14:00 +0800
IronPort-SDR: 672c93c0_zN3qFeopq3BeGqU4vx/3GyKsMdTxLE/bRJB5MBriALoDbEB
 430dnaS/iJ1/iJus2lIlyNXZ6N+Du35WsvayKbw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:37 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:14:00 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/8] nvme/031: open-code helper functions
Date: Thu,  7 Nov 2024 20:13:52 +0900
Message-ID: <20241107111354.80606-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031402_072907_1C02BB72 
X-CRM114-Status: GOOD (  11.25  )
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

The default helper functions are doing quite some things which are unneccesary for
this test, so open-code them to call just the required functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/031 | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index cd69e8e..3333338 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -44,14 +44,18 @@ test() {
 	port="$(_create_nvmet_port)"
 
 	for ((i = 0; i < iterations; i++)); do
-		_nvmet_target_setup --subsysnqn "${subsys}$i" \
+		subsysnqn=$(printf "blktests-subsystem-%d" "$i")
+		_create_nvmet_subsystem --subsysnqn "${subsysnqn}" \
 			--blkdev "${loop_dev}"
+		_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+		_create_nvmet_host "${subsysnqn}" "${def_hostnqn}"
 
-		_nvme_connect_subsys --subsysnqn "${subsys}$i"
-		_nvme_disconnect_subsys --subsysnqn "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys --subsysnqn "${subsysnqn}"
+		_nvme_disconnect_subsys --subsysnqn "${subsysnqn}" >> "${FULL}" 2>&1
 
-		_nvmet_target_cleanup --subsysnqn "${subsys}$i" \
-			--blkdev "${loop_dev}"
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
+		_remove_nvmet_subsystem "${subsysnqn}"
+		_remove_nvmet_host "${def_hostnqn}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.47.0


