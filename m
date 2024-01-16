Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03352C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbLC8Ddbd9bzM5OMVafilprvsHCcgoHUHePNLUHpOwE=; b=OXAwGrS5Ak7LdGlB+WwtvViKJo
	5BAgP1IWpH4jseL+MjLtTWWwwNen3gig7+/wQ76FmJO4RCuo7jGxon5yug1iK+JrIIZ1GyX/l6cWk
	Ap6qHTMUla76h0GwsoeJGvSTvjf1KlYG3TL9Ge0VT47mFCEFVW2c0RqzwhLanrJ2yHfLyKZafAcWu
	S/FkDILVfa0z6Kzeq+5C53jREsEbSJxIckoOwvOrYPg8QAD45oDp5N0OBl0lNu+Oe+uJb/qwxEiHd
	kwH2kuUfatfHhYDotMgFrLPJ/tsMfQcZVQRakJLniAa7q6E8lWALhCiNgZc4biv14NpbpLd70K6Qb
	QMTYoIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPou2-00D77T-36;
	Tue, 16 Jan 2024 19:15:14 +0000
Received: from mail-oi1-f173.google.com ([209.85.167.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPou0-00D76v-03
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 19:15:13 +0000
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd67e9d6ceso2041899b6e.3
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705432448; x=1706037248; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbLC8Ddbd9bzM5OMVafilprvsHCcgoHUHePNLUHpOwE=;
        b=RHr9VBru1utvzPKaea9If6UAVTf3NDmXJ574tvnMdVySSVlqC8VmQSYhlwluLdrPt2
         HgQEGN38URL9H4TD7OygKIQLeKQbAmoJxwEhVtxpui1e1jhMnGG80/BCbXbeIEFanE2V
         nSn1Hh+pAziLQH8cFUNOdFHg/cYElaL72XkZNDiUhh5sICSEveB7gq9t07wWQB96cpzd
         bIvk5y7dGpcE5yXT2qrMTzwa1/VyD2W9Sa62P7AwN0iWzxF4y7fYXJCEqqfLsDXvEMyR
         zbIxp1LBokc/qa01NqFgOZj9jEjOok33DfZrhnyTp3cGSB0l4WfiYtrp1onE68wBaZRK
         NU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432448; x=1706037248;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbLC8Ddbd9bzM5OMVafilprvsHCcgoHUHePNLUHpOwE=;
        b=ZG+ggte2pInVvCaKuICTdSLN+Fc/l2LvZadvsjPI8cXKzNtmUjpkI2D5mlIuu0nNry
         3C232bwrndy9cpd5JRM7ghpfOS4EHQen6BfvkiGepKteGEVLiSoTzMFsHxu7zhisj+xz
         Aj5DlZ9OMsfniQUkA1coj5FiPA2mwbp1wH7006AypwyalTm4hMh1cSLvTliFBMPIaemx
         wQmpvdRwvdH4Ol2WrGRkkxzUvP9IRNgQGfBTNyl2eN6t2oJ7LTXvnm3rVI7GU6aIXwy2
         /+uvJz8cK0PB8RFPOExtkL314xLP9ALQC8Womgc6FMjj0G+s10ngqQpvLiGotSnq/vzM
         ZG1Q==
X-Gm-Message-State: AOJu0YzGIR9X+t2RGaueBbagTmwI3Gy1xF//66RZTQ/AV26vBFinRKwc
	90tSVOWSrutRsKG0WHxxBa3U70c6hcI=
X-Google-Smtp-Source: AGHT+IGlwbJPbao+HmUiFBxQTFVp5qK5cqfXMZUD7s0fPQ+zBJiI+nFyf6LVZO0bGwmc1akCLYLdyw==
X-Received: by 2002:a05:6871:3a11:b0:210:86d6:76ed with SMTP id pu17-20020a0568713a1100b0021086d676edmr583105oac.64.1705432447693;
        Tue, 16 Jan 2024 11:14:07 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id mm19-20020a0568700e9300b002053c704c33sm3156555oab.43.2024.01.16.11.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 11:14:06 -0800 (PST)
Message-ID: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Date: Tue, 16 Jan 2024 13:14:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
From: stuart hayes <stuart.w.hayes@gmail.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Content-Language: en-US
In-Reply-To: <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_111512_063065_A89A859A 
X-CRM114-Status: GOOD (  31.37  )
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



On 1/12/2024 1:36 PM, stuart hayes wrote:
> 
>>
>>
>> On 04/01/2024 18:47, Keith Busch wrote:
>>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>>> Currently NVME namespaces are scanned serially, so it can take a long time
>>>> for all of a controller's namespaces to become available, especially with a
>>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>>
>>>> Use async function calls to make namespace scanning happen in parallel,
>>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>>
>>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>>> so I'm a little surprised it makes a noticable difference. How much time
>>> improvement are you observing by parallelizing the scan? Is there a
>>> tipping point in Number of Namespaces where inline scanning is better
>>> than asynchronous? And if it is a meaningful gain, let's not introduce
>>> another module parameter to disable it.
>>
>> I don't think it is a good idea since some of the namespace characteristics must be validated during re-connection time for example.
>> I actually prepared a patch that makes sure we sync the ns scanning before kicking the ns blk queue to avoid that situations.
>> for example, if for some reason ns1 change its uuid then we must remove it and open a new bdev instead. We can't kick old request to it...
>>
> 
> 
> Sorry for the delayed response--I thought I could get exact data on how long it takes with and
> without the patch before I responded, it is taking a while (I'm having to rely on someone else
> to do the testing).  I'll respond with the data as soon as I get it--hopefully it won't be too
> much longer.  The time it takes to scan namespaces adds up when there are 1000 namespaces and
> you have a fabrics controller on a network that isn't too fast.
> 
> I don't expect there would be any reason to disable this.  I only put the module parameter to
> disable it in case there was some unforeseen issue, but I can remove that.
> 
> To Max Gurtovoy--this patch wouldn't change when or how namespaces are validated... it just
> puts the actual scan work function on a workqueue so the scans can happen in parallel.  It will
> do the same work to scan, at the same point, and it will wait for all the scanning to finish
> before proceeding.  I don't understand how this patch would make the situation you mention any
> worse.
> 

I have numbers for the namespace scan time improvement.  Below is the amount of time it took for
all of the namespaces to show up when connecting to a controller with 1002 namespaces:

network latency   time without patch    time with patch
   0                        6s                 1s
  50                      210s                10s
100                      417s                18s

I'll prepare a v2, removing the module parameter and including this data.

