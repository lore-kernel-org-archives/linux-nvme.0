Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A95BC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yol08RyDld8TmY77NxknLnPeISN7NEEjxM2R56apuFQ=; b=vvJ9Fk8IIyyt4O/IU0xNjcXsi+
	o83QIakbBp7I8Kbwv7ow9MKBwRKajrzz1OgwouwOH3VYYdtO61F5y5y8s3VVNpFa8w7we4S7uFSNF
	mKg4XRhI5zQb7Tg0Q7Xn8olfZ1dItnNVg49akoxzf6P50UdrXwPIj2HNRlhrsEw9QRDFknKGqcijW
	QBAruN+bAqjPVkeR7j3HFmz38uvGgBkCmib1HjE8Aqy/IDE0TnWLhWsyXjAmJIxkrzIZ35Oiqaawj
	c7eqqQM6ZKPTWu+Nv/pyWgwFRJEZMI/yHgiFUs/qXvSDhYK6cV0u+qbemR0PCI/mCJqc0A26oOpDP
	/a/7qFJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVw1V-006sD9-HX; Wed, 07 Sep 2022 14:27:25 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVvyV-006pwm-Jy
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 14:24:21 +0000
Received: by mail-wr1-f42.google.com with SMTP id k9so20686110wri.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Yol08RyDld8TmY77NxknLnPeISN7NEEjxM2R56apuFQ=;
        b=WPxC7eBBkfeuS3o1hnYUYAOeuLFqryuR4riO9cYpIGvxS/1NlRt1VMoWjjqFw6UeAW
         px79e9Yz/f4uaRgoQ7Jqx/MGa3jofvp5iFExoesBGgYdfk7DwONuyHXHOm5t/Mn/I5G2
         I5eYc5OZl0xN37oExwcKwRknvnxF3SWJR6Ui6ExoKggyqOIRot1daoVTV0WVgrGofRaQ
         wygWm7edLmJ7ArbEnAovLlc4n6FR3ubmZ7Q9T70BGnfFDn332tMyl3aYi+Y9HQS+ylPN
         jYmijs62mR8lq03+A7Hmx1e4uf7BqreeHvqXt/PbKKOD8oh+zWLHZpO+RAQZygWQYNFT
         xmVA==
X-Gm-Message-State: ACgBeo2fpIowet9UfW0xlX45ZMofTy7OlcZYbsmtCi/W6q3U4fmcg1nd
	9rQCnXY86JrhZN5NwSeFTV7iiSua7Zw=
X-Google-Smtp-Source: AA6agR4D+MohyHQOVDx7Jq1dnBepJOpB29IK4to510io7TClnAI0pIFOmXV13Rs1OKAgGQWQWVg2Xw==
X-Received: by 2002:a5d:4602:0:b0:228:62df:7d2f with SMTP id t2-20020a5d4602000000b0022862df7d2fmr2308919wrq.247.1662560655042;
        Wed, 07 Sep 2022 07:24:15 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm6552486wrt.26.2022.09.07.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:24:14 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 1/1] fabrics: support notify_rediscover connect parameter
Date: Wed,  7 Sep 2022 17:24:08 +0300
Message-Id: <20220907142411.101950-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142411.101950-1-sagi@grimberg.me>
References: <20220907142411.101950-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_072419_691965_734A120E 
X-CRM114-Status: GOOD (  19.47  )
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

In order to solve this, support a notify_rediscover parameter
that userspace can pass us to request a notification via uevent when
a discovery controller reconnects.

Note, we rely on nr_reconnects controller counter, so transports
must not clear it before calling nvme_start_ctrl (fc is fixed).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c    | 4 ++++
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 4 ++++
 drivers/nvme/host/fc.c      | 5 ++---
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2429b11eb9a8..159097e91723 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4814,6 +4814,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	nvme_enable_aen(ctrl);
 
+	if (nvme_discovery_ctrl(ctrl) && ctrl->opts &&
+	    ctrl->opts->notify_rediscover && ctrl->nr_reconnects > 0)
+		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
+
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 10cc4a814602..945844ce64cb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -594,6 +594,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+	{ NVMF_OPT_NOTIFY_REDISCOVER,	"notify_rediscover"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -875,6 +876,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_NOTIFY_REDISCOVER:
+			opts->notify_rediscover = true;
+			break;
 		case NVMF_OPT_DHCHAP_SECRET:
 			p = match_strdup(args);
 			if (!p) {
@@ -1033,7 +1037,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_NOTIFY_REDISCOVER)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6e22116e139..a0139091fcac 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -70,6 +70,7 @@ enum {
 	NVMF_OPT_DISCOVERY	= 1 << 22,
 	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
 	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
+	NVMF_OPT_NOTIFY_REDISCOVER = 1 << 25,
 };
 
 /**
@@ -109,6 +110,8 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @notify_rediscover: Send uevent notification when a discovery controller
+ *              reconnects to userspace as re-discovery may be required
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -135,6 +138,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			notify_rediscover;
 };
 
 /*
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..7bb8837a855e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3195,12 +3195,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		goto out_term_aen_ops;
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-
-	ctrl->ctrl.nr_reconnects = 0;
-
 	if (changed)
 		nvme_start_ctrl(&ctrl->ctrl);
 
+	ctrl->ctrl.nr_reconnects = 0;
+
 	return 0;	/* Success */
 
 out_term_aen_ops:
-- 
2.34.1


