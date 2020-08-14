Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB99C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4973520838
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PXqEtD/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4973520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L3FkcQT9LABaKe+TArwi3+Bx3yZl+c3G01COWeB+6qk=; b=PXqEtD/BwR+DTxYF8/ysX/DIh
	vOipCJWWdWkhy/OJM6HsMeMyXRA/I9NS088hc+XdYQRgUP2tGLeGYJmQ631/6W8WImFf7x5W/zDKA
	xqGUcM6zffDi9RVK3e1wGA4ayznsVC1IwUcbV4yMysPLTRBNW0w4Piwkekp+oqmckknSETrwjSgIH
	1SjcE70dVWOsJqX/yjvVv1UcEOQVL9273nb1eSL8yoPw9Ma/tKYnOreqfV4ICmIB5EC1w3PGrZDdD
	yKxfuNY7vYATywk9A2lQD99jkXrRBO702ZU2zwBWplukUbVPU/KBTKMkgYPeqn7uIJUI0qRQBsPwG
	qL7oNdw1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6T3E-0002N3-9F; Fri, 14 Aug 2020 06:18:52 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6T3B-0002LC-Dj
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:18:50 +0000
Received: by mail-wr1-f42.google.com with SMTP id f1so7342489wro.2
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fkvwug/VO+u7rU47Q5KeM31qbswJBkBpuvEWIweLbLE=;
 b=VeqmClBD/r+YT4tJjD3Iguy/mbAKH2RkEPsyWkh7Tph4vyYZhI6dFZ5f+f7DQiiQT+
 aduofdCq0g/auUqoGDFe8ac6/G1x+x4UB54wMW1KMCJPXLBY0FT60aSMch6eqvY9ZECj
 ntFdoxXPXtMgP1v24/UFoibIknENryIkvguYD5a/F0mGOt0DfKJpPS/+LJyleBEELNnc
 tjqR6Z1lQmvexCRPomuK56DH1F1MGc6bEP3mGunZmMVaYMYPjoc/jgly6g7gmCb91CQk
 8US0sQ2W6PKSlPmEm4rS+5S9DjAh1NFRc2VzfVnHre+369u05msLRZvX4KJZKMzoBZwG
 zI/g==
X-Gm-Message-State: AOAM53110dJwfZJ1rJFAGzgAnOqRmzJtFP5YbIY1xRbpiytPSjhoBNub
 o+hsFO4HAHjyJOhrrgAsf8dMk1YBmNC4qw==
X-Google-Smtp-Source: ABdhPJzh+p2rJPZXyETcVugnSNR99EGJ34rWwyZXkl7amLOpQ0WGTd4OEpu/Is1JAghTMJy0PwnAvQ==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr1201235wrw.365.1597385928029; 
 Thu, 13 Aug 2020 23:18:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l21sm12278131wmj.25.2020.08.13.23.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 23:18:47 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v4 5/7] nvme: support nvme-tcp when runinng tests
Date: Thu, 13 Aug 2020 23:18:13 -0700
Message-Id: <20200814061815.536540-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_021849_496254_B02BCD8E 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 306a12440c20..3e97801bbb30 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
