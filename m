Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30760C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=; b=cGXNGHO4qgFsfbJWGg8R94cUgr
	wgjjPYfbA5q/nItEtMc8WsxDYdaE8so/O4yu8X5sA6UnHMIhIcbPca3nzKN0ZgHZ8Ip9iyOmzSzEV
	vGP1z8xdqTI0udaGlTP+Tps4hfIDO1UxVEAibw2lrFnJ0xnza2+AarS6Co0/1ZtpvKru0NNrexbHX
	ZE2QleYEsGx9+nhPkrWtLEwwZUZbWaxutrcHsa5PuMJJ0iRTYS+P8ua5MF2QnQoSB7Mpo2Awpj9ra
	+xKMwkKtL6hpHfX+xIZLUDub3BJF2k5e5ivKUGHdjBD6hZecY7ixL1JCk0Cf3VdwgKziKKaw0ZvA7
	Cgm9Mg1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp7bw-00000004s9R-3cfZ;
	Tue, 26 Mar 2024 14:17:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d5-00000004c2T-47oF
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=; b=NuKyKOob2htuEsPuQTrLpR77Pr
	E/oWY2rGBlYu2F8ym7PgkwZ1Lk3dfheDomL0EnCU6l/fplzywKvfuwRn5k5TEDIobVuThytbbUZR8
	Q2uUTPFgsWxxB2TWHxeJVL3SYpeu21nNiuYChrojwV4hk/S56KoGLIZpZCBruWb029TaHas3lLTpr
	pgl3+nmweUXUrI0dbOitcr/nXRFDJow+S3xoe6E+hMDHq9/TicXu40Av+hDrwWRj4K0d9VHRuFpE9
	EmcXY1N81PxMAY9DehpSyK/S0CwoY2wwtd0iqt+iQAEFwkbY9thzAMEhwDnej34ELuRKK7eBx0pkt
	2gEGl0sA==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d2-0000000HAx1-1CJh
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E5AE373FB;
	Tue, 26 Mar 2024 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=;
	b=cjKVWR14f/xBZ4isBNs6JQs+3Mze8DHjnVlBfD18etw99tSZofDkdkG/Vvt/ZnEGoe+ylT
	LZoRcEqIAMt9pRBlMlqtWM0bNVOz1SfMLMKDjX+G+iT1cBCewwRWL0V7C0vI3e0xoHn+ZY
	LmKTSH/shyJI6o/F8RK2tdWq3+JOl3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=;
	b=OmXpkHVkHnX52Kf3JEg9jUeP3GbDCQOeIlljtzEZwpTEZwxEW++JTn5331Uf/6/IeWaxXU
	vfGAZPS18kWpq1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=;
	b=cjKVWR14f/xBZ4isBNs6JQs+3Mze8DHjnVlBfD18etw99tSZofDkdkG/Vvt/ZnEGoe+ylT
	LZoRcEqIAMt9pRBlMlqtWM0bNVOz1SfMLMKDjX+G+iT1cBCewwRWL0V7C0vI3e0xoHn+ZY
	LmKTSH/shyJI6o/F8RK2tdWq3+JOl3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvDOBADFmDw+aOPrwhzt2BHMoHBf/CgZuKxG1LnfDio=;
	b=OmXpkHVkHnX52Kf3JEg9jUeP3GbDCQOeIlljtzEZwpTEZwxEW++JTn5331Uf/6/IeWaxXU
	vfGAZPS18kWpq1BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DC5713587;
	Tue, 26 Mar 2024 13:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UW+5CSPKAmYQNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 09/20] nvme/rc: add nqn/uuid args to target setup/cleanup helper
Date: Tue, 26 Mar 2024 14:13:51 +0100
Message-ID: <20240326131402.5092-10-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131412_450354_0BF036E0 
X-CRM114-Status: UNSURE (   8.83  )
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

Make these helper a bit more flexible, so that the caller
can setup not just the default subsysnqn.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 535bd869bf58..7f436037eb94 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -817,6 +817,8 @@ _nvmet_target_setup() {
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
+	local subsysnqn="${def_subsysnqn}"
+	local subsys_uuid="${def_subsys_uuid}"
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -833,6 +835,14 @@ _nvmet_target_setup() {
 				hostkey="$2"
 				shift 2
 				;;
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--subsys-uuid)
+				subsys_uuid="$2"
+				shift 2
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -847,11 +857,11 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
-				"${def_subsys_uuid}"
+	_create_nvmet_subsystem "${subsysnqn}" "${blkdev}" \
+				"${subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
+	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
+	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
 			"${hostkey}" "${ctrlkey}"
 }
 
@@ -859,14 +869,28 @@ _nvmet_target_cleanup() {
 	local ports
 	local port
 	local blkdev
+	local subsysnqn="${def_subsysnqn}"
+
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
 
-	_get_nvmet_ports "${def_subsysnqn}" ports
+	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
 		_remove_nvmet_port "${port}"
 	done
-	_remove_nvmet_subsystem "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
 	_cleanup_blkdev
-- 
2.44.0


