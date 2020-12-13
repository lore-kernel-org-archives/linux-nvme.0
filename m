Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB6C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F395E22D71
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395E22D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+C5DZn40dVDEtDXcdJuAXDPtLYI5KnObHvneDX2MZDw=; b=m/oVBOLlOQhvd092gNfOgh1Lu1
	bCU8ZGXa9Iq8KLNN3AuNSLysCMM8BbsUjydHSGFIwbw0lPpFzk4Lge3gWVnXvTmn0/XWSS1v4ub7y
	vrPEwPw3PV65hQOjamgNtUX1MY0+pqa1Zq+rjAfFt9alG4v9OAogRQjTLDpCiwIItu/lUo8TjxFuN
	IwrivTvd4xvCewC1I03xSJoC07mcyblgG6JB1QlUbHvpUc2YNwRVflgJQ7kqyYXBDnNcdNnjOEV9m
	RQNbGMgoyzvyLkBjJqsUvxe0NmBVOSS478FGeDskoNeTSyJ173MXFi4VdS0iB9vE/dR9240FFWFOr
	6h4e19ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koKHp-0005hF-75; Sun, 13 Dec 2020 05:51:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koKH0-0005gU-GN
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 05:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607838622; x=1639374622;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hd/h89kkFCTMloMN8HitQ9iLDV9MVx8UC7BBr2rCOjA=;
 b=PBVyFtGoEWpyjCHBqgJug0F7YCNHGZcrt5rmIepSqYR+wvJUAPptiMG9
 Jo9uPVCDQ9yFKJAloDh1xmIjl/S5ebGjouBu0i2+dGIb7T8k4U6X7/Uwz
 kzBLm3ggRAfYkdMq99PhBj4eoyI+5fAREbk4JvJXcFwb4fqTGzMvxMuwn
 WwKvPMOtyu+NcRoZyK+8yC58BMFH3l4J/n7t2svidqFQrRhte3u0fDpSw
 IstjWkGHuW8zKAZ91uKMjYOO/1F7dXaUNG8U8EyR0TcC6Eeo/jtNjcOqW
 KDaC/tw5PfQeeNGgi9IP4A+hTwzum7x27aA41+znkExbuY5FhplOwaGJ3 A==;
IronPort-SDR: 1x0r7dG7+PF+BPYVYvzbEuPfbxOd/RMRGok7i45TD5/CdPO18QyWQZoJ36kfx65KT++zx0SS1H
 0/wCoExlKn1qsEMC0dK5tW6dnQFJFv17q//xPsw4Y1oFzdNMo/Sc9DL7eb+Gvjy1MGzbTwXi8k
 zlbXetLvNPUGgrueTPDkkcSj/LhGmwJSKXXKMrHIkNWTPGHnaPsRTI2MQW77guVovAnbf3ruLn
 tuZoGJS8wIf61/N+5zL4qU7Lubx5l72xC15K+SPs0uU8Aa7azOiSQZs7OLT6jr5nEhPrietkD/
 LPU=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; d="scan'208";a="155065865"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:50:18 +0800
IronPort-SDR: 4cQGawTYj/Ns8m9rI8k1QTSZ70GzdHiA1NIULPao7mCcHxnr5bmQepUNl1k4+cZHP0BEw1pRSj
 ZFWtYP/wkmSSP24ybksEzoo8SAjrAPJkg2y2g+2PN7V0nt4oiZk2wZznR3zc8kdgirpPx32EcA
 1GNLH9ACjsBJhs74Az5kZrFFit66n283t+JqnsqdglecAufgvgyjvS/9THuICNmFkv9uhrqEyC
 idT2SJ2SPr12LRMzQtf61oFQi0yybdt5VPArBEvOX9k+Y3JgvhbD58x0cXCkTl0qrXmbkGvZYZ
 d/n9v71ebYi9pOuS93p0SvP6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 21:35:40 -0800
