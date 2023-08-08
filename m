Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939C3C001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oqNU0bW80Dtqeb91FmOO4Mk+HjGPIZ7T1eI+iwui6SM=; b=H7m1ZuezIgUtmtyZSrs52r8Upe
	AVVvtgD0Loy3aCU7BX1T2Ju/f4pov6fjCojFMi5nwYEJ+mBCVCOJxoJxJ8Y6sWaGG3YvSJezz5O/s
	lDjS+71DJD7PPy7w63wvJektyfce5TQuD+MyypFOxNHE9MkQjWfhyAfqDAnGKtUokb6R8ZfdODfOt
	CJeaipLVNj5Llb9VT91/Jf5p6jn7D8Anf5HNIdaVrr+Ig0qriZNs8yT5xpHAp2o7yR61b5fiWh3R4
	fUpeCOz66S3MElyKmt/7aA6Sciq9ozzBmHOFXPIfb4noopvOm1rxHYWFVbLr0eFg7huZdwbyZEDYg
	CKC60aoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGqH-001rMp-30;
	Tue, 08 Aug 2023 07:09:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGqB-001rLp-38
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 07:09:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A87EE20314;
	Tue,  8 Aug 2023 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691478553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oqNU0bW80Dtqeb91FmOO4Mk+HjGPIZ7T1eI+iwui6SM=;
	b=DCktnY6KCstWrmt3OnfxTsTVf2DiwYuplbDv7dT9YfoTyhnyaV5xFYXI4l+KFUzYTdI6dp
	WtY0P/0Qmq/en4wqZZ5I+yzMqOa00zxx/e7COYby0UyZLbFsQck5xW1qVdi30NL+D35ObH
	k0ikM0Lx/A4kmsy63hEGXfo9oZ5iAwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691478553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oqNU0bW80Dtqeb91FmOO4Mk+HjGPIZ7T1eI+iwui6SM=;
	b=AzFfnm7NETDBIMbrAbyRx3SQXkoCjxWeByGu/HqgMLHwu8fpJP7d/pxdea2uoEsBjtsbe4
	2ehDzR90s5vh+VDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AF2F13451;
	Tue,  8 Aug 2023 07:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id j/XMJBnq0WRZVgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 07:09:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v2 0/2] Do not pass disable_sqflow if not supported
Date: Tue,  8 Aug 2023 09:09:05 +0200
Message-ID: <20230808070907.18834-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_000916_149505_46466804 
X-CRM114-Status: UNSURE (   8.38  )
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

Follow up on the discussion in [1]

[1] https://lore.kernel.org/linux-nvme/676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me/

Sagi Grimberg (2):
  fabrics: Read the supported options lazy
  fabrics: Do not pass disable_sqflow if not supported

 src/nvme/fabrics.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.41.0


