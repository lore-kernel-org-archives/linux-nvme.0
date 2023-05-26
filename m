Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFD9C7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kL+5lYYee97E6SZqoTVSe5id0GqxnXWFlUKOMno8A4s=; b=WL43Nva1nFRxEAA/6YFRuwZjuB
	UkzxozzFnVvD64qtLrRMz0+IBcE5oFsKbaJDW18IgDSICiyADb0LBPVi2rR5HFXA75WzJNH68PMRU
	N8MCMNVcQH4unXPDArnicy6xw0Hv1wRRulfGW9X/s4GJOtdyUGDoNl/QZD+mDN/VP3sYhou6r3hTO
	i71jDcaByDHTFJNz+1vCQEtkWx+mrxv9mYz7cqIzstF0Bjpv/UUONMx7v+OeBsnbkxvzCsPH4x9BD
	MqeUK2mOog8vancKf8iTyCKN1UN30HcR/khGC27ft8k2sULflH+LyqKFUQSF58pwg0Yu/W53cQncR
	upvWHrLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXP-0012hZ-2T;
	Fri, 26 May 2023 04:58:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXN-0012fp-0u
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 04:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077129; x=1716613129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmt7t8vFaRTuFbJrPQjmtj1I56fHkQ5BSpFqy997CHk=;
  b=VJFbN9FW7Ek1gdjg3onaWRGxOi1kw9NOduZ7KgNDDYZ6M+yvgDke3q1j
   h7fjF0GlZx0Er0Nk+AJ4o8/HR3DRvoka3vulC/dFUq1urfxx6GM2csv6Z
   jtjl6VOZmZuT23TLdFSuHebPz3EA0hc0QFgkD43A7emIdgCQSr+hxeiRc
   SFY1+d0N+ZG1DnI2jIuSk1oqei/aM5Jcc4K0SoxFeAq3Uq4Fh3gm3FWCU
   oQY5PNUditYSP2OUfOcrIxYSrmgOEM1Vv/RWw7ld+VZuABvs7NGeTrqHu
   Tz03whB2p6bDnnMev3FeqSTzeIC1NJYt+008JqB+lwSe9Ri5xJ6mE8XKE
   A==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231705017"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:45 +0800
IronPort-SDR: W7YEfRmB4SEUGKZ3/reUIuoUCsDYE9a+NoEAqZisKUzb12chsEceCIi+NbpS/Y5B25mfNivs2E
 wfXKWMKU5/C3tuToiP3MkNcN+tPSLZfSAvOf/uJ4xKmMUA1Zfgo+PxXtnjyrNFpmYmH7LXCdvU
 tgYG/Usx5pFne1mflUwx++sZoa5Ij4k7w92xYgic2IgdUvvyfwh7f0mzTEwc9NUC2tpUZJlRSc
 3/sNpHhKCbwFwBZPJzrYNwuZYwtufIj9cAqh/3pSedKOvGiKgblUnnsngAgTybJMhYDlKTcJXf
 x9E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:03 -0700
IronPort-SDR: aC1JkN/ow4pe3FcmT3EdEXzfM1Kga/mi5QCAYNqf+JmNjwCu2/SPeCK6QUzYtG1Kkh4MEtHQTD
 bKJIbGAIJ1w0Wz1mAqW67y+Z7dG+jg1Tb8DMTM9Uj3BLQosDIPMiB04EwL3ExdNmvi2SrLHF9T
 Nje8KJwrpwFN9U2iQAm936L5rZoE0nnYjmehtdR3rbGC3yP1KwtvcBAIu/QLYX7GcqsmimfzNW
 p1b2K255p5A23g/rkqhViJHgrr1YiaUrhMg9NFfNnbhUCAnrosHidZJx2tUWEt9snYjehLPn67
 S4s=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:44 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] common/rc: introduce _get_pci_from_dev_sysfs
Date: Fri, 26 May 2023 13:58:41 +0900
Message-Id: <20230526045843.168739-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_215849_406882_84026508 
X-CRM114-Status: GOOD (  12.52  )
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

To prepare for block/011 test case improvement, add the helper function
which gets PCI device from the given sysfs path of a block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 57e0f42..90122c0 100644
--- a/common/rc
+++ b/common/rc
@@ -313,12 +313,16 @@ _require_test_dev_is_pci() {
 	return 0
 }
 
-_get_pci_dev_from_blkdev() {
-	readlink -f "$TEST_DEV_SYSFS/device" | \
+_get_pci_from_dev_sysfs() {
+	readlink -f "$1/device" | \
 		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
 		tail -1
 }
 
+_get_pci_dev_from_blkdev() {
+	_get_pci_from_dev_sysfs "$TEST_DEV_SYSFS"
+}
+
 _get_pci_parent_from_blkdev() {
 	readlink -f "$TEST_DEV_SYSFS/device" | \
 		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
-- 
2.40.1


