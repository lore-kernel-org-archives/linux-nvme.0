Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D3C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 21:18:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A5120658
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="feAzug5P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AU+N1F/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A5120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cj+0p10r6zO6/wQAZf8f+kEkzvxFEAbE0eg8cNRCJso=; b=feAzug5PMlOpaFH020S+wyHF7u
	8ocp9fGJY0yzLFRAADtzluA/224+BVXawlouoXXoKPQXxaG8ZYDNfzd1VMlOB+ow0UxqNlkkUiWIR
	GZL7SeLBYR/AdkFLWuZpo7cDHdWdz32bj4ZrGZOiKw2NDfGaLeg2ePwF+IsCLVQjw0tF9q42LKqlo
	F3sR5Y3AAdqZjyZp5eeUCmppM6KwcfNdWGvzLP9ukZ4hhWsz8pif8OkHkiAeCSpA6/wPkD0655QR2
	rRoraAJ2qZyCR/rkpsZsv4L+BDhIKn2vAyR5Ngmw7Yon8hm0BTBqqU6XlFS5mjowYWyJM7r/vd4K1
	HFN38Brw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvSK2-0005qf-Ia; Tue, 14 Jul 2020 21:18:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvSJz-0005pG-F9
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 21:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594761553; x=1626297553;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Eii7FmfTiwjXtaWeM5VI3cqCVXCyz8WbJm0iTlMDWJs=;
 b=AU+N1F/Q18PIk/bRl2EVYj7NnaynYf/iqA600G+GFvNNNiikoS9u6nmX
 6llnBMQK2thWgiin1RHZMOBpgs3ye8bMpquhWYR1S56L/BCfhrtNlASDP
 4OBmddYmEvwbShzgjSuCC1kG6FxQiVYZR8Bf1wbO4/KR+meukRc95lcJy
 lDs88WEuSg46k53Ea/BZfanNIEvkJ+8/6UOHmoVEl0QV7oudj2AAplcdh
 oGFAsqAp/SzKN36u9wNKYknZlXZlVhUDXt/q+UnCSdW7SMRb0cs+3Fdq/
 XNp1K3lbFCF53IXtlwzFBategFeBm6d/1QEtOF8iV8jGwqleFCklNeCwR g==;
IronPort-SDR: pUfwcbTSNKaduP76ieawKagU+QIx3g5qun3zpy8LZupwKk6n1nzTv5ISbtspJiWeinQmf4KoDP
 FYWXuqijn05z0UEp1JPXTBhqoaRiqc4z9QbWs5tWT/HP5vfbDRNJewOSABSaamF0ohnSB41jQj
 6yZppazCiXELvCMrGqAUXNejUGYxELYkYbxt9GaiB1M7rlx7iKIzk7UjFDJQAOJ0Qva7ww5ESH
 f4GuYUfvIpnF/wkfKKvbH9fBpeKhxLrzZEnF6TpAD+gNkEPs0NX3O/dXUdoxQngLCFJlUI3vpm
 iqQ=
X-IronPort-AV: E=Sophos;i="5.75,352,1589212800"; d="scan'208";a="245491609"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 05:19:08 +0800
IronPort-SDR: wdiob1gx/7d1g6qrr1Etg9sP2YcYzECgKkD1g0Afu3Zr2oSvk4OyO5FPJHD5uQuWr6K3h1cWZ4
 N50zX+Y1l3ULd0JRtgwtKWu3GpwnXs3pQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 14:06:29 -0700
IronPort-SDR: k7z3BG/rBj8iFCvPyvk0k3PKbnvggxnH2BwR5yWdE3n5oHKB7mt35lSX0qKzIUfr8NJIC1e2Oq
 dUHvmegCmbjw==
WDCIronportException: Internal
Received: from usa003306.ad.shared (HELO localhost.hgst.com) ([10.86.57.226])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Jul 2020 14:18:33 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 0/2] Export max open zones and max active zones to sysfs
Date: Tue, 14 Jul 2020 23:18:22 +0200
Message-Id: <20200714211824.759224-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_171839_679248_A2B5C69E 
X-CRM114-Status: GOOD (  11.21  )
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

This patch series in based on Jens's linux-block/for-next branch.

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

Changes since v2:
-Picked up Damien's Reviewed-by tags.
-Update Documentation/ABI/testing/sysfs-block in addition to
 Documentation/block/queue-sysfs.rst (Greg).
-Added bdev_max_open_zones()/bdev_max_active_zones() helpers
 (Johannes).

Niklas Cassel (2):
  block: add max_open_zones to blk-sysfs
  block: add max_active_zones to blk-sysfs

 Documentation/ABI/testing/sysfs-block | 18 ++++++++++
 Documentation/block/queue-sysfs.rst   | 14 ++++++++
 block/blk-sysfs.c                     | 27 +++++++++++++++
 drivers/nvme/host/zns.c               |  2 ++
 drivers/scsi/sd_zbc.c                 |  5 +++
 include/linux/blkdev.h                | 50 +++++++++++++++++++++++++++
 6 files changed, 116 insertions(+)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
