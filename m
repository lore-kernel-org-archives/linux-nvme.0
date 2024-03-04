Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE3C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=; b=UILbBxt8m+AsX2PtDTy54m/U0H
	hjbnO1VmNtBBJ9c10IZpdSc7doPRr68I6gS7yhhCoGNSRZQJBLOTsC/bVJ7EiJDfQsIpSOffZe+E4
	JKvEd4aDmzBkhyXDbyveDMvpiSpNiLX6ZtQ2aZ3tJ7VO9YgSCHotqpy7wGF0Bx5f3+x7NaI/HD5Fe
	X3Y0rvPWhUN8EFDPYJrGlFteMJZvDLnPnJMcvQlXuWavm7zfQmCoGhmqI+HeLbEdyCLedwLi8b2bA
	4IlGC4DYw3thXkAUCK9VftXHBocjUu/DJX/owBsf8izYsG3s3hH5Yg7zw2HDMmtvzNtd/ZhOziNPp
	xr3PwmbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAwG-00000009m68-0vdq;
	Mon, 04 Mar 2024 16:13:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAw9-00000009m3d-3ySd
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:13:13 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28C51220E1;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=K6x5303QyomchmrMlz0IO3/wFjkYork8wQ3TbMf5n7OmD2bp9slrmAkr36Cmev0M+dBXrb
	oowD1Kyaa0QhNKKLg6nZaRfag8qyVaeGWw2FgSPn9RjHiuvEQWz9xUBDSwyBuvY6JrGu8D
	iCy+mhdbhDGlXWlkwz0yg7vN5fRlfGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=eeFc3Uv6ItbEz6nE+O8cBv8bTQ+ReHWztPn6DUzT2+NABSg0IjtGaJV5SgPgZZTHc04axc
	/JVe2TtQbHRPfqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=K6x5303QyomchmrMlz0IO3/wFjkYork8wQ3TbMf5n7OmD2bp9slrmAkr36Cmev0M+dBXrb
	oowD1Kyaa0QhNKKLg6nZaRfag8qyVaeGWw2FgSPn9RjHiuvEQWz9xUBDSwyBuvY6JrGu8D
	iCy+mhdbhDGlXWlkwz0yg7vN5fRlfGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=eeFc3Uv6ItbEz6nE+O8cBv8bTQ+ReHWztPn6DUzT2+NABSg0IjtGaJV5SgPgZZTHc04axc
	/JVe2TtQbHRPfqAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14AC7139C6;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9daIAxTz5WUXewAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:13:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with invalid key
Date: Mon,  4 Mar 2024 17:13:01 +0100
Message-ID: <20240304161303.19681-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.01 / 50.00];
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
	 BAYES_HAM(-0.89)[85.88%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_081310_232483_699A1227 
X-CRM114-Status: UNSURE (   6.84  )
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

The is the test case for

https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/


Daniel Wagner (2):
  nvme/rc: add reconnect-delay argument only for fabrics transports
  nvme/048: add reconnect after ctrl key change

 tests/nvme/045     | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/nvme/045.out |  3 +-
 tests/nvme/rc      | 17 +++++++++--
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.44.0


