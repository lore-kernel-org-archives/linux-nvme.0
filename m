Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTpzPp/HdUEGs77huRWaJROdnbeYjpZ7oLTchejrPLc=; b=PsNcGrbt3A9OqFdUteB3V4Y82+
	C4NqQnjYY4lfWoUPqrvDNAD9wc/jjLSsq+UPCPwEW+UL61AKXg/70Pa87I6rJXHZz3xgH99UM/sU+
	qId+T5zMrrukuaeqEbPK4hyFwkqmbFQ/97XFApRzEvodlROeuL7ou8Oy3T4P5hatdf362emH5iMpw
	Dh1946c2DEbLurW6rIdTZACBNR597lNsfVlC4ME4zRHn8KPCUQBTG4aTN1OO8QwXwIJpRQedC7LcV
	nUqnCAGhGl8al77XQt4F45CSePlgoICP+D9zQ0h3yzdRKZ5R0UqXBXl925M2P5UPKuWX0p9Xc4k/L
	tkwbSAdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Ql-00FELt-2e; Mon, 22 Nov 2021 08:12:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4As-00FAuP-BM
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7EE571FD5B;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTpzPp/HdUEGs77huRWaJROdnbeYjpZ7oLTchejrPLc=;
 b=MQaIuoUsh6rbshaIU/wigTCeaeMSa9xXnpeeDSt4OivtnxNs/gFFm6XWJKerBhPKph0gHT
 RKYllWljRL/++CSGGxuQFAGSb7E2kxamIKuVYcGg5Z1ffGgzKELSTmPpPNSVIKiEs2/W4x
 n/XJAYvKi/jco1RFvmawnzrFMiJ3ngs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTpzPp/HdUEGs77huRWaJROdnbeYjpZ7oLTchejrPLc=;
 b=Wd2B0k89whm191YQHxCvVkIOaJs2xCR6xEG6B9LPWRFqHpRV7LftUMgbYvjm5oGIeTq2L2
 Ezh4+H1auEwWyyCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 78BB0A3B90;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5C83D51917FD; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 8/9] nvme/043: test bi-directional authentication
Date: Mon, 22 Nov 2021 08:55:23 +0100
Message-Id: <20211122075524.26207-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_638793_29C6E11D 
X-CRM114-Status: GOOD (  14.80  )
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
 tests/nvme/043     | 104 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |  14 ++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out

diff --git a/tests/nvme/043 b/tests/nvme/043
new file mode 100644
index 0000000..0c00f95
--- /dev/null
+++ b/tests/nvme/043
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp bi-directional authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test bi-directional authentication for TCP connection via localhost"
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
+	# Step 1: Connect with just host authentication
+	echo "Test host authentication"
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     -S "${hostkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvme list-subsys
+
+	nvme disconnect -n "${subsys}1"
+
+	# Step 2: Connect with host authentication
+	# and invalid ctrl authentication
+	echo "Test host authentication and invalid ctrl authentication"
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     -S "${hostkey}" -C "${hostkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvmedev=$(_find_nvme_dev "${subsys}1")
+	if [ -n "${nvmedev}" ] ; then
+		nvme disconnect -d "${nvmedev}"
+	fi
+
+	# Step 3: Connect with host authentication
+	# and valid ctrl authentication
+	echo "Test host authentication and valid ctrl authentication"
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     -S "${hostkey}" -C "${ctrlkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
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
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
new file mode 100644
index 0000000..9ad2d72
--- /dev/null
+++ b/tests/nvme/043.out
@@ -0,0 +1,14 @@
+Running nvme/043
+Test host authentication
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test host authentication and invalid ctrl authentication
+no controller found
+Test host authentication and valid ctrl authentication
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


