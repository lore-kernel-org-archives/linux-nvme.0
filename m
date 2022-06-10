Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A23C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73SHc/og8UW4DiVLaA/5IUOhK+fueZdSBGa7TdvxUCc=; b=qrvtm3L8/QnGvAGaeGsCGpNVb8
	GTh87NrWWQijaLyzba8OWhDsnE83k38SOPa5IFiKgsnKgge5K3AXp703UWCPM5ej6Qbt/xm6VZogY
	wBUbNcagwYda26wUKr0QPiHBj19kSCUqWhqxOAI9ZXSdxDYZ/SWtqYLWWpmE1gbn+Xnq7J7DIVEzo
	fsbGe8gEg0S5uB0rpbg5XNcKAH3cdsbD7hvznJMcVgIEK95Fi5tFTbLdIHpTzj+y1LwsmjSe1oYHc
	XGgrrT1atCF7QkxyKX+xBMhJk3i+Y8i/DfEB1/1lXgKqiDJVKlCv90MUzjMi/f+UwNGevRACwtkKc
	hVCqINfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcud-007wKh-44; Fri, 10 Jun 2022 11:34:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcta-007vm1-QN
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id DFFB61F9B7;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73SHc/og8UW4DiVLaA/5IUOhK+fueZdSBGa7TdvxUCc=;
	b=KTfb+ZkBv0CDPm+RWIvKlsMeAFggRWe+jJNTaIvcK8unlX3VjfG5dPlvGFYjQllHfpIQyK
	yPzq3IIX8oiNofLP19ge1ntoNxbMkZohIQ3wpzeuXfyojhbfF1OMXPpVvTl6wAkVFJYALY
	+oQ9XQMMEIjkQnGj9pKrN01mmppJ6cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73SHc/og8UW4DiVLaA/5IUOhK+fueZdSBGa7TdvxUCc=;
	b=AyM1imr/+jFNZDBC0Y/8LYW044ddXRqfzCO6m8wrjCS0z4XlDxEb4fCrc03g4ROGx/gAc/
	cKfomNFgqhQDzyBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D17612C14E;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A8D6B5194A44; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/10] nvme/041: test dhchap key types for authenticated connections
Date: Fri, 10 Jun 2022 13:33:21 +0200
Message-Id: <20220610113324.10294-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043343_097543_FCFC8A22 
X-CRM114-Status: GOOD (  13.20  )
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
 tests/nvme/041     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/041.out | 16 ++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out

diff --git a/tests/nvme/041 b/tests/nvme/041
new file mode 100644
index 0000000..2ded9c9
--- /dev/null
+++ b/tests/nvme/041
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
+	_have loop
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
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+
+	for hmac in 0 1 2 3; do
+		echo "Testing hmac ${hmac}"
+		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${subsys_name} 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for hmac ${hmac}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+		if [ $? -ne 0 ] ; then
+			echo "nvme connect failed"
+		fi
+
+		udevadm settle
+
+		_nvme_disconnect_subsys "${subsys_name}"
+	done
+
+	for key_len in 32 48 64; do
+		echo "Testing key length ${key_len}"
+		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${subsys_name} 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for length ${key_len}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		if [ $? -ne 0 ] ; then
+			echo "nvme connect failed"
+		fi
+
+		udevadm settle
+
+		_nvme_disconnect_subsys "${subsys_name}"
+	done
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
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
new file mode 100644
index 0000000..49a56ea
--- /dev/null
+++ b/tests/nvme/041.out
@@ -0,0 +1,16 @@
+Running nvme/041
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
2.26.2


