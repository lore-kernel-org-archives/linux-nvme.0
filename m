Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B7C6FA89
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WAHooePitRG2Wrs35vuzbHd8NY3KHdanVqS7QR9FpIU=; b=fGbaPJ0OwPQdkj9UQ1/89d/YTO
	0XDoIDbs2zxAJxjcFO2B6xBxS6AMhNE84jjqJQVxeJCWxGOYRF6JKBAuHGtnkGh0Sav8ttv2VRncj
	4WdtuSMSJUwetOcczxqgALr7C3NlUzQ9KxipJUMY+RFsWPL235vgvvy4L53nbK4fJ0zgAdzhEGla5
	WjHBmHuhhiYtqTesPNzejcm9d61M+tZWUBcOV6H+wUNxfmn7zJEkb7ASwrDQ3m67MjCuhkm7G8IYQ
	y3GlrQmD/8otlg6gZ66e5nQRIvfSpDI6UxQt3g86yY9tKFESrIr6CADmQaLXCIR2COgRDzbJeGA98
	XzhJM2ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjXU-001ifJ-EG; Fri, 09 Sep 2022 19:19:44 +0000
Received: from mail.baikalelectronics.com ([87.245.175.230])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWjXL-001iTh-0e
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 19:19:39 +0000
Received: from mail (mail.baikal.int [192.168.51.25])
	by mail.baikalelectronics.com (Postfix) with ESMTP id C5083DB9;
	Fri,  9 Sep 2022 22:23:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C5083DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=baikalelectronics.ru; s=mail; t=1662751390;
	bh=WAHooePitRG2Wrs35vuzbHd8NY3KHdanVqS7QR9FpIU=;
	h=From:To:CC:Subject:Date:From;
	b=iX1wdQ2tkUspgFc45FW4WaEGuHMyax4z91TFFPsyBuNjTD6YjXEsw0tHxAJvtqnSB
	 loxA3zfIH2xmTcU1D4Sj6Wg3eS+gwpjCDDhD2DLZdYTcrOMOyN59o6Ke9r9pSWF+0i
	 RPP0tKa4w1wrlP2q/CfZU6K5PS33NnM71gu7lKFQ=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:19:20 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Jonathan Derrick <jonathan.derrick@intel.com>, Revanth Rajashekar
	<revanth.rajashekar@intel.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Pavel Parkhomenko
	<Pavel.Parkhomenko@baikalelectronics.ru>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] block/nvme: Fix DMA-noncoherent platforms support
Date: Fri, 9 Sep 2022 22:19:14 +0300
Message-ID: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_121937_245161_83C90ED3 
X-CRM114-Status: GOOD (  13.52  )
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

Our SoC doesn't have the CPU caches coherent on DMA's. After getting the
kernel updated to the 6.0-rcX version we've discovered a problem with the
NVME hwmon probe. It turned out that the root cause of it was connected
with the cache-line-unaligned buffer passed to the DMA-engine. Due to the
cache-invalidation performed on the buffer mapping stage a part of the
structure the buffer was embedded to was lost. Here we suggest to fix the
problem just by aligning the buffer accordingly as the
Documentation/core-api/dma-api.rst document requires. (See the
corresponding patch log for more details.)

A potential root of a similar problem has been detected in the sed-opal
driver too. Even though we have not got any difficulties connected with
that part we still suggest to fix that in the same way as it is done for
the NVME hwmon driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  nvme-hwmon: Cache-line-align the NVME SMART log-buffer
  block: sed-opal: Cache-line-align the cmd/resp buffers

 block/sed-opal.c          | 5 +++--
 drivers/nvme/host/hwmon.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.37.2


