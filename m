Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861FECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68N5DycOpL4Rg4o9EfqAhk52NzjvSEM+u5OY5hUdLlo=; b=wzb1fSPQY690rzPdMmSegb1JUu
	6x6042M5rSrjbp7O5bUtYhwYqjkS9BOaims58MsRo6s24uXwld8PeSPk+wxpes7193D6Qxm6Uk5ND
	GX2QMgp6Dhw4A0ahUrzHdV26aRIoYyqNm33ProhTKOT/MKjDFaRe2AiYn45FRpWGb+BRSZ5jp9V++
	8t8wPRwl3qXjeE3tK1sbVasOoTd93gfg7PjNXVCWo7BSKaHdMSLS0n4Di3VJdWGIeGgQF9zMRDvxR
	EJ6NmxnUmCqlkiG+WC+iNLGYo9DgitieDwlnH7RzpG3IHBgJT44Czas5dnG+dB5wJi899T2LyCXlb
	ZLz/dFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJjY-0004tu-35; Sun, 28 Aug 2022 14:57:56 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJjS-0004rN-FW
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 14:57:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3211676wms.5
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 07:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=68N5DycOpL4Rg4o9EfqAhk52NzjvSEM+u5OY5hUdLlo=;
        b=K7T6GHZAcAYONxweoRme02qS4CHBb+sNiz+Xx5dChl+xk8KkRIseHCW2gP5WX5yy4H
         v+mhc1yypIUTwbeXIQr+ShK3FW/qFmCTNdauoTmwdmAM2vZw2D6KGlkzQJ1RVx0SyfBJ
         ii1Md7dSLM5A06tzyGY+RlV7AoFThV0Omy4iZI9FHFOePLdzk27OEU5QMtZftKZ2QKWA
         UHkQx9UODsn/BeueJyD3M6lBN6a55Nvg3h3uH7PI0tyY0kZN22fKUGdMsBoP9n5qRkX3
         mEzzliqT9TLGzt7bJytLh7I+7np+IxJIvxR93crZXR5pboX+oy3jrXdaRFmnhVXkx3CL
         PFnA==
X-Gm-Message-State: ACgBeo0oAIRQs+keUbfrHLbH+GL1o++A8qVIURUBZvPwqiQr6pMiz0Vb
	Q6srxf1CojxNOtGSDZ/7BxQ=
X-Google-Smtp-Source: AA6agR4E0LIUJ3MaoGtSq0VPJXKTeWI3G/89eKZvRW86JQwICUgESC4oRIxMDrYPoeFUEaNdrkBw2w==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr4703627wmq.188.1661698668776;
        Sun, 28 Aug 2022 07:57:48 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm4884686wry.6.2022.08.28.07.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:57:46 -0700 (PDT)
Message-ID: <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
Date: Sun, 28 Aug 2022 17:57:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_075751_605045_1B845A36 
X-CRM114-Status: GOOD (  17.54  )
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


>>> On 2022/8/21 14:20, Christoph Hellwig wrote:
>>>> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>>>>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>>>>> case of low concurrency, if some packets lost due to network abnormal
>>>>> such as network rerouting, Optical fiber signal interference, etc,
>>>>> it will wait 2 second to try retransmitting the lost packets.
>>>>> As a result, the I/O latency is greater than 2 seconds.
>>>>> The I/O latency is so long for real-time transaction service. 
>>>>> Indeed we
>>>>> do not have to wait so long time to make sure that packets are lost.
>>>>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
>>>>
>>>> I'll leave people more familar with RoCE to judge the merits of this
>>>> change, but I really want a comment explaining the choice in the
>>>> source code.
>>> Now the TCP retransmission timeout interval is 250ms, and this setting
>>> has been maintained for many years.
>>> The network quality of rdma is better than that of common Ethernet.
>>> That is the reason to set 262ms as the default ack timeout.
>>> Adding a module parameter may be a better option.
>>
>> Are you solving a real issue you encountered ?
> There is a low probability that this occurs in real scenarios.
> The issue occurs in fault simulation test.
> In the core-leaf fabrics,simulate a fiber fault between the core switch
> and the leaf switch.
> In the case of low concurrency, There is a high probability that the
> I/O latency is greater than 2 seconds.
> This patch can reduce the I/O latency to less than 1 second.
>>
>> If so, which devices did you use ?
> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
> The switch and storage are huawei equipments.
> In principle, switches and storage devices from other vendors
> have the same problem.
> If you think it is necessary, we can test the other vendor switchs
> and linux target.

Why is the 2s default chosen, what is the downside for a 250ms seconds 
ack timeout? and why is nvme-rdma different than all other kernel rdma
consumers that it needs to set this explicitly?

Adding linux-rdma folks.

