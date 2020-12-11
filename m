Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB3C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 06:55:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D0B23F2A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 06:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0B23F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f58Vg6ceyf631Md9m100nlWdpP4+uX2av3ZH9NPFeus=; b=0YXDjDAF3DZuRhsuLUnYkb/rOs
	n0cLvPcq1Fom8fG86eCsOIiEGqFJhM16UwNkLhLxTRMZdJ6XRRQir4m4KXHZUWusfEu1zX8zkxXo7
	VxDFTYB3ZhDQqgjYJJo8mau+MQGa6mGQQEc1FH4rT0QS9YojHx8lcJlnUwbRa/cecDX9XSYSv8M2Q
	am+5VaCcFUD6vyq4ZiXzB3RDtz3RZyM2Z2PRpWU9PsvUig8LVRxUIYxQX6TAmmfgcKbInhA2PO8SV
	ETVgIGj9gegB6B1eOtiblvgE5dDkh6ClNktW4LGP2/lvRIBLE11YlzSe716vtyMkpaRGKu2gVMyMe
	j7VYgGpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kncKd-00015t-Jq; Fri, 11 Dec 2020 06:55:11 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kncKa-00014s-Kj
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 06:55:10 +0000
Received: by mail-pg1-x544.google.com with SMTP id t37so6496637pga.7
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 22:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PtrdIWHf0l79DvI8uc1Iscj77P/+6pPa3TMd8+VMU9Q=;
 b=ZLsBaj030AG9Jd2Wql+Z67a/Whr7yxh1QxDSlPOvUlzYYAFrseeRVMUf9XDx+0m2Dt
 h37H8qLOaBvDzHqedMPLL7OtLkihWNk8uPpA2Ic+5l3uYgSVzUcAuc8djacrwQfjSsYc
 PwSn0kGuI9KTzsRtA47X82AjIrz6nK9RYxWGVva6GzfC+9pOnA8xIw+OUL/XVNW5gX6t
 QbOPY/DSfdYyaNpmSq5kidYanddewxmfdcbpczC+oRbaTeTpXQplXA+bSeMsEHEyBoDG
 9/5YsYcC7VF1BsgtVUlTOFDxW6YrDjWuEDQ8rtmiS01+M3tEHikQybBZXjKY+so/ryvU
 UnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PtrdIWHf0l79DvI8uc1Iscj77P/+6pPa3TMd8+VMU9Q=;
 b=lXBH4ToSSgRcRceRSUrQUCF4V7SqfqxLFvlIGdWinJhvJTGv2OOngZ5/DEQdiwxICq
 cBEyVEOrtOOnkXRtB+GJOg6yIfzOJm4XaWj7gZhRnetc/1o95duoi+KSV9pNzqd6A90g
 9RGHBCraac7QOJcycwjf0ynJH9SkmzXieJWM/5E1MtoXf2iJs51fMfNpYhPJ1PEgBnaO
 ME7sdsnzitqLUnoi5PdUhvn+3sAWdBVn9glu/ZUgL2eBfaUu/82znQO63uLRVqOpNizD
 aFodHDI56h3mke32l4/eTXEGrcoF/fETkaBv4046/WxEvJUVtX6Yj9T3UhDW66G7yqsk
 NxXA==
X-Gm-Message-State: AOAM533xLZFMOxF/N77NqVdz0wB/QPwunXRDxiS6N76Ki1aRb5nGpdEY
 rZytGE3hd72x52KfVBoT3BIcwA==
X-Google-Smtp-Source: ABdhPJwnuq4yl3DgTCz7YGdMgNP5ou5xBAC1KAsUJKEkSeaV6Wu7QcesQ7TJ6K5XbKGGuA37oST4Nw==
X-Received: by 2002:a63:170f:: with SMTP id x15mr10167670pgl.157.1607669704694; 
 Thu, 10 Dec 2020 22:55:04 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id s29sm8242252pgn.65.2020.12.10.22.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 22:55:04 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH] nvmet: fix mismatched serial
Date: Fri, 11 Dec 2020 14:54:56 +0800
Message-Id: <20201211065456.826822-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_015508_794005_B5C02829 
X-CRM114-Status: GOOD (  12.89  )
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
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Target side uses 'bin2hex' to convert u64 serial number to a hex
string, saving serial number as be64 to keep right byte order.

Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
then we can get the same SN string.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..e7808a86ccef 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -997,7 +997,7 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%llx\n", be64_to_cpu(subsys->serial));
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
@@ -1009,7 +1009,7 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->serial = serial;
+	to_subsys(item)->serial = cpu_to_be64(serial);
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
