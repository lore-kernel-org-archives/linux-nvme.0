Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D546606A8BE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ID0rWAyQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AwVeDQNh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a17L9MAu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=; b=ID0rWAyQpKg+H5
	qozBoMU44OWMQtUtt4ozgGUGxNY5clfN7olfDmsdP0kqJhk/8EgjPJhRQzVCmdxhs5v89vrnD9InO
	0RNQ1X67zNNqs5nETaN62cqLFYjZLOxAn+Bt71qCUFzABniZL++CAYD+5sSNCaFAZx5iJ8rvHdKgM
	8Y1asIOQPeARh/PvfXbI6vK5CdSD55j5t2S0iSYEHNlSxtTXW58kh8NvQe4nWNA4Ly7ZsIHVNPbrE
	/LTmcfqgjfnWGNz+KCkw/uLabW3VIxujb7zfqRPErSL1G94MqeyARnIVDlkFHB3/n3dYVv1fpZ+DF
	ddEW9iqZ0PpBLV3mWvfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFO-00000008Bmt-1JiZ;
	Wed, 18 Nov 2026 08:42:30 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbFL-00000008BlJ-2akI
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 08:42:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0EC1223A6;
	Wed, 18 Nov 2026 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=AwVeDQNhkolSDopcaCmSL7ky31LBuGW9DQ2cSzaTenf78XiFiLIx6bYhnfFW6eQQr397WI
	HWUbQ9chrOPZhAKm9UfS3A8BGwfHkxj4TdVZZ+mjekoOZupX2Z8Nj3vnpaYEWM/PJn/Hma
	5rChsZ17iz2f9cHAXoo6AcsqQpZ9IUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=a17L9MAuHeOaUvk/UPkX+zk/r//LpsLe+BPy6kTDdYLQzzXe+wx249MZXl1+RDJjKb7GmS
	266JQsMYD7dcHmCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=AwVeDQNhkolSDopcaCmSL7ky31LBuGW9DQ2cSzaTenf78XiFiLIx6bYhnfFW6eQQr397WI
	HWUbQ9chrOPZhAKm9UfS3A8BGwfHkxj4TdVZZ+mjekoOZupX2Z8Nj3vnpaYEWM/PJn/Hma
	5rChsZ17iz2f9cHAXoo6AcsqQpZ9IUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlkZTfp97ILjzk2q8amVabxZhUPgms7wRTorDxz7C4U=;
	b=a17L9MAuHeOaUvk/UPkX+zk/r//LpsLe+BPy6kTDdYLQzzXe+wx249MZXl1+RDJjKb7GmS
	266JQsMYD7dcHmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81029134E9;
	Wed, 18 Nov 2026 08:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IaGSFvFk/WrbTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:25 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 09:42:22 +0100
Subject: [PATCH 2/5] nvme/053, nvme/068: skip if fio or xfs_io is missing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-skip-missing-deps-v1-2-a9b4a5a7cc94@suse.de>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_004227_817127_309E757C 
X-CRM114-Status: GOOD (  10.16  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme/053 runs fio and nvme/068 runs xfs_io without checking for them, so
they fail instead of being skipped on a host without the tools. Check
for them in requires().

Fixes: ed9b60a05a3f ("nvme: add test for controller rescan under I/O load")
Fixes: ca59dfcce4ef ("nvme/068: add a test for multipath delayed removal")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/053 | 4 ++++
 tests/nvme/068 | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/nvme/053 b/tests/nvme/053
index 99dbd3880edd..255cff177c0f 100755
--- a/tests/nvme/053
+++ b/tests/nvme/053
@@ -12,6 +12,10 @@ DESCRIPTION="test controller rescan under I/O load"
 TIMED=1
 : "${TIMEOUT:=60}"
 
+requires() {
+	_have_fio
+}
+
 get_sleep_time() {
 	local duration=$((RANDOM % 50 + 1))
 
diff --git a/tests/nvme/068 b/tests/nvme/068
index cab57cd62969..b9d28a50d03e 100755
--- a/tests/nvme/068
+++ b/tests/nvme/068
@@ -15,6 +15,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_have_module_param_value nvme_core multipath Y
+	_have_program xfs_io
 	_require_nvme_trtype_is_fabrics
 }
 

-- 
2.56.1


