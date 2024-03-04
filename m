Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59BEC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KWYLNcKLx3+0aivMM/iiy/Bi4uErrneqsVlSTSAl03U=; b=UV2l8J2WOoHc3f5US1NhJ1IDun
	vrRtCBf5lLowzyGaA53uHfYCnRHnpWjQtj4bA1bBOJoVy68ID8G+X106zAEs0Nqo8PCFEbWt4g8Rm
	kER5n+D49wltKxx1l6UQzO2b4RCzXniXDHZEyJSFKDzQox00kdeXfwWqOcX4nfoCbXtt+OKTwYMgy
	75z8IuM1RJ08vLSeID7SgAVzBea5v6+hke5Tx/UzuDoSzULdkC1LbzYFgY+sjBJnF1Y58kr3on6h3
	FGpHFXQqKGnO0BRG3MFO40qtCFB/AXZ4Gave4sag9Hi104/MkRkr8bflzMLjXxl+FuFGY4YotScvF
	s7rkZQDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAtY-00000009lK2-0cCk;
	Mon, 04 Mar 2024 16:10:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAtO-00000009lHR-19Qt
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:10:22 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 542F822CD6;
	Mon,  4 Mar 2024 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KWYLNcKLx3+0aivMM/iiy/Bi4uErrneqsVlSTSAl03U=;
	b=zi9kJi8T3MnVp8XKzVCnXTz3jvgG6x1hJyTmv09hl3ByHfK68s1yB+yPT8NzPBs4dOaeXN
	ROsmsOC/K4vmUbMLi0A/enkH312jhJyHuYslaJVdSFzByrr6vRnculF+unOTo/1WxEagPl
	CSILzOwvOxIS0B76hLE5F1VryXrEezU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KWYLNcKLx3+0aivMM/iiy/Bi4uErrneqsVlSTSAl03U=;
	b=sObZBCUZcRiLNKT0T6G2ZKJJE4h3FSG3hOER/PxVcxD/cK7YaCEUGIqAPUxC7bD2V9xv2S
	XthjMkPu4Iex7vCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KWYLNcKLx3+0aivMM/iiy/Bi4uErrneqsVlSTSAl03U=;
	b=zi9kJi8T3MnVp8XKzVCnXTz3jvgG6x1hJyTmv09hl3ByHfK68s1yB+yPT8NzPBs4dOaeXN
	ROsmsOC/K4vmUbMLi0A/enkH312jhJyHuYslaJVdSFzByrr6vRnculF+unOTo/1WxEagPl
	CSILzOwvOxIS0B76hLE5F1VryXrEezU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KWYLNcKLx3+0aivMM/iiy/Bi4uErrneqsVlSTSAl03U=;
	b=sObZBCUZcRiLNKT0T6G2ZKJJE4h3FSG3hOER/PxVcxD/cK7YaCEUGIqAPUxC7bD2V9xv2S
	XthjMkPu4Iex7vCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F6CA139C6;
	Mon,  4 Mar 2024 16:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uN9FDmjy5WUkegAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:10:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/2] nvme-fabrics: short-circuit connect retries 
Date: Mon,  4 Mar 2024 17:10:04 +0100
Message-ID: <20240304161006.19328-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.86 / 50.00];
	 ARC_NA(0.00)[];
	 SUBJECT_ENDS_SPACES(0.50)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[grimberg.me,wdc.com,suse.de,lists.infradead.org,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.54)[80.73%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_081018_489529_FEC534C2 
X-CRM114-Status: GOOD (  10.59  )
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

I've picked up Hannes' DNR patches. In short the make the transports behave the
same way when the DNR bit set on a re-connect attempt. We had a discussion this
topic in the past and if I got this right we all agreed is that the host should
honor the DNR bit on a connect attempt [1]

The nvme/045 test case (authentication tests) in blktests is a good test case
for this after extending it slightly. TCP and RDMA try to reconnect with an
invalid key over and over again, while loop and FC stop after the first fail.

[1] https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/

changes:
v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/

Hannes Reinecke (2):
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/rdma.c | 22 +++++++++++++++-------
 drivers/nvme/host/tcp.c  | 21 +++++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.44.0


