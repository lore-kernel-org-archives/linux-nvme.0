Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F07CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4D6207B3
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 13:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D6207B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/56oZTZgTL0LQe+ZIx2P+aMb/f4SifRrVEq7d/I00/0=; b=rTrGTGBpUCHBHhOdVcY1TTpfz
	wY2DVh60WuwEqPoPYJbQ76VJtzqNZmsg8LgiKiKaoaafSMIi6fHtUKcbtyjJXdbmLxcarrY1jAr+k
	gldZOphF/AI/rq0DrJr2tkOO7KyLB/scPt8GYy7FKL77fzAtoe0B7tPT3UV1Us8e8mS2S2Tfp0gNU
	RitexJclHpJ/Oh+h9CBicB9HgbI6QT9dQNOXfdCthlWZggwgQqlE+gEis4KmNpOOyPdGM8tuWsjlJ
	B+gXUhMlGj9geNDh5dHOjZKMuN7a5ws7aEJEv1WwzvxIyGvxqhzPOgr4a94R6QgNGrSy19Q3zd27o
	+HKLY/O4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1qtD-0005li-Q0; Tue, 19 Jan 2021 13:17:43 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1qt4-0005ip-2a
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 13:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611062254; x=1642598254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gf41tJSgK06B/Ga4VjMMXYqoISVLe/c4wgOY899USOM=;
 b=KAUqP2THceA2kMAvVDCI4E4yUklSGBzSo+NP3novu+tWQspJdqq8etPO
 8mi5h5/etTlMW0DNW1UVyUUQTjBusqkJLdej/+8ibxa/baHgwMk8Dm0nl
 Urf/T1AMuUQeTYkSPq8TjCrQhmdsULWqbLZuIuRIPWgA+LUU39tpuWU6x
 qyd/zCf5QBdcZh/4kAPPL5eUi3Z28KFUiopo2wSI1Ax6qzI0VJdn6Ae30
 M6fMLR+VsNjsX0Hb0f/UbvW199esX6nhZFq80RYLP5VPsofAtCik9VdY6
 NITBRdhIqy/Oabo6/o26B9ObcUkjPth4au+0ZhnEimh9/xJ+hH2V89LEP A==;
IronPort-SDR: qehYL/ZpRrUTV+d3Y2zysFWDTqILRBtWZu6DrscakUX1p3S9j3sLcOTrcxlLhW0V+l870aIFmC
 M3bJ8pSEIfGXMScOu1CS2baJ0TaC9nUnUqZ5+sHPZ103VCgZEc8+4t86mgLfju1fAQjB0jsQbC
 mJNjDRs/5+1rVB1wGNXMYmO5IcOxB1RbNGajltWfS+GkKkGd+ytT0qvROJcu2WtpMmK5pbI9+s
 Vyp4/ogz8UXcrYr/ed9mSMO2XGxLIt+zOPTikK+vqtjJjmKKHVJAcnxHafXxAf4W0+hv6piHuw
 oGY=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; d="scan'208";a="268116825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 21:17:28 +0800
IronPort-SDR: 2QoZSq9WAN3JcazM9XJ6IjeCj3zKlZd0j1LOasZTY6MRG7lGSkLrOHl02A4GzNIdhXzm4Gbopp
 k6aBvVXP/7ALh2OA0ULfaeKk/Ns5jfFYJtMvSxg3HYmkYNy+E4q75H61u3KcHu98W/tnE7ZFxX
 S5N/7oTVtIYHqJp+K7MUn0xJg0CPJX8dqFLxVq6XhvCgvT1x8K7FoARlcJk00trHvktx0dzQb0
 vkciI/Dk8LFVCOkN6hyNrTIGe65/+X25vmG29BeLxo8n9gAUjIIENX41mYD1W7KE3xN504Ypn8
 LTPsv1XYWwI1sS8DC1KYMq3g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 05:02:05 -0800
IronPort-SDR: bJewGvUGD2sd8RHBZafXHMg0+wubmtkfNYOfD6a8NwTV//wLa0dZzK5OVZJWLVgBZh8rC79oxL
 fQ2sAKgqjO/QrBrBp04+pudSEiVEAaZLu406kcpbTwcvmcIT+psRAv8h2VHNb5I9J3P3rPRpqD
 et/gv50/Xx9x7NTQEPo5ZKAWPmDGqAP55v+sFRdo6skgAaT3o70mEVJCWS1QIKWj1CFe/ZVNJd
 ccayjxo/ErKBQYgIebKl5wXt5IaYTkq8FsceHiYYT3QQqZCZ10D57Po2bWVsHsIecRrmlNhCY8
 15w=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jan 2021 05:17:28 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/2] block: document zone_append_max_bytes attribute
Date: Tue, 19 Jan 2021 22:17:23 +0900
Message-Id: <20210119131723.1637853-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119131723.1637853-1-damien.lemoal@wdc.com>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_081734_264438_3C1B2927 
X-CRM114-Status: GOOD (  12.12  )
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
