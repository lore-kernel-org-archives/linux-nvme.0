Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C31DC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgmFMlN+tH/QM54PHSIbI9M6+RleOp7ZoW3f9wqGfJM=; b=SlN7LS+W8gHzjFWATIgCc2pibo
	08p64j8rHoYM9T8iJYQtcoPMNvyS5KnoCB5jJxbBimRffrcyPpDdWA/6z/FkU9ldPc7nTmB5xtogf
	UREgAKzCM1NVdbMRyCjEIWm+ecI9NizXcsDJgPoml6e6cvG/YdyLl/B6GX1bfxa1VGX+59KzQdfIC
	Q20lXeMaQgNA3bRFD4aT39KlU9Pgu2ogTllZbxRfDEWvuUR1wnTf0wFjEu+3zLEM/NXY/fApjILQv
	506i/5/IeiZBw2Vv3sl29zKcSH2LphqrJh0Wq8PPktevGKXUC0bR1hanw2K5HmB388l9JhawcvBuc
	L3f53TQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQRN-0074lo-NI; Tue, 25 Oct 2022 20:22:25 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQRL-0074lL-96
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 20:22:24 +0000
Received: by mail-wr1-f51.google.com with SMTP id o4so14808920wrq.6
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 13:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgmFMlN+tH/QM54PHSIbI9M6+RleOp7ZoW3f9wqGfJM=;
        b=aIMxPuF9mmJ9FWhWwnXMguXKr1cLeKTG0xLRGTPUGm7IhrV8CkURnhFA4uFBe1nGhI
         uh/JWKdexBojktpWMUk0xwQW/KPRDn26xqsvUtyhmP96iVWvbINjdqWng2gdK1aOhm0A
         l+EqH5dnoScK/6C7PAtaSuDOZjCgqyt8jquo8ov4d/IEMqyUU/wZCcUCVbORKUKuCHwq
         PbE82ZXk0qnZBPthn9lOTqNQImDZ+34WsGNVvkPT1V8RqVTYp7vaeJC5dhrt6mAwIDgy
         ZuJeIWX8Yqrf+wv7Q3mVUuM1mBtx7g3LiWjf343UlBTNiYkLL9gVp/6XSzWY+0i+Gzxn
         4e5g==
X-Gm-Message-State: ACrzQf0t7fuPhE3iun1HqqeH+4koFNhgEd77z10/iFqst/VGfSIfwIq9
	XhnkRb1TGKZWAq+4YlWnYdOf3ammd7g=
X-Google-Smtp-Source: AMsMyM4YsRJ5uM7w0yqXvNwZ2e/OZtlI2zp1pJqnvu8BKSqeGeSHW5RqVy7ecv0aSzUVGn0BbJazDg==
X-Received: by 2002:a05:6000:1287:b0:236:712d:2545 with SMTP id f7-20020a056000128700b00236712d2545mr8495543wrx.52.1666729339255;
        Tue, 25 Oct 2022 13:22:19 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id d17-20020adff2d1000000b002362f6fcaf5sm3575575wrp.48.2022.10.25.13.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 13:22:18 -0700 (PDT)
Message-ID: <741c630d-6b2c-5e43-d8d6-a0b079a72090@grimberg.me>
Date: Tue, 25 Oct 2022 23:22:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/6] nvme-auth: don't re-authenticate if the controller is
 not LIVE
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-4-sagi@grimberg.me>
 <07667003-2a31-8c82-895d-aa520fb4968c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <07667003-2a31-8c82-895d-aa520fb4968c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_132223_333263_9AAAEF2E 
X-CRM114-Status: GOOD (  19.13  )
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



On 10/25/22 20:22, Hannes Reinecke wrote:
> On 10/25/22 15:43, Sagi Grimberg wrote:
>> The connect sequence will re-authenticate.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/auth.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 734928282d3e..93c0fc71bc7c 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, dhchap_auth_work);
>>       int ret, q;
>> +    /*
>> +     * If the ctrl is no connected, bail as reconnect will handle
>> +     * authentication.
>> +     */
>> +    if (ctrl->state != NVME_CTRL_LIVE)
>> +        return;
>> +
>>       /* Authenticate admin queue first */
>>       ret = nvme_auth_negotiate(ctrl, 0);
>>       if (ret) {
> 
> Hmm. That is only part of the story; the controller can be reset at any 
> time during the workqueue function.

Won't controller reset flush/cancel all the pending auth works?

> Doing so will invalidate the digest hash, but we only find out about 
> queue being invalid once we _send_ data. So we crash in 
> skb_copy_datagram_iter().
> I got a patch here somewhere (which is still under testing, hence I 
> didn't send it off), but can do so now if requested.

It would be good if you can share. I think we need some more work on
the whole re-authentication piece.