IronPort-SDR: qOleVCQmsTR7p5hjXXegqIB0RSbODPPX/WyMnzoj92JF+BQh9pTj5OCXxyhAkiQF4zr/qgsUOV
 oA5zvOWdb9F2k4kVjN4rjBauklhUjRuw7rCPYXquVG7U6F8WIatex2zAr+vEvZDgt+JyOMfOhe
 bRddwr2ZWqW6wnzSIXQtVJij/YFTs489lvwd4djlv9bFsnIzBDk/4Ss8xoGcDSDkn/6IjEXp3P
 xRjAAU0sgh9oJl6Gcod1VZgx8CamlVfEoI3IbXSrT7HuFwcoRsLIuTGASuvNwdH+dVpbcMP0G2
 T3s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:18 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V6 0/6] nvmet: add ZBD backend support
Date: Sat, 12 Dec 2020 21:50:11 -0800
Message-Id: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_005023_072292_B9CACE48 
X-CRM114-Status: GOOD (  21.58  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru
backend. There is no support for a generic block device backend to
handle the ZBD devices which are not NVMe protocol compliant.

This adds support to export the ZBDs (which are not NVMe drives) to host
the from target via NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for
patch-series overview.

All the testcases are passing for the ZoneFS where ZBD exported with
NVMeOF backed by null_blk ZBD and null_blk ZBD without NVMeOF. Adding
test result below.

Note: This patch-series is based on the earlier posted patch series :-

[PATCH 0/4] nvmet: admin-cmd related cleanups and a fix

http://lists.infradead.org/pipermail/linux-nvme/2020-December/021501.html

Regards,
Chaitanya

Changes from V5:-

1.  Use bio->bi_iter.bi_sector for result of the REQ_OP_ZONE_APPEND
    command.
2.  Add endianness to the helper nvmet_sect_to_lba().
3.  Make bufsize u32 in zone mgmt recv command handler.
4.  Add __GFP_ZERO for report zone data buffer to return clean buffer.

Changes from V4:-

1.  Don't use bio_iov_iter_get_pages() instead add a patch to export
    bio_add_hw_page() and call it directly for zone append.
2.  Add inline vector optimization for append bio.
3.  Update the commit logs for the patches.
4.  Remove ZNS related identify data structures, use individual members.
5.  Add a comment for macro NVMET_MPSMIN_SHIFT.
6.  Remove nvmet_bdev() helper.
7.  Move the command set identifier code into common code.
8.  Use IS_ENABLED() and move helpers fomr zns.c into common code.
9.  Add a patch to support Command Set identifiers.
10. Open code nvmet_bdev_validate_zns_zones().
11. Remove the per namespace min zasl calculation and don't allow
    namespaces with zasl value > the first ns zasl value.
12. Move the stubs into the header file.
13. Add lba to/from sector conversion helpers and update the
    io-cmd-bdev.c to avoid the code duplication.
14. Add everything into one patch for zns command handlers and 
    respective calls from the target code.
15. Remove the trim ns-desclist admin callback patch from this series.
16. Add bio get and put helpers patches to reduce the duplicate code in
    generic bdev, passthru, and generic zns backend.

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

Chaitanya Kulkarni (6):
  block: export bio_add_hw_pages()
  nvmet: add lba to sect conversion helpers
  nvmet: add NVM command set identifier support
  nvmet: add ZBD over ZNS backend support
  nvmet: add bio get helper for different backends
  nvmet: add bio put helper for different backends

 block/bio.c                       |   1 +
 block/blk.h                       |   4 -
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  59 +++--
 drivers/nvme/target/core.c        |  14 +-
 drivers/nvme/target/io-cmd-bdev.c |  51 +++--
 drivers/nvme/target/nvmet.h       |  71 ++++++
 drivers/nvme/target/passthru.c    |  11 +-
 drivers/nvme/target/zns.c         | 350 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            |   4 +
 10 files changed, 518 insertions(+), 48 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  16 zones (0 conventional zones, 16 sequential zones)
  131072 512B sectors zone size (64 MiB)
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
