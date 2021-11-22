Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1777C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmxg8m7jNrj76emvgg1cdN8GLOEzM/5t1KIdb5hj4hM=; b=sj192jZIgjSdU3U+5gviCYCWrm
	jvHxq/vwqZP11wVXpcvzQ3OaawIOYRMzX/TnNPcXTKE7U7kNEJ2NGCw7MBwciHJ/o96Uv9J1UPSUy
	xA9Wz4nEtMULdslQ/kS2E7An58CLNmbiUGi6xyy1df0gaTYupCJ/sBAa9IiVzK6Pj/IrVqkfL8SMK
	0fmSXQQVvH/ISX0ru6iBB13YYym9d6WnBFA18bRZPyiqN2GFNJ33a74YRBHsrTrp35iEU7nHSV8gl
	rxX3HNEc0eIVEZcyT36tLW7kzMnZDAM6GEr9jKMp4zEENxa86bzo92xLrXoLRYR0EioeaMnU4/6yD
	YDR07rCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4OU-00FDsN-Sl; Mon, 22 Nov 2021 08:09:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4As-00FAuR-Ap
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7F330218CE;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmxg8m7jNrj76emvgg1cdN8GLOEzM/5t1KIdb5hj4hM=;
 b=wWoVKBOGztmQQ6FE6FXB2kPG9PHiGZs5cIjegLQOZaKZbARm+EysgosS4Poab6mu9IPCIY
 0kV1p4617FNqkfnhiTJiQlgq7Jmmt7Qg70epPOtdQHJLr47UXPy0nJRom9V8kBly/g4s1a
 9K+6Bx+2SxOxgzmNs7l1c4+QxaJmXSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmxg8m7jNrj76emvgg1cdN8GLOEzM/5t1KIdb5hj4hM=;
 b=itDX2+0yhMJnkVPZFJ1hJ2F+wSjcA1y12QA9ZaeaT3KK/3CC9fBzcslg1BIlETABIyYMpQ
 UNb3hoeQEUyOWPBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 76A58A3B8C;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 609C451917FF; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 9/9] nvme/044: test re-authentication
Date: Mon, 22 Nov 2021 08:55:24 +0100
Message-Id: <20211122075524.26207-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_622567_ABFD47F1 
X-CRM114-Status: GOOD (  15.04  )
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
 tests/nvme/044     | 116 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/044.out |  22 +++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/nvme/044
 create mode 100644 tests/nvme/044.out

diff --git a/tests/nvme/044 b/tests/nvme/044
new file mode 100644
index 0000000..e3a1e94
--- /dev/null
+++ b/tests/nvme/044
@@ -0,0 +1,116 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp re-authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test re-authentication for TCP connection via localhost"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_modules loop
+	_require_nvme_trtype_is_fabrics
+}
+
+
+test() {
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+	local nvme_trtype="tcp"
+	local hostkey
+	local ctrlkey
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	truncate -s 512M "${scratch}"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "${subsys}1" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+	_create_nvmet_host "${subsys}1" "${hostnqn}"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+	_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+	_set_nvmet_ctrlkey "${hostnqn}" "${ctrlkey}"
+
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     -S "${hostkey}" -C "${ctrlkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvme list-subsys
+
+	ctrl=$(_find_nvme_dev "${subsys}1")
+
+	echo "Re-authenticate with original host key"
+
+	echo "${hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
+
+	echo "Renew host key on the controller"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+
+	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+
+	echo "Re-authenticate with new host key"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
+
+	nvme list-subsys
+
+	echo "Renew ctrl key on the controller"
+
+	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+
+	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+
+	echo "Re-authenticate with new ctrl key"
+
+	echo "${new_ctrlkey}" > /sys/class/nvme/${ctrl}/dhchap_ctrl_secret
+
+	nvme list-subsys
+
+	echo "Change DH group to ffdhe8192"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
+
+	echo "Re-authenticate with changed DH group"
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
+
+	nvme list-subsys
+
+	nvme disconnect -n "${subsys}1"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
+	_remove_nvmet_subsystem "${subsys}1"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/044.out b/tests/nvme/044.out
new file mode 100644
index 0000000..e1803f4
--- /dev/null
+++ b/tests/nvme/044.out
@@ -0,0 +1,22 @@
+Running nvme/044
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Re-authenticate with original host key
+Renew host key on the controller
+Re-authenticate with new host key
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Renew ctrl key on the controller
+Re-authenticate with new ctrl key
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Change DH group to ffdhe8192
+Re-authenticate with changed DH group
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


