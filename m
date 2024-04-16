Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F674C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ejaH279bWujEqlWdFlyIRnoUaRE9Pipkds2u7cL4Vu8=; b=pFHX5EnaKQFxJm3qI09dSYmXuG
	bIGjuI2TtPeL4bBCsSphKxIYlYKwLjYcs4eadqDenpM5NBZN3FXkSuV9CjP+P7sWtC0YTiMdKD5bb
	R/rD0SDvR+3em1eSbTgsvHCLGbxGDQV/8xWoGMK9RHTdxPpoD/xAEoah75o4lHrQ5S1X/Q3T2ybfO
	Y3sytb6rc+JvfZuRPlXlM19BAU7oAPr+7+fKhyqbetFPpjXDmhnSzaP9KgefTBw1xVF30kaw9au8t
	BTVq6N8rc9EcbvjM+C9IOuQ0cv9znlmMKFx0xWadW03Et9qZAU2T/v2Mi8iJv+Lg1Kdy7Yb3t7Lj8
	R9BURf5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6s-0000000Bncx-3E45;
	Tue, 16 Apr 2024 10:32:18 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6m-0000000BnZ6-1bcR
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263532; x=1744799532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QNdq5yF3hsDMuPnolar9tznpqVlfgKML9Uckv54AcRI=;
  b=DH5DL2IwmeZd6GRRDeWlFQ8pURsTKvDHMvLSxeisvD1lFhMABY1v/21B
   eIs7WyCVgUDuAjKko93vfIiJPvXcngKj+NW+41YIiuFAKpHiFiOVNFoqH
   2+nv+NodUEr4xrVDw0tpInQfyVqP95+OrB6YvCZ9fGwckxjeBbiNazTjI
   ihrsr/WQaApluPY5s6vNC8JMeAputx8AFo/72ildY01Bq2Zo8m4lkhZIf
   IrCoB8eowDfevUg0aHbGxDyOgYul5FNcaLVLyMS2jLPyU4+7cWNHWlwiL
   PBqhGxnv0j8RP/AC/zc5bJ3b61gefQO0eQRIL7zt2W/n1c1JYz55P2O/D
   A==;
X-CSE-ConnectionGUID: BwAoSCYYSsmrc0+vSLAOdQ==
X-CSE-MsgGUID: 6FF+E8p2TX2w9IKxy568ug==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796894"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:09 +0800
IronPort-SDR: bMVVNBJ3YZMxXNABsYB6LZvxZ7aeQSucmGBsX4+QHZbXpNUl4c9zy/x7GSVf4zC2NiE7nlaZyO
 ovyuwwPT6D+A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:48 -0700
IronPort-SDR: ElW5Wyn8+UAGQudRkvil1UmpiGhtRBjafHFuk5VEwRO+hWWqyH7CQQH6s2aCraRZ4rQqx3CmHd
 XKAfnrFBuyCKhg2G4ffo7tG7jxNz5Hk8KwUhgv33WYLMzQHsOrMaoXOFiqkJVTg8rMRVfJMI1O
 AGo6OOiPH/dDfpd+qKGTKjHJCkhbYqj4GTvUKCDK41Z54b7upESH5+ZsFrbofOFKpFCSLsTcAK
 vzzFLBPjFyUKTIKo6bN6XuCOk/8hSUjmhWw14vUNtS4AiVXaczSX+KOFaVaGe7YWVOWsdTYRN8
 J5c=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 00/11] support test case repeat by different conditions
Date: Tue, 16 Apr 2024 19:31:56 +0900
Message-ID: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033212_601392_826A0C28 
X-CRM114-Status: GOOD (  20.78  )
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

In the recent discussion for nvme test group [1], two pain points were mentioned
regarding the test case runs.

1) Several test cases in nvme test group do exactly the same test except the
   NVME transport backend set up condition difference (device vs. file). This
   results in duplicate test script codes. It is desired to unify the test cases
   and run them repeatedly with the different conditions.

2) NVME transport types can be specified with nvme_trtype parameter so that the
   same tests can be run for various transport types. However, some test cases
   do not depend on the transport types. They are repeated in multiple runs for
   the various transport types under the exact same conditions. It is desired to
   repeat the test cases only when such repetition is required.

[1] https://lore.kernel.org/linux-block/w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72/

One idea to address these pain points is to add the test repeat feature to the
nvme test group. However, Daniel questioned if the feature could be implemented
in the blktests framework. Actually, a similar feature has already been
implemented to repeat some test cases for non-zoned block devices and zoned
block devices. However, this feature is implemented only for the zoned and non-
zoned device conditions. It can not fulfill the desires for nvme test group.

This series proposes to generalize the feature in the blktests framework to
repeat the test cases with different conditions. Introduce a new function
set_conditions() that each test case can define and instruct the framework to
repeat the test case. The first four patches introduce the feature and apply it
to the repetition for non-zoned and zoned block devices. The following seven
patches apply the feature to nvme test group so that the test cases can be
repeated for NVME transport types and backend types in the ideal way. Two of the
seven patches are reused from the work by Daniel. The all patches are listed in
the order that does not lose the test coverage with the default set up.

