Return-Path: <SRS0=bdbJ=OZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D06C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 04:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D68561130
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 04:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D68561130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uivkJtitUdAT8WajPKKx9azA/8tAj6Xuy72XGcFQFcw=; b=3orSucQsfkHGD6
	5Bnj8Q+TZtUMie9Ro74pBrotO9q4P6ziahx+y0oO671pEuK5+uxGCUr8snzqVAFgcUYUA0gQ6hr3S
	M8V8joLDb0zrKVp1YcSsQ331q0oiOYII1ikzcc3yiEdzWZkfGBFcNGcZb3MamoIgELacc8qnVAueJ
	lHuCI3qKTbOmlAmozwtK+on0hQSiA6s+E4UVgHiKnPVSenXYeY4S2cUbYjjhfnXcDC6VYn1u96ckv
	qlTibzLVDXI+hG6DaTD+HYiNo3QCZXFnQgZxA45coUtbo/LJ2rhmK+Eo25CteV2LpPNAX/yYkyCpm
	+nDXUrCETW8NnnMsNcyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXcSB-008v8E-MA; Tue, 05 Oct 2021 04:53:23 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXcS8-008v6S-TF
 for linux-nvme@lists.infradead.org; Tue, 05 Oct 2021 04:53:22 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 oa6-20020a17090b1bc600b0019ffc4b9c51so978482pjb.2
 for <linux-nvme@lists.infradead.org>; Mon, 04 Oct 2021 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+lpcd/dIjLX1XzfbWfSb6TmisR3YFI0hYoc80N7VkYY=;
 b=BhgqGB8g17r5OxfsHfDIYnO7ToRyWkNnL85cxRnFnizGIRfe/9x8l5X5hU8nKLz+ZY
 HsFPQ61tW8MntttqiVH/xXzvFYuwzs8KyoEF0g53UkB2pkqB4Ph82wcd6EdUYb0JGFwy
 bps2xyQHAbImvP851z8re3BufkUhXRoDgfVxQhNCGNgHFtFEwK2NGTNEA4M7VqyM/NS2
 mQyDtwOxhoPevOjCFyu8pJcqm4crd8V6mFO9VwtYq3HJV3jxk8QAJmO1OpsJpjFXaGhK
 LYpvl9Jqs2zxkvnd+L9gsNk+xvugMpBJI65MErYsaJ0NBzvTJGMLOxbwpSUTE3Ol50es
 mpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+lpcd/dIjLX1XzfbWfSb6TmisR3YFI0hYoc80N7VkYY=;
 b=0Dm6Bbb/M/xyi4nlmg7wSgls3ZmrKSIQE10ZSw3uV5qRaHSylDI8gcethHOo4Wd02Z
 u0c3fqLzE4ADXejqHjJp8e6in0wcWkjvk9ZcGapbTR3HHHMcCpb4333P0/8khcwC151A
 G/1DO/myxh5fKkSMjM9rMflc+GlZgWgykpoBkamLr+cwYVpDaPwsimRFYvX+JccIsqN1
 vZTj3ut2UXnY8ljJGN3NZ6q3cvAPVLU0oNLU9s1Qlk6JYLjJRIR8QIo5J5FoN0MwBaEw
 1tK70pnxgX1ATxG55GI4xaY4ZmEiue03ImakUS4KzEQon3CFiUjn+kq35rGvqQqyUOuN
 mLWw==
X-Gm-Message-State: AOAM532E9it+3NGeyKcdemvj38XHkOSeTL/XoM4MszhFngDO3+GPKba2
 dtdCbRA1Y6vXc3B04PemYa5Tm/IMlnclJQ==
X-Google-Smtp-Source: ABdhPJxiLyKrha7hOr7TSfdw329+HXtI4TnawBipdk6FTVxXB+3vU6ujtzp9sRk8CqcgD+7vQP8FvQ==
X-Received: by 2002:a17:90a:29a6:: with SMTP id
 h35mr1331262pjd.188.1633409596779; 
 Mon, 04 Oct 2021 21:53:16 -0700 (PDT)
Received: from unconquered.home.aehallh.com (24-113-252-168.wavecable.com.
 [24.113.252.168])
 by smtp.gmail.com with ESMTPSA id g22sm19006046pfj.15.2021.10.04.21.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 21:53:16 -0700 (PDT)
From: "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
 "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
Subject: [PATCH] nvme: hwmon: Do not create min and max values when not
 supported.
Date: Mon,  4 Oct 2021 21:53:06 -0700
Message-Id: <20211005045306.1429931-1-zephaniah@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_215320_967375_3FC24B64 
X-CRM114-Status: GOOD (  13.89  )
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

The Mushkin Enhanced Pilot-E 2TB (MKNSSDPE2TB-D8) provides a composite
temperature, as well as the over temperature threshold and under
temperature threshold settings for the composite temperature.

However for the 5 individual sensors, no over or under temperature
thresholds appear to be available, any attempt to access them results in
an error.

At the moment, that means that reading from or writing to the _min or
_max files in sys (as lmsensors does) results in an error.

That isn't horribly user friendly, and we can detect this situation at
initialization time.

So in nvme_hwmon_is_visible, for the hwmon_temp_max/hwmon_temp_min case,
we now attempt to actually get the threshold data, and if that fails we
return 0 to indicate that the data should not be made visible.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
---
 drivers/nvme/host/hwmon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d712920..063f8aaddcd5 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -164,6 +164,10 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
 		    (channel && data->log.temp_sensor[channel - 1])) {
+			long val;
+
+			if (nvme_get_temp_thresh(data->ctrl, channel, (attr == hwmon_temp_min), &val) < 0)
+				return 0;
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
-- 
2.33.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
