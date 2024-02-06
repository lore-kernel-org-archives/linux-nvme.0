Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAA3C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmECs5WNd174oxqJQ1ksF9zCzrmcp6Shg1Ftf+A+B8A=; b=V5FHx0glsqS80/oGdzMp+3SQJn
	UY/wkRyrB1/yj9tKEtiXhaEDnxI5UiV/+3retzauvfEOq5/Y1VneByafGkaCLy3nylQVBTLS3GQZs
	lkPU7Uhxzq4YFonxXVtmjcZsd6Jos+PUuc9lOk8WTU1NEOltmzQsg0rm+WQbxEi8qBX4Mp4yJVklM
	TvcAebXGyOqGhb8Q1e7z45TyY8F2LPnAGDhnArgVIANjRJE8wbWxSmBTj+MpFZH41e2KRlRINA3xf
	aS9wVW5s/RpuKz9zFdXAhRn47jIzxTW6StEWZN3tvB0HmL//XFkVsNpB5jGNLaIfeCsKOexavHJBR
	iCL2bxzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLK9-00000007gom-30Wb;
	Tue, 06 Feb 2024 13:17:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLK0-00000007gjB-1T9G
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 13:17:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19D7A221B2;
	Tue,  6 Feb 2024 13:17:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034A4132DD;
	Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XGf+OlIxwmV7OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 5/5] nvme/rc: revert nvme-cli context tracking
Date: Tue,  6 Feb 2024 14:16:55 +0100
Message-ID: <20240206131655.32050-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 19D7A221B2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_051708_610579_38D45876 
X-CRM114-Status: GOOD (  10.08  )
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

This feature is not needed anymore, after fixing nvmet-fc. The nvmet
target code is able to handle parallel operations and doesn't crash
anymore. Furthermore, it can't prevent from discovery controller created
by the udev rules, so let's rip it out.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 62 ---------------------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index cdfc738d3aec..dfc4c1ef1975 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -189,57 +189,6 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
-_have_nvme_cli_context() {
-	# ignore all non-fc transports for now
-	if [[ "${nvme_trtype}" != "fc" ]] ||
-	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
-		return 1
-	fi
-	return 0
-}
-
-_setup_nvme_cli() {
-	local local_wwnn="${1}"
-	local local_wwpn="${2}"
-	local remote_wwnn="${3}"
-	local remote_wwpn="${4}"
-
-	if ! _have_nvme_cli_context; then
-		return
-	fi
-
-	mkdir -p /run/nvme
-	cat >> /run/nvme/blktests.json <<-EOF
-	[
-	  {
-	    "hostnqn": "${def_hostnqn}",
-	    "hostid": "${def_hostid}",
-	    "subsystems": [
-	      {
-	        "application": "blktests",
-	        "nqn": "blktests-subsystem-1",
-	        "ports": [
-	          {
-	            "transport": "fc",
-	            "traddr": "nn-${remote_wwnn}:pn-${remote_wwpn}",
-	            "host_traddr": "nn-${local_wwnn}:pn-${local_wwpn}"
-	          }
-	        ]
-	      }
-	    ]
-	  }
-	]
-	EOF
-}
-
-_cleanup_nvme_cli() {
-	if ! _have_nvme_cli_context; then
-		return
-	fi
-
-	rm -f /run/nvme/blktests.json
-}
-
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -272,9 +221,6 @@ _setup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
-	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
-			"${remote_wwnn}" "${remote_wwpn}"
-
 	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
@@ -317,8 +263,6 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
-
-	_cleanup_nvme_cli
 }
 
 _cleanup_blkdev() {
@@ -544,9 +488,6 @@ _nvme_connect_subsys() {
 	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
-	if _have_nvme_cli_context; then
-		ARGS+=(--context="blktests")
-	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
@@ -618,9 +559,6 @@ _nvme_discover() {
 	ARGS=(-t "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
-	if _have_nvme_cli_context; then
-		ARGS+=(--context="blktests")
-	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.43.0


