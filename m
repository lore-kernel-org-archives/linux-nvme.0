Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCCCC432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD52C20678
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="blQlQCAj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LpLfm7f+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD52C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LgVPryIAvwNyHlKi2juMaA+jAw4+carbJiwCjJnefR4=; b=blQlQCAjvz+h+6
	3Drg//PtxwRx7VwE+uVwBQ53TLX0nbkWuBHV0tuDJ0op31EsJuAek8PqqaS6f9JwKUZMMQMF3xRA7
	AC5tVIqRzIq7T2XavdIuUFslQ8p/dbIddBKU545CfrSATSj1/Cump0L0JUqZtIOTLqofB9e5nNRze
	sw7I32p02U/Cg0z7W1HlLQdlyjQTwq9ePAgKbqvaLhg25yq/fRIAHGcRq4epqtvIP/WBidS/Vb1wf
	zYJCjgjWSnlnWnlfQEu6sisxVAP6ir4YawL9ackuZtpLVeV3woaDt8ivse4LPBcC8xTSvcDkytQn6
	H9Qh06IVtVK828ZN8QmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZtp8-00057m-0M; Wed, 27 Nov 2019 09:41:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZtoT-0004Ye-JG
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 09:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574847646; x=1606383646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M5Td7n7OQK4LMnYUUJ0ereJ1F0CCcYIg/D22NPxygP0=;
 b=LpLfm7f+7Vvy9pmOnXj8EjCX7uLH3oQ4+YTRjFis7FPxCel9h2u1cDyr
 p0EF45So4LTQpXUVDaQnB0hTu9MDdft3i4MABb6gO8El0dz3auib3nNKl
 DXc+zDJRA1sp7RWyABJYc7dOcf3sspctzRuNP1sXzHhqQ9Z7ZO/VNkIa5
 hqq2f6GBos2ydSia8Ns4YZyzQ3V6PTnKqOHxbXNBtQn/0un1HVO42aMGo
 tlcclgY2TkirA9yLaFq/ynCAxnnqUA7ijasn6P8rH77eTdoO7tQrtCISv
 Afgl9UY6NdwoU6wVBy2u+Sb/SP7azo6sgCfcpAR6FYK7+xgBK2OlvYPRl Q==;
IronPort-SDR: gyEhbwvEAXYlIwduARGiNzkry3kBgFBxsoeYyuUoj9qh425Xgm0a4gER26FC+hleQrR3SDajy7
 UjrdzG1BjOlqjvh+MiL1PYYTKiadv3sQZSwDBiyX+6py8R5TA6dKwj5Z9Y8VlEWgTVm6ZQ3SDk
 /p/JUQlA1cQ4MmVcM9utMsgKZsg5LmJq475cMVjBKnddDEHA0tfjHisc/gey9eOP5kqODlkw4Q
 PTBH7U7JYJHQqXe1uAclwmfzbi1++J1YzwYy7z0sOU6wh6pd2/9Z1v+HOSNGQRkqtvoMIObBNM
 DJg=
X-IronPort-AV: E=Sophos;i="5.69,249,1571673600"; d="scan'208";a="124872975"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 17:40:46 +0800
IronPort-SDR: N5iyNTyq6sTD/CATNwwamY7n3drt3NGaFnRDGQlSpH+t2GB7ThSsbq9FRpEfER1nOCt/oL/ACY
 s5N6b0ZWHW7lC6+qrxXdJBpM9BZXJdtTz9znWld0Jxvau4OOMZTiUaap8il8kYKl8jzo5IjY5l
 V/0Edqu7tz5qaWCh2r7Fv8z0Es30EHuZsCV67ib12o7DILz+75MAnV+86wwTJFN3q9O1sXs/1v
 S1yXTJqHqp6RewzNf4qAsMoyb+PmcBgCeveFS0Az2Uw8m5shGW7AdDIjknoucGjJhQYgjSUCjY
 RSgSUZum2gJxqWNcFiqj2IRZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 01:35:44 -0800
IronPort-SDR: xS0arMtcaIotP2edQq2f1fESFM4RR1vfgPd1u/eCfcxABJ6J7k5mCIiTnR8R7+Wmetj+Ty9+Rm
 wg3a9EGZTVqk475IG0hRPzNnP1xP/j6NQxX+TpepMxyb5QRMkPs2kWLFc1hsSFOoj35mrAdBxU
 RT40bZ4SqGFdBZWUoKhyIhxl62PfoNUqRkDwOKDhyhO9U3j5qZnQGP1qAQ1hWeC6CsxdejAw66
 OdARkZQPtlwkevqRLA+CeRIv00zDLX/+JPvbi0KLaziFxa7U8u86cWPsOqL/vAy5Alh54mqx8a
 QkM=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2019 01:40:45 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/3] nvmet: check sscanf value for subsys serial attr
Date: Wed, 27 Nov 2019 01:40:34 -0800
Message-Id: <20191127094034.12334-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_014045_689718_1900FFD4 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For nvmet in configfs.c we check return values for all the sscanf()
calls. Add similar check into the nvmet_subsys_attr_serial_store().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-
1. Use temp variable to scan the new serial value and retain original
   value if sscanf() fails.
---
 drivers/nvme/target/configfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 4dea77a7da3e..0a19fd73979d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -852,10 +852,13 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 					      const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item);
+	u64 serial;
+
+	if (sscanf(page, "%llx\n", &serial) != 1)
+		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	sscanf(page, "%llx\n", &subsys->serial);
+	to_subsys(item)->serial = serial;
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
