Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35114C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:19:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0683520772
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxPMBIlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IjOwobJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PyPKZq/ECReislrFRkmqwqah2EEv8BqBC5xvQj7PpJs=; b=lxPMBIlk1hPN19HszojWjsbSam
	eSnkaaUxmrOKJn0/5GT9rMpH/Jbd9dw3lbO0B5gtR6d5onlbsLEAf+91gZxVrllChu7vZuugkyDZm
	wnn0q0dYOCFwExa46QxKJh0DgwU/WCbuH+bWO8nutPQWETAem9gf1Gd02+vPqcPZ1vEdsHWn/S5QS
	cCDvEojpZSFcVVZbGzi7zf05926zJfpa0Ar+iyI/Q9Fy2PHw0VT6n6hMi5IpYz+o1PFmSSqe4GhHI
	66R5QkRFh0Nv8qC7Zk25sq5BDItSVenbppisuf9NVTFdHNVjYBTrQlkicyzSVLJWm/Ixj55TksEN9
	X8eAVGyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr3oM-0001ru-Ij; Thu, 02 Jul 2020 18:19:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr3oJ-0001qw-Cb
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 18:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593714007; x=1625250007;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kaofhYnEjFP3lo+xOFaqTZIKdftbO3b5N4EGAllPI2s=;
 b=IjOwobJfhaapEFScR/VS3AH3YpG8JvLRRrQauDpX+OJpH32vKgYZgJSX
 m+SxRPgau4cgXL+ybU/wB+myKfCZv0Q86Vf5iIAQZ3CkgKAJODDs9nbLs
 mgDk9WegzabxitDM7B2eXVRNh0LABafmdTH4s6l08vL71Vlc+Uc45JFdL
 ugDzLezPr+0WE0AgVl7nnSSq44FzrxmY3geN5IEzJQPbh7p4CKA+ceY8E
 erUfEPtduqZ7qzfYoc4BoAEZfKVYK7F/Oa+13iBugj+ln2agRnhX2o75O
 0EtlWTRU4HB5JCs+W/8HbQieja57Y+Dd8lswPDt6OmN81YQ0DB2nRnCbT g==;
IronPort-SDR: IqKpNPgokuD0rKwUUg3hiCqiEg7pTMB6+iEtSXGdFIPkzblrZmeg6KuiRhhqkogGXz7GjvBziP
 TMkAcylobrQ6LWJEX4MeJMwN1b+lb36YwAAHEn5UnrVyMR8MmS1WFrQCfnhXRLMvbYE+5m2aWu
 8e14yHq1f3To9IVEvcaT80X9Alx0pFL41AMSHu6jX5dQI6TJeF5/76GkB5URMGSBgTtOG/or8n
 aVfMcJGVg0cUc72o95OSSafRNZkbiuSBaH8m/+a8lAfhW2qPC4LMgEqZOcwGvFBn+eGPO5YL25
 13g=
X-IronPort-AV: E=Sophos;i="5.75,305,1589212800"; d="scan'208";a="244525655"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 02:20:04 +0800
IronPort-SDR: KBXcEYl8aNwj3qiU+hwFUpD2nBo2Ua/N09pB5/Fek/pn53zzquWqJOh2n/8AlC5G4j6khAYhw7
 Qta2uv0qcY8yh+Ea6LVj0yEcOtJYmZgMc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 11:08:32 -0700
IronPort-SDR: 8F+GWDrALYAMncJ4kzkXRhtyvKSoOfqJw1w2evNh1U+HuqCi7+BZszvO2GN5Q7dz84aRoGKV/e
 TyGqZMigUMFQ==
WDCIronportException: Internal
Received: from caiyi-lt.ad.shared (HELO localhost.hgst.com) ([10.86.58.119])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 11:19:40 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 0/2] Export max open zones and max active zones to sysfs
Date: Thu,  2 Jul 2020 20:19:20 +0200
Message-Id: <20200702181922.24190-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_141947_550978_42DC653A 
X-CRM114-Status: GOOD (  14.80  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Export max open zones and max active zones to sysfs.

Since this patch series depends on the Zoned Namespace Command Set series
that has been picked up in the nvme-5.9 branch in the nvme git tree,
I have based this series upon nvme-5.9.

Jens, Christoph, I don't know how you usually sync stuff,
perhaps the nvme-5.9 branch could be merged into
linux-block/for-next, once now, and once later (like usual),
to ease with integration patches like this, that changes
code belonging to the block layer, but depending on commits
in the nvme tree. I have a feeling that this series will not
be the one series depending on the ZNS patches for this coming
merge window.



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

Changes since v1:
-Picked up Javier's Reviewed-by tags.
-Reworded commit message (Damien).
-Dropped unused stubs for setting MAR/MOR when building without
 CONFIG_BLK_DEV_ZONED (Damien).

Niklas Cassel (2):
  block: add max_open_zones to blk-sysfs
  block: add max_active_zones to blk-sysfs

 Documentation/block/queue-sysfs.rst | 14 +++++++++++++
 block/blk-sysfs.c                   | 27 ++++++++++++++++++++++++
 drivers/nvme/host/zns.c             |  2 ++
 drivers/scsi/sd_zbc.c               |  5 +++++
 include/linux/blkdev.h              | 32 +++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
