Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E619C18E72
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yCzTDdITn7dGgsIFcuqVdV1I++MHpakn2R34Lu4d+jk=; b=V+p7rAYAtwYvRSmgQyjJx+D0PK
	4/JoHayVtpSa7sthv3Oo+wt8ikFK8QvzdlXTUUa3H1E56gQc1BEPgEM8H+cdORG1HrDLHkdKTKkTY
	G+LeJBVvD4JEk1yIwPPfjKaCWe3zYo9rANPa9ImJj02g6uWCBjiCct1cDDsbKiiOU6ZOxWt7hPiD9
	W2B1kbUnfQ+HBjzyeZ4hVyGncIIGcrt1lfIr+7qgEi2JRiRzvM6X+k5JwmuNM+W3VqOSHGE8bUvLb
	KInqy3m3LMO1HfmlXSjw4OT/bh+maAZ7NJrnxRy4ik/n506xXumbbxUrsR3H/IP+CyGMN8ydcTLK7
	OI4sIixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY1-00000003BvV-1Mvx;
	Wed, 24 Apr 2024 08:00:09 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXs-00000003Bmj-1xi5
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945600; x=1745481600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7u9FNA3ZfGP8XEDUmPTcZGwiQtZFPdXbcZ7OzAiOzzI=;
  b=GoFhvmFpaMHIhHmE0gXQJCRAPiN6c14b2P0mu8xzSVecKGGN/Tt92oFD
   ECsZNOg1iFvR4ComZCxaFT6I8l3A9jDSFkKrii6NnXN/js009nekxGi/9
   Lu8s4zsPrqUKtcDh1pMIzYLTtmXPKqXOnAIT3UaeSBWXwqkLEs3bzjlLg
   36UQ39seAhZj4pB+XfWxq14TvDArfP5GHTfihRnfJDYSr59AEZAEnz+z7
   1Ci064EzDbSVdCMmIlv/T63wVA2W4jjBnKgo6TqFbYMO98fLAgxUsZ3D0
   qePWd3cOPNX837aT2u8zv2iIJJEIgdiNdCIwm37yov1zbn2pbi13HooXZ
   w==;
X-CSE-ConnectionGUID: HFWdS4V1SwOoHoOc700Dzg==
X-CSE-MsgGUID: yweu8squQBqCr0C9IDCRCQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738255"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:56 +0800
IronPort-SDR: toumEvUQzFXy8/pPVAIDlBI9+o2oWNLQSgILUOzDM0WWkvqAJlysfmQHuEgDQ4+HbJ0lh351Ch
 b2qmtd1AEGnqT7/B9331eltfya1IViR2VYwcbPiHZeX8ig/SkpE9ojFrB1Cs9EHtuxnmczZM4w
 Yjq0N0xA3vq9rzkl3+n/hiUaemeEiR5+DrTlYojHwC638xrhGR+P6nNOQ90Png3zebHdCgpToa
 Y5WW3NE/9cJqWsUvXEzAm80oHG6FnRQX8ASggbF9qFjnXaBfZviAN9UX/LjmnvWuyov5n8RodA
 AJA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:06 -0700
IronPort-SDR: GbQKuRSrDUqLNB2yjJEh+EXn7A40K09xkSKttjnPiHhYP0TAKKMKhLoBxzid/sB9gzf1l8ZHW/
 BXSLxd2yOSxgzAMbv1rKZuihbioltev6UvdrlFkzeSJtXmSUqKn0n961DHnZrENyrYi+1yrkgO
 9wkGcLKIc2Kuaohto5lk5XeNcmDoWHNLhzIGnM7nFqsgS4XXBimEi3VWa7cPuSntC758zzFVvg
 QB27hdVsNT1toqmAd4tTaaJDzRDW+chrA8HxOqG3JSIUV+TBq8Oo8TsjZTwpCMNrj4HDCAK3h/
 T/Q=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 00/15] support test case repeat by different conditions
Date: Wed, 24 Apr 2024 16:59:40 +0900
Message-ID: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010001_066917_127D0537 
X-CRM114-Status: GOOD (  23.85  )
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
repeat the test case. This series applies this feature to nvme test group so
that the test cases can be repeated for NVME transport types and backend types
in the ideal way. For this purpose, this series introduces new config parameters
NVMET_TRTYPES and NVMET_BLKDEV_TYPES. Taking this chance, it renames other
lowercase config parameters nvme_img_size, nvme_num_iter and use_rxe to
uppercase to follow the guide for environment variables.

The first four patches introduce the feature and apply it to the repetition for
non-zoned and zoned block devices. The fifth patch introduces a helper function
to prepare config parameter rename to uppercase. The following seven patches
apply the test case repeat feature to nvme group. Three of the seven patches are
reused from the work by Daniel. The last three patches rename the config
parameters. The all patches are listed in the order that does not lose the test
coverage with the default set up.

As an example of the repeated test run, let's say NVMET_TRTYPES and
NVMET_BLKDEV_TYPES are defined in the config file as follows:

  NVMET_TRTYPES="loop rdma tcp"
  NVMET_BLKDEV_TYPES="device file"

In this case, the test cases which depend on these parameters are repeated
3 x 2 = 6 times. For example, nvme/006 is repeated as follows.

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


Changes from v2:
* 5th patch: added to prepare for the parameter rename
* 6th patch: modified nvme_trtype description and added NVMET_TRTYPES check
* 13-15th patches: added for the parameter rename
* Applied Reviewed-by tags
* Rebased to the latest master branch tip

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

Shin'ichiro Kawasaki (12):
  check: factor out _run_test()
  check: support test case repeat by different conditions
  check: use set_conditions() for the CAN_BE_ZONED test cases
  meta/{016,017}: add test cases to check repeated test case runs
  common/rc: introduce _check_conflict_and_set_default()
  nvme/rc: introduce NVMET_TRTYPES
  nvme/rc: introduce NVMET_BLKDEV_TYPES
  nvme/{002-031,033-038,040-045,047,048}: support NMVET_TRTYPES
  nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
  nvme/{rc,010,017,031,034,035}: rename nvme_img_size to NVME_IMG_SIZE
  nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
  nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE

 Documentation/running-tests.md |  33 ++++++---
 Makefile                       |   3 +-
 check                          | 129 ++++++++++++++++++++++-----------
 common/multipath-over-rdma     |   5 +-
 common/rc                      |  27 +++++++
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
 tests/nvme/006                 |   8 +-
 tests/nvme/007                 |  27 -------
 tests/nvme/007.out             |   2 -
 tests/nvme/008                 |   8 +-
 tests/nvme/009                 |  36 ---------
 tests/nvme/009.out             |   3 -
 tests/nvme/010                 |  10 ++-
 tests/nvme/011                 |  39 ----------
 tests/nvme/011.out             |   3 -
 tests/nvme/012                 |   8 +-
 tests/nvme/013                 |  43 -----------
 tests/nvme/013.out             |   3 -
 tests/nvme/014                 |   8 +-
 tests/nvme/015                 |  48 ------------
 tests/nvme/015.out             |   4 -
 tests/nvme/016                 |   6 +-
 tests/nvme/017                 |   8 +-
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
 tests/nvme/031                 |   6 +-
 tests/nvme/033                 |   4 +
 tests/nvme/034                 |   6 +-
 tests/nvme/035                 |   8 +-
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
 tests/nvme/rc                  |  74 ++++++++++++++++---
 tests/srp/rc                   |   2 +-
 65 files changed, 493 insertions(+), 404 deletions(-)
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


