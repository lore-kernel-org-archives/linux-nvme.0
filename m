Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF5C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xFwaA+wIKlaI/1MZziCKqYmigbddYHG0ysQJeHat2NQ=; b=DVWiCAe7dfy8w1h3wYlA3xTfUu
	i3Pbu8AWsSimd86Rh03tcnsYmxK8XAtc9ngDz8AC64T3K9BaL5xvZI0YzoITYEfYspIY/jm+z7Q3F
	hyA46fZhXp2RHLc6R5f05MSL56P4UXSsEYX7SF2ctuOH5L93ZEEaa8wnuz/vqM+N7MvYPRQ1q9r4T
	k3Tqdh51uUQZmh53EmHV5Gt/HaEjJJmtsHqqZgzTG8cR23hva6s0onJP00DeXxElI7bBvp4EAX333
	RVm+b/nF8yobTuTM47wSVOoOOZ2ZvLFrHYPA81xpfhF1TFoVl3QYHuchAsOAkr6Sai44tUM3M7MTd
	g8TeSgHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zb-008yZP-2O;
	Thu, 11 May 2023 14:10:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zY-008yXa-39
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1878721D0D;
	Thu, 11 May 2023 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xFwaA+wIKlaI/1MZziCKqYmigbddYHG0ysQJeHat2NQ=;
	b=Sc+NC2aajHFAzbYmOO6fTlXPzxkBWDfBIr78JPthJ7YBvYDDptO4TWrhTeyigv0ZhClQQM
	4KPMpny33kNgQTIPpTIO+FrPQraIS3ujxstls5Q618ad/ryaLXR5Rb98fEErOpcUNqUwRt
	aMDH7H1LB28pvcOxavfoOw6WQc29z3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xFwaA+wIKlaI/1MZziCKqYmigbddYHG0ysQJeHat2NQ=;
	b=bcI47lEChW3XoQxlvf3fHUXkBiP0YKG+Fj85MP1oyiZEix7tEYVIWecIRYskiIT+wPBK17
	NjevSfIfTAXgKCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB5F0134B2;
	Thu, 11 May 2023 14:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7d3pJDX3XGQ/PwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:09:57 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Date: Thu, 11 May 2023 16:09:42 +0200
Message-Id: <20230511140953.17609-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071001_168256_F88A37B5 
X-CRM114-Status: GOOD (  10.78  )
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

I've updated the series with the comments from the last round.  

changes
v4:
  - renamed test
  - updated commit messages
  - fixed whitespace damage
  - fixed ShellCheck reports
  - dropped 'limit number of random jobs'
  - fio runtime 'invinity' changed to 1d
  - fixed typo and updated documentation
  - added tags

v3:
  - 'nvme/rc' instead of 'nvme-rc' subject prefi	x
  - fixed spaces vs tabs indention
  - nvme/014, nvme/015 dropped -1 in #block calculation
  - common/xfs: use 'tail -1' instead 'awk'
  - common/xfs: no need for printf for integer division
  - nvme/035 limit disk size via nvme_img_size
  - set defaults to previous values: nvme_img_size=1G, nvme_num_iter=1000
  - nvme/032, nvme/040 let fio figure out image size
    set timeout to infinity
    cleanup fio
  - add documentation for nvme_tr_type, nvme_img_size and nvme_num_iter
  - limited nproc to 32 for num jobs for random fio job
  - drop job size limit calculation
  - drop nvme_num_iter from nvme/002
  - limit xfs fio job size inside _xfs_run_fio_verify_io()
  - added reviewed tags
  - https://lore.kernel.org/linux-nvme/20230503080258.14525-1-dwagner@suse.de/

v2:
  - made image size configurable via nvme_img_size env
  - make number of iteration configurable via nvme_num_iter
  - do not hard code test values
  - calculate job size
  - use runtime for fio background jobs
   - https://lore.kernel.org/linux-nvme/20230421060505.10132-1-dwagner@suse.de/

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230419085643.25714-1-dwagner@suse.de/

Daniel Wagner (11):
  nvme/rc: Auto convert test device size info
  nvme{014/015}: Do not hard code device size for dd test
  common/xfs: Make size argument optional for _xfs_run_fio_verify_io
  common/xfs: Limit fio size job to fit into xfs fs
  nvme{032,040}: Use runtime fio background jobs
  Documentation: Add info on nvme_trtype
  nvme: Make test image size configurable
  nvme: Add minimal test image size requirement
  nvme{045,047}: Calculate IO size for random fio jobs
  nvme{002,030}: Move discovery generation counter code to rc
  nvme{016,017}: Make the number iterations configurable

 Documentation/running-tests.md |   12 +
 common/rc                      |   30 +-
 common/xfs                     |   17 +-
 tests/nvme/002                 |    4 +-
 tests/nvme/002.out             | 3004 --------------------------------
 tests/nvme/004                 |    2 +-
 tests/nvme/005                 |    2 +-
 tests/nvme/006                 |    2 +-
 tests/nvme/007                 |    2 +-
 tests/nvme/008                 |    2 +-
 tests/nvme/009                 |    2 +-
 tests/nvme/010                 |    5 +-
 tests/nvme/011                 |    5 +-
 tests/nvme/012                 |    5 +-
 tests/nvme/013                 |    5 +-
 tests/nvme/014                 |   12 +-
 tests/nvme/015                 |   12 +-
 tests/nvme/016                 |    2 +-
 tests/nvme/017                 |    4 +-
 tests/nvme/018                 |    2 +-
 tests/nvme/019                 |    2 +-
 tests/nvme/020                 |    2 +-
 tests/nvme/021                 |    2 +-
 tests/nvme/022                 |    2 +-
 tests/nvme/023                 |    2 +-
 tests/nvme/024                 |    2 +-
 tests/nvme/025                 |    2 +-
 tests/nvme/026                 |    2 +-
 tests/nvme/027                 |    2 +-
 tests/nvme/028                 |    2 +-
 tests/nvme/029                 |    2 +-
 tests/nvme/030                 |   22 +-
 tests/nvme/031                 |    2 +-
 tests/nvme/032                 |    4 +-
 tests/nvme/034                 |    2 +-
 tests/nvme/035                 |    4 +-
 tests/nvme/040                 |   11 +-
 tests/nvme/041                 |    2 +-
 tests/nvme/042                 |    2 +-
 tests/nvme/043                 |    2 +-
 tests/nvme/044                 |    2 +-
 tests/nvme/045                 |    6 +-
 tests/nvme/047                 |    8 +-
 tests/nvme/048                 |    2 +-
 tests/nvme/rc                  |   40 +
 45 files changed, 183 insertions(+), 3079 deletions(-)

-- 
2.40.0


