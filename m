Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A188CF9C6C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RdAknJL0N4MfFq2ZIichp4a5zzuLXUqfhxmcuM4H8AM=; b=XA4algYzEa3yLizqJZGJDihnf/
	weBdGlSbPb6U46x2LFCCJoxn2KiUhSlGfKeMAQYPvwEdNf0SQACZlUkQ2Gkl8JY2wl1FBDyC93NnA
	nYZNJ8/HnvZ+pRH9xoj7Dhyzf3pWPLeGA47AsMJLV188cvRKPRNidEN4eiUO4Zg6IdDjvKQmCvSjF
	JcLSZCxc+BLcFruiQ9p002EszCsbM9bqZqlyG3i9WE84f+RwI12X4NHXQELnYlxrscGRApBTqKoCo
	puyKO/eB6gBbo5wDayK4gKexNrIu70/sjzPPY4XsHcn+3mVegT503sk638FfhzAwtJD2Gpd8W8vgB
	hFd18Egw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssKGU-0000000F1Gl-1nFy;
	Sun, 22 Sep 2024 10:56:30 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssKGR-0000000F1GN-3CdL
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 10:56:29 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-718e6299191so1783830b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727002586; x=1727607386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdAknJL0N4MfFq2ZIichp4a5zzuLXUqfhxmcuM4H8AM=;
        b=AODm9URJT8tSsGZBa9x+qelN3Njw2re2TBTzuyDff8lDjI44OCpQ312oM9GIt7u82L
         aQvYLHZXAW/p3IwneKjs1HRFwoxqGHaYhLl18yfICbtA8prjnuBTSgJNTiKCbXQmYDoB
         sjmqKW0PxwZBnKLQCKE2xxFDwy0iobGQrDeFrle/p4W4Wessj25JgJqOYFYGuVXCJ0q5
         RGkjIDxkRYHhpKGcoSaecq9m0idm5OO2eiSzPqdQ7vgVU1deKWGBG7CANK6l+4xpg1C8
         6RuwNC2UhtF9YoflqY8At5ft3aAV7ke2d8HAG/hDrz9mAqdPwqqLmGm8ToZunT4S7BlU
         qJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727002586; x=1727607386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdAknJL0N4MfFq2ZIichp4a5zzuLXUqfhxmcuM4H8AM=;
        b=CKfxBOPUeNfpiNWB5g54u5pV3somJOpYr9nje1rl+4/mLOO+QXyztXmqB4Ps0Um62Q
         oBS8iYugSwsB6IVcuH+BZCt8MZ6NizDX07l8o+OZ26D0a6ml9Sf2U0yhLiWZ/IXRT5l2
         Ywvwje2aHiTULsDtcfkeGjohVJ++Df9F8nmXOn9bdb1N1PWqOjqaJFw9tGWp1/mC8BR9
         lukJBkHLGI0JGnM+NFUtmVJwFSh2y05rGR3P6iTTe+AQDhS37T3zvylHJxrp0Hpg8AN/
         40QxKMuD2/DJYK0O29BISWAPa1L7p+PHx3XGE4wJMNZvkXvkZTkA/7xZJ10q+wcdLDhY
         rp7A==
X-Gm-Message-State: AOJu0YyMsS/jCH2Bvp3HjI1pQc+a6jFnbQ+IzkRgSaToAdsd5VVMLw0j
	KWjoF24aUX5UTVr0kgsgAu5MofIW6qUIRze9RQWyhGrcDIF7cV5wQF02BA==
X-Google-Smtp-Source: AGHT+IHsTl1kicqBAMhMhICK7oZLibxKisyGqubvqzKYnrwW0j8Uf7xBTMDiWXCPChjp4Fa9WEFayQ==
X-Received: by 2002:a05:6a00:3d4c:b0:719:8f48:ff01 with SMTP id d2e1a72fcca58-7199cd62dbcmr11976093b3a.6.1727002586238;
        Sun, 22 Sep 2024 03:56:26 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:16d6:f5c2:eee9:3f4f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71977315b07sm8061589b3a.37.2024.09.22.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:56:25 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-sysfs: add 'lba_shift' ns attribute
Date: Sun, 22 Sep 2024 19:55:42 +0900
Message-ID: <20240922105621.4642-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_035627_824996_3CFA82E5 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
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

This is to reduce the identify commands to get the information.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 945b7fe11373..467049334f23 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -176,6 +176,13 @@ static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(csi);
 
+static ssize_t lba_shift_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%u\n", dev_to_ns_head(dev)->lba_shift);
+}
+static DEVICE_ATTR_RO(lba_shift);
+
 static ssize_t metadata_bytes_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -259,6 +266,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_eui.attr,
 	&dev_attr_csi.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_lba_shift.attr,
 	&dev_attr_metadata_bytes.attr,
 	&dev_attr_nuse.attr,
 	&dev_attr_lbaf_index.attr,
-- 
2.43.0


