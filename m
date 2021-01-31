Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1451C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 07:51:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A2764E0A
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 07:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A2764E0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zO7Hx6M8i3gZpaWVrggXyJdxh9rd380DFhRgnAfo82Q=; b=j/K52udcEXM/juANho1Fq0H8P
	ADyaWlrBFy0Zu/wzM1O/i3Bwzc33oeh9kLaXq1JS6v1p2RuYEJx+Q21F0m9hdcAoSf4pAUFpTNOp+
	896Rp4HSRTjF7Wdw4+uCDlC7M0oXyxzHcJQpcQ7YFKzzXgv2eDX5WW5cLwPjnzj6xlaNyYSDb22NO
	GYE54c7xb60VUedoRCrqrYgGBYO0Q06+sV00ql064CGOlaA5PcN1f70V2bw4dUASDkVKEsMHvmchw
	e80bCg9rA+T8W6/XDxUuZw6asrAhPT0eWk6/3LL2KWZ8s9rqiojZnDq7m+Vlj5Clb2zsn8A706sBK
	0d5QKCJBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l67W2-00064M-J5; Sun, 31 Jan 2021 07:51:26 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l67Vu-00063J-6c
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 07:51:19 +0000
Received: by mail-ed1-x529.google.com with SMTP id f1so15268416edr.12
 for <linux-nvme@lists.infradead.org>; Sat, 30 Jan 2021 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CZnj9PSGYJvwkHgTiq/VDDFdSzGMKGh7K/RwheJSvf4=;
 b=P9rduIvYflhy/mdiWPslz323bV4GVbUTfNDWGzBu2IAuTQ3wffgW49ATNBY6eEzWnX
 s5Hibxdqa+2+ReBoDUZuV3T5ZJrVXR6oml/KPWYlTeOSMRT3cA0adK6oI18uSVTcgG3L
 HL3mWrdaUk589S95T+b9ar2eypyJmvrWm9Xlqih98NcUsqsfux+3MegNQQJur3CU+S2I
 wPq6nPS14a86FGOk9e8vd9CkLUvS55ffIakDp1bGmmatCOmN20PjTyjG/UkA5qdF/oa5
 ZsWw0jf58sBkeGVb/uLlV88HnwJO+zwUWzOqECYmVVQI53TOswrZXLUPMaY1R1k+P8uj
 3WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CZnj9PSGYJvwkHgTiq/VDDFdSzGMKGh7K/RwheJSvf4=;
 b=jDbLo+ZeYpu5iLny0RyGScv7YUJB3QdXWOx8JYYLvIqXWiNmYrgF9gcIWoqBr9fnv2
 PTWl/xtW/YzWRay0mPVFbI6yaM6S1mWWQ9Dw93UKs30Q3VysvvueflnJoBQqrHt7nOUn
 J9IZ6slNurF6TXXimWcp7XFJIcwV6apRNCBeC30m413JdMWj4jFqxHeYMz8j2Q03YjQk
 pRm+53XT3/U1mscsn0LlMKV5WQTgzJ9J6XCxSKh882ookBo8zD7nSN+ZfxoPHRQ/z5Hf
 WuSN8SwXV5RoryriVGBWwDUxNhQtAby6V9xETobBADyDvLz/GXB/X1eFl+gHqoQk9T6f
 8lYg==
X-Gm-Message-State: AOAM533tNA7HqENC87wKLwMRp3DlAjSS0gwEaFEFxzkwGpD3XPh5Ubu8
 3utWcrXxbUDlzkluPUPzPtQ=
X-Google-Smtp-Source: ABdhPJwXU/dOisJZQ0h2CNK1vEUzVmcvk7WcfPsziaMP9Q2aTVWagnsQw+D+RLq1fKGuazndWuZVfg==
X-Received: by 2002:aa7:db49:: with SMTP id n9mr13450979edt.73.1612079475659; 
 Sat, 30 Jan 2021 23:51:15 -0800 (PST)
Received: from [132.68.43.126] ([132.68.43.126])
 by smtp.gmail.com with ESMTPSA id a11sm6080181ejc.64.2021.01.30.23.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Jan 2021 23:51:14 -0800 (PST)
