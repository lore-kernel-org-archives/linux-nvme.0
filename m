Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98533C3601A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PB+ZvnFgUlMiLOenpOxVotsIwUnx8OzFje6NNLsSywo=; b=QfJgAUXNMGlWTfWhDnewvlbMBe
	/nSYViEdYZlDt/ramslHs31LM1VRaDukz/NL9GlsEImg8Qz/I3JzJP9f2D/EmYNK8HVfv9QpCDpIF
	qhwX8gUZjuLJxYVsrsKk93G+37n4M9cVPmDf/nC0LlYP+Zi2YTeD8kttaSxSIuarW4n9vvLvh162l
	X6sAVNSsn5ji+2PzjtVox0oUlE85xFyPKCWGC2p4uOF5JLWFs4JgcPpn8qSfWXnulc5prEWDrvyRW
	OwGtA8iYsbauEt/N3k2siWqFbQdftWYb/E+Wvcm86lNINd+RjMBJpeMkmsqmxVtfnASgEyKMhSA3p
	lMxqdq1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsYw-00000005NBU-2PYS;
	Wed, 02 Apr 2025 07:31:02 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDm-00000005JtH-0lqD
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577750; x=1775113750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YXy23ytnJLV0YbuAGgRiT2EsTOOJ5DnpJeZbJUGvdE=;
  b=M1dYXuVUWAxRdQn2pJ036pcLoC02m7c/4sT1s5Mmpgut+kp5V4V5qWVv
   hhjU2x2v7hnZ5cf+sClzu+iWsu75AK1DE6DNc+RK5aXb+ZVJJ5jrak/pi
   sHpsYIPyP4nJCUtRacyD8qKl0XkxtoWYbi1n+uU9WXO8Y3NmSdD4JjaH0
   lScozkjZ8q7QDD7kQYfD+6A9QsZx1mP3aw/RxfT85J6U3093uB6TxrGL5
   p8rQuBaSZAgvGGYyoDdaQIO65tqU+8hhwqq45TakU1gXd41G+l8LbjcHO
   DJgGdSWl/N8GqstTfq36H7d0J7i9JD4LyXmAp6Ml71d1HN1HBh4+fxQwc
   A==;
X-CSE-ConnectionGUID: fpYuv05XR/2MwP+JbpXHBQ==
X-CSE-MsgGUID: bTZ0Zuq2T4uhh1FCwQvLuA==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793444"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:09 +0800
IronPort-SDR: 67ecd49e_z4CYIo3LfzvUe0xtGh1a9lf5O73nx80+1LHDghrSMhF/jiy
 Om6nofIwnEejpHxEzx7KA2RSaOymeH99+13vybw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:34 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 01/10] common/rc: introduce _have_systemctl_unit()
Date: Wed,  2 Apr 2025 16:08:57 +0900
Message-ID: <20250402070906.393160-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000910_227080_C9E9A164 
X-CRM114-Status: GOOD (  11.09  )
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

To check that the test system has a specific systemctl unit, introduce
the new helper function _have_systemctl_unit.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index bc6c2e4..ce7f975 100644
--- a/common/rc
+++ b/common/rc
@@ -500,6 +500,17 @@ _have_writeable_kmsg() {
 	return 0
 }
 
+_have_systemctl_unit() {
+	local unit="$1"
+
+	_have_program systemctl || return 1
+	if ! grep -qe "$unit" < <(systemctl list-unit-files); then
+		SKIP_REASONS+=("systemctl unit '${unit}' is missing")
+		return 1
+	fi
+	return 0
+}
+
 # Run the given command as NORMAL_USER
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
-- 
2.49.0


