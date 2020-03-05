Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85036C3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC1C20848
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F69ams8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC1C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eKKn04l11iYfBpKFJX09Gt4Co9FIS6J8+n89wjk911E=; b=F69ams8hseYmerUkqeQwPl+Aa2
	w9M+vmoGkxaTLaJI+PD4qgJfk/flGaFm5/Dt4uISgWrLjFSc8ch7yp9myTupg/hr8CPFPlXQRxbea
	5qYMw/tSDX/tJ+9j1SJCy345LVgqAwXIw0yhGZuCO7/CA2fT0cExxGd9LgIicmCfeK1OdNbgetFC7
	tGmNarizFnkmB31Uy3ZuQZX9nPy5ePWUh/xi562rZ7nG1F0RmRCMIAmM7oz+QeZ/PpMG3Pt5hi6yk
	vsBkk1E+Ue/dhyF09Z27MNoVJZHhAk0QBDCUng4nLhLtUB2TuWpwRb08L4DruslIHxxVbHnZq1Gpq
	E7kOLdiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9p3t-0005Ju-E2; Thu, 05 Mar 2020 11:53:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9p3p-0005FX-3W
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 11:53:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 500F8AF00;
 Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 3/3] tests/nvme/034: Add a test for the fcloop driver
Date: Thu,  5 Mar 2020 12:52:39 +0100
Message-Id: <20200305115239.29794-4-hare@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200305115239.29794-1-hare@suse.de>
References: <20200305115239.29794-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_035305_451612_5F297106 
X-CRM114-Status: GOOD (  12.85  )
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

Add a test for the in-kernel fcloop driver. Despite being a loop
driver it still requires an actual FC card to run this test.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 common/fcloop      |  58 +++++++++++++++++++++++++
 tests/nvme/034     | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |   3 ++
 3 files changed, 183 insertions(+)
 create mode 100644 common/fcloop
 create mode 100644 tests/nvme/034
 create mode 100644 tests/nvme/034.out

diff --git a/common/fcloop b/common/fcloop
new file mode 100644
index 0000000..b9a1ce7
--- /dev/null
+++ b/common/fcloop
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+#
+# fcloop helper functions.
+
+. common/shellcheck
+
+_nvme_fcloop_add_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
+}
+
+_nvme_fcloop_del_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port
+}
+
+_nvme_fcloop_add_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
+}
+
+_nvme_fcloop_del_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_local_port
+}
+
+_nvme_fcloop_add_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
+}
+
+_nvme_fcloop_del_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port
+}
diff --git a/tests/nvme/034 b/tests/nvme/034
new file mode 100644
index 0000000..1a197f2
--- /dev/null
+++ b/tests/nvme/034
@@ -0,0 +1,122 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2018 Johannes Thumshirn, Hannes Reinecke, SUSE Linux GmbH
+#
+# Reproducer for nvme-fcloop
+#
+
+. tests/nvme/rc
+. common/fcloop
+
+DESCRIPTION="create nvme-fcloop with two ports and connect/disconnect"
+
+requires() {
+	_have_program nvme && \
+		_have_modules loop nvme-fcloop nvmet nvmet-fc && \
+		_have_configfs
+}
+
+test() {
+	local subsys="blktests-subsystem-1"
+	local remote_wwnn1="0x100140111111dbcc"
+	local remote_wwpn1="0x200140111111dbcc"
+	local remote_wwnn2="0x100140111111dbcd"
+	local remote_wwpn2="0x200140111111dbcd"
+	local host_wwnn1="0x100140111111dac8"
+	local host_wwpn1="0x200140111111dac8"
+	local host_wwnn2="0x100140111111dac9"
+	local host_wwpn2="0x200140111111dac9"
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet-fc
+	modprobe nvme-fcloop
+
+	_nvme_fcloop_add_tport ${remote_wwnn1} ${remote_wwpn1}
+	_nvme_fcloop_add_tport ${remote_wwnn2} ${remote_wwpn2}
+
+	_nvme_fcloop_add_lport ${host_wwnn1} ${host_wwpn1}
+	_nvme_fcloop_add_lport ${host_wwnn2} ${host_wwpn2}
+
+	_nvme_fcloop_add_rport ${host_wwnn1} ${host_wwpn1} \
+		${remote_wwnn1} ${remote_wwpn1}
+	_nvme_fcloop_add_rport ${host_wwnn2} ${host_wwpn2} \
+		${remote_wwnn2} ${remote_wwpn2}
+
+	local port1
+	port1=$(_create_nvmet_port "fc")
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	local port2
+	port2=$(_create_nvmet_port "fc")
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	local remote_traddr1
+	remote_traddr1=$(printf "nn-%s:pn-%s" "${remote_wwnn1}" "${remote_wwpn1}")
+	echo fc > /sys/kernel/config/nvmet/ports/${port1}/addr_adrfam
+	echo "${remote_traddr1}" > /sys/kernel/config/nvmet/ports/${port1}/addr_traddr
+
+	local remote_traddr2
+	remote_traddr2=$(printf "nn-%s:pn-%s" "${remote_wwnn2}" "${remote_wwpn2}")
+	echo fc > /sys/kernel/config/nvmet/ports/${port2}/addr_adrfam
+	echo "${remote_traddr2}" > /sys/kernel/config/nvmet/ports/${port2}/addr_traddr
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "${subsys}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
+	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
+
+	_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+	_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+
+	local host_traddr1
+	host_traddr1=$(printf "nn-%s:pn-%s" "${host_wwnn1}" "${host_wwpn1}")
+
+	nvme connect -t fc -a "${remote_traddr1}"  -w "${host_traddr1}" \
+		-n "${subsys}"
+
+	local host_traddr2
+	host_traddr2=$(printf "nn-%s:pn-%s" "${host_wwnn2}" "${host_wwpn2}")
+
+	nvme connect -t fc -a "${remote_traddr2}"  -w "${host_traddr2}" \
+		-n "${subsys}"
+
+	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"
+
+	# Allow I/O to settle
+	udevadm settle
+
+	nvme disconnect -n "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_anagroup "${port1}" "${ag1}"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "${ag2}"
+	_remove_nvmet_port "${port2}"
+
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
+
+	# Fixme: need to wait for RCU grace period
+	sleep 5
+
+	_nvme_fcloop_del_rport "${host_wwnn1}" "${host_wwpn1}" \
+		"${remote_wwnn1}" "${remote_wwpn1}"
+	_nvme_fcloop_del_rport "${host_wwnn2}" "${host_wwpn2}" \
+		"${remote_wwnn2}" "${remote_wwpn2}"
+
+	_nvme_fcloop_del_tport "${remote_wwnn1}" "${remote_wwpn1}"
+	_nvme_fcloop_del_tport "${remote_wwnn2}" "${remote_wwpn2}"
+
+	_nvme_fcloop_del_lport "${host_wwnn1}" "${host_wwpn1}"
+	_nvme_fcloop_del_lport "${host_wwnn2}" "${host_wwpn2}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
new file mode 100644
index 0000000..832d645
--- /dev/null
+++ b/tests/nvme/034.out
@@ -0,0 +1,3 @@
+Running nvme/034
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
