Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C69C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A947A239EC
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZ6DTC41";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OqWWwnEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A947A239EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dy+PefBMdPaMg0xRmK1X6G56RqaVe139r6CK18p+2J4=; b=GZ6DTC4150wjPhVAh9dOcAg59R
	kHiu1JiVjZ4y7rizDhMZT49o9MrpEFh5afW7h95HVb1+d2aeqlYKDuChahFDKhj7ibFBoif1TKhHR
	dRPnDthsf9MpImHTGp/Kr5PMUcoUWfxIDlLskr58naGY/Nf4Fj7tSJbkRQD0PVJnb1kIXnW9yegW+
	vw+wba79As85DRz+RKtmhcSD8Y6Iyfunm62XjMKln0TWmSW/n0d+VRCIoJej1nkkPeFy7GVsXBkiK
	RNdz5CRGD3A+rj9xsQRfLyhXa4z4MkLfOoRM6Ww+XdX53jYyNclVCwA7fzkGB6BXzVpmv+6AB+fXR
	DMpduj7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLb1X-0005KR-2d; Thu, 24 Sep 2020 23:51:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLb1U-0005K5-I7
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 23:51:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600991496; x=1632527496;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UGoOJt15izAwTFA4a0vmYSZw3yLk0QpnWqhRNtX+lVE=;
 b=OqWWwnExQlcpkFGI+VDYkGxFBVE3YBOx/kdy/hm9tAmkDInvG5k9gHM2
 f0yLACfNijDWrcoTKCPKDM88x4kwm8ve9phUfizIcDxLxqCxS941BE3wf
 R9Jxx1kKMeHSl+u8RFytuDihp5LrEBIvxWkb5V4yFVraY/Ah52GthGp7j
 2a9fmZsFDYWdDlKbeGU2N5Et6wPUI03w88FteBRKzpcDnJ7tjDEH6ODF5
 ZqmmuRE68Y2Qtx9BH4izUy7xIE0ya8XDWxJ2AFUzuS/ad2KqC39HA58+H
 hMq665PfTd5q12h8kzxi4W5e7Wzf3P5moqHtZjiIROfy5G5kb9Khb30iU A==;
IronPort-SDR: mjQBK4ElBHTShbuU05PlXqi4Ev0aCcdwApNmSLTTbGtC5loqJEmedaGF9xuR3SAjFlfDt42nMj
 6Qf66QMZUODRQnC8s8hWQFVJUrQKuoFtXvrfSQclaxvAcCcnSsLiC/bywJEB79Tn/sHR6uqcvk
 iuUofCfe8hdorIMl0i8VnEkSOXLSWrlVVPTgJdEX2eiwc+vvx2yZBqAwDBxIpOzPm8KJ841q3F
 flOH7SKJaFxKeAIOE2/At2D92Y2V2sPAouF57jvJZaDBDzuWZEboIUAm+jRcZJ6028rtyTjwfH
 Bp4=
X-IronPort-AV: E=Sophos;i="5.77,299,1596470400"; d="scan'208";a="148145828"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 07:51:32 +0800
IronPort-SDR: CdLFyVe9dUhR9lTaM4QlbJBb3GtPLRCt/Gg4DTxrcv8nXuOlSASsqR4vhYavV52dw3dUc50gv4
 zY8lQTp/mIsw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 16:38:32 -0700
IronPort-SDR: aCp3yuZ0EaPK+PO8HlbRkd5kBRUKC68Kdio0YVdN6cXwaTKrgEAuPfFWWdY5+IE92mdNa9Web3
 ZU6Hur59e2HA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Sep 2020 16:51:32 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-loop: use xarray for ctrl and port list
Date: Thu, 24 Sep 2020 16:51:28 -0700
Message-Id: <20200924235130.50565-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_195136_798224_6DB9A7E0 
X-CRM114-Status: GOOD (  11.29  )
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

This patch series replaces ctrl and port list & its respective locks
with XArray.

I've not tested this exaustively, but all the blktest testcases for
nvme-loop are passing [1].

After I get some feedback I'll send V2 tested with corner cases.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvme-loop: use xarray for loop ctrl tracking
  nvme-loop: use xarray for loop port tracking

 drivers/nvme/target/loop.c | 79 +++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

[1] NVMeOF nvme-loop blktest results :-

 # for i in tests/nvme/???; do ./check $i; done 
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  21.565s  ...  22.434s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.130s  ...  10.124s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  2.847s  ...  2.865s
nvme/005 (reset local loopback target)                       [passed]
    runtime  3.513s  ...  3.408s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.099s  ...  0.095s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.051s  ...  0.054s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  2.882s  ...  2.836s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  2.850s  ...  2.827s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  28.148s  ...  26.239s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  241.177s  ...  241.837s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  40.502s  ...  37.633s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  191.061s  ...  192.911s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  23.068s  ...  22.672s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  23.341s  ...  22.319s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  14.842s  ...  14.733s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.820s  ...  14.774s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  2.783s  ...  2.790s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.895s  ...  2.830s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  2.811s  ...  2.770s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  2.772s  ...  2.836s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  3.407s  ...  3.431s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  2.817s  ...  2.859s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  2.863s  ...  2.780s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  2.839s  ...  2.813s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  2.793s  ...  2.794s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  2.815s  ...  2.799s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  2.838s  ...  2.808s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  3.092s  ...  3.075s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.334s  ...  0.325s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  17.295s  ...  17.435s

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
