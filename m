Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89095C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8W0j3m3g9mbuvAYgmTAyOHe1ozF8JFUJaCK/5kksqs=; b=Hl/ku3yp8EMNgBr4bcVH4aklg7
	q5ySdtiVEvhP78Oa0Fu5GzJwjiEVfd/+ZgarNlX0RJxFWzd7xZ/QxzvgA1XQrSCMsLBSADhiUbfHR
	bo1StQx5sv4qXXIkbmMnjZlnTVuEIlwjxVqdg57tbQ2EpficZfxvp+I8BFqCItZ8pWxHepoG8n8xB
	yDFXJLjj9MRzeBKyVESNMDAR3RVDD7wqZkqErl0/qpCClDg8KzB7FZG5DCEmTB0i3mBBQPoff7bz5
	Wj1SA6AycoCyKDpVidNQB6zc7cRSNrsC3wLAKEBDoMd9+Tl96VymcgA0lmOIqxVYsjkAZnzDGZbpx
	11P3H0HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctl-007vqS-TZ; Fri, 10 Jun 2022 11:33:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctT-007vip-3X
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D7A9E1F9A4;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8W0j3m3g9mbuvAYgmTAyOHe1ozF8JFUJaCK/5kksqs=;
	b=vaPL//UKeqgL4ffsFm+PVAswmA5jBj58JHVTpAeyNhWQacwfwBZUTxYXoLn4bFQK1WVHlf
	BBIyz/YVbOeXKSu/NWpzZuvuwmwohuv5xk6VB4giEl8j71x678xb8QQ5RFuqTP9qrQ/b9A
	2y0dEUjdjM6LO7o1Wvwr26bZfUfCVs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8W0j3m3g9mbuvAYgmTAyOHe1ozF8JFUJaCK/5kksqs=;
	b=82Wc/e2cqr+pYRQrm+6Og7PT2BsTudYSolNBRPBY44L+60Y4VSTtNxIzeNm0bC4vysArCO
	Vx3zvxqV2Vnl6iCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D1E2C2C152;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AFA655194A48; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/10] nvme/043: test bi-directional authentication
Date: Fri, 10 Jun 2022 13:33:23 +0200
Message-Id: <20220610113324.10294-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043335_404793_EB06371C 
X-CRM114-Status: GOOD (  13.48  )
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
 tests/nvme/043     | 106 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |   8 ++++
 2 files changed, 114 insertions(+)
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out

diff --git a/tests/nvme/043 b/tests/nvme/043
new file mode 100644
index 0000000..fdccb10
--- /dev/null
+++ b/tests/nvme/043
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test bi-directional authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test bi-directional authentication"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+}
+
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local file_path="${TMPDIR}/img"
+	local hostkey
+	local ctrlkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
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
+	# Step 1: Connect with host authentication only
+	echo "Test host authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}"
+	if [ $? -ne 0 ] ; then
+		echo "nvme connect failed"
+	fi
+
+	udevadm settle
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	# Step 2: Connect with host authentication
+	# and invalid ctrl authentication
+	echo "Test host authentication and invalid ctrl authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${hostkey}"
+	if [ $? -eq 0 ] ; then
+		echo "nvme connect succeeded (should have failed)"
+		_nvme_disconnect_subsys "${subsys_name}"
+	fi
+
+	# Step 3: Connect with host authentication
+	# and valid ctrl authentication
+	echo "Test host authentication and valid ctrl authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${ctrlkey}"
+	if [ $? -ne 0 ] ; then
+		echo "nvme connect failed"
+	fi
+
+	udevadm settle
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
+	rm ${file_path}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
new file mode 100644
index 0000000..a49408d
--- /dev/null
+++ b/tests/nvme/043.out
@@ -0,0 +1,8 @@
+Running nvme/043
+Test host authentication
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test host authentication and invalid ctrl authentication
+no controller found: failed to write to nvme-fabrics device
+Test host authentication and valid ctrl authentication
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


