Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CA5D6EC0A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TbJgXzu9d4sPvq9jVlXBfjc3vgaaH4I/NC+QWfZ3/jU=; b=2A8HPKNTkJWowe7hcPWah2HtfX
	Yo6hMoGy4wkJJxzTcKmmQW57+rDiatU/A8bUHrdNYn1h4l+PBah84NMvKWonFLL29Bq6JkWaLn/IH
	n8/b7ezUM/WNtdtfI/T+Aemaeav4jVyHXMgq/IemI4DkXLyAW+8yyGA1PwslsIxOvKBU9oM54+pL+
	ZBQd/1EprYtPqYGoApe6Yr7tDC8FVGxhpJRoyLdttNV0Rut8aZ1DOSqbmrY5sk0cQyw29N9z7tONa
	mVkTNwEgb14OMDLOxmfzt4t1r6RO6v0uwrKbufwm9fdsdaVtPgad76CIOddsbzQzgosIGLJllPA12
	DONPpgxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10x-00000000BPa-25rk;
	Fri, 29 Nov 2024 13:26:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10r-00000000BJ1-3jeF
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886786; x=1764422786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi3FuQM22DQEOtcklHgfq0fUPvvdDxsPK/gA9O/02d0=;
  b=rmRAC8Yk1FQvPdLPD0ihSmfzC7z4BmLqvx0nUJlOuDLnSJOvx21+Hn63
   Pn/L0hAr/wEtIVoH1pYuIlXi0ePvOsn4rlkZPE42wOGsCxghlHyn85U3V
   yiGFx1MJX9asXcfIpzyu+7gOn0cFOX2OIQX/nyBRONZQkpRAPmY4i+oX1
   fDMvq2Ub8bQYj5FAhFvuxc3Yyomhj2v+Ijk80hccb+lGZHm/qVdpJH7kd
   plDMLup6s6H7Lm7sjul2orWx7Q+ANyke1hWLmfYojzyEMFNQo9WQQycsi
   RQ+aB+ZTuOjlmHRSvsKMfsyCvwaS+I/73QE3oc0bUhpa8vUDPpMq+7bQV
   Q==;
X-CSE-ConnectionGUID: 0iWDq6nQT2OLzAteVobFVg==
X-CSE-MsgGUID: Er13zC1YTEyJtjEwmWTTKw==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015181"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:24 +0800
IronPort-SDR: 6749b262_za/AFRWAVBVGqq/PnXvFGOWpzhOiLUTvb2Xn+o6I5LEcHXB
 xCoqRhBVHaeTWwDHUU3kmCXcT9fr7HPqqI80Vag==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:24:02 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:24 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 7/7] test/nvme: add test for rapid namespace remapping
Date: Fri, 29 Nov 2024 22:26:17 +0900
Message-ID: <20241129132617.400429-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052625_989992_ECF4CC64 
X-CRM114-Status: GOOD (  16.52  )
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

From: Hannes Reinecke <hare@suse.de>

Add a test for rapid namespace remapping to simulate short-lived
namespaces being created and deleted in rapid succession with a
cluster.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: renumbered the test case from 055 to 056]
[Shin'ichiro: use for loop instead of seq per style guideline]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/056     | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/056.out |  14 ++++++
 tests/nvme/rc      |  31 +++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100755 tests/nvme/056
 create mode 100644 tests/nvme/056.out

diff --git a/tests/nvme/056 b/tests/nvme/056
new file mode 100755
index 0000000..d230a21
--- /dev/null
+++ b/tests/nvme/056
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Hannes Reinecke (SUSE) <hare@suse.de>
+#
+# Test rapid remapping of namespaces
+
+. tests/nvme/rc
+
+DESCRIPTION="test rapid namespace remapping"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+_setup_ana() {
+	local portno=0
+
+	for port in "$@"; do
+		if (( portno == 0 )); then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+			_setup_nvmet_port_ana "${port}" 2 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 3 "inaccessible"
+		elif (( portno == 1 )); then
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+			_setup_nvmet_port_ana "${port}" 2 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 3 "inaccessible"
+		elif (( portno == 2 )); then
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 2 "optimized"
+			_setup_nvmet_port_ana "${port}" 3 "inaccessible"
+		elif (( portno == 3 )); then
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 2 "non-optimized"
+			_setup_nvmet_port_ana "${port}" 3 "inaccessible"
+		elif (( portno == 4 )); then
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 2 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 3 "optimized"
+		else
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 2 "inaccessible"
+			_setup_nvmet_port_ana "${port}" 3 "non-optimized"
+		fi
+		portno=$(( portno + 1 ))
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local d i n port
+	local -a ports
+	local num_namespaces=3
+
+	_nvmet_target_setup --ports 6 --blkdev none
+
+	for ((d = 1; d <= num_namespaces; d++)); do
+		local file_path
+		local blkdev
+		local uuid
+
+		file_path="${TMPDIR}/img${d}"
+		truncate -s "${NVME_IMG_SIZE}" "${file_path}"
+		blkdev="$(losetup -f --show "${file_path}")"
+		uuid="$(uuidgen)"
+		_create_nvmet_ns --nsid "${d}" --blkdev "${blkdev}" \
+				 --uuid "${uuid}" --grpid "${d}" > /dev/null
+	done
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	_setup_ana "${ports[@]}"
+
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}"
+	done
+
+	# Simulate unmap on one cluster node and remap to anther one
+	for ((i = 0; i <= 10; i++)); do
+		echo "Remap namespace #${i}"
+		grpid=$(( (i % 3) + 1 ))
+		for n in $(seq 1 "${num_namespaces}" | shuf); do
+			_disable_nvmet_ns "${n}"
+		done
+		for n in $(seq 1 "${num_namespaces}" | shuf); do
+			local uuid
+
+			uuid=$(uuidgen)
+			_set_nvmet_ns_uuid "${n}" "${uuid}"
+			_enable_nvmet_ns "${n}"
+		done
+	done
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/056.out b/tests/nvme/056.out
new file mode 100644
index 0000000..cdc3e55
--- /dev/null
+++ b/tests/nvme/056.out
@@ -0,0 +1,14 @@
+Running nvme/056
+Remap namespace #0
+Remap namespace #1
+Remap namespace #2
+Remap namespace #3
+Remap namespace #4
+Remap namespace #5
+Remap namespace #6
+Remap namespace #7
+Remap namespace #8
+Remap namespace #9
+Remap namespace #10
+disconnected 6 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d63afd1..2ddc6bc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -307,6 +307,37 @@ _set_nvmet_dhgroup() {
 	     "${cfs_path}/dhchap_dhgroup"
 }
 
+_enable_nvmet_ns() {
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="${1:-1}"
+
+	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
+	ns_path="${cfs_path}/namespaces/${nsid}"
+
+	echo 1 > "${ns_path}/enable"
+}
+
+_disable_nvmet_ns() {
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="${1:-1}"
+
+	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
+	ns_path="${cfs_path}/namespaces/${nsid}"
+
+	echo 0 > "${ns_path}/enable"
+}
+
+_set_nvmet_ns_uuid() {
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="${1:-1}"
+	local uuid="${2:-$(uuidgen)}"
+
+	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
+	ns_path="${cfs_path}/namespaces/${nsid}"
+
+	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+}
+
 _find_nvme_passthru_loop_dev() {
 	local subsys=$1
 	local nsid
-- 
2.47.0


