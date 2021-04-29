Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DCC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E286961408
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E286961408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=02ZiLDBBSd0/Z6+f1p4FQMg0dWIALz8kWhEQ5GkG4lg=; b=pU05uWvbm6YTucmGeM5Q16X3SA
	+8o+DnTEZhLw88zdegeS4f/RxQed9wCmKh6QeyhTz2vwuJd5hbXmXCFKD/SYom08Z06R8U/+v5aPj
	Z1mxxceHR+MGC0g1uxzoHryYl4DtE8qCSTZO/v0+C+7wTqHUXlg93bNyDSnWWdcoLYQ6GSfAd6yW5
	MfMm2+FTSAqD7fX6ULs8UTjnbMUE78OInQSQfLlxk8c2C5tqMGP/zeUfT+fgMze3WLwWp8PSaHRnM
	611KWIUOLoGx8NKuA2RFzNA6QPY5qpWay3qSiYKRvdfh+/nCX3Am0S9FTd8AWBbAjHjp3GWgcqIzW
	SBtPdRAg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcBdx-006CcU-4F; Thu, 29 Apr 2021 18:44:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBdu-006CcF-Bs
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 18:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=bqWnKAfMi8ePpDQ7HE2Cp8ZphvaDvwinABBpuwWJdg4=; b=30rQsa3ZPGj5JcxynCPH/DStkW
 PKkAZNmk847vjupv8W7gxFRVfT+4mHC81Dh2cZ2Iwa8nrv7AAXDj40qu/4y5MN2KFOc6L8wDJSR/9
 AAMSgDCZ92ZvfpVQk8PlBm40oacDJRJRq5BLNxaMKZErNBYppqbB3LYWZ4RVZDqzBBd1Lgc+KsgFb
 R+wHU3J65rRdlBF0q7SQbYOuEArQWQDXL9aAdCrUBMh/allVeEPsUMgDz1vN/w6q8XGqHDpER/HXs
 w1OHwm5QDy+MQBduZ2RsCvKLuLuNlR2GUf3+H8k1zhNqkQuf7HcUH73o42HXHNnoPIQtPvkPnv7nK
 tovQ7GVA==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcBdr-000rJ2-L1
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 18:44:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619721842; x=1651257842;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+i9oJtkeEI7HAJyZHSKe6IqTtCCkY/mDsovbAzzrzG8=;
 b=c6TWxDWDfwKRx7q8m55Xt5/v0yLXbDQt+l/rLB2C073OcCfgasjpSD6Q
 doqY4RYBg0biZ9o2Qsd122CekfCBnMC2hiIIVdp1SQC1Nir8Sji31W5FB
 ePEf1j13/PhJgIxY/Rx91ACQuFoe2XExZoseaByFj9YcXIklG28J6UVIQ
 H933lGmlHoc7F4Gh0vwhZf6QWVoWLGVKgzB6M4qKhb36reYe6AZqAnIrt
 qlzOffF9Eh1bopKUTwbXlzfVSUlmnXdO34xrtbK4sE1nnC26lnhOgxOGq
 4MaImuwfKSQHWRY7gPJSP4dypRZeYvLyvWwa8ectDaIBZo3mr1aJrIwz0 g==;
IronPort-SDR: rfCFKZdxf9EPui5IEizKbKPKUXtUqOsE3GwI+gBEaXCrduhmn3Ip5a4dS7ytlZ7Sq688bw7BQL
 Tz+DGKND42YZcXlV3fZuZO5F9nzl/IX4QWwIB0l+X/8fqK0un47BaRxWUzQSI4cthWpnDX1MHU
 mS7GNnofduVce63xomGQR5iCViLsiqWX8020SO/XWO7DQm9B4+VtMr4jWOk88hgw/QPl4Rj0MT
 NE7NTyN+NA1AJMwIR9ypBCeCh6kj/U0W3ZZ1aYJxNkYIzVDFhIVM3Iv22oPPOD1w/BTKt+hy0H
 mcA=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="171236388"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 02:43:59 +0800
IronPort-SDR: nlfbV5PRbHzLPBVRY350eCtfHspGC1z+XAsA/+PO0PG9kc/EtIZvU4zs2w3GcinSfKUwN9kISp
 e6MPYA68L6rEKGp7a10eFw8oXL3BrCT049FnXaaIJd3/YP0IKlAPdkWyHbqGpP5slZiaSzNQVt
 V1WSDM1hSg77R5EtQZhGeJMPNbr9u3qBtxKIPV1UCUNNLHojXeQWjMV/F5QzPoD4aw32JvkmGi
 V6UPPlictQO8d434vh+KcpfR681VCUDJ5dnfLHRdhNVumJ5mKycTNaQ1W4ya0YwffgR+p2QEnk
 ckFek29tJUq7Kr/O8PO7LzuX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 11:24:17 -0700
IronPort-SDR: hHJVQuRzZMAkpip8paEbYfPfDOyauHEGOxvxPzL6QA7tqCEQZ4uP955dqcUcjBb6rD9dqwVzWV
 7FcE8rLVAaEM/hF5BsMNuMReoPc8vXywq+GM99kGCp2hGvzgHhXwGV4buSbKZ4EKCVWMpsgs11
 wARC1EBJTDnCA7ORCOyc2JXzVFs7p6CP7k76s1qqv5YD+S5SOypH++pulwBu0XPEj3vCh+lPld
 Pvg0T45WAHOB+ZV95ukBo5ueObY8z2d92VpNhC+4KdWdzJxJ+t5yGFUFC8EQgWJ4tWqtsdO5/p
 bNI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2021 11:44:00 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
Date: Thu, 29 Apr 2021 11:43:55 -0700
Message-Id: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_114403_724471_AD479F09 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

While testing I came across the scenario where checking for the
transfer size is not enough for inline bios, this issue is not easily
reproducible with the test tools that I have.

This small patch-series adds an additional check so that we make sure 
transfer size and the req->sg_cnt both fit in the inline bio for
bdev and passthru backend.

-ck

Chaitanya Kulkarni (2):
  nvmet: check sg_cnt for inline bio for bdev-ns
  nvmet: check sg_cnt for inline bio for passthru

 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 drivers/nvme/target/passthru.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
