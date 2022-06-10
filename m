Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1599C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLOy51iW7w77jMCdh6xaYC1w5eeDrdSkkE/tS2jHkxQ=; b=ezBpH0lW2l1F6rYChR4CpuNdLJ
	hUnQ4+VhLtOmCIVdatIXjxpE17F/KHWKRDsyHdoTu5rjydeP6lKjAeErGe5H2zxfpXIO+nDtSFl80
	M3vhwKrrI8Y0nSYQYK1elHGrzft0Gu5igbjY70uDbS+0uVKYdxTI4f3FC8dk+ToaJieMXUAfjQ7Ig
	JcXUUsAC8sbXRen06or3W0B2wF0C139l+Vetki4a58i3Z+e9RY7ip7VslkQjskv44wxD9SrPn4aqE
	8k4qC4axTI9zLUd8rtt0anIkB4dSIpYoDBwfaS7zwgtfqehZuEoQnZhSyCl6ZQ94yj9OM4CBQLIoz
	aBWN4yaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcur-007wTK-OP; Fri, 10 Jun 2022 11:35:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcta-007vm0-QO
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E0B0E1F9C2;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLOy51iW7w77jMCdh6xaYC1w5eeDrdSkkE/tS2jHkxQ=;
	b=xamWOXDi960/4VJqIYs97bvhubb7dRATQKAYVH25z7CBM3PVpYmjdHSM6ggCvX31hlF1Gy
	L5qgDxpSoRDw7/NcR27ddlvax57ZRgSABfUtKypxfh3i50aisZ09WV0rkZjlxejiQG5XeV
	iSaUDb+HbBv4PyyDzdhUQMOPbXBLh0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLOy51iW7w77jMCdh6xaYC1w5eeDrdSkkE/tS2jHkxQ=;
	b=zyCggykBK+Dg5n4Kcw7O4ezy/saf5CTQysi5GfMspKtrO9YGH0z7tVoZhxQkPtVQ6uKndp
	0Q8HhrXPHqMoA+CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D89752C153;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B31635194A4A; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/10] nvme/044: test re-authentication
Date: Fri, 10 Jun 2022 13:33:24 +0200
Message-Id: <20220610113324.10294-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043343_102424_7523ACE0 
X-CRM114-Status: GOOD (  13.56  )
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
 tests/nvme/044     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/044.out |  12 +++++
 2 files changed, 137 insertions(+)
 create mode 100644 tests/nvme/044
 create mode 100644 tests/nvme/044.out

diff --git a/tests/nvme/044 b/tests/nvme/044
new file mode 100644
index 0000000..060194e
--- /dev/null
+++ b/tests/nvme/044
@@ -0,0 +1,125 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test re-authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test re-authentication"
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
+	echo "Re-authenticate with original host key"
+
+	ctrldev=$(_find_nvme_dev "${subsys_name}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+	echo "${hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	echo "Renew host key on the controller"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+
+	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+
+	echo "Re-authenticate with new host key"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	echo "Renew ctrl key on the controller"
+
+	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+
+	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+
+	echo "Re-authenticate with new ctrl key"
+
+	echo "${new_ctrlkey}" > /sys/class/nvme/${ctrldev}/dhchap_ctrl_secret
+
+	echo "Change DH group to ffdhe8192"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
+
+	echo "Re-authenticate with changed DH group"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	echo "Change hash to hmac(sha512)"
+
+	_set_nvmet_hash "${hostnqn}" "hmac(sha512)"
+
+	echo "Re-authenticate with changed hash"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
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
+	rm ${file_path}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/044.out b/tests/nvme/044.out
new file mode 100644
index 0000000..51a7092
--- /dev/null
+++ b/tests/nvme/044.out
@@ -0,0 +1,12 @@
+Running nvme/044
+Re-authenticate with original host key
+Renew host key on the controller
+Re-authenticate with new host key
+Renew ctrl key on the controller
+Re-authenticate with new ctrl key
+Change DH group to ffdhe8192
+Re-authenticate with changed DH group
+Change hash to hmac(sha512)
+Re-authenticate with changed hash
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


