Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F329E7C4F4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3pIomq8IgPRDFR958eGpQlQuQqUlaP0fILbsQjF0Hes=; b=D+Ve2vXByRWWPkVrEyuiuYPnJU
	VMMiKYpTrqq7G7LviyUMawfdUpnPDWT9Vs70kgReGy7YdPAqLFTeCMs+EtlNeOF6UUcWAobPNzVQ7
	kan50HYjNWabw5mzEgy26TxINxnOscFTi/yBtTIPs185vwHDCXX0wIGBvKEVwGzy1hasRnBbrXexL
	ggKNeFxkn+Z4KVdkBxiGnRJdq9p3uDPLBlKjiFbbpDYNYjg6X6SWDrC680L17wQw0n1H1Zqv3uf+d
	QNzhnGy1cDYyfA++5Yrw2zIGzoBBNciDWITNSZ58SX2kake1dg3WCd4mZCVFjCrAULNlkcUTOnJhm
	hNWn+hyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJK7-001dnE-1p;
	Thu, 05 Oct 2023 08:03:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJK0-001dig-1c
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 08:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696492980; x=1728028980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XcAujXW4ucxGpO1rPRNmHohcn1w2B4X6WE50bbphgns=;
  b=evjRFIF+6EOY8uT3YBmQiDK30xIclppm5hfqHg8j+xyCLedBWB7ji3PZ
   DQVYIMLW7uSWDEUZkZETjOZbKiaDnGAryLzXZ9M/RSSVA5kiWMqyMqcs+
   Gd033EC29lWgFq1xEaPg32VNbhem/bBHY0gCErm8D+2+wxBbztldozCpf
   VWoP3wGEk0txVRQm3sgRxtlosrBHmTpx4PXf3iIOEOjrcCNJBh1hulXz/
   6qY3GOrFQZOJ/xc6rorw6fJrdEMw/JHrFtZH2IOX/ABDrg7sRfQbTWJFl
   zebCUoSFpNauJtMKQBa/diMB2SqcNIPTxJ4DvHVYFtkD5wdYUcCIE6fld
   Q==;
X-CSE-ConnectionGUID: 0iTytobATjGc6tPRbLFIyg==
X-CSE-MsgGUID: ro6eGxlOTPKkukTElFphXQ==
X-IronPort-AV: E=Sophos;i="6.03,202,1694707200"; 
   d="scan'208";a="351122191"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2023 16:02:43 +0800
IronPort-SDR: MetO7aOEaV9ghdgUVJXhW41wXhVNAO6FpcCSrRVunFa35qK40fVPllveKCCax5JOkdRt/vb1Fk
 kuRTUgdLXbrQdezfRWstl1QVdRsywW20FFG6NAeMV1n1VAH4IrGfm6cRjvem9543VcY1jl17rE
 KyurNJtV3ik2+gKcEYhne0HRtudWUvL+HAvQmJ6Bk2t6gj5OJEbxk+QuMBNGny4PYidFtWR9dG
 Rx03FDsxtK4Eq+F0Cdwo/Kp+MHhghOCe+aqSYl61E47nPkgXRFAYmwQljnjp+HhLlJ0cBPYVxU
 WcE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 00:15:00 -0700
IronPort-SDR: L5Cfa9o8BtXKZQ7ZfdIK2DRNEX+z3k+hfnJPVo8DBI6bwvm77IF0gigEbOrJij8Gl2TUpePJ84
 +LefZDSBBatn95fmkqZcGQ2BuIeMp/QmukxiTuEbHe41KvJOZVSHS7onC+HXPjk77Ui96lYdVj
 OP0LZ+T4DHkd1Sf0L1+YPi+ktXIWKBNoQuJfRbpy+g9g4tWkghI32Akk3x0V4+8zMPG1Yb5sZ0
 Uv2LgGYbBHtnsqSQgxqwLKE7VGRXXFJ8LtYKGZSL5XDsGNFDXslmnBsqqeaa6gMFxUFSnu5lZY
 AxY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2023 01:02:44 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: fix rdma driver check
Date: Thu,  5 Oct 2023 17:02:42 +0900
Message-ID: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_010300_583961_80C00F00 
X-CRM114-Status: GOOD (  11.57  )
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

Since the commit 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not
return value"), blktests no longer checks return values of _have_foo
helpers. Instead, it checks if _have_foo helpers set SKIP_REASON, which
was renamed to SKIP_REASONS later, to judge test case skip. If two
_have_foo helpers are chained with ||, the skip check does not work as
expected since one of the helper may set SKIP_REASONS even when the
other does not set. Such chain with || is done in _nvme_requires() to
check rdma drivers.

To fix the check, do not chain the helper functions with || operator.
Instead, refer $use_rxe to call only the required function.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1ec9eb6..bac2db7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -44,7 +44,11 @@ _nvme_requires() {
 		_have_driver nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		_have_driver rdma_rxe || _have_driver siw
+		if [ -n "$use_rxe" ]; then
+			_have_driver rdma_rxe
+		else
+			_have_driver siw
+		fi
 		;;
 	fc)
 		_have_driver nvme-fc
-- 
2.41.0


