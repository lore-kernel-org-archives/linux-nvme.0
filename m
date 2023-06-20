Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1562AC0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGmZ/olQcis6+UwkuO2nwZxUQO0u8CCpdn9kXeK69lI=; b=Kq9CjlOCzd9O/ZhSxPBlmOo8Aw
	ZwuYO6BRlIrNupPR5Bd+PHBbq/70CaJrQisS0DF71thHsnyRkJaEaWmEjbAxYO+XGhrnYk/zf4MZO
	x1dTMa9o22Uu76PD2uDYjnrWUww/0qHgHCjooE2avvRDX5UCLP9YZbSTFgFpFSrr+dn7Ai3PyE5FV
	qWH3zGLHu35TqpUVyg9nxO5GJfVAyqwyz2ReWdFwX5/9C19SLh5o2IT0YYE4uNAZP0o4vysJKl3Mi
	GIxY9HyiLFsfm6Ig6E8RyuukXZMPH9qQhddBsLn6lqRVBHKmGw09F4K3SJE526MUrjpnu5i0RrWTj
	DvhQa0xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbOJ-00BNtE-0x;
	Tue, 20 Jun 2023 13:27:27 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbOF-00BNp7-15
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:27:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 165491F38A;
	Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687267638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGmZ/olQcis6+UwkuO2nwZxUQO0u8CCpdn9kXeK69lI=;
	b=p2LyCrwU9BVcEuKucE5EYfVVjhCTR2cBrL3CyOm3m11u09Fy+PSShBnRPWiN3oRvXtlnwv
	yX2onXbW7xqn62c/pxQgXavz+u48Ni+7Vjkxcl8J+UaxwH9VITke98KJHpAVzSH2iPX/HU
	LK9zJz7Z8WnBpNN1tIar+M/zlASJknM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687267638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGmZ/olQcis6+UwkuO2nwZxUQO0u8CCpdn9kXeK69lI=;
	b=ePCe6gPxYXv8wXkMXq1XXyCUnZhao+eGWj+8V9InX/BxhCBQqn1cRLqblGj/9ES/Rz1RPw
	ceL6JMYchPVHO4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0658C1346D;
	Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NVk8ATapkWSfOAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli autoconnect
Date: Tue, 20 Jun 2023 15:27:02 +0200
Message-ID: <20230620132703.20648-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620132703.20648-1-dwagner@suse.de>
References: <20230620132703.20648-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_062723_523632_0302AB7D 
X-CRM114-Status: GOOD (  12.85  )
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

nvme-cli learned to ignore connects attemps when using the
--context command line option paired with a volatile configuration. Thus
we can mark all the resources created by blktests and avoid any
interaction with the systemd autoconnect scripts.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2e0c43..00117d314a38 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
-def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
+def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
@@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
+_nvme_cli_supports_context() {
+	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
+		    return 1
+	fi
+	return 0
+}
+
+_setup_nvme_cli() {
+	if ! _nvme_cli_supports_context; then
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
+	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
+	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
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
+	if ! _nvme_cli_supports_context; then
+		return
+	fi
+
+	rm -f /run/nvme/blktests.json
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -235,6 +279,8 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
+
+	_cleanup_nvme_cli
 }
 
 _cleanup_nvmet() {
@@ -337,6 +383,8 @@ _setup_nvmet() {
 		def_host_traddr=$(printf "nn-%s:pn-%s" \
 					 "${def_local_wwnn}" \
 					 "${def_local_wwpn}")
+
+		_setup_nvme_cli
 	fi
 }
 
@@ -436,18 +484,18 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(-t "${trtype}"
+	      -n "${subsysnqn}"
+	      --hostnqn="${hostnqn}"
+	      --hostid="${hostid}")
+	if _nvme_cli_supports_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(-a "${traddr}" -s "${trsvcid}")
 	fi
-	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
-		ARGS+=(--hostnqn="${hostnqn}")
-	fi
-	if [[ "${hostid}" != "$def_hostid" ]]; then
-		ARGS+=(--hostid="${hostid}")
-	fi
 	if [[ -n "${hostkey}" ]]; then
 		ARGS+=(--dhchap-secret="${hostkey}")
 	fi
@@ -482,7 +530,12 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(-t "${trtype}"
+	      --hostnqn="${def_hostnqn}"
+	      --hostid="${def_hostid}")
+	if _nvme_cli_supports_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.41.0


