Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D1C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:06:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1847239FD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 01:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1847239FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jZjvCY6EI8c1LLRQ1XDpjiw+Jde40HaacQAE9HmW7FM=; b=PWFkAjCZUaQK11jCLSdCDCY1/
	O3qPacb6xa9J4v/MoW0b/7OLx+qFCdVTzzzFvTcqiVY1pENdxelyDgmmfgbx4eSlKMCBWMDwISs7Z
	dr0kwytbCVhnMmEEJfhGc06eApdD2Q6lAl7Qb9rjn7I/p5LmKPpp9D67g8+pH6/l25bLQkJMKPkd9
	cyY64+SXSM+iaAfVjTlLF+jKM2MMxALltPH70GZ1y6gxel5G8xgfwKUcRQ5t113Lh9KMmqQT5KqrZ
	kU/7cAHw5WnpgFz7nlNCChBGypKAR00fnZugLnodCzoK2kt+aWIIsSY0GHSjbHIGkgQAvIdoVLrci
	qvlrhbWcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmnvk-0001mW-GT; Wed, 09 Dec 2020 01:06:08 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmnvi-0001m3-TK
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 01:06:07 +0000
Received: by mail-oi1-x244.google.com with SMTP id d189so68131oig.11
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 17:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l8AQDCReSWYO7mGJNo1DnhG491pzv61j6dUQU/cFOe8=;
 b=M64FGG+eRC1O2Tlg+MJPE5Ke58QKCfq5qXZA053nxDrcgrYnUUu62wiSA55dn1ceK/
 WnrqY/D4aMjsGKjTXEuJRpfpyldvTipgNmSZdGg6BaxNCLcjD2IBPPWeNjuz8e3Zs3fV
 /CxsLKl5WbDL6QWch2zWoC49ITvxcgWvfGpPsSswP7thCVzduUUHvvACHcBuB9FJJCdb
 W9Es7VzatAiGBSch/N2LgWjzKsknfEOWBBgMPMj0It+38MXpE+susyLlJLzJmv/nRwLe
 QwSw2rjoJKCDU85QEGyZ1RAzLzMNGug1rqEFYxWBWBf9sWhfCG6y08JpUhcSe6kUxPUh
 nrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l8AQDCReSWYO7mGJNo1DnhG491pzv61j6dUQU/cFOe8=;
 b=Pq+k3i13Qa1Xmj+V0P+2yImLwy+9/MACIvxWqthOd6cSgB/p34up0JlKZs1wNJX190
 /6Zy+NgctuL5Qg0h0PRZ3PjiDlwkwH1FSB8bfUPbZqLZwu0Avq45YEZ7Sco3Zy/8IJmG
 VMJNkRPEsRtb9LPVRNYPZCHn2j2LaslWIISosQlpF+UkYlQLtbQRdrAC00WOVzp3zLBV
 zBj/VDfoZ2jsEAUgfAAYzJrrBMcNuTix8Eln3fcO7HcOOD0ZF27cSolXnsFiLqxmMrXN
 1H1EzavfHusDwRDZwQCB5qQsKqV3YYtRnE8325wBha6ZKuvmzVbQJw7LjF8el7LDHWd/
 aJag==
X-Gm-Message-State: AOAM531qu1lp/S4qc1DFwONmgSlz3i4moN95Ydtmtw5wg6z8DoHkESYK
 qEE453CbhQTYs7GD4QFLvxU=
X-Google-Smtp-Source: ABdhPJz1/hcIshzh1zSLKvSeT9W/cjpORYGMBgCrgYLiqTLae6n3p/fmlXuu6/5sxkiCAPOasVrH5g==
X-Received: by 2002:aca:bc03:: with SMTP id m3mr118783oif.106.1607475965086;
 Tue, 08 Dec 2020 17:06:05 -0800 (PST)
Received: from Davids-MacBook-Pro.local
 ([2601:282:800:dc80:64fc:adeb:84f9:fa62])
 by smtp.googlemail.com with ESMTPSA id u15sm3693oiv.28.2020.12.08.17.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 17:06:04 -0800 (PST)
Subject: Re: [PATCH v1 net-next 04/15] net/tls: expose get_netdev_for_sock
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-5-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <f38e30af-f4c0-9adc-259a-5e54214e16b1@gmail.com>
Date: Tue, 8 Dec 2020 18:06:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207210649.19194-5-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_200606_971328_3B6B6ADD 
X-CRM114-Status: GOOD (  22.36  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/7/20 2:06 PM, Boris Pismenny wrote:
> get_netdev_for_sock is a utility that is used to obtain
> the net_device structure from a connected socket.
> 
> Later patches will use this for nvme-tcp DDP and DDP CRC offloads.
> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  include/net/sock.h   | 17 +++++++++++++++++
>  net/tls/tls_device.c | 20 ++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 093b51719c69..a8f7393ea433 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2711,4 +2711,21 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs);
>  
>  int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
>  
> +/* Assume that the socket is already connected */
> +static inline struct net_device *get_netdev_for_sock(struct sock *sk, bool hold)
> +{
> +	struct dst_entry *dst = sk_dst_get(sk);
> +	struct net_device *netdev = NULL;
> +
> +	if (likely(dst)) {
> +		netdev = dst->dev;

I noticed you grab this once when the offload is configured. The dst
device could change - e.g., ECMP, routing changes. I'm guessing that
does not matter much for the use case - you are really wanting to
configure queues and zc buffers for a flow with the device; the netdev
is an easy gateway to get to it.

But, data center deployments tend to have redundant access points --
either multipath for L3 or bond for L2. For the latter, this offload
setup won't work - dst->dev will be the bond, the bond does not support
the offload, so user is out of luck.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
