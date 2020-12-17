Return-Path: <SRS0=3eeX=FV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69710C2BB48
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 19:06:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E707239EB
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 19:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E707239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RFXp3kZt7fz23i0NUDc/w1DTqYuyEKwPiacwMBm8jww=; b=VbKoBrqPIKEM/BpMHhIyx/V1+
	deC+ur8NeKgBfNSBBKWiq9GHc9QJA4jKL7TrCiG88rznOGtAfFy6Vg6so/e/K3AnaGwFSzS9RQ12J
	bsw1UQjlI7/03KC2eY9wZ1DM4IrA/JrlQ3F4DvpkE2QjvCCPQMawqEN9rKiRZN6Bb+Z2sLBJTkXZb
	fIg/hQd4yad/JKx08JwnGRKeYhVR5pAZqUEFtj620FzTKssOOgMbePb9qNl9WcMBXL0CzMiSTae1x
	bFsmMh18dQo8z78ARRSfAenrdmJrYJxP6yE39BlH202lYnwbcAZ2Gew1wtYWtkRT1uP/s/YKd3Ze7
	qWuBhwzpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpybr-0003n8-IV; Thu, 17 Dec 2020 19:06:43 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpybo-0003mp-Pn
 for linux-nvme@lists.infradead.org; Thu, 17 Dec 2020 19:06:41 +0000
Received: by mail-wm1-x32a.google.com with SMTP id r4so2747641wmh.5
 for <linux-nvme@lists.infradead.org>; Thu, 17 Dec 2020 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9xOXMrV1b09b1oYGaCiclh8h4mRDmt5ss5YUsRlsRSs=;
 b=ChqeZquFbqUXpddfbgr0CroHca0Xrp3RfKQucTuAeHIwvIw2tD5p3WZ0fejJr3Duar
 CkxuqPE+cAebWoqbu0mmYsavwcdSl93BQE5pPp6MVMvsR4HXjg6GSjUlN/1rWcHGbMx8
 7rVFyLrUMqxyJRd1w+eqXGxXupuvdn+6y9D60whVdm9TY8BXYgWJh3vNkCYZwmRg4l3Y
 13lIJ0382VySkXdXelv1KvKeTLnk++RiYzS71AngTEG8uj8o8lm2QE2XABbm7RROkmlm
 3ZLpZr6A6YCLdoRCVEqgNPMOQ8xyGVFyp4JnVoVVFobleDKD/yi5Mg8OBcqc8PTvgp1s
 M5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9xOXMrV1b09b1oYGaCiclh8h4mRDmt5ss5YUsRlsRSs=;
 b=H8Q9ObAmW8CkndKoAUONOHgMRvwut3aMPD6B0QqZjtee/is9mKX7vQj5kqLTMKkYt7
 hYfndlRfS8iQesjlwsnQmoKeCOJpFZoi1DMIfUTIBFCz91re5SHK9A6R6u0ycjcL2TSu
 42pYiN2Xvr0tFQz+ciVgyW1ptT9Iq0TRWCLhzO/pFua81RBPU5kTkENV5L69at/BQKuT
 7idq2Uyt2lY76ccn6Y4dTJldegYVZjtbKp6aA93zBl89JX9+Y1VveUeY/gz9IUmeCmFD
 6wRYq6hZImGM0jRA90dpWnnSCR3x0/JuajmpvFO6TpBDJqdCPOYUKPPbo60/ACiVZxMe
 D0kw==
X-Gm-Message-State: AOAM532Wj3K0aE35DbtAMa0EwLsM6Oa7X+62vRLyml56LLMV5CiYPovQ
 ObINdKpJEBEpNgzEPRGi/4I=
X-Google-Smtp-Source: ABdhPJw1jUROsbNyZmI5lJcWnaJ2pXvGDqDAwnOuv90DXTOkhMArj8ZPm9PxumI1hfpWtPfO4io4eA==
X-Received: by 2002:a1c:6383:: with SMTP id x125mr794995wmb.46.1608231998975; 
 Thu, 17 Dec 2020 11:06:38 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id v4sm6612574wrw.42.2020.12.17.11.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Dec 2020 11:06:38 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <ca9f42e5-fa4b-1fa0-c2a8-393e577cb6c9@gmail.com>
 <128d5ddc-ef46-1125-c27e-381f78a49a96@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <999f935c-310b-39e0-6f77-6f39192cabc2@gmail.com>
