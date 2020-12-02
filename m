Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D771C64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:22:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673BB221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673BB221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TTDXfwzJP1G14Jn9/49ZYwJ8LxCnJECPSzR5+iHdYdg=; b=vk2GfGsh7RbdPvLQ+Z4YbzvAGN
	RQ30GdVO1rSCutoITrJtah329xDX+/VJKxNhuZvtLpWquFYm6yZ+iW4ki7/Vd++vu4N5jcqagKxty
	dLnTqbb1IAOSesDIm+dZ0xMN0+FiouNIqy39wyiDI+taroAsb/ASUs9d5h+CgynuQ52RYGu/ODzYG
	EnbGcT4d3xwEuQHknu7TvyKINDq9HxgU8GLpLIbRCEpYs/sXijOfQI8IFkHAnOXr29+ncfKb2cCdM
	D+Gqgm7Rb7xyY3zzOAa0QRkiLfU7A3Tt9fKZmvuS5NDrDnybvZPZ7g+RBFWmWS3CpgThwq2fL2PVf
	5gF+GpFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLXC-0005OQ-0r; Wed, 02 Dec 2020 06:22:38 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLX8-0005NZ-NE
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890154; x=1638426154;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+U3GdEDI7ytLsMd0GtYdOsJ0q+8o/7LcYvYBSUjzkp4=;
 b=Po3nCXWQP45OKbquRq6Gb59mZ3stTtrdFc65gT5hJvM1vcH8qZCOeeFy
 SWH4rc3+M2EMe2s67CBmScyF6A+7JtAXXM/czyqR/CrTLT35a/x+fiUHS
 BamqW8m7bqkHqHDfrnbV4OB67ArcBbk38yL8JavLwFjEmTNsF8DydsIFm
 pp+RwetEQC+h8TAuuoW3Mwu55yDCIzTDF3LOSOO8bKcX7og8CRiYndCFY
 pKEHF0YzfJW4KVRbU+XZ6UMoXpFJxpL4wczn8YKzMxbBi7wlez5Xv0fl+
 SeRte8ScPvqywUv7OI+OyD+OAb+8WiMQcGLihDISpUx40hZf0n6CZU2lb Q==;
IronPort-SDR: ZgKOrosAoHqsQlRy8zkpHwT3KebvduVzVjc2J/yBTFto0bat/pUmXCDJi9TCRtXGQTXWsFWUB/
 wOr3Z2hlBxZzKayOr4s4GlC0MQsoxdDVdWlJiPzgpRja3K77AGWtU9cVp01f/A+8/Gog+EGAnz
 UWuPUQN9mFlKTeK2ts+V8VXN9HeUc393SATvIvMiEazsHW4B5kAu24yC6m8czdpIsph4bc5p9/
 SIOSufCgfPj6IaBbwzeZzwOxVk845aQsUTdtOnGVWHXF+A/xirNwFMGoZafWRfY12h93VTTtCi
 UO4=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="154060431"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:22:30 +0800
IronPort-SDR: Rgru+ZmRUO4VKa9IMqrF4CtlheNy/IDkAqnMMwxG/QxAf1evLFekhvcXpF9umnf22qNu2sm6J+
 LZG/RcpKRpx3zcCHs0svIaEC0gkvHBlFc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:08:05 -0800
IronPort-SDR: 5gaJgnyq4tJtGlrJGLKj6SIPZVek34FGwWDOHm6IAhCvvCrlVHLCVT8RUdprTfoNOIAj2emDiY
 opmpLnYz9k3w==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:22:30 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/9] nvmet: add ZBD backend support
Date: Tue,  1 Dec 2020 22:22:18 -0800
Message-Id: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012234_972055_DAA211DC 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru
backend. There is no support for a generic block device backend to
handle the ZBD devices which are not NVMe protocol compliant yet provide
NVMe ZNS interface.

This adds support to export the ZBDs (which are not NVMe drives) to host
the from target via NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for 
patch-series overview.

All the testcases are passing for the ZoneFS with ZBD exported with NVMeOF
backed by null_blk ZBD and null_blk ZBD without NVMeOF.

Please consider this for nvme-5.11.

Regards,
Chaitanya

Changes from V3:-

1.  Get rid of the bio_max_zasl check.
2.  Remove extra lines.
4.  Remove the block layer api export patch.
5.  Remove the bvec check in the bio_iov_iter_get_pages() for
    REQ_OP_ZONE_APPEND so that we can reuse the code.

Changes from V2:-

1.  Move conventional zone bitmap check into 
    nvmet_bdev_validate_zns_zones(). 
2.  Don't use report zones call to check the runt zone.
3.  Trim nvmet_zasl() helper.
4.  Fix typo in the nvmet_zns_update_zasl().
5.  Remove the comment and fix the mdts calculation in
    nvmet_execute_identify_cns_cs_ctrl().
6.  Use u64 for bufsize in nvmet_bdev_execute_zone_mgmt_recv().
7.  Remove nvmet_zones_to_desc_size() and fix the nr_zones
    calculation.
8.  Remove the op variable in nvmet_bdev_execute_zone_append().
9.  Fix the nr_zones calculation nvmet_bdev_execute_zone_mgmt_recv().
10. Update cover letter subject.

Changes from V1:-

1.  Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2.  Mark helpers inline.
3.  Fix typos in the comments and update the comments.
4.  Get rid of the curly brackets.
5.  Don't allow drives with last smaller zones.
6.  Calculate the zasl as a function of ax_zone_append_sectors,
    bio_max_pages so we don't have to split the bio.
7.  Add global subsys->zasl and update the zasl when new namespace
    is enabled.
8.  Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
    move functionality in to the report zone callback.
9.  Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10. Allocate the zones buffer with zones size instead of bdev nr_zones.

Chaitanya Kulkarni (9):
  block: allow bvec for zone append get pages
  nvmet: add ZNS support for bdev-ns
  nvmet: trim down id-desclist to use req->ns
  nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
  nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
  nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
  nvmet: add zns cmd effects to support zbdev
  nvmet: add zns bdev config support
  nvmet: add ZNS based I/O cmds handlers

 block/bio.c                       |   2 -
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 417 ++++++++++++++++++++++++++++++
 7 files changed, 475 insertions(+), 17 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c


Test Results :-
# nvme zns id-ctrl /dev/nvme
NVMe ZNS Identify Controller:
zasl    : 4
#
#
# nvme zns id-ctrl /dev/nvme1n1
NVMe ZNS Identify Controller:
zasl    : 4
# nvme zns id-ns /dev/nvme1n1
#
#
ZNS Command Set Identify Namespace:
zoc     : 0
ozcs    : 0
mar     : 0
mor     : 0
rrl     : 0
frl     : 0
lbafe  0: zsze:0x10000 zdes:0 (in use)
# 
#
#
# lsblk | grep null
nullb0            252:0    0    1G  0 disk 
# 
# 
# 
# ./zonefs-tests.sh /dev/nullb0 
Gathering information on /dev/nullb0...
zonefs-tests on /dev/nullb0:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS
  Test 0089:  Sequential file mmap read/write                      ... PASS
  Test 0090:  sequential file 4K synchronous write                 ... PASS
  Test 0091:  Sequential file large synchronous write              ... PASS

46 / 46 tests passed
# 
# 
# 
# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  1 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS
  Test 0089:  Sequential file mmap read/write                      ... PASS
  Test 0090:  sequential file 4K synchronous write                 ... PASS
  Test 0091:  Sequential file large synchronous write              ... PASS

46 / 46 tests passed
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
