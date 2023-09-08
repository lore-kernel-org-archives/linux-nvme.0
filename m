Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACF3EE57EC
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vtQhS/LNZOa2Zehyb/uDr9IeAGloiWgMqGb15srOMmE=; b=4diMQNW3g5ql4/4xkTcazuqGdc
	2MxF0TCzRXC4cNHF7ZyCVApnPUHzZ2PmZqFFq9jlLbUFVNoGvC+5AEvpHeaXivkwt4mjpgA8ZDg8k
	i3ejrGh1yaBP/RAOp81MPFNPX8pC1xs+OHscoU4dWxBLPiCtC1qT1NikHEkhLZX+p/sfNlLT+IYi5
	vOtccrGXzBOPEhgfZ+0qv62cKXh70yl0vvBatvgd8mYtcC7mMA8o5HF0ESPnTggsNhG9Q13oPBfgA
	1wkDSufoLsYaHOKj86FCHnF0LAyxOrAVydX1vdDhcY2rwTlLPV72+yzURVPdklsLr1PIPjeWIvp4A
	wCm76Rew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIP-00DRJp-1U;
	Fri, 08 Sep 2023 10:01:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIM-00DRIL-0d
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 10:00:59 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id EDF4C219C8;
	Fri,  8 Sep 2023 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694167253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vtQhS/LNZOa2Zehyb/uDr9IeAGloiWgMqGb15srOMmE=;
	b=0oE20TARslwYbeOQfdtn19NuPJjmJjAgonci/bpw/TAEzPuiE8klxCvgWAgKpvTAhQ3BkZ
	Z929TtRZ6jLEi8RpxrG7at/RX+W150lSfQwN4UyPCWV+lUSiC8hsjERWHZhXHvn/Lpr4vX
	jwqnPma8DU7iXmfz/Yt/HTLFnbRWaOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694167253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vtQhS/LNZOa2Zehyb/uDr9IeAGloiWgMqGb15srOMmE=;
	b=JueSyRq18xOyspoYsFU+LGuUP5kCrkvXZM5KTtByqbKZLYNrzGCZt2CHl6ZjaREgLdv/xp
	KNP7L6CAoqU3PbCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D73142C145;
	Fri,  8 Sep 2023 10:00:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C9EF651CC67B; Fri,  8 Sep 2023 12:00:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Date: Fri,  8 Sep 2023 12:00:46 +0200
Message-Id: <20230908100049.80809-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_030058_375159_399085BB 
X-CRM114-Status: GOOD (  11.33  )
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

Hi all,

there have been some very insistent reports of data corruption
with certain target implementations due to command retries.
Problem here is that for TCP we're starting error recovery
immediately after either a command timeout or a (local) link loss.
That is contrary to the NVMe base spec, which states in
section 3.9:

 If a Keep Alive Timer expires:
  a) the controller shall ...
  and
  b) the host assumes all outstanding commands are not completed
     and re-issues commands as appropriate.

IE we should retry commands only after KATO expired.
With this patchset we will always wait until KATO expired until
starting error recovery. This will cause a longer delay until
failed commands are retried, but that's kinda the point
of this patchset :-)

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme-tcp: Do not terminate commands when in RESETTING
  nvme-tcp: make 'err_work' a delayed work
  nvme-tcp: delay error recovery until the next KATO interval

 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/tcp.c  | 29 +++++++++++++++++++++++------
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.35.3


