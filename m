Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1EFC636B9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 03:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEJsfKercZGBzvP3UcFmBeEfofQlsTyo6SsYtcgQZLE=; b=c5jq3tEOY7O6eeU7qG1Z8fk999
	IHCziNQ6X7tN1P8rgu7XoTHrZfrMKlkWkhxUH/4YrtjhOo66YPWmRa3VJZZJuHUR9+MNADEghfW6A
	uD91CR6Iyj9+lA4rqZhLn/7ALyG3vd6d0CcuzUX9JxoxCmP/jPM6GaegezOfLYESE904pA+a0RRT1
	S6TSclYxtm8S3IRNbW7g2B31hP/7BrM6uY0Tuw2QKgrBtJoESRJkc7yyKe3myjwgVe2kD1USrOYnZ
	3Hax3XPUydtl3TMcKVcPnrFF2v1NysK3/b5+Vcf1tbVaBoc41IiTL6gFV4jKoYvm2oPyqCqvbT+XF
	YntVwfkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxu-0000000HBeN-2SLk;
	Mon, 23 Feb 2026 03:50:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxq-0000000HBcM-0dwD
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 03:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818630; x=1803354630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7t+J+tUUXEHJkiZGqw5eTJMqhkB8UMVepv2+gKUVDwQ=;
  b=IUre+HJkSIE5ugamz8q1IYXd1leQNYbqBkT+nlkpn3ZnfXbdkiHFYUWB
   aWtLQyKERdZhYfFPnMVIGIGLe6xEi1JSTBF/2FNXKX9wZykONzgzRtKOv
   U/VWcieEk3uikdMBq8ZSrKfdxo5/CQzjWTVX2DdWO/ExHQPzXj2/a8TYR
   OtSh2iHOuHc050QLkASVHMFZk00234LengR4XcGwRFdsfq6c3E60+ED5V
   7GRQeFYpaPeIUzFI5+AnoNYEBAx1i6aHXVuqeZT6zV6/mqYmzLBHQ32MN
   4CQ/hevXLWOGf4FT0Ug+PMw1wVYywVPJmswUsX2az4UMLO9DLYBEZfyrL
   g==;
X-CSE-ConnectionGUID: SAy7QyvwRpiUcOuEt6x8jA==
X-CSE-MsgGUID: Xuea1+fMSIGAwoRPoZWKKQ==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="140288652"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:29 +0800
IronPort-SDR: 699bce85_mOyBVbjBmKqWO2a95dkdpGFxfoFXAA6ZHUzAyZqX0uArPUh
 9bJwcKTvX17/BYBqbuFyzyRy2NKAPh7AU5UzGLw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:29 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:29 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] common/nvme: unload nvme modules only when loaded
Date: Mon, 23 Feb 2026 12:50:23 +0900
Message-ID: <20260223035023.21902-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_195030_258377_64F17D3C 
X-CRM114-Status: GOOD (  17.54  )
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

To test nvme target driver with various transports, _setup_nvmet() loads
the nvmet module along with other required modules based on the test
conditions. The loaded modules are unloaded by _cleanup_nvmet()
following the same logic as _setup_nvmet(). However, this module load by
_cleanup_nvmet() does not work as expected because it unloads the
modules regardless of module load status at test case start.

For example, when the nvmet and nvme-loop modules are already loaded at
the beginning of nvme/060 test case run for rdma transport. In this
case, _nvmet_setup() loads the nvmet-rdma module, which has a dependency
on the nvmet module. At the end of nvme/060, _cleanup_nvmet() attempts
to unload both the nvmet-rdma and nvmet modules. While the nvmet-rdma
module is successfully unloaded, the nvmet module fails to unload
because it is still used by the nvme-loop module. This results in the
following error message:

  modprobe with --wait option succeeded but still nvmet has references

To prevent the module unload failures, unload modules only when the
modules were loaded during the test. For that purpose, replace
"modprobe" commands in _nvmet_setup() with calls to _load_module(). This
ensures that only modules not already loaded are recorded in the global
MODULES_TO_UNLOAD array. Afterward, the recorded modules will be
automatically unloaded after the test case completes. Also drop calls to
_patient_rmmod() in _nvmet_cleanup(), which are no longer necessary.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index a419cd3..64f1828 100644
--- a/common/nvme
+++ b/common/nvme
@@ -213,13 +213,7 @@ _cleanup_nvmet() {
 
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_nvme_fcloop_del_lport "${def_local_wwnn}" "${def_local_wwpn}"
-		_patient_rmmod nvme-fcloop
 	fi
-	_patient_rmmod nvme-"${nvme_trtype}"
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		_patient_rmmod nvmet-"${nvme_trtype}"
-	fi
-	_patient_rmmod nvmet
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
@@ -240,11 +234,11 @@ _setup_nvmet() {
 		return
 	fi
 
-	modprobe -q nvmet
+	_load_module nvmet
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -q nvmet-"${nvme_trtype}"
+		_load_module nvmet-"${nvme_trtype}"
 	fi
-	modprobe -q nvme-"${nvme_trtype}"
+	_load_module nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
@@ -263,7 +257,7 @@ _setup_nvmet() {
 		done
 	fi
 	if [[ "${nvme_trtype}" = "fc" ]]; then
-		modprobe -q nvme-fcloop
+		_load_module nvme-fcloop
 		_nvme_fcloop_add_lport "${def_local_wwnn}" "${def_local_wwpn}"
 	fi
 }
-- 
2.53.0


