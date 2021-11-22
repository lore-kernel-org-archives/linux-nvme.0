Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8141C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XugcWwRyDzjonFZac7PTY+bhUYIADQnFDsllIFrq5fE=; b=40TphbztDJMjSTwlUnh/Unkk/X
	KalIjfKfNFDdaayOx3B1WALorb34RyhfUTIkLkiPp1UhbIgIF9qLzDjPsIcJwjLeCUJahJTrk4ejS
	u9WzLqBier6CoqnedztA6OKdwWM+KlmDmP2bvE/FKpExjmiEHi8Dp9Ixhpb0UyK3BZ6bYPq0+8Muf
	Vi4SSkTGrjsHWIt6Pq2+I4NDdM7OSnXXX2pBcPNWvnBIK1uFQVf2mzkCfZZri1OhiPDnUgmBZVe8S
	rdr0DL7brzT5tw9Fc6VD4D2+K5SEP6zXjtEH5dwkJT0d477k9xXiJuiu4FhCSuinzx/Ie79wc6aHd
	8VXx+J5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Sp-00FElO-9m; Mon, 22 Nov 2021 08:14:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4As-00FAuU-BX
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 830F8218D5;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XugcWwRyDzjonFZac7PTY+bhUYIADQnFDsllIFrq5fE=;
 b=Z7XQ/AM16DunPaf2TIMlgXe7qZqP3iybUBT9V5YzbZU7onxd+jjvxrA8rRTSwNT/CZxBkV
 TDT3cA1SpEtWD7vE/JfiWe40nRozr7TCSU9JYUtOlW9MWs3L2cj4dOT7+ha49hQEp6Bqsh
 m+zCcONkjuKRJ5n8WU3sEvhxa4uZx1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XugcWwRyDzjonFZac7PTY+bhUYIADQnFDsllIFrq5fE=;
 b=bNruRk3fTe34hB5gYpqqEkzz27aaaNDHi+XFFWYGlWv274IzT3alkSqdxr+tXvuvhKVWst
 E7xcvDKxZv3+KgCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 78B70A3B8F;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5346851917F9; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/9] nvme/041: test different key types
Date: Mon, 22 Nov 2021 08:55:21 +0100
Message-Id: <20211122075524.26207-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_631262_AF3FA29F 
X-CRM114-Status: GOOD (  14.29  )
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
 tests/nvme/041     | 102 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/041.out |  36 ++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out

diff --git a/tests/nvme/041 b/tests/nvme/041
new file mode 100644
index 0000000..8fc4ab9
--- /dev/null
+++ b/tests/nvme/041
@@ -0,0 +1,102 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp dhchap keys
+
+. tests/nvme/rc
+
+DESCRIPTION="Test dhchap keys for authenticated TCP connection via localhost"
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
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvme list-subsys
+
+	nvme disconnect -n "${subsys}1"
+
+	for hmac in 1 2 3; do
+		echo "Testing hmac ${hmac}"
+		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${subsys}1 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for hmac ${hmac}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
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
+	for key_len in 32 48 64; do
+		echo "Testing key length ${key_len}"
+		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${subsys}1 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for length ${key_len}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
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
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
new file mode 100644
index 0000000..037c434
--- /dev/null
+++ b/tests/nvme/041.out
@@ -0,0 +1,36 @@
+Running nvme/041
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 1
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 2
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 3
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 32
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 48
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 64
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


