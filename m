Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE4BC54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gadEZlo5HX6ZvCpKvvvFLxpx/LQrgu8T3YbMhZTBo7E=; b=AYV83MlPsLiFtdB9azEO7jMTBU
	g151qf/57PlShZOLtB+jHYc2WnirJUEhGue6I3vLaIab5tkavrk2DmjbGMlO8WnGaO1NCXomIKcMf
	Nd45VkoKdb1CkiIw8SEObvIgyO1/lbo2SxUxic7jimk5HpHuwsKPw9tWdYpNWQY82jp8QfWNRfwof
	j6AUNNvnK7nvIk0ey/KWh96IXI1DVjS1h3gSseralGI33wIxs1zVa3FYjVjSZzOnN0pc70AzGeFos
	NKFirgZSeSb2kvrd2HCNuGgwf9zHteBVnc6sBvwm/0y2unxuWPeAAtr5L02RtQwQ2it/J5Y9v9foA
	gNuz3Zvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeX-0000000DhWr-3mbY;
	Tue, 05 Mar 2024 13:16:17 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeV-0000000DhUW-1zEz
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:16:16 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so45980645ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 05:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644574; x=1710249374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gadEZlo5HX6ZvCpKvvvFLxpx/LQrgu8T3YbMhZTBo7E=;
        b=Uh26Cy8SDivkdyo9NhGfk0SWRnheKTMZVV+fAwMqierPETHfNls79idc+3wscLG5/P
         jTBR8OvTzdcnbR/Qbz3KfQi9XrdWm01syq30bDXtilu9fS3oKcId3zLk33jevzPshRez
         Y4IJZfECV5LJXG7Q6j36xgr/7Bv4PNKUosH2j8NeA8TLrEgzdsAZSiJ7bHAA68Nk/DXn
         WxCrtXX4CjV/+d6Bx3GRKl0E9WKRoibu83pDTK7sI+mlXdy/dxZjjp7fFEQewrfsNK/R
         eB1FerfAqsgFsOYFGwdM5o8QFwuT5fkRk1exLfFVSASS6tQJPqb8RYW1b6K6g4QkReRF
         I5qg==
X-Gm-Message-State: AOJu0YyaHRv6xax+8e36TrR69+xWAL4kwyE3ltNLvu4PjWb2+a0BrWE9
	T8dbGLsW253FsPW4jEJLl8eYrAsxu/pXw+5mmctt6MM/9hcEQc4k
X-Google-Smtp-Source: AGHT+IFxlioFA+0snm0cpY62UqyNrvze7kGIh/a9o4bx+H+50s4b27RXJpgKgrdJBQz1ek0gYH4x2w==
X-Received: by 2002:a17:902:e74b:b0:1da:22d9:e7fd with SMTP id p11-20020a170902e74b00b001da22d9e7fdmr1972561plf.20.1709644574032;
        Tue, 05 Mar 2024 05:16:14 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001dc96b19616sm10493335plg.66.2024.03.05.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gadEZlo5HX6ZvCpKvvvFLxpx/LQrgu8T3YbMhZTBo7E=;
	b=qwGPOhIu1JrBU+Ku4MfcnysPIzAdIiHZA4ojvs5dgJoNaxxRzWfO0isA4s23FJ2AvErtvL
	uMhE6ciJtGgSJaUpjJmegQIqKOMWpsa3Ig4dthh+kNATuAPUly6Pf0xMssF83j4w95mHk2
	hdpNwolcz+WnZW3dnZwP8AQxczG8LM00nspFDceybthbEd6XloCup/DnGYhglIB85oIJMN
	AlX2O54usTDfubIpGeSVQB51ZY8yMIxwEO1/bKdCD+6TfjHKJSXHy/i17GPLBQJbClMv6/
	mpsR89ucZhVRjY6+F0xvC9CDjfnnTmh2OcjncrKSYpzBnYo3UowfWvMXyVdfHg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:57 -0300
