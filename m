Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77976C982E6
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vFAWgbQv1qSO+/rKdk0siS4WLAN6WSkmRl7OdK/9TVE=; b=toL8OvS8K3KddLP9MYy9Qmzs/m
	BQCcxuQREVwhjV+t9eUuE/uyhDBg+SnfJL1V5Xk76huAPSxH1SgfozQwJK0bavLPO4gfkU8dClj1Q
	zF7hD+JiWPelfD5HtsnlxGiwJhLfPLoPuEZcwI3tBrH7hiJZtVfUKaBoo+0ClXzK7DP5mFdVFdhu8
	x3QSfCoSSsR7B0KEiWPxrcWy6Ic3mtHmy8dcd0xOa8M2jwlsigMLG2VTU3uWiIE1R33NRaM7svATW
	s/caIBGBCvpq4+WVnDA1y37AweqjHkeVXuYZzYFqv4y5wilZOmPuusri0L/IyMIGS3nSmly7OSann
	QhwpK1uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fS7-00000002Uyy-4BRH;
	Mon, 21 Sep 2026 14:57:08 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fS5-00000002Uxo-2TP0
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:57:07 +0000
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso3004807a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002625; x=1790607425; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFAWgbQv1qSO+/rKdk0siS4WLAN6WSkmRl7OdK/9TVE=;
        b=kIIgSuADvNjCAEdqv1Uptoa01X+Xl28kNtBbEiVzK3xHw6rcvIf8rhiICFbrGsVvQc
         RLFUJzGDO3nMRSZp+JT9BlkR5IsaF4ArX0urgD0hnNaqoJVo81gkIqDxmJywUW098+Jh
         N2mzE26CnmHN5vwf5BBtrL2XjiajFPut5oDy70dl5VXiq2+QltKveJ/Y7R1qlFWSgeXV
         7ELHimMmo0az+t5orRf8BvVq5nVB0CsnfX4Dp2zLsMylQak189qPp1xlXwMK9Ef3TTJk
         4fZkCMRcBvozov4+uCLa1e3KcnenScZlczriDpESzadVLoCBCHF+QGB/irFx8I6UuBHY
         jAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002625; x=1790607425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFAWgbQv1qSO+/rKdk0siS4WLAN6WSkmRl7OdK/9TVE=;
        b=bfNjVp9EMq2bGL7rJ5BuoNrEh7HHk8FZiklEhA256qeIArWGaJZ6P1yEQvpf5qxqA2
         YaeDCtHlE3nyiGRZEsccVNIFDxS5s+/ORDOzmQtOWUxT3aLWVw/xQ1RPzkq4wwXQntHj
         nFJbUFH3W6/KYuWGlS/ZGIfh89XCXcQh2k8hO/KKUGCGjwPkOsxPpn7jA761BeCYAq0I
         oeUHYKrTAwNOEuvyKovq5B1QHC0igDinsxkhGoMoq60X24Gr94xl9xe8b14x5Rp6pVg+
         QDy9w4ZVwVHoAvnxU/UkiXsfQYs6naQVMZCkamy8gFkegmMOzS5XGj7lzbeYo3M9HPZu
         s/Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwEJpfTbp8at/8W0v1CLLvFSh6Ca29oqV1GAbbjqaK+Os/64WyzVaupaSTmmSCLqpgg1mTx8su5n4B1@lists.infradead.org
X-Gm-Message-State: AFuF++k3SkTvnF6eR++MBedN5RyMiSyb1Uwgd7s+pRInSeFm506M9rwN
	OqNUJd1+PkibJBdps8GNh+xOvcfFHcO22Y7DvtKCbyehyoMxg6TDFmqKOeTeqQ==
X-Gm-Gg: AYBFou2G7giZ8M9ir2RFGx1set28aOX36vaqiU3dc6QONftUKNsi0W1lmKFnwhNxpuW
	rAjz+UQ1n22/8fMG9JV59HlDVJwgmxEigYUGDKymhtc+ryR9bSWq6ZFO8X1Rg0/sJPXIfBuWBg7
	Kb/W5ZzSpABYIaRqmsJyVBVSvvS8AmXwZ8zdmrX17zBHxmfuIbNTLkEvtt0WP6htUM1J1Nx1xTT
	QLE0QLLoI17XGYYphISzIC6AjrAcGqhjZVly0mc6b1O/CVKkqMgiJIkJY6bwci7N1oCN3VEA0U/
	rIWQ6A5gVsxUJeY1r0BH+saGswAautohglD1bdqROCiCiCbyKiDU2ksdeokSMsxy5o65OsGVtg+
	cRtwL7GGHJOmSdqGjxqJuTHsPkbKfY3WeBRiL32P6dR7HSG8Vv02Hgpzib9lOB0SarwP7YAGmdy
	p2N/OMTrYFpaZSCfxTNBjoHfsCZfEGnenp+U6gsa35t6+eeHWVvU22K4hGbhMx4ApYAjZ4iEOMy
	pI1spdXnvhw1EU=
X-Received: by 2002:a17:90b:53d0:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39e54d8ece9mr21218146a91.4.1790002624613;
        Mon, 21 Sep 2026 07:57:04 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:70bd:a3d:dfa4:3859])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063a41b25sm505372a91.5.2026.09.21.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:03 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvme/071: add a test for fcloop LS request use-after-free
Date: Mon, 21 Sep 2026 21:56:59 +0700
Message-ID: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_075706_013627_680724E4 
X-CRM114-Status: GOOD (  14.10  )
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

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 tests/nvme/071     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  2 ++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..d17ef18
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Nguyen Ngoc Thang
+#
+# Regression test for a use-after-free in fcloop when the target port is
+# deleted right after the remote port. Deleting the association sends a
+# Disconnect Association LS whose completion is queued while
+# nvmet_fc_unregister_targetport() is flushing nvmet_wq. The pending LS request
+# was freed before that completion ran.
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
+	local i ports port host_port
+
+	_nvmet_target_setup
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	port="${ports[0]}"
+	host_port="${ports_to_hosts[${port}]}"
+
+	for ((i = 0; i < 20; i++)); do
+		_nvme_connect_subsys
+		sleep 0.05
+
+		# Deleting the association sends a Disconnect Association LS.
+		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+		sleep "0.00$(printf "%02d" "${i}")"
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


