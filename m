Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52089C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 22:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpcCgQS0gXCD+hvSguR3UnFG1qnT0lm+T8n1vVCxIxM=; b=Mczy33Y1mALyt7VH8F3+XkfgLo
	k94P4pGD332U7KwVMRRf6EqAyHnBoBuGKGrccKDn8fZmcx1kGUO5ew4ELCcXPFZ5j+r5/0Uzmwo7j
	MtCy9dTWnNtbHlWd9pjqK56DHV4i9p4Aj2UhWEbePb2SP+E1vlBOTbLRccHY9ZSQCrp9xrqsj7yoz
	sN6IgKh920tNXtd6V59HCsXgQxB+TiQJ3L99U/Am0SNVMgBZElvP6Ll7vKm4e1t1Uei/wXnOTKKbr
	Qr8WKH+gBv/R6W0qJ127DJkgOhMf3YHlUSijodWbtL3PLtXDgm8VYk2yF6ufpQt3thR9mIpy8/b1x
	tGe4At2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJM9D-00G0kf-2Y;
	Tue, 11 Jul 2023 22:47:55 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJM9A-00G0jt-2u
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 22:47:54 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-392116ae103so4828642b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689115668; x=1691707668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpcCgQS0gXCD+hvSguR3UnFG1qnT0lm+T8n1vVCxIxM=;
        b=KjTLIEMy/UOKJS1nUesRrgNqETtpUU0ym+GtGAS0nFpmlOsPFT0VC/jMhiTqKwR7x3
         tfYaqWNaR4ur3HpMyd3W+6YOkE561EpXrBmhhMWYXTBP6LnMYlvWxTzwOFmFqdsnEwcL
         snkaXVqvV4e1gS6bEc5wMcRFH41l/KzwrKQwnftmp4+xhprfLzdF/PHafuYWzblnuGe5
         3paEvWudVifKhm1nRSzBUrntu6IUDNQ7HTI0uIKEKGkRJMNXX5Ovimtp460oe/LG+pBA
         Y8okBDt7o/qGr9yFlfPgtAsXL6pErNaLJzgxtAy+EnUPM/DBWFzas+/8GvI3k96PWhTM
         W8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689115668; x=1691707668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpcCgQS0gXCD+hvSguR3UnFG1qnT0lm+T8n1vVCxIxM=;
        b=Wg9LoIjWCSrMsCx2wTCzc+l51I9DHIZ7tVjJ+NsnDlzMupT8HMLMmFFBViwoJEcAvA
         WnPIHJ7mUUOS8UUffJa+PwAJ8URzbgYqEW+F+oYHNHPJtkaBPzApRFTzJxHkTfGpTavJ
         hCBBDiuLnP/LRGS+x0I/pNO4AKlhzc8ID0Aou+6WF9K0slX5y8vFsbipeF5pHBPcgUln
         NoZAESJGhU2dqyNoMVki2lqybKFZ/QKct3IUD+srNBu6xB6OyBLs6Kk4HvMS4UK1DkRP
         aKfRi8tl97kGXiyyFf4NCXmXZU9nCgKwCr6G7KL7C27wVuSkZu1Xu1qHorXcLwFqnzl4
         vd7Q==
X-Gm-Message-State: ABy/qLYQ9CdiKeue/2WVxn7iHEgRqc21y9Cfl/69/lz463urnVFzYhy9
	b2BBc3/ZkLSsnBnx4Zn7pY0=
X-Google-Smtp-Source: APBJJlHv0PeOyk7BhG/GOv1k9Z29OiBGd6p6xJrUCOn9UGhShD6VDfAqkzbNdM8f7Sm9K9D+9ipTOw==
X-Received: by 2002:a54:4f8e:0:b0:3a3:ffb7:a28 with SMTP id g14-20020a544f8e000000b003a3ffb70a28mr7749566oiy.45.1689115668098;
        Tue, 11 Jul 2023 15:47:48 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b003fdebf1a634sm1580898qtb.75.2023.07.11.15.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 15:47:47 -0700 (PDT)
