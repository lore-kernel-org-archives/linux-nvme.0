Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C215CD98FA
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKbRDKMOJztUv49sILaukziN+K2G1il0E9dcwo+oHmE=; b=Mkj6v0EOGGcTrMscXI7cHABXNB
	9yXsOXG5+wqZqSXBM/d3TZFwEV9aGxI2vcYpJI8Uc3cG7NtLApOvDT6IZi6/C9hCzZ3TugwdQpDih
	UG+UlBBChqd3Da+nbmLl8aj+iKq/fCx6RbQXZ7dprjOnCHDXmLXB7FIjxUMzvTiMMlj/hBNBCxXWl
	q/tpogJW4JlSq62uP/idPDVVS88ABIxsTvauEVFEwHZc9LVmowt+Er4dtOHoLmbyEWREpoOa0MRO5
	e8A5TISpaCq0AvSdkgowqlvwS0/7OchMXvE3sFIsVq8evoQj7ZiqFxfLUzE/+HdgSRRXuvy6NF1Dd
	ifL346Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7K-00000001v2P-0N6r;
	Fri, 19 Jun 2026 01:33:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7H-00000001v1N-3cJq
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 01:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781832836; x=1813368836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXU0BKLcSkMi7NJ8O8CD2V+LWjO950qSKHiY61h37ro=;
  b=CYLWEWlx+PToSiNQtBSfeod+PKnBRFlB9e5kWzbz7QWF2X6yWiXL0UtT
   kmXNT9Ikv45jrfjURrxss90mziYDcKOVq5pP0Z+mrEy5CRe+Javxe2jkB
   K+6C6lybvoamg2cSTfw6lcwm4LJ9H903kinpbJiKew3oIAwt1UyXPy6M2
   BYukeJfKkXEXMcInk6zwLLt2wnn5AXPD8SEgswN04gOgIDGMENxwsw9Jh
   7o9iGOyenmpPtGQW02rmzuoHvNvd0GFh1nerSnCecrocYCyW179FW0iEI
   veq77krh3fsYPxj0OtbEtiv6BNZm9Bagok+SNfYCNfRxxcxIQPSHUU254
   w==;
X-CSE-ConnectionGUID: GbBQ8W3YRHaOjeP92kGIkQ==
X-CSE-MsgGUID: eFzOUX6DTiu9jrvYnipcqw==
X-IronPort-AV: E=Sophos;i="6.24,212,1774281600"; 
   d="scan'208";a="147932158"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2026 09:33:54 +0800
X-CSE-ConnectionGUID: d17bTG7CQnWx/2OOMwLwGQ==
X-CSE-MsgGUID: t1MEPTMSRLapX8L1HT8NNg==
IronPort-SDR: 6a349c6b_FTwUU34IDcMqOh5ikM3hlwekgXxC8giAA6S8oyWHBlvPxGH
 SQEyf3K3syw0DzewW6Xranf+xrg5tmQJsJEybYg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2026 18:33:31 -0700
X-CSE-ConnectionGUID: T7nyepqlRyOWxF4itVTaFw==
X-CSE-MsgGUID: 6ObMVHC2TmynI4xwm1IQUQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 18 Jun 2026 18:33:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/060: suppress state file write error
Date: Fri, 19 Jun 2026 10:33:28 +0900
Message-ID: <20260619013329.558580-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
References: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_183355_958431_CAE98A0B 
X-CRM114-Status: GOOD (  14.31  )
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

The test case nvme/060 sometimes fails with the message below:

nvme/060 (tr=rdma) (test nvme fabrics target reset)          [failed]
    runtime    ...  27.967s
    --- tests/nvme/060.out	2026-01-19 04:30:04.820982813 +0000
    +++ /home/fedora/blktests/results/nodev_tr_rdma/nvme/060.out.bad	2026-01-19 06:44:49.223643735 +0000
    @@ -1,2 +1,3 @@
     Running nvme/060
    +_: line 1: /sys/kernel/debug/nvmet//blktests-subsystem-1/ctrl1/state: No such file or directory
     Test complete

To reset the test target controller, the test case locates the "state"
file and writes to it. This works in most cases, but the write can
fail: the test case connects and disconnects the target controller's
subsystem in parallel, so the "state" file may disappear after being
located but before the write happens.

Suppress the write error message to avoid this sporadic failure.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/060 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/060 b/tests/nvme/060
index 997512d..9e694af 100755
--- a/tests/nvme/060
+++ b/tests/nvme/060
@@ -19,11 +19,16 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
+filter_state_write_msg() {
+	grep --invert-match "state: No such file or directory"
+}
+
 nvmet_debug_trigger_reset() {
 	local nvmet_subsystem="$1"
 	local dfs_path="${NVMET_DFS}/${nvmet_subsystem}"
 
-	find "${dfs_path}" -maxdepth 1 -type d -name 'ctrl*' -exec sh -c 'echo "fatal" > "$1/state"' _ {} \;
+	find "${dfs_path}" -maxdepth 1 -type d -name 'ctrl*' -exec sh -c \
+	     'echo "fatal" > "$1/state" ' _ {} \; |& filter_state_write_msg
 }
 
 nvmet_reset_loop() {
-- 
2.54.0


