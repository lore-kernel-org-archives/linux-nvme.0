Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A385C5ACB3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 02:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvZ5UrNbRia5Pn7IAvuuMMeEcSuHwydOvOMG7/izKCg=; b=qnOuvpx4N5Orn8bujnNno93JYh
	jc0N7x+hdhi5DtaqK1DssxS4DZVY3fzX0kZSpkb4kUmS8oQc6enzLf3jnF/fKaLrgxBQI3ckld9sy
	z8BnD7NHfR3CZN8kazvoKkvyt5tGJiSEt3TRiouqyCsHvw1vMjyQ99HRE1AuTvSiRvw9ZeQXDh07m
	9FD0h3ApDlpBqj2I/R+QdchlN7DOyY/EYMKbAODA5TBkjJSB7KCJJs2x/wR+HW4MrHPjevNUidCso
	aXQ6yc0mMDrYgzWm+XjA5gLgAcfjAvS/eUEJbCcIBbvtWsgyCsbYFp0nOGTu27KdizoXTc3xEmXAd
	Q/utZdzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r4uM1-00AyTc-0p;
	Mon, 20 Nov 2023 02:49:41 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r4uLw-00AyRn-1s
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 02:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700448576; x=1731984576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i4Jq9ujSuw+tbJO/gE7VpPB4GEvE8wZu/dgRKJY3A04=;
  b=hk7OCH7254UOUoW5CW9AJdHRbhOuBQGORLnsnfH9LuhkqzWstBo9KkCh
   s6o7lgF0z0ZyrsQTwWb3UINwKgkGYUAU/8BO86C85qkdCbErOvSaOABgx
   Hrdk70dfXPA5IOOMzvHvJCVuEKYrrF4JC3iB/dC4KBtgr/PCLLlMU7ocC
   QFflsCj7ShFjhFDDi8w6g6BnffExhyHRRPhDQ8hOQ1NoJsNtjODspwz9E
   +/nI+yj0VCzZVehh++9GGLkhYdspghOiFxSVwhB8/byhITBcB8NBd0bvY
   vGQPGLPtGNGftDqLrbFHwVataOWYaIlFvrP2311woekasoaKpoR+W6dU7
   A==;
X-CSE-ConnectionGUID: U0f7rpxHQZWzrSDFCX0D5A==
X-CSE-MsgGUID: Gbp7UFC+TaiEowexpMIiRw==
X-IronPort-AV: E=Sophos;i="6.04,212,1695657600"; 
   d="scan'208";a="2663717"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 10:49:35 +0800
IronPort-SDR: 5BVW/m0QoWijY9hp12+VoNAzUtcMCB7vy73LmMawRLN745UWjAcpJn2ptyItVnmlroViLKwcWL
 baqxXwVBlFVk/7dvUMoEjD5HpWWgFt09xDc8IjitGjJN7mWmq8c61WHK8ERZpHBHFyWh/VCB1O
 DrquIraxCwmWESkVicamJOsbzkemHvO4wslN7dAEaW+7BQWPL71ZSV3UkVsIUBeCD80atPNlYo
 hpF/Qi/5W+kL6A6qyNESoJHtW9Y7mi29e5C/RpROpSnm3To3TOLGKjc7LnDWcp2DtyratWNKcv
 lXI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2023 18:00:56 -0800
IronPort-SDR: LyAhL587kEd5mvoOmm30w330KTXV8mNMw880HxO4A6NL5WFwNQbjO1jB4TXSs17Xi6HHsF1KXW
 J8WQtqzPnyrkAbpS8Iw7El8wcTUpx4VMdyaa+nrWaO6tudSUenOSZwDuCAW5/ahWC7ysqhkAx0
 8hOwAJYonEtAFEwDStaQ8gKF+xh45QgLMoVFBGeyLYI3gnd226fmKt1dAGNtlc6ZyFhEd+yKBg
 C3V1qZel8zB79AqgKu+JYpuL/h37xn3ilcONbNxqi0gfzgK334c9sSYuDVuRqtrGvnz4cYOPoa
 qng=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2023 18:49:34 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/1] nvme/{041,042,043,044,045}: check dhchap_ctrl_secret support by nvme-fabrics
Date: Mon, 20 Nov 2023 11:49:31 +0900
Message-ID: <20231120024931.3076984-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
References: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231119_184936_712954_33387D27 
X-CRM114-Status: GOOD (  13.03  )
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

The kernel commit d68006348288 ("nvme: rework NVME_AUTH Kconfig
selection") in v6.7-rc1 introduced a new kernel config option
NVME_HOST_AUTH. When the option is disabled, nvme test cases from 041 to
045 fail because nvme-fabrics module does not support the feature
dhchap_ctrl_secret.

To check the requirement, add _require_kernel_nvme_fabrics_feature()
which refers /dev/nvme-fabrics and checks if the specified feature
string is found or not. Call it to check dhchap_ctrl_secret support in
require() of the test cases.

This change relies on the kernel commit 1697d7d4c5ef ("nvme: blank out
authentication fabrics options if not configured").

Suggested-by: Daniel Wagner <dwagner@suse.de>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 6 files changed, 21 insertions(+)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d23f10a..c4588d7 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9fda681..815d65e 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index c6a0aa0..e65abb0 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7bd43f3..9ee0747 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032..be408b6 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -15,6 +15,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_require_kernel_nvme_fabrics_feature dhchap_ctrl_secret
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522..3c4b2e1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,6 +155,22 @@ _require_nvme_cli_auth() {
 	return 0
 }
 
+_require_kernel_nvme_fabrics_feature() {
+	local feature="$1"
+
+	_have_driver nvme-fabrics || return 1
+
+	if ! [[ -r /dev/nvme-fabrics ]]; then
+		SKIP_REASONS+=("/dev/nvme-fabrics not available")
+		return 1;
+	fi
+	if ! grep -qe "${feature}" /dev/nvme-fabrics; then
+		SKIP_REASONS+=("nvme-fabrics does not support ${feature}")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.41.0


