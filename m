Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7456ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 05:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wBDx7/wWPZrawDtwys9f5J4g2096Qzi1vuniMl8sY1E=; b=Ily59Tq9eiA583atg4Ueo+mXH2
	KJDSCpCP7RL9s1SbHAqL6M+sHYIo061bRWTL79Lk6jwtl7WzWLm3SLc3m9McQoPtTfoQPDPDNBO/S
	HiYPw0twSXIKtlI4KL66d9nNzyXbSAuYEzEQWE6FLmQCM79yDQ3Ax7X94qH2+xo4pp48uwic6F0lo
	Uq6NxPvjnYo0Mm76E5PelzDcOimvP+MYPiI4ZEVgfj594fbW54FPleL58V48XBRlnottwHPtCB1f6
	44IZ7SbjcFV0t/hyJ3G/CYewXjR9PUD35KBhJQbQj7TXp8UXd2kd8MolCU3UTIvFE8AKG6yJ8xfTH
	202hq2Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTGGK-003zg4-0N; Wed, 31 Aug 2022 05:27:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTGGG-003zdc-Pv
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 05:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661923655; x=1693459655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByKcWcIpfCse/1hPY8HeKN2pwqbZzeKO8j/Hwys4Ebw=;
  b=HiSN6rf/BRtHkeAbCSfXvzWVok7BZbAVy8rOfrPI73rGhctq+K3P7CIP
   UQaim7/XKEfunlpHAsB4WHxmYbYDbRWtfaxpPWRWiXIdqiElnENosLSi0
   AekLmJCwOTLOdTIMkOS1a5mclJGWMmju4290kLkTCk8xkCtC9XD5veaN9
   3v7jb3l4jowYLC+lAZ5ofP0QM1u54jrLFLLw8jmjUNN8P5cPswmVz0j6c
   6iWsv599htXIoudefJ7nVFi0YeiW/td6HTPLNeQTXxkMQKPXJkr4d2ppa
   73mWmwWpC03T8J80NOw4mfqwTZRsjTZrkAF8AkWb3tBm5HxIY2kh+RMk8
   g==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="210094072"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 13:27:29 +0800
IronPort-SDR: 3O3HMgELOtyCqt0CL0zVD39s/HfaYB6rdMXcEEGrnOsoRFBadcKJhj9c6R7Un1cTtY6uj5bX4S
 m4tH6cKp6vDSPQY6uwwX7LbTzUFKu4CBE2sh+lmQ5CGueN5DeJnJmMm9towcx03G4QRwQVYoGU
 rc9NrGezr8yCvCMggikMV39D4SW5tJkbkLif9zBGz6pDzOB6TRZaIjzBlGt6mHeMbU9C4KfZte
 AapJVEYbwXcNHywQ+xwUWh6S1pQGro3/vZJSNZD6oJ/dRiYg9hGSekJlcCs6ouQm7+o3LgfdJR
 C7VUl90mk4T1xTEEQfmk26j0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2022 21:42:38 -0700
IronPort-SDR: hizPfkSQj+R1AVB3qYVnBn+WcmNuyOXqGHpB9nU3LxPHCOnhHhHhzb+X61rW/E9VbbNrVYcZbS
 2i89kdt9/z67upctY9EHlsU58HpNFqdkVxA6HeyfKpFBj8hrrkRCDNXwMKMj5VFoPdYsM4LFWH
 GwXZB4uqRoja2oLHuJOR4BqTFulI6wFUumGUUdKe0yTwb+6gGpFjJcQHFRDuU6BCgMhEBIUBS5
 7AXAfLXqjaGPleGSuUiK5mda+NPdRuEMFY0sdQxc3/B2ed90J1hCp4qd+QK390hvUO3JbkaLjw
 fiA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Aug 2022 22:27:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/043,044,045: load dh_generic module
Date: Wed, 31 Aug 2022 14:27:29 +0900
Message-Id: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_222736_873792_1CF5EC4D 
X-CRM114-Status: GOOD (  10.34  )
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

Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
module. When the module is built as a loadable module, the test cases
fail since the module is not loaded at test case runs.

To avoid the failures, load the dh_generic module at the preparation
step of the test cases. Also unload it at test end for clean up.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for authenticated connections")
Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/
---
 tests/nvme/043 | 4 ++++
 tests/nvme/044 | 4 ++++
 tests/nvme/045 | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index 381ae75..dbe9d3f 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -40,6 +40,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -88,5 +90,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
diff --git a/tests/nvme/044 b/tests/nvme/044
index 0465531..5ef6160 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -51,6 +51,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -118,5 +120,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
diff --git a/tests/nvme/045 b/tests/nvme/045
index b60f18f..1d44c55 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -53,6 +53,8 @@ test() {
 
 	_setup_nvmet
 
+	modprobe -q dh_generic
+
 	truncate -s 512M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
@@ -130,5 +132,7 @@ test() {
 
 	rm "${file_path}"
 
+	modprobe -qr dh_generic
+
 	echo "Test complete"
 }
-- 
2.37.1


