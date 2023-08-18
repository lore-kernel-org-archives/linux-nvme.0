Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50D8C05052
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F+4pE3eEurIa+crq3qA6W7/bubTCplnACoCcJD+xN5k=; b=PFjcozDzCft2v/WYGJbfZVc6ns
	Nc7mAsuaF23iPZgMpwOAGgU3Cw+mBls9F40597q5ilwNymDbkxRYML92hhd7U46rxP7X+6T3rHPKs
	UKCUm8epoHrJ1JZhPG9RET2REb6okPtDVqiaa/rAiZirixLyenUBeynlwfGFOGtm5B8Wis1b7JSJ4
	cTdA3P6uz6sSfAeYisO3akt4X49kayWXaUT14susO6gO9tbeezbxbU4lROXJdKasXACidMe3N4rKc
	+mPxDmfORpS8BQqI+lGgA7ZuhZBLfbVv8akc0XmJMC/zvwgIY9ApBzwS9BgbgNxpyDxC2v+bu/kW8
	7s/Km1Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWwEh-0089jm-11;
	Fri, 18 Aug 2023 09:57:43 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWwEc-0089iQ-2W
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 09:57:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 416CB1F893;
	Fri, 18 Aug 2023 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692352657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F+4pE3eEurIa+crq3qA6W7/bubTCplnACoCcJD+xN5k=;
	b=wKfiyMH8jk6H5Z5GyN+6VVe2FgI13BNyUBKp0WOPxRpPWgucE56XNo6ujn3uIMCWAbP0Fh
	14Hl6p+NpL5f6nTxjg2xJpBnbzLk3uEJ571+CZYc6Dt9/rHxotZ0naBzlX8yKZer1MiwfT
	E89p7ZHSJdXcssDi2pFNbMxaLeKO6z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692352657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F+4pE3eEurIa+crq3qA6W7/bubTCplnACoCcJD+xN5k=;
	b=8/vmGOZLHG3qT9Pt4zNDFnf4wIeAsryWZ9/qw7W8uGvVfR+rdlrCTCwpy0js48t63KsCQs
	Bwa/Xb7TiAv2hfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34036138F0;
	Fri, 18 Aug 2023 09:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rRyiDJFA32SfNgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 09:57:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/1] Introduce nvmet target setup/cleanup helpers
Date: Fri, 18 Aug 2023 11:57:43 +0200
Message-ID: <20230818095744.24619-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230818_025738_998702_27C6D702 
X-CRM114-Status: GOOD (  10.71  )
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

Introduce helpers to setup nvmet targets. This is spin off from the refactoring
patches and the allowed_host patches [1].

Sagi suggested to record all resources allocated by nvmet_target_setup and then
later clean them up in nvmet_target_cleanup. I opted to figure out in
nvmet_target_cleanup what was allocated via the newly introdcuded _get_nvmet_ports
helper. The reason being, Hannes told me offline that he would like to add ANA
tests which will add some more ports to the subsystem. I hope with this
the code is more future proof.

BTW, while looking at this I saw that the passthru code is using the awkward
return value port when calling nvmet_passthru_target_setup. It seems some
more refactoring is in order...

[1] https://lore.kernel.org/linux-nvme/5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct/

Daniel Wagner (1):
  nvme: Introduce nvmet_target_{setup/cleanup} common code

 tests/nvme/003 | 14 ++-------
 tests/nvme/004 | 21 ++-----------
 tests/nvme/005 | 20 ++----------
 tests/nvme/006 | 19 ++----------
 tests/nvme/007 | 14 ++-------
 tests/nvme/008 | 21 ++-----------
 tests/nvme/009 | 16 ++--------
 tests/nvme/010 | 21 ++-----------
 tests/nvme/011 | 16 ++--------
 tests/nvme/012 | 21 ++-----------
 tests/nvme/013 | 16 ++--------
 tests/nvme/014 | 21 ++-----------
 tests/nvme/015 | 16 ++--------
 tests/nvme/018 | 16 ++--------
 tests/nvme/019 | 21 ++-----------
 tests/nvme/020 | 16 ++--------
 tests/nvme/021 | 16 ++--------
 tests/nvme/022 | 16 ++--------
 tests/nvme/023 | 21 ++-----------
 tests/nvme/024 | 16 ++--------
 tests/nvme/025 | 16 ++--------
 tests/nvme/026 | 16 ++--------
 tests/nvme/027 | 17 ++---------
 tests/nvme/028 | 17 ++---------
 tests/nvme/029 | 21 ++-----------
 tests/nvme/040 | 19 ++----------
 tests/nvme/041 | 18 ++---------
 tests/nvme/042 | 17 ++---------
 tests/nvme/043 | 17 ++---------
 tests/nvme/044 | 19 ++----------
 tests/nvme/045 | 18 ++---------
 tests/nvme/047 | 21 ++-----------
 tests/nvme/048 | 17 ++---------
 tests/nvme/rc  | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 34 files changed, 154 insertions(+), 519 deletions(-)

-- 
2.41.0


