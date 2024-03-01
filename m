Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75825C54E41
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=; b=VAhprgSTIKDU0WPlQtmmCTITlH
	sNx7Py03M2to0ov36cVpLOREITP0Vht5i2zwCJu0woGwk9OCOd0ALNlj/5by3cRVq9YYApe5d9Gt7
	3j+685DIhp7yf2rJQrW9Hqn1yLrV8HROL3hdR4Q6UMwe/lgMZLdxUnsFsS2S7FWMejqNQYU+nm7iq
	X0Xg3j0uICZFfiqHE44sqXAsjyTSwfkgXMulWE2ojtLgI6ppH2EYyqttvm3SiElWPWHuhgdV6kLHV
	SJYKMRO6clm1f23gXCs/OF356LPYR9gw1AUyDav/eIg8o58cTcjfCVGLAh8DWvrAemtH37uGXE/tO
	X8PvdZjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVM-0000000HEWM-3eeg;
	Fri, 01 Mar 2024 09:48:36 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVE-0000000HESg-29er
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 09:48:32 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29A4222D88;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=y/dPDSJ0Y0O7PN7/g/7ZTsXC5hWZMPw2EskVN5Xxo/rofgwJoc7pueImvhgha2jPHQMr+C
	8s4uWEatKY3y3EpseBc1jTYpBxXO1JWa9zKzTespOW6CXb/pRoZh2pKfgkz0gqmfpZ7k+x
	LAlJiBKW2ZalAq0BtxaT1Ix9qeBNa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=+wjU3R7z3LmtROz/5gZvcEUgnMfLCDJFCGoRE3+GeKKKP1uGAI5Bc54yDwDDk+D7g+QYyZ
	W1TtKyFKUc1nt8AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=y/dPDSJ0Y0O7PN7/g/7ZTsXC5hWZMPw2EskVN5Xxo/rofgwJoc7pueImvhgha2jPHQMr+C
	8s4uWEatKY3y3EpseBc1jTYpBxXO1JWa9zKzTespOW6CXb/pRoZh2pKfgkz0gqmfpZ7k+x
	LAlJiBKW2ZalAq0BtxaT1Ix9qeBNa08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0V7CjIwX35H7mnUrzMLBYfjuQ51EtGtIz8Hd5Mehis=;
	b=+wjU3R7z3LmtROz/5gZvcEUgnMfLCDJFCGoRE3+GeKKKP1uGAI5Bc54yDwDDk+D7g+QYyZ
	W1TtKyFKUc1nt8AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1788913581;
	Fri,  1 Mar 2024 09:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BApMBGmk4WXnGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 1/2] nvme/048: remove unused argument for set_qid_max
Date: Fri,  1 Mar 2024 10:48:16 +0100
Message-ID: <20240301094817.29491-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301094817.29491-1-dwagner@suse.de>
References: <20240301094817.29491-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y/dPDSJ0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+wjU3R7z
X-Spamd-Result: default: False [2.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.37)[97.09%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 29A4222D88
X-Spamd-Bar: ++
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_014828_751334_991F8C6B 
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

The port is argument is unsed, thus remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 1e5a7a1bcb99..8c314fae9620 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -69,9 +69,8 @@ set_nvmet_attr_qid_max() {
 }
 
 set_qid_max() {
-	local port="$1"
-	local subsys_name="$2"
-	local qid_max="$3"
+	local subsys_name="$1"
+	local qid_max="$2"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
 	nvmf_wait_for_state "${subsys_name}" "live" || return 1
@@ -100,8 +99,8 @@ test() {
 		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
 		else
-			set_qid_max "${port}" "${def_subsysnqn}" 1 || echo FAIL
-			set_qid_max "${port}" "${def_subsysnqn}" 2 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 1 || echo FAIL
+			set_qid_max "${def_subsysnqn}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${def_subsysnqn}"
-- 
2.43.2


