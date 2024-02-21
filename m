Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5373C48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 07:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=; b=tcrywYISMBC24T13ThDJR33dAs
	fjLLmbIgV3ydvxip2UQNlkVGy+dJKVnl111hLqJY6LRxYtD8IDSFRoPQ3o6gWc/6rfQF6HmquOaWX
	cvZtfh+Y7Pj2uYjE7V++uf3Lxb9l4h7/oKHgv+Zo92Id74EHrxP25Ww1GEG225bipPkfl17a1AHm7
	ciWStybG5XMpxGL7Bq6eSxojTMO9jMgu1thVjs0dr/RCBirUthL76r1vZf8J9PyTdAoYuApJn1JmR
	AQHbzKVLuFTmIbwhgPeqjhIeyFSrP8E85ilhZk73/dJdOS/4C1DsQxV/Ia5ZHOyyOHDzcocHn1XY2
	+VQKRB2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchHH-0000000HXqD-2rkw;
	Wed, 21 Feb 2024 07:44:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchGq-0000000HXeq-1Rb3
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 07:44:08 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61C9D1FB46;
	Wed, 21 Feb 2024 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=0B91yPq5c2ldfpXzsq19LsHReBKcH0SwIJgiWPjxonElw3WOvtr00Jmr3iBDZjSB238tin
	mLPWoqFn+KFsnAzSgNKCbmhUUpKt5NeUDOGnyovXjOD/XevuA6L8EiPcTcGSfZdefl0rbU
	PRn0Er0tjZWzzVbwFh9BQWcNGKDQ9CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=HPYBsRltBZkbMaHl4Oiu8k5DvL/KNT+CfRPJa+PeUv3xfKwaLJmNp9ivHD/19lfjOKmrRi
	fW030eYC6pEMyrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=0B91yPq5c2ldfpXzsq19LsHReBKcH0SwIJgiWPjxonElw3WOvtr00Jmr3iBDZjSB238tin
	mLPWoqFn+KFsnAzSgNKCbmhUUpKt5NeUDOGnyovXjOD/XevuA6L8EiPcTcGSfZdefl0rbU
	PRn0Er0tjZWzzVbwFh9BQWcNGKDQ9CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AnTV3I+14a8T/tI2unD6gCJsXG8Br/+R1KCiFA583MA=;
	b=HPYBsRltBZkbMaHl4Oiu8k5DvL/KNT+CfRPJa+PeUv3xfKwaLJmNp9ivHD/19lfjOKmrRi
	fW030eYC6pEMyrCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B57413A25;
	Wed, 21 Feb 2024 07:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Fi4PEr6p1WXqcAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 07:43:58 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH blktests v1] nvme/029: reserve hugepages for lager allocations
Date: Wed, 21 Feb 2024 08:43:53 +0100
Message-ID: <20240221074353.27646-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0B91yPq5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HPYBsRlt
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 61C9D1FB46
X-Spamd-Bar: +
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_234400_579888_5DC47E8B 
X-CRM114-Status: GOOD (  10.44  )
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

The test is issuing larger IO workload. This depends on being able to
allocate larger chunks of linear memory. nvme-cli used to use libhugetlb
to automatically allocate the HugeTLB pool. Though nvme-cli dropped the
dependency on the library, thus the test should try to provision the
system accordingly.

Link: https://github.com/linux-nvme/nvme-cli/issues/2218
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/nvme/029 b/tests/nvme/029
index db6e8b91f707..a4f0cb1402b1 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -54,6 +54,7 @@ test() {
 	_setup_nvmet
 
 	local nvmedev
+	local reset_nr_hugepages=false
 
 	_nvmet_target_setup
 
@@ -62,6 +63,15 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
+	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
+	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
+	# from HugeTLB pool.
+	if [[  -r /proc/sys/vm/nr_hugepages &&
+		       "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
+		echo 20 > /proc/sys/vm/nr_hugepages
+		reset_nr_hugepages=true
+	fi
+
 	local dev="/dev/${nvmedev}n1"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
@@ -70,6 +80,10 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
+	if [[ ${reset_nr_hugepages} = true ]]; then
+		echo 0 > /proc/sys/vm/nr_hugepages
+	fi
+
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
 	_nvmet_target_cleanup
-- 
2.43.1