This series introduces new config parameters NVMET_TRTYPES and
NVMET_BLKDEV_TYPES, which can take multiple values with space separators. When
they are defined in the config file as follows,

  NVMET_TRTYPES="loop rdma tcp"
  NVMET_BLKDEV_TYPES="device file"

the test cases which depend on these parameters are repeated 3 x 2 = 6 times.
For example, nvme/006 is repeated as follows.

nvme/006 (nvmet bd=device tr=loop) (create an NVMeOF target) [passed]
    runtime  0.148s  ...  0.165s
nvme/006 (nvmet bd=device tr=rdma) (create an NVMeOF target) [passed]
    runtime  0.273s  ...  0.235s
nvme/006 (nvmet bd=device tr=tcp) (create an NVMeOF target)  [passed]
    runtime  0.162s  ...  0.164s
nvme/006 (nvmet bd=file tr=loop) (create an NVMeOF target)   [passed]
    runtime  0.138s  ...  0.134s
nvme/006 (nvmet bd=file tr=rdma) (create an NVMeOF target)   [passed]
    runtime  0.216s  ...  0.201s
nvme/006 (nvmet bd=file tr=tcp) (create an NVMeOF target)    [passed]
    runtime  0.154s  ...  0.146s


Changes from v1:
* Renamed NVMET_TR_TYPES to NVMET_TRTYPES
* 1st patch: reflected comments on the list and added Reviewed-by tag
* 5th patch: changed NVMET_TRTYPES from array to variable
* 7th patch: changed NVMET_BLKDEV_TYPES from array to variable
* Reflected other comments on the list


Daniel Wagner (3):
  nvme/rc: add blkdev type environment variable
  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
    tests
  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type

Shin'ichiro Kawasaki (8):
  check: factor out _run_test()
  check: support test case repeat by different conditions
  check: use set_conditions() for the CAN_BE_ZONED test cases
  meta/{016,017}: add test cases to check repeated test case runs
  nvme/rc: introduce NVMET_TRTYPES
  nvme/rc: introduce NVMET_BLKDEV_TYPES
  nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
  nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES

 Documentation/running-tests.md |  16 +++-
 Makefile                       |   3 +-
 check                          | 129 ++++++++++++++++++++++-----------
 common/shellcheck              |   2 +-
 common/zoned                   |  22 ++++++
 new                            |  21 ++++++
 tests/meta/016                 |  29 ++++++++
 tests/meta/016.out             |   2 +
 tests/meta/017                 |  29 ++++++++
 tests/meta/017.out             |   2 +
 tests/nvme/002                 |   4 +
 tests/nvme/003                 |   4 +
 tests/nvme/004                 |   4 +
 tests/nvme/005                 |   4 +
 tests/nvme/006                 |   9 ++-
 tests/nvme/007                 |  28 -------
 tests/nvme/007.out             |   2 -
 tests/nvme/008                 |   8 +-
 tests/nvme/009                 |  36 ---------
 tests/nvme/009.out             |   3 -
 tests/nvme/010                 |   8 +-
 tests/nvme/011                 |  39 ----------
 tests/nvme/011.out             |   3 -
 tests/nvme/012                 |   8 +-
 tests/nvme/013                 |  43 -----------
 tests/nvme/013.out             |   3 -
 tests/nvme/014                 |   8 +-
 tests/nvme/015                 |  48 ------------
 tests/nvme/015.out             |   4 -
 tests/nvme/016                 |   4 +
 tests/nvme/017                 |   4 +
 tests/nvme/018                 |   4 +
 tests/nvme/019                 |   8 +-
 tests/nvme/020                 |  40 ----------
 tests/nvme/020.out             |   4 -
 tests/nvme/021                 |  10 ++-
 tests/nvme/022                 |  10 ++-
 tests/nvme/023                 |   8 +-
 tests/nvme/024                 |  40 ----------
 tests/nvme/024.out             |   2 -
 tests/nvme/025                 |  10 ++-
 tests/nvme/026                 |  10 ++-
 tests/nvme/027                 |  10 ++-
 tests/nvme/028                 |  10 ++-
 tests/nvme/029                 |   4 +
 tests/nvme/030                 |   4 +
 tests/nvme/031                 |   4 +
 tests/nvme/033                 |   4 +
 tests/nvme/034                 |   4 +
 tests/nvme/035                 |   4 +
 tests/nvme/036                 |   4 +
 tests/nvme/037                 |   4 +
 tests/nvme/038                 |   4 +
 tests/nvme/040                 |   4 +
 tests/nvme/041                 |   3 +
 tests/nvme/042                 |   3 +
 tests/nvme/043                 |   3 +
 tests/nvme/044                 |   3 +
 tests/nvme/045                 |   3 +
 tests/nvme/047                 |   4 +
 tests/nvme/048                 |   4 +
 tests/nvme/rc                  |  58 ++++++++++++++-
 62 files changed, 437 insertions(+), 379 deletions(-)
 create mode 100644 common/zoned
 create mode 100755 tests/meta/016
 create mode 100644 tests/meta/016.out
 create mode 100755 tests/meta/017
 create mode 100644 tests/meta/017.out
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

-- 
2.44.0


