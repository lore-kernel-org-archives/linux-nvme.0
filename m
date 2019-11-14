Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470FBC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 15:40:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F63206D5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 15:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HqPFwe9Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNH1sBRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F63206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yTN5G6ZvQwDp3hiCyqxXXQZKj2tD+X/owL6saf6RjEM=; b=HqPFwe9YUl+Fo1
	vpiSYBCV0bfxn3kCzZdrUdIeylsH4vlkxogAjOV/+ScPbqwCFWlLxBRYCGdY+5vS7Y+nInC8cgMhe
	MZc1BugQUx6HhufeJD8k15YdDOnu2CpJsWYoYm+GhC2gQv6cOJ5Mt5FuNzcWT2oMlbvBSMuYNS45J
	loOXa2vrceQvhk3VME2GGlKGJW2NXpNT4En+mb+Q6ro7W5/ahkVnqc7FWDj8XLy0NkSJmnvLyqcFo
	TcNGKaVaawbTxjiSi8gNYrR+NeczJN6j/f1RAp7/rqvPn/aDwu9yMat5LunyttpzjsQmqcZMHPHR+
	mWTVF3N51kOd0OOrEcyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVHET-0006Tm-7x; Thu, 14 Nov 2019 15:40:29 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVHEP-0006TB-KA
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 15:40:27 +0000
Received: by mail-pf1-x433.google.com with SMTP id z4so4471586pfn.12
 for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2019 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gBW+T3fGCC3ZauWE1bP/FEflNLqJJ9otTssyUktVKTU=;
 b=NNH1sBRUCRVOORerPHFQHOlR9e9J+0xIID778YUDlEsiVBTpO0G52T3V/z+niqCe0k
 kpBY3haS+YcDCH4UyxVTHnp2RnJxgZi43SNP1iGChuXsHszki7bV6OByo4QReb138167
 A8Ry0kk8K1zWH4ep0OYVOciJ5MhwqkJ9EQiBCGHqrfSqF16dLRRuSJ03iK8oKqq4JEKQ
 Ycl49nSXnzWvekivKbdO/zWQsMdkTYrkvriixOT6t+wtBVpP0iR+X5IWfpIsRGvUa+WE
 +KbcNqPCmaOFNWti0Y1GIoy7aYVlO4wQ3esO3uNNHawfyzygvvVFixpv8GP8+Zr5A8pR
 PYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gBW+T3fGCC3ZauWE1bP/FEflNLqJJ9otTssyUktVKTU=;
 b=mD98HeVz3yBxnT1G6XSr59t4M9Ty7VoHBR6j+qToVQdf2KgOIS8hEmGl7JGFrsErbr
 vAaxkI7aMgI2NKk1gZUB6TezVD8SXinDdHi6xTpDV9g3sP5RWk/D+weQ/JS9tc0Md4dS
 +WnFM8p5oEWzo/mJkJZJHlNoGKEcKLb+LSonxTDNFF/7bvuXuG/LJaahhA63LkST0yfQ
 SgRiK6fZDpaBdByrJoD9ntnXZebQmaCFZB9AfB2QQvtWvN0Smc1vTOBWJi4Je2rgIHlg
 kkWZkW4aiC8GdeUwpgSW4IWlwpLCXUj+zPM/RlzcbotHOJOHuHAQV+0g1aLhP7nVPAUm
 uMkQ==
X-Gm-Message-State: APjAAAUBCypWc5SOusg+gUcaaaBEy3aibwAn+rDR/fMt6MLeMZ0uEnA2
 XFksD6liRIejOIXdwHdS2dCqxIT9
X-Google-Smtp-Source: APXvYqxvfLOY2clWvMfw944A1oYXSLmN9VRf6ZzB5NV9JeI2XR/e2es+VG3yj5p9pgUhOzZ/sTK6zg==
X-Received: by 2002:a62:2902:: with SMTP id p2mr11215436pfp.160.1573746022668; 
 Thu, 14 Nov 2019 07:40:22 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id 206sm11490858pfu.45.2019.11.14.07.40.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Nov 2019 07:40:20 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 0/2] nvme: hwmon: provide temperature threshold features
Date: Fri, 15 Nov 2019 00:39:59 +0900
Message-Id: <1573746001-20979-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191114_074025_665063_76B3F881 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to the NVMe specification, the over temperature threshold and
under temperature threshold features shall be implemented for Composite
Temperature if a non-zero WCTEMP field value is reported in the Identify
Controller data structure.  The features are also implemented for all
implemented temperature sensors (i.e., all Temperature Sensor fields that
report a non-zero value).

This provides the over temperature threshold and under temperature
threshold for each sensor as temperature min and max values of hwmon
sysfs attributes.

This patch depends on the patch "nvme: Add hardware monitoring support".
(http://lists.infradead.org/pipermail/linux-nvme/2019-November/027883.html)

* v2
- Add helper macros for kelvin from/to milli Celsius conversion
- Remove alarm attributes for each implemented temperature sensor
- Use u32 variable for the last parameter of nvme_get_features()
- Use NULL for the unused last parameter of nvme_set_features()
- Avoid ternary operator
- Adjust temperature value ranges with clamp_val()
- Don't use WCTEMP after initialization
- Avoid accessing negative index when WCTEMP == 0
- Add a new quirk to avoid changing temperature threshold

Akinobu Mita (2):
  nvme: hwmon: provide temperature min and max values for each sensor
  nvme: hwmon: add quirk to avoid changing temperature threshold

 drivers/nvme/host/nvme-hwmon.c | 110 +++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h       |   5 ++
 drivers/nvme/host/pci.c        |   3 +-
 include/linux/nvme.h           |   6 +++
 4 files changed, 107 insertions(+), 17 deletions(-)

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
