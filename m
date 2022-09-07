Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F0C38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8zX0EEv4M1vWRQaBV61e2vv0QkXHAJVjadQsyqCzZtE=; b=ezpUOh68v2Boo5Bt1QOb8b26eX
	3yhw6GA58YlzmzdbPOhTk7HXOqCXA8b9R5YVbuRmhypGw5V7CleZ+LzAB1iTAUcF64qZjcMFVBErc
	YGUhORlL/Wcs5t2e8aNzkGYyjNqIoy0OLoyclrmjvNHXudqKQ1BMNEDRtLGXSSb/M6NeBAv1HQVZR
	uIlBkDCKj9HTM2SPfg6/NcZ+I7EbDEihlr14VmqiXy2KsBQyhLvZe3K5Lr0HtuWW0kl/2EhknMYHB
	niOlq89mhqs3HdT2XFx32ItN4kDUdnj6qzIPWMYYs4vfGmaEWEdQ6xhg8B19n3BnvhllIK0CEjbc/
	191cchBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVw21-006sb8-3t; Wed, 07 Sep 2022 14:27:57 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVvyW-006pyl-6O
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:24:23 +0000
Received: by mail-wr1-f45.google.com with SMTP id c11so16428222wrp.11
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 07:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8zX0EEv4M1vWRQaBV61e2vv0QkXHAJVjadQsyqCzZtE=;
        b=hPr6OVEwVGb4w5YNuklE2OFqBg4kVu6WrykjnPKYjgdCfT8m4O2EfGhPlC4cvRrWCg
         LdY7L+5x60KEzjoy/vLPw6QvoU2ap+LgJQlY+DqE5pK+XTkppRpC0Egu8LvzJ8OlPwcu
         XIvqkhjC4b6woy6tdNZ800L1czbvUsUTaR2TM0YjuVtbtjReod7Rtg/DZvlq01fXjmGV
         EU6K+Gtb/5H5Mi9yHa6M0qWmrgwl3BzMzaqnWbIH8HhQpCrSKDp6lMJlGH8qvZfjEFMJ
         OpQfnQFY92hiV4Rkx5Ns9OGPwZPVNwwKx3dHXRxIkAa+ZAbwYxToSAW64aXiXlJX4N+s
         OEPw==
X-Gm-Message-State: ACgBeo1eUyPuFF4GmNEGw8xALuY2MZq22PEyoH5cQAtIjL8aVoRNicxl
	PALKor8SP7inonW8YbB0NiS8Lmr5fyY=
X-Google-Smtp-Source: AA6agR5P9jfMFAJwS+RJNUOohc4X/lWSH9VoOEBdsEQVc8y4ObMdfHPRUnbJ2lSI5QDsax6BS13spw==
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id a8-20020a056000188800b00222ca41dc26mr2184231wri.442.1662560657244;
        Wed, 07 Sep 2022 07:24:17 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm6552486wrt.26.2022.09.07.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:24:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme 3/1] fabrics: add notify_rediscover parameter
Date: Wed,  7 Sep 2022 17:24:10 +0300
Message-Id: <20220907142411.101950-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142411.101950-1-sagi@grimberg.me>
References: <20220907142411.101950-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_072420_309064_6A51665E 
X-CRM114-Status: GOOD (  14.03  )
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

When a discovery controller is disconnected, no AENs will
arrive to notify the host about discovery log-page changes.

In order to solve this, add a notify_rediscover parameter
that we can pass the kernel to notify us via uevent when
a discovery controller reconnect.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/fabrics.c | 3 +++
 src/nvme/fabrics.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 678ca2af2561..b49bc2eda965 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -214,6 +214,7 @@ static struct nvme_fabrics_config *merge_config(nvme_ctrl_t c,
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, hdr_digest, false);
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, data_digest, false);
 	MERGE_CFG_OPTION(ctrl_cfg, cfg, tls, false);
+	MERGE_CFG_OPTION(ctrl_cfg, cfg, notify_rediscover, false);
 
 	return ctrl_cfg;
 }
@@ -481,6 +482,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 	    (hostid && add_argument(argstr, "hostid", hostid)) ||
 	    (discover && !discovery_nqn &&
 	     add_bool_argument(argstr, "discovery", true)) ||
+	     add_bool_argument(argstr, "notify_rediscover",
+			       cfg->notify_rediscover) ||
 	    (!discover && hostkey &&
 	     add_argument(argstr, "dhchap_secret", hostkey)) ||
 	    (!discover && ctrlkey &&
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 83353a65c5d7..377475a690f6 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -40,6 +40,7 @@
  * @hdr_digest:		Generate/verify header digest (TCP)
  * @data_digest:	Generate/verify data digest (TCP)
  * @tls:		Start TLS on the connection (TCP)
+ * @notify_rediscover:  Send uevent notification for rediscovery upon reconnect
  */
 struct nvme_fabrics_config {
 	char *host_traddr;
@@ -59,6 +60,7 @@ struct nvme_fabrics_config {
 	bool hdr_digest;
 	bool data_digest;
 	bool tls;
+	bool notify_rediscover;
 };
 
 /**
-- 
2.34.1


