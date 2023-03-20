Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE2C7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYHfRgyFGmfXf7uT3/vn0EeWZOwjnHEPhqCLdhvEaVc=; b=zoVrAj+MrIN/9K35aEEe5wRmeM
	NJ4ubhsmHmf5ZKAMjcNvnCl6tJb2OJO/efMN/98ohMHN6SYuqz8SirXwMY2ctu76wUEGtkuYfOSIB
	v0EPXw67ud/OlA4TaJDjtv4JxjGakdbwWKiVxddTnfd1AY0qkBmyli+kAwqXrVmjfRn47JPJq3oPG
	P0B4OU8l0yJw9hp86+5lDUoX6vF3CuPvgDeDwrQAap6pGYRwxBohDv6/pYAP2NuLkNemi4AE0PMvG
	HIFxF/3nYR23zaWl+l0xRpGE821u+FNajnTL+77319+1hXEaEX/cSSiZalG+33hWpR7i14nh+AZ4j
	Ykuq8nRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peHum-009fYW-2a;
	Mon, 20 Mar 2023 15:59:16 +0000
Received: from mail-io1-xd62.google.com ([2607:f8b0:4864:20::d62])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peHui-009fX0-0O
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 15:59:14 +0000
Received: by mail-io1-xd62.google.com with SMTP id h83so5605039iof.8
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1679327950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYHfRgyFGmfXf7uT3/vn0EeWZOwjnHEPhqCLdhvEaVc=;
        b=ZxWrpiJs8GXKz97FuIUkpX603uXClPdCVINDc9hV7KeMZQYGOuSSbdoLpkwhgtobo+
         ARwfAqQnNBfsFodNn/CQDVMOJRbBgwHMYj53Udx5uwctETte7B8YA8K4ZV9iNd6ZaQ3t
         DRUDaSKI/MpKj6epZ0TKbhrVoeUE2rkuzlSCwLmPTFTXRPHAueMhuryrLYe6vaQDkTjH
         vssgS9iP7h2ejoAaBYYa9/4z0uWamhu2QO4c7vVupzt4jS9IiYLpUJKSorUY9yJSlNtL
         O6oVaBAIx+Dw9i+YbLz04OdPIp2HNIizHbQbEEmFQBC8fMoZMFrED0xsqSgGcxPIZKMY
         BeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYHfRgyFGmfXf7uT3/vn0EeWZOwjnHEPhqCLdhvEaVc=;
        b=uGIBUGzGrFya243zTRlgO2nIPHcw3ehV3SoLf1tDIpWRl/vUBXKOZDH/YWQmKW6tup
         JRTvpTFtWDk9FU6v+5J0ew5hnBANeZfoir+MDBjTKYNsPVqU2s8UsjGy95hosguFIlnG
         Qhd0KaO+qRnnv1qHY54wans4FggjPyVrTYx7k9B9DLL5myrPvdyJiGfNQNkIXkimAdRq
         81xdb0WRgDuynE2FgIdSu3EVkEX1/SsVJngyc9Hi7WYXmmC24kzlr1hZusH0Y/cMsCru
         NPvABjUwFYo3IYblUYPx2xu5fiAR66KvR9B3WEZLpZQHLHs5rONauC8Ac2LN/7+GgSUX
         GBuA==
X-Gm-Message-State: AO0yUKUL64sO+zR/oMsynbI/AVoVMS4YNGtQR/+5vvX4ncGum825Km+z
	JxOXS7q9NNOSm1//0W5fKdYXJBIeMihhm2vZz8tcdedmZ84hfg==
X-Google-Smtp-Source: AK7set80AWFqWRlEqnusarywacYoeJZQqdV4SbszNu0Fo0QocmMWzC9cQl9RbHeabQIFFidhfX9jbcr4qpjp
X-Received: by 2002:a5d:8b08:0:b0:752:dca2:6690 with SMTP id k8-20020a5d8b08000000b00752dca26690mr5482280ion.19.1679327950306;
        Mon, 20 Mar 2023 08:59:10 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id h5-20020a022b05000000b004060ccabe70sm1726205jaa.66.2023.03.20.08.59.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:59:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id D6AB720D24;
	Mon, 20 Mar 2023 09:59:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D232FE402C8; Mon, 20 Mar 2023 09:59:09 -0600 (MDT)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	Caleb Sander <csander@purestorage.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] nvme-tcp: fix nvme_tcp_term_pdu to match spec
Date: Mon, 20 Mar 2023 09:57:36 -0600
Message-Id: <20230320155736.1492682-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <linux-m68k@lists.linux-m68k.org>
References: <linux-m68k@lists.linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_085912_161607_1DB450DA 
X-CRM114-Status: GOOD (  14.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The FEI field of C2HTermReq/H2CTermReq is 4 bytes but not 4-byte-aligned
in the NVMe/TCP specification (it is located at offset 10 in the PDU).
Split it into two 16-bit integers in struct nvme_tcp_term_pdu
so no padding is inserted. There should also be 10 reserved bytes after.
There are currently no users of this type.

Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 include/linux/nvme-tcp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 75470159a194..57ebe1267f7f 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -113,12 +113,13 @@ struct nvme_tcp_icresp_pdu {
  * @fei:           fatal error information
  */
 struct nvme_tcp_term_pdu {
 	struct nvme_tcp_hdr	hdr;
 	__le16			fes;
-	__le32			fei;
-	__u8			rsvd[8];
+	__le16			feil;
+	__le16			feiu;
+	__u8			rsvd[10];
 };
 
 /**
  * struct nvme_tcp_cmd_pdu - nvme tcp command capsule pdu
  *
-- 
2.25.1


