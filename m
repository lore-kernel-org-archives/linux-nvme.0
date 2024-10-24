Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0FED0BB4C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCB1GfaLAgbBSwNDiSswv8fXpQE82cg4qCD/IQ9CNcU=; b=ff2g7YY/iP/+B+2WUx6r/DliRT
	Rzi3n11ucNP8Tk2OUwU9sXdp1a67zz9ybuSjn2+LbVZtod9r5tNFMpQfWd2uFAGFN3o/6dZ2KZRHo
	6EQ2JGV3bhdWimFg4i+FmQZQXFLM0rjhAuTTOysQ37baEuh/9psTfclFFbZKDo0Byq/nE/+8IOEKX
	H61rh70gQ6SbMUJTitJvtTvudSnKAIvBmZ1ZppKbku06HVMicRdnRSZhp6xQbd17nb3odPGFK8lsg
	h35SPUnctVZsSdCh8U1wihcE6YYVBC/xJwTThTsebFx7+L7R+gw5QEM95GkCVPx3w8ATt6O5cMgbi
	wBroBETw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDV-0000000GMiA-39i0;
	Thu, 24 Oct 2024 01:00:45 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDL-0000000GMWc-3ilM
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731635; x=1761267635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDGFeMQa/GQvOO5xbJHeBTsLjdH9slY2Cx1Ovz8JpRU=;
  b=nK9g217uQtoGr7JQp9aSXmZUfCf/VcuTCLR2hj9E/ZmVKxTtynpUNAru
   eOnocbsSizm4esQhCw+7UQEXsWsg0Dmz/LX0P1mgYn5Gu2R+qSVeS+ij2
   07JaTmFNd87kXi5uwW/CTVRyRFS6qBZADE3K62xuBs890gjsIiYvqpFoN
   YfAraqeucChFEK5N6IIHIpvR8XOqSjJPCcrlMTF0/XW7vZYT3iVLQBxeV
   6tnhcj4FjHqhI4IQtKPAOvEz6y9/nHHin9cKthr5aTBV5f5igrUZuDQg1
   o+NjMX2GcIlAoKy2mrWAsw/cOx/peVZTD/VPkz4hM8PEg9dSK9WBRiolM
   g==;
X-CSE-ConnectionGUID: NYJ4EVYmR2CnZBqqlVZWIQ==
X-CSE-MsgGUID: qsgv96BJQ4y9gu4MJY0Taw==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211123"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:32 +0800
IronPort-SDR: 67198f18_sOq+x1AL/cjhSguBWl9TBC0HuhZ8cwqNX/D23IzRYNUwGCx
 C+/bKmZ0dEvB/ANJ1+lWB6F8qbPd0+QRgP4iNdQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 07/15] nvme: return error from _find_nvme_ns()
Date: Thu, 24 Oct 2024 10:00:17 +0900
Message-ID: <20241024010025.2216242-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180036_027054_9D4D73B7 
X-CRM114-Status: GOOD (  10.28  )
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

When _find_nvme_ns() fails it should return a non-zero statue to allow for
the error to be propagated to the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/nvme b/common/nvme
index 2ef9fd8..5d2e38e 100644
--- a/common/nvme
+++ b/common/nvme
@@ -694,8 +694,10 @@ _find_nvme_dev() {
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
+			return 0
 		fi
 	done
+	return 1
 }
 
 _find_nvme_ns() {
@@ -712,8 +714,10 @@ _find_nvme_ns() {
 		uuid=$(cat "${ns}/uuid")
 		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
 			basename "${ns}"
+			return 0
 		fi
 	done
+	return 1
 }
 
 _nvmet_target_cleanup() {
-- 
2.45.2


