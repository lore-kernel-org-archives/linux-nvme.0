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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB29C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:41:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2111D23B85
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2111D23B85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=26a2vKe/b/ixQLts7CLWlui2HfrEO9fkgwMcXYSB/Kw=; b=miJ4ChMaoRUXwU7n51NFJM43m
	k0xG0c6cfB1BIe6+ofpIFTLZ+HDg86lidHEypdydafJxZoaM1MjQZi3aTyWIeVai/segNrhxjr3CA
	9J8JENUyhTVFULeKMKCPjfYKouz8gE3Z/oMPoGXEENxQWg4x9158ugur/yhYukAOWQq9H5uv9OLEQ
	4PW+TEojRG3UkFXhSiSGvDby3uc8cZuFPWjriDFmAZFB4v9UvV4Kvx1prujFI3jfTDlIpdRgavEt0
	IVqb7tnhpdhfYITGb8FqEKO5aB3y9QkcAQl54ktV70eztvM9+0tGgD+JaeFfnh3S1QLZHXDH0mjHF
	4ffPaaKSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmu6j-0003LD-Rv; Wed, 09 Dec 2020 07:41:53 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmu6h-0003Km-EW
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 07:41:52 +0000
Received: by mail-ej1-x642.google.com with SMTP id ce23so680279ejb.8
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 23:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m3421Ub0KlIhhH/zoEz+MDKzqnaht2bd8LwblfeqHmw=;
 b=ICE3NXOe2Ko+onyTU092mQ+zJbo+hr4zXukVw7sqz4iiJHl+Sw3YnnRlQKK3jiTcjo
 qn/JJOuvNb7mXW/U8O3ZZ+GA4eGQXquLNs05EkPtzIIAlEc5K44BLxgmjMBG4XIR35Pm
 IJO+d78IYCWthJnPH2q6Jfh8ehzbaMfaqaKRs/1M2AA0A+ELIqxVIXV8d11rJ5fspaAX
 lzHlxXCevgS02kBwiQO/ITZ6JyxlMEdza8v5LxIMNoUw8uH/1APVRSXz5bNJuU7mFd7D
 W35f1TOZRHU90+my9H4Lc/3Va1y1ZSEWxTpSaqkWxMyInW4UlVhMnWc6M6tUAOWjTmzE
 4YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m3421Ub0KlIhhH/zoEz+MDKzqnaht2bd8LwblfeqHmw=;
 b=EWF+0jRVGZbBqJtGYadLxotIA0tZbgafP4nRcFOfMW21QedRZy0F/3URp94QmTuSvP
 t3ZjtyB4510Y63Pw/VguLh6XxJs7go/V/Hc+Xom7SNMsmpX4Z+E4bb8B45EeDfJNt/hq
 LlRkSxx7S3CGjycnJ828kopFl8vRPoEkED6K1ToFyZ3U7+yIXRTxMNXKJvTsVMFVcP2/
 rjEMm8zMa8cbHqX2H5UHjH8AvKLnaeafYhg97DsEJw2obD6VQQNGkj+sGkg2O02aAei8
 Lx3r2BuLn6KkI8bfASRU1MsN2x+JrtiEovBrOiOyjEZM2xyB7pGxFnVw4Y4GoKdcwtDJ
 v3vg==
X-Gm-Message-State: AOAM533lH9lsri08xvnxvuSDvoT6sUzw0IEfLcYKzY6Ws6mDWs0lZg7h
 qdsA6FYSqnqhThLf3rYygUw=
X-Google-Smtp-Source: ABdhPJw2QBzIT0kIqzNqpVAY/7RNpug8VHJPiMC8/cIPVSIVJm5U7XXWXVwn3BjjuawDspGKpWnYEQ==
X-Received: by 2002:a17:906:5fc9:: with SMTP id k9mr971447ejv.70.1607499708784; 
 Tue, 08 Dec 2020 23:41:48 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id w10sm652592ejq.121.2020.12.08.23.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 23:41:48 -0800 (PST)
Subject: Re: [PATCH v1 net-next 04/15] net/tls: expose get_netdev_for_sock
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-5-borisp@mellanox.com>
 <f38e30af-f4c0-9adc-259a-5e54214e16b1@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <104d25c4-d0d3-234d-4d15-8e5d6ef1ce28@gmail.com>
Date: Wed, 9 Dec 2020 09:41:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f38e30af-f4c0-9adc-259a-5e54214e16b1@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_024151_510205_CD8C44B5 
X-CRM114-Status: GOOD (  21.97  )
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

On 09/12/2020 3:06, David Ahern wrote:
> On 12/7/20 2:06 PM, Boris Pismenny wrote:
>> get_netdev_for_sock is a utility that is used to obtain
>> the net_device structure from a connected socket.
>>
>> Later patches will use this for nvme-tcp DDP and DDP CRC offloads.
>>
>> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>  include/net/sock.h   | 17 +++++++++++++++++
>>  net/tls/tls_device.c | 20 ++------------------
>>  2 files changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 093b51719c69..a8f7393ea433 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2711,4 +2711,21 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs);
>>  
>>  int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
>>  
>> +/* Assume that the socket is already connected */
>> +static inline struct net_device *get_netdev_for_sock(struct sock *sk, bool hold)
>> +{
>> +	struct dst_entry *dst = sk_dst_get(sk);
>> +	struct net_device *netdev = NULL;
>> +
>> +	if (likely(dst)) {
>> +		netdev = dst->dev;
> 
> I noticed you grab this once when the offload is configured. The dst
> device could change - e.g., ECMP, routing changes. I'm guessing that
> does not matter much for the use case - you are really wanting to
> configure queues and zc buffers for a flow with the device; the netdev
> is an easy gateway to get to it.
> 
> But, data center deployments tend to have redundant access points --
> either multipath for L3 or bond for L2. For the latter, this offload
> setup won't work - dst->dev will be the bond, the bond does not support
> the offload, so user is out of luck.
> 

You are correct, and bond support is currently under review for TLS,
i.e., search for "TLS TX HW offload for Bond". The same approach that
is applied there is relevant here. More generally, this offload is
very similar in concept to TLS offload (tls_device).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
