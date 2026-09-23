Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBAEC98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hl7YnjaAsEmCFUnVGh3gw3Uebzmmjg5lfPeWcSdrH8g=; b=XO7mBtXy04MXAqWK09QQV+5vXg
	lOrOQaT7GyIfPjcwkwmvVLpJVoJHPT88qfUfs/0YyGb2XS/c6y1CFLAA5dgZO8nynXihc/KBTMGh/
	8c49r69rAS81DemHPRzZq0rsqIxIG71tJeiiwPStmueUL3PjZ2P9suoOlhur+LXRt6Vs5cjYOSR8x
	ghk1KwsAsVjFfH2dxiyHm8dg8k9HIIhnRS7LSAbEQV/9AjezQPQXYQrCiN0cpQCSugOoHbtGWnw4w
	mHe+1nxpSbl/MbF6GDeqCuwpBwoxAlp57V7LEsY4+5LmLuUE/rwfrZ3w9ImzK1i2MzH+M04Qgi/q9
	tOLlxUag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9NM6-00000008SHL-3Ee0;
	Wed, 23 Sep 2026 13:49:50 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9NM2-00000008SFl-16kE
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 13:49:48 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469a3490bso841824b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171385; x=1790776185; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hl7YnjaAsEmCFUnVGh3gw3Uebzmmjg5lfPeWcSdrH8g=;
        b=dxtURkvTsDzxCKf7juk+st3hQkFFXHZUxutXDR0uBuPfhAUAh2B8rbTrw/l2bXXHU5
         7kNjz/FKC9KjTHdTHXLsgP/7s36VOgnBnGVk3Ry2YNkZ8Ba3n8ZePEQ3TP1kSqHlGKom
         HskQlfIRKvNfo47EdSfnEIP0e1eU5lV3/wC5STlta01xCZdYfIS21SCYvt/E7DdMfgYm
         bBKOwxIGmByNnfpK/+VIuoGchMSw7cv8nf2TXQ1iq9SUiJciiLG4GeRyIF6S2AIPRz5c
         65LGJrYFgyR/cc5IJUXFAmCUzE799V9A/ZXURAOSXJu3NrweKX59Fdo9enzKJOJTEu2o
         y1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171385; x=1790776185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hl7YnjaAsEmCFUnVGh3gw3Uebzmmjg5lfPeWcSdrH8g=;
        b=klinOCxztTFoevnFK0wat2IkvHXOD56tj8//lC0IX9WJwxB88kHhEF7F1U/0vhSVOe
         gk2gxGaCZLioyyIYdlOIwDTvhaMYmDhgbHaxTOKK7cXkga2E2lfpNMPOT/ZTUqBBL90K
         TAfncylkhRnA+dA8IxDg5tfgWpHm9XT7RNwMDDr2DPH4seMCVYzlUilUX2+UKdFSpqpt
         8e/Qf6076KALcTKgC2x1NBBmKnADxVBe+RkF4/Ynyk/Fibdv9H5Md44tGjYnKei4OebX
         m61fFH4c8U49UvFnziK72reM0R4ssxiZAaVFK7GnZUyIWZxeu+eBKWpjIqG2IOfb/TF+
         l1yg==
X-Forwarded-Encrypted: i=1; AKwUvBzwlrgMqBPw5/JBQRyXE5yLW//pxBrgbSjAJLVvxlgqJoIuDCSC5Ym/MFxxNR8g5E8asdteZeeg9QQ6@lists.infradead.org
X-Gm-Message-State: AFuF++kJ7oPIgmwzno08AG/yx5+iQr4VROW5K2/bfBFQZUwcLzEW+3QY
	2+2Tis/hdydfj3zKu6hHuuTbkvXvp2TZOaEjDkv3YQqmQtMhh3FDuRN9
