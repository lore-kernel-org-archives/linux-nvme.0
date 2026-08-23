Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B767C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aigxDDnwzURlijvLDq7lfo2OdrDCXPYsqVZxoniYxnM=; b=kfXA7wiymWrpxftQzUn0oVvGCr
	1mKdJeTogljf6p3vzmlQj/0HSCW5aOGuu94L8sy3gVGH9yv+gMwaez0dL6gB/Gp/uhny4MuI48D1T
	Wu/1bUNy2yDL6FD/fr9XHYYL/SWCQTqb1i3U7csj2T0S4EC84QSFg9EUgk4jV/jQCTagjWqQQQuLR
	6JxxDfDAIYdBtUWineVJyklYVpHZxZtza1UqzCtTwt0KP/ofuS1tDufbzxqPgWZEAi3wyy9kRbLpj
	Av+b2FS9Dg1S7SF6e6YewGZICpZBmJzUAbvU1mplgNwlUwqa8HvEFuqYosibMxYFz2unpC8F3VP1h
	HTswsLbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tM-0000000FBcH-42Ke;
	Sun, 23 Aug 2026 08:49:24 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tH-0000000FBYG-0PSt
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:20 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so4867319a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474957; x=1788079757;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aigxDDnwzURlijvLDq7lfo2OdrDCXPYsqVZxoniYxnM=;
        b=PRS/P8MHIdQEy2Q431WiJchW8aRUSuCr7HuXf6KlxYpEh2VMeVMC6fv5UPnchxhPYq
         zAitDi67AwyrquC6/cVtS8HZHAOUWzQxPHLcWJmqCZwMZjmfdxjz3MbccQmxUef6N44b
         P5cCWpWspd0aLIbRvyhmocog07bocO6SnQMvhvqJZmT0jKz/97QrFHRm65023pWWmnWQ
         e5eagB+EwjQoc78DFNZG8OL/aURvtnO0ciAAy0CnF7q6d62NHYisAuv6ukYmfyjo71Fk
         iHtgtSqcffvhiHUEWHM0uXX2yJZkwuehodoqM8V0uevaW9FW1ubnus+owsEfWpxBGFlg
         Aj3w==
X-Gm-Message-State: AFuF++m+cXFPUrJjxpDWjVM9k+6jsRI8e01EYQjbOnj53lZlS9X5Qt18
	cCs69XVg3mWHnA7Oudv9beIs7X4hPVtiovcQG+JLZmTC8r9ihz71BU+rNAN25A==
X-Gm-Gg: AR+sD13N6BYbokTwxVQ6C2hge80J2LC0aeC/yr5vRE3SfYvWhDk8Md59hJ7ETLWxjE5
	q1WDRMcIidd+9wIbg2cFgrRqAV2TVoCMRO/G6+SoillByvMc5lb/cmx72CylMaG7li2Ok8G3BTy
	sKlxUvevkUYHArr42BYwoSKU8E8qM9gI3oDUi2jgOMuDK+qHPkip3wATw4K4ZSY0x5OYHx7Gx2f
	B0kMxeAwWSFE+6k/CENJpIPaFPdnq3vk8LMJ5CApLYrVnpyi5HwmU3fOZbS8DYCp1uMbG83qm9c
	8jNqqRPXpKMP9t2TYmJSAz/roXEhKlPLkkBJO/3GCxf7mABus6mg5R237Kc2546yD+PDO8n8RTl
	D42oqthsZqql0kXGvWvhIRpCrtwOWpGAYtPKJd7eX0wiIlbaqRQg6se4pdcwlFSSvIHojnPOcZ+
	xgpXLvzgJwcHDY+wPpwBPi6vwyUHXiiqsCep0ouisC3ssX+L7FxCBlzBQaWdaAe/hTK/RIvmMwh
	kTsB5nyO8sYVG/9FuDi4EkhJxjJP2yqEllJxJkEWqThJQBIVvk=
X-Received: by 2002:a05:6402:5406:b0:698:c13e:179a with SMTP id 4fb4d7f45d1cf-6a42f1bcdb3mr20191410a12.10.1787474957105;
        Sun, 23 Aug 2026 01:49:17 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/6 RFC] nvme: test per-command retry delay
