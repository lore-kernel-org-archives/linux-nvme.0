Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90A3C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED062207FF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIzfn+5z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z4jGOSWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED062207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YboQNIyz9F21IutpQHT9gOfpyTW7S/zUWcDTCoBYP1w=; b=MIzfn+5zIfi0Wt6uyTFTFLjQh9
	Mv83IFrk78niDv01gOTjnbmTbhgHf5HUhtoIJUGb/oizUNQtA66HHJtAoZ185KvJOjTEIXc+66yQs
	THEHSmobqJ1zRsDOAzw//e4iBAK8dN7zGl+Z59pLK8ppS3CZ2tGGrzok0J4hdYn7F7/RGxsOm7Tyk
	ivCWX0cQf8cYAFNwMXGCTL4EhMCdhMk/tT0rQQhtBISuH2FtHvO4qupsRlcZlDR1GQTrwaiUKV9fz
	CcJoAhqtYnaU+5A1LGdL1PpGC+0Vcuq0Ztvy4rbtBEe+vs2TAeVKwwvROs1ipWKalwpqQcVFc9YUS
	sl1r3PYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx3Z-0008GC-Mi; Tue, 01 Dec 2020 04:14:25 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx3V-0008Fg-Jh
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796061; x=1638332061;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MOTxPr/dXMgLtBMStLftu/Vxq96/Hq6WbEO0PU2Kb70=;
 b=Z4jGOSWTNP+QxYlida5FR9cn4mc1nlz7iyjHYJlxJMM3izN09pEszNHh
 WDv2t+YRikN8QwHnLYWd8cmra7ylEo7NQVo5QDrkyj+ZYeMk0E6nUfOOx
 4bKG5B7ykux5J08ynjPIznTXcfb09Gs0dEdJo82UiTn1P1KDB9JOHLOqd
 DTA9OuRHmR/O2GG2SyXqQRL7gQ0m9l9VF/O0O7BSaYw6MiwrVqqwDPZSm
 UGYfyp6m0hehl1MdVTVWfk03RVwCKs9V+uAuul1CKYMcOelFRaEdy3z7d
 R5FLhv/gs7t9f6ZceVCHf0XAJoa/8Kig8JIK+mWs4RnrToMBT7EiglPxW Q==;
IronPort-SDR: mNJqYld5UXxCkohCbiVvZfhG3RvJGDQuLSPDS0x1Q0rLb55BjWH/G+ZWwYKKdCM6vci3WUVVNg
 RiiCyehoBTPnpIdnfVrFooshDMgkndaJmLUOkcSCQhpmsitxj9cPv+ehzDObQK0tttMbkJWVWB
 4GROWz9ZDI7GFq2EzOZCfc7WXJk9TbVcXHUy0Nl7c2hRdb76vHvWF6PUg1VKw328xzpIsCvh4u
 9LysDhot8264gHyZEQtk54UhakdYGxBUZqAUClKcQyPvTQbLuz2qxBeMEtuTpqwETREza1ylux
 M2I=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="155078121"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:19 +0800
IronPort-SDR: JN/q4vH0CNE7g/NoZuvtMAB9z0ltvv4y6IvDn3ToqJJebWYER1vBTQwdd00M7JDQDJdjEpI1tR
 LLQShOR3e6Wbgb3zxEIpVg42jzydKz0A0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:58:31 -0800
IronPort-SDR: rhBiVjv6fnsLtyA/uGzSf/ajn7O3Zpx7MR7AAs5MEDA/0DdCmclz9R+JFlw/7DX+agZfERC698
 ESF5EDn2lZzA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:19 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/9] nvmet: add ZBD backend support
Date: Mon, 30 Nov 2020 20:14:07 -0800
Message-Id: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231421_891141_C7FA1639 
X-CRM114-Status: GOOD (  20.52  )
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
namespace with nvme-loop transport. The only testcase is failing in #12
on both null blk and NVMeOF ZBD backe by null_blk. 

It uses invalid block device to format zonefs and doesn't do anyting
with the input device, still looking into it.

Regards,
Chaitanya

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
	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append

 block/bio.c                       |   3 +-
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 426 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   1 +
 8 files changed, 487 insertions(+), 16 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

# for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh /dev/$i; done 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  1 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
 *Test 0012:  mkzonefs (invalid device)                            ... FAIL*
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

45 / 46 tests passed
Gathering information on /dev/nullb1...
zonefs-tests on /dev/nullb1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
 *Test 0012:  mkzonefs (invalid device)                            ... FAIL*
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

45 / 46 tests passed
# 
# for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh -t 0012 /dev/$i; done 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  1 max open zones
Running tests
  Test 0012:  mkzonefs (invalid device)                            ... FAIL

0 / 1 tests passed
Gathering information on /dev/nullb1...
zonefs-tests on /dev/nullb1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0012:  mkzonefs (invalid device)                            ... FAIL

0 / 1 tests passed
# cat nvme1n1-zonefs-tests.log 
## Test scripts/0012.sh (mkzonefs (invalid device))

/dev/console is not a block device
/dev/nullb4
/dev/nullb4: 524288000 512-byte sectors (250 GiB)
  Host-managed device
  1000 zones of 524288 512-byte sectors (256 MiB)
  0 conventional zones, 1000 sequential zones
  0 read-only zones, 0 offline zones
Format:
  999 usable zones
  Aggregate conventional zones: disabled
  File UID: 0
  File GID: 0
  File access permissions: 640
  FS UUID: 339b07fe-ebbb-4876-be16-5a887384f349
Resetting sequential zones
Writing super block
 --> SUCCESS (should FAIL)
FAILED

# cat nullb1-zonefs-tests.log 
## Test scripts/0012.sh (mkzonefs (invalid device))

/dev/console is not a block device
/dev/nullb5
/dev/nullb5: 524288000 512-byte sectors (250 GiB)
  Host-managed device
  1000 zones of 524288 512-byte sectors (256 MiB)
  0 conventional zones, 1000 sequential zones
  0 read-only zones, 0 offline zones
Format:
  999 usable zones
  Aggregate conventional zones: disabled
  File UID: 0
  File GID: 0
  File access permissions: 640
  FS UUID: 591f1476-47c6-4d81-b0e8-7c82d4c5b657
Resetting sequential zones
Writing super block
 --> SUCCESS (should FAIL)
FAILED

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
