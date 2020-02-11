Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CAC35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:11:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6579F20708
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L6EHntKq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NgWBEi7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6579F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Padj8iWA99nlj/FCb8HyCi4hDB+MotsuwGfSDnxGecI=; b=L6E
	HntKqDUCHbYzU4vHjbrCMUZkgmon74wBAXOF7+lsMwANT5nziq86Tv33ec6YlRsFaBpxmL4sUIvGt
	Vdxf/RnSGBHyOi7+66Mz7piUavDINHdOmuh9lCoZ7VEcPzRfVmnk0Nfox99jsK3JmWO8DEzHCF2bz
	fDniQgiYT0fcqAaU0hPBk8qIzuua7cQSKu6CAGsiCOm7UdzaG6elI+qxY+9OYrQQDmkp34JsXd3wO
	xHn2PLQUcXF9oRWJh9pkeOq+CWtqfTp7BSbZipLYtBMwyDoOyqJlNEbZg1dyIFMwW3jjHoYyQ7DV2
	fgKEu1CmkjBZNM8ebihc3yWieDhJwIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dkF-0003NH-7n; Tue, 11 Feb 2020 22:11:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dkC-0003Ml-6H
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581459060; x=1612995060;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nMy3ZNpQFfoomJ6mihsNBtvFRRFrVaW5/x2ZxsTLVfE=;
 b=NgWBEi7A5Due/A4toq9tbZY6SDGvdhcsZoL3QCep2NmLohwEmSdI36V8
 i646ZZv5jK9RsQMXUIC2dKUVXZFuuV6D9D9AmUP6YsJ6lIrQLMadEWrXa
 f3+gLqkIWq5Z6SaSa3e/V/K2NTsCsNjig8S69lH3VF5/CJ4nkLV011KbS
 6z344Y4Y/zzKeTFZFFi5nv6LC7/zOl6y2p7XFC6Tfee45ygwgMN6TRSmF
 IJymubztQy1OqN9svpEhAH0A9rJgEdCSNOi0k77dG9tkMFELG06Niqah8
 FKabajzNOu4ehdELlpzhBkBzmVHR4FCmgaguB9/3nEzwgzy62Mk8Hc740 g==;
IronPort-SDR: aLXfyaRFzgyGpq/vk4UN8BvE1a8nWynPbhIkgw8W4W/193NPzhsseph3RdYuG0AP4ftyS+VyI4
 X1HNBrKS+mc4ulw4tysWvMOktzpBWRaaNoe5ylPh8xk4nRnCRmNIy0TS+p74P1oKTpbuomyNoX
 eK4c6ddG/TeTRJ1MjX6r0EXv93dXIRRJl98NEeJe1KW/a1w/wp9s6kqmhUAnG3Fgdy1tJw8GVh
 7uF295XDC6xh7zeE/8eCbaUNb7P6tmeOKSDPPeUkgaXj6ajZC1G2vbNibqg8xUR2uQGpYbWqd8
 Apo=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="130154733"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 06:10:56 +0800
IronPort-SDR: YariWzj24Ge2VcK7iNFxiIM71v287czkIQS9aGG4wIWJvjkCQJ0hHC31oLBpcdvKoNe75fXeGz
 gYOBKpZlwgNpFv9oxWuy1yMjTz72Hgz4AA61sB9lVUJg+3fEB6dYpbhdRPD7DHRP1AdNZmTEbQ
 fM8Jzw9sGKUm7dILqV9V4d5qOFre9ziO6Qxk5e8jhOHz4kKNDgwS/I2qOSMsuWYG2LgUkdYix7
 3nVwCRuUse8oyDwTLhbkfnVzYP3b2AVRkBlUbfXjP+DPYJafyYFj0YZSncVr48mD4GXefaAeFu
 gQLEOydhTGWnEKWVCL07QG+P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 14:03:45 -0800
IronPort-SDR: wzQn5L6QGLEHZZfRx3g6U79/ZMSpNl+nsmy4eZul0/fVY1/NJuS/KXv0Yif5ELYvVl+rwFSxim
 HMBb+z6FGOXTLfvhR5/XvBe0o20ZoWK2ZGlWog2UKBW0GP0Niig55kQcMcVZdsz8nZhbQ9p/55
 Ps68Bye6czRzJz0WHExnjCf+AWSLInkSDVIl6r+kUlKIHTmh5VeM5fp4LQ5aQS+v1881+OJsnB
 FmuXhuheWP5JDmgFcNFakXd/05HyB/YSzIFsNPD9ehiIXb9AhOZ4zmtFMREWXO9bJH1WSLl38Y
 878=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 14:10:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org
