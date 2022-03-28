Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=; b=eAcVk9lpjbywz97zJGLTxwfTAJ
	5apjSiNztxA2CwnIrGL75BhrZHmDsMm1kr5pra+1addgYjS6Dxgclaq8Pte7HAvUE1cHgdQoyH+d4
	c6aisSLFAI9dgFUES5RzQ5dvccdnUGf9XHTji24dnzAJ6LJDCivDNaaa5+gNoJIHLZHQ/R32N0VR/
	387dmWylD9PYfFpvrFCrqS5LLMm6j09em2tVnTY5LQhIZgjCVOQ04ebwNwmG2xEwpyVDyKaxDanmt
	sRXe4vJAUTGwqi3Zeela1mrvtMAx3Rdv+E45a1nNV1hAbR/LPyTxO8PDevcQaVDhRiyD9DtHl9ReA
	aOV+hhCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTx-0089Hp-HK; Mon, 28 Mar 2022 10:20:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uc-SZ
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 57D291F385;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=;
 b=uL6Ys5h27NJSj+d8Y8VLGE340J9+WriH6ijINCmxxUfQPNuhYJW21///d7/uCZRfv4absX
 5Zda+iWbhJZ/PTIg2P9Ve74bMa/E9epx0fZqtKY53H9ekQ9rqfKPI6scjcYuxuFJ0K1TCs
 Yp/Fe5F+VYCd82fQG8WP8aJlqhcYxCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=;
 b=7mtfNEvcvBWD1l6VVveLPQqwRCbQL91tQ1fnb7aISTW4JSsU4IlJ/TaEZp7W6thQrYz/m1
 4PGqT2/IZgNnHsDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4D650A3B96;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4811051939C7; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/10] nvme/040: test dhchap key types for authenticated
 connections
Date: Mon, 28 Mar 2022 12:18:52 +0200
Message-Id: <20220328101855.73975-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_184631_4983CD1A 
X-CRM114-Status: GOOD (  13.09  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/040     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/040.out | 16 ++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tests/nvme/040
 create mode 100644 tests/nvme/040.out

diff --git a/tests/nvme/040 b/tests/nvme/040
new file mode 100644
index 0000000..cebc58b
--- /dev/null
+++ b/tests/nvme/040
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test dhchap key types for authenticated connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Test dhchap key types for authenticated connections"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_modules loop
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+}
+
+
+test() {
+	local port
+	local subsys="blktests-subsystem-1"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+	local hostkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 512M "${scratch}"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "${subsys}" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}"
+	_create_nvmet_host "${subsys}" "${hostnqn}"
+
+	for hmac in 0 1 2 3; do
+		echo "Testing hmac ${hmac}"
+		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${subsys} 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for hmac ${hmac}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		ctrldev=$(_find_nvme_dev "${subsys}")
+		if [ -z "$ctrldev" ] ; then
+			echo "nvme controller not found"
+		fi
+
+		_nvme_disconnect_subsys "${subsys}"
+	done
+
+	for key_len in 32 48 64; do
+		echo "Testing key length ${key_len}"
+		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${subsys} 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for length ${key_len}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		ctrldev=$(_find_nvme_dev "${subsys}")
+		if [ -z "$ctrldev" ] ; then
+			echo "nvme controller not found"
+		fi
+
+		_nvme_disconnect_subsys "${subsys}"
+	done
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
+	_remove_nvmet_subsystem "${subsys}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/040.out b/tests/nvme/040.out
new file mode 100644
index 0000000..3643da4
--- /dev/null
+++ b/tests/nvme/040.out
@@ -0,0 +1,16 @@
+Running nvme/040
+Testing hmac 0
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 1
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 2
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 3
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 32
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 48
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 64
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


