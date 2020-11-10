Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B3C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397A620789
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0aPjlZS8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gjf3UvaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397A620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=n+4L8eguxfUOKoTi9iXDsipeM7wUIysKC/b14pcR8dc=; b=0aP
	jlZS8zqppFoIhNwReG5u1DYRYWyR9Bzdm1GALr+3zCrZEpl7uRuiSdFs9cCCscaDsFoP0EtSJt01x
	rDXrql8rsE2lxGNIch+ulG5kYGCIWktq69sc9L4IxEu5gLA4pVW744LUbMkf3Qj1+TRMTmC/BA49C
	2jd0ah1lsnGUbDm9Iji/ZvOkjIZEzbEXd0xVQsU01qg8yeC1r1U6lUhH4G39L5Z8eCmOXoww+ACwd
	j80aLuY2H6s+/+cVjOhJcyjg+URaiBuH7l9e9tzdiN4a7Wz94vD3zQvBfL82X230+/5sCMZsJJdNn
	LNzgED4kc8PKRvWsl1GFkECCT82slug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcHbf-0001xR-7k; Tue, 10 Nov 2020 00:33:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcHbb-0001ww-Oy
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 00:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604968431; x=1636504431;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NE85jGYd3xXtkq0zxn2tyXhUPzBr+mMgyxU3u74JocU=;
 b=Gjf3UvaBw9cpaYiBeDO0IUzhUZM9f+8tsNaDErZSTOdP95Uj/9k4Slfv
 AVK9K/0mm9YVqOkiPZGggPDayTbg/ldBbOl9Lg733kSNoXcqiUVtsENsV
 q2VBULh9Fy/YhVYBJKhwxo+ZPpN1oFSSAq0seTZlqfjnRCNhDMDKPhSTy
 hb4WtAwaGH52HGJU3N3afZVJoXss5P2ceGyWh003S3hFw91MTGhB3xgU9
 kD5SKxCj15bAlqOm3hdUTnlcSHumW8j7Y22fNicibfSOusKDaxa+J+TbN
 OuCzl/+xCWxSwug6pHqKHdNABJop/8tH2/E50L08Qmfm28wrI+rWBtIbb Q==;
IronPort-SDR: f44IH9evq27/1VbHn6GFhw7/87qI9k9FrmEFxoAmzXaELPsUGAySmZlOA1nmvf1Fmb9Q/10yUN
 wDvMQtJPXVk+5bGkMX6fUtOHyi0uA3DLrserxDuGjuH6wc2GzVbnGgaToIIwCEaeXcq81yX7Ts
 /f5myV7BI8C7INk795Sk8fjDJKmPueLqT+NOIYUpiPSaGNJ4Acl/pMWSUM8vWr/tnY5fnSblCn
 Zw2NHnT9RcdzNU0NoORjXat76ft43TgMC3NTysi179buyrJMOxNcvM2HAfWtDqQLY0fEYMevgO
 LKI=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; d="scan'208";a="152131748"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:33:47 +0800
IronPort-SDR: A/2zeVZMvE9LfOmIQAjcB8Ao6TtHJ1bigQXzFzpxqnR3NZgQoiIY6z/DtFmPNTy1E0ulcKESLi
 mwlyZ60Qf7INM7faCmWIHZOZykqdan28Aqz4pGv4anhVmyVYaQKEBceNq2DlvPd6BObioCTenE
 KTgHIB0xGvcbc/oVSkowqQmYfxdI22HYymeJVJAXsv4jlnNZmhRr5pVg6tDrctzc6RLOKuYti+
 /fJmFLBxkGSZsY6MdhNoH86QoMjU+UNPWozxVNfRsmpCneht0p6ChaB/77yUgwtFzLJ0pkwEF5
 iltGDehnWam66Mt6Z/6VHIXZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 16:18:35 -0800
IronPort-SDR: 2aE9LZ2lnc2IbpQIs65VEAESC8MAPPj65+YpOhxy/uioEr8Mv+BCi6zzCIRnBCy6nbJ/xu/foc
 MQDls/iHgMNS+Oota6fAF6se+1slKiwdAFscVH01sryrCGU7E/V5xlybVjAfFBpQwsE8mLCkkK
 +fltlMrIOrHR9XPIU1ebFG9frqzr3yln/oByl0ecgZdbHkwAcw82VTOEt40FlCH/idRV1puobb
 0wsiTjVnn6uMKDdAA1pFjvMmo3HM66eCci1dXjdZLG7mNVTRZ/2t9DB0Imns2Sjbk94DxgD+pp
 CoA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 16:33:48 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 0/4] nvme-core: timeout related fixes and cleanup 
Date: Mon,  9 Nov 2020 16:33:41 -0800
Message-Id: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_193352_035885_24F4E96A 
X-CRM114-Status: GOOD (  20.20  )
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
Content-Type: multipart/mixed; boundary="===============3174092124474696470=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============3174092124474696470==
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

* Changes from V7 :-

1. Remove conditional operators.
2. Pass 0 instead of NVME_ADMIN_TIMEOUT for __nvme_submit_sync_cmd()
   when calling from nvme_sec_submit().

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

 drivers/nvme/host/core.c       | 15 ++++++++---
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/lightnvm.c   |  3 ++-
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/host/pci.c        |  6 ++---
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c |  7 +++++
 11 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.22.1



--===============3174092124474696470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============3174092124474696470==--
