Return-Path: <SRS0=+Z1J=7Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 01:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5103206D7
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 01:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwYl7xt1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l8n8Jvh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5103206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=clTgt5PGs6C9MMsxsteux70NrQ9pPFAxw+2bkNldpUU=; b=TwYl7xt1CQeh2n
	G9jNg4BfchltTRKZet1ZBK9y4L25FwBbpzb875M5EmL4/W/1LFnq/fOH0ik+XZBSpyTN+1JkHjIlO
	AEIQ4Z1KWLnJhT5nJugNY8WDPiDI1k361Fctdvd1ohQbNIi91CqHbdGQ8iYmMea2G2+MlZE+yaNUH
	YZ3XwiUQGv9QYIh7rTtWRrguRTxtcWms/iickqWxYhfj38AXc/JujBetniTg21KaO6pGksXbs99Jp
	qgxoexPf/SWbEPUKHYHwXnpslquz/fzF+lsafRCPHOwqaGdwqSxhQ1V/wZCZpIYH+L8KHlVg4AKPL
	WSYriZjozgSL5L5QSWKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjYJt-000322-Cd; Fri, 12 Jun 2020 01:17:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjYJq-00031d-Sv
 for linux-nvme@lists.infradead.org; Fri, 12 Jun 2020 01:17:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591924638; x=1623460638;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n2fhHT1kuwyTgMERc9GPUgH+A68lC8mnNdKRjsPC9fk=;
 b=l8n8Jvh0sSr1MHNbQQgcbaaTVqwJQRmzMbI1Zo331Mrdz3wCqvSj4hi+
 STK3YEs7TMEWU7wAT0bfaTa5lZobkW0YddIAd4b28kHM6EzP6bTc7RrZL
 G8xEdb2R56n8CVUH8MGrM8Qolb8GBZz1zJJ/1ELaO5H+ndZb18T9vJSAd
 /EqUaQ0rcMsB9WrS+jKhmIylTd2y8RGU2sgDTF84e6BnrrqU8zu9AX6Rg
 frQTNNwq9fhoGMZ2v0lYQ67tmgef25+mAXsBmIAGruYlft6PX48a7Xwo7
 dcMrb8HZAayFeLSuuodPKeRj1iiPO+wpV4UuuMuiPDA37ieVFgFz+L37e A==;
IronPort-SDR: IIlZKY76DIPAACRihWrzKU8j8hRPtCJGiF0btdO3p3PzbilrXwJ3Gag4ujtkBJ3gT9eIqm8ozS
 iWqUOqpH73FcX+ptnlnyVNJelvRarzCXzM3XtiZ7JpM3kYCgFKpGzzGGKbRO43XVOH/KqqE91R
 0m/ik8QkUanl6xY+4y/QJ0MDL8kiqpMKz9EqsiZbgKFYl79D9VWk022kfYrudOaZdrXRYSuk9i
 WUY1ZkNsL9a3whehVkNW9vkoE25Zb+jV4sQ0DU0H+uwjBWT+y80oJPsbi49KAlhSPWHE3taNXX
 TB4=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; d="scan'208";a="139782063"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 09:17:15 +0800
IronPort-SDR: me+6MfCMr3nRK44xO+cHWXYJuxnHVNBZgL2O+wW+Zh6VHbys9dLcy7KZxW++e1sEMLqUK542ic
 l6vYKD43olLJZ+Fj2HPWOKyP9YbK10DA0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 18:06:39 -0700
IronPort-SDR: lLy91OzLg71P60Nz4kRhjrPie5ZdWr8GfmquIXBWJ725ULBXe+NUohVcGGEjm/rzqTM6Sye8Hz
 kq0kYnyBbvpA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 11 Jun 2020 18:17:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: use unsigned type for u64
Date: Thu, 11 Jun 2020 18:16:59 -0700
Message-Id: <20200612011659.11247-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_181719_020057_703C1F2F 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In function nvmet_subsys_atte_version_show() which uses the NVME_XXX()
macros related to version (of type u64) get rid of the int type cast
when printing subsys version and use appropriate format specifier for
u64.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 419e0d4ce79b..cdec47de89ed 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,14 +862,14 @@ static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
 	struct nvmet_subsys *subsys = to_subsys(item);
 
 	if (NVME_TERTIARY(subsys->ver))
-		return snprintf(page, PAGE_SIZE, "%d.%d.%d\n",
-				(int)NVME_MAJOR(subsys->ver),
-				(int)NVME_MINOR(subsys->ver),
-				(int)NVME_TERTIARY(subsys->ver));
-
-	return snprintf(page, PAGE_SIZE, "%d.%d\n",
-			(int)NVME_MAJOR(subsys->ver),
-			(int)NVME_MINOR(subsys->ver));
+		return snprintf(page, PAGE_SIZE, "%llu.%llu.%llu\n",
+				NVME_MAJOR(subsys->ver),
+				NVME_MINOR(subsys->ver),
+				NVME_TERTIARY(subsys->ver));
+
+	return snprintf(page, PAGE_SIZE, "%llu.%llu\n",
+			NVME_MAJOR(subsys->ver),
+			NVME_MINOR(subsys->ver));
 }
 
 static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
-- 
2.27.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
