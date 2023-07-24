Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F61C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERI1mbTAFPSVFu55VrWRm74nSyomQrTooYpm5NsLBFo=; b=YUpDrZbjmAAa3PXs4PmytQ+NRb
	2rIXTs8obGpX6B/YQwDIzprmv3Qlqx6W/GyRJgWcHl/vruYQdkFjUeKLI/HdwzptAkGvcTwfPMG22
	75g00Ny/gn6D8cXDitD97MTLgovIFcCdrvznS0FhRT6gPSfkeKbTPmzxzcaRaTnEEnxJABJaYXHMm
	7nD9WbMsu7LPTi9IfylfVxSVkcnI+Q6Ieq62l5PIaUCjBXgfATO8T5jt6JpjHmdXR9xiyntSvRW5N
	9C1vyMgpm+yyuidblEvTOvm8PYyiJ2KcaZqAI1Jb3kh3gE/ZUNFv/LOMz2r59HScZR4QzmhjekbO/
	f+3ph9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk2-003Nlb-05;
	Mon, 24 Jul 2023 09:20:34 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrjy-003NjC-1K
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:31 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso4493295e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190427; x=1690795227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERI1mbTAFPSVFu55VrWRm74nSyomQrTooYpm5NsLBFo=;
        b=ML5D7SF0wHZ6kfnRPRx3gQs7CD9roSa0LGBkcKSPdPnUF9O5+bG8F00PMd4thui+0J
         mr5bvybI+T09jJNYO9/0Tgo7KMTuxnK8r9KWBdKcba2C9abKSuNMMMHyQFvFpwO+Ec/T
         VrTARY1MhQZ1p49oJb2NQJmPi1arB9a3JC5lUaxt9PttVh7QGYG7FKJRR/G4pC2OHR63
         5D8mNNqJhXTH3dmGHFX/vaHDAwQlHaZMIP0jjCIs+hFP6XBc+93WsgTpaO7s9k3voalw
         VBmvNHGLP5y943ay++ICxzc9IxHp1TlMLy37lzYYgDmHYVhWKv4xv09UPQh00WEzjxt3
         VVkg==
X-Gm-Message-State: ABy/qLYMCm8h/pig4rTIjP1vG2OEbe1nVqfkn2AtWe2mM6h1lxqiqakm
	Y7fyIjmfWF4MfuaxJ6oHG8L/dz3SPok=
X-Google-Smtp-Source: APBJJlFM3jp1W+ZSUo44JNQ71QcNx1FrWxltCJZAWw2aucgPEhIEvT9hD/SY6OZNcY7OFmZzd40/Ng==
X-Received: by 2002:a05:600c:4f8f:b0:3f8:efad:31ee with SMTP id n15-20020a05600c4f8f00b003f8efad31eemr1486714wmq.2.1690190427219;
        Mon, 24 Jul 2023 02:20:27 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 1/6] nvme-fabrics: add helper to resolve ipv4/ipv6 or dns name
Date: Mon, 24 Jul 2023 12:20:17 +0300
Message-ID: <20230724092023.708335-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022030_472540_1B52F4FD 
X-CRM114-Status: GOOD (  13.74  )
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

Allow userspace to pass in traddr as a dns name as well. This may be
useful for a discovery service that may have a dns name, that may also
change in time (with an updated dns record).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8175d49f2909..fadd25538d1b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/dns_resolver.h>
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -1133,6 +1134,33 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
 
+int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
+		struct sockaddr_storage *traddr)
+{
+	char *traddr_str = NULL;
+	int traddr_len;
+	int ret;
+
+	/* first check if traddr is ipv4/ipv6 address */
+	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+			opts->traddr, opts->trsvcid, traddr);
+	if (!ret)
+		return ret;
+
+	/* second check if traddr is dns name */
+	traddr_len = dns_query(&init_net, NULL, opts->traddr,
+			strlen(opts->traddr), NULL, &traddr_str,
+			NULL, false);
+	if (traddr_len < 0)
+		return traddr_len;
+
+	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+			traddr_str, opts->trsvcid, traddr);
+	kfree(traddr_str);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvmf_resolve_ip_address);
+
 static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 		unsigned int allowed_opts)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 82e7a27ffbde..603d8d176168 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -222,6 +222,8 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+int nvmf_resolve_ip_address(struct nvmf_ctrl_options *opts,
+		struct sockaddr_storage *traddr);
 void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
 			u32 io_queues[HCTX_MAX_TYPES]);
 void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
-- 
2.41.0


