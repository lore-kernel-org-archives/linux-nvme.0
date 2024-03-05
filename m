Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5632C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqt+8cktK+V8idZwjIDNU1rO/elSFQ6X7CURi/kzXvg=; b=MEK3XrErI/4E35paV6fs7oiV6Z
	FuFKlK7/0WvLmlwbmPAYEFl0qJcUIqC0xic26MIZ+ZtFKXstr8Q/WtvrJ+GuvM5rKoWSD5doxV58M
	Gh/Tk0KxBSS1rqBWIBwj2Jol8kIYLV0ooU59m84NBiF2XdjZSQkvVB+9q62aJHnawmzZqSNsHFVsu
	t55nZGZtD8kK4Iyq22TtM7BLBDrTcoDnct8NgEGGSraq4VkpckRXCUkhnZeuPaOMkMN0IBycAYbtV
	9jTAO0ethDmx2HS2fLiVKDbhcftDEY0QNHCEABghBS1Bl2mD+o0j3i4HBQzZvZ0F7CmDjWIxDkRvS
	4A8OWGDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUec-0000000Dha5-1omR;
	Tue, 05 Mar 2024 13:16:22 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeY-0000000DhWp-1jmE
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:16:19 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so26582215ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 05:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644577; x=1710249377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqt+8cktK+V8idZwjIDNU1rO/elSFQ6X7CURi/kzXvg=;
        b=Y8xPbiKu3EWzWAlfpTyKeepuSVztMjH3gOH5xvSINBYAksWM6s2EUPZ1M/fgERjhxY
         6XPYV3DRAyW6zUz4eSF0CfYoVOiZ4j7V0k/Het7ptUI9LSDnn8ehP2BAOAy0NBfy5xCo
         aLZUyKQb6/8KX+LtVhMLKA2fghIUEy0UhcfgeDeXI2nUkYpXqfb+2YPzRmRUnIAvPESf
         2CEzsEIMnWiaVt40rIVrN4odkVRZD52E4+nSRMc3RuluWosg6rMsh9UCEPrstAhauyS0
         Ih7tiDORpOCVAzbqkUypjhgglX65fkZTTB0UeeotnDslPQM/2XIksRPCG6fjpKGkxQhl
         p4eA==
X-Gm-Message-State: AOJu0YzrmLRYn2IWHcMeWBaS82LOKqH8SDoLlkG2aPs6WxVhcKCMle8q
	fVPfESVShpk5tG5kkVVW0/8B/obZ9usdI8NkWimzwosC8fQodc7Zhx+4bEaU/BKu9g==
X-Google-Smtp-Source: AGHT+IG9CQ/TOywUL0lRZw8A45CBzTLMi8LoTwLkUWMwPnBC6g9eldfxFCnZ7t4YOlOhH9FiQJOjqQ==
X-Received: by 2002:a17:903:1249:b0:1db:4419:e925 with SMTP id u9-20020a170903124900b001db4419e925mr2003858plh.1.1709644577073;
        Tue, 05 Mar 2024 05:16:17 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001dca813b07csm10502348plg.62.2024.03.05.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqt+8cktK+V8idZwjIDNU1rO/elSFQ6X7CURi/kzXvg=;
	b=rTsvBQq9uE6VWvj5xypr/90eZoYr/nFmabxffrvmshWjFc8ehvdkQhf+deH2N0rozSXbZW
	w27TUHwR49lidBoYAvii5CSaYjN8uyXDYcCwXNMCW5r3W3FmQ9xSGwSGG5CjNOcYT6o+qt
	G8t9iuyTjkT6ZUNQNEnIQuw0NFUMCEW4d68AvpEFleB44jEuKPrhoGVgV/w+o7LAH1ukvA
	CsSi1U+Xlspo2E5TBrgjTUTPiL08HFyAzZN4FxHFy4hDrbvMjLQ1ajF/WsipIoY7NiGMa9
	ZyoPqbLmsXdnv7PvO/5QaSV9QkJmx5ohTYsbWlSEU3oaHpGo+dOCF61i33QtOg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:58 -0300
