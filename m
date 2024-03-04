Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939D6C5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=; b=zc4xYFikuomZEmJmeWMfgEQEpP
	FHU2FqlJU7LFhA0pI1+q1+hB6Wll8yiwqI95ny5JVetjUDEuKw2fBX2yiCIiTDftuo4UuubQVt3th
	nCWRr7BNpF127Y1VOIoGTL8qUEmk4fQd6EWastZNPZESvilS6Y5YFYSrZTInOxG53L5wMNXUlnmD9
	UeKwpKdxqKcnoIq2+U9qAm1lItpCOu4C77tHerKf0CuWVkkmhdOpSw5bj+N+Q5+k12d7T7rofX86Q
	rd0FimOjKJJIAUMI0QGQJ63Yd9fAvMYGK6wCgYQ0Lm4bGPQPHvwXTSqqeM+B3vhpBnTgE087bwOMB
	IfhYt2sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8gX-00000009EBy-0Xnx;
	Mon, 04 Mar 2024 13:48:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8gC-00000009E3U-3E1w
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 13:48:50 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 085FD76062;
	Mon,  4 Mar 2024 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=bogOyDTO92rQxumAgFFVWmUwAt0G2SXjj8XyWkRDSvQ/XlfhknzRmFyLhIA8gcLpBuLtU6
	9ckrz/akdIy/L+k6HjFHfmbqdaHcX1fMNwCziO6NLrENsmBO/MCIsakVJgyMkqKkPYcv2E
	W7kq0sHQLZSjrQS6jTv7kuHXW1qmWH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=YkHjq6L9M2yA/vrXrZW+jE6dS3rOC1qhmhoKpkfJjzgi+Zd3osTjYed5i0OcDrbZpPv1rT
	pou7/VApKDXFCtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=bogOyDTO92rQxumAgFFVWmUwAt0G2SXjj8XyWkRDSvQ/XlfhknzRmFyLhIA8gcLpBuLtU6
	9ckrz/akdIy/L+k6HjFHfmbqdaHcX1fMNwCziO6NLrENsmBO/MCIsakVJgyMkqKkPYcv2E
	W7kq0sHQLZSjrQS6jTv7kuHXW1qmWH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dxdbCkVkX4T7z0yhU/0/V65EvjCfxxvaq6BgKKlMoI=;
	b=YkHjq6L9M2yA/vrXrZW+jE6dS3rOC1qhmhoKpkfJjzgi+Zd3osTjYed5i0OcDrbZpPv1rT
	pou7/VApKDXFCtBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E996E139C6;
	Mon,  4 Mar 2024 13:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ibSSNyzR5WUkUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 13:48:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 2/2] nvme/048: make queue count check retry-able
Date: Mon,  4 Mar 2024 14:48:26 +0100
Message-ID: <20240304134826.31965-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304134826.31965-1-dwagner@suse.de>
References: <20240304134826.31965-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.79)[99.07%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_054832_991434_7E218DB3 
X-CRM114-Status: GOOD (  11.70  )
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

We are racing with the reset path of the controller. That means, when we
set a new queue count, we might not observe the resetting state in time.
Thus, first check if we see the correct queue count and then the
controller state.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 8c314fae9620..393dbc2a07d5 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -47,11 +47,25 @@ nvmf_check_queue_count() {
 	local queue_count="$2"
 	local nvmedev
 	local queue_count_file
+	local retries
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	queue_count=$((queue_count + 1))
+	retries=5
+
 	queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	while [[ "${queue_count}" -ne "${queue_count_file}" ]]; do
+		if [[ "${retries}" == 0 ]]; then
+			echo "expected queue count ${queue_count} not set"
+			return 1
+		fi
+
+		sleep 1
+
+		retries=$((retries - 1))
+		queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	done
 
-	queue_count=$((queue_count + 1))
 	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
 		echo "expected queue count ${queue_count} not set"
 		return 1
@@ -73,8 +87,8 @@ set_qid_max() {
 	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 
 	return 0
 }
-- 
2.44.0


