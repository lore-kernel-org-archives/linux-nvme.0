Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A65CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=; b=IzuPv+oqq6X7hc5nPzz7v4+dV9
	uc2KnNS8nY8z+2PiJRtGZNFvory/bOlfcAGA0TiDyGlYeUMUrqeEjPnYQj7GRRAUUYsGcEz4av969
	zfliF6wAYLgzTtx27CQ3bYvfdApgzgvYuKof1jzOtlvXVEXNAxE/aZHdDAo4xLJqvT2MfoYSSv6bP
	zqd4mQTOeNDcGCfbCFq3JCAkhU8PVN+ndj+ZvuYuAgMopY9NGzFKy/5X+j5vvxBUJxNf7f4HWezLd
	T0fvSAP3HUsC9BunGRVDD6M/jpo28ROh8ixP4DKyF5g+x1dJMrGKUnzO2UlubBH8BjcYNMFqI4RRr
	tzu5isIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6en-00000004cjW-27fG;
	Tue, 26 Mar 2024 13:16:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d0-00000004bzV-0XOq
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:43 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F37665D656;
	Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=WZUT+twYOQAzS/ucgzQni59KtWGEEpfwlDo2CcjUg+QAZARpefK8afaY4GgRxG622qWjwb
	wdfnkZ4ix8RcoBqNA0J3smkYpf1543vB+EXDQD07Qa5H9ZBOqxuS59iIduXlaJYmAq36Hi
	BtQ1Cty2CAx4anOBzouR+BPkAkpOdXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=79IMKCkqlfbstEaNaRaCZdTp//tU8k6Eypd4dSFGjn8OlcWoHzB3iWkQeVeuKDR1yc+8Hc
	+A70sJGKUONTu9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=WZUT+twYOQAzS/ucgzQni59KtWGEEpfwlDo2CcjUg+QAZARpefK8afaY4GgRxG622qWjwb
	wdfnkZ4ix8RcoBqNA0J3smkYpf1543vB+EXDQD07Qa5H9ZBOqxuS59iIduXlaJYmAq36Hi
	BtQ1Cty2CAx4anOBzouR+BPkAkpOdXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=79IMKCkqlfbstEaNaRaCZdTp//tU8k6Eypd4dSFGjn8OlcWoHzB3iWkQeVeuKDR1yc+8Hc
	+A70sJGKUONTu9Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF88213587;
	Tue, 26 Mar 2024 13:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kUb4NB/KAmYCNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:07 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 04/20] common/xfs: propagate errors from _xfs_run_fio_verify_io
Date: Tue, 26 Mar 2024 14:13:46 +0100
Message-ID: <20240326131402.5092-5-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.78 / 50.00];
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
	 BAYES_HAM(-1.77)[93.62%];
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WZUT+twY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=79IMKCkq
X-Rspamd-Queue-Id: F37665D656
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_061410_403810_8AA208DA 
X-CRM114-Status: UNSURE (   9.90  )
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

If _xfs_mkfs_and_mount fails _xfs_run_fio_verify_io will continue to
execute and fio will run against the local file system instead against
the block device.

Propagate all errors back to the caller.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/xfs b/common/xfs
index 37ce85878df2..569770fecd53 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=64m -f "${bdev}"
+	mkfs.xfs -l size=64m -f "${bdev}" || return $?
 	mount "${bdev}" "${mount_dir}"
 }
 
@@ -27,8 +27,10 @@ _xfs_run_fio_verify_io() {
 	local sz_mb
 	local avail
 	local avail_mb
+	local rc
 
-	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
+	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" \
+		>>"${FULL}" 2>&1 || return $?
 
 	avail="$(df --output=avail "${mount_dir}" | tail -1)"
 	avail_mb="$((avail / 1024))"
@@ -43,7 +45,10 @@ _xfs_run_fio_verify_io() {
 	fi
 
 	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
+	rc=$?
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
+
+	return "${rc}"
 }
-- 
2.44.0


