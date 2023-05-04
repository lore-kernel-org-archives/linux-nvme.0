Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7BC77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zg7g2BOvhmWFc3dhiKasbnCc51IssmQS3By3r+3Vyvc=; b=Eu7uIzmId+OX+5sqLs6kvDfANT
	QggGDWENFuxC5tCh+HT0n/LIQ/orHFOe2QV3gaI4zgyqCSQlCXauv4FxLNR0tikP0M4AX1OAoXEJ9
	543D1f1Kfb5he7a7gIAwnZdtQ7CJKBRBp3FrLDhfYJI/DPOPmGQr4N9ZQOfHBNN9Yu4ef7wC/tzHF
	OV0tR408F77+Pbz3JyPUE1x8yLEj96r2kv8VObcu64XmbsJ2Y+MAzyKYjZX1E27Fuw2WVbveYUw6c
	hiAuvna2ucX42mEqnWhxZimbpKWnVyMAxtV6k1PXY5fuOnv1J7auk1RN8pcB9vCPQ6vmrXSwmoGYY
	kdiEuezQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puV1P-007Dfk-1Y;
	Thu, 04 May 2023 09:13:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puV1M-007Deb-2o
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 09:13:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7191433931;
	Thu,  4 May 2023 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683191583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zg7g2BOvhmWFc3dhiKasbnCc51IssmQS3By3r+3Vyvc=;
	b=MC29e/jxsi3vii+r1q6FTuTeZ9+h8d2o2nRI1YT0GHIb8b+3hY5D/cK/bB6+235xHyv3Zk
	xmwAzcsL6Z7Ut13HNOfM6sqA3t1xUUIR+PeeHvsazShHC9J0k3sxzDInfOjw9e1sByNXkN
	A+6XzUMKhiPoDYHdkpvkkuQ/MXa+cHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683191583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zg7g2BOvhmWFc3dhiKasbnCc51IssmQS3By3r+3Vyvc=;
	b=ACIw7b/wmBFXaY6PHIuXXxbUkH5YR7XgPgF79dscbQGvzVoOyB1BddNCfwMy2WE9gsV7Mt
	C3T5oV8jOfQ8LMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6127013444;
	Thu,  4 May 2023 09:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WK+qFx93U2TVTwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 0/9] Unifying fabrics drivers
Date: Thu,  4 May 2023 11:12:50 +0200
Message-Id: <20230504091259.29100-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_021305_054787_7CD05D36 
X-CRM114-Status: GOOD (  11.08  )
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

I've rebased on nvme-6.4 and gave it a bit of testing. Up to the last patch it seems to
work fine, at least blktests doesn't trigger any errors.

I've tried to split the pure moving code around part from the part where we need
to change some code. That means the last two patches highlight the problems I
run into with this attempt to implement the setup_transport() callback

changes:
v2:
  - move the complete ctrl state machine to fabrics.c
  - https://lore.kernel.org/linux-nvme/20230306093244.20775-1-dwagner@suse.de/ 
  
v1:
  - https://lore.kernel.org/linux-nvme/20230301082737.10021-1-dwagner@suse.de/


Daniel Wagner (9):
  nvme-rdma: stream line queue functions arguments
  nvme-rdma: factor rdma specific queue init code out
  nvme-tcp: move error and connect work to nvme_ctrl
  nvme-rdma: use error and connect work from nvme_ctrl
  nvme-fabrics: add fabric state machine
  nvme-tcp: replace state machine with generic one
  nvme-rdma: replace state machine with generic one
  nvme: move queue flags to middle layer
  nvme: introduce setup_transport()

 drivers/nvme/host/fabrics.c | 513 +++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  24 ++
 drivers/nvme/host/nvme.h    |  19 +
 drivers/nvme/host/rdma.c    | 720 ++++++++++--------------------------
 drivers/nvme/host/tcp.c     | 706 ++++++++---------------------------
 5 files changed, 913 insertions(+), 1069 deletions(-)

-- 
2.40.0


