Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED275C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:01:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94216023F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B94216023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JzEGon5MhvNPIoG9OWyol0lsp5nreb0vMurveG5fPs=; b=Dl17fhgFo3En2ybfqHKAyc4+aD
	WE/+5lNdBQIMf38s0tJHmt4VMhc5R2FvxrD0LRM0Mtt4IFJklTkQs3V7BhmKuh7R22dLCxsW/2sji
	92uK0JEG2Tm6Ygszb4ObZCeaQanwp5FWA25Wf+wxxbscPafizoDBiujsTX11+eAZNWoN1V6I6jhhk
	SmR3f0Ftrhy6EVUBJR3TTOnYkpb/OqIqC3j6jItFc1OyZw27MztdF17XcG1Sl8hNwUGAa3jcW4NpK
	wtjXmgDEP1M0ijvoPp0mf7/qO6qaSaNM7NPDQo92z9iL4EII2CnOfy9gzgQ4EBEMW9DjOic8r7A+u
	kXgq19Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY37-00AxX7-IS; Fri, 12 Nov 2021 15:01:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN3-Fi
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 994C62198A;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JzEGon5MhvNPIoG9OWyol0lsp5nreb0vMurveG5fPs=;
 b=wf7sbgnOs//VWOMre5lzIBKjYZncpVAPMj/1eCcq1I0ZzZsf9GNXdaNqSCaqrRFN3wubyB
 SW5y9fvSPbTNMT3TYeh65RXODZa81uYAyQszhT//LcNZkhz5O13sCQrbGwDrjKtTcUGIbH
 tT0vJhWdW+AS4hs76NKfkyN+vPDPVX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JzEGon5MhvNPIoG9OWyol0lsp5nreb0vMurveG5fPs=;
 b=phHvM+R5A7bflmsbj5ODEXd1t1uBdFtz5oj+PPogMOgjchrJE3qq2wO4TDMa8TQ+NAK0Rp
 F+Apr7czF6P35yDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5C7AEA3B8D;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5024A5191281; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
Date: Fri, 12 Nov 2021 15:45:05 +0100
Message-Id: <20211112144510.98523-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_790253_84BD191B 
X-CRM114-Status: GOOD (  18.44  )
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
 tests/nvmeof-tcp/001     |  55 +++++++
 tests/nvmeof-tcp/001.out |   6 +
 tests/nvmeof-tcp/rc      | 347 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 tests/nvmeof-tcp/001
 create mode 100644 tests/nvmeof-tcp/001.out
 create mode 100644 tests/nvmeof-tcp/rc

