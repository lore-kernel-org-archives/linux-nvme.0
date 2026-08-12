Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B05C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1sNqoJcFRKMIplTh79AgFKomYIVvTDNtx5NTb2ndos=; b=hDkodhRCIwr+yVgbZiQjjsNz64
	H4b2T1meT3BhiHUjnOv7PNhZdjfYUaoCJvExnxZRy6OJ/379cnFQAA8xTqfmSFXV6k7xZsElm9Rfv
	A1S3W4aGIx6RaONrVKFKzMop7qYaYR15ZE6HjIvouZdAL8DxyY4FtkXswZ1Bgkhh6b6nk1A+a7oAC
	/DCslGVSl5aBHhPr5qiF1+FxKbjtMnEMmjKMYsdlTS7mPnP0qKkJcpspksXLcvDlPWV58UCoMyGEK
	qQf90OmqN3Jb6kzfXuBRrYn16JrWXrzBk9lV+KpuuToaL/dRLVBHqj2jdbI/8FgQgd91a7Nx6yn7x
	fJr0MVSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD11-0000000GidF-0CuI;
	Wed, 12 Aug 2026 17:45:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD0w-0000000Gibw-37zV
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 17:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786556717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1sNqoJcFRKMIplTh79AgFKomYIVvTDNtx5NTb2ndos=;
	b=hCPuNMKTYCkIH8GHaa2cOog+vR7P0DN7HBokd1OQ2dppJ7WklmRGXQZk4CsOttDOnEZ5B9
	zyl5AF4+XVoXeP7HL92/XPpeua0zLfFBJnNIVLCO1hH+1nx9bofS7wlFQCZZjIsrKoeA28
	nyj+dVWaHq/pDy89wPqV+PYcOR9LYrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-CJZj9yapM4ScJY888vyHGA-1; Wed,
 12 Aug 2026 13:45:13 -0400
X-MC-Unique: CJZj9yapM4ScJY888vyHGA-1
X-Mimecast-MFC-AGG-ID: CJZj9yapM4ScJY888vyHGA_1786556712
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A80831800578;
	Wed, 12 Aug 2026 17:45:12 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25E8D195DF98;
	Wed, 12 Aug 2026 17:45:10 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH blktests 2/2] nvme/070: Test multipath and marginal ports
Date: Wed, 12 Aug 2026 13:45:03 -0400
Message-ID: <20260812174503.3705830-3-jtaubepe@redhat.com>
In-Reply-To: <20260812174503.3705830-1-jtaubepe@redhat.com>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: rS5z78hdFS08GxYbvcjc2B1jHXTVkjz_SbbzBue0HDo_1786556712
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_104519_668518_EF0FD91A 
X-CRM114-Status: GOOD (  20.67  )
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

Add tests/nvme/070 to test various multipath and marginal port
scenarios, while confirming the port useage and state. This test is
intended to emulate receiving an FPIN event in a multipath environment.

