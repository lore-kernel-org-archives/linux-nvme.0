Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CD0C54E69
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8mNkINxWBS8/R8stVPgmcc8G5g/Dd8VE1G9bmdfPAg=; b=oobyIWGSvt9IceSy/h/ydzkFj5
	LRC1jEg38LCPVeLZQpUFeWEe6sferH3w96hn3Yv0JYbyYS7virb6YojBRaw5V1oqU9VvSVJkRZXt4
	8PBBVekCZzW9y8ItpZv/bDeYzc3EWxXvA6pLzFdH/LgIAufK5XL9GTGDj0dwa3QkIlyPuO4xHoxRN
	gAJwLBVQNXgLNR6eFoVedkkPguIWsroW32L7603pbhjZyteObh23tW5mXgERaUYX/RGid6drsIk7y
	b+uWN24Qci4wc9VIU2RyDvbqSf5XOELwAQWDg7ZPATsbr1xgqpaiqOCOmZQFmBZQHujgQ/XpggoWQ
	1gDJDYHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9Sc-00000007xIU-0Cbr;
	Mon, 18 Mar 2024 09:39:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9SW-00000007xDW-3iSJ
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 09:39:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CE0E5C33A;
	Mon, 18 Mar 2024 09:39:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 291AF1349D;
	Mon, 18 Mar 2024 09:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RswHCroL+GWqUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 03/10] nvme/rc: use long command line option for nvme
Date: Mon, 18 Mar 2024 10:38:48 +0100
Message-ID: <20240318093856.22307-4-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 3CE0E5C33A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_023909_195944_C1991288 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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

The long format of the command line option are more descriptive and more
likely to stay stable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 961364055733..c8f13819ca21 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -160,7 +160,7 @@ _require_nvme_trtype_is_fabrics() {
 }
 
 _require_nvme_cli_auth() {
-	if ! nvme gen-dhchap-key -n nvmf-test-subsys > /dev/null 2>&1 ; then
+	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
 		return 1
 	fi
@@ -408,13 +408,13 @@ _setup_nvmet() {
 _nvme_disconnect_ctrl() {
 	local ctrl="$1"
 
-	nvme disconnect -d "${ctrl}"
+	nvme disconnect --device "${ctrl}"
 }
 
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}" |& tee -a "$FULL" |
+	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
 		grep -o "disconnected.*"
 }
 
@@ -508,11 +508,11 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
@@ -578,13 +578,13 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(--transport "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	nvme discover "${ARGS[@]}"
 }
-- 
2.44.0


