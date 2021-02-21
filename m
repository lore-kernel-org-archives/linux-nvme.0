Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3699C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 11:29:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC1B64F00
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 11:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC1B64F00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7J8rDHipRu1GBrsg+bVNYb0IwPUTb07hLEdSCcmt3Ak=; b=CeE3iUbWtmmBj8yreh+R6ovBk
	LuPOu+rAKzfs/39wEOJKjnGvAfVRuCUmLrmyf/Tk1pQRpMjL53TxeK0VymefxrQMkjloXF7/ok+Ui
	Oh+yrkdQDGVbEh3Qd2MWvC55ZM85nYVKaL5nLOeZcZqmmredB5P2reyglD7p06DHk0S/gtWNsHalg
	gKKk3NtyVpojr3TYuaOYGlmL/cAAATfb0ydVlMC1aI1X0diBJpNQmcqG11ebfxMM+vEZ1cQ9PexIs
	8NW6F8tilRlhBUz0HnGmb5M4u5vvxHpmtNfmom7TMreoN0wd5qn2nPTlnx4IoNUTbrGAcvSm+xCt3
	2mg0Z0/mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDmvt-0004qp-LI; Sun, 21 Feb 2021 11:29:49 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDmvq-0004qI-AK
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 11:29:47 +0000
Received: by mail-ed1-x531.google.com with SMTP id q10so18189314edt.7
 for <linux-nvme@lists.infradead.org>; Sun, 21 Feb 2021 03:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NkqLH2iI4TGIsYEyVAwIq/vBaQt2ewB722xv9p5GaH8=;
 b=NVXRFqEWEExByzBwj7i9f834L8MsUCdcmvojkY75wdVpyoTFjKqBDhT6JmUq23R9nY
 UkV8/eAXs3jNZE0haptV7Ajct4s/a8Ewk5MQvLt3ebe3rLcjm3a5Insg+tnPTOeKakuS
 MrxTCTEU64ZZAb37iwpT6AAZu1j/OAl3g53UAC4QR4J0Vtm/maqI/IC3xfsoMQy3RGct
 atgIBrALiN6+mA5qAxu3v7at2kN577Z6o7okxXWhs+VOogtjQzwfEWsCemF3u/CfsCwF
 qofU8Fhkxvx1AGFX1orVris6c9m/83bM1TMkfCRDKN6CTY1aQZenK35EbLAlQXbG1eOg
 hr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NkqLH2iI4TGIsYEyVAwIq/vBaQt2ewB722xv9p5GaH8=;
 b=GWLgt3niqC8MBFIY/sexQ9FxCGyZMYrqaua8pMayjTwszWMQCpQK5fCU4lWrY0+0So
 FsiCQ9xiM3KWqQtvB1Y70spSs1Sk6Syctpi7Tk+1cXZWO6y9qMr7wYAX2JlOrcbcNxOV
 f6Y7LonXR1/v8TCQkIYPKG3dqKjA7seg1CFS+YZ0QQeAj1JgnG3jMj4DmBccocQjG6/u
 +NOMxoWYotzQhJ0RvGL/cNgy/Bi7MYBSQZOtZgNLJ/S87dpGVxCQ+iPSs8ZYNcY1yBRb
 +K7Tp6eT+X+9T+xErITHGm3aqLxG3DcdBNMEJcr2skDr4KIAIGLJIdp5N+n2za1dTKGQ
 gijA==
X-Gm-Message-State: AOAM532HRVHfJUhqVT+aKYrYaWz1Jbczop57yQvlX4NmA58Td3V9nuY/
 TJBTqvN0gkgAGneWvDKpVx8=
X-Google-Smtp-Source: ABdhPJxPPe2ES370m4Jkp1KQ93EluukjDD976InpundPP02BkBdhuQJ5EsOwsIzNx5CZIwtekspfoQ==
X-Received: by 2002:a05:6402:190a:: with SMTP id
 e10mr17851608edz.110.1613906983513; 
 Sun, 21 Feb 2021 03:29:43 -0800 (PST)
Received: from [132.68.43.202] ([132.68.43.202])
 by smtp.gmail.com with ESMTPSA id v9sm8128251ejd.92.2021.02.21.03.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Feb 2021 03:29:42 -0800 (PST)
Subject: Re: [PATCH v4 net-next 06/21] nvme-tcp: Add DDP offload control path
To: Or Gerlitz <gerlitz.or@gmail.com>, David Ahern <dsahern@gmail.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-7-borisp@mellanox.com>
 <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
 <CAJ3xEMjMqK81uNv21poD+DoZCRxYak0DYFZrjDbmWaSxw4R5ig@mail.gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <3f447ef7-3ded-8c1c-fdfa-ec137e11a19a@gmail.com>
Date: Sun, 21 Feb 2021 13:29:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMjMqK81uNv21poD+DoZCRxYak0DYFZrjDbmWaSxw4R5ig@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_062946_467185_A1FBD1EA 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: smalin@marvell.com, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 benishay@nvidia.com, David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 17/02/2021 15:55, Or Gerlitz wrote:
> On Sun, Feb 14, 2021 at 8:20 PM David Ahern <dsahern@gmail.com> wrote:
>> On 2/11/21 2:10 PM, Boris Pismenny wrote:
>>> @@ -223,6 +229,164 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>>>       return nvme_tcp_pdu_data_left(req) <= len;
>>>  }
>>>
>>> +#ifdef CONFIG_TCP_DDP
>>> +
>>> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>>> +static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>>> +     .resync_request         = nvme_tcp_resync_request,
>>> +};
>>> +
>>> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>>> +{
>>> +     struct net_device *netdev = queue->ctrl->offloading_netdev;
>>> +     struct nvme_tcp_ddp_config config = {};
>>> +     int ret;
>>> +
>>> +     if (!(netdev->features & NETIF_F_HW_TCP_DDP))
>>
>> If nvme_tcp_offload_limits does not find a dst_entry on the socket then
>> offloading_netdev may not NULL at this point.
> 
> correct :( will look on that
> 

That's only partially true.
If nvme_tcp_offload_limits finds a dst_entry, but then the netdevice
goes down, then the check here will catch it. This is needed because
nvme_tcp_offload_limits doesn't hold a reference! We opted not to grab a
reference on nvme_tcp_offload_limits because it doesn't create a context.


>>> +             queue->ctrl->offloading_netdev = NULL;
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     if (netdev->features & NETIF_F_HW_TCP_DDP &&
>>> +         netdev->tcp_ddp_ops &&
>>> +         netdev->tcp_ddp_ops->tcp_ddp_limits)
>>> +             ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
>>> +     else
>>> +             ret = -EOPNOTSUPP;
>>> +
>>> +     if (!ret) {
>>> +             queue->ctrl->offloading_netdev = netdev;
>>
>> you save a reference to the netdev here, but then release the refcnt
>> below. That device could be deleted between this point in time and the
>> initialization of all queues.
> 

That's true, and this is why we repeat the checks there.

We avoid holding the reference here because there is no obvious
complementary release point for nvme_tcp_offload_limits and there is no
hardware context created here, so there is no real need to hold it at
this stage.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