Subject: [PATCH 3/3] nvme: fcloop: make fcloop_class constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-3-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=dhrwlnVq2theRONa+InVWSZTMPvREYNEiPaTBGSHGGM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRXt2+dITQnRqAEy1FoOdCoRSxRNbVfJPrz
 CQVOd6gJjuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 poQ+EAC1E0hCOgTum9T66zK+bF1h7DVrDRQqDcefQv/xbPQa/qn1ho/7PMqlVqH9EI2Ns09s85t
 qYZbHDCbGNlFF99xy7Gr5WrmJ/+f+UmuIQjGIj35ZZDWaG1SQ8L7EG23TJnxnLELbN74tGkY8W4
 25cHoAaTo4KRYqMZ7IR0eX8ftfzjhp51yzzpEjLF2jwcO8RqryhEg329LkMNXEIpdf11GPO+6ac
 YZ2zwboPONSN3L2SzmhueKnPExWkGBleZY0m7NE5PyaVFNycui4V5jIrmPw5zwGQO7LAz3jVD0v
 7qYBokatdGrF/K7hPJ4E1bYWjYYi53Q51lRX4MwXl1hDlszzRx0OhVLz6mFhP7LVVfnZ5N3mk7Z
 QbhAzra4F/8V/RiAjAOzzofKtgN/3OSehe8sHFPnSvT2NDERYtmG/8N6Ij+BoXucesN0L6a94a4
 UoeVhXjelNf/BTzjqmHCz03hf+CewLXh9T2loEE3NbS/ngxbbY9DGfNe3KYst0FGXpvjesZH2P/
 mZr7vnqov4m4jHUuv2ffl7s3uyUXAA77wwFBgDaxUrsgXr4xGee71thj9amwPPMyAqfQ+P34tPE
 bu9zUEQW65CD5QbiS2qwYd3ig0zxQFNxvTwahoYZMNNNbdvweZ8isOAmn2Lrz/pACbh20vEAXuU
 eJ3SkhzQmeXvccQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_051618_545526_17B1145D 
X-CRM114-Status: GOOD (  15.33  )
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

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the fcloop_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/target/fcloop.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1471af250ea6..913cd2ec7a6f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1556,7 +1556,9 @@ static const struct attribute_group *fcloop_dev_attr_groups[] = {
 	NULL,
 };
 
-static struct class *fcloop_class;
+static const struct class fcloop_class = {
+	.name = "fcloop",
+};
 static struct device *fcloop_device;
 
 
@@ -1564,15 +1566,14 @@ static int __init fcloop_init(void)
 {
 	int ret;
 
-	fcloop_class = class_create("fcloop");
-	if (IS_ERR(fcloop_class)) {
+	ret = class_register(&fcloop_class);
+	if (ret) {
 		pr_err("couldn't register class fcloop\n");
-		ret = PTR_ERR(fcloop_class);
 		return ret;
 	}
 
 	fcloop_device = device_create_with_groups(
-				fcloop_class, NULL, MKDEV(0, 0), NULL,
+				&fcloop_class, NULL, MKDEV(0, 0), NULL,
 				fcloop_dev_attr_groups, "ctl");
 	if (IS_ERR(fcloop_device)) {
 		pr_err("couldn't create ctl device!\n");
@@ -1585,7 +1586,7 @@ static int __init fcloop_init(void)
 	return 0;
 
 out_destroy_class:
-	class_destroy(fcloop_class);
+	class_unregister(&fcloop_class);
 	return ret;
 }
 
@@ -1643,8 +1644,8 @@ static void __exit fcloop_exit(void)
 
 	put_device(fcloop_device);
 
-	device_destroy(fcloop_class, MKDEV(0, 0));
-	class_destroy(fcloop_class);
+	device_destroy(&fcloop_class, MKDEV(0, 0));
+	class_unregister(&fcloop_class);
 }
 
 module_init(fcloop_init);

-- 
2.43.0


