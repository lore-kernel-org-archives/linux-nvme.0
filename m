Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A306C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA4720720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wDXfXh9P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rh/oJG3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=S3uuppqkiks2UDeMfTsIR5ptKLqBE8hncY1JZPyCOHI=; b=wDX
	fXh9P5zI52fL2ba/HPO8ivRMy5wDUW9Z5aOQ0Qty9eUren409+TffujIMXN3PDYQYazGIdtON+h3W
	5xJAvXGqEKEDkvYEs2BnszEqItGThkGoP1aJyHsXIGUMwuWg7JycQGEXe2mNftgHiJhL0ih4wkoBo
	n/snGUC1Iq/u2IXwfAsExCBicopf4Lq7bTRgmaiea4A/kS4/ddqjC6zCvopB09l3/0aJ96mblBtGu
	PKPySmyFo6Iv2ztSieeL2DSQtdX/3dOVuJbFo9NoWgukXQTVy4xF3uK4juIVOreV1LyoZ/R15ziSy
	LOIUPdfUKHzhx7K6f9uz7HVcGgdM9Yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHe5-0000Ag-H2; Thu, 29 Oct 2020 23:47:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHe1-0000A5-HL
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604015269; x=1635551269;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6HwNE3qQ36drRWSKjGYYGjDEr66RRue4f8OEO/VeUMM=;
 b=Rh/oJG3oG4doTWBEntbumLvIHixUHJpgleD9FZSohPX0j8ai2ILHl+Ki
 Vl5ANyKQVCJoQ0waZ2dBjMMFynLHcrqrn7cL7X7xJOFHzEyGwpzkq3vsJ
 ZzvR0MXuoTpk9WskTHs1EjI1YjFVIHLGWVhuysxnBOuQIVuQeaX9DaNug
 UaIoV0iV84/a96N/tDbmiktRqZfIu89mIXlkHjCOVN6FgaQAsOJX8NnbP
 QlugI6KiaPFN2LSK7xHVidJCcq5pf4cD0YUPJ/WH+lxfr5Rl67H3qNUEO
 0gDEDlnLsqQMGNcUc9Dzcr/wkYPy9jglhWwMAofxGpFeQtyITYO9CKkrX w==;
IronPort-SDR: 1bmFBV5BNsaWZZJoNqcX0/0MqDK8RjPJXqS9j9s+CCXrVjDpM34NmAwRi655g3zLbIMNFqLkG2
 P6VS4g3/AWp71IMHOFIiAnBCmhhi0pO87FRlLMuL7fRBkOGBrbsWlufmpXqbJkxS5OwCuOClS8
 BOcJf+n56lIeDXbZW7C0Q6oZz3BkLrMPiWeBPkz9qOu4LjOc04fPg6c7SxkugAMg3mx5eSVXYr
 LAZLPdBcFlIwV8TsYpvPMose/8Cx8wGTn4k7EgeNwTxIRbT8YYYv5F/sKmmo2Jx6Srl01OAuXj
 rpc=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="151368476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 07:47:47 +0800
IronPort-SDR: pUj2pzsyTMvTQaj3suz5l4+uKGBEK92DJUPq2nzQ9KzDeQW5+ClzHl0PNWNO7fh2XIIzAQAia1
 s0+YkHciKuXMPGqqmKm/jEZXxdpxRAW97bEoldtbVOSU42jWhdqsDw2Tb3oxwlrpVK2594LX9t
 gGjhDD/aF6LZiLeP65YgjqqWNrmBpzxT0/7iOx1w2rvbBADk67qcThCJzY1b2gjv0N8R6KjqJy
 t88SLd58rP02R8K5QyryT76bSKWye/UXI4VyESOsOD2x2k2BVLN8LMi+SxBmLIJY9UP5+Y+I5v
 A4rV2HrAd3LG1QRS5GnTxMKT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:34:02 -0700
IronPort-SDR: pvRTAdn5RkHJfFWi3tcw+ftQvnKTkZ8BDwKhkWWqWDhWb/VUOOgd6vBeeUZnAFMZqWwsvBx9Aa
 iL5QnRWsdSLFGL3p919rYaUulsm/00+ucG8BXXhWUERPfAeeriGK+Zw1Wyn4fKNf1IHYVWXXO3
 j6x5jD3KbwmY+WohXa+x5mhZrVca37loVrxuYvCG8moHHkp3orgLuP8wmHo/r1OpeYaTuH8CwU
 gI9oirWRztMcHqtqV5Fy/27YGyK6YnEuYN3gT9svLb8jW0fpgo7AOeQ3SUqiYnqDv0XXVXifo/
 nd4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:47:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 0/7] nvme-core: timeout related fixes and cleanup
Date: Thu, 29 Oct 2020 16:47:32 -0700
Message-Id: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194749_786710_4FF72C1B 
X-CRM114-Status: GOOD (  18.41  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: multipart/mixed; boundary="===============0616578760644327083=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0616578760644327083==
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

* Changes from V4:-

1. Rebase and retest on nvme-5.10.

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



--===============0616578760644327083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0616578760644327083==--
