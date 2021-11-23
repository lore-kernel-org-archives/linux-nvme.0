Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30BDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=; b=tYmB4kIm4LJ32ymLY4UmZtE8dP
	Pj75ePPOVoLfAWHR1E074awEHzqR98VeKlKSVwSIkDQ/Bl2/bzfN/r+olsMrvCz7vu3tSp2Li+68s
	85xJndx5soYVdbNBQF3FzCOVhMxi7Y73Imttm+ATtgMJbFEGgG3Getj6ADkljSVjexOT8D7szSijy
	+3yyVF5MxwEYeFnph/JK/wGiM+FPZ0tsUAmLWi0Tp8w4GaFID6F7FpKv3RdVhCtRdLVB7rSsbcP5X
	tTQ4/32pK/8tPHOYMIkaabF29ikCuUJ7j0UB2QTnEivGACkEGumGzhzpL8uxLuCKgpL0voO2AQBVY
	LHifkBLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQcX-0017lp-O1; Tue, 23 Nov 2021 07:53:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYu-0016kJ-QE
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 238B41FD5F;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=;
 b=EljmPGfGfm+u445d5+u7lSrTxokydPBRP5QdjLdMTnpETFclEU19v7S98TSK1v5kIGx9uQ
 lq7nMCcqUq7Kz81KTUQfEPyMcxCTMXEcmQjHAvgBpyRCR/LgMStbDpcZtPCT4dJq2gIS1H
 UJ83BUAhKu6PMsRrKTQzDVOvQAMFurA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojwVCi9TySrjlWaZm3/VwDAss46iOLLXwvSULzX9DL4=;
 b=P4MVZ7TW6y96YSCy/kL7xuTe3yyXPd05Rs+fvGyWzk51FejdX9geKB0WBmfP5eLaYQhq2H
 i83n5dw7Gb8QxuBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1A1D1A3B8E;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 31577519188F; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/10] nvme/040: test dhchap key types for authenticated
 connections
Date: Tue, 23 Nov 2021 08:49:37 +0100
Message-Id: <20211123074940.113390-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234957_077193_BF3DD46F 
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


