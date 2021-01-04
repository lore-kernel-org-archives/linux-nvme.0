Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7413BC433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A942075F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A942075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i/A6od40s6d/2YdY2qw+ns8xkYLEOpppu71n0FJ/oUw=; b=W2y2nLBD/nCjdl0M1hyZZsZ/jn
	ESIFa1lVXVThm/LiUCNKMZa7W4KDBWLhVsgGmV8Pneq38B+EVFbywGFQExb07xFMeCbikVo/y+k3z
	Dto4oozmztyIrwnakJMtTmQe+xCghm9pTcOzuquIUMe4rvg+sXb8ScRGeCZ70/AnK1u7xqzLx7opa
	0OUm878QpzbRSKf54ZmuWBWOzprmYYdiEVh21ICqS0tyzvf9lE8gufZyaQBgYuGBmsPlZHW43z+sN
	QU0GGk3C31mgsDdoNQfWDC5p9koA0uaeRXN/izLW+GhxGJOl7R2QRZjskb4j442XZ3nLZYgM/vuh5
	+T14nBKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwHqu-0000Mg-2K; Mon, 04 Jan 2021 04:52:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwHqn-0000Jz-4g
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 04:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609735933; x=1641271933;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0RlfNU15CVk4C5x0u5hanL6whsN0v+NS/RomWYCVDFQ=;
 b=hf7H3PngmrPMXr235R47TwR8XoIbeLZamTD3QdN36Kosk6t67WmX1w4q
 weObsVum9P4Q4UQNwzzyGkAMRKbKMjaJIQ2+CWypc5ieCt0y+6nH59P18
 UZLbmb5luZLAFmWsk4EvSlLm7FsS+Bfo+DdaXjLlx8zN8OcqeXPgmjkZf
 p9wlagPCmUuUP4FvSvRo9irpSWcHTeDh1auokm3LACiogpvVdh88e94Dp
 bXTrOahh/8FSfGDZFRTMJNhz6tviBz5cFlKw66jfOcPsFLvhdfxarbQSv
 u2B6OOtEJsx6Un7wVvfWaFHx04EzbxTK0FVQdI4vLV/4aWHoUWm4MKNYK w==;
IronPort-SDR: rHkVIcGG2A1uN0z5vF/zUqcdQj9iVWToFbHTT/LFjELkUNbcmoTqqsfEXL7LTU01rEBBox/iUQ
 TQwoYWh0llvUVuXQBN5o7MUn2Zu+02UAHJf5WRhsKP58u7O1gluqrmyNKNVqLm+UZ9ETLlj37a
 XeS6L1F9FRAKVEkrDSKFbTFicTJmcmgbF8MEc5zHduzDF3aGW/Y9LpnbGWJxKfqybFrpR4LRbX
 3HqKva3EN/5YZRTchF3XXQIW6VotE2RKo7Ve8CkdjgwbGk+KrjKFBlsa8BYim0q11NJSB+wtcX
 cpw=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156434422"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 12:52:06 +0800
IronPort-SDR: zOW1hTtdvzTV7MuakVdLKxDocHWyO2ROEbsejn1Gk+vDkh5hjJNfOcHd0vIGjys8QNk7ig1aGI
 TkHXMaW8MWxQboY1DWtZH0NclYNYwzQcPqgu/4Xcht0/kFxnCQL0FFhhLmIcBvyMMJqlnFDs4M
 4ds7/1/G1mvq1wdBLPICQN2+QRfuBUvZaEHgRO3Kv10MZbrot0+r34vS48THvcUzRNkHBbOgnj
 zkxTHQ0RA3J+tBnNyP81ZLNW6SQJCb5WeyGUfJ5t9BCNoNSWekQpcurQCQ1W6qxywEViVCyH/Z
 YLjbbWDjqRqQglJ81rpFYiNE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:35:15 -0800
IronPort-SDR: MGnpnvC+ZCvTTZo+h9lazobXFqhndRj7TfUpf90vpNEq6kRpbB2W/pVOoLbh46GHSgsKGQ3Jya
 NIw2gKg9Fz1Rvt6zhsmgAaN/sVz82M0Kd0vzM8baC4TSm4IYuLdMrXXwotRdVmGfXeONjoWUch
 dhUX1VZb8MDp8E2lPqFBSR7gjE6rRLfbYCEicxuJ8XLJ3DCU9LEb8G7ECXJFSu/kOJ9lvdopOC
 q9Oy3Nk2nFqTPo1pf5xbEpZ7gib4MLkHBmI7qjEGWaNd+wOruzjC+iEIlOUZifPKiO/DJzQVq2
 8cs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 20:52:06 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/4] nvmet: admin-cmd related cleanups and a fix 
Date: Sun,  3 Jan 2021 20:51:59 -0800
Message-Id: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_235213_875622_AFE6E05F 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

There are three functions where local variable ns is used instead of
using req->ns which leads to duplicate nvmet_put_namespace() calls.
We can just use req->ns and not the local variable to avoid duplicate
calls. First three patches fix that.

The last patch sets the right error status code when namespace is not
found in nvmet_execute_identify_ns().

I've tested this series with nvme blktests, all the testcases are
passing.

-ck

Changes from V1:-

1. Rebase and retest on the latest nvme-5.11.

Chaitanya Kulkarni (4):
  nvmet: remove extra variable in smart log nsid
  nvmet: remove extra variable in identify ns
  nvmet: remove extra variable in id-desclist
  nvmet: set right status on error in id-ns handler

 drivers/nvme/target/admin-cmd.c | 77 +++++++++++++++++----------------
 1 file changed, 39 insertions(+), 38 deletions(-)

Test Result :-

blktests (master) # ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  24.027s  ...  24.214s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.134s  ...  10.134s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  2.463s  ...  2.436s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.091s  ...  0.093s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.061s  ...  0.062s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  2.446s  ...  2.457s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  2.457s  ...  2.427s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  19.340s  ...  28.696s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  225.867s  ...  235.098s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  42.473s  ...  42.824s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  251.344s  ...  714.369s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.070s  ...  30.622s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  23.212s  ...  29.880s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  14.002s  ...  18.465s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  13.758s  ...  14.368s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  2.424s  ...  2.458s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.439s  ...  2.520s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  2.409s  ...  2.586s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  2.440s  ...  2.470s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.843s  ...  3.091s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  2.439s  ...  2.520s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  2.419s  ...  2.451s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  2.417s  ...  2.582s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  2.399s  ...  2.546s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  2.419s  ...  2.641s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  2.394s  ...  2.575s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.694s  ...  3.300s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.327s  ...  0.390s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  13.381s  ...  15.152s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.038s  ...  0.043s

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
