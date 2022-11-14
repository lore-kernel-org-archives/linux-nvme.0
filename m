Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64656C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pKtXYFtuJb8u8x/sGWfxElnzDTYxHJgQjYo51N9SsJo=; b=C4wLQrEFlliDqKq8QzL5ab96YY
	7lWXZ1Hxz59jK1e8G1czXTQOJTAkWzPS+sSSgA4lhG541vvruob8MAclNssNvEjKmxZDh5lFNplyL
	8MwEhP4py7BCIeNuD8wsxaC+fHaKGBgezotJxXLVVxcdu0U/jh/cyjfjX275mVqHkNPnBrhTMn0BF
	c9wqaP3KuhEbGgcBRAYDdNJcqDJGaGkQR0WSTPRVz2XFBj/mvepNqw3pyGRo3OPiao2CjoYNWgfPp
	nwNi4iRbqkq11gJD2kE5RFyYy8Hx89SdIVermjOJENchSsHOmwyyFQaQuJiXTGlPo/hiflBmGkw7n
	oF6AfmUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouYyJ-000xSH-6N; Mon, 14 Nov 2022 12:53:55 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouYxO-000xQ0-M9
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 12:53:00 +0000
Received: by mail-wr1-f54.google.com with SMTP id a14so18072920wru.5
        for <linux-nvme@lists.infradead.org>; Mon, 14 Nov 2022 04:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKtXYFtuJb8u8x/sGWfxElnzDTYxHJgQjYo51N9SsJo=;
        b=EoG7armsnlQm/XCmzUBaO1Yj9SQafp4osUwNr6Yvrg+xYXK/wzdrRmQnKU5lUwJPwk
         RRSGXqfF3vREn63r0Luax5ljmfIN79DuTQZ5ayzlXiXhNu34VPmuuvvlgIQqMj9uGEqC
         YNctZGPfGcjG0MBWxchI/uHVSfb+QV6MRcCjlwT0Z0WKjp8B0vthUAtHQiLlbQj3P/lp
         SMRAlxBMYMAvGeyMW9gEPs/K1EOYxeJCgYIl59i1Q8J7EdgMoUmhQYsCi7x9MyeU8loU
         cHW1xHnzgFFs/ovL6bRrF2eie/7bVhyciVPkhwXJ8VcaMg7moBLJmHff/uH2BQCX2O9U
         AjKQ==
X-Gm-Message-State: ANoB5plUJydgMNqsJb1fAcdUo9I/5QNypiuvThD2SuM0UmGeSZSwQCze
	DGx39gaGkFKj3mbyT6l/+d0=
X-Google-Smtp-Source: AA0mqf6rMnzDdt1NuNuya8IudrPm05NOMrJAT1MmbpL9YkQuLmieYMaHTJHUDawxpinmckVe+ecedQ==
X-Received: by 2002:adf:f3d0:0:b0:22e:37c1:b225 with SMTP id g16-20020adff3d0000000b0022e37c1b225mr7014394wrp.428.1668430374166;
        Mon, 14 Nov 2022 04:52:54 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f4-20020adff984000000b0024194bba380sm1324893wrr.22.2022.11.14.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 04:52:53 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add re-authentication running concurrently with reset
Date: Mon, 14 Nov 2022 14:52:52 +0200
Message-Id: <20221114125252.1086763-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_045258_758036_EE5DD232 
X-CRM114-Status: GOOD (  14.62  )
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

when re-authentication with new host-key and/or ctrl-key there is an
async work that is scheduled async. A controller reset should be mutual
exclusive with the re-authentication work. Add a test that triggers
re-authentication and immediately resets the controller.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/046     | 112 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  23 ++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..d5c8d53ada7e
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Sagi Grimberg <sagi@grimberg.me>
+#
+# Test re-authentication and reset running in parallel
+
+. tests/nvme/rc
+
+DESCRIPTION="Test re-authentication concurrently with reset"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_option NVME_AUTH
+	_have_kernel_option NVME_TARGET_AUTH
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+	_have_driver dh_generic
+}
+
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid
+	local hostnqn
+	local file_path="${TMPDIR}/img"
+	local hostkey
+	local new_hostkey
+	local ctrlkey
+	local new_ctrlkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	hostid="$(uuidgen)"
+	if [ -z "$hostid" ] ; then
+		echo "uuidgen failed"
+		return 1
+	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$hostkey" ] ; then
+		echo "failed to generate host key"
+		return 1
+	fi
+
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$ctrlkey" ] ; then
+		echo "failed to generate ctrl key"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${ctrlkey}"
+
+	udevadm settle
+
+	ctrldev=$(_find_nvme_dev "${subsys_name}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	hostkey_file="/sys/class/nvme/${ctrldev}/dhchap_secret"
+	ctrlkey_file="/sys/class/nvme/${ctrldev}/dhchap_ctrl_secret"
+
+	for ((i = 0; i < 10; i++)); do
+		echo "Re-authenticate with new host key (iteration $i)"
+		new_hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+		_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+		echo "${new_hostkey}" > "${hostkey_file}"
+		_nvme_reset_ctrl $ctrldev
+
+		echo "Re-authenticate with new ctrl key (iteration $i)"
+		new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+		_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+		echo "${new_ctrlkey}" > "${ctrlkey_file}"
+		_nvme_reset_ctrl $ctrldev
+	done
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	_run_fio_rand_io --size=8m --filename="/dev/${nvmedev}n1"
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 000000000000..2d63f4e3112b
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,23 @@
+Running nvme/046
+Re-authenticate with new host key (iteration 0)
+Re-authenticate with new ctrl key (iteration 0)
+Re-authenticate with new host key (iteration 1)
+Re-authenticate with new ctrl key (iteration 1)
+Re-authenticate with new host key (iteration 2)
+Re-authenticate with new ctrl key (iteration 2)
+Re-authenticate with new host key (iteration 3)
+Re-authenticate with new ctrl key (iteration 3)
+Re-authenticate with new host key (iteration 4)
+Re-authenticate with new ctrl key (iteration 4)
+Re-authenticate with new host key (iteration 5)
+Re-authenticate with new ctrl key (iteration 5)
+Re-authenticate with new host key (iteration 6)
+Re-authenticate with new ctrl key (iteration 6)
+Re-authenticate with new host key (iteration 7)
+Re-authenticate with new ctrl key (iteration 7)
+Re-authenticate with new host key (iteration 8)
+Re-authenticate with new ctrl key (iteration 8)
+Re-authenticate with new host key (iteration 9)
+Re-authenticate with new ctrl key (iteration 9)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.34.1


