Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C46CF9C5B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2024 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d7UJLznyIZVUFXyg0Uvkl6hNYRP7JRqaS3AvNVUFfy8=; b=sMjGOtmSvjMRcvFffgfVqoZRwm
	jsDIUQDa/PtV4r8qPTFKv4LPV7w557779aZpr0G7StDVyACjSjUC4zUx4exe4RKHesa5J+YPycqZe
	JWyTWrBUWomQOssygQlnYrEbsVN8FC8i99Fr4oaMNGj+UefzLp5rEqZFRRq2FfftRUpdAHSaQjpUJ
	IX6Ru2mwvbwiloN8m6HWiOkcwYtKqniHsebdXMjdTZRfPhQ7fbnuurH3lq1RKAI+QBjweaKkXooRO
	GPUqunAUrbeVBck83dlA8qZzY4w5u+ePewqg3JJriMsgpiKNnVlMaPtcKEmjrD32Qejg+jeYQq9A4
	kLvJuUyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ss2KZ-0000000Dqi8-08v8;
	Sat, 21 Sep 2024 15:47:31 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ss2KS-0000000Dqhk-2H39
	for linux-nvme@lists.infradead.org;
	Sat, 21 Sep 2024 15:47:25 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-718d704704aso2556497b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 21 Sep 2024 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726933643; x=1727538443; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7UJLznyIZVUFXyg0Uvkl6hNYRP7JRqaS3AvNVUFfy8=;
        b=BEuAD00eQbibmrRTizeP+yrtomMHFoXQzibCNSUkZ4N/3uIfHuI3GJ7osf4LJulGxZ
         TY+WoV1bSuYs1/xmvdw/nwjv3sTEwUeObn7LReswntotI3RLZy5TJVyxmzGwzZ6rG2hi
         wno0HajeewlAZ5h6nCYoHN3pOTNn7gW5LvVMzEnHLVVPmR8x+bF0qSzBiXNAFu4VSkx8
         3UkoSuu8NM9S7SQSDxmP1kukYpjm6n9fddsDo3os0xMyHCANDfAwTv/T+/zD5MGA3adL
         /lJQss/y7rBknvwLfrDun4LFqlgPshKxAlNk8lQqvZIE4DijN044ECGutQyz0E5NASvX
         nM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726933643; x=1727538443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7UJLznyIZVUFXyg0Uvkl6hNYRP7JRqaS3AvNVUFfy8=;
        b=qgbUrg0pIj/QdEnzpATkL1y2Jd2Bb8tPTRQHt20JMvsSncW3CCe3f8a24IfvpvCQTb
         P5MMs7LoZb8PfnY+FFXyxpJtXShK6bTcpERsgNP46ZBXfnNDy5N/qLrYHD9YJgyQul3G
         BRkyQnAVE0vt24OXJD8hGtv+LRL/VO4u9ZdRcQ0D4YhmJAMmyp3yhmz6oicWXme/KQeF
         DaZhqR2jxh6NkURlAb9M1M+ZK7CwlhE8AgUy2qvFUVakF2G+hxU9zfEjEqmd5ymRywov
         7TfIBUZke53VKEcAOEsogQi1p/LCMawNK1xrypYEkiYHty/3jIpYt6c83tddatkI4rCu
         V8Lg==
X-Gm-Message-State: AOJu0YxZCvqOIeRHb7abvPyFN++Uvo9DxNPOUYxapvZLSwi64lKe9yYk
	oBEKFZwt56KXw2MwV0FlFb9CcnDUNDitKmHGYA8u/jMBsqfvhOFxGO0VwQ==
X-Google-Smtp-Source: AGHT+IGPkuhnEB6WZkGX83r2JzO47MV3681gtOxHMZAdp3GW6OBOUn78lv9CzL0inNkhSO/p9f4Zvg==
X-Received: by 2002:a05:6a21:60c4:b0:1d2:bb49:6381 with SMTP id adf61e73a8af0-1d30a9d890dmr9488153637.47.1726933642675;
        Sat, 21 Sep 2024 08:47:22 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:ec2f:9038:974:8faa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b13dsm11762032b3a.97.2024.09.21.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 08:47:22 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-sysfs: add 'fna' attribute
Date: Sun, 22 Sep 2024 00:45:53 +0900
Message-ID: <20240921154707.4362-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240921_084724_618448_28EC74D2 
X-CRM114-Status: GOOD (  11.73  )
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

The fna attriute is needed for the format NVM command.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/nvme.h  |  1 +
 drivers/nvme/host/sysfs.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca9959a8fb9e..0ecb7cbabbed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3302,6 +3302,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->cctemp = le16_to_cpu(id->cctemp);
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
+	ctrl->fna = id->fna;
 	ctrl->vwc = id->vwc;
 	if (id->mdts)
 		max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2c..3df0fbaadb04 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,6 +328,7 @@ struct nvme_ctrl {
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	u8 fna;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index eb345551d6fe..816a869306df 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -546,6 +546,18 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t fna_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->fna)
+		return sysfs_emit(buf, "%02x\n", ctrl->fna);
+
+	return 0;
+}
+static DEVICE_ATTR_RO(fna);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -687,6 +699,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_fna.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.43.0


