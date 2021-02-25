Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740BC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DE364EB7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DE364EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mq5877TZZOP5NEumSJF3+zgHm6nA1+Sj9gKFYL1VOBY=; b=TbsmGUzeTtTsI/LdavYdEUvujC
	wGj63k20U7qlH/eol4MjV7sTKDXKsNVvAT4H6SvpVol99aAN0z6M6hRPc9KZj//1ImakrbdFsAFAy
	h+d7fwfcoxeSD6cIIjcyqIkx6LqygIzgPKI+tFdpJJ8+tZZE+jA7jBeT56qbeMvwfJrXWuZOIa/xa
	0/rX4iVFAQe0KtSedGWgi/XXNGC3D7dEwskPgpXGtry6g9vMq/MkZdBeLqiUlv6ayLQv7HCNv+xLJ
	wAUOku2szEu1NElBUXHoARxSU1U2iXUMJFrlSH+KZ9LJEqCl93PBH4NiH5sV4ig3c9Ki/FSaGsc8c
	imhdYDMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5td-0007fl-PL; Thu, 25 Feb 2021 01:56:53 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5tY-0007f6-Fs
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218209; x=1645754209;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jL4ARwzf+uSCQZ1yidZ4AyHPxX/qAfpsKue0XP1R9Tg=;
 b=F7Wi9/DCj5tNt1Dv7ltVNv6pXTu2hFYottRL6lA+mWxXookr4emVWAkD
 1CUPaEAp/dwkWa73asg+/9dOp8jtkFOaL83A+kcSiJcGG/5H0/SHiuptp
 1dcs7nwKPvPM+KgThsEnWGtuMvR6FdCDjeKT+RUbFK3yxyTzpj1pZ4Kzw
 zypfWJXUUWPva69x4BlATbe6uVjIy3Q+hRTxqX7zPbrCJC1r/8M+llzKM
 9dZG7py7vREXcyAaTOWK625oA1e0YUK07vhqKCO7Km8zUHIDs22/UhCf2
 ZvGQ1Az+tBcPPhr76k/BDN4tKR2g7kSZBugejlAf8r1mzeR5NjkT1LLWa Q==;
IronPort-SDR: jL0SeieVJAhFTjms5VexL9I3zmI8PAnpHBsfIQpOsJwdzj00rtt3k0LVH22GyVukfsj/zgSdOE
 3hi8sVXcx8T2Xah3RxyvyNxxtvgARqLhO+8NDB91ZDF1nInASBrW+R7bMfQFD6H2lBwjYu62fV
 rNUHIB7c0J44rYeMClL5PIr+RVMQ6EX0NWiWz9j1L8uAip01n6y8dxxaPNPnvPL9SupCH2VQ4E
 6g3TV8vVzSdIm1FhW2yMHr4sU2EpCxDdz0CSxC30ygYf+Rj+ke5QSDMLoGiAzxBBNvMTGmDB5J
 f5c=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="161913752"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 09:56:46 +0800
IronPort-SDR: mqxI2JI1ARRFupDbEWTIYBc1FH1Sv8O3xPTMZ71e01KpolLFXiJuEklFrbceP31W6nXTth7FbV
 /4FEarMgng7yRoTZ3msU06V8xzPaR0TCSIyreYu0YjjlJoetmyPTkucLagpzyxSRHaRiv+5bqq
 XJm9Hv7vezIrz/tT3W21uWH1t9MCqWkmkiaXKsODQLl+Qi8/j2nrx2bl8zGjdXuIMQWbezn1Oo
 H84StYS/sU6r5ZbW9OUWm4Heln4elGq9iEoTksZ/PtdmBVHpENI3krgjOGlfvO2O6V2sa+fZB9
 0NxoQRs8XsfXFsZF3/Rpd73T
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:40:01 -0800
IronPort-SDR: RekvsdslLyM01rNPK4Dmbs1bgmp1GWbbWeDAJB2ZiijpIf5tfdGOpv29Ls8jOO0fTlj7Mq3+fT
 0MkQHbuu0yFWFBkcgOhvD0mQ2tJY+1RxGC7rNYNg1xdBrLgJ0WQSNFN1lZUVrBueU0D4FtrdT8
 njofWkkU396k2axA6HVWAGQFiXJVDFUcgGd1wa+dT/rUs9cwKyUPtL8AEqIy7ZIwQ7HmxSCpPy
 ymFqph5hUntTinfUVAm7URcKpSYlDerWvM7KGqKmf0pBpjPU6rZhFt/ox46ikemZdouisDSeA/
 V2s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:56:45 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/6] nvmet: cleanup and status, error log fix 
Date: Wed, 24 Feb 2021 17:56:36 -0800
Message-Id: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205648_779001_EDF3A9A2 
X-CRM114-Status: GOOD (  12.53  )
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

This removes duplicate status value assignments, unnecessary function
parameters and fixes the error log page update. Last patch also
removes the spaces where tabs are expected.

-ck

V1->V2:

1. Remove the patch to set the status variable under if at the error.
2. Move the error log page update into nvmet_alloc_ctrl().
3. Add a patch to replace the spaces with tabs.

Chaitanya Kulkarni (6):
  nvmet: remove duplicate status assignment
  nvmet: update error log page in nvmet_alloc_ctrl()
  nvmet: remove unnecessary function parameters
  nvmet: remove unnecessary function parameter
  nvmet: remove unnecessary function parameters
  nvmet: replace white spaces with tabs

 drivers/nvme/target/admin-cmd.c   |  4 +--
 drivers/nvme/target/core.c        | 58 +++++++++++++++----------------
 drivers/nvme/target/fabrics-cmd.c | 19 ++++------
 drivers/nvme/target/nvmet.h       | 10 +++---
 4 files changed, 43 insertions(+), 48 deletions(-)

# ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  36.789s  ...  37.383s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.177s  ...  10.164s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.743s  ...  1.739s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.141s  ...  0.137s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.096s  ...  0.092s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.756s  ...  1.760s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.709s  ...  1.732s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  19.931s  ...  29.821s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  267.604s  ...  282.232s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  49.320s  ...  50.911s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  335.511s  ...  292.379s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.308s  ...  20.296s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  21.888s  ...  18.687s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  19.097s  ...  19.649s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  19.393s  ...  19.435s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.718s  ...  1.729s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.747s  ...  1.786s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.700s  ...  1.704s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.702s  ...  1.745s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.131s  ...  2.128s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.739s  ...  1.761s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.708s  ...  1.717s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.692s  ...  1.703s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.798s  ...  1.716s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.713s  ...  1.716s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.695s  ...  1.723s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.168s  ...  2.148s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.379s  ...  0.381s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.774s  ...  5.747s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.051s  ...  0.059s

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
