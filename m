Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2C606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ibe7ymjH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1L5lp3Gq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xgGegUGg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1L5lp3Gq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xgGegUGg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cZ1LBDIOP0P+1lRU8+2lVu6ApClHf3rwFHj9w0fEp3Q=; b=ibe7ymjHRZXgRK
	m57G8mUIW/6q0PsYOWBBu0QnB0vVwip1PXXXT3DPYH54S9mkjZ64YaQqLkqK7/GRFW0TFSRUXFGGI
	g/c5sEBZs2Nk7XU9Bk01SRli3POH71BjnxHfWI7tx/7DD53DsAL+SDF4I+Li0No7gjYYGFRMJmuor
	faVdH8/oUDR318QMEsxOSvUDt/W+c0cvZHQqEtOWnFmYVN2/p6k6SKp7ZX7qCGxzeznhLZHSXr2lS
	925lisj0BdN3G4+jBWgageB4Q2qvmc2hxwUn+zGaberz7/e1Z9XlFMumHiG41QT+/RIzz8uPaSjHM
	TE4qcnsjCtw0lt9RKt6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwU-00000008Lp5-2bmh;
	Wed, 18 Nov 2026 09:27:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwQ-00000008Lhd-22ak
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 09:27:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D634F1F387;
	Wed, 18 Nov 2026 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ1LBDIOP0P+1lRU8+2lVu6ApClHf3rwFHj9w0fEp3Q=;
	b=1L5lp3GqbXY9b7zHtA8yGjePTorttSX2jiyUkRlRqtIZ8XzHqSsP6bKEeaGAC3yQPkt1lH
	GYeIMoaJseM/pxoGy2if1loVwDYOVIc0m2hesR8AzSCAWZg+hZjPFVL8I4QHdW79I8AlWx
	oltW+fV5TrpWCBzdQU+Wq1rVj4swJns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ1LBDIOP0P+1lRU8+2lVu6ApClHf3rwFHj9w0fEp3Q=;
	b=xgGegUGgXfFgqaPyQuZrdvJ7A9ARFeS59b7df4pfFMVFzJ3rQeBrYmzSzoJQMwZTb2e9Z3
	BNK2D45NXfFSWtCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ1LBDIOP0P+1lRU8+2lVu6ApClHf3rwFHj9w0fEp3Q=;
	b=1L5lp3GqbXY9b7zHtA8yGjePTorttSX2jiyUkRlRqtIZ8XzHqSsP6bKEeaGAC3yQPkt1lH
	GYeIMoaJseM/pxoGy2if1loVwDYOVIc0m2hesR8AzSCAWZg+hZjPFVL8I4QHdW79I8AlWx
	oltW+fV5TrpWCBzdQU+Wq1rVj4swJns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ1LBDIOP0P+1lRU8+2lVu6ApClHf3rwFHj9w0fEp3Q=;
	b=xgGegUGgXfFgqaPyQuZrdvJ7A9ARFeS59b7df4pfFMVFzJ3rQeBrYmzSzoJQMwZTb2e9Z3
	BNK2D45NXfFSWtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 904701334C;
	Wed, 18 Nov 2026 09:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jOHiFWBv/WpRfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:56 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:45 +0100
Subject: [PATCH blktests v2 7/9] common/nvme: support the ports of a remote
 target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-7-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_012658_834151_6675514B 
