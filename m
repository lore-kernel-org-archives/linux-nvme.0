Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58BC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2T1JKUBQvWM8kl7JF1g2FlMWg5/oMv8p0UcXtDGgk+s=; b=HxahFnLr14sN9oZAbaH6vJN4B4
	hfdLGtOcg+IkOLwZcTxoy/zvY7LH576qMm0GVBFlbyOuN+7V9Yof85RALWpEiQUBcyeO2xELNk13R
	K/jX3TfsVwX9jrAEIv73e7v2AXShE65wzyYndaZBustkcKZ0Ms3jrNXF34N32WMZ0KiQdGCZIv5fT
	Iuq1d50KtqVPkqvdG2MSB7+9yO4xwYS1AzsOumOtsJByzWirhfTQTbPvxJhE/HRC+OxXTWQZ49Zv6
	0IdxEgDnYUxdeoBOxRNGR+Wajbg+alcANiK1kr+khjXBA9Vu3o1YCXvMk5MhRqkry8k+e37gfCrYW
	3+PKyBpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHNZ-00E4VF-KD; Thu, 22 Sep 2022 08:16:17 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHN5-00E4Dx-Vo
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:15:49 +0000
Received: by mail-wm1-f45.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso809165wmq.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 01:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2T1JKUBQvWM8kl7JF1g2FlMWg5/oMv8p0UcXtDGgk+s=;
        b=GOLorUfUq6mhlEh97cP9H2BwcBsnRZ0b2Kl5NvPvpJE8JWfz32a8boiYI5yUc7fSoy
         cw7/NHOD3FAQa3mjOtdRB9VKcsqHkpHVQvqgsL3yulAph+2RVDNTwoNM35SDOtdif5f9
         Fi+DHgmiJjSJbunkDTXG63WhMb2OYOLBgdu4NyBuMK5H44RwQ1vcKgl0T4b5zmzVz0XB
         ElwJpWOyQ1On1O9QSH9rN3agJ09UqGyzrUkSEiXlKWovN9d6Y5jmVmbFiwXGIgY63CZD
         TROPldJgq07R24++PX8zlmVGTA28KedcWJTsiMwRSy2TF/ostBFIDERBZtTikDFPZAqL
         Sr6A==
X-Gm-Message-State: ACrzQf0Kjqv8+UywJlA00YyM8rBR1jeQw4STqZZl5YrN1PbJP4pm+/rW
	CpTKnQmZKO6VYOpZOF/Jdh3/za3hFdQ=
X-Google-Smtp-Source: AMsMyM6srStxIh5zIkVWBkTsR+r9n/0DYQf+qpS53D7cSsRoQkmhH7MfjYp2GVuDiY1m3vhzkpMpEQ==
X-Received: by 2002:a05:600c:3d8f:b0:3b4:aab6:4a97 with SMTP id bi15-20020a05600c3d8f00b003b4aab64a97mr8607876wmb.82.1663834545053;
        Thu, 22 Sep 2022 01:15:45 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t126-20020a1c4684000000b003b32aa0fabcsm5016997wma.4.2022.09.22.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:15:44 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page when a discovery controller reconnected
Date: Thu, 22 Sep 2022 11:15:38 +0300
Message-Id: <20220922081538.13364-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922081538.13364-1-sagi@grimberg.me>
References: <20220922081538.13364-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_011548_078199_89AB29DA 
X-CRM114-Status: GOOD (  12.66  )
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

When using persistent discovery controllers, if the discovery controller
loses connectivity and manage to reconnect after a while, we need to
retrieve again the discovery log page in order to learn about possible
changes that may have occurred during this time as discovery log change
events were lost.

Upon reception of a udev EVENT=rediscover we can kickstart discovery on
the existing discovery controller device node that generated the event.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
index 434cc080ffe3..93e438863672 100644
--- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
+++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
@@ -17,3 +17,10 @@ ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
 ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
   ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
   RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
+
+# A discovery controller just (re)connected, re-read the discovery log change to
+# check if there were any changes since it was last connected.
+ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="rediscover", ATTR{cntrltype}=="discovery", \
+  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
+  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
+  RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
-- 
2.34.1


