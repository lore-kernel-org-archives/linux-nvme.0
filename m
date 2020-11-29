Return-Path: <SRS0=SC3Y=FD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2AC64E8A
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 18:19:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BDC20731
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vl8cuXn0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhMuTeEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BDC20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P6mUc+xOhUqJ9sbfUcj2PE1ke2QkinaKnc3obVL0hfo=; b=Vl8cuXn03guvslNBt8EnMZwuP
	ddc8GRfmVS6o9s+RI3wUeOff4pMYLcEMTqPo617qEDEU7CuBw4XOxGk6JuyZ0Io/Q95SVogW8hJWi
	qZE9CY1nKKejbGX/pscmWldPm6EzMBI9YY/y6qbg5QKlF1GM31aewTMqwJloxU6KK/PM3MQ7w18l8
	ZyA9YM4fvrYCTBUwlM+zkuyr9K4oF083cPFYdkSe+mB+25lJcfNrJLhsmhQ6rac98EzsVUVGYeKFj
	7dmHnpDZRP/HkPRNV1ih9vd6lFB1zTAZtfrXJ7/342SIUfTMn86/8WNfSKVR5aa+blHBZ8p1SRQVT
	HX/4i9f1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjRId-0007T3-01; Sun, 29 Nov 2020 18:19:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjRIW-0007Rw-RJ
 for linux-nvme@merlin.infradead.org; Sun, 29 Nov 2020 18:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=EefFTETwdjTT2tc3Kw8m+h2v6iqXbIBFBB9JSH+56hw=; b=VhMuTeEiiHBfSw5NdViDL8pIQr
 9XMfTGxzE7EnRGvgfYGgWYUd3SCyDJV5ANGHvXRV04PgLjsXbYj2iHd02HVI2HqIyBAT9JLTe1t9f
 +2oJdvttHYxKfaFQIukm/IdW2FZ6u3m5hI2JQ5TvrF0e3Tj1LR0G0AOJNg22ZbDbs+EfOpbRjYdX+
 FgSpC9vHtZZJw43RiPa/scGhW29vvo4bbDsh7oKnDYX9DojEX7la2eQe637f45Iwlq3ThoXPusS5u
 XdgP16IwMB4q170Qtgwc90cLhYb9ixdGM4UUEaeckoOBvGRBAvWCqPaV1T1XgMyXVVknzbf30aGTs
 NIy2OjVg==;
Received: from [2001:4bb8:18c:1dd6:f89e:6884:c966:3d6c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjRIU-00078D-8U; Sun, 29 Nov 2020 18:19:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] nvme: allow revalidate to set a namespace read-only
Date: Sun, 29 Nov 2020 19:19:25 +0100
Message-Id: <20201129181926.897775-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129181926.897775-1-hch@lst.de>
References: <20201129181926.897775-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Unconditionally call set_disk_ro now that it only updates the hardware
state.  This allows to properly set up the Linux devices read-only when
the controller turns a previously writable namespace read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc89e8659c403f..2442f43a1a5624 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2047,8 +2047,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if (id->nsattr & NVME_NS_ATTR_RO)
-		set_disk_ro(disk, true);
+	set_disk_ro(disk, id->nsattr & NVME_NS_ATTR_RO);
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