Subject: Re: [PATCH v2 net-next 06/21] nvme-tcp: Add DDP offload control path
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-7-borisp@mellanox.com>
 <37861060-9651-49c8-e583-2b070914361c@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <c9d06a90-4e7d-b5aa-eabb-63b557b8b5d0@gmail.com>
Date: Sun, 31 Jan 2021 09:51:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <37861060-9651-49c8-e583-2b070914361c@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_025118_394424_CC4BD184 
X-CRM114-Status: GOOD (  23.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19/01/2021 5:47, David Ahern wrote:
> On 1/14/21 8:10 AM, Boris Pismenny wrote:
>> +static
>> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
>> +	struct nvme_tcp_ddp_config config = {};
>> +	int ret;
>> +
>> +	if (!netdev) {
>> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
>> +		dev_put(netdev);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	config.cfg.type		= TCP_DDP_NVME;
>> +	config.pfv		= NVME_TCP_PFV_1_0;
>> +	config.cpda		= 0;
>> +	config.dgst		= queue->hdr_digest ?
>> +		NVME_TCP_HDR_DIGEST_ENABLE : 0;
>> +	config.dgst		|= queue->data_digest ?
>> +		NVME_TCP_DATA_DIGEST_ENABLE : 0;
>> +	config.queue_size	= queue->queue_size;
>> +	config.queue_id		= nvme_tcp_queue_id(queue);
>> +	config.io_cpu		= queue->io_cpu;
>> +
>> +	ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
>> +						  queue->sock->sk,
>> +						  (struct tcp_ddp_config *)&config);
> 
> typecast is not needed; tcp_ddp_config is an element of nvme_tcp_ddp_config
> 

True, will fix, thanks!

>> +	if (ret) {
>> +		dev_put(netdev);
>> +		return ret;
>> +	}
>> +
>> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
>> +	if (netdev->features & NETIF_F_HW_TCP_DDP)
>> +		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static
>> +void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
>> +
>> +	if (!netdev) {
>> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>> +		return;
>> +	}
>> +
>> +	netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
>> +
>> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
>> +	dev_put(netdev); /* put the queue_init get_netdev_for_sock() */
> 
> have you validated the netdev reference counts? You have a put here, and ...
> 

Yes, it does work for the cases we've tested: up/down,
connect/disconnect, and up/down during traffic. It is
unfortunate that it is not trivial to follow.
We'll add some comment to make it more clear. Also see
below.

>> +}
>> +
>> +static
>> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
>> +{
>> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> 
> ... a get here ....
> 
>> +	struct tcp_ddp_limits limits;
>> +	int ret = 0;
>> +
>> +	if (!netdev) {
>> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (netdev->features & NETIF_F_HW_TCP_DDP &&
>> +	    netdev->tcp_ddp_ops &&
>> +	    netdev->tcp_ddp_ops->tcp_ddp_limits)
>> +		ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
>> +	else
>> +		ret = -EOPNOTSUPP;
>> +
>> +	if (!ret) {
>> +		queue->ctrl->offloading_netdev = netdev;
> 
> 
> ... you have the device here, but then ...
> 
>> +		dev_dbg_ratelimited(queue->ctrl->ctrl.device,
>> +				    "netdev %s offload limits: max_ddp_sgl_len %d\n",
>> +				    netdev->name, limits.max_ddp_sgl_len);
>> +		queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
>> +		queue->ctrl->ctrl.max_hw_sectors =
>> +			limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
>> +	} else {
>> +		queue->ctrl->offloading_netdev = NULL;
>> +	}
>> +
>> +	dev_put(netdev);
> 
> ... put here. And this is the limit checking function which seems like
> an odd place to set offloading_netdev vs nvme_tcp_offload_socket which
> sets no queue variable but yet hangs on to a netdev reference count.
> 
> netdev reference count leaks are an absolute PITA to find. Code that
> takes and puts the counts should be clear and obvious as to when and
> why. The symmetry of offload and unoffload are clear when the offload
> saves the address in offloading_netdev. What you have now is dubious.
> 

The idea here is to rely on offload and unoffload to hold the netdev
during offload. Get limits is not offloading anything; it only queries
device limits that are then applied to the queue by the caller.
We hold the device here for only to ensure that the function is still
there when it is called, and we release it once we are done with it,
as no context is established on the NIC, and no offload takes place.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