X-Gm-Gg: AYBFou1y6PgrSlPG7q39CnEpMm2AO22qQ41jx1PvYNLRSA/wo6664dFa3ELyK8G0SIm
	4VUYSTTAXeN0JaCfoBldmzVFNToWJr+QJZJcFXua4Jn8DD15U0AfO/6J2LGWKLu7jh5s4C+jXtQ
	9jiQUjlibH0JxxQyWUPJR4jv5MLFB3IZtnYI8hCB27mVvC7U4FshQXlT8jcDrxqxCUosL4MgD4P
	C8XAeTVMKknJXQ/wJNCb4PXCKIXmCZFUx70LRlKdsqCH6aCzjH+hZqvZ5ugq2bcwEqOu5lFxWO2
	PCT/7bX+EduTEOq+nXzroWQycyYIsrpb5U6XkXrwhPGqfBlKBKumwxQIbHeDB7yHq0PAALjMSXS
	3/SFG+nsm4kELRDw+wutIMuhrjBryD9sPpvm2UTkoqR0eNC4qaD81CvI1eNBJcqH9vDUSUyOEQs
	/BNdxm7QO8N/oBJ7Ru/iIX1FmQ65LlQxO5uxhTQ1h129FYpic37SvuNkI2GttxaIKiW73n1Gmwu
	hH2VvSVWybIQ9TMUYYHu4oRMKA2u+mukacsDg==
X-Received: by 2002:a05:6a00:178e:b0:87a:9335:c93f with SMTP id d2e1a72fcca58-87d1c0ab0aemr2062753b3a.43.1790171384406;
        Wed, 23 Sep 2026 06:49:44 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:f072:2258:ced5:5d8c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fbbsm1319790b3a.52.2026.09.23.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:49:43 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2] nvme/071: add a test for fcloop LS request use-after-free
Date: Wed, 23 Sep 2026 20:49:37 +0700
Message-ID: <20260923134938.12673-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
References: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_064946_306764_DA51697A 
X-CRM114-Status: GOOD (  18.97  )
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

Delete the fcloop remote port and then the target port while an
association is being deleted. The Disconnect Association LS is completed
from a work item that can run after nvmet_fc_unregister_targetport() freed
the pending request, which KASAN reports as a use-after-free in
fcloop_tport_lsrqst_work().

Kernel fix: "nvmet-fc: flush nvmet_wq twice on targetport unregister"

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v2 (thanks Shin'ichiro for the review):
- Note the kernel fix's commit title in the file header.
- local -a ports, and use _get_fc_host_port() instead of reading
  ports_to_hosts directly.
- Connect with --ctrl-loss-tmo 0. Without it, the host can spend up to
  NVMF_DEF_CTRL_LOSS_TMO (600s) retrying reconnect after we pull the
  remote port, which is likely the hang you saw; disconnecting it
  cleanly then has to wait on that reconnect state first.
- Drop the swept delay before pulling the ports. I could not tell it
  apart from a fixed "sleep 0" here either (KASAN UAF + list_debug BUG,
  both with and without it), so it wasn't earning its complexity.
- v1: https://lore.kernel.org/linux-block/20260921145659.17151-1-ngocthang2710.1999@gmail.com/

 tests/nvme/071     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..406a841
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Nguyen Ngoc Thang
+#
+# Regression test for a use-after-free in fcloop when the target port is
+# deleted right after the remote port. Deleting the association sends a
+# Disconnect Association LS whose completion is queued while
+# nvmet_fc_unregister_targetport() is flushing nvmet_wq. The pending LS request
+# was freed before that completion ran.
+#
+# Kernel fix: "nvmet-fc: flush nvmet_wq twice on targetport unregister"
+
+. tests/nvme/rc
+
+DESCRIPTION="delete fcloop target port right after remote port"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype fc
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local -a ports
+	local i port host_port
+
+	_nvmet_target_setup
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	port="${ports[0]}"
+	host_port="$(_get_fc_host_port "${port}")"
+
+	for ((i = 0; i < 20; i++)); do
+		# ctrl-loss-tmo=0 so the host drops the controller on the first
+		# failed reconnect instead of retrying for NVMF_DEF_CTRL_LOSS_TMO
+		# (600s), which would make each iteration look like it hangs.
+		_nvme_connect_subsys --ctrl-loss-tmo 0
+		sleep 0.05
+
+		# Deleting the association sends a Disconnect Association LS.
+		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+
+		# Remote port first, so the LS can't reach the host anymore.
+		_nvme_fcloop_del_rport "$(_host_wwnn "${host_port}")" \
+				       "$(_host_wwpn "${host_port}")" \
+				       "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_nvme_fcloop_del_tport "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+
+		# The host keeps trying to reconnect, drop the controller.
+		_nvme_disconnect_subsys >> "${FULL}" 2>&1
+
+		_nvme_fcloop_add_tport "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_nvme_fcloop_add_rport "$(_host_wwnn "${host_port}")" \
+				       "$(_host_wwpn "${host_port}")" \
+				       "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	done
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000..146809b
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete
-- 
2.43.0


