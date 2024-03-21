Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94952CD11DC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=; b=OsQhoAig4Y3payqxN7M+TkXhLA
	kIJwj3/i7k8pF2hv/ZMmCtSSqwdRkD2BdgQd/tYephWm8m3OAGAJitD/5BymAi7f3jgL15iX6Y6O3
	gIZ7cOpBBFcM/56HZnvrCfWjp8v3LSOZsRt4twC8cBGB6DYY2fjTg4NENfToJrq4VrcxpNdH6RD2P
	mx4ICdhu+FpyYzflLDJFYCvmS+J0sUuUxKc1zCt2Xn+F8JjSbcxib5B6GEVijC/pH84x5U2YVYx2F
	0tnFrKhN3+HJzUm5l7sR/b1ZPJCD0TT8zUbQ0B7pwuqNUqRPi7kmBOu6uB6Gi2E41rfBEebHrAJfr
	B+FpP3vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGBl-00000002huE-436N;
	Thu, 21 Mar 2024 11:02:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1f-00000002Wu0-1Uul
	for linux-nvme@bombadil.infradead.org;
	Thu, 21 Mar 2024 09:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=; b=P+YJANjyi33jhY0r7WRVa/gFlI
	mpIAGqIGF8zrLqWqHpR1/StVSEg4B4gCHH10GCtnbDm/OT18I9o5dT4KmvjofnO7m9L79EFOUc6Kx
	WpiAu6n95Nkxg8XP1uJdB8tLjS3NOff7cFpMx8rMR8DLLQDRPR0pcnwUy4LOleik4Ph5rS+ajyfDu
	rv6Ba14v8egfj3qm9to8XCCSzPcenfuNHP/5jlmj0GdGqv9wZt3yIQmLoXy9tRlldmShZ0YO6Xm63
	pg2KAeYSJFqxKDegejvXqLIFtzyFvyyUwamdKkSwjJah+YCPtqap1mLjrCFlZddnJ7LKeF5PwZKH8
	1ZhofmpA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1a-0000000EAO3-3a6p
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:47:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548CD5CBC8;
	Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=q7tmfp6hi2dtoZTo/ojsmHtopM70td/ZVJoFQ1fAhAVmPq2dbiI/Z9R5MWg+w7JFmrmkgz
	aJNfetjTKd5SXpWzLrVrD8BhhzCBbsF/LyvYKYlAoO3fLB9XNFsnKDtWamwv02C8ZALFd1
	l/tn5thFtPw1VgD4PdiRuSA+gnVUOz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=MWFA+urwDm/7whjt1gtdSYqZR4RpJ4Z19kC2lmTkCBImJUXLc/BE8/lellTgLkwRT/EBvp
	fbLKazjW0ZIhEFCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=q7tmfp6hi2dtoZTo/ojsmHtopM70td/ZVJoFQ1fAhAVmPq2dbiI/Z9R5MWg+w7JFmrmkgz
	aJNfetjTKd5SXpWzLrVrD8BhhzCBbsF/LyvYKYlAoO3fLB9XNFsnKDtWamwv02C8ZALFd1
	l/tn5thFtPw1VgD4PdiRuSA+gnVUOz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+hhT8mYIDmfa1QfLAxQ9c9VKsoPa4xGXF8L0z12hAc=;
	b=MWFA+urwDm/7whjt1gtdSYqZR4RpJ4Z19kC2lmTkCBImJUXLc/BE8/lellTgLkwRT/EBvp
	fbLKazjW0ZIhEFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 425B713976;
	Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ky7DjoC/GXfDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 13/18] nvme/{rc,031}: do not cleanup external managed loop device
Date: Thu, 21 Mar 2024 10:47:22 +0100
Message-ID: <20240321094727.6503-14-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.977];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[67.21%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_094751_264097_803FE829 
X-CRM114-Status: UNSURE (   9.85  )
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

If the test setups a loop device itself (not created by
_nvmet_target_create), do not cleanup automatically.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/031 | 2 +-
 tests/nvme/rc  | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/031 b/tests/nvme/031
index 892a52170ce9..bfc43282411e 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -45,7 +45,7 @@ test() {
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 
-		_nvmet_target_cleanup --subsysnqn "${subsys}$i"
+		_nvmet_target_cleanup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
 	done
 
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d74a5418557d..e6e7b113ca8b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -855,9 +855,14 @@ _nvmet_target_cleanup() {
 	local port
 	local blkdev
 	local subsysnqn="${def_subsysnqn}"
+	local blkdev_type=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -878,7 +883,9 @@ _nvmet_target_cleanup() {
 	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
-	_cleanup_blkdev
+	if [[ "${blkdev_type}" == "device" ]]; then
+		_cleanup_blkdev
+	fi
 }
 
 _nvmet_passthru_target_setup() {
-- 
2.44.0


