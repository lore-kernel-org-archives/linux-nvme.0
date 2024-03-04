Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D04C5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=; b=p2jGs7OGSV2ZnF2PWf10uiNmj9
	by5+NoD4vS+zJbwHMDVJSbM+3KElvez1sAyrY1wOdnJ9r85gZg1005tPqnRAblerqYOb7OtEH9SVA
	695Xi3XJtjGiIANsxkaD0HJnAnCKQ5r03Pl0CWldt2yqP9XgHDinsTk7uRt/UihDxBzg0Yq9mVYon
	dkjYm8naWn8b+oEGu8zCbEDORaaEx/Gu0NMn7GS+wOtX5tczYqfo3/RcE6FbiU86UOhNrSWK6SEFD
	ComSzw8DrwpUeJlc9kOidRzWtrcmBXMJ34EE5FTcFCffdV6JgfTj4cie8qQnh5Yat/1X1MusTovWF
	CzfN+E8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAwL-00000009m94-3PyF;
	Mon, 04 Mar 2024 16:13:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAwB-00000009m3q-0nQg
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:13:19 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 666191FD86;
	Mon,  4 Mar 2024 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=gOV2qGcW89d+1AGWnqB3UVmmKau9AgVQfy8CQ802t7Y5uyn5MDrz3YS1AQs7Mug/PSJJJ2
	TBZGApNww8wDtqWG1ccHz8mhcQ7lwBeBEAsMhqNpbXAg4YuxPfp5YEjQlC0PtfeIse23mW
	m6wmNdemGbj6lnWfbaGJDiI+lie+bqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=BszQ/32uH7xm81KT9QKPwFair1gE6Gds3QFAa9l+G3nP1wFO3q6Z6hySQPKyn6XfvCm8Ne
	DK3zWWn9ADyUPmBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=gOV2qGcW89d+1AGWnqB3UVmmKau9AgVQfy8CQ802t7Y5uyn5MDrz3YS1AQs7Mug/PSJJJ2
	TBZGApNww8wDtqWG1ccHz8mhcQ7lwBeBEAsMhqNpbXAg4YuxPfp5YEjQlC0PtfeIse23mW
	m6wmNdemGbj6lnWfbaGJDiI+lie+bqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYr10uhGwyJhv2Bn7zavFpYfS5IaeB3cAS6xVvgTdDo=;
	b=BszQ/32uH7xm81KT9QKPwFair1gE6Gds3QFAa9l+G3nP1wFO3q6Z6hySQPKyn6XfvCm8Ne
	DK3zWWn9ADyUPmBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 53BDB139C6;
	Mon,  4 Mar 2024 16:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VugDExXz5WUgewAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:13:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key change
Date: Mon,  4 Mar 2024 17:13:03 +0100
Message-ID: <20240304161303.19681-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304161303.19681-1-dwagner@suse.de>
References: <20240304161303.19681-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_081311_429788_FD85B9E0 
X-CRM114-Status: GOOD (  14.17  )
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

The re-authentication is a soft state, meaning unless the host has to
reconnect a key change on the target side is not observed. Extend the
current test with a forced reconnect after a key change. This
exercises the DNR handling code of the host.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/045     | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/nvme/045.out |  3 +-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/045 b/tests/nvme/045
index be408b629771..b0527685f61f 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -21,6 +21,62 @@ requires() {
 	_have_driver dh_generic
 }
 
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+nvmf_wait_for_ctrl_delete() {
+	local def_state_timeout=5
+	local nvmedev="$1"
+	local timeout="${2:-$def_state_timeout}"
+	local ctrl="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+	local start_time
+	local end_time
+
+	start_time=$(date +%s)
+	while [ -f "${ctrl}" ]; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "controller \"${nvmedev}\" not deleted" \
+				"within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+}
 
 test() {
 	echo "Running ${TEST_NAME}"
@@ -55,7 +111,11 @@ test() {
 			     --hostnqn "${def_hostnqn}" \
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
-			     --dhchap-ctrl-secret "${ctrlkey}"
+			     --dhchap-ctrl-secret "${ctrlkey}" \
+			     --reconnect-delay 1
+
+	nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	echo "Re-authenticate with original host key"
 
@@ -108,6 +168,16 @@ test() {
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
 	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
+	echo "Renew host key on the controller and force reconnect"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
+
+	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"
+
+	# Force a reconnect
+	set_nvmet_attr_qid_max "${def_subsysnqn}" 1
+	nvmf_wait_for_ctrl_delete "${nvmedev}"
+
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/045.out b/tests/nvme/045.out
index 84a69ef5c4c6..3331304ef71a 100644
--- a/tests/nvme/045.out
+++ b/tests/nvme/045.out
@@ -8,5 +8,6 @@ Change DH group to ffdhe8192
 Re-authenticate with changed DH group
 Change hash to hmac(sha512)
 Re-authenticate with changed hash
-disconnected 1 controller(s)
+Renew host key on the controller and force reconnect
+disconnected 0 controller(s)
 Test complete
-- 
2.44.0


