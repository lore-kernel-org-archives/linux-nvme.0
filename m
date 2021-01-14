Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BAEC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBE123435
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBE123435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RuKnChCEVem3mDVjySYLgAIVwiZ1T/n5toJMM3422qo=; b=QwTeuYPMrsqMq1HCjQhKcagAEg
	XoUsbCLaWFr2hfXzOEjBb8nxsNNmj8HR5E73A93lptb28pqjETjMtO6d2exB3ETqPTj5shzIW+W26
	IL/G4G5axHEaDR21hMVBv6tBnacnsRUQLe7OCD2zjgwygrw+x/VI3pN8dYpEb7qQ2eUv8wORx6dqo
	weQTdj5/O0jewHPzsCzbVK8Cg0EUNqxeqDQrrA7/VM00XTEb6O+1gB4nx27JpiG3SiJHgxPRm8riC
	comEnsQXfFFui5MKhkCyBfMNrEh3CcQTxUNUhRXCyxfImnhXUzJpW9UWn4nMIpD2T6ZNY2FrOFSsB
	nn1bFgqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrWU-0006e2-FT; Thu, 14 Jan 2021 01:34:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrWS-0006dV-6z
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610588990; x=1642124990;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eXEMsW+0I2Xv/nBUG8hZ3zbwcmnPVjckMOniHbxeiV4=;
 b=R24BBlgc8bIMFoHdagsLB9YnLwMrjlUdEGhC0JpmyvO0vP0NpQ6v8xUb
 ZwETs5i/DqLVezI5CHbKpY6pdNT/vYWl6AZlm4NUiCgRXhGYghGuBhTqk
 ab0VjC64ujg3dp3qS1JEK/iMucZnBjcFrwSogiTY0epCU1q6cg2vPPxOn
 6kM9IFdkmmf66QFf5TS/0ZPKFtqKLxV40Yh+8mG0OYPqjWpQ0EkkphK15
 9s3/eUkdrS/h6ycw1Wb9QYITdbMgUrdJCeIj3Cx555tCHYe4ZqmzoxP6y
 VywRqXQGSew1UtcVI+OYErpien26uuLgPgg9jZ5sNfs6jpBwZ6JG84n0J g==;
IronPort-SDR: 57YtqnN9hiHxyGpjbGzJ/JyvC2TnVREp4rP9/YRXOIuXIjWsnOVQ/omhX78qwX3zDMbYrtgWcf
 oGQo2EDQPUyc6kLAEs3DJJkpRUFnwIsWmkTfFzyZYVlrgkKxvVJ/hDwgpR5i/JzGcvq1m86dTd
 DUwb0KeiNVdrjdTODEPzDZVBiceJr+KT+J1cOmmJ9gvvdFPKSGd29y7P1xDjxpi8NbRkQaxudu
 kCUzY3lb47HRqjj0yobgBR9u6wo5gE5Wnv0y77n90Gd0D2L+A0+UPxICAl8M6FONGXbNwa8uad
 4L4=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; d="scan'208";a="261291901"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 09:49:46 +0800
IronPort-SDR: 9nGqJE9fL6x+3f4yAe4n529gMfZWHjdPVMxCxRU7keguaN+XTyJm4gHnGKmyKKTlSqktevgQhg
 pHPR69fg/b118S7XA7ZcufAt+U5jC992V+hpGwNCefBelr+fit9RRdbGqX49S9HnmD8LuK+elS
 Vcb147g+m2RvneBQR3eMGEw2DfHd28W3dSwAzblU3xL0pSR6MtQXB10fJb0xVm2jNLjHpDR66v
 t8VR2ncMc2csfpXa1rFXJ1xq40L0+D3RN2pQSBsyvCoRAPZLU2kTbEazhk4KXLpaeluQ7pR2EL
 HkJ3XG+sGLkoLKPtp/nlprHp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:16:45 -0800
IronPort-SDR: Q6qLWwkaqnUlYEGGqLLjGg2qqfcSP3E57HTv8e+G9R+yom7yaQXj8ZTbiNhahUzIk1Vy4Zwv/F
 l0F8yD2L31lFoKFjni5SK7VYA1VUV2QckwrGSrQzRKGsyvytUPcqtHEAQp36zBsK5aFJVjHxqo
 07nuYaGXXpAi16uxND+9qxx61yq2SlDeBCdkN/URuBcsZj+LpyWbciSKC6D79W+XWgMjWzjJXc
 Kc9MlrYCki5izqiyQCMofx1w88mvq5Yqe8mf4H54cfMaJSB/sDgzFk/TPS48/AcPXmbrxVvi7u
 /RI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2021 17:33:57 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/4] nvmet: admin-cmd related cleanups and a fix
Date: Wed, 13 Jan 2021 17:33:50 -0800
Message-Id: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_203400_462140_BD497687 
X-CRM114-Status: GOOD (  11.50  )
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
calls.

The first patch sets the right error status code when namespace is not
found in nvmet_execute_identify_ns().

I've tested this series with nvme blktests, all the testcases are
passing.

-ck

Changes from V3:-

1. Don't copy zeroed buffer in case of invalid ns for id-ns handler.
2. Remove the out label in smart log nsid.

Changes from V2:-

1. Rebase and retest on the latest nvme-5.11.
2. Add ns status error patch at the front of the series.

Changes from V1:-

1. Rebase and retest on the latest nvme-5.11.

Chaitanya Kulkarni (4):
  nvmet: set right status on error in id-ns handler
  nvmet: remove extra variable in smart log nsid
  nvmet: remove extra variable in id-desclist
  nvmet: remove extra variable in identify ns

 drivers/nvme/target/admin-cmd.c | 77 ++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 39 deletions(-)

#./check tests/nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  27.652s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.136s  ...  10.137s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.730s  ...  1.691s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.113s  ...  0.114s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.074s  ...  0.080s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.720s  ...  1.703s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.683s  ...  1.653s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  25.213s  ...  26.554s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  257.846s  ...  235.864s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  47.453s  ...  51.182s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  249.408s  ...  273.498s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  22.446s  ...  21.439s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  18.614s  ...  19.769s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  16.945s  ...  16.443s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  17.179s  ...  17.091s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.676s  ...  1.678s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.701s  ...  1.713s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.662s  ...  1.665s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.666s  ...  1.657s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.099s  ...  2.075s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.699s  ...  1.687s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.659s  ...  1.667s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.649s  ...  1.651s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.658s  ...  1.665s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.665s  ...  1.660s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.663s  ...  1.660s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.025s  ...  2.037s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.317s  ...  0.313s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.559s  ...  5.553s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.046s  ...  0.044s

# gitlog -5
6f388312bf5b (HEAD -> nvme-5.11) nvmet: remove extra variable in identify ns
733d50382d90 nvmet: remove extra variable in id-desclist
d982b2b03fc0 nvmet: remove extra variable in smart log nsid
4a458a76be0e nvmet: set right status on error in id-ns handler
239055c858f5 Merge branch 'nvme-5.11' of git://git.infradead.org/nvme into nvme-5.11

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
