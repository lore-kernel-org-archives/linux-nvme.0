Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E5C28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6TNhZPBp/7wijLHd43TXWE9WrCVvdgRyodfwXZwZgM=; b=YkXqAl2kvoYIqGPyf59ZnYkJON
	XqxZ1EK17kNOQCnyimMjH4g6wBPWEczZZi+NQ5XqwcMyJcTr1WwP940bj2wE2w3LlOq+zeUPjWkY/
	VIoel5LsVZ04+mTTIsqVClNdq3Iois9Q3f4i7FONjsUVm5kZcrASO0nL+mwsyPpTdFfaSPQhUuX1U
	Bd96Q3+OK7wAbvXtq19U1Q55ks9jlNZEu5yi9PAp6JvwwIwCBXxcL2x7VZLRrwmcvwuL3Pgc29LR1
	31iR+cLZDLlHmqejybjTJs8G0nx8puRlDaT5REflBwah+HG0NduI8jNXAje+7f/AwhRpmj7L1ybL4
	n3TLziUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsYx-00000005NCL-3Kzu;
	Wed, 02 Apr 2025 07:31:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDm-00000005Ju1-3Twq
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577750; x=1775113750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//8Nb3BSwEDLv+lBYEejrYD/CHrsy84oq7ePiX7R4oY=;
  b=nFUdj3UMWVJ/nA+s8FHXUOZBXUEBijZygPsVfPhLtbGHtnNa0+fSLAC0
   tpUWU8LqbUwlrR5WYDtgMjwunr4bCUr+Bl8WHH0CCD3KRcE3zYtFHFwOW
   BlSpP9Bioow3E9R+SUVF9sILi/goKWJNQbE48EQ51Euim2bIHKotxse1V
   fEASdqhikgoISlUxFshU7MCoHX3FAcTu7LanHzhXixotNS6sJXyIWlfCL
   IHCb8OMuFqvPiJfU8HIDCaScOSo5mh06GVcyl6rOe+ZVWyi0GagJqSHAo
   05R7q1iXN225fjkIil2IsBiWeGgGDNvJ2/JPqss98LTOF9L6c4yDegemX
   Q==;
X-CSE-ConnectionGUID: 3Iorg5utSlqWwfILsJ2LyA==
X-CSE-MsgGUID: BIjkI11+QAGvIJaBwCcLCQ==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793466"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:10 +0800
IronPort-SDR: 67ecd49f_vn00Acdqjb9aqPW7gCQPCr0jWVN3Qkcp78db/yoiv8knC4p
 /LMJvGyhdsGZBy1k5Q6vJbN0GFfw7UdKDsH/2JA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:35 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 02/10] common/rc: introduce _systemctl_start() and _systemctl_stop()
Date: Wed,  2 Apr 2025 16:08:58 +0900
Message-ID: <20250402070906.393160-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000910_872097_5296C13F 
X-CRM114-Status: GOOD (  12.64  )
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

When test cases depend on specific systemctl services, the test cases
need to start the service. After the test case completion, it is better
to stop the service. However, if the service was already started and
active before executing the test cases, stopping the service will affect
test systems.

To avoid such affect on the test systems, introduce _systemctl_start()
and _systemctl_stop(). When _systemctl_start() check if the specified
service has already started or not. If the service has not yet started,
start it and record it in the global array SYSTEMCTL_UNITS_TO_STOP.
When _systemctl_stop() is called, stop the service recorded in the
array SYSTEMCTL_UNITS_TO_STOP.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/rc b/common/rc
index ce7f975..068a676 100644
--- a/common/rc
+++ b/common/rc
@@ -13,6 +13,7 @@ shopt -s extglob
 . common/dm
 
 declare IO_URING_DISABLED
+declare -a SYSTEMCTL_UNITS_TO_STOP
 
 # If a test runs multiple "subtests", then each subtest should typically run
 # for TIMEOUT / number of subtests.
@@ -511,6 +512,26 @@ _have_systemctl_unit() {
 	return 0
 }
 
+_systemctl_start() {
+	local unit="$1"
+
+	if systemctl is-active --quiet "$unit"; then
+		return
+	fi
+
+	if systemctl start "$unit"; then
+		SYSTEMCTL_UNITS_TO_STOP+=("$unit")
+	fi
+}
+
+_systemctl_stop() {
+	local unit
+
+	for unit in "${SYSTEMCTL_UNITS_TO_STOP[@]}"; do
+		systemctl stop "$unit"
+	done
+}
+
 # Run the given command as NORMAL_USER
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
-- 
2.49.0