Subject: [COMPILE TESTED PATCH] nvme: code cleanup nvme_identify_ns_desc()
Date: Tue, 11 Feb 2020 14:10:54 -0800
Message-Id: <20200211221054.9013-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_141100_304006_CBF49D3D 
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============9222562690127436976=="
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============9222562690127436976==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

The function nvme_identify_ns_desc() has 3 levels of nesting which make
error message to exceeded > 80 char per line which is not aligned with
the kernel code standards and rest of the NVMe subsystem code.
 
Add a helper function to move to the processing of the log when the 
command is successful by reducing the nesting and keeping the 
code < 80 char per line.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

This is compile tested patch only, if everyone is okay I'll send
a well tested patch.

Regards,
Chaitanya
---
 drivers/nvme/host/core.c | 84 +++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6ec03507da68..4dbb1622a65a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1053,6 +1053,50 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
+				void *data, int pos)
+{
+	const char *warn_str = "ctrl returned bogus length:";
+	struct nvme_ns_id_desc *cur = data + pos;
+	int len;
+
+	switch (cur->nidt) {
+	case NVME_NIDT_EUI64:
+		if (cur->nidl != NVME_NIDT_EUI64_LEN) {
+			dev_warn(ctrl->device, "%s %d for NVME_NIDT_EUI64\n",
+				 warn_str, cur->nidl);
+			return -1;
+		}
+		len = NVME_NIDT_EUI64_LEN;
+		memcpy(ids->eui64, data + pos + sizeof(*cur), len);
+		break;
+	case NVME_NIDT_NGUID:
+		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
+			dev_warn(ctrl->device, "%s %d for NVME_NIDT_NGUID\n",
+				 warn_str, cur->nidl);
+			return -1;
+		}
+		len = NVME_NIDT_NGUID_LEN;
+		memcpy(ids->nguid, data + pos + sizeof(*cur), len);
+		break;
+	case NVME_NIDT_UUID:
+		if (cur->nidl != NVME_NIDT_UUID_LEN) {
+			dev_warn(ctrl->device, "%s %d for NVME_NIDT_UUID\n",
+				 warn_str, cur->nidl);
+			return -1;
+		}
+		len = NVME_NIDT_UUID_LEN;
+		uuid_copy(&ids->uuid, data + pos + sizeof(*cur));
+		break;
+	default:
+		/* Skip unknown types */
+		len = cur->nidl;
+		break;
+	}
+
+	return len;
+}
+
 static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -1081,42 +1125,10 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		if (cur->nidl == 0)
 			break;
 
-		switch (cur->nidt) {
-		case NVME_NIDT_EUI64:
-			if (cur->nidl != NVME_NIDT_EUI64_LEN) {
-				dev_warn(ctrl->device,
-					 "ctrl returned bogus length: %d for NVME_NIDT_EUI64\n",
-					 cur->nidl);
-				goto free_data;
-			}
-			len = NVME_NIDT_EUI64_LEN;
-			memcpy(ids->eui64, data + pos + sizeof(*cur), len);
-			break;
-		case NVME_NIDT_NGUID:
-			if (cur->nidl != NVME_NIDT_NGUID_LEN) {
-				dev_warn(ctrl->device,
-					 "ctrl returned bogus length: %d for NVME_NIDT_NGUID\n",
-					 cur->nidl);
-				goto free_data;
-			}
-			len = NVME_NIDT_NGUID_LEN;
-			memcpy(ids->nguid, data + pos + sizeof(*cur), len);
-			break;
-		case NVME_NIDT_UUID:
-			if (cur->nidl != NVME_NIDT_UUID_LEN) {
-				dev_warn(ctrl->device,
-					 "ctrl returned bogus length: %d for NVME_NIDT_UUID\n",
-					 cur->nidl);
-				goto free_data;
-			}
-			len = NVME_NIDT_UUID_LEN;
-			uuid_copy(&ids->uuid, data + pos + sizeof(*cur));
-			break;
-		default:
-			/* Skip unknown types */
-			len = cur->nidl;
-			break;
-		}
+		len = nvme_process_ns_desc(ctrl, ids, data, pos);
+
+		if (len < 0)
+			goto free_data;
 
 		len += sizeof(*cur);
 	}
-- 
2.22.1



--===============9222562690127436976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============9222562690127436976==--
