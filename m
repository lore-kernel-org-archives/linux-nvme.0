Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1CECA0EEB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ac3mgkOF5dj+22+0dp2ezh5Qm0KBNweXr+MZsQrqL6E=; b=Yf9O86FBA02lZ+6KOTmzC73jWG
	HO79xKsGBmMAV1Fk49uFa/iTMn4di+p7aCnDG5NopnnOsY3iilLY3IecXKaoeMj68qkY2Q9J5y8JK
	UCtygh8uSgUhm5scy9FFPA3bVEhiCMW3jmQwFrc9O3IatT9M9WNSnG0fDiJmeDvlDav4c3yZHGhSf
	hafKmdSMY6JP2E/NM2jtFjSTO3wktYEKZMsFCiYKYatGeQ45+xoTiWPFkHnbjxx4+2AZSnPYEHDUh
	2UJ53Enotqvt+TIF+Fu/f9qlstSMwQ3rpSYYcGaNeRS/4Al5CPVAvLdmgMGjOrCkh4xmo2EMjTmIe
	bde4d6mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo08S-00000007cjW-13NC;
	Mon, 18 Aug 2025 13:42:52 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unykz-00000007JB8-0VNc
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 12:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755519273; x=1787055273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IV19IBf/ZIG0CYko5bRs+Ch2/KPWvylWxz3d9S36qYo=;
  b=dsafubeK8vbEJxMzxskQfqCkclqUlqA+5TmCrKKc5vvJzlCh4DWBc8tt
   T2QAfDa/QJ9/tm1R0TTSQBYqr9ffVRjIYNS4TsKCoKKBxaWyyqfjpY4ph
   IgEMApJYp+F2yn5AXM79Umm/piW1WFEJ83pOrD5xRi5H3DdFBAdvEkH82
   jeGL5zbgUux5hwgfaBVwgeUYx3Qmg6hIJWDtYzbxLQobCGPFwbl0yf2Zj
   vE+h+BrXlBLWTuDLPy/gR5CoHrWdOC3tg47p7Wpj9CnXpqfJamaJg4fCs
   sgqcqknk7zBN+GfUtaQm1KTa86TAv+PMiWrg7hd2q4/gikyYbOnDK/eoH
   g==;
X-CSE-ConnectionGUID: GV35f91IQ/yUABb4nbMw+w==
X-CSE-MsgGUID: hbV9jYorRaaSjhPks7SGwA==
X-IronPort-AV: E=Sophos;i="6.17,293,1747670400"; 
   d="scan'208";a="106040925"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2025 20:14:31 +0800
IronPort-SDR: 68a30a50_hN5NoapMZLnlnLDtFI16b7ZN7ePBMAa1wF6FHLh0QUbmNdw
 8iRmXC48cjNmKLNNVXMQ+YrbUOjqunq3t8vEwGA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 04:11:12 -0700
WDCIronportException: Internal
Received: from wdap-o94mrqhjyp.ad.shared (HELO shinmob.wdc.com) ([10.224.163.59])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Aug 2025 05:14:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/050: repeat checking test device restoration
Date: Mon, 18 Aug 2025 21:14:29 +0900
Message-ID: <20250818121429.1579513-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_051433_182628_C79A0211 
X-CRM114-Status: GOOD (  12.67  )
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

Since kernel version 6.17-rc1, the test case nvme/050 has been failing
with the error message "Failed to restore ${TEST_DEV}". This failure
happens because the device restoration check is executed too early,
shortly after writing to /sys/bus/pci/rescan. To avoid the failure,
implement repeated checks for the device restoration with short sleeps.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This is the blktests side fix for the nvme/050 failure reported for v6.16-rc1
kernel [1].

[1] https://lore.kernel.org/linux-block/suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun/

 tests/nvme/050 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/050 b/tests/nvme/050
index c710832..ba55c6e 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -23,6 +23,7 @@ requires() {
 test_device() {
 	local nvme_ns
 	local pdev
+	local i
 
 	echo "Running ${TEST_NAME}"
 
@@ -49,7 +50,13 @@ test_device() {
 	# Remove and rescan the NVME device to ensure that it has come back
 	echo 1 > "/sys/bus/pci/devices/${pdev}/remove"
 	echo 1 > /sys/bus/pci/rescan
-	if [[ ! -b ${TEST_DEV} ]]; then
+	for ((i = 0; i < 10; i++)); do
+		if [[ -b ${TEST_DEV} ]]; then
+			break
+		fi
+		sleep .5
+	done
+	if (( i >= 10 )); then
 		echo "Failed to restore ${TEST_DEV}"
 	fi
 }
-- 
2.50.1


