Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B75C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E43B207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="18XSelyH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mSR/IxuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43B207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QVE78itXnsg6zM62m1MS8bH3PDffx9y31QCh68mB68k=; b=18XSelyH51l7aBC1gPwuArz2wj
	BFqRPJKXjrrRwv9G75vrgSElRF6QwnzzeBj5cwGuOL0I7br01cDgii82a6nfpRSZx6f2AkGtszB9l
	S7PV5VuFdqI1xlrPK42FlOqAfVvzjsCKDlo3BAgRmnJqhbzlnzaeJqULTeiRpKG3B1RZtDGsGS+wn
	xgUdJZbMqwkzD/moAM+s2rFh9796VonICY2GRiazZyB756PAPo3uCSjWAWdOcphLavyrss7WAhkE3
	UUp4LTSyHEJQwKG8D6W/Bh9pai4NBsTDlRCMkjoXXmMloHVUXJlAwZpM/yt21omPqcMVpaESpoKMf
	YjxKC0ew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7DP-00056E-K3; Thu, 26 Nov 2020 02:40:59 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7DK-00055X-EH
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358454; x=1637894454;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KseYHWkLriCBOLacE5vxJsXwJv0GfWJfPlyVPIyeoC8=;
 b=mSR/IxuYaXLuw3n/yijq9mvHvJTfK6gwsElQYTkOD05KWPeYeZaciPjC
 P8etzYKV50NhdiNgwLitMVGERLAaLL+bMYyeBWMaxV8F7SqtNZ9XjY/o4
 fnyF8/lhKOGsezl7r/eez0lhlBLPp5/tpZMplWKjWFGHkmhdi1Ewuonv6
 0Zmyv27CO9HHPao/4sJV4KT4EBEFSJknO2Nd2MgdBHGF5BgJYjH4V1jxf
 asMVQMkhlO53/XdL8c+zOn+hikhMXOuJIKD8o5AwKfjhv+b5FSvcvSQd0
 7sPrz8LH6UZ29jUWKREbtxd4O8OrtOkyiy8HBGmn/3ss+54MWYADeWgbN g==;
IronPort-SDR: /z80qpN1d+6rxLnZugJbROW5DVAezF9+6j2tXobpgJ+kFGglIXjoWilij8rBtd+VHkRL2yy22z
 x8QdubrpJzzPNhTd9WcYar9ioP7mfdADiK4Y8GUMmhee8Eqcg6ZCzrR5YAJ4UpwngmHHBNRboC
 6zWVBka/tGBoWcLtBe9KcA6CqWo4+Nau7C0x5HsPwlxGxScCMduRWvMUtFLb0BCaoVc+abPtk+
 nEbwjmJnt4BDqMNw/TuMAWiJxB7PbOGZ04aCBeIjk8KTU452pKKGW/+/IUFc3LJ+SIlJ/V6LhX
 Hs0=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="263593196"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:40:52 +0800
IronPort-SDR: vFA288sutECPpg575rA5T3tiBWs09MqWx8qsgY7ADLS2VT3c40bZR/q/1VuK+VG4LPnrBLTh39
 UlsccXsJ1WsHxuIvW+eMreG2ruC36pA0U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:26:34 -0800
IronPort-SDR: 3iZsBs2kOUk3esMlwrDUsj6cSVmN6ilbLAKYLA7Pc1ZQhFFplv7l0cJ/SRLk1IFHRIwk4JCJUb
 2hlvvxaTUxKw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:40:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/9] nvmet: add genblk ZBD backend
Date: Wed, 25 Nov 2020 18:40:34 -0800
Message-Id: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214054_766717_146C56E6 
X-CRM114-Status: GOOD (  19.12  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
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
namespace with nvme-loop transport. The same testcases are passing on the
NVMeOF zbd-ns and are passing for null_blk without NVMeOF .

Regards,
Chaitanya

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
 drivers/nvme/target/Makefile      |   3 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  18 ++
 drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
 include/linux/bio.h               |   1 +
 8 files changed, 451 insertions(+), 16 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

Test Report :-

# cat /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/device_path 
/dev/nullb1
# nvme list | tr -s ' ' ' ' 
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme1n1 212d336db96a4282 Linux 1 1.07 GB / 1.07 GB 4 KiB + 0 B 5.10.0-r
# ./zonefs-tests.sh /dev/nullb1 
Gathering information on /dev/nullb1...
zonefs-tests on /dev/nullb1:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... FAIL
  Test 0013:  mkzonefs (super block zone state)                    ... FAIL
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

44 / 46 tests passed
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
  Test 0012:  mkzonefs (invalid device)                            ... FAIL
  Test 0013:  mkzonefs (super block zone state)                    ... FAIL
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

44 / 46 tests passed

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