diff --git a/tests/nvmeof-tcp/001 b/tests/nvmeof-tcp/001
new file mode 100644
index 0000000..39f4108
--- /dev/null
+++ b/tests/nvmeof-tcp/001
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp connection
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Create single TCP connection via localhost"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_modules loop
+	_require_nvme_trtype_is_fabrics
+}
+
+
+test() {
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 512M "${scratch}"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "${subsys}1" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+	_create_nvmet_host "${subsys}1" "${hostnqn}"
+
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvme list-subsys
+
+	nvme disconnect -n "${subsys}1"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
+	_remove_nvmet_subsystem "${subsys}1"
+
+	_remove_nvmet_port "${port}"
+
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvmeof-tcp/001.out b/tests/nvmeof-tcp/001.out
new file mode 100644
index 0000000..1eae834
--- /dev/null
+++ b/tests/nvmeof-tcp/001.out
@@ -0,0 +1,6 @@
+Running nvmeof-tcp/001
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live 
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
diff --git a/tests/nvmeof-tcp/rc b/tests/nvmeof-tcp/rc
new file mode 100644
index 0000000..9ae0899
--- /dev/null
+++ b/tests/nvmeof-tcp/rc
@@ -0,0 +1,347 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Johannes Thumshirn
+#
+# Test specific to NVMe devices
+
+. common/rc
+
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
+nvme_trtype=${nvme_trtype:-"tcp"}
+
+_nvme_requires() {
+	_have_program nvme
+	case ${nvme_trtype} in
+	loop)
+		_have_modules nvmet nvme-core nvme-loop
+		_have_configfs
+		;;
+	pci)
+		_have_modules nvme nvme-core
+		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
+	rdma)
+		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
+		_have_configfs
+		_have_program rdma
+		_have_modules rdma_rxe || _have_modules siw
+		;;
+	*)
+		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
+		return 1
+	esac
+	return 0
+}
+
+group_requires() {
+	_have_root
+}
+
+group_device_requires() {
+	_require_test_dev_is_nvme
+}
+
+NVMET_CFS="/sys/kernel/config/nvmet/"
+
+_require_test_dev_is_nvme() {
+	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+		SKIP_REASON="$TEST_DEV is not a NVMe device"
+		return 1
+	fi
+	return 0
+}
+
+_require_nvme_trtype_is_loop() {
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
+_require_nvme_trtype_is_fabrics() {
+	if [[ "${nvme_trtype}" == "pci" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_nvme_ctrl() {
+	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
+}
+
+_test_dev_nvme_nsid() {
+	cat "${TEST_DEV_SYSFS}/nsid"
+}
+
+_cleanup_nvmet() {
+	local dev
+	local port
+	local subsys
+	local transport
+	local name
+
+	if [[ ! -d "${NVMET_CFS}" ]]; then
+		return 0
+	fi
+
+	# Don't let successive Ctrl-Cs interrupt the cleanup processes
+	trap '' SIGINT
+
+	shopt -s nullglob
+
+	for dev in /sys/class/nvme/nvme*; do
+		dev="$(basename "$dev")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
+			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			_nvme_disconnect_ctrl "${dev}"
+		fi
+	done
+
+	for port in "${NVMET_CFS}"/ports/*; do
+		name=$(basename "${port}")
+		echo "WARNING: Test did not clean up port: ${name}"
+		rm -f "${port}"/subsystems/*
+		rmdir "${port}"
+	done
+
+	for subsys in "${NVMET_CFS}"/subsystems/*; do
+		name=$(basename "${subsys}")
+		echo "WARNING: Test did not clean up subsystem: ${name}"
+		for ns in "${subsys}"/namespaces/*; do
+			rmdir "${ns}"
+		done
+		rmdir "${subsys}"
+	done
+
+	shopt -u nullglob
+	trap SIGINT
+
+	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
+	fi
+	modprobe -r nvmet 2>/dev/null
+}
+
+_setup_nvmet() {
+	_register_test_cleanup _cleanup_nvmet
+	modprobe nvmet
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe nvmet-"${nvme_trtype}"
+	fi
+	modprobe nvme-"${nvme_trtype}"
+}
+
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect -d "${ctrl}"
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$1"
+
+	nvme disconnect -n "${subsysnqn}"
+}
+
+_nvme_connect_subsys() {
+	local trtype="$1"
+	local subsysnqn="$2"
+	local traddr="${3:-$def_traddr}"
+	local trsvcid="${4:-$def_trsvcid}"
+
+	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
+	nvme connect "${ARGS[@]}"
+}
+
+_nvme_discover() {
+	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local trsvcid="${3:-$def_trsvcid}"
+
+	ARGS=(-t "${trtype}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
+	nvme discover "${ARGS[@]}"
+}
+
+_create_nvmet_port() {
+	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
+
+	local port
+	for ((port = 0; ; port++)); do
+		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
+			break
+		fi
+	done
+
+	mkdir "${NVMET_CFS}/ports/${port}"
+	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
+
+	echo "${port}"
+}
+
+_remove_nvmet_port() {
+	local port="$1"
+	rmdir "${NVMET_CFS}/ports/${port}"
+}
+
+_create_nvmet_ns() {
+	local nvmet_subsystem="$1"
+	local nsid="$2"
+	local blkdev="$3"
+	local uuid="00000000-0000-0000-0000-000000000000"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local ns_path="${subsys_path}/namespaces/${nsid}"
+
+	if [[ $# -eq 4 ]]; then
+		uuid="$4"
+	fi
+
+	mkdir "${ns_path}"
+	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	printf 1 > "${ns_path}/enable"
+}
+
+_create_nvmet_subsystem() {
+	local nvmet_subsystem="$1"
+	local blkdev="$2"
+	local uuid=$3
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	mkdir -p "${cfs_path}"
+	echo 1 > "${cfs_path}/attr_allow_any_host"
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+}
+
+_create_nvmet_host() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local nvmet_hostkey="$3"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	mkdir "${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+	if [ "$nvmet_hostkey" ] ; then
+		echo "${nvmet_hostkey}" > \
+		     "${NVMET_CFS}/hosts/${nvmet_hostnqn}/dhchap_key"
+	fi
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+	ln -s "${NVMET_CFS}/hosts/${nvmet_hostnqn}" \
+	   "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
+_set_nvmet_hostkey() {
+	local nvmet_hostnqn="$1"
+	local nvmet_hostkey="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_hostkey}" > \
+	     "${cfs_path}/dhchap_key"
+}
+
+_set_nvmet_ctrlkey() {
+	local nvmet_hostnqn="$1"
+	local nvmet_ctrlkey="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_ctrlkey}" > \
+	     "${cfs_path}/dhchap_ctrl_key"
+}
+
+_set_nvmet_hash() {
+	local nvmet_hostnqn="$1"
+	local nvmet_hash="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_hash}" > \
+	     "${cfs_path}/dhchap_hash"
+}
+
+_set_nvmet_dhgroup() {
+	local nvmet_hostnqn="$1"
+	local nvmet_dhgroup="$2"
+	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	echo "${nvmet_dhgroup}" > \
+	     "${cfs_path}/dhchap_dhgroup"
+}
+
+_remove_nvmet_ns() {
+	local nvmet_subsystem="$1"
+	local nsid=$2
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
+
+	echo 0 > "${nvmet_ns_path}/enable"
+	rmdir "${nvmet_ns_path}"
+}
+
+_remove_nvmet_subsystem() {
+	local nvmet_subsystem="$1"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rm "${subsys_path}"/allowed_hosts/*
+	rmdir "${subsys_path}"
+}
+
+_remove_nvmet_host() {
+	local nvmet_host="$1"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
+
+	rmdir "${host_path}"
+}
+	
+_add_nvmet_subsys_to_port() {
+	local port="$1"
+	local nvmet_subsystem="$2"
+
+	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
+		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
+}
+
+_remove_nvmet_subsystem_from_port() {
+	local port="$1"
+	local nvmet_subsystem="$2"
+
+	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
+}
+
+_find_nvme_dev() {
+	local subsys=$1
+	local subsysnqn
+	local dev
+	for dev in /sys/class/nvme/nvme*; do
+		dev="$(basename "$dev")"
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
+			echo "$dev"
+			for ((i = 0; i < 10; i++)); do
+				if [[ -e /sys/block/$dev/uuid &&
+					-e /sys/block/$dev/wwid ]]; then
+					return
+				fi
+				sleep .1
+			done
+		fi
+	done
+}
-- 
2.26.2


