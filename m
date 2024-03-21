Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A0CD11DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=; b=RtduyiYi9DzKS7lEYz8siWIaQG
	Ihd8I5r7eZcGIWNiTgYOCamGzkzNTgYGaBr/AGNhQINRcE6MLlkFVMv1b2FjqwxcxfHgR8hvuaYmI
	jesr+NMdP0V/oo/n+Yp/prXlEPacfOUEewUqzcl1JxVyvGjo/YFXrZ7JN8MKBF+eV2Iq1HBch2jrw
	vhpHhoVsuf7RPpOygp7V5UW1zpNnDEOu1VtOJIwG/rk4bXiaiKJLhHkquamjQTLl5uBee1Qessup0
	KqrEEpzyCalElQpxUoi4Xr8ntmJNuCX2NmOgcafIAnsqnj8B7IFmCA2qhTFzqhZN0mRIs4zv/lIu9
	zSECwifQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGBh-00000002ht6-3vzl;
	Thu, 21 Mar 2024 11:02:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1K-00000002WiG-3G0F
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:47:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BAA75CBC3;
	Thu, 21 Mar 2024 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=n0Fg1ixqRg4A5IcXkFSo7U/9isdrfJZ/moeQXEQQTrIZJOpkDq9DeRvt8xBCNjfu81v9zM
	MsfkEQA0/lwEzfcKcsdllmtc/Xb0dFS/vitbOK3LN30BLzmL1moYzK6RH4YOmrmajKz+Z5
	7TA7xspkXPNWAwa+dOF6XPEgFSvn2u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=czC2alZR+lclMW4RtYlIaN8EALzv396IG2farxUiF57yfNVvAaY9GCnjDJg4z2dt0Xj3iT
	dloIP+JEV2cNfIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=n0Fg1ixqRg4A5IcXkFSo7U/9isdrfJZ/moeQXEQQTrIZJOpkDq9DeRvt8xBCNjfu81v9zM
	MsfkEQA0/lwEzfcKcsdllmtc/Xb0dFS/vitbOK3LN30BLzmL1moYzK6RH4YOmrmajKz+Z5
	7TA7xspkXPNWAwa+dOF6XPEgFSvn2u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=czC2alZR+lclMW4RtYlIaN8EALzv396IG2farxUiF57yfNVvAaY9GCnjDJg4z2dt0Xj3iT
	dloIP+JEV2cNfIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B6A13976;
	Thu, 21 Mar 2024 09:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XxZzFDUC/GXBDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:33 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 05/18] nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
Date: Thu, 21 Mar 2024 10:47:14 +0100
Message-ID: <20240321094727.6503-6-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.978];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_024735_663038_28A2014C 
X-CRM114-Status: UNSURE (   9.55  )
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

When _xfs_run_fio_verify_io fails we should log the error. Currently, no
failure is detected when this function fails.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/012 | 4 +++-
 tests/nvme/013 | 4 +++-
 tests/nvme/035 | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/012 b/tests/nvme/012
index c5e0eb9c5e23..f0914ce3206b 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -33,7 +33,9 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3ec280ff24cf..3cef009cb9f4 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,7 +32,9 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 712fe1dbcfb8..01aa09077d6a 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -31,7 +31,9 @@ test_device() {
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
-	_xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"
+	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
-- 
2.44.0


