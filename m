Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB2AC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE1C61C17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE1C61C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qC7SiE7j6JmsD5Nd9qSF7c2TuDBzYiWPHsANlNgfAKU=; b=JEiciHdSlcyO8m
	pDZlLRKr6/gaAyzenJlaEGImape/ZnCv+DYd3XKOsxA8VgGT3eAyI5Mg5fAPAXh1s5PJpKfxSeITw
	8v/iyni8mxU/AMrT/rBGPGiDdoFCBO03PN+HIIMZ2dWq+ZR6ln1cXIt9QlRcV/Hqvfiqq14Qq0cTv
	VWSrSsA7Fita8NJzGZw9L22b2FkWzGrN14wmkk8zsYxQuyKn+NlbakIbHieXwozgBgAPXRv/6fOAn
	4nwWMeZOMvDYe+pb3By7FToWNWOerWkwfFTS+UCTcFjwCT+yd1/Sr7qr8we08QomgGCDlTbh7n6fy
	GI2beO3zO9og7hDefQfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjVa-006lDq-FX; Mon, 28 Jun 2021 05:08:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjVW-006lCj-3h
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856934; x=1656392934;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8CR10AvaByuT1W3rPk8PYh+vIq6XlNoHjVkoRmM7k4M=;
 b=l5fNtyem+N55yHwaut/BjUfAV09MVCeYvFu826vzFC49o11Q+KVFG5u+
 Xh61YbKUzyl9YWw7m4ZpTkhllamyKUaL6gyDRlVdVwcJCq9Ovmg6/TkDa
 HtSoErIDUavgJqPWQstbJ/UoZfMDxs73p620VDgOTZ4C/+U9QHe9dz2uo
 lJNlIrb901kQEMZKtASNIjgcN+mrpxmmcrrH7Q75HT4RTNrftCsjNNAJA
 bmJYYuH/o5URt+9l7FBPlcTpva+D/iN3iNs0TEUrqp2LHXOE198Vy/cdF
 qZ6MJbbFrm4WVtYprV0aeWKryFlgxKinYaZkrPSlNIkk+IpjGtox9+8Ad w==;
IronPort-SDR: SWFg5fmH0WafJLwp2PQMIF4aiPAYFHPvzbqxpEZ+ZQVsjKG4FJAvQJHPWYjaDvbvHpMwKM5qYN
 DUc60UccwDDBcB/peruZlhNJjSC9axJO31ti/nZZuraNSbb+062c9as7b3Bni3zQmA2Hk38FVE
 LTaVZiZ+XIE/FVswjngdSUwiD4cgOBz1b8gxiGAA8JF8pyz+FgU2bshDt7YeiuXGTO0judOFjZ
 nEVp7x5SR2SiDYd1znoMYQnHr0NgULITbbS5vM8f93rrcbESau13wP5r5uSKLRvOQYkZUv0P4Z
 cuQ=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="276851351"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:08:42 +0800
IronPort-SDR: ME8H+kXcHLo00qOo0DnK6qWJFyuCGBHrnJRyyIYQJ9nFBgILTxC9SZnFnPNrvIKDd62DNB3EGo
 kHtkCVeS88pUMf2YgYkuOvQXcnYGO98P8KnYSqtHDnUTh2C2WKgnLS7uz+t5TvMgV0Px7tmRmc
 Z4Qp079B9Kjiv9iUvQD43petC2qBsCMxMeP8c8nbX9hgKhQ9PXaXuJWyWVPCakt65smoZ/VrQ5
 W7BoOYWZF4i2Y37r/E1szMJPoX49IDDogyJR3Hggf21Thj9POnLMA9ctFwPdW20eOV+VI9yMI5
 YqUWFc7rcj/eNRwdO9gpvD05
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:45:32 -0700
IronPort-SDR: dyK2oCck9DZn0XY+ZhKK+zbTu4YNChKPSSfLWHbXEyIIx1vcrhO6N8UKXxQGci1oyFM2/n+Sx0
 8Xx9/thhxw5wVTyJCPX31W/iAhGMqYE4H0rwUJ8ew/jWrZWsPUAfawUnR7UbAyZsvXwBnTYnoI
 We0YEIfs8hV1KJFI5A5nkX5r1UsvcUtte1FaKZw4DRqaaLiPySVsfPx+Y6t2fsHPtVT/CU+AjM
 28K7Syd/wUk6RIclI5JrXMz71Fm0tdGIipUvylxcHfeX+/XDrx3ncggdVSzBJ2dLhZod6TNjWV
 v8Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:08:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 00/14] nvmet: remove repeated calls to nvmet_req_complete()
Date: Sun, 27 Jun 2021 22:08:03 -0700
Message-Id: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220830_300603_6234EE9F 
X-CRM114-Status: GOOD (  11.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Since the addition of the NVMeOF target time, we've added various log
page and identify command handlers where we complete the request in
those handlers. This adds 10 repeated nvmet_req_complete() calls.

This patch series removes 10 repeated calls to the nvmet_req_complete()
in for various log page and identify command handlers by completing the
request in the nvmet_execute_get_log_page() and nvmet_execute_identify().
Also, with this change we prevent future repeatation of such calls.

This also allows us to remove 8 goto labels.

I've tested this code on nvme-5.14 [1], blktests and zonefs tests seems
to pass.

-ck

Chaitanya Kulkarni (14):
  nvmet: add common req complete for log page
  nvmet: remove repeated call for error log page
  nvmet: remove repeated call for smart log page
  nvmet: remove repeated call for fw slot log page
  nvmet: remove repeated call for changed-ns log page
  nvmet: remove repeated call for effects log page
  nvmet: remove repeated call for ana log page
  nvmet: add default case for nvmet_execute_identify
  nvmet: remove repeated call for id-ctrl
  nvmet: remove repeated call for id-ns
  nvmet: remove repeated call for nslist
  nvmet: remove repeated call for desclist
  nvmet: remove repeated call for id-cns-ns
  nvmet: remove repeated call for id-cns-ctrl

 drivers/nvme/target/admin-cmd.c | 180 +++++++++++++++++---------------
 drivers/nvme/target/nvmet.h     |  12 +--
 drivers/nvme/target/zns.c       |  27 ++---
 3 files changed, 108 insertions(+), 111 deletions(-)

# ./check nvme 
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  38.825s  ...  40.506s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.176s  ...  10.184s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.781s  ...  1.776s
nvme/005 (reset local loopback target)                       [passed]
    runtime  2.334s  ...  2.243s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.155s  ...  0.149s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.102s  ...  0.104s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.779s  ...  1.785s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.747s  ...  1.755s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  34.091s  ...  26.953s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  288.054s  ...  320.502s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  8.515s  ...  9.634s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  27.329s  ...  24.710s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  20.028s  ...  21.024s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  20.615s  ...  21.140s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  20.653s  ...  21.571s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  20.402s  ...  22.023s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.747s  ...  1.767s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.771s  ...  1.805s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.735s  ...  1.739s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.764s  ...  1.752s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.163s  ...  2.182s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.780s  ...  1.815s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.739s  ...  1.750s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.726s  ...  1.756s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.740s  ...  1.750s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.735s  ...  1.757s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.738s  ...  1.751s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.213s  ...  2.253s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.404s  ...  0.426s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  6.396s  ...  6.226s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.061s  ...  0.058s

# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  32 zones (0 conventional zones, 32 sequential zones)
  131072 512B sectors zone size (64 MiB)
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

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
