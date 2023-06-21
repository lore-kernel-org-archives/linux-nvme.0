Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4116EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGOyuozdZEg1rV2jSDdWfg2dvvscaZag+fZjO1LUAHM=; b=LD3diZBHS98+rwTA31INYJNO65
	eqMq766cTWu6UjSFjEradV+vqXaYu7QzmaNNvAJa5pNIlrCzwcCdHk0fevMmPIYfls7ITEnhGqzdo
	vtEk2foMaJL5XKLn93RIIXn5iGKcWwGIvjOHrMMJ6PHOxA8lIXpsM9XCXZG/350vhnpOEy4bGBfe5
	28v5cs5TGvhXHMCqVJ6wRbryanE/etWDkXAU7024Z7KS3aE80GUT1J4WTqaDLCHTxHI8mZ2yZZVlJ
	kvgTl5ciWJB7wP3vpANgovRDDAdTMAUfrop2xFLmapZ7jP2p7ZmOYdzctj/TZ0d5RXk9oqZ+RRB/P
	Fj/yTpQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qC0EJ-00F1Uj-3C;
	Wed, 21 Jun 2023 15:58:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qC0EG-00F1T9-2p
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 15:58:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69C4321EF7;
	Wed, 21 Jun 2023 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687363121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGOyuozdZEg1rV2jSDdWfg2dvvscaZag+fZjO1LUAHM=;
	b=i905QhIv+FXqDw8Dz5cOkH/8gXD9yZy0t2H44eD3ePVrn03+4FcEDEsDIc/0ZDDSIlDrFY
	4CrQY/5qVxYRLd/hXpixOSz3IuYVhgpPBwHcen4ctjbOz+fbw6kdbUkPeLjuadMzu5OSxV
	+WP+vWlhDgo0ILez/KhAYGABLqaxsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687363121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YGOyuozdZEg1rV2jSDdWfg2dvvscaZag+fZjO1LUAHM=;
	b=nEu+0ySm0inoWxM7P5QKVyCQtbi16QpI6LAX7eZzbCgEiKH+oSnBK7XJI3TnatOrlg+n/S
	ZQFKWWfauw4aeLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5962D134B1;
	Wed, 21 Jun 2023 15:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id v+FuFTEek2RMMgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 15:58:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Martin George <Martin.George@netapp.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 1/1] nvme/050: test DNR handling on reconnect
Date: Wed, 21 Jun 2023 17:58:25 +0200
Message-ID: <20230621155825.20146-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621155825.20146-1-dwagner@suse.de>
References: <20230621155825.20146-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_085845_075362_6C3DDC54 
X-CRM114-Status: GOOD (  17.57  )
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

When the host gets disconnected and tries to reconnect,
it should honor the DNR bit and do not retry to connect
with the same parameters.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/050     | 126 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |   2 +
 2 files changed, 128 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 000000000000..d33eb24e2f13
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,126 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 SUSE LLC
+#
+# Test DNR is handled on connnect attempt with invalid arguments.
+
+. tests/nvme/rc
+
+DESCRIPTION="test DNR is handled on connect attempt with invalid arguments"
+
+requires() {
+	_nvme_requires
+	_require_nvme_trtype tcp rdma fc
+	_require_min_cpus 2
+}
+
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+nvmf_wait_for_ctrl_delete() {
+	local def_state_timeout=5
+	local nvmedev="$1"
+	local timeout="${2:-$def_state_timeout}"
+	local ctrl="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+	local start_time
+	local end_time
+
+	start_time=$(date +%s)
+	while [ -f "${ctrl}" ]; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "controller \"${nvmedev}\" not deleted" \
+				"within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local loop_dev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+	local hostid="77b49aba-06b4-431a-9af8-75e318740f1a"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local nvmedev
+
+	truncate -s "${nvme_img_size}" "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--hostnqn "${hostnqn}" \
+		--reconnect-delay 1 \
+		--ctrl-loss-tmo 10
+
+	nvmf_wait_for_state "${subsys_name}" "live"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	# Only allow connects from ${def_hostnqn}
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+
+	# Force a reconnect
+	set_nvmet_attr_qid_max "${subsys_name}" 1
+
+	# The reconnect fails with the DNR bit set
+	# Thus the host should remove the controller
+	nvmf_wait_for_ctrl_delete "${nvmedev}"
+
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 000000000000..b78b05f78424
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,2 @@
+Running nvme/050
+Test complete
-- 
2.41.0


