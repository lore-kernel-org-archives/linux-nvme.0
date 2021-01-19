Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A6C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BEA207B3
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BEA207B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hK9eyCvyWkWB/1UBTwAWMvG9gEkfcmszJf0nmcdZGMk=; b=yOIGhytMXi4zIbiOzHt8VjaBVq
	qDqEAiSuUZ48yUJFJQXkIzEFh6iKVwnml7tQkAW9huRg/IqaZpOO5IC3OspiSWOMlsssWdu7ZefAo
	3NMCcNnr3sWSeM00a3XJqP/RdFDk4hwkbwODnNlLXh/iLGAB3MWM+v6y57OZVhgbsFrQqw4ZYuR4N
	M8P4cQeNHaL0bXQ2KRsfGPCpx7HwnQTgQ3b5nSpLcCH/wXCCm0rjbIZ4n8CqETEqLKFFynEUlrkTK
	fJJzD2Xtnq2+ZDW+kqpoAPbHhtrAQL02Yl+AUqXg6QWjPSHU3Ya6aqTBP+/qpEvFbNQsJjWlP8886
	CQM2Es7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1qt6-0005k3-8N; Tue, 19 Jan 2021 13:17:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1qt2-0005iE-51
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 13:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611062252; x=1642598252;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Gi5ViTFKpBsj3fxRrg2EwEQkEQSXyFAtVoTUeweHPR4=;
 b=rUgI4Rz6fg6pFqGU55GYI2c9YsfVfG8cow1C/pggW9mtvCHxKm6jSmmL
 5X29fXKQ4lVwkvORibxJQumZQ87+/PQ2PBdki+gTdy2PpekrhZxqt/0OO
 6gdECWzv2S7gl6aabdvnLI2VZBCSUhc9mA+L4IF29yZLV/M6bKPKcXmqp
 W24ncA566zbn6bK4ToEboBUNmwmFP2CbUtKTShmQZhfA36F25a8HsGyNd
 Z8jiKg3FO9Ayw7uLkxOv9LgXeISEkAaQ4OKUe6T+GBQz6YYqq5+mbwLvv
 SxYILmcMNdDSE/fe0DuhhUPA9eEQJ9VD/SJUdF+GCgtvNjMpzbrSI6bIr Q==;
IronPort-SDR: VgPWgo0abDAM1FUV3ynFokpa/LCv7jhAsQGoZedY3Ft0YBNxteAoDzc5bLSEdWB0AXvRl2vxB0
 0ePZRdIVhdtvjejvkOn8U9PIRDIsgaZrUI9mPbdIb1mPjaIKEZ57b2i33ab1xJU3Tz6y/wwX7u
 OFs7gE1W9aSmPRz0wKQcMvbxzamWe4LhydS5DtLHJN/FM3JYdmHTIoDkF7L+J895qgGhpffBo6
 EpsClO79TswOgctvgIrcun5JU+DABrYtp5RpkGkvm59IpYMTB9NV5nLggF7pSf0E2QyWy2IkwA
 Ozs=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; d="scan'208";a="268116821"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 21:17:26 +0800
IronPort-SDR: f7SGOyq6PufDaBhLoTsjIJN2WOZNwdf6SaaPggz0MHSKFciGQnwuK/qxxXNfRqPEOl38jSKg/n
 nGp/DPVeUvkVj32M311hgPnWSSIzzYfwoByRU3qMRtdzKjehfkZbTuj1Z0Y/pJUjjabphbEfDH
 1PeauKJEn48HyV+wRqxpKTNBHfla7rE5E3Z+7WLK7dQ/UIBQhqlYQIpYT7s4IDjOLa/OZdaQpQ
 AkczsqmkUb7oLGD3agpRBGApdQcGJ+jMJbIqEDVXY89l1kjfRfTPUkV/7U023I6z2xbwVpW9zp
 PaH6ALGQuLfjAqXI+EJwXl42
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 05:02:02 -0800
IronPort-SDR: iCSGPLzWpqlW+qM6lkwgwZ1SveYNRIo/+8VeOgcrOnefP9BD5qlLJ1VC/OkvF5hd7XOyUBdwn4
 MN7vN8UZzQIhOknav8jiRTwUMl+NeliOhvQCj5gObUoxlIxv8aZbemGjYsWbEBL9WeZp2PEefi
 q6WjrU3EUAde0jkKUM0mjfIrNXCmNsLHNpdGBBLrZa3f6fvpAObIy//7yh2KYKNVe9+H6QcTrP
 30ThSv4Bc8vNWJ66+vUrmMzg0ahXvYeV21Ac208Hjd41WXH7yoWWJ/pijnmE7SndQ+sUuKD+/a
 vDc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jan 2021 05:17:25 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/2] block: add zone write granularity limit
Date: Tue, 19 Jan 2021 22:17:21 +0900
Message-Id: <20210119131723.1637853-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_081732_443636_99E94D6E 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: linux-scsi@vger.kernel.org, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

(resending as I forgot to add nvme and scsi lists and their
maintainers. My apologies for the noise)

The first patch in this series introduces the zone write granularity
queue limit to indicate the alignment constraint for write operations
into sequential zones of zoned block devices.

The second patch fixes adds the missing documentation for
zone_append_max_bytes to the sysfs block documentation.

Changes form v1:
* Fixed typo in patch 2

Damien Le Moal (2):
  block: introduce zone_write_granularity limit
  block: document zone_append_max_bytes attribute

 Documentation/block/queue-sysfs.rst | 13 +++++++++++++
 block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                   |  7 +++++++
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++++
 include/linux/blkdev.h              |  3 +++
 6 files changed, 62 insertions(+)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
