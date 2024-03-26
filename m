Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E625CD1280
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=; b=zTXtJwIfw5IKPTpxWatTkSfEmK
	D+wJD5ZCvEztkPALOfoqHu4HDGNip6j6AiD8k366KIG82bVRr5+JyzMZL9IWJOvB/5s22C0vrJWbR
	OCGAqrBuibEh2/BrgLJS3yfvsPTIcvhZ6o6ZR/XWjgTnRrIK6dNjwABmNQlJx0kw/sExFgzHFDw5g
	ES5yepDii3RlO9xhZSmzY7jnFhi20ximUkOb+ckb4tlD/nY66C2K2yq1J/1OhtMWb+prwh1Jkz3Z+
	CO70fxXnt5Zwz17Timb5hsVqMAbutaSF5vDw4oPPGoNfLAlscENaMff/oe/8fA/ilojCbBEeB3aWD
	yFSuUKHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dx-00000004cFW-1dw6;
	Tue, 26 Mar 2024 13:15:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d5-00000004c2U-4BRo
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=; b=NqAZpRxuELMIpBmYdyLun8qDIp
	x/x3TTCstyUXFFI2qKhsObnf0+5cO0Q6dpgJpjnkR1DD0ToOJ5I4fPvoQI03zFCrMVMT3u3QhcWx7
	KDkvoMwyVlGx3ddTxljAkgMxOGpOs7NHpYT/Mjbu7csXoQV+4rbYG5mp3/Ug/JZHQutPTntYWESKL
	0KhCkm2PsxwUy80DhNHIO13ZvE7t67lx0rLrW27ixa/3Ki04Edi6N4YS9DYi/1CrNHw3v8FxT/n++
	xSQLvT7t3LcKhRN6U0XLAzsQiYdOYTA2Np1Zeio0JdgDFKEs3q0hwwXhPT4jlLEH2CEgAmF3uiWKE
	IxjY96eg==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d1-0000000HAwe-49qq
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFC537BBA;
	Tue, 26 Mar 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=Uh3mOKkOhx+HVFMSZ5k7AADCuvrdgHvpTNjddVV5MyqmOIFgNEKc51kasLlB51LeVwS7nd
	CkYXcESc5SfBjN7E2ygO99A8HIP55lvMYLqqBjaaDyOtahTcISGYEX0lc3fo/xj1ITdkr1
	YJ1H+es6nIAREuNqZwDh8SXmAEINEbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=5qnIRV16JM10yK5H3YWWMZELV/TSP7EO0rXjqLsfAUP5iLTOY8ekdIm3qePv3tTIICuzw9
	fFz2pcIXfkE7nLAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=Uh3mOKkOhx+HVFMSZ5k7AADCuvrdgHvpTNjddVV5MyqmOIFgNEKc51kasLlB51LeVwS7nd
	CkYXcESc5SfBjN7E2ygO99A8HIP55lvMYLqqBjaaDyOtahTcISGYEX0lc3fo/xj1ITdkr1
	YJ1H+es6nIAREuNqZwDh8SXmAEINEbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+BQo/zcr69M7gMHeiTmNO6PMDT+nNMcDXxkVe0Mosk=;
	b=5qnIRV16JM10yK5H3YWWMZELV/TSP7EO0rXjqLsfAUP5iLTOY8ekdIm3qePv3tTIICuzw9
	fFz2pcIXfkE7nLAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8B913587;
	Tue, 26 Mar 2024 13:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0mu8CSHKAmYJNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 06/20] nvme/rc: use long command line option for nvme
Date: Tue, 26 Mar 2024 14:13:48 +0100
Message-ID: <20240326131402.5092-7-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uh3mOKkO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5qnIRV16
X-Rspamd-Queue-Id: 4CFC537BBA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131412_169272_80030FFA 
X-CRM114-Status: UNSURE (   9.70  )
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
index e67bb846ab77..6bf2e3ae37c5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -148,7 +148,7 @@ _require_nvme_trtype_is_fabrics() {
 }
 
 _require_nvme_cli_auth() {
-	if ! nvme gen-dhchap-key -n nvmf-test-subsys > /dev/null 2>&1 ; then
+	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
 		return 1
 	fi
@@ -396,13 +396,13 @@ _setup_nvmet() {
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
 
@@ -496,11 +496,11 @@ _nvme_connect_subsys() {
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
@@ -565,13 +565,13 @@ _nvme_discover() {
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


