Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB6464D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB6464D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A5g6U/uWiMB8hnldK/4KJLMHrU29whePKQ898E2agjI=; b=sMsb8LvXIVP0bgBuMzlqMzAub
	GlHl6KNh46smdnlpnl90vS04y46SBrJE9k8BlIfmW8a3YgM2MTrskKoTXiw4M8eli1/SH6eEg2iq4
	UA1QJK8jH7b8K7idqxSj3GxuX+loTP9CVYHj9Gw1dlC+yeSoGQ5QV3L46iK0yhqoxUxfYbplh1vrT
	KatY3aKk7o6iHJ7ZQMB/PM3tb0r7TI7XSk6fwtJqu0H6Enp89SeW9tR6OpoXM9cnVcQqfIwUf0uXE
	ErkksT+nuDjRHL+4WEwsiA8GQP2vhYIPYn1mPFTxrXSsWlH81LL2o+j2icMDe/YQs5ZGC9/Cxt92U
	1k96C739Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wX-0005Tw-L9; Tue, 16 Feb 2021 21:31:37 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wV-0005TA-KW
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613511095; x=1645047095;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ri+BwQxJ8ZTVcVZrLxfBWwj5pGtXwYMRvjzo6KiBMp8=;
 b=FHHqJvb7MNjJRBIJXeSAi1CwaHhUdtCFwQgMDIu14iO+ulSnREX7qWlE
 EouCI15k1mWm+iWaUZBrHZdg0ocXNEHFn8fWNJkt7yQm5y+GSQ8kLEvgD
 w5u6VHCwqTG0EfwqkdRZzkmT5ODHSUJwkojDwLtNYb7wi10S/Mnuqahh1
 yWxwMfNUBHUhbWpEBkYZ0mUYmM/aIKBxi/dldA/oLGkewGwgv+T/FuAdm
 +RUWIuvD/AaljMKcjcLYwp073OXNGOXMBSv45vU0+1OYQyYiAL9MIGCp1
 BgsSRAbcB+mOBjC0j6KG3As0zRctFv7DXiiMh2T0jDHQS3aq0gUGyUAn5 A==;
IronPort-SDR: hOju/3z7XfViWUNWBt/bR+UWnIWr9e/YV1BmeXwoQrtQAPaAtMpvI84nXsmLSP7rDPeLrH6cnc
 oXWOraKIyX1xKmstQvpqWGyjfI7bNAldTLfjessN7d/Pvy1G2bCNANXbxuuReD/PPs2y0rL8Ih
 dpPIiuMdQWcb0Os8DdpHbXgV/BUQYe9uZ6TomKuN7zkpW1GSo6Dzdo+n0b3MRDjaCLaEwDVdnU
 /DlclCkSZQeRxtCTsjkWGgYzsDNvFuRBC+oJEseFC4PnkpcTMSB6Ep2+WLhLGsEdXFx8Xga2yw
 1NM=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270620011"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:31:33 +0800
IronPort-SDR: rsLfkBbM7XDDbR4UT7IIFPnyqqtwKehbAWda1Ql+RSzr35DOCq5pff7+qv1yr8JTSaNagxGkSy
 x4Nwr8o00a4xoRYq7XlXZEaZG6jURwXmarKr7+F1gsbM1d5RUhNdDRIEaNttT0wBpuF1HJ2vHM
 obMaCFRsSvxOOOJgAY1VR/tMhdMHkKrU9eIl20F8p7XLF16yXXeTRD9/8/1qKxDpD6nbHs0z5L
 Lz5EMkxW5HyckDoKX+E0/5taKt3zWc3rH4I/Wyx/91mayonKn5DzUu+4a9A4n5lLauWgUB3lIt
 tOj0T8wC/qjL1lmSbM8SQDnh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:13:18 -0800
IronPort-SDR: KiAj/CdY/lppMF5CLOrSuKo5WO4knWycORVtlXaCXvMZZzvKiwttauX5N4rjVGxJhZ4IrSdWvb
 Ljfh8B0pk9FPcl2TIS8c71RQ9vSwBdVXpyxLEL6fNboMZLCcfj08mJWCqjA2fVrYXjIeiJMlts
 T3oNjSZBC0afgDHO1Ez8tXWM4Nygv+1bQRL1Ed+45Z9bc/k9GqfpT0+hheZGLBnrR1MBFk2ejx
 x9pNi8YPGzgykzX0Sk2kBNE6LYPDgLpCSAV3d31XcVunY8JF4MbaWMOrdVp9VDRJjd7kpQHviu
 Mgc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:33 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] nvmet: set status on actual error condition
Date: Tue, 16 Feb 2021 13:31:08 -0800
Message-Id: <20210216213112.20078-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163135_826921_EAF7049C 
X-CRM114-Status: GOOD (  12.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the nvmet_alloc_ctrl() set the status variable to its error value
NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR in the actual error
condition just like the rest of the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 64c08b71be2c..df2d3de0de62 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1305,12 +1305,12 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
 	}
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
