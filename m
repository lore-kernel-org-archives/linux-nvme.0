Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB8FCFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=; b=PHhU7rEkKbFF6piGAP4AAbp2b7
	K30l3841PMqgDsjYmoMfY5piPRPzdzjCIMCss9ziZVb+6iS4xYwbBV4btX7xqPjG5zPP9v2KLE0H0
	OjO/9YSHNcuMC8m9af3wQAUXSRC/72aUyico97/U9agUl01lTx15//ufup8isvhto+Bhg7NuTsNEC
	jVupnEkOc8vN4xtz7qrE5Cnvz42YXBC4rkqfQssgsywRp0JCGMrmHNea9riI35hi4dKQSmEHjuFXP
	w3L+MS3/v2pu1TFZuXBDz6UAg+I8tfvPtYOy6MKEbZqeWQhb8QEj/hshExWbDJfWWUVx4cg+iVElL
	oOdid/oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLj-000000082Nd-14x7;
	Fri, 21 Nov 2025 08:18:35 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLf-000000082KN-4BNC
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:33 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1476916b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713111; x=1764317911; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=ABOE3lrZtHOPhkoDqidMoY4eahPBm4uZMWk+uRYy5riEPfje2f58yU1cy0EVI/REF+
         49MnZidjaDwuvUGNUgxAiaH38opMUKdNzT1SQHyn7RC98im30tU5CRmOt9u94ZkJzJ1B
         kFh2PO6mpHeLmGbWd76ofHZPnVb3lC38mfg0qpaOF8EAXNo7u/Ir5zt03HIeG1hUGbVD
         8oDrA3llAjWgnEl3ctw3/MgjILTorpda0vuPNXa/ovBrN0LFpFjXb8wCx5oX5GGcR1aL
         yfZDS2FkhodZJA6dGw7uHr9rPbDkFDSXyK4HN55EXDwiXxWrf3aMEDzq4C0GB59oNBzk
         xXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713111; x=1764317911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=F20Ko6pYIiAwM8icnm4Y/xmLp9xnolcexdeRMsYIbuwGHTI849efBsPmKHcaQM2cY7
         QWVy72LMeKDsH9hSnGSikvDv6oAeWg1UYxMf9P/aKnsKuJJrYSbj6NOSNLUI3HDLgiw6
         9bLTOR86Afp/NvnzI2Q6Dno1KnqKnvg8drhsVHTXCxIXCDWm7SeOEQMS0JptI+UI57ud
         hyIQetKbcRZsuDEGkasWfSD3vuSw51rOoIkTgGUMCPShvmQKA/mrsKq/Cd9+WKBRgTjl
         NUojA7nJcpSqFge5tEhpHmuwxGbTUA+qTE4Zye0O5i+hFQTVkziiHh97bXndWdbs8V3W
         9Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBbZyFHdGRr+ZZSNLpud/uOx4svpnDzBoSYmJhyktHMWV8mN+TfbbT7uxsHGKsoBvZusK7XfzZNIxm@lists.infradead.org
X-Gm-Message-State: AOJu0YxMSB24KMFM4X2bYlGpICB1M3YXbQa8EPQe4fjGcB7l86tCL3gT
	aoKq599FSqe7DV6GQtldF5qhgooULLWBKBn0Y9+DLvDzNGIeUCVoWMBs6tMcJKTS5m4=
X-Gm-Gg: ASbGnctuQx8OCiWRQPMCbfqSGekhPv5BJ9Wo++rvDsv0bwYpMrwmyA3OcP65FUZpYfC
	9NZQFMYjBlNeiHS643DeN+ZWnluixDh2Bj5KqBcbSwKPi/0pstTmjSwg8hk+70Kf1FFuOMA6Kf7
	QJhYgjK1+p0FBDpNxng1fwsuooeC7aviF3iGjdx/o+LocRHdL8J93N1LLur0vesXNJ7VZLXTrBg
	QW8IyGsl74VwD2gbLAGS3nRRyoa9xguKFWrwJvas/Ka0kgw+a0Hy5iwjRCdhEeEY0Y+9dTy5cgU
	0DTy+VnMWJ4n6+7mnVeH+PEkcHKpNF7JTtm4BL5zE8UdtE9NysQKQkRyQIMoCcm1my5nUwUltDp
	34xbUkg68mIUpVFuf78wwr9A7KYj/+5tn3EFfX2GfTDwuwW73JQQ1RiW3sY4Za1+ruJz/bbhUUE
	FYm9wypXdYbW1VP5CElLdIe+kChg==
X-Google-Smtp-Source: AGHT+IFWgtWuJbeRkMQREJ+GB1+CIl1owO0q1AKLfdba/kSV5Dme/s+uE/AHBWMGMV79yRIBfle0AA==
X-Received: by 2002:a05:7022:628d:b0:11b:9386:8257 with SMTP id a92af1059eb24-11c9d87a334mr448835c88.44.1763713110905;
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 8/9] nvmet: fix the potential bug and use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:47 +0800
Message-Id: <20251121081748.1443507-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001832_051558_E3C03697 
X-CRM114-Status: GOOD (  10.70  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

the prev and new may be in the wrong position...

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1


