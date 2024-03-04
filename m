Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7ABC5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=; b=KRp5Ncoh9mhZYt2D2rOYI8NKpQ
	3cfMDAhEf1edR0ZKTUJIBlXFKwbHm5H85dHFvGduA1Srq8U31+d5ekmEWCGj5se/7iHyEnReLR0Pk
	pGyZocHtR8UZllF/RhpiBkYx8V1KysmKMW2s4CQ06RMbGuilIudEVWOufo5+lB2/ejzB0O4Mgh95u
	JiNZYHzoFxZKL/ZWQ7LTezGjUstwi5NLwJuU+qXw74j4c5tLfPcK4R0biAahUFFitA1VaRfXUm/eF
	4O7ZDgeTSkh3rI/JUTjNQXxkGvdX2vuwohzGPAjNXVHoGURKWCOcT7oJ9OnqRzdoxxYceTwUBsdPo
	cZ3nB/lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8gR-00000009E9Y-1ykz;
	Mon, 04 Mar 2024 13:48:47 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8gC-00000009E3T-1MLu
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 13:48:41 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF40A4E7D6;
	Mon,  4 Mar 2024 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=YLFi/baNf9LEXNCxXn77sKPwrvkno7gibNX7zuaUtCVwLkHkvO45o2wsp82TXtnY2loFse
	SKubONFdZ21gStbn/UkwZiAJWsmiWj3sURqtEwaiEDl81Mfwh6cQfwJEwmtpEjzYtZdmq8
	m8jLtfiWNRwmB97xgugv3Zj33Mt1rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=yd/mcWgLigW5T3wNzRXYOFLbPyDQfbfnbugOgiLpwTTPdU/oTc4FssNspBTH1sQ45458q0
	4KNR3sVbyZ7T7SBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=YLFi/baNf9LEXNCxXn77sKPwrvkno7gibNX7zuaUtCVwLkHkvO45o2wsp82TXtnY2loFse
	SKubONFdZ21gStbn/UkwZiAJWsmiWj3sURqtEwaiEDl81Mfwh6cQfwJEwmtpEjzYtZdmq8
	m8jLtfiWNRwmB97xgugv3Zj33Mt1rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=yd/mcWgLigW5T3wNzRXYOFLbPyDQfbfnbugOgiLpwTTPdU/oTc4FssNspBTH1sQ45458q0
	4KNR3sVbyZ7T7SBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB39F139C6;
	Mon,  4 Mar 2024 13:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5FhWKCvR5WUfUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 13:48:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Date: Mon,  4 Mar 2024 14:48:24 +0100
Message-ID: <20240304134826.31965-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.03 / 50.00];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.87)[85.71%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_054832_536847_00DC2F76 
X-CRM114-Status: UNSURE (   7.56  )
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

The nvme/048 tests fails with the fc transport because the check logic is racing
with the reset code in the target. By making the checks a bit more robust in
blktests, this test passes for all transports.

changes
v2:
  - added RB tags
  - refactored exit path as suggested by Shinichiro
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240301094817.29491-1-dwagner@suse.de/

*** BLURB HERE ***

Daniel Wagner (2):
  nvme/048: remove unused argument for set_qid_max
  nvme/048: make queue count check retry-able

 tests/nvme/048 | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.44.0


