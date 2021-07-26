Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112EC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07B760F4F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F07B760F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RC9j6o6ytxO9r/wR9/MGe/Z4d7dxooqibqUb2/tSKCE=; b=O9/MnMwNctkskO
	U4W49kL+tz7moFkkBh76s2JSkV2Gmel1/uomPoM29GEv+AhgyAMPeBam4Lss1WsPVHtK3Kq/uYP5B
	vTH3UTckf6cH6X3BnZYZ3uRtgMblWyyis1S3CkiOSdbZpxwaNQDb8ytOml8DRiUPfNlYbV3FqBgnh
	t1a6xV0PR1GnC4+dLyauTdsnGa2cdMX5u/dV8f6uyOQu5wKXEnjbEoxLkvNEbKExiIX25qPpCdun2
	GogjV2MU+hkUf8/g9c3G2/tTee5oBWtaz6BcFkiJcSEX0BON2Q6UEwLFhB7vn+ob+xysmZ0GJw475
	GNDuJpjILYKJzc4HXmZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m80aG-00BJ0k-OA; Mon, 26 Jul 2021 13:23:52 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m80Zj-00BIzY-GA
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 13:23:21 +0000
Received: by mail-wm1-x329.google.com with SMTP id
 f14-20020a05600c154eb02902519e4abe10so2004856wmg.4
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YoTT5JSM0KXApnvSxTPPv5lEEtSTHE0jP5EJ2+BXK/4=;
 b=mZSYePYuhUR/H3XVrwsU6Pb4g2MT7EECN5Cfd2yiEbYJ7qmp4aFq18eFxjOlVwMmP2
 kRQ7FUs21J0PgfqMlAAAhIUukxUnMLiuwrt32ICQEAGSS+0HmFrd7l56WAeliPPxlMjx
 /w2NgI7Ofztw49O206jJEC48oVhlZo3bjwq6kXYRSyMJGznu0kUO8k9JAP5p4bYVakIA
 v2pHs9uGvg170OMBHB0Gi6w4oR8LEtgHLGbNOnMDvMNZAB+EbobO7LhAPfK6V9IUpVAB
 zjJ4YHiihD4btVY6jvBIL8gmKDV2neqjmxcToa+7knOKfbABsOLYpnoTZ/Xw/fnqRZRO
 pevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YoTT5JSM0KXApnvSxTPPv5lEEtSTHE0jP5EJ2+BXK/4=;
 b=dFX1YY5xGz3pfAdtexSS77h6R7UWHAvbGmnXZ2lrr5eF+30NYpbc7UdfpHYXGL40Xy
 wmzc9rCf1KS5Kx5IWVRV7ycwr1hbo4VQCqSMeSofk7uIwwEWAReNsMTLn6psbAMo78G2
 oHc0r2gGHh0RU3SOzamd4tPvc27APtAlo8+lu/UtEve8oC+fw5Th6z0tszVjncV5+IZO
 kLipuhwGfvByTc3Czy7h6QnZOaqIXt9+bYpDPJQz8B+ZDHa/WToBXep1kU4mU6Owgm/l
 Iyn0lPljdwcfuEXannzYrGutOyA/HM+H6lnqCDSG6YISuGmqUSzWDFVu20kFM8VJWK0N
 MOAQ==
X-Gm-Message-State: AOAM533izqJDvt2bfAHTd+fqeDE1K5XLX0Jj3HZhh4NHJ1QfP27xipHE
 XojFSeCwJduNe+iH94RhCTo=
X-Google-Smtp-Source: ABdhPJxU5jilS297dc5rkI2UEbiBQRYHMTgzJueVTM3EwBDy7lQOv2gWHV/Psmf1QdzuaNGEu/uiDA==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id
 m13mr27309380wmq.31.1627305797286; 
 Mon, 26 Jul 2021 06:23:17 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de.
 [95.90.192.255])
 by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 06:23:16 -0700 (PDT)
From: shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Date: Mon, 26 Jul 2021 13:22:21 +0000
Message-Id: <20210726132223.1661-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_062319_586757_85597A2C 
X-CRM114-Status: GOOD (  11.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

In the platform with a limited backup power supply, devices like NVMe
SSD does unsafe shutdown.

These two patches address this issue by adding a power loss imminent
flag. The platform will enable the power loss imminent flag if the
platform's power is running on the limited backup power supply. During
the shutdown, the driver checks this information and pwerforms the
abrupt shutdown.

Shivamurthy Shastri (2):
  PM: introduce power loss imminent
  nvme: Add abrupt shutdown support

 drivers/nvme/host/core.c |  7 ++++++-
 drivers/nvme/host/pci.c  |  6 ++++--
 include/linux/suspend.h  | 28 +++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
