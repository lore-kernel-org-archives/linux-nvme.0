Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB9C001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+8YBrUpE2qb6+lv32u7UaAshwQ/NzzYaAEBiSNLejw=; b=p3WHaDdogsGis9BZkx/ttlOPLJ
	Z5h7wCw9eJDFySO+DgVejGKiAuj/I7D1cOuOi8XKvVUvMv5NPjRN6tuUBSWa4i6tkS3WnlaGA2sD1
	OlALKfvZdy9QZ+1vk1FMn89CC/OsiJ4dGtF5SSaG9WFpJ6OsenCM8NVwgDkLcsxdom0ZSlMUzMj+r
	SxT1FNX+RtmaCr3s9uOJ3oPo2cN9hcDkb1GuDyetuoIzPkAnRu8E05m7e9C9sqy4w6ozXtCMze6tH
	Q2ToZ9pkPc3lunfLE9KT8aYLZKdxlMz+bAptdmrCp2nKG2+c8cpQCbpmvneanzCv5qz2n6TgMVKhf
	8ioFslIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFg5-009tWg-17;
	Mon, 03 Jul 2023 09:17:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFg1-009tTA-0u
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:16:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6AB51FD75;
	Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+8YBrUpE2qb6+lv32u7UaAshwQ/NzzYaAEBiSNLejw=;
	b=aJmI21XoZATqMcxjej/15bKMZYrd+hA/+VsblssIvVvsNxnaHbEuh69tJAbB3DukWKT0tT
	HZ8blHsP1mKB8H06vSWCONF0DI+Wm5BTluLIB0ww4qUG/cvqOvbp2+aUTvOhWKu+U3RDFZ
	squn7W+cBtbkXqTAk4EqLQ3IN7GAjus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+8YBrUpE2qb6+lv32u7UaAshwQ/NzzYaAEBiSNLejw=;
	b=EFyh0LmGkHJ0/iuIO0GzOGCahFA9hXk1xaPJe68n7OeLUpLX8Cvr/9t0Iuarq2VSnhdoST
	6urwYVCwcpLUeiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9CA613276;
	Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kRBAMQeSomSLDgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 09:16:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/3] nvme/rc: Avoid triggering host nvme-cli autoconnect
Date: Mon,  3 Jul 2023 11:16:46 +0200
Message-ID: <20230703091647.800-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703091647.800-1-dwagner@suse.de>
References: <20230703091647.800-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_021657_463152_9DE10696 
X-CRM114-Status: GOOD (  11.86  )
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

When the host has enabled the udev/systemd autoconnect services for the
fc transport it interacts with blktests and make tests break.

nvme-cli learned to ignore connects attemps when using the --context
command line option paired with a volatile configuration. Thus we can
mark all the resources created by blktests and avoid any interaction
with the systemd autoconnect scripts.

Only enabled this for the fc transport.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c2c2fab62c1..9b5442b2c07b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -176,6 +176,57 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
+_have_nvme_cli_context() {
+	# ignore all non-fc transports for now
+	if [[ "${nvme_trtype}" != "fc" ]] ||
+	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
+		return 1
+	fi
+	return 0
+}
+
+_setup_nvme_cli() {
+	local local_wwnn="${1}"
+	local local_wwpn="${2}"
+	local remote_wwnn="${3}"
+	local remote_wwpn="${4}"
+
+	if ! _have_nvme_cli_context; then
+		return
+	fi
+
+	mkdir -p /run/nvme
+	cat >> /run/nvme/blktests.json <<-EOF
+	[
+	  {
+	    "hostnqn": "${def_hostnqn}",
+	    "hostid": "${def_hostid}",
+	    "subsystems": [
+	      {
+	        "application": "blktests",
+	        "nqn": "blktests-subsystem-1",
+	        "ports": [
+	          {
+	            "transport": "fc",
+	            "traddr": "nn-${remote_wwnn}:pn-${remote_wwpn}",
+	            "host_traddr": "nn-${local_wwnn}:pn-${local_wwpn}"
+	          }
+	        ]
+	      }
+	    ]
+	  }
+	]
+	EOF
+}
+
+_cleanup_nvme_cli() {
+	if ! _have_nvme_cli_context; then
+		return
+	fi
+
+	rm -f /run/nvme/blktests.json
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -208,6 +259,9 @@ _setup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
+	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
+			"${remote_wwnn}" "${remote_wwpn}"
+
 	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
@@ -250,6 +304,8 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
+
+	_cleanup_nvme_cli
 }
 
 _cleanup_nvmet() {
@@ -452,6 +508,9 @@ _nvme_connect_subsys() {
 	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if _have_nvme_cli_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
@@ -496,6 +555,9 @@ _nvme_discover() {
 	ARGS=(-t "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
+	if _have_nvme_cli_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.41.0


