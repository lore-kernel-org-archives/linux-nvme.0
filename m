Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01098C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCh43rBY2tzJxLnoVAnLykkZC68yhKG1IMdVxeQvXoc=; b=lr6opmHf43XwgKN5cDUEu5NQkz
	MEn7a/Cf5CfUzUvq24KyOk/Ht/bYQoZKa9sn2oLM7uZ6cN0LiV+p7258lEPInSdhl1DIIzbuHv5eD
	fGpQ4QtyLwJ2hOe+H1QvOTvLJkVb0D9kTt1yMjDkobVoKeME3tJ9S6m2KH79cosjOS47bKZzp55uK
	pQbbHdyxrzC13hnw3CCtuzki35jmDJ4Cf9yGGXo08vKQ95GZasJwVYTRBIpMoeL7J/btaeFCIBDqQ
	OeAednVE0IIoU0ruUem6XaS8HVKuVznn6PyhE0sxwGRbVKfGgfPp5cab6Gf3oOgi2WhuAvHDG2FnZ
	Que5rfyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5fo-00FbKm-N4; Mon, 22 Nov 2021 09:31:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Ax-00FAxy-3a
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 84F6B218D6;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCh43rBY2tzJxLnoVAnLykkZC68yhKG1IMdVxeQvXoc=;
 b=rDmGi+gwSst3+hM7hyuCpDn0IE5suea+Ef1uNzR64jowgr8SLkY0KS7HwqJAcdf6rHP0Bu
 iFMlI9oUlPSse3QL4wAOlH4Y1rOKWsjXlOqTwwiq1u4zq7AzEzTU4eIQOCgpFo9Tbeg5bs
 zb+5G2ejsjTx5nFrLNPd0bCKhYknkvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCh43rBY2tzJxLnoVAnLykkZC68yhKG1IMdVxeQvXoc=;
 b=zc0tDRNGX1utIARwFcQwbQUM9xsis5Qly3gFbGweT6xpgNhblNd7O7VC+36QUi4diYjujm
 nIK3ZzAEa1VG30Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 77B4CA3B8E;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5777551917FB; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/9] nvme/042: test hash and dhgroup variations
Date: Mon, 22 Nov 2021 08:55:22 +0100
Message-Id: <20211122075524.26207-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235543_340605_3AD2E2D7 
X-CRM114-Status: GOOD (  14.33  )
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
 tests/nvme/042     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/042.out | 37 +++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out

diff --git a/tests/nvme/042 b/tests/nvme/042
new file mode 100644
index 0000000..722f6cc
--- /dev/null
+++ b/tests/nvme/042
@@ -0,0 +1,88 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp hash and dh group selection
+
+. tests/nvme/rc
+
+DESCRIPTION="Test hash and DH group for authenticated TCP connection via localhost"
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
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
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
+	_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+
+	for hash in "hmac(sha384)" "hmac(sha512)" ; do
+
+		echo "Testing hash ${hash}"
+
+		_set_nvmet_hash "${hostnqn}" "${hash}"
+
+		nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+		     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
+		     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+		nvme list-subsys
+
+		nvme disconnect -n "${subsys}1"
+	done
+
+	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
+
+		echo "Testing DH group ${dhgroup}"
+
+		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
+
+		nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+		     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
+		     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+		nvme list-subsys
+
+		nvme disconnect -n "${subsys}1"
+	done
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
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
new file mode 100644
index 0000000..7ac606c
--- /dev/null
+++ b/tests/nvme/042.out
@@ -0,0 +1,37 @@
+Running nvme/042
+Testing hash hmac(sha384)
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hash hmac(sha512)
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe2048
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe3072
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe4096
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe6144
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe8192
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


