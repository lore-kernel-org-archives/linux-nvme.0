Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACEC19425
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FFB23B45
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FFB23B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hLY4pPxDuC8AzFwNM8tbQXd7G3uPLY4A7yN+Veuy6eE=; b=tZWlS7r1lMzCBJA9PwNJ7bMNVu
	xSFco+5LHMV49g7F2f9/mHhf6+PEiFBwCyDVKV6xIOT5B8u5ltFySooeLFdK8ZPn2FlAFJYqY4q3i
	wm3k15IbBseba2plprmqTtNAtPB+OtdalJc+IYJPc/jHTuYI0t6G8LpRPpxlR7VuAd8xFe76gbvgL
	mhEgd7NFRDIR8Vtemr9UnKOxa9QIUcPhgQ/j8d4YgJPAcqmRY1cQ+1CoYsO7TGSNRoMoxsQ37EonK
	MsaffWfQ5ZI6pgnh42aiYRY0I+MmEkPjRiYKMNwplA1l2ZYBIUdqHnY67tJwRcN2t8imJjlZwiZo4
	PKvGPuxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCAU-0000C7-Mc; Thu, 10 Dec 2020 02:58:58 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCAR-0000BF-UL
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569750; x=1639105750;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ox6EZGac3PKvW7Z5sLg/TA78onXmd/42pQB7Q6yUqcI=;
 b=lz/PJeh6h4FWNckf8M5GbaoT34GYkYp/nWh72Gt2uO9EA7gd6oFFf7DF
 uT2eq0F5/t2+Jv3WhjzumGU4Hfvo/VA7Y81GZnEPWbaEJ1vHkZDJMemap
 OE9iCfRHIcD3FxeprMJVcyGptBVB3FX6DkLq7w500dWs+Q/JC/HW8CuQy
 7kDqFb3TYxnMJKNp9dBdrcPCyHcxwRg2ChMflmr6rachtX00dISBqW7ig
 6r3RHEP2LAphW6OKOq9rPbZEKBBHunm9UdY65zP0ToQ9IBq2OKR09bUD5
 g6KYoW1U14msEMG2xRgRj0/vtu4u1A79FPRy5yyXZohdczf+LsYeFmNx7 w==;
IronPort-SDR: FKfBTLdYfXX5ZuKU2qdKhpLKXbkxyrsUUOas33XkkUzpAhOQjLiWPqglJoHlBhWBr3qmMOUJkC
 9QoLCf9PzImUg73U6xmi7COT6arJDpGsvgXxbMNi2KJtL40kGDXT9a3PO2w0/eVigySOtD0TD+
 4pwX1GAs3PaPgcfcHPJt5iu1DPAj7jLN2p9RjbiB7BwYjY8l+V4iq5NYbnpsqMLW2eqgGMnZwU
 5tpBVQF+6fIj/AV/wf72B2H51LwfY+sxkA90Gbv0Ga1+S5jA6LbTCbrz3IU9LNlRZhgcE5uFa0
 5f8=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="258549075"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:09:02 +0800
IronPort-SDR: yigH+PdxA6GxgK0x//uzlLjEyLqAYi9zQ0i3qk3iu1v9vdvixfsCCBRbfpCpCUIlTpR0C3cBhy
 U6wSvHB+DIAMikoGvYRD7Laj+CWiw+oxE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 18:44:16 -0800
IronPort-SDR: ElGJm6/XRpsrRy4ZOkAqC4tg8KVKhXNWYM4G2xdHT+ZgxVEdgEZiBZIrdQ1C2bFNsxHrRUEaCR
 6eUmfd9CSyrg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 18:58:51 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] nvmet: admin-cmd related cleanups and a fix
Date: Wed,  9 Dec 2020 18:58:44 -0800
Message-Id: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_215856_102448_CBA8B761 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
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

Chaitanya Kulkarni (4):
  nvmet: remove extra variable in smart log nsid
  nvmet: remove extra variable in identify ns
  nvmet: remove extra variable in id-desclist
  nvmet: set right status on error in id-ns handler

 drivers/nvme/target/admin-cmd.c | 76 +++++++++++++++++----------------
 1 file changed, 39 insertions(+), 37 deletions(-)


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
