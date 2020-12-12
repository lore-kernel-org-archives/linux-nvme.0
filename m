Return-Path: <SRS0=Hsw+=FQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BFC433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 07:58:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B6923137
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 07:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B6923137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGaqjvBiu/z+ZlGKSNzU0JJNpLRd+QBqIp1tqMAFVT0=; b=oPqTDevxF49pQD8z9J2hnCNgxL
	WcNIrkrxUqIEzSI8TelXllkWFeLQbZMfRevRx7SF9Zk4d9fdWqFtvEyUcxp1GPA7TkAnM9ml024ev
	8i+2KT3NsjZ2iR2ACMrFSZPpjSqFqmOyQaSH16vVlQmJfMU2dtYCnPUU1HVPmxhZ3+Ckb05M5X8XI
	OX9c3d4PeYsue+qrUT/0ZJvlRBGjASLMzQLWBO+xGQBRtsz/UiXFSH/BM+Y+OZgIsjt3CQL4N9HNS
	NUsrRCPan/j7pf3UjJsdP9JJ+YaOr14y+zeuT18ktkuDs39xPL35PwtTkC3lh/V+o+Ih0NqHr1/+A
	FjXOPpJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knznH-0007aV-T7; Sat, 12 Dec 2020 07:58:19 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knznC-0007a6-1v
 for linux-nvme@lists.infradead.org; Sat, 12 Dec 2020 07:58:15 +0000
Received: by mail-pj1-x1043.google.com with SMTP id m5so3656624pjv.5
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 23:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M9kk/CA9nciMRKSKbfZOYYwHqdDh/aOItR7NswTJnPA=;
 b=JCHU3jiL+ADP3ea5Q/5kaowmsJHkSEUZYZoHB1yFpo5BtbV48tTopgYHd607d7xwVI
 xO9tLcgSMBaVSR9qDsUVEO+ux/y2iTKSPsTbV17nmVhsoXTloXHwF7PHtBvjfC7k+EOv
 WgdIUmDAxIM+UrGA909Hw13feAZiiRM9Jrl+x10tp4cn0HsPlcJJHBgqjWKIE946qEA2
 h4SnMqytRKT2LRROOxMG9UT6Vgu96G3ilkL4OdKltIKVoQ64zjl4scWc7Iy6aw+10t+O
 cJxnoDWFkv5T15QIUdlatd3FQwiQ2t1J+zjfjxnFGCywpZ1DhCuxW/mf7T2rKdzpXJrw
 nDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M9kk/CA9nciMRKSKbfZOYYwHqdDh/aOItR7NswTJnPA=;
 b=kU654Kj+ClCxoF1fFFbx8+Tj9LO6ARuMTq+t/Pm73PA5OUUq545GgVGpAnGiDbKkOz
 5WZg+Rt5GJyehNDuR2ah6ty1eqObBw9MzWrVRkXhSqOmqHMi9wmYzfSel+qAGqpL4k0r
 0kgsC6mYmNqGiUFCHDgxcY4DMbqdIfKmZo91MWB1cfkwhVHa19G9GJnt1eC6+gZBhev8
 L4tL4Qxxc/BojGLDHnF+lxHNqBNpg5B0rTb7G5wu1CpHRHrcmZ1HXkL6/PZXFdA4sCoS
 IklSwdZYL/egnQ5iczo0/tv4Nfu54489QH3UK7h0MpPcR0eqEOHF1P5NDl91yu8djPDc
 eoTw==
X-Gm-Message-State: AOAM532mxl/4N4lBRydKUh+WozlU9y/aSamaoQXq4fGT0IAaLcbfYH6M
 E2fSkBpoo5w8TnllK5C7zuZd6A==
X-Google-Smtp-Source: ABdhPJyKO0rezQnmsMrUaJxOsLjZoIRlanfnW6UbmKV/W8/74bePm2H6jkc/ekkqlLHRfRdF5OQTow==
X-Received: by 2002:a17:90a:a502:: with SMTP id
 a2mr12511930pjq.155.1607759889279; 
 Fri, 11 Dec 2020 23:58:09 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id i123sm13427824pfb.28.2020.12.11.23.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 23:58:08 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH v2] nvmet: fix mismatched serial
Date: Sat, 12 Dec 2020 15:58:01 +0800
Message-Id: <20201212075801.1393924-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201212_025814_212415_71D3EBDA 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Target side uses 'bin2hex' to convert u64 serial number to a hex
string, saving serial number as be64 to keep the right byte order.
Also use format '%016llx' to show the full serial string to avoid
to drop prefixed zero.

Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
then we can get the same SN string.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/nvme/target/configfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..6404b9ce09eb 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -996,8 +996,9 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 					     char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
+	u64 serial = be64_to_cpu((__force __be64)subsys->serial);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%016llx\n", serial);
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
@@ -1009,7 +1010,7 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->serial = serial;
+	to_subsys(item)->serial = (__force u64)cpu_to_be64(serial);
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
