Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE515C3601B
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C85oMopt0fnFmlDQdQpoKBs0OSW1FN0tKFUOs6wyP4M=; b=rQPy8FTC5HTxYcIUrcRP8BWjQA
	2Vszx3dvmCpLZC4lmUFI/pjBU/66iBjBE2YqVLfSjbPSkwr8hvPTsn2V+OmZHQ9+MCxLAqsmq8uBb
	TIn4y+bXHaXNu5h9l4obaYR3hfuCrB9s7eHOJvgH2AC+dSce27dC16U0jJy9wThSpwRqncGlRiXHZ
	FYWjaw/+OW/i67c3IaTbBS72f3/Sm6nUP1p9OhSFIOmHNl37Udy6tTeABKeNRVx9WQyg/8/yOOH/A
	TJGDJToG/Ki2z1cvMOCYibIB6O0BbnyvVmA9StF0AnEcd4kpE8yCXgVXSy1397NsX4yOlhIzM9KW0
	ptrdVU1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ0-00000005NDs-0krG;
	Wed, 02 Apr 2025 07:31:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDp-00000005Ju1-0uYB
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577753; x=1775113753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYoXh2T33Um9vyJzMNSajt2mhPw/PFqAatUozcTWlZA=;
  b=Y8hwgvMByk6oX5721fVApPO7dSdBueRFbY/XJz+YjtszWNBgtWeZ8xIH
   9u91FmeVu0us1OV8dXGEjHkmr9GmNGSYvUeTr1f3OprHvkmXLzCzONhBb
   Rs7YDi2Ckpx8sct0TsseDGGcQTrpqVEsx5Go2beuWFnpuvVtVQH+SogYl
   RfPuVwp3HpUI4bbm+EKlSn5gDcnuDVOpzyNA8BtX90c/GW0g1UXmRoDRd
   VOTWgc15mNEG80+usa9yQ9xLEMeNUnFvKR1ZaUbt/ISHbMapy3LQfYY9W
   APHddrE+VHAzo6J3id1gWI+jM6P3jHKuvCyn4hF2OnYkvqH7CVJzp8wjH
   A==;
X-CSE-ConnectionGUID: rrUZ/jvVTiCA+WANaYFn/A==
X-CSE-MsgGUID: IoKhA4NESFWjo6qWXXz7hQ==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793492"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:13 +0800
IronPort-SDR: 67ecd4a1_SYyQyNkwFd21A2PuhOO85helOhL/qJb2I/S9Fmm0fmuGWdr
 YJnNZkseu+4MgW8eVrMkNLm3DpQWpVqoK309voA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:38 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 04/10] nvme/rc: introduce _have_tlshd_ver() and _have_systemd_tlshd_service()
Date: Wed,  2 Apr 2025 16:09:00 +0900
Message-ID: <20250402070906.393160-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000913_261169_22F78A8C 
X-CRM114-Status: GOOD (  12.31  )
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

To run the newly introduced test cases for nvme-tcp TLS support, the
userland daemon tlshd and its systemctl service unit are required.
Confirm availability of tlshd and the systemctl service. Also check that
the tlshd version is larger than or equal to 1.0.0, which allows to
authenticate TLS sessions for nvme subsystem with the default
configurations.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index de68b31..9584610 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -597,3 +597,23 @@ _nvme_reset_ctrl() {
 _nvme_delete_ctrl() {
 	echo 1 > /sys/class/nvme/"$1"/delete_controller
 }
+
+# Check whether the version of the fio is greater than or equal to $1.$2.$3
+_have_tlshd_ver() {
+	_have_program tlshd || return $?
+
+	if _compare_three_version_numbers \
+		   "$(tlshd --version |& sed 's/.*utils \([0-9^.]*\).*/\1/')" \
+		   "$1" "$2" "$3"; then
+		SKIP_REASONS+=("tlshd version is older than ${1}.${2}.${3}")
+		return 1
+	fi
+	return 0
+}
+
+_have_systemd_tlshd_service() {
+	_have_tlshd_ver 1 0 0
+	if ! _have_systemctl_unit tlshd; then
+		SKIP_REASONS+=("Install ktls-utils for tlshd")
+	fi
+}
-- 
2.49.0


