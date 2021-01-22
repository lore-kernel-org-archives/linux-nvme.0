Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68145C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C4D230F9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C4D230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VfExGUGu7vSkzZdxjGuzL7WEBfFOwHJK4KFCo3kp3o8=; b=17K1czKJcmFCVcpFzUtvc/sbp
	cqgJWrQs+VMh/9q1XCIpIP/zjqmNhYoMDnFmGmaRvIDuEOAewVDiXJWubxHTQ0o+CMgQCk4sljZRK
	SsT9m1CYFIw8KYVC60CEMKYR/WidC0vzZ4tfgDVSJXbPhrTfV3W4LGaPIAgxcZ1d4qjtb+P3sApzm
	0L9pc9q/J7XpCD+Ey6XyVeSmt3SjXVCTNXvOdtigt50dS+19VZSz2IqmfShqZ8QYEv/P74RYEZ6XW
	fmJ4g/qM9MYe0xApIgszIUDCemiLg5umkwmemBeBl1QYNBbCX06QemLsITS4XV7I3bh2Ir4z/7Alb
	38NpVRFvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2rMq-0003T1-Db; Fri, 22 Jan 2021 08:00:28 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2rMl-0003Ps-Cz
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611302423; x=1642838423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+1ir2y+10gofxtVYdchl8MNcaiG9s+2w3chtZ7ND0zE=;
 b=Qu+vwC7G8FWOOoKwn00sU9TcEDfdYU+oiQmGwEcIUE9MWIq9Nr0ZFchC
 MtpqHnES7lh0SXYAYb79KbkTsqcD5IRVjcSqrQbdz4mIHXbC9f0CjlJKb
 rZdM+p1Bn49dmR92gKZOadWeGfda3rCF4XmovvV5sR8X6n/8xSWPTDJD/
 bGNBOceiaJM7jzeso3VMSnf9W7sm1vwdsLLO6+9pNuQ+lrCBsOgo/jBjL
 oXCV7gyRaZ1QODJN7veQFUNFxrhYsm9VFRmW6glbLEDxkVrXoxVe6GfgV
 LnKFbRa/3yfDAihUV0YScOOtpOyTv8mQxCCm+ICldJudeq6PhBqTbdG6d g==;
IronPort-SDR: gqWyGCx6GfNoXfNgttPwrM1SMW1+b7V8sTUMJ753OsYDZ/wiEOD2NHQkS0NR9dPWrh0U4mTqCi
 eOjvl71VyjuYWnPK665d5HAF2tr/8uIWErHqla+tO0b3dgPk3P2OAvjieoojDgXLSaC6qIAkBK
 0cjNPmpB12wX0JbksSVky35CnDyeY391bqv6eEeqewj+LBLfCdcJQPgTeyZODBV3ARThLR793U
 ROSf1lMH9rA+y0wZ2e+0SFE7hb3Mv1YLhxGkn+UZ0VgjJtI/nq3WF3Nk45v/uNv3HS4Ew9EttC
 S/I=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; d="scan'208";a="158062035"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 16:00:19 +0800
IronPort-SDR: Z8C6fC2svN3iGd5hSkKCccie81gOpkksWTLBS9nuE6Br9ZDzV9IbhmZnKt31jhXWG9SMvAyXjQ
 pS6bIspXbkfma5ZpIMiSPxPaUTOEn5HSy7zAcmWAB6y6ZbOFwOc8szhpj/eel5VJ9eouu2XJEp
 9kq94NR/1mcTE8zCg7dcUHPPF0jg1zTW+E1MqmUXsb2QdImzQcSr1GMaooHt+rtxyyFDjcslvD
 H8PEByiy1LEi3sJqzQ0d7Ou2UF1EIz/67U7QLKFqrkA96KfTFxhS8jGCe3iPRhaOR+LiuHr3L4
 A/lUXZc3cOLZZfkDobx+9/IU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:42:51 -0800
IronPort-SDR: WzFa3CIwNou7jEhVGULmqS9NnBhBsd0vUX+hTASBOsOuEQveAhbO+OMENewT3Cr9YHFeIhvcF7
 Usq3ypxVPp5ztjuL243L+zvAamkmU7pfL/TZqus5ue0okFGbDmPqVjdLjGAB0oSEXv4LoXTp8f
 hri725177EKnQ8DU2VSR4IQjOVqdwVVqxpbS5qDp+nVyl+e6ax3vZZ6AXulndmXZcp4MTZB77m
 LXuc+SLKurJL9W4vld+rXCF03FCgAkZAKNcYtJoJK7VPoou9JkPW79lAUQEcxiG0uNZbjLKNpI
 ZLM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 22 Jan 2021 00:00:18 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 2/3] block: document zone_append_max_bytes attribute
Date: Fri, 22 Jan 2021 17:00:13 +0900
Message-Id: <20210122080014.174391-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122080014.174391-1-damien.lemoal@wdc.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_030023_580572_54F26349 
X-CRM114-Status: GOOD (  12.31  )
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

The description of the zone_append_max_bytes sysfs queue attribute is
missing from Documentation/block/queue-sysfs.rst. Add it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/queue-sysfs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index c8bf8bc3c03a..4dc7f0d499a8 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -261,6 +261,12 @@ For block drivers that support REQ_OP_WRITE_ZEROES, the maximum number of
 bytes that can be zeroed at once. The value 0 means that REQ_OP_WRITE_ZEROES
 is not supported.
 
+zone_append_max_bytes (RO)
+--------------------------
+This is the maximum number of bytes that can be written to a sequential
+zone of a zoned block device using a zone append write operation
+(REQ_OP_ZONE_APPEND). This value is always 0 for regular block devices.
+
 zoned (RO)
 ----------
 This indicates if the device is a zoned block device and the zone model of the
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