Date: Thu, 17 Dec 2020 21:06:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <128d5ddc-ef46-1125-c27e-381f78a49a96@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201217_140640_960508_F35D8D87 
X-CRM114-Status: GOOD (  30.99  )
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
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 15/12/2020 7:19, David Ahern wrote:
> On 12/13/20 11:21 AM, Boris Pismenny wrote:
>>>> as zerocopy for the following reasons:
>>>> (1) The former places buffers *exactly* where the user requests
>>>> regardless of the order of response arrivals, while the latter places packets
>>>> in anonymous buffers according to packet arrival order. Therefore, zerocopy
>>>> can be implemented using data placement, but not vice versa.
>>>
>>> Fundamentally, it is an SGL and a TCP sequence number. There is a
>>> starting point where seq N == sgl element 0, position 0. Presumably
>>> there is a hardware cursor to track where you are in filling the SGL as
>>> packets are processed. You abort on OOO, so it seems like a fairly
>>> straightfoward problem.
>>>
>>
>> We do not abort on OOO. Moreover, we can keep going as long as
>> PDU headers are not reordered.
> 
> Meaning packets received OOO which contain all or part of a PDU header
> are aborted, but pure data packets can arrive out-of-order?
> 
> Did you measure the affect of OOO packets? e.g., randomly drop 1 in 1000
> nvme packets, 1 in 10,000, 1 in 100,000? How does that affect the fio
> benchmarks?
> 

Yes for TLS where similar ideas are used, but not for NVMe-TCP, yet.
At the worst case we measured (5% OOO), and we got the same performance
as pure software TLS under these conditions. We will strive to have the
same for nvme-tcp. We would be able to test this on nvme-tcp only when we
have hardware. For now, we are using a mix of emulation and simulation to
test and benchmark.

>>> Similarly for the NVMe SGLs and DDP offload - a more generic solution
>>> allows other use cases to build on this as opposed to the checks you
>>> want for a special case. For example, a split at the protocol headers /
>>> payload boundaries would be a generic solution where kernel managed
>>> protocols get data in one buffer and socket data is put into a given
>>> SGL. I am guessing that you have to be already doing this to put PDU
>>> payloads into an SGL and other headers into other memory to make a
>>> complete packet, so this is not too far off from what you are already doing.
>>>
>>
>> Splitting at protocol header boundaries and placing data at socket defined
>> SGLs is not enough for nvme-tcp because the nvme-tcp protocol can reorder
>> responses. Here is an example:
>>
>> the host submits the following requests:
>> +--------+--------+--------+
>> | Read 1 | Read 2 | Read 3 |
>> +--------+--------+--------+
>>
>> the target responds with the following responses:
>> +--------+--------+--------+
>> | Resp 2 | Resp 3 | Resp 1 |
>> +--------+--------+--------+
> 
> Does 'Resp N' == 'PDU + data' like this:
> 
>  +---------+--------+---------+--------+---------+--------+
>  | PDU hdr | Resp 2 | PDU hdr | Resp 3 | PDU hdr | Resp 1 |
>  +---------+--------+---------+--------+---------+--------+
> 
> or is it 1 PDU hdr + all of the responses?
> 

Yes, 'RespN = PDU header + PDU data' segmented by TCP whichever way it
chooses to do so. The PDU header's command_id field correlates between
the request and the response. We use that correlation in hardware to
identify the buffers where data needs to be scattered. In other words,
hardware holds a map between command_id and block layer buffers SGL.

>>
>> I think that the interface we created (tcp_ddp) is sufficiently generic
>> for the task at hand, which is offloading protocols that can re-order
>> their responses, a non-trivial task that we claim is important.
>>
>> We designed it to support other protocols and not just nvme-tcp,
>> which is merely an example. For instance, I think that supporting iSCSI
>> would be natural, and that other protocols will fit nicely.
> 
> It would be good to add documentation that describes the design, its
> assumptions and its limitations. tls has several under
> Documentation/networking. e.g., one important limitation to note is that
> this design only works for TCP sockets owned by kernel modules.
> 

You are right. I'll do so for tcp_ddp. You are right that it works only
for kernel TCP sockets, but maybe future work will extend it.

>>
>>> ###
>>>
>>> A dump of other comments about this patch set:
>>
>> Thanks for reviewing! We will fix and resubmit.
> 
> Another one I noticed today. You have several typecasts like this:
> 
> cqe128 = (struct mlx5e_cqe128 *)((char *)cqe - 64);
> 
> since cqe is a member of cqe128, container_of should be used instead of
> the magic '- 64'.
> 

Will fix



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
