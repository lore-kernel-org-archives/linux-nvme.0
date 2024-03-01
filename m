Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964AC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=; b=X5vOB44xjlqPx2zEeiJRhfEK0B
	714UDbNODKzJ+Dr9MBNWHsOgd0R+8oF+/WIMGFmcUQ93NqnHrR71kUQ05KMA/52ehA1W4mRrLtDYf
	EgwInteNhxmyZ3SmRnTJHSNrBN1WQ98k219xNmx6fGN/HwckStUwMEoQbQf5Tak9CY+d+2rsvaeB9
	ugba56HDg2NOJwz+7YVHvB6qrnYzlYA+1vECQYWNAKEWgY6New40Ii+5dQJcFryaHt+1RaedOpmVI
	daKbAKL8QH39YNd1zzrRjyVh9BG1TxiTxTkUPDuK5z4cXIyNxBLbgcKFueZrRnNwT8DowW9SiUAjP
	D7NgykiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVN-0000000HEWf-2TRT;
	Fri, 01 Mar 2024 09:48:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVF-0000000HESp-16hE
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 09:48:34 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE65A22DB1;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=Pqjez5Ry6jKUV6CKdwzjeGV2Qsrlx83uZIBtUjgRgNjyPNwujQ57rrWjA2PM/Zz9FvUmP8
	n8gyegiK4WnhibbJcJjRKoYqgbbSz89Pl+je+l6hoNTu0Dj1s46E/tiaywnP1LhhbVYjUY
	+eRz9cIMOr40qc5l6Ci7b+pGnBVJ98Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=L3YyxBmibakQz0Nr7m9RguHu3CS9/xZ8oL7Dd7mQn/I4BWlBAXGhfef1ktWdRuBEYjENq1
	kPvR/ss24Fu4/pBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=Pqjez5Ry6jKUV6CKdwzjeGV2Qsrlx83uZIBtUjgRgNjyPNwujQ57rrWjA2PM/Zz9FvUmP8
	n8gyegiK4WnhibbJcJjRKoYqgbbSz89Pl+je+l6hoNTu0Dj1s46E/tiaywnP1LhhbVYjUY
	+eRz9cIMOr40qc5l6Ci7b+pGnBVJ98Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYz7i8/k2trzZXHeovD+sfA2ZBXbvyt0ndQH31Mx2Ys=;
	b=L3YyxBmibakQz0Nr7m9RguHu3CS9/xZ8oL7Dd7mQn/I4BWlBAXGhfef1ktWdRuBEYjENq1
	kPvR/ss24Fu4/pBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB98E13581;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hpIfLGmk4WXpGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Date: Fri,  1 Mar 2024 10:48:17 +0100
Message-ID: <20240301094817.29491-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301094817.29491-1-dwagner@suse.de>
References: <20240301094817.29491-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.77)[98.99%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_014829_494667_400D1AF8 
X-CRM114-Status: GOOD (  11.25  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 8c314fae9620..3b9a30bcca89 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -47,11 +47,23 @@ nvmf_check_queue_count() {
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
+			    break;
+		fi
+		retries=$((retries - 1))
+		sleep 1
+
+		queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+	done
 
-	queue_count=$((queue_count + 1))
 	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
 		echo "expected queue count ${queue_count} not set"
 		return 1
@@ -73,8 +85,8 @@ set_qid_max() {
 	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
 
 	return 0
 }
-- 
2.43.2


