Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A5C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D474E206DF
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1jPKIHme";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+boohm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D474E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CSYgwzITO1Z223Tcb29tyPSFl49MxOEXHKBab1nOaDc=; b=1jPKIHme7NLgD1dlETrNHjWsG
	53fckLx406XmJ4hWsRRZksgH9sZW+Cm6fVvcUPRyPM7i9zCGFCNFu7P3vsKxR/bxTpeETqp1YvEu1
	1zYMy84AhGYuYMXO01eEFky/+mYjvJxIgC1GHg6iHRWA9znBdfQivRFVmnYAYP0nYADGKv7msT5a7
	FE74QwK+sqpcSipso5KWwxmQRE8q5lg/wayDDzT/5gfmyado6NSdl53Qf+V9Ad9dq2DfCgXu09ViC
	2rGkGcFBkrzFrFArjFZ49Fmgv4JFPBynoAj7/OZAuuNyKINeZ2J5fxJRer2+d8FEeqKzgnBfZrO/e
	txRwM6yiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZuE-0001Br-5H; Mon, 30 Nov 2020 03:31:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZtD-0000qM-Ee
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606707011; x=1638243011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
 b=V+boohm9ehY2FzVGhLao7GTiDnTkoHJ+WTMtSwkfVqJuI0tA9oIFeWx9
 MYpibD+AIaRsTD523yRjrHRZtTcZsxY/7qV5EJuS+luL0R01DevORHUyz
 Ngt63GW4+YRVB3uWKDWZRhsac810Bq+5ncDxbBg7Zoax6Ja1s1+yjsfJj
 CwQHuhwz/Li0HDEUkLfnhLN9avphOJojZ4f22ZsBKh7Y5Kej485UMWP6i
 DHn9TreFzR0HUZLtkOmtzV9eo83ol3N0x5fFzQcTHWe4DnGbjXzZbs1Mp
 LU1U9JyFVNCbPnDKiONwARExzxolJfzICBE3xc1QymazAvJ+PqBISoaNj Q==;
IronPort-SDR: oKKWqbje/kleDoHOUTfNAwONg65/wSq0sGg3dkKYQ1wV84i7svaE3lA2XjWfcn00+0tvkoKz97
 yh3L2jDD+2YwCopcDD6YB6pCOqzuwFfXXs/0tPi/ZXEnWyw4LE+t9u/d0EpWrTHJMjeIVQDDAz
 bQUzNcZesNnvbY24TECUvyiXHW0X/fHlYtQuClGKL1qNURTxb77/trmNfU8affboiqn2WgEGxr
 Ppcf0mSukOB+uA9QlD+Dd+EiVMXdt1eUSPuvvfmBpMPdLme1YK0sDQlXTdSN5KEbNGcH1SXtNT
 Vq4=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="153710367"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:10 +0800
IronPort-SDR: 4xHS7xT0zr4471DjDH5EnUgjsmQZZoF27eA9uu2Jv4Fpx+98P5wCtl4Tp71ZLHAqsYuawCxan2
 GTuozT0xWi6WgBw+AbNXIb9lJaTU0zZHI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:14:24 -0800
IronPort-SDR: beHalbNxexlazcYB3ByP8QAzY/houumBdrNcMA4pNHhuKyW7zGlJZqaR49S4z1XNtqkK4G/8If
 2/OJqRDFfZEA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:10 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 8/9] nvmet: add zns bdev config support
Date: Sun, 29 Nov 2020 19:29:08 -0800
Message-Id: <20201130032909.40638-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_223012_205051_34089444 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For zbd based bdev backend we need to override the ns->blksize_shift
with the physical block size instead of using the logical block size
so that SMR drives will not result in an error.

Update the nvmet_bdev_ns_enable() to reflect that.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..e1f6d59dd341 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_enable(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
