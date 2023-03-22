Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE3C761AF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXUrtujg2ff8LWOHRdRnBuszIDKHUpNyoCvyQ2YNsPo=; b=CZPWejswWVjOQOJpS1NnIPXDAk
	74lUCW9wkl8ZQ3TSJsPNK6G6VHGFYJhD/giSX76j1/sNubYU0lFZHxtWviRv+N8Xxf2aM1HORTgjw
	54p6pHwJYykFhyliryi2+zCPXe8YNgQ2p8+2eTS6zITN7ZXiwKbw7h6KDbrLz6AWO9gTwUOX4knAg
	7GAawXj6GiH/61GW9jyeCGk0UWGmBcldar1v1RKMxDO4oIdI5qyU9BrJ5xyfZRqlkbibfkFXHHEgk
	QQOu/VBhETptq5V3mmeKUkEEYzIZnoN79EERyJipqmKF7z8QvQFS8mRsc+fs29PuX6lQus4gYbahj
	EYLth6SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWe-00FbdA-2i;
	Wed, 22 Mar 2023 10:17:00 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pevWa-00FbZS-2v
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 10:16:59 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2872B339B1;
	Wed, 22 Mar 2023 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679480214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXUrtujg2ff8LWOHRdRnBuszIDKHUpNyoCvyQ2YNsPo=;
	b=SrmS7TbyhiyPs9MKJz35cJDfgGQuqOEgKbB47+C2p7tre68eaPQYkUAbOnrKEeEH3pF3ik
	wJ5K81wGHEdfCM74TP7dFZHErHGhXKXn7vU4g2JDXNX2iaQ8gL++iWxpb39U5Wi0qrnRV5
	4K9hcU8vY/1yThEFjGvHcCJL4dgJ9Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679480214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXUrtujg2ff8LWOHRdRnBuszIDKHUpNyoCvyQ2YNsPo=;
	b=kcY4/Vi8yRREzW0svOvNPOIgBhhEGsC2c+F6qEwBsAIJ4k5eAqQ2oXzrCupn5M+bNqcIcq
	ftAPwsCTmPCKhbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A10C138E9;
	Wed, 22 Mar 2023 10:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id otIEBpbVGmSGDAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 10:16:54 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 3/3] nvme/047: Test different queue counts
Date: Wed, 22 Mar 2023 11:16:48 +0100
Message-Id: <20230322101648.31514-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
References: <20230322101648.31514-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_031657_095145_090F548B 
X-CRM114-Status: GOOD (  14.16  )
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

Test if the transport are handling the different queues correctly.

We also issue some I/O to make sure that not just the plain connect
works. For this we have to use a file system which supports direct I/O
and hence we use a device backend.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/047     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 000000000000..6a37f7a569b7
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2023 SUSE LLC
+#
+# Test NVMe queue counts.
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="test NVMe queue counts"
+
+requires() {
+	_nvme_requires
+	_have_xfs
+	_have_fio
+	_require_nvme_trtype_is_fabrics
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local nvmedev
+	local loop_dev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 512M "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--nr-write-queues 1
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m"
+
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--nr-write-queues 1 \
+		--nr-poll-queues 1
+
+	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m"
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
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 000000000000..915d0a2389ca
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.40.0


