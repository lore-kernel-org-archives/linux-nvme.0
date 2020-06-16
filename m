Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A43C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 10:26:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2083D2074D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 10:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYFvxIar";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H1qbQ23H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2083D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4n26jsdWibeaTp3qwzyqU8lKO7ndjMxBBQalZlcO0KY=; b=eYFvxIaryDgxs3
	KCQbqjsjxw7v7wQwWX7KxjViwc84iVR6i+xxJV/XwXJDEd9lQ1iFe/VAmbgZ8cguwF4udBnjw9Kzu
	n54FpK2c43EM0n0HgZGHfas4xKRWnJ8MxkRgagyGsTBCnG/JaLlAlmHLRKrtA+tL9JyVe0YS7OMzs
	FRCEyXjS3Jzch9q7hfAMgTv8l2RzqMueB5YdsrbiTs9Y3nwV/F9dtXOrPrVU0MO0PuPA4JEbSb+0K
	6uSch1xtd1RT6KAIWkc+y6KEKW5AHcu8xXk4vEt17bnBlh8sBV7cbz88cAdfp4KCDt6siRpWyxabN
	ojeMuj5OQLEZlaB1NeKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jl8n8-0001Ff-6t; Tue, 16 Jun 2020 10:26:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jl8n5-0001FA-93
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 10:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592303162; x=1623839162;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k2wrTtH2GzrGLfrzfk/gBGspC7SuqBmLlC4focXFTlU=;
 b=H1qbQ23HNMNG7xr3JNI8kejM1M0Judc90hDGZmrRAItpOEc237ZDAra9
 bdE1YnunDdl7Pwxizbm6JJsd78fG8AMJaW8/ZhhckhtRAhbi0kLo6lwJL
 Jtg4r79VfNt24l2uzhENei6r8/kWLMtDnYKC+9h+PxUkkEWDiDcH+0hFp
 LJRbdL0lboSj+HqQ5poy9W1iXXjHiBjxBxxpsr54XUipS6Yqcg0A8O8wz
 eyvjfYAdxXuY6wu/OQdY/QH40nz6Qff3dJDqzRPH8MKZLdZDlU/Oc8DUv
 xPcdH7J3iNGsnGCJerqnyGEPU2htYYnm/u3lNOomwAS7XNAvsSCM2xdGo g==;
IronPort-SDR: vEiHtMNk7req2RYNmwHN0jBlUZaoPBGP3nFfWc0dzOs9BrOPHTNXXkTqPq3cEQ9jKDBqcC3JoE
 TVP0HCNWX0nbnwlUwA5x3JvGo8MrddcCLiJCDTTxZpXHWb/peMlrk74OUF4FI2iz3eai+Glnvi
 QL/wiHRy/x+TWgUD5QyzPjBGyAP7nW+NmFLxT7c6GMJqQAgp4a1F1SgTDxeVkJAXTgv+9eaTx1
 1/J6OoReuXNd/eE1JJD4DQEmBxJtw7CougJ6WRVb6CWvHkXv4F192pk/g9WHlCpOggL0tqQmtc
 zao=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; d="scan'208";a="140116378"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 18:25:59 +0800
IronPort-SDR: feq1LkXG6p8QQBuUl68hxrhTmlwBJhZVpviYTJJ8ZNCOLhMiQexNZP6VQimCfD3XmAEHUxd+xb
 eu4JmU1P9XITjX8cakiSyP9YMufb/XjFA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 03:14:42 -0700
IronPort-SDR: Ds8ZpyQ1PDwkBGREw3CK27qrIdNAtRYofgjQkj3QsRgzQ3Byrn7Pe1AbLOoVBnTiJLKfPrmEOs
 Y8Sji87WubWw==
WDCIronportException: Internal
Received: from 31yhj72.ad.shared (HELO localhost.hgst.com) ([10.86.58.100])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jun 2020 03:25:55 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 0/2] Export max open zones and max active zones to sysfs
Date: Tue, 16 Jun 2020 12:25:44 +0200
Message-Id: <20200616102546.491961-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_032603_408805_D00F36B7 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Export max open zones and max active zones to sysfs.

This patch series depends on the Zoned Namespace Command Set series:
https://lore.kernel.org/linux-nvme/20200615233424.13458-1-keith.busch@wdc.com/


All zoned block devices in the kernel utilize the "zoned block device
support" (CONFIG_BLK_DEV_ZONED).

The Zoned Namespace Command Set Specification defines two different
resource limits: Max Open Resources and Max Active Resources.

The ZAC and ZBC standards define a MAXIMUM NUMBER OF OPEN SEQUENTIAL WRITE
REQUIRED ZONES field.


Since the ZNS Max Open Resources field has the same purpose as the ZAC/ZBC
field, (the ZNS field is 0's based, the ZAC/ZBC field isn't), create a
common "max_open_zones" definition in the sysfs documentation, and export
both the ZNS field and the ZAC/ZBC field according to this new common
definition.

The ZNS Max Active Resources field does not have an equivalent field in
ZAC/ZBC, however, since both ZAC/ZBC and ZNS utilize the "zoned block
device support" in the kernel, create a "max_active_zones" definition in
the sysfs documentation, similar to "max_open_zones", and export it
according to this new definition. For ZAC/ZBC devices, this field will be
exported as 0, meaning "no limit".


Niklas Cassel (2):
  block: add max_open_zones to blk-sysfs
  block: add max_active_zones to blk-sysfs

 Documentation/block/queue-sysfs.rst | 14 ++++++++++
 block/blk-sysfs.c                   | 27 +++++++++++++++++++
 drivers/nvme/host/zns.c             |  2 ++
 drivers/scsi/sd_zbc.c               |  5 ++++
 include/linux/blkdev.h              | 40 +++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)

-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
