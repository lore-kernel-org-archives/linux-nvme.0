Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EAE606A337
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NBRuujau;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TnoMZeIn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pE+LsDJ7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=om1WRHns;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lqYxjopI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DpSAyNjyZsVtlCdUMdKs2X8x9N76nJtuwlqaRghXfS4=; b=NBRuujauLQG6PH
	FRR7iy6VQw6UpcorTXqyp5rxDkqkR2LrYwjjQmMoXBK9QNrlQddeW0jEY84j3uoIFQrrFDH/a8G8c
	kqlrxWYC8/YLCnp2h4N+3IwI9EvpuTNntyFaq6h+V96fzsUvrSy6LO6dBSfJRTSmEX3FiVjBpgMvR
	sRhG7hMbrO5P/4Ykh/DSTS296Eg5iIOAMxG/yajmlVQw68tQ3ZJ5g8+5huQZhil5GtoDuKZQ69qTl
	swGeHINHO5XLm7pKlw+j+t6Z0mJIYyhcxwdAzpJ01O0m13ZLvcV/JwfPqlTTa0SsbRtpYlMJifVtc
	BHhHNYPyR2O37fkwp7Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe7G-000000062md-1j0E;
	Wed, 04 Nov 2026 16:45:38 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe76-000000062ax-20W3
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61FFA21E05;
	Wed,  4 Nov 2026 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpSAyNjyZsVtlCdUMdKs2X8x9N76nJtuwlqaRghXfS4=;
	b=TnoMZeInUYOF6Mnmj/eQACnn2cJXdI4g6impVt0X5LpH4W2nZyso8JcqBgoIHy4OYjuie8
	sDGZ0LCfARJByRkAIM83fhJqeGe/m7HKEGg6f90W8FH3NPCZ+zS7r830+gie4ANefeXvVy
	mPeVi05G1qzdSF1lJgzsmN8ctftpzdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpSAyNjyZsVtlCdUMdKs2X8x9N76nJtuwlqaRghXfS4=;
	b=pE+LsDJ7IGYXmGEI/EDyHL1zafTrI0g3DwXg76tN50QW2xuXLPcafZkJ+xhJfJhsT7UHrL
	vCEsCBP1w9q02OAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpSAyNjyZsVtlCdUMdKs2X8x9N76nJtuwlqaRghXfS4=;
	b=om1WRHnss49UjRkfwglePmyRUmsurfCmTrUYkXCbhPdYLyH9DnSqLahwwVc0xK+9cWxXqf
	9e+XLfpBMmLakcGEcKjHgrqK/5+qaMTqFiIkZXhpgBklZQj9lPNZ0APLCCIN4kfFVlHk0G
	EsSEqUxAa1Vxn7FKKO4/Myl3i/4JUuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpSAyNjyZsVtlCdUMdKs2X8x9N76nJtuwlqaRghXfS4=;
	b=lqYxjopI0LMI7+ZcdXGIz7/YUq8f0xi6IDo9FG+dKIeHjWo/xa+c4ajnFdJx309hSiBhXA
	gRmCsAvDIDC7leBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB07134F0;
	Wed,  4 Nov 2026 16:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WKT7ACVh62qMfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:25 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:46 +0100
Subject: [PATCH blktests 07/10] common/nvme: support the ports of a remote
 target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-7-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,running-tests.md:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_084528_838399_88FA6F06 
X-CRM114-Status: GOOD (  17.48  )
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

With NVME_TARGET_CONTROL the port helpers still use the local nvmet
configfs. _create_nvmet_port, _remove_nvmet_port and
_setup_nvmet_port_ana write to it. _get_nvmet_ports and
_get_nvmet_port_params read from it. The ports of a remote subsystem
are not there. _nvmet_target_setup doesn't pass the number of ports to
the script, and _nvmet_target_add_ports only reports that add-ports is a
stub. The tests which use more than one port don't work with a remote
target, e.g. nvme/057 finds no port and connects to none.

Use the port commands of the script instead: setup --ports, add-ports,
add-port, remove-port, list-ports, show-port and set-ana, with --tls or
--force-tls for the TLS mode. _nvme_connect_subsys finds the port of the
subsystem with list-ports, as it does with the local target. If the
script lists no port, e.g. for a target which is configured already, it
connects to the address config shows, as before.

Document the port commands in running-tests.md.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 29 ++++++++++++++++++
 common/nvme                    | 69 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 095d6aa4e18e..9ca01e6893ec 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -255,10 +255,39 @@ The blktests expects that the script interface implements following
   --hostnqn HOSTNQN
   --ctrlkey CTRLKEY
   --hostkey HOSTKEY
+  --ports NR_PORTS
+  --tls | --force-tls
 
 cleanup:
   --subsysnqn SUBSYSNQN
 
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
index dfe85b6e281f..698d6bf780ef 100644
--- a/common/nvme
+++ b/common/nvme
@@ -888,20 +888,21 @@ _nvme_connect_subsys() {
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
@@ -1079,6 +1080,18 @@ _fc_host_traddr() {
 	printf "nn-%s:pn-%s" "$(_host_wwnn $port)" "$(_host_wwpn $port)"
 }
 
+# Print the nvme-target-control option for the TLS mode of a port.
+_nvme_target_control_tls() {
+	case "$1" in
+	not-required)
+		echo "--tls"
+		;;
+	required)
+		echo "--force-tls"
+		;;
+	esac
+}
+
 _create_nvmet_port() {
 	local tls="${1:-none}"
 	local host_port="${2:-0}"
@@ -1088,6 +1101,13 @@ _create_nvmet_port() {
 	local trsvcid="${def_trsvcid}"
 	local portcfs
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		# shellcheck disable=SC2046
+		"${nvme_target_control}" add-port \
+			$(_nvme_target_control_tls "${tls}")
+		return
+	fi
+
 	local port
 	for ((port = 0; ; port++)); do
 		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
@@ -1157,6 +1177,12 @@ _setup_nvmet_port_ana() {
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
@@ -1173,6 +1199,11 @@ _remove_nvmet_port() {
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
@@ -1446,6 +1477,13 @@ _get_nvmet_ports() {
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
@@ -1473,7 +1511,12 @@ _get_nvmet_port_params() {
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
@@ -1621,10 +1664,13 @@ _nvmet_target_setup() {
 			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
+		# shellcheck disable=SC2046
 		"${nvme_target_control}" setup \
 					 --subsysnqn "${subsysnqn}" \
 					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
 					 --hostnqn "${def_hostnqn}" \
+					 --ports "${num_ports}" \
+					 $(_nvme_target_control_tls "${tls}") \
 					 "${ARGS[@]}" &> /dev/null
 		p=0
 		while (( p < num_ports )); do
@@ -1719,19 +1765,20 @@ _nvmet_target_add_ports() {
 			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
+		# shellcheck disable=SC2046
 		"${nvme_target_control}" add-ports \
 					 --ports "${num_ports}" \
 					 --subsysnqn "${subsysnqn}" \
 					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
 					 --hostnqn "${def_hostnqn}" \
-					 "${ARGS[@]}" &> /dev/null
+					 $(_nvme_target_control_tls "${tls}") \
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
2.56.0


