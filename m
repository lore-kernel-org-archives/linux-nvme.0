Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF62C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=; b=LOiPb+DnqRoonbe2Q2e0gNFWFf
	WQM/WDqufFKczdZP9iOcJre8otDcY52F++BDJCms3VeuMGB8S2n8QAu4LodSLTzhstU9J83uJPkpU
	X9muPj1h7cDueM58yPiVtc0bwQWQPBt7jExdw8iWvc8yF97VlSLIS/0rvN5fABuxY8CBuMMEptHQb
	uHQlkhJyHDaJudx9ciVlz0dKwxcSOXb6sIY4gbna4Gutwk3oV79gdpaM4LnjFz1umPtXUm35Mkn1a
	v4zCxqMfoZ28UCW3DkMC/4BuMGcjuggYc6prPVebj0rFQlCcAYlrxD/1+pR/44Mi+gohE7O6dFmBG
	sC000kVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1j-00000002WwY-3jPM;
	Thu, 21 Mar 2024 09:47:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1f-00000002Wtz-15e3
	for linux-nvme@bombadil.infradead.org;
	Thu, 21 Mar 2024 09:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=; b=A4Znm2wPtuk5ekruackKgPN3LH
	JEaMx47G4Seq/bgoFLEbh/d0oSrXZmgYTT6Y+hwL49SZ44R10KA8dg1QqjdIuP/vwSik/IpiV4ARl
	GD2OP+jBfzw2C6Lh2r1Uw6QrHUeQZVhbxKiPs/or8CQY0lbU/VBQGLePMmAfJ2O8ZMmFPXVQJHdH0
	vjxBZw016Lfs8cES23T2Hp9OecCsaVnTY37MZmSUSIqWB/mRVm4WP2ScueOLoM5VWrP3OIE1yPiwS
	joJ6bbbFbHgn9ZAE6t0BDNJmVQbtaP5jE1iW1Xi8Ul/bV1yguh0u6azsmrV6+yYBRC3PxmSJgRfLB
	iY8ptiXQ==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1a-0000000EAO6-3VjT
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:47:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DAF55CBCB;
	Thu, 21 Mar 2024 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=KU9XoXRSvKrcthmxdKxBeX7Jmc4K152+bDU4pm3XRtzZxfVIZgbrbV+QCkE7JCs4bh0Z3t
	484tHE5a8WvKPthlyQRsEQXLuQ8JCfRy8bGYU0BNoSaWE3oCWD+0DKrd6Mhhwh+3Enla4h
	gFCqqsbxVmlIy05z9sI7syvEJPvOoDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=Z9CjUzyxiwXr8/ALSo2Apj32nJieiDFh/9fssPL0KBl58eVvdOaqwM2AluJeKstgfJRv1P
	f1BF31bSceDouKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=KU9XoXRSvKrcthmxdKxBeX7Jmc4K152+bDU4pm3XRtzZxfVIZgbrbV+QCkE7JCs4bh0Z3t
	484tHE5a8WvKPthlyQRsEQXLuQ8JCfRy8bGYU0BNoSaWE3oCWD+0DKrd6Mhhwh+3Enla4h
	gFCqqsbxVmlIy05z9sI7syvEJPvOoDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nix2qVmvxSUoWdkjAYqws6e2g+BUh2++k+pzkffUz0=;
	b=Z9CjUzyxiwXr8/ALSo2Apj32nJieiDFh/9fssPL0KBl58eVvdOaqwM2AluJeKstgfJRv1P
	f1BF31bSceDouKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3A513976;
	Thu, 21 Mar 2024 09:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oh/0BDwC/GXsDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 16/18] nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to _nvme_connect_subsys
Date: Thu, 21 Mar 2024 10:47:25 +0100
Message-ID: <20240321094727.6503-17-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_094751_259568_709976D1 
X-CRM114-Status: GOOD (  10.02  )
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
index 257898724ca0..adc86b89ccc5 100755
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