X-CRM114-Status: GOOD (  17.29  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The port helpers always use the local nvmet configfs, so tests that use
more than one port don't work with a remote target. Use the port
commands of the target control script instead and document them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 29 +++++++++++++++++
 common/nvme                    | 70 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index d556f1d3b7cc..8300d9aa4842 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -256,6 +256,8 @@ The blktests expects that the script interface implements following
   --hostnqn HOSTNQN
   --ctrlkey CTRLKEY
   --hostkey HOSTKEY
+  --ports NR_PORTS
+  --tls | --force-tls
 
 cleanup:
   --subsysnqn SUBSYSNQN
@@ -267,6 +269,33 @@ the target can set up TLS. blktests skips the tests which need a feature
 the list lacks: the authentication tests without dhchap-sha256, and
 nvme/042 and nvme/043 only the steps for the other missing algorithms.
 
+The tests which use more than one port, or add and remove ports, also need
+the port commands. A port is named by an ID the script picks:
+
+add-ports: export the subsystem on NR_PORTS more ports, print their IDs
+  --subsysnqn SUBSYSNQN
+  --ports NR_PORTS
+  --tls | --force-tls
+
+add-port: create a port which exports no subsystem, print its ID
+  --tls | --force-tls
+
+remove-port:
+  --port PORT
+
+list-ports: print the IDs of the ports which export the subsystem
+  --subsysnqn SUBSYSNQN
+
+show-port: print the transport type, address and service ID of the port
+  --port PORT
+
+set-ana: set the state of an ANA group on the port
+  --port PORT
+  --grpid GRPID
+  --state STATE
+
+If list-ports prints nothing, blktests connects to the address config shows.
+
 contrib/nvme-target-control implements this interface. It configures a Linux
 nvmet target over ssh and can be extended for other targets, see
 contrib/nvme-target-control/README.md.
diff --git a/common/nvme b/common/nvme
index 6fba3890b6ce..2590b6343a27 100644
--- a/common/nvme
+++ b/common/nvme
@@ -906,20 +906,21 @@ _nvme_connect_subsys() {
 		esac
 	done
 
+	if [[ -z "${port}" ]]; then
+		local ports
+
+		_get_nvmet_ports "${subsysnqn}" ports
+		port="${ports[0]##*/}"
+	fi
 	if [[ -n "${nvme_target_control}" && -z "${port}" ]]; then
+		# The target doesn't list ports, e.g. it is configured already.
 		ARGS+=(--transport "$(${nvme_target_control} config --show-trtype)")
 		ARGS+=(--traddr "${def_traddr}")
 		ARGS+=(--trsvcid "${def_trsvcid}")
 	else
 		if [[ -z "${port}" ]]; then
-			local ports
-
-			_get_nvmet_ports "${subsysnqn}" ports
-			port="${ports[0]##*/}"
-			if [[ -z "${port}" ]]; then
-				echo "WARNING: no port found"
-				return 1
-			fi
+			echo "WARNING: no port found"
+			return 1
 		fi
 		_get_nvmet_port_params "${port}" ARGS
 	fi
@@ -1097,6 +1098,20 @@ _fc_host_traddr() {
 	printf "nn-%s:pn-%s" "$(_host_wwnn $port)" "$(_host_wwpn $port)"
 }
 
+# Add the nvme-target-control option for the TLS mode of a port to an array.
+_nvme_target_control_tls() {
+	local -n tls_args="$2"
+
+	case "$1" in
+	not-required)
+		tls_args+=(--tls)
+		;;
+	required)
+		tls_args+=(--force-tls)
+		;;
+	esac
+}
+
 _create_nvmet_port() {
 	local tls="${1:-none}"
 	local host_port="${2:-0}"
@@ -1106,6 +1121,14 @@ _create_nvmet_port() {
 	local trsvcid="${def_trsvcid}"
 	local portcfs
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		local -a ARGS
+
+		_nvme_target_control_tls "${tls}" ARGS
+		"${nvme_target_control}" add-port "${ARGS[@]}"
+		return
+	fi
+
 	local port
 	for ((port = 0; ; port++)); do
 		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
@@ -1175,6 +1198,12 @@ _setup_nvmet_port_ana() {
 	local cfsport="${NVMET_CFS}/ports/${port}"
 	local anaport="${cfsport}/ana_groups/${anagrpid}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-ana --port "${port}" \
+			--grpid "${anagrpid}" --state "${anastate}"
+		return
+	fi
+
 	if [[ ! -d "${anaport}" ]] ; then
 		if [[ "${anagrpid}" -eq 1 ]]; then
 			echo "FAIL target setup failed, ANA not supported"
@@ -1191,6 +1220,11 @@ _remove_nvmet_port() {
 	local cfsport="${NVMET_CFS}/ports/${port}"
 	local a
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" remove-port --port "${port}"
+		return
+	fi
+
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_nvme_fcloop_del_tport "$(_remote_wwnn "$port")" \
 				       "$(_remote_wwpn "$port")"
@@ -1464,6 +1498,13 @@ _get_nvmet_ports() {
 	local -n nvmet_ports="$2"
 	local cfs_path="${NVMET_CFS}/ports"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		mapfile -t -O "${#nvmet_ports[@]}" nvmet_ports < <(
+			"${nvme_target_control}" list-ports \
+				--subsysnqn "${nvmet_subsysnqn}")
+		return
+	fi
+
 	for port in "${cfs_path}/"*; do
 		if [[ -e "${port}/subsystems/${nvmet_subsysnqn}" ]]; then
 			nvmet_ports+=("${port##*/}")
@@ -1491,7 +1532,12 @@ _get_nvmet_port_params() {
 	local trsvcid="${def_trsvcid}"
 
 	# When port is specified, get port dependent parameter values
-	if [[ $port != none ]]; then
+	if [[ $port != none && -n "${nvme_target_control}" ]]; then
+		read -r trtype traddr trsvcid < <(
+			"${nvme_target_control}" show-port --port "${port}")
+		[[ -n "${trsvcid}" ]] || exit 1
+		args+=(--traddr "${traddr}")
+	elif [[ $port != none ]]; then
 		[[ -d "${cfs_path}" ]] || exit 1
 		trtype=$(cat "${cfs_path}/addr_trtype")
 		traddr=$(cat "${cfs_path}/addr_traddr")
@@ -1638,11 +1684,13 @@ _nvmet_target_setup() {
 		if [[ -n "${ctrlkey}" ]]; then
 			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
+		_nvme_target_control_tls "${tls}" ARGS
 
 		"${nvme_target_control}" setup \
 					 --subsysnqn "${subsysnqn}" \
 					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
 					 --hostnqn "${def_hostnqn}" \
+					 --ports "${num_ports}" \
 					 "${ARGS[@]}" &> /dev/null
 		p=0
 		while (( p < num_ports )); do
@@ -1736,20 +1784,20 @@ _nvmet_target_add_ports() {
 		if [[ -n "${ctrlkey}" ]]; then
 			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
+		_nvme_target_control_tls "${tls}" ARGS
 
 		"${nvme_target_control}" add-ports \
 					 --ports "${num_ports}" \
 					 --subsysnqn "${subsysnqn}" \
 					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
 					 --hostnqn "${def_hostnqn}" \
-					 "${ARGS[@]}" &> /dev/null
+					 "${ARGS[@]}" > /dev/null
 		p=0
 		while (( p < num_ports )); do
 			# Set ports_to_hosts so that _get_fc_host_port() can return the correct host port
 			ports_to_hosts+=("${host_port}")
 			p=$(( p + 1 ))
 		done
-		echo "'${nvme_target_control} add-ports' is a stub"
 		return
 	fi
 

-- 
2.56.1


