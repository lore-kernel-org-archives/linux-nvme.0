Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E773C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=; b=EE6nmKdp/FZtJkqAUoY53iMLsZ
	tUB9BT9Dt4FWX27aqX4gA9Oiqinxc/mRZgQnh44Wpyr7t5IRExmQR/jBGyNt+mWNS8xfXRyk4LtrD
	ELUAfSjARFQcz12l6worMsd5xwTF646Q4gO48N17Fx5meyTMYSOQKoCwE/xuxcONarqOXUyJllBYR
	MVuEZITtQhRifqGM+kD/xUId3r7SG2RSNfYOMZP1ulVd88hE75PE70R6qdgG7rjqn5RwahjlCngI9
	w74EEL94y3OFduDxCLQQ9TT3pjSlHkc14kAH3ajFnnetKoXTZWBVTZkYHMKAwUpJSFWD3KDCpy2sO
	0yx4U8eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTC-0088zJ-VN; Mon, 28 Mar 2022 10:19:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uU-K8
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 522281F381;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=;
 b=y1CKQwY10klvEHE3dsvEGioV2aSYGM+T61OKOvOi5NjuGW9ryrNTOrhgyvvNNpumt0hVh0
 0EnMf6Cviq5GdDC8xzYbMjaOo9iY0pv7gCdIcrdPQ72HGnRm8rFsCFUvPfz9Z30AWIdV09
 hEV+6SF77maavGXNocBKAkr4sUA6tog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=;
 b=ET+Q/MEf3jH3BcNDC2ixvwnmmqH0AsITd6AdfkysK6/AtbNq4kz4Vg4qvyHiqlA01VmT++
 cAz38KqbdfLV/QCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 46237A3B95;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 42B5E51939C5; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/10] nvme/039: create authenticated connections
Date: Mon, 28 Mar 2022 12:18:51 +0200
Message-Id: <20220328101855.73975-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031921_903058_2013E457 
X-CRM114-Status: GOOD (  12.27  )
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
 tests/nvme/039     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  7 ++++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100644
index 0000000..4fbe7de
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Create authenticated connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Create authenticated connections"
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
+	hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
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
+	_create_nvmet_subsystem "${subsys}" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}"
+	_create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}"
+
+	# Test unauthenticated connection (should fail)
+	echo "Test unauthenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}"
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -n "$ctrldev" ] ; then
+		echo "nvme controller found"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+
+	# Test authenticated connection
+	echo "Test authenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}" "${hostkey}"
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
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
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 0000000..e42d2f1
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,7 @@
+Running nvme/039
+Test unauthenticated connection
+no controller found
+NQN:blktests-subsystem-1 disconnected 0 controller(s)
+Test authenticated connection
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


