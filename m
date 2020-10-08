Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B40C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C96321D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="czwnw6cB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="fLcIjlv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C96321D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tlxsDxGFR/Dh8SD/3ZgHW2a3q7x7FC/GYrMywTpX620=; b=czwnw6cBaLZjrRQ3q6reH9vCfw
	6bTEUqO2gQYS3tWGKS2fVXed646/u/sD8Uvd9pZk2sEH3SLUfLfBBlRXe326bZz0aN7FTcAxWlWmO
	21f3vKqP4DUyA3HGrEzNxNgURcS340DoP2x5NdyIhVheazF1WA3Mbi+B+m9tQbuRMC8csz+7yq7eu
	YvxabXzj+ht9L8hfKtJCEEnPtyQYgZ22SoHsNqeUL+scCPQacBU51Kr1f6U2lk8R3KNn9YZ7EdDC0
	HVRo2z6sMJuQdpuzDKXguuCPbvg7zrDDf9RiAnfAp4YicasReeKTCPThhoKBppDg7S3VMB1OJGvet
	1b9NeOgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYy8-0003Nq-Lt; Thu, 08 Oct 2020 16:40:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy2-0003Jn-CS
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tyFGCWU6L6lDBY3zLY1rfePLMMRW/v3T/hGVwL8WZnY=; b=fLcIjlv5U0a6Bu7IdnvtONnG51
 0+0ExI436um7EWaC5+iRkecbPtKZ8v3leJB5C/djsCzsMoaATmNYPpwdnXjsntysrUrSOnSKLf5q/
 xr/IzuNMSlWK3ybkenKVGPNjtH4q5VONjWBDLs001Zgos9k7fH85UPXJDvxGNO+OZ8Cn8yusECHDh
 IXqG+frSwwscmjuuWYTn1WjVZ6Y4BTl0ZJQuKrLkUaUfgHSH+UEyuie6H32TBA5vz04dlPHJ+G8WT
 5jVxpqDBDUJcSlXFB31bru8LoJ6UhJ/ZHY0Hy+Xh0D2R6Ic/3te7I1+FYX95QSAl2gbQTPr/NfM4U
 pov27J9A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxz-0000if-Pp; Thu, 08 Oct 2020 10:40:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxy-0003HG-Lm; Thu, 08 Oct 2020 10:40:30 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:13 -0600
Message-Id: <20201008164024.12546-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124034_483739_8A5BDF29 
X-CRM114-Status: GOOD (  14.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This series adds blktests for the nvmet passthru feature that was merged
for 5.9. It's been reconciled with Sagi's blktest series that Omar
recently merged.

This series is based off of the current blktests master and a git repo is
available for this here:

https://github.com/Eideticom/blktests nvmet_passthru_v3

Thanks,

Logan

--

Changes in v3:
- Fixed a nit with variable initialization in patch 5 (per Chaitanya)
- Replaced use of printf with echo (per Chaitanya)

Changes in v2:

- Rebased on latest blktests master and changed to use the common
  helpers Sagi introduced in his series
- Collected Chaitanya's reviewed-by tag

--


Logan Gunthorpe (11):
  common/fio: Remove state file in common helper
  common/xfs: Create common helper to check for XFS support
  common/xfs: Create common helper to verify block device with xfs
  nvme: Search for specific subsysnqn in _find_nvme_loop_dev
  nvme: Add common helpers for passthru tests
  nvme/033: Simple test to create and connect to a passthru target
  nvme/034: Add test for passthru data verification
  nvme/035: Add test to verify passthru controller with a filesystem
  nvme/036: Add test for testing reset command on nvme-passthru
  nvme/037: Add test which loops passthru connect and disconnect
  nvme/038: Test removal of un-enabled subsystem and ports

 common/fio         |  1 +
 common/rc          |  8 +++++
 common/xfs         | 33 +++++++++++++++++++
 tests/nvme/004     |  2 +-
 tests/nvme/005     |  2 +-
 tests/nvme/008     |  2 +-
 tests/nvme/009     |  2 +-
 tests/nvme/010     |  3 +-
 tests/nvme/011     |  3 +-
 tests/nvme/012     | 23 ++++---------
 tests/nvme/013     | 21 +++---------
 tests/nvme/014     |  2 +-
 tests/nvme/015     |  2 +-
 tests/nvme/018     |  2 +-
 tests/nvme/019     |  2 +-
 tests/nvme/020     |  2 +-
 tests/nvme/021     |  2 +-
 tests/nvme/022     |  2 +-
 tests/nvme/023     |  2 +-
 tests/nvme/024     |  2 +-
 tests/nvme/025     |  2 +-
 tests/nvme/026     |  2 +-
 tests/nvme/027     |  2 +-
 tests/nvme/028     |  2 +-
 tests/nvme/029     |  2 +-
 tests/nvme/033     | 67 +++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  7 ++++
 tests/nvme/034     | 35 ++++++++++++++++++++
 tests/nvme/034.out |  3 ++
 tests/nvme/035     | 37 +++++++++++++++++++++
 tests/nvme/035.out |  3 ++
 tests/nvme/036     | 37 +++++++++++++++++++++
 tests/nvme/036.out |  3 ++
 tests/nvme/037     | 35 ++++++++++++++++++++
 tests/nvme/037.out |  2 ++
 tests/nvme/038     | 36 ++++++++++++++++++++
 tests/nvme/038.out |  2 ++
 tests/nvme/rc      | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 38 files changed, 419 insertions(+), 58 deletions(-)
 create mode 100644 common/xfs
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out
 create mode 100755 tests/nvme/035
 create mode 100644 tests/nvme/035.out
 create mode 100755 tests/nvme/036
 create mode 100644 tests/nvme/036.out
 create mode 100755 tests/nvme/037
 create mode 100644 tests/nvme/037.out
 create mode 100755 tests/nvme/038
 create mode 100644 tests/nvme/038.out


base-commit: 20445c5eb6456addca9131ec6917d2a2d7414e04
--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
