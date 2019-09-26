Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06401C432C2
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 00:20:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD25621A4A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 00:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="anlovJuv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdYSut39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD25621A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=b6m86Xi+AqWXGJhszQcuB+yyZ2G2F9SwwUFJktTwMe0=; b=anl
	ovJuvFuhJCchvjmYn3EszUk7R8YpiRqrIzUKF+FX6mpsWFV3Aly8IsDR5ylCUVkUErjEwruqpRvqZ
	n9LZPBLLh3lmqRzeOijI/PKGksBr+QbpvhNq1QXbiiM2Y1a+7lGbJv3JaP5eFxGCoQBuFU9JITjEL
	HP67KVey251ZkdSH5nUpGWMuZPQyAqjgHir3w0TG4Rde7HkoEmouCWc3qgedwK6u9UCPbMloktTh8
	AX5dbRzvHzWzP1B0O4JK35il6N12H45eRMRSGajb4tfA5gIARurAy8tEPDqkhfxxjRIO9Ja08z6qA
	XAzfNa1qcm1VT+dASgxG+Z4TQo5OPKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDHWT-0005Et-BH; Thu, 26 Sep 2019 00:20:41 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDHWQ-0005EU-7g
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 00:20:39 +0000
Received: by mail-pf1-x442.google.com with SMTP id q5so557500pfg.13
 for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2019 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Di8Y3XGb6m/bilxvYyIwXE6JG/tp6MijdClXTqEx83Y=;
 b=KdYSut39j1zaZZV89ZUd55WE1lNp1PAPs+x9ERtxDbZDyfEMOedNtL4P4upqXfFNbz
 OgEOgoxjJPrvBqPdh3a99toy/ESCYt6UG83jtXdrFHl5CNK5qZwVs93yJpxNOArH3o8a
 mBYOLd03P/Y7FVaSthnimu0jX2YFvZqa1sWnZS6au4zyZ8Z6w5gpSJc57EYoMJt+6LLY
 r/jIlk5JDI6UTgBMunSirOqyQ0PYDp/sKGQz0DJSOurJLfYfW26p6D3IN8CzSPHeWXTd
 ZsOq46qLi7jZJH1JIa6S5TcMSvp1+7IQssHwjP7FKPLaLcF3LoNYs4YXxBd08N+BY5Ae
 8opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Di8Y3XGb6m/bilxvYyIwXE6JG/tp6MijdClXTqEx83Y=;
 b=j3ruT4EWZF4wL95l5Rv1GL0InMRfmpYkMfqXXXpDmFT2HFGbVmvGPLqW4uMCv5pySa
 n5w0/CUYmyFymEs6gb8CQKsJcLS9uor2k2eBVrqyUOnHz9xt7zjnxNdrc7hgI4ejau9+
 fZvM6Bfv25PNPee9qvzNHL+DeWF1XaMlmUJsv4Orub8ZadAvV3bLDFA8ZPZgms4Y7Zlb
 RtycxuYOazbzxWtr9qqkHKYCgY1L+vqZNvFYRv5PtqYbY8My2VNyVDmamyNF+aZ02gm6
 7HYrHWV6pSFn06Ngv0GaI3UYhOwvXsD+2uL7+fHG2IQ8e8t6/WxZxm84Oz+0cfqHi2WY
 8qHw==
X-Gm-Message-State: APjAAAVK1vuEmOG7ta44/9wERfYO+uWkvTdwqOdsgj0E3Zv5oedGyN+Z
 yzot7IxzyF2W5TzQIvztQVaGxNvE
X-Google-Smtp-Source: APXvYqxpCCDzMfjb8SyZIr3trtHVis8VnucsxdWW/bQj0Fkp0/lB+CYz2mjc1vJyzs7ulOQTu542Qg==
X-Received: by 2002:a65:5bc3:: with SMTP id o3mr635682pgr.30.1569457237169;
 Wed, 25 Sep 2019 17:20:37 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h1sm168075pfk.124.2019.09.25.17.20.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 25 Sep 2019 17:20:36 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: Add ctrl attributes for queue_count and sqsize
Date: Wed, 25 Sep 2019 17:20:23 -0700
Message-Id: <20190926002023.14033-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190925_172038_282069_87C8ECB1 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Current controller interrogation requires a lot of guesswork
on how many io queues were created and what the io sq size is.
The numbers are dependent upon core/fabric defaults, connect
arguments, and target responses.

Add sysfs attributes for queue_count and sqsize.

Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
  Updated is_visible to not show sqsize attribute on pcie controllers
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e0e2dcbfd05e..d3c85c6d9230 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3040,6 +3040,8 @@ static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
 nvme_show_int_function(cntlid);
 nvme_show_int_function(numa_node);
+nvme_show_int_function(queue_count);
+nvme_show_int_function(sqsize);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -3120,6 +3122,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_queue_count.attr,
+	&dev_attr_sqsize.attr,
 	NULL
 };
 
@@ -3133,6 +3137,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
+	if (!strncmp(ctrl->ops->name, "pcie", 4) && a == &dev_attr_sqsize.attr)
+		return 0;
 
 	return a->mode;
 }
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
