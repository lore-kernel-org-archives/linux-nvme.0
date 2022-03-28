Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AFDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JK49g1ZrklO6bjG37B2lpSiYolyfcVQcdGKmlo1oylE=; b=RjvrcE02J4BpmNWY6DMWFINC4t
	LrGhS/F0naXox4fTIecRxf7g9DoJWbojHte22yMdw/LZrVRANqDUDkF7nHp0IQsU9ckSyFQm1y0SU
	dYMgigxDb7MoxjzYHmGg7AaY98yPseUuJKdujJWUU4yQcRMfU+b4eL/1CepJJnyIgyzsO/i+GYiaD
	L74KdMfQdJhferDI/pVT4P5yYKh7/eVYpNNNdtQ6Qsq3ei3QynyIYreAbjlZjAvXhnYlHrG6EAWF8
	NxIM7Z00/6j3wTfoJu9kKHb/5UmBG9sSFLUG+bIPYXpnKnuFnfgfCkeX/bBCG6wNLBYiPDZH6Asbv
	S72uC3TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTn-0089DQ-KU; Mon, 28 Mar 2022 10:20:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uT-O4
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 49023210EF;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK49g1ZrklO6bjG37B2lpSiYolyfcVQcdGKmlo1oylE=;
 b=PmBZMk9ufCy5rltuVij+FM3SdiRG5F/uCoz/YSXYbcI+I4e3MEeAiDZMr5aXOZ5p+PXBTe
 pSZIOjsTG9xB5VepZJ14wrPEHx7MaX4Vl3WE/RoaLc7IMTgZDHUUyc77YTFGBnKO1+SoWv
 D+bz/OiUqSYSir6EkPt6aV7u7U+cNts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK49g1ZrklO6bjG37B2lpSiYolyfcVQcdGKmlo1oylE=;
 b=ZdNjShJdkN71RYjHRjXQAvng5AjhfvTYyNHLVSz3AWRd9T0/4Wn6mo11+7AysGF8OstlT2
 HqbjLmx6Q2dlsLBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 34502A3B88;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 261B751939B9; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 blktests 00/10] Testsuite for nvme in-band authentication
Date: Mon, 28 Mar 2022 12:18:45 +0200
Message-Id: <20220328101855.73975-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_097207_9F08D061 
X-CRM114-Status: GOOD (  12.15  )
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

some people (Hi Sagi!) have complained that nvme in-band authentication
provide far too many configuration options to test it with some easy
commands. So here's a test suite for testing (most of) the various
configuration options and features.

As usual, comments and reviews are welcome.

Changes to v3:
   - Rebase to current HEAD

Changes to v2:
   - Merge first two tests
   - Add optional arguments to _nvme_connect_subsys()
   - Convert to use _nvme_connect_subsys()

Changes to v1:
  - Move tests to the 'nvme' directory
  - Check for authentication failure on invalid keys

Hannes Reinecke (10):
  nvme/rc: do not print error message when no nvme device is found
  nvme/rc: clear allowed_hosts subdirectory
  nvme/rc: clear hosts directory in _cleanup_nvmet()
  nvme/rc: add functions for in-band authentication
  nvme/rc: add more arguments to _nvme_connect_subsys()
  nvme/039: create authenticated connections
  nvme/040: test dhchap key types for authenticated connections
  nvme/041: test hash and dh group variations for authenticated
    connections
  nvme/042: test bi-directional authentication
  nvme/043: test re-authentication

 tests/nvme/039     |  83 +++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 tests/nvme/040     |  95 +++++++++++++++++++++++++++++++
 tests/nvme/040.out |  16 ++++++
 tests/nvme/041     |  89 +++++++++++++++++++++++++++++
 tests/nvme/041.out |  18 ++++++
 tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++
 tests/nvme/042.out |   8 +++
 tests/nvme/043     | 136 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |  12 ++++
 tests/nvme/rc      |  97 ++++++++++++++++++++++++++++++++
 11 files changed, 668 insertions(+)
 create mode 100644 tests/nvme/039
 create mode 100644 tests/nvme/039.out
 create mode 100644 tests/nvme/040
 create mode 100644 tests/nvme/040.out
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out

-- 
2.29.2


