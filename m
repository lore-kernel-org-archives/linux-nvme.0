Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4071C64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762A920663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZRrfrTez";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A5hidZXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762A920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3rZ+x9/WrypOHzLcX4MXEugmnCFt3Dv+sTb+K+53PXI=; b=ZRrfrTez6mGMX/mFMiQ3nHCb8P
	ot/UiwjznSybQ38wVoa01Pwny28KmSCsfyMqf08hZkf90JnGH5SlKytn4NHogAK6n4T6Riq5TZZ74
	FjTfcsxMiiEQviVZAta6i3hB4WXSBGZn6Sa0x1EGPrEtsOu8V7kZzbOfAD7d+/CLmEnoFA2JdLSqz
	SRAUQ02C0k3QvrG5LepZACHQt6/k5LJy5/E24lEXOvX6ZshukJTW+0uhJCWbVeQP5abX4Yt2XejWd
	P1eTDJnIQT3hZ53p5pCeAL9aYf1wFLuTs6NWlDFI7E3d2u7ThUrQtvTIARWebHD4xaDaHLIpjd5Fr
	cMcHU8wA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZsQ-0000Uj-3L; Mon, 30 Nov 2020 03:29:22 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZsL-0000TG-SX
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606706957; x=1638242957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ag4Kyb+Xfg9A3G4ksCYAMaUKqGExJXD9X+MkHXHamDY=;
 b=A5hidZXKNPmYUttcMTO0JTqoTol1PrwUJW43bozviuAk8tUmqCi/qDVx
 KlOt/+jgut5EEtAGvAdxRUzczMhEKtHwJKAVZ/GCHLhoG4MYozHfJm+pj
 iSzkLwHawk8G/bs9V2620Zx1hk1FFjLzq5XEiieScSg9KRDW4MWsTqpIy
 9Ka2bGevAeEJ5ppQA/lKw/rhbGer/PpUUWHOjz1HssSx5BVMdEUcdky3R
 ymHfGIFiyTSYHJNH6FtAlWnsQYGhjU3Z0MtbkUsPaTrHuM4Lkgil7XFvp
 6l5mPnaf3mEojSiE6g4UiC0ctKvahxy9eUcs3IqwZeeaOONQNJ2WLdV01 w==;
IronPort-SDR: k+8cNAlmpW4Yib3uNZkMliakws1Zfo2ykj8XWu19sm7TdrZQNL6/6K3K/hFhN6TccqFHUqMOaj
 DDmLvlTlgqSpWjYerr/bPtoll7aFqNW+SScxFh4qS36xHVDrTCaUPsoIyoRhgJUwjNTLqxHJMx
 TR3PacPz0ILr+AAkGNgDA4OhD5uCepIS2H0YB3Vr5fOPgR6UYAgaSF6GNi3GbvCtQH3GirE28B
 JQ/u/Vj8DdqZeAZyg95vAD0l+SKqDkE/VBgjrg82srtj0MKg8/eILI52cr96m0z9M5Vtl/9H0p
 fXQ=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="263892471"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:16 +0800
IronPort-SDR: x4eAjGMcD/gr1TQ7Q2jvXqDIdHjB4sYaZmjixcYb9TaB37HbQrQgHQOU5UoE05g4Rkfn9ue7mg
 x7UVax79cGFtp+NnUKq0S33JcS8aSp5WI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:13:30 -0800
IronPort-SDR: vi2W3aBmFtIvVJr54lg+DhWKKgvV+JP7rqEarA+hUsEYRGnGqs+GHmxEQFbpSM7bFDsVQaBIO2
 JQYEVtLJrtqQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:16 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/9] nvmet: add genblk ZBD backend
Date: Sun, 29 Nov 2020 19:29:00 -0800
Message-Id: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_222918_163897_83C94CD9 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the ZNS mode with the passthru backend. There is no
support for a generic block device backend to handle the ZBD devices
which are not NVMe devices.

This adds support to export the ZBD drives (which are not NVMe drives)
to host from the target with NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for 
patch-series overview.

I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF
namespace with nvme-loop transport. The same testcases are passing on the
NVMeOF zbd-ns and are passing for null_blk without NVMeOF .

Regards,
Chaitanya

Changes from V1:-

1. Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2. Mark helpers inline.
3. Fix typos in the comments and update the comments.
4. Get rid of the curly brackets.
5. Don't allow drives with last smaller zones.
6. Calculate the zasl as a function of max_zone_append_sectors,
   bio_max_pages so we don't have to split the bio.
7. Add global subsys->zasl and update the zasl when new namespace
   is enabled.
8. Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
   move functionality in to the report zone callback.
9. Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10, Allocate the zones buffer with zones size instead of bdev nr_zones.

Chaitanya Kulkarni (9):
  block: export __bio_iov_append_get_pages()
	Prep patch needed for implementing Zone Append.
  nvmet: add ZNS support for bdev-ns
	Core Command handlers and various helpers for ZBD backend which
	 will be called by target-core/target-admin etc.
  nvmet: trim down id-desclist to use req->ns
	Cleanup needed to avoid the code repetation for passing extra
	function parameters for ZBD backend handlers.
  nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
	Allows host to identify zoned namesapce.
  nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
	Allows host to identify controller with the ZBD-ZNS.
  nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
	Allows host to identify namespace with the ZBD-ZNS.
  nvmet: add zns cmd effects to support zbdev
	Allows host to support the ZNS commands when zoned-blkdev is
	 selected.
  nvmet: add zns bdev config support
	Allows user to override any target namespace attributes for
	 ZBD.
  nvmet: add ZNS based I/O cmds handlers
	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append.

 block/bio.c                       |   3 +-
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   1 +
 8 files changed, 524 insertions(+), 16 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
