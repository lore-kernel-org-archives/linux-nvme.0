Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24741C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ePKx4BwcJRYwxdp0ZKpJtcfK93EaEbUlz67UT9mwm0=; b=0148h8y8yxgmHXucyBCoZzs/0y
	yz/AEuhcAsho3Q7yUwS5jNXT6kyRUvrd9JVIpumdMRGO12ze8IbyIzmB4whLXgPOuygn73rWStzFN
	zf9C7LlaR60Fxoz7t4V9n7EbqEQadvgcaSJgtqET0xkwp+10VT1fSK6cWG3hV0x7KdTD+SJnYkCEL
	NAvmp3kmbSpz27SL835pmmDy1pUcpB5zdlPs2fUMX/ivJdcNFwFVbgdc1nlTBGn0RsgyfHimFE2cX
	6Z4j5sdeXwG0PgUexQUc7125efDTZtly7z9fC+opUuIPWo6WzPf13PQLu+vA5TQxk/TecrL+BtunJ
	qFotC6IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcuI-007w8c-4d; Fri, 10 Jun 2022 11:34:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctV-007vj2-Co
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id CF92521F8D;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ePKx4BwcJRYwxdp0ZKpJtcfK93EaEbUlz67UT9mwm0=;
	b=CMe80KqiYFlw8LZUEFFDuWqfpnoHuuICcP775dTDrIDaIBpEJ5C1u+CRugajEnoTCS0W/8
	GdoMPb3ems4FFlmX6fHlsBB4A9Ng4uPoXc6i0twDah+By4ETXZ4L6KHS7LOr0jEhbGBzYu
	0ZzDSf2LtcXumXxtkpScQRP19wrTi5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ePKx4BwcJRYwxdp0ZKpJtcfK93EaEbUlz67UT9mwm0=;
	b=w4fxCLCu8rJxLaOH3JuMezgCQEVNH78fZxpf3Yb/Y9Rd2bio9Msu9Gg4CzTalQjrwFh65S
	3CbD+c5qdvAWSjDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 97EBE2C141;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8921E5194A36; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 blktests 00/10] Testsuite for nvme in-band authentication
Date: Fri, 10 Jun 2022 13:33:14 +0200
Message-Id: <20220610113324.10294-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043337_723321_B9F13706 
X-CRM114-Status: GOOD (  13.12  )
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

Changes to v4:
   - Rebase to current HEAD
   - Use return code from 'nvme connect' instead of looking for
     the controller node

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
  nvme/040: create authenticated connections
  nvme/041: test dhchap key types for authenticated connections
  nvme/042: test hash and dh group variations for authenticated
    connections
  nvme/043: test bi-directional authentication
  nvme/044: test re-authentication

 tests/nvme/040     |  81 +++++++++++++++++++++++++++++
 tests/nvme/040.out |   7 +++
 tests/nvme/041     |  95 ++++++++++++++++++++++++++++++++++
 tests/nvme/041.out |  16 ++++++
 tests/nvme/042     |  89 ++++++++++++++++++++++++++++++++
 tests/nvme/042.out |  18 +++++++
 tests/nvme/043     | 106 ++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |   8 +++
 tests/nvme/044     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/044.out |  12 +++++
 tests/nvme/rc      |  97 +++++++++++++++++++++++++++++++++++
 11 files changed, 654 insertions(+)
 create mode 100644 tests/nvme/040
 create mode 100644 tests/nvme/040.out
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out
 create mode 100644 tests/nvme/044
 create mode 100644 tests/nvme/044.out

-- 
2.26.2