Subject: [PATCH 2/3] nvme: fabrics: make nvmf_class constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-2-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2439; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+dZdFqYSeTBhHCI/BvnkTnL3SyFJABSSpjeS4o55OME=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRk7shI3nEmZOyWDcbHBkqIDALjOp8rSwRS
 PW9luUHba6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 pokLEAChkBvAmbdjHqdx0mLrG/G/zqnAQyWG16mp9+F/bfOltpDc+KHT6w8q9AlAcWuDi+A0quH
 Aqb8pXZ1LLW2ljEQ79Uyc2GUZ1RBY+POjejYCmNW5B2yqFb07gbpV4hTbAwIiCIe1CvhiV4BdUt
 hyZDu0RypQUJKvMmF3yq6KpWnJkHzxJja2OEYWtLg0w+ekav60KkFSiC2AT/hg71jd+LWnYlXAc
 MUxDRpSjUSwsnUSG8yg/CVdHpxTg4ICOEb2oqEH7vFLUGLK3VkaAUWrxs1pmFVqnCqnJswhWjXT
 u78DPjsdkeJY2INFFkYoJVsxYgKZjgY2S0ja7YBY/j7ynwpMJE95fU91qgFgtFRpble9PmOtNqH
 +veGO4HF8hR8Hz+IpCiNQshdJEpb0jCuih1Adnwu3n/3VPDUsUHMfGULc961qqkhGcEws92j9OT
 B0K5wiox5D5bvBtKGYhUMOFnftMYvB6D0gC/4rYtzlZYb2eKhm6Z2jB4rK5dzL0FfGPAh2R1n6Q
 Nof4Oyx5x2CNKa0TppQ7zY4GYed6Ltf9tDnNrbgAwT1ZLekAAocUIYQL2UgzYXr3hCmTnlP/xHt
 d0jhQaiSufymo8Xf7iQJODbUl6YuyeHRQS+Vy48BC2xPqwOhU3JRn8RRwjrmlNZClBpErCZvF8o
 8Ad9eeLbDqms8Eg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_051615_577104_D2CE7521 
X-CRM114-Status: GOOD (  16.07  )
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
memory, so move the nvmf_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/host/fabrics.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..94e0911c43bc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1318,7 +1318,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	return ERR_PTR(ret);
 }
 
-static struct class *nvmf_class;
+static const struct class nvmf_class = {
+	.name = "nvme-fabrics",
+};
+
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
 
@@ -1438,15 +1441,14 @@ static int __init nvmf_init(void)
 	if (!nvmf_default_host)
 		return -ENOMEM;
 
-	nvmf_class = class_create("nvme-fabrics");
-	if (IS_ERR(nvmf_class)) {
+	ret = class_register(&nvmf_class);
+	if (ret) {
 		pr_err("couldn't register class nvme-fabrics\n");
-		ret = PTR_ERR(nvmf_class);
 		goto out_free_host;
 	}
 
 	nvmf_device =
-		device_create(nvmf_class, NULL, MKDEV(0, 0), NULL, "ctl");
+		device_create(&nvmf_class, NULL, MKDEV(0, 0), NULL, "ctl");
 	if (IS_ERR(nvmf_device)) {
 		pr_err("couldn't create nvme-fabrics device!\n");
 		ret = PTR_ERR(nvmf_device);
@@ -1462,9 +1464,9 @@ static int __init nvmf_init(void)
 	return 0;
 
 out_destroy_device:
-	device_destroy(nvmf_class, MKDEV(0, 0));
+	device_destroy(&nvmf_class, MKDEV(0, 0));
 out_destroy_class:
-	class_destroy(nvmf_class);
+	class_unregister(&nvmf_class);
 out_free_host:
 	nvmf_host_put(nvmf_default_host);
 	return ret;
@@ -1473,8 +1475,8 @@ static int __init nvmf_init(void)
 static void __exit nvmf_exit(void)
 {
 	misc_deregister(&nvmf_misc);
-	device_destroy(nvmf_class, MKDEV(0, 0));
-	class_destroy(nvmf_class);
+	device_destroy(&nvmf_class, MKDEV(0, 0));
+	class_unregister(&nvmf_class);
 	nvmf_host_put(nvmf_default_host);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_common_command) != 64);

-- 
2.43.0


