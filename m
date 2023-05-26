Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18416C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmY8kN3LBBUFGQ1c51+Cdh9Ua8+O1cQ+ArRu5275sYw=; b=bYJiW7F0QQfhoHa4F8dJb3YtQI
	TGhFRv+OHkSVvxJcOgMwt9F7tm0cE4QsL3/0PMgvuBnXpD+RbVWJIdu4yGAvODOcmCiOofGkQA+6N
	mnK9unInqQYsmqihawuazBGxGtlpNOw+r5/V74H8+CalDNMgmP2U7KZS2XIistvcIct7kEiTZDOko
	SLGsnCq+gJdzwTbKLKT2ntwldFT6fjNO0MOvj6RCiWHY4w3AvhNQhriB8/e+r6IuA43Fa+Y3ffLXf
	Y2xVw1asHnmZ+4n/hQXw3Lo4sYwdIaZzb4T7mfneNJCi/Xcok5lHVsBknjhfdIGfkJEiPf79dF1ts
	OkIp3L+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXT-0012j9-1W;
	Fri, 26 May 2023 04:58:55 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXO-0012fW-34
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 04:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077130; x=1716613130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=govZswT40GqPisVwCC1SU8A5Yon4GMRNQyG6Geg9+Ds=;
  b=JLijwb8gAqDxxEJr+yLIJ6AQH+rETgLI6QCuegfJF9qRNf8n1NjVZ73G
   Gc3IC4uq0f8jbYOJWTLKZcxBo9xJe/rcP7de7qkmjv8BQm6hslfCqGvHt
   +QHVn7dwBAAGUuduG5VbEV4F+j/q5eg61JCVgcDwHIhtN8SKEOo/OTm/7
   BUkj3RYAaMDY4tEUqe1h5XAhYdkv5hRaOs5MVU7ixpPm0rMlP+MSx7qZY
   wYo+HhIa/iWGOSMFwJE7WU/ZAfsgjUEsh1e14wUYud5qKocyciUvsHJFJ
   Ilkmn/hi6PBOh5q+qulPaCt/3rH0N0D2cjuggzqWs3I9Q9+M/B+1AvcpS
   A==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231705021"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:46 +0800
IronPort-SDR: 0kuPZ+XIASrhQtfw11C9KGbeU8Rj31rgzXJKadlmHALzoIiYoxbhEbE1Kj+9+IfANgLojKpsUb
 /6RCF791GuMhKZPmxvWcDb1IN9ksGDePQOgONr7oEhm1CddX/DPl/7X3L48YkuC/cMKNXtNi2H
 RupmNNYuBT3crYrZKpOaUcGBVUGVBi9Uzv3s4ZjUlFBGKYid4+QdkD/HNj8KkirKvQR5TXgNt6
 8Gp3IGNYeoBFIR3rKn+iGYmvOtTttI4bl10rzOroicFORxifDh2BDq99Azz2LIPPUQc926l+0k
 BEM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:04 -0700
IronPort-SDR: NUuM5LWV81tnOdPR86BoSnDEOy4xwg2Ls8jnkslpCzrbGid7kbWP4EHJbFS0bh6ETPs2Qm5/9r
 Eq/7Sr2VyAP1x+psznMOnnQNC1Teptl/itSKreRQvzUBoueGrSPn97u3ID/HfLiBgWtBpYR5Uj
 ISRQoJJWtXCPQeexdwh38F4SdZ9S9u5WFaH49PWJh2rAg6mxJ7q1lw/NPe3LugaWLRNGGFnyH9
 HWMeh7VwHuuO/DwRLYBj4glvz/7jJpsvfIhpSE8lYnKYeXrOVL1/hHjeYiVnpIUqxCNCu1uBUX
 /aA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] block/011: recover test target NVME device capacity
Date: Fri, 26 May 2023 13:58:43 +0900
Message-Id: <20230526045843.168739-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_215851_049314_55A807AB 
X-CRM114-Status: GOOD (  16.69  )
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

The test case runs fio while disabling and enabling PCI device of the
test target block device. When the block device is a NVME PCI device,
the test triggers NVME controller reset. When an error happens during
the reset, NVME PCI driver marks zero capacity for the device. This
zero capacity device causes failures of the following test cases.

To avoid the failures by zero device capacity, check the capacity at the
test end. If it is zero, remove the device and rescan PCI bus to detect
the device again, and regain the correct capacity.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/block/011 b/tests/block/011
index 0699936..a4230f4 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -59,4 +59,18 @@ test_device() {
 	done
 
 	echo "Test complete"
+
+	# This test triggers NVME controller resets. When any failure happens
+	# during the resets, the driver marks the NVME block devices with zero
+	# capacity. Then following tests fail with the zero capacity devices. To
+	# get back the correct capacity, remove and rescan the devices.
+	if ((!$(<"$TEST_DEV_SYSFS/size"))); then
+		echo "$TEST_DEV has zero capacity" >> "$FULL"
+		if [[ -w $TEST_DEV_SYSFS/device/device/remove ]] &&
+			   [[ -w /sys/bus/pci/rescan ]]; then
+			echo "Rescan to tegain the correct capacity" >> "$FULL"
+			echo 1 > "$TEST_DEV_SYSFS/device/device/remove"
+			echo 1 > /sys/bus/pci/rescan
+		fi
+	fi
 }
-- 
2.40.1


