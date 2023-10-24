Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4619AC07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JOgUmZ/i7NH7todrPk6yq7t2rzG1HndUdq8MJVPNGQg=; b=jlmbhI0YfsdHgBAZoN7+s3zUng
	xbsLCPoEWNsz+Szd0XvYEVoVW3ClWEUBVFei7HpGUdTdBVOBCR4RFlpG32P1PWlErga/qX/kwKcFe
	ICk3a4DnMfo2uSegJMj05wTQFv2iTKvL1TXVBHGZSxkAjI/FgyY1NM6dAuwuMQzxIO4dFsJZ36yZu
	QrdxHyuXqzLRS74BURUO1TtrkKz7+Bs7poPGgPzVblWBibRRWfcR5PLsm/RG+0iU5z8eZ+egNqf1f
	r33kgyIz9Zjyc4wcEWrJwi+l6UjU87HLFz+EI9kWbiqwb9KLkARCKH977lVZRyboYwHo5kKczPauH
	mJmaxX7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvIF1-00A6tm-0j;
	Tue, 24 Oct 2023 14:18:43 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvIEx-00A6tT-33
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 14:18:41 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9be02fcf268so662005066b.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Oct 2023 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698157116; x=1698761916; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOgUmZ/i7NH7todrPk6yq7t2rzG1HndUdq8MJVPNGQg=;
        b=qe4sKZITVpAXEKwQA1P+6rTix5ugWW0ykGVEaxjvaUo1o2zdINzjd473WDwpRU2pDh
         fsRK0MQ+jk4axmYsE7TjCCZbxYsK/+LQkkgSEcfcFW3Rjc0BenidO+J3SVrEYwa2Yf7A
         xUtIRvCb3aULqnOzuGGKmi5nU9jRY84nUr2uUK02FjSNVwyg+Um/81JrTWdInlBBLcct
         JJ11ST8Hlcmc8n8Hgp5O+ef4WqnZUcBZhh9EoY+yQu5V1RfPKadDm3R0UdDiY3B2mXlp
         SNpE7QmsR4uNxNNB63kBWE6KXE7BQLm3vo5pRaHepkA+VEUTLMt8EASXmMozVOx0Gnxc
         oRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157116; x=1698761916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOgUmZ/i7NH7todrPk6yq7t2rzG1HndUdq8MJVPNGQg=;
        b=ud6hhZ8XGZrsItYMqFq7mFOyvzyjpdS2q16O3AkEV/PiaZuJ1fxv0uLw43F7xJhixa
         z7qw9rRmHrCBJjspzzld7XY63drDlQz0b8qfohhrnKGf3no7qxHOkQng7On8YWqGPYsg
         umRf5++CheUkPyrwJa2FxVz9UntR8aK2dtABVaew31EutSQ7vQ0A3b4cH1wAUIPNvoSd
         3nq+nwQ9XOmzfh9rRgkbYKXSxKa0/PPaQFk0bmc1N0wg4mo6mL9BpITMa2dH5kEawxPi
         NevXFAT0OGDtfrBdsysqre+E4vz2xe+rDfQfByGT7eoo724LHvPEMY8z/35cFo1jtiIl
         Dbkg==
X-Gm-Message-State: AOJu0Yxy6tFZj9Stn2w183HakTUIK3eLbA4cBmhCosabjShO5Djhfl2U
	IfJcdUM1YQjDlfqJVnfyoZc2Hw==
X-Google-Smtp-Source: AGHT+IEfPX8HDxSh3u8WyrY3nPgo1Z+3/Jd8JTRXkUQ5Qt3roDlGxpW/xl03NSdnJ+FV1PgOJ72iZw==
X-Received: by 2002:a17:906:c156:b0:9b2:c583:cd71 with SMTP id dp22-20020a170906c15600b009b2c583cd71mr9509494ejc.50.1698157116191;
        Tue, 24 Oct 2023 07:18:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009c657110cf2sm8356351ejb.99.2023.10.24.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:18:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:18:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	imagedong@tencent.com, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v17 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <ZTfSOv0F7licIO6Y@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125445.2632-2-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_071840_184146_3649EC3C 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

Tue, Oct 24, 2023 at 02:54:26PM CEST, aaptel@nvidia.com wrote:
>From: Boris Pismenny <borisp@nvidia.com>

[...]


>@@ -2134,6 +2146,9 @@ struct net_device {
> 	netdev_features_t	mpls_features;
> 	netdev_features_t	gso_partial_features;
> 
>+#ifdef CONFIG_ULP_DDP
>+	struct ulp_ddp_netdev_caps ulp_ddp_caps;

Why can't you have this inside the driver? You have set_caps/get_stats
ops. Try to avoid netdev struct pollution.


>+#endif
> 	unsigned int		min_mtu;
> 	unsigned int		max_mtu;
> 	unsigned short		type;

[...]


>+/**
>+ * struct netlink_ulp_ddp_stats - ULP DDP offload statistics
>+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
>+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
>+ *                           for offloading.
>+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
>+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
>+ *                         Direct Data Placement.
>+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
>+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
>+ * @rx_nvmeotcp_drop: number of PDUs dropped.
>+ * @rx_nvmeotcp_resync: number of resync.
>+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
>+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
>+ */
>+struct netlink_ulp_ddp_stats {

There is nothing "netlink" about this. Just stats. Exposed over netlink,
yes, but that does not need the prefix.


>+	u64 rx_nvmeotcp_sk_add;
>+	u64 rx_nvmeotcp_sk_add_fail;
>+	u64 rx_nvmeotcp_sk_del;
>+	u64 rx_nvmeotcp_ddp_setup;
>+	u64 rx_nvmeotcp_ddp_setup_fail;
>+	u64 rx_nvmeotcp_ddp_teardown;
>+	u64 rx_nvmeotcp_drop;
>+	u64 rx_nvmeotcp_resync;
>+	u64 rx_nvmeotcp_packets;
>+	u64 rx_nvmeotcp_bytes;
>+
>+	/*
>+	 * add new stats at the end and keep in sync with
>+	 * Documentation/netlink/specs/ulp_ddp.yaml
>+	 */
>+};

[...]


>+++ b/include/net/ulp_ddp_caps.h
>@@ -0,0 +1,42 @@
>+/* SPDX-License-Identifier: GPL-2.0
>+ *
>+ * ulp_ddp.h
>+ *  Author: Aurelien Aptel <aaptel@nvidia.com>
>+ *  Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+ */
>+#ifndef _ULP_DDP_CAPS_H
>+#define _ULP_DDP_CAPS_H
>+
>+#include <linux/types.h>
>+
>+enum {
>+	ULP_DDP_C_NVME_TCP_BIT,
>+	ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
>+
>+	/*
>+	 * add capabilities above and keep in sync with
>+	 * Documentation/netlink/specs/ulp_ddp.yaml

Wait what? Why do you need this at all? Just use the uapi enum.


>+	 */
>+	ULP_DDP_C_COUNT,
>+};
>+

[...]

