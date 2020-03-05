Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C307AC3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8416D20848
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKPq5Zhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8416D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=25ZU+Yh3apiymMpMv+9mRsbVmv7wdrxRMpKc7JiCO/0=; b=EKPq5ZhmN8RobqZ8/sHr/nnCwl
	wm+A+MLnmuzUq2YB/clSMxTbgti11HuMiq+Yve4xzB4LI7ZTaYgcjxK3Sj5ivccjXXHzZuK6dIs/o
	a/Lxh4SvH5QjHg8LMuNCraaJI1Onf/BnVBIF4+/pMGCoUynd+/6HwisapPO1lrjDDS8NzXhvdsw18
	u74EsU2a0c/sdRWYM/qlAoi8E7v6XiN8jNQ4t+0YDeMPue6RKKKdsvkY9U/wQp0sHAOIZB5Ze0pTg
	7RpPKclN8nmgr7uaAJBY4w7Rt0R0I7lQpbigR8Kz52ULviKfHlS4RgIPw+Jpezk60ba+nulOFo4RA
	upNHoOPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9p4N-0005hu-O6; Thu, 05 Mar 2020 11:53:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9p3p-0005FW-3a
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 11:53:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 50A1FAF82;
 Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 2/3] nvme/033: add test for ANA state transition
Date: Thu,  5 Mar 2020 12:52:38 +0100
Message-Id: <20200305115239.29794-3-hare@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200305115239.29794-1-hare@suse.de>
References: <20200305115239.29794-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_035305_458779_2ADA420C 
X-CRM114-Status: GOOD (  14.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a test to check ANA state transitions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/033     | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  18 +++++++
 tests/nvme/rc      |  16 ++++++
 3 files changed, 173 insertions(+)
 create mode 100644 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100644
index 0000000..44182fc
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,139 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Regression test for ANA base support
+#
+# Copyright (C) 2018 Hannes Reinecke, SUSE Linux GmbH
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
+QUICK=1
+
+switch_nvmet_anagroup() {
+	local port1="$1"
+	local port2="$2"
+	local mode="$3"
+
+	echo "ANA state ${mode}"
+
+	if [ "${mode}" = "change" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "change"
+		_set_nvmet_anagroup_state "${port1}" "2" "change"
+		_set_nvmet_anagroup_state "${port2}" "1" "change"
+		_set_nvmet_anagroup_state "${port2}" "2" "change"
+	elif [ "${mode}" = "failover" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
+	else
+		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+	fi
+}
+
+requires() {
+	_have_program nvme && _have_modules nvme-loop && \
+		_have_configfs && _have_fio
+}
+
+test() {
+	local mount_dir="/mnt/blktests"
+	local subsys="blktests-subsystem-1"
+	local port1
+	local port2
+	local loop_dev1
+	local loop_dev2
+	local nvmedev
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	mkdir -p "${mount_dir}" > /dev/null 2>&1
+
+	port1="$(_create_nvmet_port "loop")"
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	port2="$(_create_nvmet_port "loop")"
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	truncate -s 1G "$TMPDIR/img1"
+
+	loop_dev1="$(losetup -f --show "$TMPDIR/img1")"
+
+	_create_nvmet_subsystem "${subsys}" "${loop_dev1}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+
+	truncate -s 1G "$TMPDIR/img2"
+
+	loop_dev2="$(losetup -f --show "$TMPDIR/img2")"
+
+	_create_nvmet_ns "${subsys}" "2" "${loop_dev2}" \
+		"9aed0138-bfd9-46f5-92ac-24c70377fd49" "2"
+
+	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
+	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
+
+	switch_nvmet_anagroup "${port1}" "${port2}" failback
+
+	nvme connect -t loop -a "${port1}" -n "${subsys}"
+	nvme connect -t loop -a "${port2}" -n "${subsys}"
+
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"
+
+	mkfs.xfs -f /dev/"${nvmedev}" > /dev/null 2>&1
+
+	mount /dev/"${nvmedev}" "${mount_dir}"
+
+	_run_fio_rand_io --size=32m --directory="${mount_dir}" --runtime=20s --time_based &
+	trap "kill $!" EXIT
+
+	sleep 10
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "change"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	sleep 6
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "failover"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	wait
+	trap - EXIT
+
+	umount "${mount_dir}" > /dev/null 2>&1
+
+	nvme disconnect -n "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+	_remove_nvmet_ns "${subsys}" "2"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_anagroup "${port1}" "${ag1}"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "${ag2}"
+	_remove_nvmet_port "${port2}"
+	losetup -d "${loop_dev2}"
+	rm "$TMPDIR/img2"
+	losetup -d "${loop_dev1}"
+	rm "$TMPDIR/img1"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..782656f
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,18 @@
+Running nvme/033
+ANA state failback
+1: grpid 1 state optimized
+1: grpid 2 state inaccessible
+2: grpid 1 state inaccessible
+2: grpid 2 state optimized
+ANA state change
+1: grpid 1 state change
+1: grpid 2 state change
+2: grpid 1 state change
+2: grpid 2 state change
+ANA state failover
+1: grpid 1 state inaccessible
+1: grpid 2 state optimized
+2: grpid 1 state optimized
+2: grpid 2 state inaccessible
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 72e33c1..1787725 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -246,6 +246,22 @@ _find_nvme_loop_dev() {
 	done
 }
 
+_find_nvme_ns() {
+	local uuid=$1
+	local dev
+	local hidden
+
+	for dev in /sys/block/nvme*; do
+		hidden="$(cat "${dev}/hidden")"
+		[[ "$hidden" -eq 1 ]] && continue
+		u="$(cat "${dev}/uuid")"
+		if [[ "$uuid" = "$u" ]] ; then
+			echo "$(basename "${dev}")"
+			break
+                fi
+        done
+}
+
 _filter_discovery() {
 	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \
 		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
