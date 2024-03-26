Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D3ACD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=; b=pkoGVoFI4PgofQPWEw3qGQMYP6
	53KKPzwG/kG3gZlak6MC1tkn1MxXCegumqtiUQuElnbR5N5uCtnsdJ/LFznlHucsFTfCmFo13FYHL
	sDovDriY9l+HsyT7nFQGwq5vJJjUULfL2twA8J51zB2na1yNuA3rcHTiTSSzsMdh6Jiwjs6SQu/y9
	1vS+4GD4ztZSLW62Q5bt3tzOX0jn4HxzoKlOopHP7A4KeWkflXHdukLi6QCi6j7lG7P5+kICXIm96
	lPap4zPygJ/8C5X42O+njBvh1GD9IguPN5RyY9HiyTC8alg0pEclQzzBIVrvOJAwT1w/WnuhlT/LC
	vwh3GHfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dr-00000004cEF-0mWv;
	Tue, 26 Mar 2024 13:15:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dJ-00000004c43-2iLG
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=; b=OcDXFafyg3HEQO/Wn0oT8F9355
	iCJiPICEvWzYy12iJ4Iap07DOZakNGszk+Gre9RwmqjYZ2AkiDkFtIk+HN3aOcKlCPOnmEWsxWB8M
	jzwl6fqD/wQhc2VDvldA+KQ/Y9FqxHufFZzYeyg4d2k8Vhf6uONxkKok51ezR8xLSYUdgfXgQ9XHp
	DvT9hbZ5sopGCQmK3F62SSc2kiiz2NUG62wlahaSrhvMnTsMXbqakiO9nrfRySrV8+A905ZcHLPq5
	bfMnrJ9PtNDEpZ9ifC3wzhm2v2l+wVonDK7M+/DAXXb+rT4ZFCiFFrlLZHDWqh8eKtTqui8A7JFbl
	W4t24lcQ==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dF-0000000HAyu-0vKH
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D722F5D64E;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=A6xhVg1CWJw6Wt6xqXWvj5a87reerCzbNxNeKOyVWgFY0E+wxeeFJavKAMD7vJYT6by/LK
	ZSILSfJIMTgXZS0w8bnhEikd7ZfNDFfic1Ib11Enw0BwEWawreXMY3+w9uNKrT1mGV5DMz
	SmmzVWxNnZNDwESl2qUhpdYEV5DnGyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=rnfZ+vc+cYU/neNEZyf2A/tzpS67KHHIH/o1xVTWJbWWp495KYpZvD/Dusq4K31YCtOKIB
	LW7kPufA5APX+nAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=A6xhVg1CWJw6Wt6xqXWvj5a87reerCzbNxNeKOyVWgFY0E+wxeeFJavKAMD7vJYT6by/LK
	ZSILSfJIMTgXZS0w8bnhEikd7ZfNDFfic1Ib11Enw0BwEWawreXMY3+w9uNKrT1mGV5DMz
	SmmzVWxNnZNDwESl2qUhpdYEV5DnGyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRwxPcjUmT+sgVYhBELtu/T0gPthLZogcmVoqBFq7L4=;
	b=rnfZ+vc+cYU/neNEZyf2A/tzpS67KHHIH/o1xVTWJbWWp495KYpZvD/Dusq4K31YCtOKIB
	LW7kPufA5APX+nAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C57F313587;
	Tue, 26 Mar 2024 13:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ay/ELijKAmYmNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 18/20] nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to _nvme_connect_subsys
Date: Tue, 26 Mar 2024 14:14:00 +0100
Message-ID: <20240326131402.5092-19-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A6xhVg1C;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rnfZ+vc+
X-Rspamd-Queue-Id: D722F5D64E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131425_490539_F23E1944 
X-CRM114-Status: GOOD (  10.20  )
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

There is no point in passing the default values to
_nvme_connect_subsys, thus drop these arguments.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 |  7 ++-----
 tests/nvme/042 |  8 ++------
 tests/nvme/043 |  8 ++------
 tests/nvme/044 | 16 ++++------------
 tests/nvme/045 |  4 +---
 tests/nvme/048 |  4 +---
 6 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d6845628726e..f1fa00c0f420 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -38,16 +38,13 @@ test() {
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}"
+	_nvme_connect_subsys
 
 	_nvme_disconnect_subsys
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index 480e1cba9d19..a9e79c6a13b4 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -41,9 +41,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
@@ -57,9 +55,7 @@ test() {
 		fi
 		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
diff --git a/tests/nvme/043 b/tests/nvme/043
index dd48035dd967..4589423d4335 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -45,9 +45,7 @@ test() {
 
 		_set_nvmet_hash "${def_hostnqn}" "${hash}"
 
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
@@ -58,9 +56,7 @@ test() {
 
 		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
-		_nvme_connect_subsys  --hostnqn "${def_hostnqn}" \
-				      --hostid "${def_hostid}" \
-				      --dhchap-secret "${hostkey}"
+		_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 		_nvme_disconnect_subsys
 	done
diff --git a/tests/nvme/044 b/tests/nvme/044
index 624b832c0cc6..8b8859068660 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -49,18 +49,14 @@ test() {
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}"
+	_nvme_connect_subsys --dhchap-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
 
 	# Step 2: Connect with host authentication
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
 	_nvme_disconnect_subsys
@@ -68,9 +64,7 @@ test() {
 	# Step 3: Connect with host authentication
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	_nvme_disconnect_subsys
@@ -79,9 +73,7 @@ test() {
 	# and invalid ctrl key
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/045 b/tests/nvme/045
index 3a5df7c0946c..87ac3c019970 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -51,9 +51,7 @@ test() {
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
-	_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-			     --hostid "${def_hostid}" \
-			     --dhchap-secret "${hostkey}" \
+	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	echo "Re-authenticate with original host key"
diff --git a/tests/nvme/048 b/tests/nvme/048
index 79620e0d0879..0b299a91288b 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -99,9 +99,7 @@ test() {
 	_nvmet_target_setup --blkdev file
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
-		_nvme_connect_subsys --hostnqn "${def_hostnqn}" \
-				     --hostid "${def_hostid}" \
-				     --keep-alive-tmo 1 \
+		_nvme_connect_subsys --keep-alive-tmo 1 \
 				     --reconnect-delay 2
 
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
-- 
2.44.0


