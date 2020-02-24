Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB3C38BE1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4945D20836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oe+lEw3J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPO29O9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4945D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yv2O38dVBxCIUzgiJkqw5C+OG7PgS2Er2+a0/ui55jY=; b=oe+lEw3JG458G1lyCNRVgHvxHi
	TTPAsxQA9BV3S683wJgBP4DAI+2teveN8GhaifR60qn1U40adnP1m85aguV6s1fFaAqnka7eOZ8Nv
	e7T3cmnTSSadxMIKX4PyzCD8w8wt1KuPCRdD/2vuXem6ufU62XzkrEadvZQzmXrFPKv7Sxo2LgdbC
	o3hdrfqXsvq+CHqEfmwqLTBby4bXobg3O6l6BR1pRaDDWcRu/HRmkTubKucGd/4ME08AeOkXGXXYa
	y5XbekYcku+OBuqNmYFaCjNJeeG4ARu7K82R+Ktr65NdVE2nGlr8b2wNu49lZThvLOAm38BAjeuQV
	sNqLWRrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Io5-0000ti-P4; Mon, 24 Feb 2020 18:50:17 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6InB-0007OC-Kd
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:23 +0000
Received: by mail-wm1-x343.google.com with SMTP id m3so231002wmi.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6TrfCYYZDKaODT+pkOYSUQuCCJnmDQvaRdrGoIOIpfQ=;
 b=FPO29O9FT4ehoXFxejU9p5DhERC+38qpYTsjxkj8UD1V4AYZcnDAq7fB2am84IZPLO
 Ux3kB3xhkNC70xDlDcoAO7/n1HDXoV0btM+6yFvCic8CY4fkzFpoZ+qUgpDaj/AKqMLm
 +O2HXVl/uSnxbA7w8rGx4QK/lmWyjobeTp/IcfyTD2y8DkfJRXxmYd6BEq9Fe07oykdM
 k6s1P8djR0vdJ9t3ddDdzcosfqqpbkuMM7/rpBzK6l9+FXzBUnbbrM2UUB7lQt4TL9R8
 +coNqBPPaKD/ecwUEKmPeBIertx+K9d4oneYbuhRH1IskUyjVF63NHOmj/CS/oUdnFO5
 DBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6TrfCYYZDKaODT+pkOYSUQuCCJnmDQvaRdrGoIOIpfQ=;
 b=UEgVnwJWKO2p+rrsJ70uO5egN88jRKjbY2Tbli7zOZyzz4kkt7kJVYig1bdOm3gd4O
 LuRgvyjPFxmknbUxlrxuwj86DwjK/IzZVvcUQrn1gF1UIdrZDDIYqDouxA8l28WyHMXC
 kGP8sH0nsNgVnGPVxHjzJxYe0udVjlIsBoPOHjIp9IN+875jRjGav9qTY7W/MTNMyxD4
 nOhTQRi9OtsQSu5H9IDwyI1XpjwrMNlYa5Gyr9LXNXN1rQYT+y7XE+89CxzGsqPXVAU9
 3ybA4tuI3AaZWCIp9ze/mWkUytaIlQgJDkEuJBl7j4fGLtcDf6chXwWZEhAkSu46belJ
 F1pg==
X-Gm-Message-State: APjAAAWtRP975lnq4fm6Nm57qmx/cfW0Jya56TqD0RG+uaXyJT2I2JAt
 tlW/R+oDjWYHdG+FYOlhdp2jR9lG
X-Google-Smtp-Source: APXvYqzJazEk91im/vF3Zy83i9r9iLxrGZ6eiWaEAvBYBWHgF4pZiPP7qP9YOKeHU7qt5pwGIuaq9w==
X-Received: by 2002:a1c:113:: with SMTP id 19mr393132wmb.95.1582570157899;
 Mon, 24 Feb 2020 10:49:17 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:17 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 6/6] nvme: Introduce NVME_INLINE_PROT_SG_CNT
Date: Mon, 24 Feb 2020 10:48:59 -0800
Message-Id: <20200224184859.20995-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104921_736264_388E962F 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: Israel Rukshin <israelr@mellanox.com>, James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

SGL size of metadata is usually small. Thus, 1 inline sg should
cover most cases. The macro will be used for pre-allocate a single SGL
entry for metadata information. The preallocation of small inline SGLs
depends on SG_CHAIN capability so if the ARCH doesn't support SG_CHAIN,
use the runtime allocation for the SGL. This patch is in preparation for
adding metadata (T10-PI) over fabric support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
Differences from Israel's original patch:
  Renamed NVME_INLINE_PROT_SG_CNT to NVME_INLINE_META_SG_CNT
---
 drivers/nvme/host/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bedee3fa9d41..d5fc3b9d9b77 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -31,8 +31,10 @@ extern unsigned int admin_timeout;
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
+#define  NVME_INLINE_META_SG_CNT  0
 #else
 #define  NVME_INLINE_SG_CNT  2
+#define  NVME_INLINE_META_SG_CNT  1
 #endif
 
 extern struct workqueue_struct *nvme_wq;
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
