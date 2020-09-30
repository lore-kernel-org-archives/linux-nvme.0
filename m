Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3838C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0093F20791
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mteCx9Zl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X95r0PYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0093F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7MWIr7kaQFqveA74GaD0RPSPeRkWODTDjyi/VIoVwOk=; b=mteCx9ZlyTqEVO6iVvdaRxfiyl
	tF1HHt5coW5iUcU7IqdBReEka5iIekJNc6KB9ZwDZJdGrjtQwO2UJiwgxGlhRxAxluBNd5n7HSchh
	3r1m5uvDwOsixYd54k0yrGjq/NFdlwxjhi9GGULUOU0hwLTP6mw+NlOwjjTZNqwQLi0L04QJj2Tqe
	lkcMktwsW1UZwoiNRbYNMpgjnIeqA8XO3JG7lj98nkOq+UGjHf2Ggmue+3rnkPAZsfP3WG8CEaOjn
	mBud3meRfyjW1IISPu3YbZ20M3t9wS8slX0QPPgATUqWDW8ciD/10dcA7eWmiAL8zox0U6+Ja6Z2G
	0g25+uow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNU9r-0005qY-ID; Wed, 30 Sep 2020 04:56:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNU9o-0005q9-8i
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 04:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601441761; x=1632977761;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/gKuRrP6kKjqgnwBDn2mJDzO8g7assv2z4llAy4jQuw=;
 b=X95r0PYfpf3SxM2qP5uikKYgSTSDEzPuG18n9VWQ6QPqlt8Lscb5AWc7
 13Nu1sj17NYpTwkSpjYDwlUldIEFQF+3HlmOTQw9xM9+ZDdPF6weZVz1L
 8FOq8ED47bcuNCHconxhd/UaekX1EJf71H+Bfu13w96nZGbB57EgE12kL
 3Ckd38+kom5PF6hgyWaLV6OLpd3iGCldxtA/LZFcggsmpDksY4txmm9Hk
 2VgrksEZZBKJ9D2R28ICFMKeFZMbrXLDpu5nVTrVkZpnXnttwOBG7tJgT
 pWslDE7XLdRxWEmxtTe9wkZVrqxE0EuFZu41YY1ok+CHwhAYmhmPcyBG/ A==;
IronPort-SDR: YaPVl1B9I/tvsP4rhpXhslL9O3NxmzebyPNxtWAMn9OB+eVFqPq1kfn7Bwt1+iSPMtdtkWnXLC
 qPk/kpgez6eoCTwt0mvlNCiPXM22BH/LM3OKYjBIyKdldJrI9y5AkWtZcD3qpOZJcTIUIk6Dt+
 y4GAC4rPY6oFbqNNxpZupEYCLnUFVikJ+1zu8GO53QpWc9s60CgJ9SZWD8Aw3u5f5B2QnwYvkf
 NIVLWblmvFKuUwWNRcqKFCzU8J7+dL1QmdcytB3+toZhoVki0pOD/A3gfVOy33IxaY5fOCuxhP
 ACQ=
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; d="scan'208";a="152999366"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 12:55:59 +0800
IronPort-SDR: lVMxf5CuXYD+LVVboDkyyUnEdwyl8nJMg0mccCXv6LXGCozju7VLykH9EtZAIOI3dzUx43nbx2
 qbg/kiEeRRiw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 21:42:52 -0700
IronPort-SDR: 4WVNk6G/iTOPnqe6ZFWsN9sCkrhLXrXyA30zj0Z1l3ndI+nxr9s9XzEYiJtuwOduBTB+gqo8Wg
 CozHLB3OjC7g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Sep 2020 21:55:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme-loop: use xarray for ctrl and port list
Date: Tue, 29 Sep 2020 21:55:55 -0700
Message-Id: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_005600_520524_4261D560 
X-CRM114-Status: GOOD (  11.36  )
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

Currently ctrl and port tracking is done using the list & a global lock
respectively. Since this lock is only used to protect the list mgmt we
can safely get rid of the lock and use XArray.

This patch series replaces ctrl, port list & its respective locks
with XArray.

I've not tested this exaustively, but all the blktest testcases for
nvme-loop are passing [1].

Regards,
Chaitanya

* Changes from V2 :-
1. Rebase and retest on latest nvme-5.10.
2. Generate this series on the top of 
   http://lists.infradead.org/pipermail/linux-nvme/2020-September/020023.html

Chaitanya Kulkarni (2):
  nvme-loop: use xarray for loop ctrl tracking
  nvme-loop: use xarray for loop port tracking

 drivers/nvme/target/loop.c | 69 ++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

[1] NVMeOF nvme-loop blktest results :-
root@vm blktests (master) # ./check tests/nvme/???
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  24.180s  ...  24.181s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.130s  ...  10.128s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  2.876s  ...  2.880s
nvme/005 (reset local loopback target)                       [passed]
    runtime  3.467s  ...  3.459s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.104s  ...  0.098s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.060s  ...  0.056s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  2.843s  ...  2.873s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  2.815s  ...  2.804s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  26.820s  ...  32.029s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  302.723s  ...  268.770s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  42.882s  ...  41.107s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  142.143s  ...  128.990s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  23.945s  ...  23.363s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  22.146s  ...  19.836s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  15.456s  ...  15.097s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  15.267s  ...  15.184s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  2.806s  ...  2.842s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.841s  ...  2.852s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  2.834s  ...  2.873s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  2.850s  ...  2.828s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  3.415s  ...  3.422s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  2.870s  ...  2.853s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  2.827s  ...  2.826s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  2.862s  ...  2.812s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  2.836s  ...  2.809s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  2.877s  ...  2.878s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  2.835s  ...  2.822s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  3.157s  ...  3.163s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.352s  ...  0.349s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  17.561s  ...  17.649s

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
