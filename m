Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A91C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NZuJRy1a8xf8P0Fd510LDohkaayKIK9cyqlc01uY7kk=; b=MHWB6grKW+lr2aYLxe263iq2cH
	mVHpsJa6DbzEDMRUQpk6uGmgdoAv3EICnozUsPIp9MkrqDFtAX7jMETaGunDSQFaKyEQQL12V8CkT
	t1Dkr+FHlCpfrysXoXEFwXpDjNXcDCQ3kzx1+3F9OZ6hI5rk8DtD62m971BolD/AtCUfWP51iiNFo
	cbArKLpnNxYX7wY6Ij5LzYFQl0dDPjboune0VB9zuYuUdIw5eUsID/LkT6bM+MzyRD0w0VE4vl3Ep
	0j2D8wsVt9aMZd7UTdrb8S0iKWi0oeCtq5KRDT5Q0Zgk3UrxcAgl2ZyHTKAqAgyGYICXE+dp/vLiK
	U0fU4dyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQSCr-005dVM-5Q; Fri, 10 Feb 2023 12:08:45 +0000
Received: from mx1.riseup.net ([198.252.153.129])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQSCo-005dTu-DY
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 12:08:43 +0000
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx1.riseup.net (Postfix) with ESMTPS id 4PCsvj1QJ1zDqJ5;
	Fri, 10 Feb 2023 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1676030913; bh=006T42n5ayIRq96/1xRWWSnZfPhFc8SBxKW2hAn4L0Q=;
	h=Date:To:From:Subject:From;
	b=Ivu5tZa2XuBkk/CX5DfwpqbMIdepENBDpMnaRaUfpnoMOBou0NdzNELw/SZhk6cMC
	 2IO7iptFtstJj9RtWpRQ5xHgmIzJ2AmRLFTHYO90nG3WnxaiTaFjrNWgBFaVrS0lX6
	 bmg80ddng+QYRqdz2OPK90eMyVSxAMVis2C7Wh4E=
X-Riseup-User-ID: C971FB09AF76FF13C7B5EE703B0DF115B822322E6E6A097822E9006E73A5AF41
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews2.riseup.net (Postfix) with ESMTPSA id 4PCsvg2ymqz1yTd;
	Fri, 10 Feb 2023 12:08:31 +0000 (UTC)
Message-ID: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
Date: Fri, 10 Feb 2023 15:08:29 +0300
MIME-Version: 1.0
Content-Language: en-US
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Ivan Rubinov <soltime@riseup.net>
Subject: [PATCH] Add quirk for ADATA SX6000PNP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_040842_517682_6D05A81F 
X-CRM114-Status: GOOD (  10.25  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

 From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Date: Fri, 10 Feb 2023 14:59:41 +0300
Subject: [PATCH] Add quirk for ADATA SX6000PNP

Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..c63443d531b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
      { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },
+    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | 
NVME_QUIRK_BOGUS_NID, },
      { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.39.1