Date: Sun, 23 Aug 2026 11:49:03 +0300
Message-ID: <20260823084903.193188-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014919_328285_281F6F2E 
X-CRM114-Status: GOOD (  20.32  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add tests to exercise host command retry delays handling.

070: check that basic command RETRY disposition works and respect ctrl
     crd
071: check that basic command FAILOVER disposition works and respects
     ctrl crd
072: check that different commands completed with different crd levels
     are retried independently, each respecting its paired completion
     crd level
073: check that different commands completed with different crd levels
     are failed-over independently, each respecting its paired completion
     crd level

These tests rely on nvmet support for subsystem crdt attributes
(_require_nvmet_crdt) and nvme host crd error injection support.

In addition we add some common nvme helpers to set nvmet attributes,
inject errors, and leverage nvme diags to count retries/failovers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/nvme        | 281 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070     |  95 +++++++++++++++
 tests/nvme/070.out |   3 +
 tests/nvme/071     | 185 +++++++++++++++++++++++++++++
 tests/nvme/071.out |   3 +
 tests/nvme/072     | 118 +++++++++++++++++++
 tests/nvme/072.out |   8 ++
 tests/nvme/073     | 157 +++++++++++++++++++++++++
 tests/nvme/073.out |   8 ++
 tests/nvme/rc      |  24 +++-
 10 files changed, 881 insertions(+), 1 deletion(-)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

diff --git a/common/nvme b/common/nvme
index f3999378db2d..a224dca61840 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1527,3 +1527,284 @@ _nvme_requires() {
 
 	return 0
 }
+
+_require_nvmet_crdt() {
+	local subsysnqn="${1:-$def_subsysnqn}"
+	local crdt_attr="${NVMET_CFS}/subsystems/${subsysnqn}/attr_crdt1"
+	local tmp="blktests-crdt-probe-$$"
+
+	_have_driver nvmet || return $?
+	_have_configfs || return $?
+
+	if [[ -e "${crdt_attr}" ]]; then
+		return 0
+	fi
+
+	if [[ ! -d "${NVMET_CFS}/subsystems" ]]; then
+		SKIP_REASONS+=("nvmet configfs is not available")
+		return 1
+	fi
+
+	mkdir "${NVMET_CFS}/subsystems/${tmp}" || {
+		SKIP_REASONS+=("unable to create nvmet subsystem for CRDT probe")
+		return 1
+	}
+	if [[ ! -e "${NVMET_CFS}/subsystems/${tmp}/attr_crdt1" ]]; then
+		rmdir "${NVMET_CFS}/subsystems/${tmp}"
+		SKIP_REASONS+=("nvmet does not support attr_crdt1/2/3")
+		return 1
+	fi
+	rmdir "${NVMET_CFS}/subsystems/${tmp}"
+	return 0
+}
+
+# Set Identify Controller CRDT values (units of 100ms). Call before connect.
+_nvmet_set_crdt() {
+	local subsysnqn="${def_subsysnqn}"
+	local crdt1=0
+	local crdt2=0
+	local crdt3=0
+	local cfs
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				crdt1="$1"
+				crdt2="${2:-0}"
+				crdt3="${3:-0}"
+				shift $#
+				;;
+		esac
+	done
+
+	cfs="${NVMET_CFS}/subsystems/${subsysnqn}"
+	_set_attr "${crdt1}" "${cfs}/attr_crdt1"
+	_set_attr "${crdt2}" "${cfs}/attr_crdt2"
+	_set_attr "${crdt3}" "${cfs}/attr_crdt3"
+}
+
+# List hidden multipath path namespaces sharing uuid with head ns.
+_nvme_path_ns_devs() {
+	local head_ns="$1"
+	local uuid
+	local ns
+	local found=0
+
+	uuid="$(cat "/sys/block/${head_ns}/uuid" 2>/dev/null)" || return 1
+
+	shopt -s nullglob
+	for ns in /sys/block/nvme*c*n*; do
+		[[ -e "${ns}/uuid" ]] || continue
+		if [[ "$(cat "${ns}/uuid")" == "${uuid}" ]]; then
+			basename "${ns}"
+			found=1
+		fi
+	done
+	shopt -u nullglob
+
+	# Fallback: controllers may expose path ns under /sys/class/nvme.
+	if (( found == 0 )); then
+		shopt -s nullglob
+		for ns in /sys/class/nvme/nvme*/nvme*c*n*; do
+			[[ -e "${ns}/uuid" ]] || continue
+			if [[ "$(cat "${ns}/uuid")" == "${uuid}" ]]; then
+				basename "${ns}"
+				found=1
+			fi
+		done
+		shopt -u nullglob
+	fi
+
+	(( found == 1 ))
+}
+
+_nvme_ns_diag_path() {
+	local ns="$1"
+	local attr="$2"
+
+	echo "/sys/block/${ns}/diag/${attr}"
+}
+
+_nvme_get_ns_diag() {
+	local path
+
+	path="$(_nvme_ns_diag_path "$1" "$2")"
+	[[ -e "${path}" ]] || { echo 0; return 1; }
+	cat "${path}"
+}
+
+_nvme_set_ns_diag() {
+	local path
+
+	path="$(_nvme_ns_diag_path "$1" "$2")"
+	[[ -e "${path}" ]] || return 1
+	_set_attr "$3" "${path}"
+}
+
+_nvme_sum_path_diag() {
+	local head_ns="$1"
+	local attr="$2"
+	local path_ns
+	local sum=0
+	local val
+
+	while read -r path_ns; do
+		[[ -z "${path_ns}" ]] && continue
+		val="$(_nvme_get_ns_diag "${path_ns}" "${attr}")"
+		sum=$((sum + val))
+	done < <(_nvme_path_ns_devs "${head_ns}")
+	echo "${sum}"
+}
+
+_nvme_reset_path_diag() {
+	local head_ns="$1"
+	local attr="$2"
+	local path_ns
+
+	while read -r path_ns; do
+		[[ -z "${path_ns}" ]] && continue
+		_nvme_set_ns_diag "${path_ns}" "${attr}" 0 || true
+	done < <(_nvme_path_ns_devs "${head_ns}")
+}
+
+# Fault-inject targets for a namespace: path ns devices if multipath, else the ns.
+_nvme_fault_inject_devs() {
+	local ns="$1"
+	local paths
+
+	paths="$(_nvme_path_ns_devs "${ns}")"
+	if [[ -n "${paths}" ]]; then
+		echo "${paths}"
+	else
+		echo "${ns}"
+	fi
+}
+
+# Resolve the nvme controller sysfs/debugfs name for a namespace device.
+_nvme_ctrl_dev_from_ns() {
+	local ns="$1"
+	local ctrl
+
+	if [[ "${ns}" =~ ^nvme[0-9]+c[0-9]+n[0-9]+$ ]]; then
+		ctrl="$(basename "$(readlink -f "/sys/block/${ns}/device")")"
+		echo "${ctrl}"
+		return 0
+	fi
+	echo "${ns%n*}"
+}
+
+_nvme_now_ms() {
+	echo $(($(date +%s%N) / 1000000))
+}
+
+# Arm host fault inject on a namespace/path device.
+# Args: <dev> <dont_retry> <status> <crd> <times> [probability=100] [verbose=1]
+_nvme_arm_crd_inject() {
+	local dev=$1
+	local dont_retry=$2
+	local status=$3
+	local crd=$4
+	local times=$5
+	local probability=${6:-100}
+	local verbose=${7:-1}
+	local fi="/sys/kernel/debug/${dev}/fault_inject"
+
+	if [[ ! -d "${fi}" ]]; then
+		echo "FAIL: missing ${fi}"
+		return 1
+	fi
+	if [[ ! -e "${fi}/crd" ]]; then
+		echo "FAIL: missing ${fi}/crd"
+		return 1
+	fi
+
+	_set_attr "${verbose}" "${fi}/verbose"
+	_set_attr "${dont_retry}" "${fi}/dont_retry"
+	_set_attr "${status}" "${fi}/status"
+	_set_attr "${crd}" "${fi}/crd"
+	_set_attr "${times}" "${fi}/times"
+	_set_attr "${probability}" "${fi}/probability"
+	return 0
+}
+
+_nvme_disarm_crd_inject() {
+	local fi="/sys/kernel/debug/$1/fault_inject"
+
+	[[ -d "${fi}" ]] || return 0
+	_set_attr 0 "${fi}/probability"
+	_set_attr 0 "${fi}/times"
+	_set_attr 0 "${fi}/crd"
+}
+
+# Timed direct write; prints elapsed milliseconds on stdout.
+_nvme_timed_direct_write() {
+	local dev=$1
+	local start end
+
+	start="$(_nvme_now_ms)"
+	dd if=/dev/zero of="${dev}" bs=4k count=1 oflag=direct status=none \
+		conv=notrunc 2>>"$FULL" || return 1
+	end="$(_nvme_now_ms)"
+	echo $((end - start))
+}
+
+# Background timed direct write. Sets nvme_bg_timed_pid (do NOT call from $()).
+# Writes elapsed ms to <result_file>, or FAIL on I/O error.
+_nvme_bg_timed_direct_write() {
+	local dev=$1
+	local result=$2
+
+	rm -f "${result}"
+	(
+		local start end
+		start="$(_nvme_now_ms)"
+		if dd if=/dev/zero of="${dev}" bs=4k count=1 oflag=direct \
+			status=none conv=notrunc 2>>"$FULL"; then
+			end="$(_nvme_now_ms)"
+			echo $((end - start)) >"${result}"
+		else
+			echo FAIL >"${result}"
+		fi
+	) &
+	nvme_bg_timed_pid=$!
+}
+
+# Wait until fault_inject times reaches 0 (inject consumed).
+_nvme_wait_inject_consumed() {
+	local fi="/sys/kernel/debug/$1/fault_inject/times"
+	local timeout_ms=${2:-2000}
+	local start
+
+	[[ -e "${fi}" ]] || return 1
+	start="$(_nvme_now_ms)"
+	while (( $(cat "${fi}") > 0 )); do
+		if (( $(_nvme_now_ms) - start > timeout_ms )); then
+			return 1
+		fi
+		sleep 0.01
+	done
+	return 0
+}
+
+# Validate elapsed ms against an expected CRD delay.
+# Args: <label> <elapsed_ms> <expected_ms> [max_ms=expected*2]
+_nvme_check_crd_elapsed() {
+	local label=$1
+	local elapsed=$2
+	local expected=$3
+	local max_ms=${4:-$((expected * 2))}
+
+	if (( elapsed < expected / 2 )); then
+		echo "FAIL: ${label} too fast (${elapsed}ms), expected ~${expected}ms"
+		return 1
+	fi
+	if (( elapsed >= max_ms )); then
+		echo "FAIL: ${label} too slow (${elapsed}ms), expected ~${expected}ms (max ${max_ms}ms)"
+		return 1
+	fi
+	return 0
+}
diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 000000000000..14d7160664a0
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Sagi Grimberg <sagi@grimberg.me>
+#
+# Test NVMe command retry delay (CRD) with the per-request retry timer.
+# Requires nvmet attr_crdt* and host fault_inject/crd.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe CRD per-request retry under fio"
+QUICK=1
+
+# NVME_SC_INTERNAL
+NVME_SC_INTERNAL=0x6
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
+	_require_nvme_trtype_is_fabrics
+	_require_nvmet_crdt
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+inject_crd_retries() {
+	local -a inject_devs
+	local dev
+	local ctrl
+	local i
+
+	mapfile -t inject_devs < <(_nvme_fault_inject_devs "$1")
+	for ((i = 0; i < 5; i++)); do
+		for dev in "${inject_devs[@]}"; do
+			ctrl="$(_nvme_ctrl_dev_from_ns "${dev}")"
+			_nvme_err_inject_setup "${dev}" "${ctrl}"
+			# verbose=1 probability=100 dont_retry=0 status=INTERNAL crd=1 times=8
+			_nvme_enable_crd_err_inject "${dev}" 1 100 0 \
+				"${NVME_SC_INTERNAL}" 1 8
+		done
+		sleep 1
+		for dev in "${inject_devs[@]}"; do
+			ctrl="$(_nvme_ctrl_dev_from_ns "${dev}")"
+			_nvme_disable_err_inject "${dev}"
+			_nvme_err_inject_cleanup "${dev}" "${ctrl}"
+		done
+		sleep 1
+	done
+}
+
+test() {
+	local fio_pid
+	local ns
+	local retries_before
+	local retries_after
+	local inject_dev
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	_nvmet_target_setup
+	# CRDT1 = 5 * 100ms = 500ms
+	_nvmet_set_crdt 5 0 0
+
+	_nvme_connect_subsys
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
+	inject_dev=$(_nvme_fault_inject_devs "${ns}" | head -1)
+	_nvme_set_ns_diag "${inject_dev}" command_retries_count 0 || true
+	retries_before=$(_nvme_get_ns_diag "${inject_dev}" command_retries_count)
+
+	_run_fio_verify_io --filename="/dev/${ns}" \
+			   --group_reporting --ramp_time=2 \
+			   --time_based --runtime=20 &> "$FULL" &
+	fio_pid=$!
+	sleep 3
+
+	echo "Injecting CRD retries"
+	inject_crd_retries "${ns}"
+
+	wait "${fio_pid}" || echo "FAIL: fio exited with errors (see $FULL)"
+
+	retries_after=$(_nvme_get_ns_diag "${inject_dev}" command_retries_count)
+	if (( retries_after <= retries_before )); then
+		echo "command_retries_count did not increase (${retries_before} -> ${retries_after})"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 000000000000..bf52d7b13a5e
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,3 @@
+Running nvme/070
+Injecting CRD retries
+Test complete
diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 000000000000..897a88302b75
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,185 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Sagi Grimberg <sagi@grimberg.me>
+#
+# Test NVMe multipath failover respects controller CRD. Requires nvmet
+# attr_crdt*, host fault_inject/crd, and nvme_core.multipath=Y.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe CRD multipath failover under fio"
+QUICK=1
+
+# NVME_SC_INTERNAL_PATH_ERROR
+NVME_SC_INTERNAL_PATH_ERROR=0x300
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_have_module_param_value nvme_core multipath Y
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
+	_require_nvme_trtype_is_fabrics
+	_require_nvmet_crdt
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+dump_fault_inject() {
+	local fi="/sys/kernel/debug/$1/fault_inject"
+	local f
+
+	echo "fault_inject $1:" >> "$FULL"
+	if [[ ! -d "${fi}" ]]; then
+		echo "  MISSING ${fi}" >> "$FULL"
+		return
+	fi
+	for f in "${fi}"/*; do
+		echo "  $(basename "$f")=$(cat "$f" 2>/dev/null)" >> "$FULL"
+	done
+}
+
+# Arm path-error+CRD inject on a single path; leave the peer path clean.
+arm_crd_failover_inject() {
+	local dev=$1
+	local fi="/sys/kernel/debug/${dev}/fault_inject"
+	local status_val dnr_val crd_val prob_val
+
+	if [[ ! -d "${fi}" ]]; then
+		echo "FAIL: missing ${fi}"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+	if [[ ! -e "${fi}/crd" ]]; then
+		echo "FAIL: missing ${fi}/crd (rebuild/install nvme-core with CRD fault inject)"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+
+	# Avoid ctrl-side setup: only the path ns debugfs matters for data I/O.
+	# status/dont_retry/crd before probability. verbose=1 logs each injection.
+	_set_attr 1 "${fi}/verbose"
+	_set_attr 0 "${fi}/dont_retry"
+	_set_attr "${NVME_SC_INTERNAL_PATH_ERROR}" "${fi}/status"
+	_set_attr 1 "${fi}/crd"
+	_set_attr 100 "${fi}/times"
+	_set_attr 100 "${fi}/probability"
+
+	status_val="$(cat "${fi}/status")"
+	dnr_val="$(cat "${fi}/dont_retry")"
+	crd_val="$(cat "${fi}/crd")"
+	prob_val="$(cat "${fi}/probability")"
+	{
+		echo "armed ${dev}: status=${status_val} dont_retry=${dnr_val} crd=${crd_val} probability=${prob_val} times=$(cat "${fi}/times")"
+	} >> "$FULL"
+
+	# debugfs x16 prints as 0x0300
+	if [[ "${status_val}" != "0x0300" && "${status_val}" != "0x300" &&
+	      "$((status_val))" -ne "$((NVME_SC_INTERNAL_PATH_ERROR))" ]]; then
+		echo "FAIL: status not set (got ${status_val})"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+	if [[ "${dnr_val}" != "N" && "${dnr_val}" != "0" ]]; then
+		echo "FAIL: dont_retry not cleared (got ${dnr_val})"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+	if [[ "${crd_val}" != "1" ]]; then
+		echo "FAIL: crd not set (got ${crd_val})"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+	if [[ "${prob_val}" != "100" ]]; then
+		echo "FAIL: probability not set (got ${prob_val})"
+		dump_fault_inject "${dev}"
+		return 1
+	fi
+	return 0
+}
+
+disarm_crd_failover_inject() {
+	local fi="/sys/kernel/debug/$1/fault_inject"
+
+	_set_attr 0 "${fi}/probability"
+	_set_attr 0 "${fi}/times"
+	_set_attr 0 "${fi}/crd"
+}
+
+test() {
+	local fio_pid
+	local ns
+	local port
+	local -a ports
+	local -a path_devs
+	local inject_dev
+	local peer_dev
+	local inject_before
+	local inject_after
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	_nvmet_target_setup --ports 2
+	# CRDT1 = 2 * 100ms = 200ms; must be set before connect.
+	_nvmet_set_crdt 2 0 0
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	for port in "${ports[@]}"; do
+		_setup_nvmet_port_ana "${port}" 1 "optimized"
+		_nvme_connect_subsys --port "${port}" --no-wait-ns
+	done
+	sleep 1
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	mapfile -t path_devs < <(_nvme_path_ns_devs "${ns}")
+	if ((${#path_devs[@]} < 2)); then
+		echo "FAIL: need >=2 path namespaces, found ${#path_devs[@]} (${path_devs[*]})"
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	inject_dev=${path_devs[0]}
+	peer_dev=${path_devs[1]}
+	echo "inject=${inject_dev} peer=${peer_dev}" >> "$FULL"
+	dump_fault_inject "${inject_dev}"
+
+	_nvme_set_ns_diag "${inject_dev}" multipath_failover_count 0 || true
+	_nvme_set_ns_diag "${peer_dev}" multipath_failover_count 0 || true
+	inject_before=$(_nvme_get_ns_diag "${inject_dev}" multipath_failover_count)
+
+	# Arm before fio so we know inject is configured; I/O should failover
+	# to the peer path (no EIO if CRD failover works).
+	echo "Injecting CRD failovers"
+	if ! arm_crd_failover_inject "${inject_dev}"; then
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	# Append fio output; do not truncate diagnostics already in $FULL.
+	_run_fio --name=crd-failover --filename="/dev/${ns}" \
+		--rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
+		--iodepth=16 --time_based --runtime=10 \
+		--group_reporting >>"$FULL" 2>&1 &
+	fio_pid=$!
+
+	wait "${fio_pid}" || echo "FAIL: fio exited with errors (see $FULL)"
+
+	disarm_crd_failover_inject "${inject_dev}"
+
+	inject_after=$(_nvme_get_ns_diag "${inject_dev}" multipath_failover_count)
+	echo "failovers ${inject_dev}: ${inject_before} -> ${inject_after}" >> "$FULL"
+	if (( inject_after <= inject_before )); then
+		echo "FAIL: multipath_failover_count on ${inject_dev} did not increase (${inject_before} -> ${inject_after})"
+		dump_fault_inject "${inject_dev}"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 000000000000..2fca7041e467
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,3 @@
+Running nvme/071
+Injecting CRD failovers
+Test complete
diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 000000000000..2acda72cdd44
--- /dev/null
+++ b/tests/nvme/072
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Sagi Grimberg <sagi@grimberg.me>
+#
+# Verify per-request CRD retry timers are independent: arm CRD2 then CRD1 on
+# two overlapping commands to the same namespace (fault_inject only holds one
+# crd at a time, but once latched on a request the timers run concurrently).
+# Each command must complete near its own CRDT, not a shared controller delay.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe CRD per-request retry timer independence"
+QUICK=1
+
+NVME_SC_INTERNAL=0x6
+# CRDT units are 100ms: CRD1=1s, CRD2=10s
+CRDT1=10
+CRDT2=100
+CRD1_MS=$((CRDT1 * 100))
+CRD2_MS=$((CRDT2 * 100))
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
+	_require_nvme_trtype_is_fabrics
+	_require_nvmet_crdt
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	local ns
+	local inject_dev
+	local crd2_pid crd1_pid
+	local crd2_result crd1_result
+	local crd2_elapsed crd1_elapsed
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvmet_set_crdt "${CRDT1}" "${CRDT2}" 0
+
+	_nvme_connect_subsys
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	inject_dev=$(_nvme_fault_inject_devs "${ns}" | head -1)
+
+	echo "ns=${ns} inject=${inject_dev}" >>"$FULL"
+	echo "CRDT CRD1=${CRD1_MS}ms CRD2=${CRD2_MS}ms"
+
+	if [[ ! -e /sys/kernel/debug/${inject_dev}/fault_inject/crd ]]; then
+		echo "FAIL: missing fault_inject/crd on ${inject_dev}"
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	crd2_result="${TMPDIR}/crd2_elapsed"
+	crd1_result="${TMPDIR}/crd1_elapsed"
+
+	echo "Arming CRD2 and starting first write"
+	_nvme_arm_crd_inject "${inject_dev}" 0 "${NVME_SC_INTERNAL}" 2 1 || return 1
+	echo "inject: status=${NVME_SC_INTERNAL} crd=2 times=1" >>"$FULL"
+	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}"
+	crd2_pid=$nvme_bg_timed_pid
+	echo "CRD2 write pid=${crd2_pid}" >>"$FULL"
+
+	if ! _nvme_wait_inject_consumed "${inject_dev}"; then
+		echo "FAIL: CRD2 inject was not consumed"
+		_nvme_disarm_crd_inject "${inject_dev}"
+		kill "${crd2_pid}" 2>/dev/null || true
+		wait "${crd2_pid}" 2>/dev/null || true
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+	echo "CRD2 latched; arming CRD1 while CRD2 retry is pending" >>"$FULL"
+
+	echo "Arming CRD1 and starting second write (CRD2 still pending)"
+	_nvme_arm_crd_inject "${inject_dev}" 0 "${NVME_SC_INTERNAL}" 1 1 || return 1
+	echo "inject: status=${NVME_SC_INTERNAL} crd=1 times=1" >>"$FULL"
+	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}"
+	crd1_pid=$nvme_bg_timed_pid
+	echo "CRD1 write pid=${crd1_pid}" >>"$FULL"
+
+	echo "Waiting for both writes (expect CRD1~${CRD1_MS}ms then CRD2~${CRD2_MS}ms)"
+	wait "${crd1_pid}" || true
+	wait "${crd2_pid}" || true
+	_nvme_disarm_crd_inject "${inject_dev}"
+	udevadm settle >/dev/null 2>&1 || true
+
+	crd1_elapsed="$(cat "${crd1_result}" 2>/dev/null || echo FAIL)"
+	crd2_elapsed="$(cat "${crd2_result}" 2>/dev/null || echo FAIL)"
+	echo "CRD1 write elapsed ${crd1_elapsed}ms (expected ~${CRD1_MS}ms)" >>"$FULL"
+	echo "CRD2 write elapsed ${crd2_elapsed}ms (expected ~${CRD2_MS}ms)" >>"$FULL"
+
+	if [[ "${crd1_elapsed}" == "FAIL" || -z "${crd1_elapsed}" ]]; then
+		echo "FAIL: CRD1 write did not complete"
+	else
+		echo "CRD1 write elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		_nvme_check_crd_elapsed "CRD1 write" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
+	fi
+	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
+		echo "FAIL: CRD2 write did not complete"
+	else
+		echo "CRD2 write elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		_nvme_check_crd_elapsed "CRD2 write" "${crd2_elapsed}" "${CRD2_MS}"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	udevadm settle >/dev/null 2>&1 || true
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/072.out b/tests/nvme/072.out
new file mode 100644
index 000000000000..d9f4520c8d23
--- /dev/null
+++ b/tests/nvme/072.out
@@ -0,0 +1,8 @@
+Running nvme/072
+CRDT CRD1=1000ms CRD2=10000ms
+Arming CRD2 and starting first write
+Arming CRD1 and starting second write (CRD2 still pending)
+Waiting for both writes (expect CRD1~1000ms then CRD2~10000ms)
+CRD1 write elapsed NUMms
+CRD2 write elapsed NUMms
+Test complete
diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 000000000000..34911392437a
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,157 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Sagi Grimberg <sagi@grimberg.me>
+#
+# Verify per-failover CRD timers are independent on the same ns head.
+#
+# path0 stays usable after a path-error+CRD (only current_path is cleared), and
+# with NUMA/default selection the next head I/O typically picks path0 again.
+# So both commands are failed on path0 with different CRDs while their failover
+# timers overlap: CRD2 (~10s) then CRD1 (~1s). path1 is left clean so each
+# request can complete once its own CRDT elapses.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe CRD multipath failover timer independence"
+QUICK=1
+
+NVME_SC_INTERNAL_PATH_ERROR=0x300
+# CRDT units are 100ms: CRD1=1s, CRD2=10s
+CRDT1=10
+CRDT2=100
+CRD1_MS=$((CRDT1 * 100))
+CRD2_MS=$((CRDT2 * 100))
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_have_kernel_options FAULT_INJECTION FAULT_INJECTION_DEBUG_FS
+	_require_nvme_trtype_is_fabrics
+	_require_nvmet_crdt
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	local ns
+	local port
+	local -a ports
+	local -a path_devs
+	local path0
+	local path1
+	local fo_before fo_after
+	local crd2_pid crd1_pid
+	local crd2_result crd1_result
+	local crd2_elapsed crd1_elapsed
+	local sync_start
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	_nvmet_target_setup --ports 2
+	_nvmet_set_crdt "${CRDT1}" "${CRDT2}" 0
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	for port in "${ports[@]}"; do
+		_setup_nvmet_port_ana "${port}" 1 "optimized"
+		_nvme_connect_subsys --port "${port}" --no-wait-ns
+	done
+	sleep 1
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	mapfile -t path_devs < <(_nvme_path_ns_devs "${ns}")
+	if ((${#path_devs[@]} < 2)); then
+		echo "FAIL: need >=2 path namespaces, found ${#path_devs[@]} (${path_devs[*]})"
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	path0=${path_devs[0]}
+	path1=${path_devs[1]}
+	echo "ns=${ns} path0=${path0} path1=${path1}" >>"$FULL"
+	echo "CRDT CRD1=${CRD1_MS}ms CRD2=${CRD2_MS}ms"
+
+	if [[ ! -e /sys/kernel/debug/${path0}/fault_inject/crd ]]; then
+		echo "FAIL: missing fault_inject/crd on ${path0}"
+		_nvme_disconnect_subsys
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	_nvme_set_ns_diag "${path0}" multipath_failover_count 0 || true
+	_nvme_set_ns_diag "${path1}" multipath_failover_count 0 || true
+	fo_before=$(_nvme_get_ns_diag "${path0}" multipath_failover_count)
+
+	crd2_result="${TMPDIR}/crd2_elapsed"
+	crd1_result="${TMPDIR}/crd1_elapsed"
+
+	echo "Arming CRD2 on path0 and starting first write"
+	_nvme_arm_crd_inject "${path0}" 0 "${NVME_SC_INTERNAL_PATH_ERROR}" 2 1 || return 1
+	echo "path0 inject: path_error crd=2 times=1" >>"$FULL"
+	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}"
+	crd2_pid=$nvme_bg_timed_pid
+	echo "CRD2 write pid=${crd2_pid}" >>"$FULL"
+
+	sync_start="$(_nvme_now_ms)"
+	while (( $(_nvme_get_ns_diag "${path0}" multipath_failover_count) <= fo_before )); do
+		if (( $(_nvme_now_ms) - sync_start > 2000 )); then
+			echo "FAIL: CRD2 failover was not scheduled on ${path0}"
+			_nvme_disarm_crd_inject "${path0}"
+			kill "${crd2_pid}" 2>/dev/null || true
+			wait "${crd2_pid}" 2>/dev/null || true
+			_nvme_disconnect_subsys
+			_nvmet_target_cleanup
+			return 1
+		fi
+		sleep 0.01
+	done
+	echo "CRD2 failover pending; path0 still selectable (NUMA/current)" >>"$FULL"
+
+	# Same path again: latch CRD1 while the CRD2 fot is still pending.
+	echo "Arming CRD1 on path0 and starting second write (CRD2 still pending)"
+	_nvme_arm_crd_inject "${path0}" 0 "${NVME_SC_INTERNAL_PATH_ERROR}" 1 1 || return 1
+	echo "path0 inject: path_error crd=1 times=1" >>"$FULL"
+	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}"
+	crd1_pid=$nvme_bg_timed_pid
+	echo "CRD1 write pid=${crd1_pid}" >>"$FULL"
+
+	echo "Waiting for both writes (expect CRD1~${CRD1_MS}ms then CRD2~${CRD2_MS}ms)"
+	wait "${crd1_pid}" || true
+	wait "${crd2_pid}" || true
+	_nvme_disarm_crd_inject "${path0}"
+	udevadm settle >/dev/null 2>&1 || true
+
+	crd1_elapsed="$(cat "${crd1_result}" 2>/dev/null || echo FAIL)"
+	crd2_elapsed="$(cat "${crd2_result}" 2>/dev/null || echo FAIL)"
+	fo_after=$(_nvme_get_ns_diag "${path0}" multipath_failover_count)
+	echo "CRD1 failover elapsed ${crd1_elapsed}ms (expected ~${CRD1_MS}ms)" >>"$FULL"
+	echo "CRD2 failover elapsed ${crd2_elapsed}ms (expected ~${CRD2_MS}ms)" >>"$FULL"
+	echo "path0 failover count ${fo_before} -> ${fo_after}" >>"$FULL"
+
+	if (( fo_after < fo_before + 2 )); then
+		echo "FAIL: expected two failovers on path0, got ${fo_before} -> ${fo_after}"
+	fi
+
+	if [[ "${crd1_elapsed}" == "FAIL" || -z "${crd1_elapsed}" ]]; then
+		echo "FAIL: CRD1 failover write did not complete"
+	else
+		echo "CRD1 failover elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		_nvme_check_crd_elapsed "CRD1 failover" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
+	fi
+	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
+		echo "FAIL: CRD2 failover write did not complete"
+	else
+		echo "CRD2 failover elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		_nvme_check_crd_elapsed "CRD2 failover" "${crd2_elapsed}" "${CRD2_MS}"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	udevadm settle >/dev/null 2>&1 || true
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 000000000000..e771abb14874
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,8 @@
+Running nvme/073
+CRDT CRD1=1000ms CRD2=10000ms
+Arming CRD2 on path0 and starting first write
+Arming CRD1 on path0 and starting second write (CRD2 still pending)
+Waiting for both writes (expect CRD1~1000ms then CRD2~10000ms)
+CRD1 failover elapsed NUMms
+CRD2 failover elapsed NUMms
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 31a0fc59ff4b..f286d9a95cce 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -505,17 +505,39 @@ _nvme_err_inject_cleanup()
 
 _nvme_enable_err_inject()
 {
+	# Set status/dont_retry[/crd] before arming probability/times so concurrent
+	# I/O cannot observe the debugfs defaults (INVALID_OPCODE + DNR).
         _set_attr "$2" /sys/kernel/debug/"$1"/fault_inject/verbose
-        _set_attr "$3" /sys/kernel/debug/"$1"/fault_inject/probability
         _set_attr "$4" /sys/kernel/debug/"$1"/fault_inject/dont_retry
         _set_attr "$5" /sys/kernel/debug/"$1"/fault_inject/status
+	if [[ -n "${7:-}" && -e /sys/kernel/debug/"$1"/fault_inject/crd ]]; then
+		_set_attr "$7" /sys/kernel/debug/"$1"/fault_inject/crd
+	fi
         _set_attr "$6" /sys/kernel/debug/"$1"/fault_inject/times
+        _set_attr "$3" /sys/kernel/debug/"$1"/fault_inject/probability
+}
+
+# Enable fault injection with a Command Retry Delay (CRD) level (1-3).
+# Args: <dev> <verbose> <probability> <dont_retry> <status> <crd> <times>
+_nvme_enable_crd_err_inject()
+{
+	local crd_file="/sys/kernel/debug/$1/fault_inject/crd"
+
+	if [[ ! -e "${crd_file}" ]]; then
+		echo "FAIL: fault_inject crd attribute missing on $1"
+		return 1
+	fi
+	# Map to _nvme_enable_err_inject args: times then crd.
+	_nvme_enable_err_inject "$1" "$2" "$3" "$4" "$5" "$7" "$6"
 }
 
 _nvme_disable_err_inject()
 {
         _set_attr 0 /sys/kernel/debug/"$1"/fault_inject/probability
         _set_attr 0 /sys/kernel/debug/"$1"/fault_inject/times
+	if [[ -e /sys/kernel/debug/"$1"/fault_inject/crd ]]; then
+		_set_attr 0 /sys/kernel/debug/"$1"/fault_inject/crd
+	fi
 }
 
 _nvme_enable_passthru_admin_error_logging()
-- 
2.43.0


