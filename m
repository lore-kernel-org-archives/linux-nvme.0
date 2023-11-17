Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F129C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=isIfkT+oZxwfDu8cR96UPoEe1IdDv84+LRxnhwt41ho=; b=GY2zmRhASKfannuU04k07CRlIe
	BgMQjPeFSWzfH0VvPtT8aybSunD+dPMMjEWCixgJAXdkcHwp6RQVEGw/0/wZEmh2Vpod1P2Jj53Ze
	CM2tSKmahkwnmgO25FkaoCCbyHEFno1sqJ2vdGgkMkNTvkCbeKmxiMqI4Ce7M8ZC1Zx3dyecddKOb
	kHSNem+7/1vU/c1pUBVhgq/cae7S86fVjgHBeknF0PeWeOZK8w6stISkO2VurVuCAao5MHlgFlcRv
	YSLaNlsr8lFOogt9Svb5Pu1R3Zmirpn/TxRxWmIdtYLXda1xwpQa+yR3oI64ntumcgeohZGaervfy
	LkLDa0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbj-006VMl-2G;
	Fri, 17 Nov 2023 12:05:59 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbh-006VLY-1u
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 12:05:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700222757; x=1731758757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7GuL9vIgDwAK9OU7Hdh+8V9imPbos4b/qdabvxGYJ+M=;
  b=kyNAobtqyCDPkls84NAS/4pPGJ+xWbZJ//kNKKtZfkgLP6CMbQ4r3nM5
   u2SFDABXY6NWnvVxRfaqBlqUgZd/OOcCJoL4sYcOLO0YTs6tiVWYSHPyJ
   vgxjxhwKjZNy50ePHuouO6B3DkrjiA5QVVIBBLWD0SWPRB/GWh6u9VFjP
   M4CK28xvhGoc5KTy/f21+pQolx30jEYxH9T7poVnws654Bhvk2/nXz7WK
   nH1afeC6fb/N4f5ZlJnyLwFTBtlsUcvIUFePHRPywm8N1oVGd6N4ypWIy
   v5xgb/3kvKo5xWTnnJiZVQ6oLdcOqOS8RksQXenooOsjdPT4Ngb1T4ww9
   Q==;
X-CSE-ConnectionGUID: FlAsN4prSoSDCxTuxQ9uyg==
X-CSE-MsgGUID: WPl98+p2QKSY7noN43twkw==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2616483"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 20:05:52 +0800
IronPort-SDR: /X0aJkVj272Ele8mcHcWraVKQCo8VOr7U9nDpAokY2hQyuoSCIi+zQpYrW9zu+XiNy70z/3TWr
 OjzP5ZjWocjB4xyURM/zk6RPjUSo2p65tddyIWV6627r0Esym32xB3XxuhfiKTI9bDcdRDQkqB
 LWalNZP9O1wSaVGD2Fnik/L39bbpNfz+/G+c1uxPBnIbHknswSFwBbZkIvac4wMvzmxHgKnTKb
 GWAG5TYBa3XXVKz5VXaQcOkJET6XDolfEqA6Z8eu0CHJOfpCvMznCEKq2gHa1IlN9rPRkqpM6T
 rZM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 03:17:16 -0800
IronPort-SDR: MdRz7VVGxq96nRl6HbozjHBGuA4duHlM3PsJOnnhCITN3yUypf4sW6dtaV6UTPpO5YVrgOPECX
 8RMnCNsrKwsQ/ZSJMvn+u1GnnEwKcb+7O/wfYTNhDhX7Z1kJ+Z+jdY3/RLf7LGb6dT0bvUlPx5
 n8nxup0s+KO0TbdO3wBmzwxrBArUCrEGH6GIBNb3MTTkncKQ8igOvizhj3zsssXKA42qlQeR+y
 /m2zQNFeX4lL5dGr0cxb+3sdSalfCtnMYYeD9UU1yRuw1TVNCizAwSnU4RLfq2xC6NZl9omJEa
 X94=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2023 04:05:51 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] nvme: Allow for pre-defined UUID and subsystem NQN
Date: Fri, 17 Nov 2023 21:05:48 +0900
Message-ID: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_040557_653395_EF69E6FE 
X-CRM114-Status: GOOD (  10.48  )
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

In the discussion to run nvme test group with real RDMA hardware, Hannes pointed
out that pre-defined UUID and subsystem NQN will be obstacles. To address them,
he created two patches in a PR [1]. I post the patches here for review by linux-
nvme and linux-block members.

[1] https://github.com/osandov/blktests/pull/127

Changes from v1:
* 2nd patch: remove only subsystem NQN part from the "nvme disconnect" output

Hannes Reinecke (2):
  nvme: do not print UUID to log files
  nvme: do not print subsystem NQN to stdout

 tests/nvme/003.out |  2 +-
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  4 +---
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  4 +---
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  4 +---
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  4 +---
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  4 +---
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  4 +---
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  4 +---
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  4 +---
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  4 +---
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  4 +---
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  4 +---
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  4 +---
 tests/nvme/021     |  3 +--
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  3 +--
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  3 +--
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  3 +--
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  3 +--
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  3 +--
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  3 +--
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  3 +--
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  3 +--
 tests/nvme/029.out |  2 --
 tests/nvme/033.out |  2 +-
 tests/nvme/034.out |  2 +-
 tests/nvme/035.out |  2 +-
 tests/nvme/036.out |  2 +-
 tests/nvme/041.out |  4 ++--
 tests/nvme/042.out | 14 +++++++-------
 tests/nvme/043.out | 16 ++++++++--------
 tests/nvme/044.out |  8 ++++----
 tests/nvme/045.out |  2 +-
 tests/nvme/048.out |  2 +-
 tests/nvme/rc      | 27 ++++++++++++++++++++++++++-
 54 files changed, 87 insertions(+), 125 deletions(-)

-- 
2.41.0