Suggested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
 tests/nvme/070     | 521 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  43 ++++
 2 files changed, 564 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 0000000..a8002f8
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,521 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 John Meneghini <jmeneghi@redhat.com>
+#
+# Test nvme-fc marginal path handling with fcloop
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme-fc marginal path handling"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype fc
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+_subsys_rport_addr() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	cat "$RPORT"/address
+	# traddr=nn-0x2047d039ea98949e:pn-0x2048d039ea98949e,host_traddr=nn-0x200000109b9b7e4e:pn-0x100000109b9b7e4e
+}
+
+_subsys_get_port() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local port
+	local address
+
+	address=$(_subsys_rport_addr "$RPORT")
+	port=$(echo "$address" | sed -n 's/.*pn-\(.*\),.*/\1/p')
+	echo $(( port - $(_remote_wwpn 0) ))
+	# a number representing the port number, e.g. 0, 1, 2, 3
+}
+
+_rport_set_iopolicy() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local POLICY=$2 # numa queue-depth round-robin
+
+	echo "$POLICY" | sudo tee "$RPORT"/iopolicy > /dev/null
+	# Returns none
+}
+
+_rport_set_marginal() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	_setup_nvmet_port_marginal "$(_subsys_get_port "$RPORT")" "marginal"
+}
+
+_rport_set_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	_setup_nvmet_port_marginal "$(_subsys_get_port "$RPORT")" "live"
+}
+
+_rport_is_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	[[ "$(cat "$RPORT"/state)" == "live" ]]
+	# Returns Success or Fail
+}
+
+_rport_is_marginal() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	[[ "$(cat "$RPORT"/state)" == "marginal" ]]
+	# Returns Success or Fail
+}
+
+_rport_in_use() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1" afaik
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/stat | awk '{print $9}')" != "0" ]]
+	# Returns exit code 0 if in use, 1 if not in use
+}
+
+_rport_optimized() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1" afaik
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/ana_state)" == "optimized" ]]
+	# Returns exit code 0 if optimized, 1 if not optimized
+}
+
+# check if link is marginal or not
+_rport_check_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+
+	if [[ "$STATE" == "Online" ]]; then
+		if ! _rport_is_online "$RPORT"; then
+			echo  FC port \("$RPORT"\) is not online, expteced online.
+			return 1
+		fi
+	else
+		if ! _rport_is_marginal "$RPORT"; then
+			echo FC port \("$RPORT"\) is not marginal, expteced marginal.
+			return 1
+		fi
+	fi
+	# Returns Success or Fail
+}
+
+# check if link is in use
+_rport_check_use() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+
+	if [[ "$STATE" == "Online" ]]; then
+		if ! _rport_in_use "$RPORT" ; then
+			echo FC port on \("$RPORT"\) is not being used, expected use.
+			return 1
+		fi
+	else
+		if _rport_in_use "$RPORT" ; then
+			echo FC port on \("$RPORT"\) is being used, expected no use.
+			return 1
+		fi
+	fi
+	# Returns Success or Fail
+}
+
+# check if all link is in state and use state if optimized
+_rport_check_opt() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+
+	_rport_check_online "$RPORT" "$STATE"
+	# Only optimized paths will be in use
+	if _rport_optimized "$RPORT"; then
+		_rport_check_use "$RPORT" "$STATE"
+	else
+		_rport_check_use "$RPORT" Marginal
+	fi
+	# Returns Success or Fail
+}
+
+# check if all link is in state and use state
+_rport_check() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+
+	_rport_check_online "$RPORT" "$STATE"
+	_rport_check_use "$RPORT" "$STATE"
+	# Returns Success or Fail
+}
+
+# Check if one of the marginal paths is in use
+_rport_check_one_use_online() {
+	local RPORTS_PATHS=("$@") #  /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Check if one of the online paths is in use
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		# If path is Marginal, continue to the next path
+		_rport_check_online "$subsys_path" Online || continue
+		# One of the online paths should be in use
+		# "!" inverts the return code, so returns false if path is in use,
+		# running the return statement
+		! _rport_in_use "$subsys_path" || return 0
+	done
+
+	echo No FC ports are being used, expected atleast one in use when all are online in numa mode.
+	# None of the online paths were in use
+	return 1
+
+	# Returns Success or Fail
+}
+
+test_set_all_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_set_online "$subsys_path" || return 1
+		_rport_check_online "$subsys_path" Online || return 1
+	done
+
+	if [ "$IOPOLICY" == "numa" ]; then
+		_rport_check_one_use_online "${RPORTS_PATHS[@]}" || return 1
+	else
+		for subsys_path in "${RPORTS_PATHS[@]}"; do
+			# Only optimized paths will be in use
+			_rport_check_opt "$subsys_path" Online || return 1
+		done
+	fi
+}
+
+test_set_one_host_marginal() {
+	local HOST=$1 # host1
+	shift
+	local ARGS=("$@")
+	local RPORTS_CNT="$(( $# / 2 ))"
+	local PATHS_POS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local HOSTS_POS # host1 host2
+
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS="$(( RPORTS_CNT + PATHS_POS ))"
+		if [[ "${ARGS[$HOSTS_POS]}" == "$HOST" ]]; then
+			_rport_set_marginal "${ARGS[$PATHS_POS]}" || return 1
+		fi
+	done
+
+	# check if all links are of expected state on hosts
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS="$(( RPORTS_CNT + PATHS_POS ))"
+		if [[ "${ARGS[$HOSTS_POS]}" == "$HOST" ]]; then
+			_rport_check_opt "${ARGS[$PATHS_POS]}" "Marginal" || return 1
+		else
+			_rport_check_opt "${ARGS[$PATHS_POS]}" "Online" || return 1
+		fi
+	done
+}
+
+
+# Check if one of the marginal paths is in use
+_rport_check_one_use_marginal() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Check if one of the marginal paths is in use
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_check_online "$subsys_path" Marginal
+		# One of the marginal paths should be in use
+		# "!" inverts the return code, so returns false if path is in use,
+		# running the return statement
+		! _rport_in_use "$subsys_path" || return 0
+	done
+
+	echo No FC ports are being used, expected one in use when all are marginal.
+	# None of the marginal paths were in use
+	return 1
+
+	# Returns Success or Fail
+}
+
+test_set_all_marginal() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_set_marginal "$subsys_path" || return 1
+	done
+
+	_rport_check_one_use_marginal "${RPORTS_PATHS[@]}"
+}
+
+test_set_one_non_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one non-optimized online
+	# First set one non-optimized online to online then check optimized paths
+	local next_marginal=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if ! _rport_optimized "$subsys_path"; then
+			if [ $next_marginal == 1 ]; then
+				_rport_check "$subsys_path" Marginal || return 1
+				break
+			fi
+			_rport_set_online "$subsys_path" || return 1
+			_rport_check "$subsys_path" Online || return 1
+			next_marginal=1
+		fi
+	done
+	# Check optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_optimized "$subsys_path"; then
+			# Optimized paths will not be in use
+			_rport_check_opt "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+test_set_all_non_optimized_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set all non-optimized online
+	local numa_in_use=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_optimized "$subsys_path"; then
+			_rport_check "$subsys_path" Marginal || return 1
+		else
+			_rport_set_online "$subsys_path" || return 1
+			if [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 0 ]; then
+				_rport_check "$subsys_path" Online || return 1
+				numa_in_use=1
+			elif [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 1 ]; then
+				_rport_check_online "$subsys_path" Online || return 1
+				# Only one of the online paths should be in use
+				_rport_check_use "$subsys_path" Marginal || return 1
+			else
+				_rport_check "$subsys_path" Online || return 1
+			fi
+		fi
+	done
+}
+
+set_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	local next_marginal=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_optimized "$subsys_path"; then
+			if [ $next_marginal == 1 ]; then
+				_rport_check "$subsys_path" Marginal || return 1
+				break
+			fi
+			_rport_set_online "$subsys_path" || return 1
+			_rport_check "$subsys_path" Online || return 1
+			next_marginal=1
+		fi
+	done
+}
+
+test_set_all_non_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	# First set one optimized online to online then check non-optimized paths
+	set_one_optimized_online "${RPORTS_PATHS[@]}" || return 1
+
+	# Check non-optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if ! _rport_optimized "$subsys_path"; then
+			# Only optimized paths will be in use
+			_rport_check_opt "$subsys_path" Online || return 1
+		fi
+	done
+}
+
+test_set_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	# First set one optimized online to online then check non-optimized paths
+	set_one_optimized_online "${RPORTS_PATHS[@]}" || return 1
+
+	# Check non-optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if ! _rport_optimized "$subsys_path"; then
+			# Only optimized paths will be in use
+			_rport_check_opt "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+test_set_two_optimized_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@")
+
+	# Set two optimized online
+	local numa_in_use=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_optimized "$subsys_path"; then
+			_rport_set_online "$subsys_path" || return 1
+			if [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 0 ]; then
+				_rport_check "$subsys_path" Online || return 1
+				numa_in_use=1
+			elif [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 1 ]; then
+				_rport_check_online "$subsys_path" Online || return 1
+				# Only one of the online paths should be in use
+				_rport_check_use "$subsys_path" Marginal || return 1
+			else
+				_rport_check "$subsys_path" Online || return 1
+			fi
+		else
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+run_test() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local ARGS=("$@")
+	local RPORTS_CNT="$(( $# / 2 ))"
+	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -a RPORTS_HOSTS # host1 host2
+	local PATHS_POS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local HOSTS_POS # host1 host2
+
+	# recrate the arrays
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS+="$(( RPORTS_CNT + PATHS_POS ))"
+		RPORTS_PATHS+=("${ARGS[$PATHS_POS]}")
+		RPORTS_HOSTS+=("${ARGS[$HOSTS_POS]}")
+	done
+
+
+	echo Changing FC links to online
+	# Initial check to see if FC is operational and set ports to online
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Set all online: pass" || echo "Set all online: fail"
+
+	test_set_one_host_marginal "${RPORTS_HOSTS[0]}" "${RPORTS_PATHS[@]}" "${RPORTS_HOSTS[@]}" && echo "One host marginal: pass" || echo "One host marginal: fail"
+	test_set_all_marginal "${RPORTS_PATHS[@]}" && echo "All marginal: pass" || echo "All marginal: fail"
+
+	test_set_one_non_optimized_online "${RPORTS_PATHS[@]}" && echo "One remote non-optimized online: pass" || echo "One remote non-optimized online: fail"
+	test_set_all_non_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Two remote non-optimized online: pass" || echo "Two remote non-optimized online: fail"
+
+	test_set_all_non_one_optimized_online "${RPORTS_PATHS[@]}" && echo "Two remote non-optimized, One remote optimized: pass" || echo "Two remote non-optimized, One remote optimized: fail"
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Set all online: pass" || echo "Set all online: fail"
+
+	test_set_all_marginal "${RPORTS_PATHS[@]}" && echo "All marginal: pass" || echo "All marginal: fail"
+
+	test_set_one_optimized_online "${RPORTS_PATHS[@]}" && echo "One remote optimized online: pass" || echo "One remote optimized online: fail"
+	test_set_two_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "Two remote optimized online: pass" || echo "Two remote optimized online: fail"
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" && echo "All online: pass" || echo "All online: fail"
+}
+
+_nvmet_get_rport() {
+	local PORT="$1"
+
+	local dev
+	for dev in /sys/class/nvme/nvme*; do
+		grep -q "io" "$dev/cntrltype" || continue
+		[ -e "$dev" ] || continue
+		dev="$(basename "$dev")"
+		grep -q traddr="$(_fc_traddr "$PORT")" "/sys/class/nvme/$dev/address" && echo "$dev" || true
+	done
+	# nvme9
+}
+
+run_tests() {
+	local SUBSYS_PATH="$1"
+	shift
+	local PORTS=("$@")
+	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -a RPORTS_HOSTS # host1 host2
+	local rport
+
+	for port in "${PORTS[@]}"; do
+		RPORTS_HOSTS+=("$(_get_fc_host_port "$port")")
+		rport="$(_nvmet_get_rport "$port")"
+		if [ -z "$rport" ]; then
+			echo "Could not find rport for port $port"
+			return 1
+		fi
+		if [[ "$( echo "$rport" | sed -n '$=' )" -gt 1 ]]; then
+			# One traddr has multiple /sys/class/nvme/nvme devices
+			echo "Port $port has multiple rports with address"
+			grep  traddr="$(_fc_traddr "$port")" /sys/class/nvme/nvme*/address
+			return 1
+		fi
+		RPORTS_PATHS+=( "${SUBSYS_PATH}/$rport")
+	done
+
+	local IOPOLICYS="numa queue-depth round-robin"
+	for IOPOLICY in $IOPOLICYS; do
+		_rport_set_iopolicy "$SUBSYS_PATH" "$IOPOLICY"
+		echo "Testing iopolicy: $IOPOLICY"
+		run_test "$IOPOLICY" "${RPORTS_PATHS[@]}" "${RPORTS_HOSTS[@]}"
+	done
+}
+
+_find_nvme_subsys() {
+	local subsys=$1
+	local subsysnqn
+	local subsys_path
+	for subsys_path in /sys/class/nvme-subsystem/nvme-subsys*; do
+		[ -e "$subsys_path" ] || continue
+		subsysnqn="$(cat "${subsys_path}/subsysnqn" 2>/dev/null)"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
+			echo "$subsys_path"
+			return
+		fi
+	done
+}
+
+test() {
+	local -a ports
+	local ns
+	local fio_pid
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet 2
+
+	_nvmet_target_setup --ports 2
+	_nvmet_target_add_ports --host_port 1 --ports 2
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+
+	for port in "${ports[@]}"; do
+		if [[ $(_get_fc_host_port "${port}") == 0 ]]; then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+		else
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+		fi
+	done
+
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}" --no-wait-ns || return 1
+	done
+
+	# start fio job
+	ns=$(_find_nvme_ns "$def_subsys_uuid")
+	echo "Starting background I/O"
+	_run_fio_verify_io --filename="/dev/${ns}" \
+			   --group_reporting --ramp_time=5 \
+			   --time_based --runtime=1m &> "$FULL" &
+	fio_pid=$!
+	sleep 10
+
+	run_tests "$(_find_nvme_subsys "${def_subsysnqn}")" "${ports[@]}"
+
+	# Stop background I/O
+	echo "Stopping background I/O"
+	{ kill "$fio_pid"; wait; } &> /dev/null
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 0000000..61d5173
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,43 @@
+Running nvme/070
+Starting background I/O
+Testing iopolicy: numa
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Testing iopolicy: queue-depth
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Testing iopolicy: round-robin
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Stopping background I/O
+Test complete
-- 
2.54.0


