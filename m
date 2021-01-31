Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59822C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 08:44:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FCE64E24
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 08:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FCE64E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1lvo2OHfuUREWjRTSychnXLQwQzN1U0Zi+YJ3PDtBMg=; b=lvAX5f6CZsGPmDbahR3pmn2Dj
	yc7LyOzOsjWKqCFwb1g51mF53HA1paykGsvQHKGfMk6RPZpdCXh4jEOKDBkB6mjuiKiARzuwlQLPa
	VBEolqma079Ghs2MQV5PfILC1FMRGF2xMMnCqWktwAlPD0ozqyjGRv4xtQsmOZTK0EF+2C9uEXmxL
	mOF5o5FildPTJfO+7fc5Or7UgVC7unx6vdg17ucpC1yldPJ17ry/UhTrOXL7CGTAZxJPOT2K6EeUM
	QuTdwQjVtCDUCJJygyca8t1aZr8eS/h9g2HfA75RzAg5Ca99Jtqj5TEpGREGe2stryRvl1061MnDz
	/eJEazf9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l68LG-0007ot-RE; Sun, 31 Jan 2021 08:44:23 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l68LB-0007oQ-6h
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 08:44:19 +0000
Received: by mail-ej1-x636.google.com with SMTP id i8so2964683ejc.7
 for <linux-nvme@lists.infradead.org>; Sun, 31 Jan 2021 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eaHIpYN9GWFnXbaCKJBt41SCDrRaQhQO2OFHIC9TfAM=;
 b=owu4XVs7ehxw5ghy+hoTFu4XjsXYxhRKVWs+x7oM4wzlD+QmH+ee5pVu5JGVXapQqK
 pitL3o92oQyaHrAYzgTkTdPiB43wFvtW1fjde9YS2QjjM6tnDKEFvDzoUw019RwlJylC
 1EriYGHHyBEoJDOpubRX4YBQ3thGiLFyQCUmt+9ZinirdsulwJ1Dfz1mc+oFdjDzrBPI
 dy5ZXM9TVizYnu4vs25aAbp46fjYmRJdjPeYI73d+yhLpHfvsLsLAnEsnhCkTgjbHK8N
 rn/m9LZtO9Njk9WwqwdyL2n1ZkM0mWCMONfJyZUIcXlUXLDGmtycZqcsfh4/jlGLohRg
 /rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eaHIpYN9GWFnXbaCKJBt41SCDrRaQhQO2OFHIC9TfAM=;
 b=WaUBH4+MZSoLdUd0bi5oKi/EPz9EsfpKSNuq+K3ybH7qpF/DK1RZpxnLzNhb7thGFQ
 bErdBhYEIDysFlA9E8eDNRiSrTE8pSV/IiCQXDWjkif0tK67bjaKIln3nuDS1r1mlK1c
 cZBfwNjCEQdoE2HEOxEcftl78HRXWODth9jSIdXDousdR37Zk6Pg4+C2vM4SQQ9uBAkx
 tcjDZyB4q7BRYkU41+xE5WYEV2zstLQ1PTLYaNmaC5IS1xNZrzjSwg3yQxV1KoKvyC7F
 0vFGZFhS2YguGnZ3kStmnmgDMQkRXzUHR4l7k0uIa4RxqHRXWZmijyhHxqLoVpOwbBKU
 lX8w==
X-Gm-Message-State: AOAM530E6XRUhgW5EOqpGfB8zulJdhBRBTBxr+MxxUAtrFT6TOKO2cy4
 Sxf8rPdK2O3A5Pkee5JugL8=
X-Google-Smtp-Source: ABdhPJxnyORbxckz4zNdup1CruQd7Nwbm4xWOVc9FEXYZwn6GCAB185O3OiO/DjCaZZVyy/xPJDntg==
X-Received: by 2002:a17:906:b51:: with SMTP id
 v17mr12465673ejg.8.1612082655988; 
 Sun, 31 Jan 2021 00:44:15 -0800 (PST)
Received: from [132.68.43.126] ([132.68.43.126])
 by smtp.gmail.com with ESMTPSA id i4sm6153469eje.90.2021.01.31.00.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Jan 2021 00:44:15 -0800 (PST)
Subject: Re: [PATCH v2 net-next 07/21] nvme-tcp: Add DDP data-path
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-8-borisp@mellanox.com>
 <84cc2af1-22e8-abf5-07da-bc7b4a2b6b12@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <419231da-615c-10c5-7c98-7e049ac54ee7@gmail.com>
Date: Sun, 31 Jan 2021 10:44:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <84cc2af1-22e8-abf5-07da-bc7b4a2b6b12@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_034417_337111_995B041E 
X-CRM114-Status: GOOD (  21.02  )
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



On 19/01/2021 6:18, David Ahern wrote:
> On 1/14/21 8:10 AM, Boris Pismenny wrote:
>> @@ -664,8 +753,15 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
>> -		nvme_complete_rq(rq);
>> +	req = blk_mq_rq_to_pdu(rq);
>> +	if (req->offloaded) {
>> +		req->status = cqe->status;
>> +		req->result = cqe->result;
>> +		nvme_tcp_teardown_ddp(queue, cqe->command_id, rq);
>> +	} else {
>> +		if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
>> +			nvme_complete_rq(rq);
>> +	}
>>  	queue->nr_cqe++;
>>  
>>  	return 0;
>> @@ -859,9 +955,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>  static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>>  {
>>  	union nvme_result res = {};
>> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +	struct nvme_tcp_queue *queue = req->queue;
>> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>>  
>> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
>> -		nvme_complete_rq(rq);
>> +	if (req->offloaded) {
>> +		req->status = cpu_to_le16(status << 1);
>> +		req->result = res;
>> +		nvme_tcp_teardown_ddp(queue, pdu->command_id, rq);
>> +	} else {
>> +		if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
>> +			nvme_complete_rq(rq);
>> +	}
>>  }
>>  
>>  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> 
> 
> The req->offload checks assume the offload is to the expected
> offload_netdev, but you do not verify the data arrived as expected. You
> might get lucky if both netdev's belong to the same PCI device (assuming
> the h/w handles it a certain way), but it will not if the netdev's
> belong to different devices.
> 
> Consider a system with 2 network cards -- even if it is 2 mlx5 based
> devices. One setup can have the system using a bond with 1 port from
> each PCI device. The tx path picks a leg based on the hash of the ntuple
> and that (with Tariq's bond patches) becomes the expected offload
> device. A similar example holds for a pure routing setup with ECMP. For
> both there is full redundancy in the network - separate NIC cards
> connected to separate TORs to have independent network paths.
> 
> A packet arrives on the *other* netdevice - you have *no* control over
> the Rx path. Your current checks will think the packet arrived with DDP
> but it did not.
> 

There's no problem if another (non-offload) netdevice receives traffic
that arrives here. Because that other device will never set the SKB
frag pages to point to the final destination buffers, and so copy
offload will not take place.

The req->offload indication is mainly for matching ddp_setup with
ddp_teardown calls, it does not control copy/crc offload as these are
controlled per-skb using frags for copy and skb bits for crc.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
