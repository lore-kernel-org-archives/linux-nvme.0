Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186CBEDF17E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pvgw2VSXgLVN+GlRTxvdu7bkd3BlZLv7u6upmku6CGw=; b=T9sbpafjqZrg5rjR6OrzeBUeln
	Oi58oju2vI5gJ2yc9s5LitMBeZk37n989pAl0z4l1X9bnOCD85fR+3BeNYESbX7AhCevhvwXsnGNZ
	wqC96ojMJks4Br2BItwuYe39o9glNKX0XD5+O34vh0ozEWzkkJ/DGPF/8yHYo8iOfJPhf7C9/uSZ3
	M9YPIm0Q/DiTf3yyz01tOHavsvkxj4unbexya+bXzSOiXeBduWnn48fpwB5GirK5rtFh4VpBDVOV0
	qBH3Js+NP+C/GR5aTKRr4lDa6iQcSCtQh6KA6Z51W2ZtJ0v8XMNDQ0c14EaPLHBb2yOamysTB7WR8
	L6F9UZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gh-00000004F2f-1E28;
	Sat, 14 Feb 2026 04:28:31 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gd-00000004Ex5-0c0S
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:28 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-12732165d1eso1959169c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043306; x=1771648106; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvgw2VSXgLVN+GlRTxvdu7bkd3BlZLv7u6upmku6CGw=;
        b=PLvhVc9Bu7OwfymmY27lEc++MddpLEkFIjXWsWEyUbqFSsQOJcFhbAqXqb7C/GMhwY
         stiuX3yYXYT7IhaAn9t3TJEkYAuR91QOmZDhKec7V6gO/97+LNFdjjNuF9hxriW3U9ib
         YRyljJnuxz2nuO6ABzLr992hgQMAwYb/Kl/RmPX8jqtW+/QuJ8bZJVJlZE4drUoVFnaI
         Jvr9puXYbsHv0HDx+pPCC8jmUpdaIG9wUekdEkjGuLxGkDsJv9K4vSqrlGeHH9qmAJvM
         ucwI5Bc7bV2h0lkkWdMwu5wtkMDNg6DKdpSOW/0H5gHKFffsFtcPBalziEhWA3CI1pEV
         LSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043306; x=1771648106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pvgw2VSXgLVN+GlRTxvdu7bkd3BlZLv7u6upmku6CGw=;
        b=Obfaq6UB4mFnxbohFjN3jK+hmBXX/3F/eQcDt0Y6jnrIwLY9uHJzq55M/s4GQZgMZ6
         kis/v5xlH8NWyCEdB94HXfqrbkOaiLUqkjThzqnXwVQsFjVBvMfWAUmRDZi0U6aAiBPU
         9UMBW86GyiKtTUsVyZm5IE965tCx2TLVJ2NubuW1G8/6I5NWPlZ8s/Nz2Guyrbrs2lF8
         RPQgVCk5UMhC7bi+CJQeACgkrwaVyuCFfBo4G+HKPCZ7x/jOWPHAGCmAYY+qImU1i/0j
         DVXrib/+VCQtMhkDnXA/uKpb3/yljSFZrXmULL9s3PIn8NxZGeSrsmqeGMNkzR1ZODBD
         UvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/csn0YlIPUir4GtuyIZl5IUcjOflKdUQrXnrL6L56KfTReYwjP2Fk4+Hsjk3xtlDp28kEvHuIaPkE@lists.infradead.org
X-Gm-Message-State: AOJu0YxSJ7oXiTzWW/S/GO2Ee96+T0CZhF9EVVv7H6YV0IktYqLDbEJz
	4TD8cc0atnMiCl6qG4U2oVU1RrKKOj5gp7AsTPC1qbapjdlg0ch2S9OibZeL14hAO9c=
X-Gm-Gg: AZuq6aLHWxd/2d1qs3qUrgngl6BSCSBln8VT4TpqekTU4C/4AbV62U0WzkgfHNL8CMC
	H6DbgIvRihx0x/rJv9Y/SaP/m318TTwc/elBlXzsUqx0YK9p9ipx+dnXNPCoXBkKCdbo9PZQYzB
	Z8EXBAd6CTTiNmxg5RCEPUDDcmC9Zf8CKJS4J2DsuEVushdoI+d6iweGEvEIhipK7OIXfPSrdSE
	9YeCeBSg6ymvT/SILw8VvKzI7IT6KaMi4HsJa83RB9XSt26znMQuoyqlfx9QxFhN9Px+XzKU5bM
	zazhEYt9TfNClm2Hrr7fi1kAkESM8F57RD7qxNxuq93SF8JhuUYn9M1zLPpDzJVyaCecOTsAG5u
	G8+H8N8DJAG8SC0OtaoXNnyQ9u8gYfXS+cbAFqz/j7s/vpivXOqjsFqlgRdKYaDq9K7K0pkH8An
	JMkeU8ygxR36KnLaGvRK6Vjz0lJOnSwWJn4fvdvso8KQY7Tw==
X-Received: by 2002:a05:7022:fa2:b0:119:e56b:98a0 with SMTP id a92af1059eb24-1273adf0427mr1591730c88.7.1771043306128;
        Fri, 13 Feb 2026 20:28:26 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:25 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 06/21] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Fri, 13 Feb 2026 20:25:07 -0800
Message-ID: <20260214042753.4073668-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202827_185972_7770DF88 
X-CRM114-Status: GOOD (  12.32  )
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

TP8028 Rapid path failure added new fileds to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directrly by user if needed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  | 10 ++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..8d26e27992fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3572,6 +3572,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	atomic_set(&ctrl->ccr_limit, id->ccrl);
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..6984950b9aa8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,11 +328,14 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u8 dmrl;
+	u8 ciu;
 	u32 dmrsl;
+	u64 cirn;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_limit;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
@@ -1225,4 +1228,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000;
+	return 2 * ctrl->kato * 1000;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..cd835dd2377f 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t nvme_sysfs_ciu_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%02x\n", ctrl->ciu);
+}
+static DEVICE_ATTR(ciu, S_IRUSR, nvme_sysfs_ciu_show, NULL);
+
+static ssize_t nvme_sysfs_cirn_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(cirn, S_IRUSR, nvme_sysfs_cirn_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.52.0


