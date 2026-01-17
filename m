Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ECDC9830D
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jan 2026 05:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d573w4nH/ilsoLOvw7pyjPKunjo6R4qdqb2xaVCLBzM=; b=eWGK8L0JN/T8OTUxQyahkfakVB
	s9F1fa6CznPwrNMIzMsYgkTVOEEoCLXic1Z5AXuqHVeUWQW6RVSZBvLYMzfEURL6TiyKhg/S6TNcv
	Q5yiybA7ofuPgpvBRoy+T4+YkQWgtg9T84YXii+Nx2qbZWhJiqJwgu5iXy5ZzsOAmTWuL8sY5hQgx
	taqX1scdvhxnBknDYNGYXc3f/l6UeJQMa1qq8HeMmWZAGHqvM3qtRjNivchKzSabHS3/R9Y3r8M3m
	jrfK69mmJDWsKoyi+ywr0nu0Ph54NpAb17SLPgRfl02EDJNT1p8Xkk1Z1f2s3weWOPAg1XpAlIi/P
	JWk2wsZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgyUm-0000000FDL6-0dmp;
	Sat, 17 Jan 2026 05:05:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgyUi-0000000FDKg-3f65
	for linux-nvme@lists.infradead.org;
	Sat, 17 Jan 2026 05:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768626303; x=1800162303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LiuxvsfThN7eejjUZoskxLSXjY6XGSPQ2uyXWcGO+E0=;
  b=AV7Su7pENNOpJfG4+pED+watpbbO6Il3OwosGAxro8oz9n9XmxDaevuz
   8Q91CkrLnvAo7w9tPktKkYqe7skS9yyiT+RzoRPxtttwKclZRuGH7EPaA
   lqy+iklVS1HmbGygIsGvUMRROTS1bUFKbbhoipsR9Sag/+iQsVuOjMnLp
   G4a3tlit66JoRmTZ1xgCBwUvXERMUEIjSE65Z0qeTmpfD07ypJzc+U8bw
   7Nlu+bYmHJqs8oLG2l0hspGZBi9F3dNh7q6CSCmjNLvzO1N7Lnf+s9PFJ
   aRYQqotDksjes5/VfcFtCuDSnc2MfRSHm0G2CyKWzsOrcbxXKunmWLm5x
   g==;
X-CSE-ConnectionGUID: u3MWhHWqToSIsJwUz3Z18A==
X-CSE-MsgGUID: SGjpLH9YT0WwRK9ovNMISw==
X-IronPort-AV: E=Sophos;i="6.21,233,1763395200"; 
   d="scan'208";a="138725977"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2026 13:04:59 +0800
IronPort-SDR: 696b187d_5PZ8woqMPKrI04k27UULZXOgTY8OJlV7LK1UOET//oFlkfh
 7tH9q6by4pAgADVHTSatO6VNJbKiSiu9mJk/XUQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 21:05:01 -0800
WDCIronportException: Internal
Received: from 5cg21741xf.ad.shared (HELO shinmob.wdc.com) ([10.224.109.199])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jan 2026 21:05:00 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/nvme: reset def_adrfam for ipv4 case
Date: Sat, 17 Jan 2026 14:04:59 +0900
Message-ID: <20260117050459.28678-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_210504_938998_B72BA7F7 
X-CRM114-Status: GOOD (  12.79  )
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

From: Daniel Wagner <wagi@kernel.org>

When NVMET_TRTYPES specifies multiple transport types, blktests runs
each test case in the nvme group for each of the specified transport
types. When a test case is run for "fc" transport, it succeeds. However,
when following transport is "tcp" or "rdma", the test case fails.

This failure happens because the run for "fc" transport overrides the
global variable 'def_adrfam' with the value "fc". 'def_adrfam' is
initialized with "ipv4" when "common/nvme" is loaded, and it was assumed
that this value was not reused after the overwrite. However, since the
commit a16ac8e052d4 ("nvme/{002-031,033-038,040-045,047,048}: support
NMVET_TRTYPES"), the overwritten 'def_adrfam' is reused for other
transport types and the value "fc" causes failure for "tcp" or "rdma"
transports.

To ensure that 'def_adrfam' has correct values for "tcp" and "rdma"
transports even after test case runs for "fc" transport, initialize
the 'def_adrfam' with the value "ipv4". For the completeness, set "ipv4"
to 'def_adrfam' also when "nvme_adrfam" is specified.

Fixes: a16ac8e052d4 ("nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES")
Link: https://github.com/linux-blktests/blktests/issues/217
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index eed5db0..311b1b6 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1190,6 +1190,7 @@ _nvme_requires() {
 		_have_driver nvme-tcp
 		_have_driver nvmet-tcp
 		_have_configfs
+		def_adrfam="ipv4"
 		;;
 	rdma)
 		_have_driver nvme-rdma
@@ -1201,6 +1202,7 @@ _nvme_requires() {
 		else
 			_have_driver siw
 		fi
+		def_adrfam="ipv4"
 		;;
 	fc)
 		_have_driver nvme-fc
@@ -1217,7 +1219,8 @@ _nvme_requires() {
 			def_adrfam="ipv6"
 			;;
 		ipv4)
-			;; # was already set
+			def_adrfam="ipv4"
+			;;
 		fc)
 			def_adrfam="fc"
 			;;
-- 
2.52.0