Message-ID: <0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com>
Date: Tue, 11 Jul 2023 15:47:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Ewan Milne <emilne@redhat.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
 <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_154752_940856_D4BB3CED 
X-CRM114-Status: GOOD (  31.19  )
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

On 7/6/2023 5:07 AM, Daniel Wagner wrote:
> Hi James,
> 
> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
>> As much as you want to make this change to make transports "similar", I am
>> dead set against it unless you are completing a long qualification of the
>> change on real FC hardware and FC-NVME devices. There is probably 1.5 yrs of
>> testing of different race conditions that drove this change. You cannot
>> declare success from a simplistic toy tool such as fcloop for validation.
>>
>> The original issues exist, probably have even morphed given the time from
>> the original change, and this will seriously disrupt the transport and any
>> downstream releases.  So I have a very strong NACK on this change.
>>
>> Yes - things such as the connect failure results are difficult to return
>> back to nvme-cli. I have had many gripes about the nvme-cli's behavior over
>> the years, especially on negative cases due to race conditions which
>> required retries. It still fails this miserably.  The async reconnect path
>> solved many of these issues for fc.
>>
>> For the auth failure, how do we deal with things if auth fails over time as
>> reconnects fail due to a credential changes ?  I would think commonality of
>> this behavior drives part of the choice.
> 
> Alright, what do you think about the idea to introduce a new '--sync' option to
> nvme-cli which forwards this info to the kernel that we want to wait for the
> initial connect to succeed or fail? Obviously, this needs to handle signals too.
> 
>  From what I understood this is also what Ewan would like to have
To me this is not sync vs non-sync option, it's a max_reconnects value 
tested for in nvmf_should_reconnect(). Which, if set to 0 (or 1), should 
fail if the initial connect fails.

Right now max_reconnects is calculated by the ctrl_loss_tmo and 
reconnect_delay. So there's already a way via the cli to make sure 
there's only 1 connect attempt. I wouldn't mind seeing an exact cli 
option that sets it to 1 connection attempt w/o the user calculation and 
2 value specification.

I also assume that this is not something that would be set by default in 
the auto-connect scripts or automated cli startup scripts.


> 
> Hannes thought it would make sense to use the same initial connect logic in
> tcp/rdma, because there could also be transient erros (e.g. spanning tree
> protocol). In short making the tcp/rdma do the same thing as fc?

I agree that the same connect logic makes sense for tcp/rdma. Certainly 
one connect/teardown path vs one at create and one at reconnect makes 
sense. The transient errors during 1st connect was the why FC added it 
and I would assume tcp/rdma has it's own transient errors or timing 
relationships at initial connection setups, etc.

For FC, we're trying to work around errors to transport commands (FC 
NVME ELS's) that fail (dropped or timeout) or commands used to 
initialize the controller which may be dropped/timeout thus fail 
controller init. Although NVMe-FC does have a retransmission option, it 
generally doesn't apply to the FC NVME LS's, and few of the FC devices 
have yet to turn on the retransmission option to deal with the errors. 
So the general behavior is connection termination and/or association 
termination which then depends on the reconnect path to retry. It's also 
critical as connection requests are automated on FC based on 
connectivity events. If we fail out to the cli due to the fabric 
dropping some up front command, there's no guarantee there will be 
another connectivity event to restart the controller create and we end 
up without device connectivity. The other issue we had to deal with was 
how long sysadm hung out waiting for the auto-connect script to 
complete. We couldn't wait the entire multiple retry case, and returning 
before the 1st attempt was complete was against the spirit of the cli - 
so we waited for the 1st attempt to try, released sysadm and let the 
reconnect go on in the background.


> 
> So let's drop the final patch from this series for the time. Could you give some
> feedback on the rest of the patches?
> 
> Thanks,
> Daniel

I'll look at them.

-- james



