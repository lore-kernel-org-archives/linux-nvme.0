Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7DCCA5538
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1IJ6dOeSQoal459gpLXC+2pZvArZBH8dyyX/X+2VWdY=; b=zZgGH1rXN/5A6aZI97oXmGERYJ
	69Qwh3sgzkHk49eALiiFMYDVaJIpn5nR1LCgSdsqlp33wQEVtKZ1i0PJ3pqoDMonOwGpE1bSMgLJH
	JllZz8aEREuRzSKMGMhOYtoW/aDRfPbg2u0ESQ6yK28gY8nqSWVaWw1V+xftcdG/Q5ZHXGI/D+VYw
	MzVhvbqZH2wV4aNEF+YdQzls3rW+O16PVRlRQcZfY+1cAVCbkJ5lb4fK4D/BSGHsBWkZOHGaFmx5T
	FqvXShlbgRb6i2XKgq8Lz9+Xw1EaG2ZU5wVoyAzJbk9l0IdMbJy6GV4ecytouUWAwm4iCw7pcxwXl
	XKIclKcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNOa-005e9V-24;
	Wed, 13 Sep 2023 10:46:56 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNOX-005e5H-2m
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:46:55 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-402ba03c754so18977925e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Sep 2023 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602009; x=1695206809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IJ6dOeSQoal459gpLXC+2pZvArZBH8dyyX/X+2VWdY=;
        b=qIxj5Ul7UVEbfN/N/JXp2DvNLdOwMUDYeEO2d/vIPXQrPvidb5m/OUqKrnpwvJ7slg
         YqcxfCDbCJQ5WpbmoK86jgZuhQUskMe3YXfXtCYUfBSlFQDv4tT+50QkBgVUYqopL2oB
         jdhFI6WnbzBSrEitDjrtTeyxEmx+E/fYa92mkFh6ehXsuYj79PLTR9rZM2nD9FfGlLRd
         suzmTgeJWV2oar7UDZ4z6y5IUM7INqhaDr/l3I/rrd0OmIlYdnDJZHpxlTGueeYfBK2j
         1+pL4txCOMbkSxkHFk38YzF98NwPGNgRdV9Ke2aM2JOgHIfJs/NN+srp7KdkeYYNmk7x
         mMRw==
X-Gm-Message-State: AOJu0YyI76y31oniYNT8jbtO1EGip/svZZm/SFlTnvfqDO0cQ4jHXhsE
	ruWA2NKmUDcRW8lzHjGernc=
X-Google-Smtp-Source: AGHT+IH2xOZSOHu8J1Ac+kKC8FBAG+bM0DPd11pNU5K57bzQAl5oNX9Zq4Lprv8v0XpO6EmutdKEWA==
X-Received: by 2002:a05:600c:1c86:b0:401:d8a4:17b0 with SMTP id k6-20020a05600c1c8600b00401d8a417b0mr1724095wms.2.1694602008981;
        Wed, 13 Sep 2023 03:46:48 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fe4ca8decdsm1657334wme.31.2023.09.13.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:46:48 -0700 (PDT)
Message-ID: <93a30515-c85d-3942-29d9-ad6bb0e869e5@grimberg.me>
Date: Wed, 13 Sep 2023 13:46:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
 <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
 <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_034653_904959_AA03D68A 
X-CRM114-Status: GOOD (  26.51  )
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



On 9/13/23 12:10, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +             nvme_tcp_unoffload_socket(queue);
>>> +#ifdef CONFIG_ULP_DDP
>>> +     if (nvme_tcp_admin_queue(queue) && queue->ctrl->ddp_netdev) {
>>> +             /* put back ref from get_netdev_for_sock() */
>>> +             dev_put(queue->ctrl->ddp_netdev);
>>> +             queue->ctrl->ddp_netdev = NULL;
>>> +     }
>>> +#endif
>>
>> Lets avoid spraying these ifdefs in the code.
>> the ddp_netdev struct member can be lifted out of the ifdef I think
>> because its only controller-wide.
>>
> 
> Ok, we will remove the ifdefs.
> 
>>> +#ifdef CONFIG_ULP_DDP
>>> +             /*
>>> +              * Admin queue takes a netdev ref here, and puts it
>>> +              * when the queue is stopped in __nvme_tcp_stop_queue().
>>> +              */
>>> +             ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
>>> +             if (ctrl->ddp_netdev) {
>>> +                     if (nvme_tcp_ddp_query_limits(ctrl)) {
>>> +                             nvme_tcp_ddp_apply_limits(ctrl);
>>> +                     } else {
>>> +                             dev_put(ctrl->ddp_netdev);
>>> +                             ctrl->ddp_netdev = NULL;
>>> +                     }
>>> +             } else {
>>> +                     dev_info(nctrl->device, "netdev not found\n");
>>
>> Would prefer to not print offload specific messages in non-offload code
>> paths. at best, dev_dbg.
> 
> Sure, we will switch to dev_dbg.
> 
>> If the netdev is derived by the sk, why does the interface need a netdev
>> at all? why not just pass sk and derive the netdev from the sk behind
>> the interface?
>>
>> Or is there a case that I'm not seeing here?
> 
> If we derive the netdev from the socket, it would be too costly to call
> get_netdev_for_sock() which takes a lock on the data path.
> 
> We could store it in the existing sk->ulp_ddp_ctx, assigning it in
> sk_add and accessing it in sk_del/setup/teardown/resync.
> But we would run into the problem of not being sure
> get_netdev_for_sock() returned the same device in query_limits() and
> sk_add() because we did not keep a pointer to it.
> 
> We believe it would be more complex to deal with these problems than to
> just keep a reference to the netdev in the nvme-tcp controller.
> 

OK, Seems though that the netdev and the limits are bundled together,
meaning that you either get both or none.

Perhaps you should bundle them together:
	ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
	if (ctrl->ddp_netdev)
		nvme_tcp_ddp_apply_ctrl_limits(ctrl);

where:
static struct net_device* nvme_tcp_get_ddp_netdev_with_limits(struct 
nvme_tcp_ctrl *ctrl)
{
	if (!ddp_offload)
		return NULL;
	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
	if (!netdev)
		return NULL;
	ret = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
				ULP_DDP_NVME, ULP_DDP_C_NVME_TCP_BIT,
				false /* tls */);
	if (ret) {
		dev_put(netdev);
		return NULL;
	}
	return netdev;
}

And perhaps its time to introduce nvme_tcp_stop_admin_queue()?
static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
{
	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);

	nvme_tcp_stop_queue(nctrl, 0);
	dev_put(ctrl->ddp_netdev);
}

