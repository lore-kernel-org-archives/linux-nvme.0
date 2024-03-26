Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA05CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=; b=P4ipzl7C+lyxQUOvEzFKmpctaG
	SvYWVz+gvyBAjPQ+I0A7lZxRtlHve6aax6EkmQBm3CfPzLOPQj5rapcAtKsUJqC0kIqQ+Kl/ruo1h
	hzTMCd+//vatTW4tD6+xAhlnZ6B902Qx2fHUpCbVrxfXfC7upT86j5Gur0BHPfP7PwaWuTCpJ5Bbl
	YG6X0OXyj2OsomSni0tbtpjZVux0D46fb1kk03Sgqn/QD+QbEWE+X7qWKSi2kWRbqdb5xgWI9Mor5
	pFaUpaS8S5bh3hAXPYf78eXyTkyXJXdqZ0Sq4AInIs1ty1be9Z2jzhHhi4niIxWRvsQeyggrW7XbD
	dsk2W4SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6eS-00000004cTm-0aoO;
	Tue, 26 Mar 2024 13:15:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dJ-00000004c42-2eOT
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=; b=D8E4sM6URCO0tLYqvslHKsPNfy
	MGbox4ZfS9Ks9jY4TFG8c8cGfUi81EnYIze0AJ7HZ9D8K3lzQCYW+Aj5umQZ3PTF1ohaqdqMzxZ9j
	sS8P/NMZYD2gJnzFILFeKkzLrtOGJXbgnTX54Jgz1OnB2UpwhqapaKnNWxyNMv58WWJKwMtXwYZA4
	wgyVyXOCxSEpOmZ7yhYjXdYAIkvACDqO5t1H62BaW3RDQSBf3zjNaacJ31c5JciaMnfAdi/sJGgQu
	6ymt+kQo0uvgoh7JcFTDPQoT89YL6qvAMdv8BfX5/UMW4IBdSctcKMJfnCvPJfVH0ZAaYjOVqtO0T
	kJgpwhMQ==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dF-0000000HAyt-0rqW
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D2C53739E;
	Tue, 26 Mar 2024 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=;
	b=HZqU0xO9o2K9DDnc1HUsaerk98mgYJAhD9zO8F8d9NgpzbeiOFa4aAz+aN4GSzcJg3BFGl
	NPPnqrba52zW5dcS3nv40bcpprEna7pApRW8UOCUNWreGtdTo6in5S92Uq9u/gegovqBWH
	teRLpk8UvWL+9PHZpbyQUx+TO/ZOipM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=;
	b=klcLcvt2x73DNnwE2FJYWyfF2r78c/1Kp+qYCeu3tuMEOjFIBo+H0Qy603oGZoG+5z3TJP
	gmnLT01G/vQXBmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=;
	b=HZqU0xO9o2K9DDnc1HUsaerk98mgYJAhD9zO8F8d9NgpzbeiOFa4aAz+aN4GSzcJg3BFGl
	NPPnqrba52zW5dcS3nv40bcpprEna7pApRW8UOCUNWreGtdTo6in5S92Uq9u/gegovqBWH
	teRLpk8UvWL+9PHZpbyQUx+TO/ZOipM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVYm7pkads50+R9zNqmX4a+aUjG9dWhj7UnDhdUYvho=;
	b=klcLcvt2x73DNnwE2FJYWyfF2r78c/1Kp+qYCeu3tuMEOjFIBo+H0Qy603oGZoG+5z3TJP
	gmnLT01G/vQXBmAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B80B13587;
	Tue, 26 Mar 2024 13:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fF6fICfKAmYhNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 16/20] nvme: drop default subsysnqn argument from _nvme_passthru_target_{setup|cleanup}
Date: Tue, 26 Mar 2024 14:13:58 +0100
Message-ID: <20240326131402.5092-17-dwagner@suse.de>
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
	 R_RATELIMIT(0.00)[to_ip_from(RL7ufrgpbk1ee76mmzdtnzc641)];
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HZqU0xO9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=klcLcvt2
X-Rspamd-Queue-Id: 9D2C53739E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131425_495372_D0E5C3A4 
X-CRM114-Status: GOOD (  10.68  )
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

Remove the last positional argument for
_nvme_passthrue_target_{setup|cleanup} which most test pass in the
default subsysnqn anyway. There is little point in cluttering all the
test textual noise.

While at it, also use subsysnqn as variable name everywhere, instead of
subsys_name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  4 ++--
 tests/nvme/034 |  4 ++--
 tests/nvme/035 |  4 ++--
 tests/nvme/036 |  4 ++--
 tests/nvme/037 |  5 +++--
 tests/nvme/rc  | 42 ++++++++++++++++++++++++++++++++++--------
 6 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index c0482c808d43..f7d9f04450a8 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -51,14 +51,14 @@ test_device() {
 
 	local nsdev
 
-	_nvmet_passthru_target_setup "${def_subsysnqn}"
+	_nvmet_passthru_target_setup
 
 	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
 	_nvme_disconnect_subsys
-	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 8bb2d8cd8d62..e5518d497377 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -22,13 +22,13 @@ test_device() {
 	local ctrldev
 	local nsdev
 
-	_nvmet_passthru_target_setup "${def_subsysnqn}"
+	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
 	_nvme_disconnect_subsys
-	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index 1d1b5e4ac46e..8a66c2c15218 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -28,7 +28,7 @@ test_device() {
 	local ctrldev
 	local nsdev
 
-	_nvmet_passthru_target_setup "${def_subsysnqn}"
+	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
@@ -36,7 +36,7 @@ test_device() {
 	fi
 
 	_nvme_disconnect_subsys
-	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/036 b/tests/nvme/036
index 0e9c3bf3486c..20cd3af7081a 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -20,7 +20,7 @@ test_device() {
 
 	local ctrldev
 
-	_nvmet_passthru_target_setup "${def_subsysnqn}"
+	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect "${def_subsysnqn}")
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
@@ -30,7 +30,7 @@ test_device() {
 	fi
 
 	_nvme_disconnect_subsys
-	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index 159d9d990bb7..2fe37a7a7340 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -22,12 +22,13 @@ test_device() {
 	local ctrldev
 
 	for ((i = 0; i < iterations; i++)); do
-		_nvmet_passthru_target_setup "${subsys}${i}"
+		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
 		nsdev=$(_nvmet_passthru_target_connect "${subsys}${i}")
 
 		_nvme_disconnect_subsys \
 			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
-		_nvmet_passthru_target_cleanup "${subsys}${i}"
+		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
+		_nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
 	done
 
 	echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6493aa30adef..fca7408062ee 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -899,13 +899,26 @@ _nvmet_target_cleanup() {
 }
 
 _nvmet_passthru_target_setup() {
-	local subsys_name=$1
+	local subsysnqn="$def_subsysnqn"
 	local port
 
-	_create_nvmet_passthru "${subsys_name}"
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	_create_nvmet_passthru "${subsysnqn}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${def_hostnqn}"
+	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}"
 }
 
 _nvmet_passthru_target_connect() {
@@ -923,18 +936,31 @@ _nvmet_passthru_target_connect() {
 }
 
 _nvmet_passthru_target_cleanup() {
-	local subsys_name=$1
+	local subsysnqn="$def_subsysnqn"
 	local ports
 	local port
 
-	_get_nvmet_ports "${subsys_name}" ports
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-		_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
 		_remove_nvmet_port "${port}"
 	done
 
-	_remove_nvmet_passhtru "${subsys_name}"
+	_remove_nvmet_passhtru "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 }
 
-- 
2.44.0


