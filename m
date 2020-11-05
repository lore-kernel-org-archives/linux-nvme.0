Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF23AC55178
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F176D20719
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOaW5GYj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qKL14WCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F176D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=0CyVna2c3ORw6huG5VekK/6MRHQMjCDIdmKI1kpT8vo=; b=GOa
	W5GYj6wTmgoQPkdgwudO4NocEzLqLlnIz01t8CwyFR6MJDWi08PFaZusMHJ2ttRFr4L7ZSfvs5Dby
	siSCSneVJ9a8KjIVHr8fKWrXopHVT48US1+e815Kp7YFut5ON3hnhkk1hW+j+UKzSdmVIY6438a6X
	ZxH+ks7+GtLECHKJqUM8IQB5E4g7W1nObOQGamyGuAUIB7kNRwffAAxx90aIeP86/T/YcWi5uQyeo
	/6fDfYrs6GE3Zb26Xw+EgRi8hex3OkiEsgEIN6+ZXsX9JbdRCkaK0VLEP8+aJ0RvNjYiAeCKpEjFz
	PdyhkwYrBuDPhjoffEY3+yG9pwVdrcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaogN-0008VM-9l; Thu, 05 Nov 2020 23:28:43 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaogK-0008Un-Ba
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 23:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604618920; x=1636154920;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=61djVsZI+pfv3/sFJYvnluhRXZ3FDBJT313++vkHx10=;
 b=qKL14WCFJv2ev8PSAqxREB6bF7D8fS0xocKPcn96qJKdVYC1TCyhQWyC
 sxwyxU41Qv0oO/rnn5m7OE89yT2firV/+TaZTjEFVAaJdC1VjjVLc3/4X
 KdazR9Sv8fyoysezT/yQnYlT7B8HyfaWZ5ZeZwnZxZj6eh5k2o9heCJX3
 G7LMAPo81XfmLXB/0xqsiVKQMdZB+lG5234ObnZITSK5KxX5z6fB31Kxi
 AXJUyHBpDw2AItVyaJZgh9ucQVMsniSQJkMxHBSfOTeX6bLXmF+oUSwrJ
 BTzAvkwszIPCYbKf88WaINKdhN9E47xjighQBlAZEgBdTU+ag6RH33Luf g==;
IronPort-SDR: tMfbYKyXHk2y2YpPdSBb1NaejB17iCQW260QwHG7Ay57vlcd+VBM1FkMy1EBYYe+HeGmCuPpet
 z72J+eqMiusTaAHn2gvBBeZYTUcl9mR5/SMK8r6OGF38gSXvE2R/yslqE2Kkbizwwt3wPsNcSN
 hMm2cr5iAmWI6n5Z9la9pcbXIQ7aeKeQNDR8Yj64zJpfNzq8MT8JIKomennLOnZRsYHHZPU+jd
 nBGLKLvGOI/KtTXvEv5XylFqXr3FKuiHsOsxk5SGAQxnqdDIMY9hWMAPKHpQmOFjr+gR6eZYph
 zZk=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="153178982"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 07:28:38 +0800
IronPort-SDR: kQzop0dHXug11NRQgEu4d45MnqJFPTXn1C4Kh8sKn4M0EkJMfitoCiHTFgldqFYs+szE/yh1OD
 XZ1dyBU5RVNIYar4arbzRxZJwcmaEKGYhvf2qs3ZaXEHLEMXE3qzxKS1vu0jauXQSl++O+txCO
 /ZlfJqDG2KFFvFw9e0hv62qgUDJ46Fe1lMyoCjBpcCKTVPCB4QxqkOv5IqTY3Ohb38mKWOWDc+
 aWm7pCBFTbNNUH51XT7Fgjin3IeZ/PSHtdpEdULEPRBvwyzdjanvD4dyB+kI6Dkku8zUUR+dDL
 QJW1BzWV96nM5hmkywSWmVFF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:13:34 -0800
IronPort-SDR: 7AINkDrd1VqCN9wZX7oyjjZEShlsG/y5XIE1giGh0GeD7J441yJo1u+M6Gx9arAbAsijiMl6m7
 D2s/xzJl9KumPvzU+kghsKCCidZndHiBobhygYmq+mLzgeh3nZtPWmiHBMdQHUKm+MNCNbLeWH
 8/iq4IwmRDo8U9drdRl5EiWgxIxPz3arxDoj1sZrykpH7CIMzFw3iUREUbekw10kXiXL6/cRqd
 tgFDpFFRq/5RllT1mJqDqnJvJYQOBSYIGDfOr7C9GWEPv5pC36rFZ8aO7BJlrlo/pxIhAWv3pf
 cjU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2020 15:28:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V7 0/4] nvme-core: timeout related fixes and cleanup 
Date: Thu,  5 Nov 2020 15:28:28 -0800
Message-Id: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_182840_604393_16B08C68 
X-CRM114-Status: GOOD (  21.08  )
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
Content-Type: multipart/mixed; boundary="===============2576243328057107525=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============2576243328057107525==
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
set, following is the detailed scenario :-

Consider NVMeOF target is setup in the passthru mode and both target
and host modules are loaded with the default timeout values present
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

* Changes from V6 :-

1. Remove the timeout parameter for nvme_alloc_request() and keep the
   timeout assignment in the caller.
2. Remove the last patch for centralizing the req end_io_data.
3. Adjust the code for passthru to reflect new code changes.
4. Update the commit log of relative patches and add reviews.
5. Get rid of the locking for admin and io timeout for target
   passthru.

* Changes from V5:-

1. Rebase on the latest nvme-5.10.
2. Centralize setting up the request->timeout value into
   nvme_alloc_request().
3. Centralize setting up the request->end_io_data value into
   nvme_alloc_request().
4. Update the NVMeOF passthru nvmet_passthru_execute_cmd() such that
   it relfect nvme_alloc_request() changes from the first patch when
   handling io and admin timeouts.
5. Move nvme_req_set_default_timeout() to host/core.c since there is
   only one caller now.

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

Chaitanya Kulkarni (4):
  nvme: centralize setting req timeout
  nvmet: add passthru admin timeout value attr
  nvmet: add passthru io timeout value attr
  nvme: use consistent macro name for timeout

 drivers/nvme/host/core.c       | 12 ++++++---
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/lightnvm.c   |  2 +-
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/host/pci.c        |  6 ++---
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c |  6 +++++
 11 files changed, 73 insertions(+), 13 deletions(-)

-- 
2.22.1



--===============2576243328057107525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2576243328057107525==--
