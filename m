Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:28:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E18123B87
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18123B87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uPJoBThmSnhx55c16+3HhXrmjSPkTW1Ba48uOEDgVS4=; b=VXtar3fxT+eouYoj+d8DxOdCI
	sGwD11uklffdwLl08VrKCUc6BjhmHt/gmqRXJz6Y1MCiyyYyF9gwgXTw+f562rix+xboyW9GQPQiW
	JrWgODiQQeJsiAsWnEnix6CyT6pskiH2fOUR6b0X0XEopLpo6DiAWe95jMqL9m0sVzloT5kyE9gwF
	lUoIQoCSuPrtte1U38RB4gEDHmS91g3kuvKhqIpLb7xqUd/cu0/APzeaK1wpm3qTxiJ2OBr1yON6n
	BvNTL4CYLIPf/UUqTcuyHGHTOPFoO8tR8hySwxN4k3C+4v/GG/ItXkRE6CT6r6WdP38hdjypW9uqf
	rTNCTKL6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmupl-0004KM-Ic; Wed, 09 Dec 2020 08:28:25 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmupi-0004Jm-J7
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 08:28:23 +0000
Received: by mail-ed1-x543.google.com with SMTP id h16so600797edt.7
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e8QZINavBB+VN0BfW8HfHmWCOR61uj5ZPA6hU0CJ8os=;
 b=NA0LpKd/sD2TvFZBlYixgWzBT4oOGML6kPm8hfY8UtbZkBlseGfg4qAjhOtyq0QsPG
 yj/0F6ioKwt5FQrvewSrV5KEV1FEH2gvTLueO0cQLLNPyLng7ByxfyfbdehhDMQ8Bshe
 uxlGlnrkqPjSoprK/mMcVCXd+2ck1QNm4rQ7WbjSOrLcl01LQaqSr1ksatmKh+zs0pQH
 QYqCBva46mbIIVfkyLK6IVM2ZJc6DktG98c0tSecfCGWtpyBab1K3VbKBOxSlOnRQMWf
 V3Pud5xVZI4tIe+/OA/Yt15gS9BvmZdiDWY7KhMpgJ3L61tlheBq+jfDcJ1wGXfzZHrx
 RU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e8QZINavBB+VN0BfW8HfHmWCOR61uj5ZPA6hU0CJ8os=;
 b=SOcivjl9NXIXdDlXhoUa3nR8R437zY3aB/R7mzkAAJ9gBKcCDtDM8K1Ll7h4Ea+UXr
 DmEFINHFFQAlJ0JnZcXKWArQybOMhvMTiB0LjiGo+0LaRsfTRCpoJohTWjkuvFL43kXz
 17fH/LDMAqCQ6S8HiFapEusmmp2daPY7Xk6elDUhQm4I8Vzgtx19CdBqjqrUJNW2rO/o
 pMzhPG5rVt8lk/8S5IM8UHFy/0U9Y8yRjDNRFvtBhDXYe/LyC+JWVHBUZ6wb4eUXPGPz
 xTQcWF2EErSCs90PtMBxqrQPZqI+qM9cKJBbrr3+kXQ9FbQ6FMh22s6Zc0j/nF48z9GZ
 7mMw==
X-Gm-Message-State: AOAM530eVNcLiDaN9rxHVw1D/ANncvJB+WLT77TDDuVkWCYNp2neY+lY
 feFimHuvMdIbnArvjoZ9N6Qe5gXJZxhKBw==
X-Google-Smtp-Source: ABdhPJwMkh/XlynfS2KRt9tBI2gAsr2j9vIID5puVy50RBn5AyKRLomhINUagk9lcTkEbau2l0gIeQ==
X-Received: by 2002:a05:6402:3074:: with SMTP id
 bs20mr933047edb.365.1607502501274; 
 Wed, 09 Dec 2020 00:28:21 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id ck27sm855428edb.13.2020.12.09.00.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 00:28:20 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <824e3bea-60d2-5a4d-e8ce-770d70f0ba37@gmail.com>
 <474d1275-9506-99d3-4f0d-86b482953eee@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <cda4323c-b7e7-05a5-e8d4-5a5b91aef784@gmail.com>
Date: Wed, 9 Dec 2020 10:28:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <474d1275-9506-99d3-4f0d-86b482953eee@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_032822_699832_ED408B89 
X-CRM114-Status: GOOD (  12.86  )
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




On 09/12/2020 3:11, David Ahern wrote:
> On 12/8/20 5:57 PM, David Ahern wrote:
>>> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
>>> index 7338b3865a2a..a08b85b53aa8 100644
>>> --- a/include/net/inet_connection_sock.h
>>> +++ b/include/net/inet_connection_sock.h
>>> @@ -66,6 +66,8 @@ struct inet_connection_sock_af_ops {
>>>   * @icsk_ulp_ops	   Pluggable ULP control hook
>>>   * @icsk_ulp_data	   ULP private data
>>>   * @icsk_clean_acked	   Clean acked data hook
>>> + * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
>>> + * @icsk_ulp_ddp_data	   ULP direct data placement private data
>>
>> Neither of these socket layer intrusions are needed. All references but
>> 1 -- the skbuff check -- are in the mlx5 driver. Any skb check that is
>> needed can be handled with a different setting.
> 
> missed the nvme ops for the driver to callback to the socket owner.
> 

Hopefully it is clear that these are needed, and indeed we use them in
both driver and nvme-tcp layers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
