Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC6D5C0C0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s7KiqxoW7OuDvSS5G5yRhDEwx5kawPqlO3S3lfywhww=; b=aNLQFgTE6XlFQuGi43mf+bxurU
	cI8TN6rd1kY94J7m8L8cmG2o9j+dsN+Cy/udzlpto/UqJvcnJoRa/FGnrjfCllQwlvUmaLTltmJ+h
	OrHx34yjnfyOxef/VwYVVc2fLMFQWqv2zOulwGPu/ME/F8mjJE54H5MQiySViIa/HMwbowxbvj9Ih
	vU6sMveccD6gDS1MFESh2mS7LrP+BTz+ti0RzxHfnVVySie7tSW5nlap+taVCfQkM9RgYCn6jLVdd
	09U0ZejPefZiLo/Cewm9NxQXQxdw7Al61bGMxgjAl694BTR9ej9oFq/NP72tHgCVgHaerBegD4IHO
	UbRvKqtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLl7-00000004cvi-2koX;
	Tue, 16 Dec 2025 03:29:57 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLl5-00000004cuu-1gDY
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 03:29:56 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2a09d981507so18436745ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765855794; x=1766460594; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7KiqxoW7OuDvSS5G5yRhDEwx5kawPqlO3S3lfywhww=;
        b=FSDWq5Hr5wXWSjTQHIuag/oItTJ/fkig/8uk/t+K+LIvHsQHbi5J4antKIWuivMpHN
         0wf1XgZe07vrhjCg8HStTEEUdd/pViKUEaRWtk0hlnFlpEymS6lhzMKbKYk4VPv5iqkb
         Se3T/kvakbdz2/EupFoYb+ImTSE5yOLzI9cIEKdwlmpF2QX16oT7+81RVxiEm48kPt4A
         pAeP4n9vr6iB/aBW0OjBtbCyeWJEaSJUkH8YNUK86ODuGk8EotGlh1GImQZG5WiqEkgJ
         04F5nqxhUhfd4efmWYxYz6dUiaWkaRbHz4nnr3yZovPh6h/WZSx07chUT3AXeZSPjxj3
         3oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765855794; x=1766460594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7KiqxoW7OuDvSS5G5yRhDEwx5kawPqlO3S3lfywhww=;
        b=gEhzasWHvU0aW0XXufLsCzUjKRF9dgBIBR7U13rGUNK4YtXe0XSjvZw87plToIUTpN
         2cBFD9cTvp41dhXaY6oD+NJZmOL/DwGqImV3hRoXhajprXM+Eum1AeAlCFan5sZdubzv
         1DkjIClxDd2YMBTZ4AyoEaq/sb87BfHJ40DI//ZJ88JdXXcmQVYpMchTowJJQU53poDn
         2ullLb8/CPEwbjjGHtpdcQujPhrQLfrGoH5wfFGEZtyt9y+4Pt61UgzWt4+vmEo5SJql
         /qQ9OOjf0A38sEUN8s+6ihm/mny/8HtwakTwnlqYjfQc3lHOy0UBhB/dt6glTkicTSGm
         3U2Q==
X-Gm-Message-State: AOJu0YxLexkX4e4VD+vp2qNKMeIZ9TYfTofsh21B8R1QZ4Puq+b0AoFi
	NYmb4iS4sqQ4QYbRXxSgPSyGoH4335i3CqpuQGS+T7Tfjl+GcPV5iNB9
X-Gm-Gg: AY/fxX5VR5wjCffJdU4aC/4Cv7qMqVVqwOO/GIowyRrzSbGqM6gj/arM2FRXqsHZ4RU
	Q7t/TMIHYGimQjTCGwi+kDPNwoF951EbUi0OwTwew7dVI+OhfM1DP/eX436ml1VvXbX1KoFwnB3
	A1O958P8eLhhSA+W1KNYGkOtmKn3LFt2pCdjo0pIeeWZCjzcJ5fvR7yxjJ4t95ECKzKxHk5stw4
	HlcTMqCGF7KNeBJqXk17wIHSCnsR/oSvWf/3vaQ5UawB1LYehHt4hHeepkAniUOmJACTulntwGa
	XkMCdQK/tRZCM/AHE6JOOzLMlmkhN/x0cLZo4o60+ce5oSySJmROm5/GgZiQIu7v0vmPe3cvlJy
	hNvQZeq5odiH/cBFsUxIZhWSg+b2URQsExqi6ySbvU/BeXYYDjRvu4pjxNIGpiYoxKsQbusV6OG
	n/uHT7d6zFJYp4/r4B
X-Google-Smtp-Source: AGHT+IG35pM8GkbEHWoRnO4S4k3ksgy2LntJzB1Jl7litUALtsKTKhoxceaVdhVWG57+Pb4Es//ydg==
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29f24800550mr145716255ad.0.1765855793945;
        Mon, 15 Dec 2025 19:29:53 -0800 (PST)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea04b7bdsm145290875ad.85.2025.12.15.19.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 19:29:53 -0800 (PST)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 1/2] nvmem/core: fixup minor typo
Date: Tue, 16 Dec 2025 13:29:31 +1000
Message-ID: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_192955_483992_6AF41045 
X-CRM114-Status: GOOD (  13.08  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..d90ffd0e4085 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1224,7 +1224,7 @@ static void devm_nvmem_device_release(struct device *dev, void *res)
 }
 
 /**
- * devm_nvmem_device_put() - put alredy got nvmem device
+ * devm_nvmem_device_put() - put already got nvmem device
  *
  * @dev: Device that uses the nvmem device.
  * @nvmem: pointer to nvmem device allocated by devm_nvmem_cell_get(),
@@ -1242,7 +1242,7 @@ void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(devm_nvmem_device_put);
 
 /**
- * nvmem_device_put() - put alredy got nvmem device
+ * nvmem_device_put() - put already got nvmem device
  *
  * @nvmem: pointer to nvmem device that needs to be released.
  */
-- 
2.52.0


