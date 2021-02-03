Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787BC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:10:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF2964F78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF2964F78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ma+IZlZphufbuUqgalRjGbxbElkGyyoYE6AbU7bIgyw=; b=3XzEm0ZxRNZ5/RXXh45UELJfV
	hJ3jhJvISpLmp6La6/hVN4QhRXIzEjqdGOorO5tH5nLFcQwN+jaPJw2+SwNA0v+piVNh8V8B3VVBW
	YRTrRtfw2RfI7XNYBR4c9yRZhhtx6IqbbUdGy6B8eYjuihIhn2DkJJsvtr1Bs0vmbByHIknH+Dw40
	+2raV6JGvcbWZK3J0uCL/f1lQ5btWvVXwPIA2vV1GWKQtqsBib0/VZSkWC73alg/cC3vjiT5rVUoW
	ZGJcTceLvTU+YsrRg6r1EJjyoiZBnrB3uedmKtnPclGUG0VvgSfNLfCf40VeJO4lyg5414vrXKviN
	kwMDmHdTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EAk-0001Wp-Tz; Wed, 03 Feb 2021 09:10:02 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7EAi-0001WC-Lr
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:10:01 +0000
Received: by mail-wm1-f51.google.com with SMTP id w4so3433339wmi.4
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 01:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GIkMvk5fpP11LMmqzTDCQwFaHl4fPOWxWWNgSZyfsm4=;
 b=i4D8sCotfbTSyO58eN2znZc5CoFvDFZsPcMi+MNavEcV+UWdq+mr2x5oFFgA0aL/2j
 zZzxt8KcXivBmhEx9mcrJWJH4Gmv6uYitq4zfhMHGdp0gm+ZUS8tWrPVKkoK9LkOhM2B
 wBGG/02RCtsQzBT/ZaAyzLhZNc0UHHomeWh1Ei0tn4Ze6df3eU4x4DKrderncFWlMcrs
 8Ww1obTphWHXewxLkR1z+QCEEbOMNwSJwYKTFWLnm6OY/ylDCRwCMrQSIqWOuUC9HH+y
 vDk5lQMAvyZzTlF+tpTei025e5Mp+MjN3Ah2j3ekkOgESj0g+Mhi7y3VFhgBzgRPxWpH
 lVUQ==
X-Gm-Message-State: AOAM532bcjtY5IhFrfURnPK6PThCGh3aKcreG6xnmg9AWuZ0rcahHPcX
 nWm/2MhvS0JYlbLZMr0fKYI=
X-Google-Smtp-Source: ABdhPJxpuFjQy8/emxvC0hNLUySLUdOkBItSo0a2kIJhYBKWP2sbWk5DJj2LPDp/lOWfTKqYlPuWDw==
X-Received: by 2002:a1c:2311:: with SMTP id j17mr1847680wmj.38.1612343399190; 
 Wed, 03 Feb 2021 01:09:59 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id o124sm1929593wmb.5.2021.02.03.01.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 01:09:58 -0800 (PST)
Subject: Re: [PATCH v3 net-next 09/21] nvme-tcp: Deal with netdevice DOWN
 events
To: Boris Pismenny <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org, 
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-10-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c864eb96-18ea-21dd-3ef3-15ca908c5959@grimberg.me>
Date: Wed, 3 Feb 2021 01:09:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201100509.27351-10-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_041000_771311_4EE7F711 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -2930,6 +2931,27 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	return ERR_PTR(ret);
>   }
>   
> +static int nvme_tcp_netdev_event(struct notifier_block *this,
> +				 unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct nvme_tcp_ctrl *ctrl;
> +
> +	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		mutex_lock(&nvme_tcp_ctrl_mutex);
> +		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> +			if (ndev != ctrl->offloading_netdev)
> +				continue;
> +			nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);
> +		/* we assume that the going down part of error recovery is over */

Maybe phrase it as:
/*
  * The associated controllers teardown has completed, ddp contexts
  * were also torn down so we should be safe to continue...
  */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
