Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C0C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=; b=URDsNkxglb9qSbICn2t5I0T17Z
	H+J+HYja05SyffO0Q+rrgPE4Jd5vsPIk2Ml55/5HdhIU2tEzk8Q/LnGir3uXtAklsENOiZidf6Gjq
	OdQuyWeLcI1QYQOBg3L7V3HGfd6KaSV2ktL3WkxGcVa4B2vWzQvf47CXFaHoaLjZ+5qTEJS0FqdBP
	vV3+hcNyRz+vH6jEYirKukq+8MHUj5++ql12na7V9gJTzC0HVtmVfCnFISIZwjYhCfOD3Uhu6WudG
	sDUtdNF4t7Uaor569DQAS6z+/pQ6bHlWFcuZ4yVL9unuMRJX1Wg5tdm2UILudTwWKlTsh3OA7zw8J
	OB2EIXHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTkA-00000004vgV-2J8B;
	Mon, 12 Feb 2024 10:40:58 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTk4-00000004vda-2poH
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:40:56 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3391F7B5;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=M0kUZE9sziBJ/3Jiy0/i9HB6TY1U5hJYb3fyf725qhiOKq/PNMUMfK8QFpCkOOH63+DvUm
	reRWOAK1xNyw6cK+Kq+7uDpf1I3/7LYnNA09WcJgcyd8GlqQR7oevCgJojcApuPx6WsI5u
	nyusMOs+Uk0k1cW3YcqkwSoOsSDizpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=hva6xSIAnJ/VMIFQ8q95GlvRdSulHH0bRDgcX78kCKVOc6thez649+QcwjFEdQDjvBDbag
	LauaxQ6ithR4oRCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=M0kUZE9sziBJ/3Jiy0/i9HB6TY1U5hJYb3fyf725qhiOKq/PNMUMfK8QFpCkOOH63+DvUm
	reRWOAK1xNyw6cK+Kq+7uDpf1I3/7LYnNA09WcJgcyd8GlqQR7oevCgJojcApuPx6WsI5u
	nyusMOs+Uk0k1cW3YcqkwSoOsSDizpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/YGKQaQ+HjwGpY382o6YRw3SpaQ9+GiCV7RLR8wcCM=;
	b=hva6xSIAnJ/VMIFQ8q95GlvRdSulHH0bRDgcX78kCKVOc6thez649+QcwjFEdQDjvBDbag
	LauaxQ6ithR4oRCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BEDE13A0E;
	Mon, 12 Feb 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UCddBbP1yWXrCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:51 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 1/5] nvme/029: fix local variable declarations
Date: Mon, 12 Feb 2024 11:40:42 +0100
Message-ID: <20240212104046.13127-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.81 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.17%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_024052_894837_A41A7383 
X-CRM114-Status: UNSURE (   9.74  )
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

The syntax for local variables declarations uses whitespace as separator
and not commas:

tests/nvme/029: line 24: local: `bs,': not a valid identifier
tests/nvme/029: line 24: local: `size,': not a valid identifier
tests/nvme/029: line 24: local: `img,': not a valid identifier

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/029 b/tests/nvme/029
index caed0f7ec476..db6e8b91f707 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -21,7 +21,7 @@ test_user_io()
 	local disk="$1"
 	local start=$2
 	local cnt=$3
-	local bs, size, img, img1
+	local bs size img img1
 
 	bs="$(blockdev --getss "$disk")"
 	size=$((cnt * bs))
-- 
2.43.0


