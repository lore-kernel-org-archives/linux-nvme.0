Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD417C46466
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E08F208C3
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Al3yD4Sc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GE/WH5Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E08F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=N4sthG/Md4l46T7lokIh+MC6pS5G5Phj8eYeYgxNrPg=; b=Al3
	yD4ScfAtobMKZ3hkyJwofmf24gpJJLkUfSD1HSy19E5bXD+xtUSvD7klC8UcUhlTb/Fh/10Q0BOlC
	hV0EDIq4QMMlPuxEXw5Mj1vJM5/JThgOHWGA/X40U/Ncq1kn2PY28xYSNqNFIxOYnV11PDZyVE0Sr
	26DG4w0P0utNv5UrPEkKiH7wnDh07TQN1s1x6ERN1SnRkqKPBOXcTdH44r+uIPR2Dzy3MsfF5LbW/
	CBh5IgmcdugifAjfZP2LbB5QgTD+oibvvE2YP+Ejcc8FYSGHIcQs4hdhUgUQ4nFcG1FcjpsCgetgp
	2tw0UyWNp523afnzV67bL4Mel42nMtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQA-0006Ac-Nf; Tue, 06 Oct 2020 23:31:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQ8-00068c-8l
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027135; x=1633563135;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MN04knJ3PnGE1j76hIGDMKDFR5Qwcb1UfmmShef5vMM=;
 b=GE/WH5SpjAtSIhzUgnq13NGDEjKdPKrnlDOirfMeuag0zzAyaX86LkR2
 aqgagCEaMbNaE/lr+VjOC8W8hvwAAP4hmL1H7y9FrSjVczpEI8xGu3jdy
 mAbZ/wqvKa9QpGCpCue3A5ut/bXggVs32OCz33ZYGF7SXGI3nsTRyyWRJ
 34E10rhRrUTkPiH+jpz9OpylY2c8iAgzKNftGulDfj0INoX5Q+RNHjhFK
 LemG+DG3KgqJDYI4a82C+ePO1A3x4wrT6Uf+paK9qhuoJaVIhy6kVDR7+
 R173qEq1qlr8gi2HZoLXxyLTUg8zgLs9NMSTWf1GnDziKhmgiGKJU8O6E A==;
IronPort-SDR: etgS0HnCt9pGpV4fZ4tBQwPjsmVIX12UrttXgXuK3TQBSQ9FM/vzG9iKyZXb7eBMbklXtJhNWR
 UD84oS/7s3csNMiK1Pq2byI2HTZGRK5yOa/uNEw4JkNktew7d0VyHc5zawLjYIe2Xj+WyEwo/S
 yM0EIzYrHY54Fui+KImFEjFbwxKJ0VSgP0BKdDLt1REQbVfl4Iyd3CPVKJsqWyXY4aaJtsX9Or
 gWaBtuB/fvL1/nosIVHjakuXWWdBOJ8Nt6pLrb5QmnUPLZj8POmCc4PDul3AUtQXSynh/iiYhG
 mCM=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="252647575"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:32:11 +0800
IronPort-SDR: K45fcEznkiaOoQFf5Ffc3YLbBFVvHM3SXLlF1QTJRRmSKfAsxk9RXl7bVro1SKwHEIi82jT2Nq
 db0ozRpJwmZQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:17:42 -0700
IronPort-SDR: r6lNn0tXzD3E0G/h8vKA2JThE86Xqx+0k9opCXuVFycywt7ScKe92pFWCejUTqtye9R0N4LX/H
 Gx7QWV6+2ZRA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:30:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/7] nvme-core: timeout related fixes and cleanup
Date: Tue,  6 Oct 2020 16:30:42 -0700
Message-Id: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193100_496219_0E734A73 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============2310031389321909125=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============2310031389321909125==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

This patch series uses NVME_IO_TIMEOUT for the sync request submission
and user request submission when the timeout is not specified by the 
caller and request queue data is set to NULL which is true for admin 
queue.

Also in this version, I've added timeout values setting for the NVMeOF
passthru controller given that passthru VUCs (both admin and I/O VUCs)
can differ in execution time than general-purpose admin and I/O command
set following is the detailed scenario :-

Consider NVMeOF target is setup in the passthru mode and both target and 
host modules are loaded with the default timeout values present
in the nvme-core.

1. User issues nvme cmd from the host to the target of nvme-cli where
   timeout is taken from the controller log page  e.g. :-
   # nvme io-passthru --timeout=XXX ... 
   OR  
   # nvme admin-passthru --timeout=XXX ... 
   The timeout value in the above example is greater than the default
   timeout value present in host-core for both on host machine and the 
   target machine.
2. The host-core on the host side will set the timeout for the host
   request and issues NVMe cmd over transport.
3. In the absence of [1] target will set the timeout value which is
   default timeout and that is smaller than the timeout set on the host
   side.
4. Due to lack of timeout value not passed over the transport leading
   to smaller timeout value for the request on the target than the host
   side, target side command will timeout.
   
   This breaks the scenario where the same command with timeout value
   from nvme-cli is able to execute with success when issued to NVMe
   PCIe ctrl but will fail when it is executed on the NVMeOF Passthru
   ctrl.

Regards,
Chaitanya

[1] nvmet: add passthru admin timeout value attr
    nvmet: add passthru io timeout value attr

* Changes from V3:-

1. Rebase and retest on nvme-5.10.
2. Update the cover-letter with detailed scenario why NVMeOF target
   passthru is needed.
3. Wrap the line under 80 char for the last patch.
4. Change the nvme_default_timeout() -> nvme_set_req_default_timeout()
   such that it will not take timeout argument.

* Changes from V2:-

1. Introduce nvme_defalt_timeout() helper and use it in host/core.c.
2. Use nvme_default_timeout() in the lightnvme.c

* Changes from V1:-

1. Instead of using qid to decide IO or ADMIN timeout use request
   queue's queuedata whch we only set for non admin queue
   __nvme_submit_sync_cmd().
2. Add second patch to set IO timeout for nvme_submit_user_cmd().
3. Set the NVMeOF passthru ctrl timeout values with default values from
   nvme-core module.
4. Add admin and I/O timeout configfs attributes for NVMeOF passthru
   controller.

Chaitanya Kulkarni (7):
  nvme-core: use I/O timeout in submit sync cmd
  nvme-core: use I/O timeout in nvme_submit_user_cmd
  lightnvm: use I/O timeout in nvm submit user cmd
  nvmet: set default timeout for passthru requests
  nvmet: add passthru admin timeout value attr
  nvmet: add passthru io timeout value attr
  nvme: use consistent macro name for timeout

 drivers/nvme/host/core.c       | 10 ++++--
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/lightnvm.c   |  3 +-
 drivers/nvme/host/nvme.h       | 10 +++++-
 drivers/nvme/host/pci.c        |  8 ++---
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c | 64 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c | 11 ++++++
 11 files changed, 103 insertions(+), 13 deletions(-)

-- 
2.22.1



--===============2310031389321909125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2310031389321909125==--
