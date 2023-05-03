Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18FEC77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6YJe18H1iAIRYoNmcH07vSIQyLGOOyZsOInNYrr5z9A=; b=scOiz0Ot0fYp1NGa4BrVVnRIyH
	DUj7vg2XAsmFI5rthX7VLOA+cuRqKcpYJOSXcTNthUIj/NdeFWi7GdZ8p19kHW/V2qfpoh8Mvp3NH
	SxZMHDsKXHQZSE0HujBw7VWmoPGiPOLJgxyImrWaVYOmZkE6zEsgFAKGZLYheFWH3uUOD5S9AgFof
	94mvch7J4LCBCQ4yQblx+/hlKJMQdc3GOBxmHmGFYgTMLKZjbKvkeBHg2EF0xT1m3aKzhUkGPMDwF
	/wB6ij7LmxSJW7x4CAsjlnXZyHH/C5gd1jFCEH/YvJ1DRKoY52bvUDKYNdYKfI2DmyPDJYFieyx0u
	LfFt6WLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SM-003kIU-26;
	Wed, 03 May 2023 08:03:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SC-003k8p-39
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8441200AC;
	Wed,  3 May 2023 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6YJe18H1iAIRYoNmcH07vSIQyLGOOyZsOInNYrr5z9A=;
	b=FVbY187ssjjfX7yvlbpc0MWurU6d3iFWBY8+D4c5j07PipzL6G/n2eMFU/AF2KbEDDwr2K
	RjGDn3Fm5YfhJyAsV7uO0WEIysfAxb2dGyLJxAvDGHUODapWM+8rK4pTSuXrzgZrfz9NLz
	03KlUDb7dTY8/n05L93d9YutkeuWmhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6YJe18H1iAIRYoNmcH07vSIQyLGOOyZsOInNYrr5z9A=;
	b=Z8KkrNa5TpoNJNeOp3eMl19mQA4zWMWA3gKVq7WqyOhmOzGHBsEVvyEaSqeV9JTFB7KgaG
	sZNRsvwK6qR9BTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6EDB1331F;
	Wed,  3 May 2023 08:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XFi4KD0VUmQjYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 00/12] nvme testsuite runtime optimization
Date: Wed,  3 May 2023 10:02:46 +0200
Message-Id: <20230503080258.14525-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010313_157960_F6BFC196 
X-CRM114-Status: GOOD (  14.52  )
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

Addessed all the comments I got for v2. If I didn't response to all
comments that just means I silently acked them and updated the series
accordingly. Hopefully I didn't miss anything.

I've changed the defaults back to the previous hard coded defaults. That means
the default image size is 1G and the many iterations count is 1000 (nvme/002
always runs 1000 as this is necessary to actually test the page overflow).

This time I also made sure the nvme pci tests nvme/030... get executed. With the
defaults the loop transport gives

loop:
  real    13m17.778s
  user    0m27.396s
  sys     5m48.958s

and with nvme_img_size=16M nvme_num_iter=10 it gets down to

loop:
  real    6m2.588s
  user    0m13.450s
  sys     1m55.236s

Althought some of the tests get skipped (nvme/012, nvme/013) with such small
test image sizes.

The values for tcp and rdma are similiar

tcp:
  real    8m29.010s
  user    0m14.068s
  sys     2m57.573s

rdma:
  real    8m46.285s
  user    0m13.843s
  sys     2m2.662s

get down to

tcp:
  real    2m18.117s
  user    0m5.928s
  sys     0m42.649s

rdma:
  real    2m5.546s
  user    0m6.474s
  sys     0m37.818s

The fc transport is not passing all tests and hence let's ignore it for now.

Obviously you can also turn the values in the other direction and increase the
tests 'coverage'.

Thanks,
Daniel


changes:
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


Daniel Wagner (12):
  nvme/rc: Auto convert test device size info
  nvme: Do not hard code device size for dd test
  common/xfs: Make size argument optional for _xfs_run_fio_verify_io
  common/xfs: Limit fio size job to fit into xfs fs
  nvme: Use runtime fio background jobs
  Documentation: Add info on nvme_tr_type
  nvme: Make test image size configurable
  nvme/rc: Add minimal test image size requirement
  common/fio: Limit number of random jobs
  nvme/rc: Calculate IO size for random fio jobs
  nvme/rc: Move discovery generation counter code to rc
  nvme: Make the number iterations configurable

 Documentation/running-tests.md |   12 +
 common/fio                     |    3 +-
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
 tests/nvme/032                 |    5 +-
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
 46 files changed, 185 insertions(+), 3081 deletions(-)

-- 
2.40.0


