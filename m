Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86249C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 04:36:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3895320848
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 04:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3895320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H71geEZX2usNsXLvNH9l/e7SI0fnW4dPIW8bIC3bdto=; b=N8LmzhnEypTVgE1LJBbX6WAQS
	Np1GUvcnYIecKHIIlynoSmPLibY7pluANnLy7MnRHEp69LdqH5bBaacA6MkC6LPnFbzzHvx/RLR0Y
	LyRQ22oSrhRI78c9/eJV7Ff4d6eyUOkyUe8ti7iu7RwDVffX4XG8jUpsQxba/7MqHnTxOV+SDETID
	Hh4QprjYyB/BkzMFn7CNc1nTkMBZuRJ2+L+he6I9YvE2JWQKpwpTgrOkTuvNL88XNmW36tzDAXAg3
	nNYgip2wLRvddEvlhhC5sI0aTFyorYnhqfJ+iRVbkSKoc8Sw8AQpKf5X2kWvrs8Pybqe5sXir60ti
	Xo9XFlB4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1iku-0004hI-NF; Tue, 19 Jan 2021 04:36:36 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1iks-0004gt-Fq
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 04:36:35 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id r199so280017oor.2
 for <linux-nvme@lists.infradead.org>; Mon, 18 Jan 2021 20:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z8iuKXvAL3hk6T2BINpw09rjR9nNUS884dQZyC6NSz0=;
 b=SyHHarU0HY8cvkXgB90ADPjGAHf07yG0s74BO+I5+WMCu9O5MCdkpel7GkVHhfiJ2F
 AktTg3ebG4itRtbcqv2GBeWBILv0IBgC4D2Owv8WrKBMxJBD6IuABfFoa5wWQzdKTHx5
 Qz6CnJ4Kx275F1DB2clfKUzPi4spXLvv211u1D70n50Vce+h1VCdHLb2uxCkpST/gRll
 Gu5OKAbs7YoZoRrl4TxdPxovDbEXLVKcQzSgsHwKTo0WDINX3c8jZwaAGMBSsXg7Ah/j
 JQsdLwKJAM9YfA79eY0t4PSqh7hEyVEbegqu3NSbyB5y9an8gbWTfJn0xARBsOHhrlns
 nnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z8iuKXvAL3hk6T2BINpw09rjR9nNUS884dQZyC6NSz0=;
 b=r+SSRTTI0tIcFyHAEniOGmN1jS9WOfiFX+Pm4uN4rqZ5Fa+QCGfBB73diY6yWm2ZlI
 xL2fGSLY4ppXc3SCs/JqlupNVZzvBCzWHWlj1uxgbIKU/H+elfjJ++J2Sxn6ZbK2A9rn
 G/cN8Qc6Mc9s4ZASrDNymgKr8RcHg0QTCOc6IkHDBkjLQ0V0HNUCNhwbXVHEbAZNYOaP
 w1dOapregZSNgbpCRcmpHKzxtqwaO0JLMEK3Cm1jv4xDUDxkhnfNzK3rQhN2z6QYKlnV
 W2XLAxjmIrNDg+xuTpHNl13vj1f0COiuTeOhW8ED1rOdN+Arca4h/XNBJ0rj2Mi4xcTN
 SOnA==
X-Gm-Message-State: AOAM533jnr7rEjrJ7GI8OoRn8XGUSC0Tr4ngIpVMZM+uqkhnqjfGCg7o
 ak5DcIm4WlylSu+xziYFDQQ=
X-Google-Smtp-Source: ABdhPJxCh8B22KtCBJsK7gdlf5Ac953lET+YJ5p0W5L3QL82Ct/eclsfTJ7dCBr7X+7kz2qiQrf8zQ==
X-Received: by 2002:a4a:eb18:: with SMTP id f24mr1586221ooj.80.1611030992663; 
 Mon, 18 Jan 2021 20:36:32 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.6.112.203])
 by smtp.googlemail.com with ESMTPSA id n16sm4103817oov.23.2021.01.18.20.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 20:36:32 -0800 (PST)
Subject: Re: [PATCH v2 net-next 19/21] net/mlx5e: NVMEoTCP, data-path for DDP
 offload
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-20-borisp@mellanox.com>
 <10c28b01-49e5-c512-8670-bf8332b24b1b@gmail.com>
 <15248743-82bf-4283-d8c6-99f2210e42ae@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2a0bfce0-6226-7b9a-95b1-15f4f1f321e8@gmail.com>
Date: Mon, 18 Jan 2021 21:36:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <15248743-82bf-4283-d8c6-99f2210e42ae@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_233634_548576_E6D58CC2 
X-CRM114-Status: GOOD (  22.28  )
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
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/17/21 1:42 AM, Boris Pismenny wrote:
> This is needed for a few reasons that are explained in detail
> in the tcp-ddp offload documentation. See patch 21 overview
> and rx-data-path sections. Our reasons are as follows:

I read the documentation patch, and it does not explain it and really
should not since this is very mlx specific based on the changes.
Different h/w will have different limitations. Given that, it would be
best to enhance the patch description to explain why these gymnastics
are needed for the skb.

> 1) Each SKB may contain multiple PDUs. DDP offload doesn't operate on
> PDU headers, so these are written in the receive ring. Therefore, we
> need to rebuild the SKB to account for it. Additionally, due to HW
> limitations, we will only offload the first PDU in the SKB.

Are you referring to LRO skbs here? I can't imagine going through this
for 1500 byte packets that have multiple PDUs.


> 2) The newly constructed SKB represents the original data as it is on
> the wire, such that the network stack is oblivious to the offload.
> 3) We decided not to modify all of the mlx5e_skb_from_cqe* functions
> because it would make the offload harder to distinguish, and it would
> add overhead to the existing data-path fucntions. Therefore, we opted
> for this modular approach.
> 
> If we only had generic header-data split, then we just couldn't
> provide this offload. It is not enough to place payload into some
> buffer without TCP headers because RPC protocols and advanced storage
> protocols, such as nvme-tcp, reorder their responses and require data
> to be placed into application/pagecache buffers, which are anything
> but anonymous. In other words, header-data split alone writes data
> to the wrong buffers (reordering), or to anonymous buffers that
> can't be page-flipped to replace application/pagecache buffers.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
