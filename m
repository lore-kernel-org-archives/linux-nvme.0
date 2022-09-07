Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF86FC54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwSaZzDBrivUKMI0plmzwXcr1i0v8W//fMbRFSHEHTg=; b=Cc6V9J2fFrsirrCvyQ4QCQEyku
	tFumgJYr+fFaWqBMlxbKCgY9LND+l33WRpixTJc1AAky9bWDvKrUNc5fq/OC4JsgSG42ltsblsD/T
	N9LUECb6R/muhG7cxK8daZjO1tu4aET8nnPstw7PdkpW00hvje2VgJ8FHNHoNLhKk5zKsKi92hSrE
	oNPXxBmDe1T9udhqdWSCz3a4RB2Ex/3vDBqNdIKP8yu+w1ZdNGcKcIt3luH9EuzGe3zrLKax+OL6j
	3JYNADMqFXFHHc1uKxcwQSM/0unrsuHX9f97nmRwoKa/syAGE9g3kPktiYgEp2c3vy9Bt8DHGA/CK
	DKzZu9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVw2h-006szJ-FH; Wed, 07 Sep 2022 14:28:39 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVvyX-006q02-Eh
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:24:23 +0000
Received: by mail-wr1-f49.google.com with SMTP id b5so20658932wrr.5
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 07:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NwSaZzDBrivUKMI0plmzwXcr1i0v8W//fMbRFSHEHTg=;
        b=HHUVDMTFCxMTw+GzBCGfW7H6xzWhQcKdvCFbo/rJFVTFRiP4uM7EeFy3MCd+UloBdE
         LfxzP4rftMYnXoyEPbfhYZimboWY88zHFgg6r3Ek02MIaxj+5xbr2Gygj2AJr/NYv6nM
         X2Fa30D86nwOEj+tAOsM8ZcZyDmB3w6Z37w3a9RfyHAH0TRnXgI0SSw/vcsO6uSitPGU
         kDFAh3NJ38oZvj0IYF2iJ/SAlmBGlY3mmdBRlgrcNhB/sG///LNBmuwT3AQ5UBHA3y2f
         A74trW6YEGaWvVAtB8CHb3RBiif+aPQuJf450Bl12bcGhvauVzwz0m8h7hUuDrTaypvK
         5Tgw==
X-Gm-Message-State: ACgBeo1NcfTPRuYbsrCR0IajV5T4phRfUxuQ5ZpR1CDl9xA5us041UrK
	VhGbBhpe/ITDjZhwW19+DdtgF1YK6xk=
X-Google-Smtp-Source: AA6agR7KGPcYmZEWPwrzu5C1FMUWJyZBghPvO5QoVAeCQliwgtBJtixCbM8sVt/+jZBb/n/zTUxpCw==
X-Received: by 2002:a5d:5a14:0:b0:22a:25be:7f69 with SMTP id bq20-20020a5d5a14000000b0022a25be7f69mr893617wrb.662.1662560658302;
        Wed, 07 Sep 2022 07:24:18 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm6552486wrt.26.2022.09.07.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:24:17 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH nvme-cli 4/1] fabrics: re-read the discovery log page when a discovery controller reconnected
Date: Wed,  7 Sep 2022 17:24:11 +0300
Message-Id: <20220907142411.101950-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142411.101950-1-sagi@grimberg.me>
References: <20220907142411.101950-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_072421_534027_338CB908 
X-CRM114-Status: GOOD (  17.18  )
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

When using persistent discovery controllers, if the discovery
controller loses connectivity and manage to reconnect after a while,
we need to retrieve again the discovery log page in order to learn
about possible changes that may have occurred during this time as
discovery log change events were lost.

So we pass notify_rediscover for persistent discovery controllers (if
the kernel supports this argument). Upon reception of a udev
EVENT=rediscover we can kickstart discovery on the existing discovery
controller device node that generated the event.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c                                         | 15 ++++++++++++++-
 .../udev-rules/70-nvmf-autoconnect.rules.in       |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 43ca5f422d3d..0cb5d9da6cbf 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -144,6 +144,7 @@ static nvme_ctrl_t __create_discover_ctrl(nvme_root_t r, nvme_host_t h,
 {
 	nvme_ctrl_t c;
 	int tmo, ret;
+	bool supported;
 
 	c = nvme_create_ctrl(r, trcfg->subsysnqn, trcfg->transport,
 			     trcfg->traddr, trcfg->host_traddr,
@@ -154,6 +155,14 @@ static nvme_ctrl_t __create_discover_ctrl(nvme_root_t r, nvme_host_t h,
 	nvme_ctrl_set_discovery_ctrl(c, true);
 	tmo = set_discovery_kato(cfg);
 
+	ret = nvmf_check_param_support("notify_rediscover", &supported);
+	if (ret)
+		return NULL;
+	if (supported) {
+		printf("cfg->notify_rediscover %d\n", cfg->notify_rediscover);
+		cfg->notify_rediscover = persistent;
+	}
+
 	errno = 0;
 	ret = nvmf_add_ctrl(h, c, cfg);
 
@@ -390,8 +399,12 @@ static int __discover(nvme_ctrl_t c, struct nvme_fabrics_config *defcfg,
 			if (strcmp(nvme_ctrl_get_transport(c), nvmf_trtype_str(e->trtype)))
 				continue;
 
-			if (e->subtype == NVME_NQN_DISC)
+			if (e->subtype == NVME_NQN_DISC) {
 				set_discovery_kato(defcfg);
+				defcfg->notify_rediscover = true;
+			} else {
+				defcfg->notify_rediscover = false;
+			}
 
 			errno = 0;
 			child = nvmf_connect_disc_entry(h, e, defcfg,
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


