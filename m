Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7515CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QlTxrc8UGeYsYju69cSCDIVBGjrkM+HpaU154MNsK+c=; b=zGGc/ycbjSdGhAzCP1ue1209iY
	JWYmOt+nYXQMAYkByMHqjdZ/IX8O7cnStfB3h7yOb8NAJ5RAgoQ/afhKaYWanyxBOEWt+vxBCBxHw
	S2FnwCAKkWaqrsMNdx571GR6m7eYQNcwPUnsWQNU/Si1ZHTV17NdKI4ZPDCZNwRbeJa3HED9NRRUJ
	ccDsozsgZfd2EGVo8QEXKszymhY42kDdgK85AzzzGlOotGEXiBM2eV2pZXnpFPVSLTbtp01nkZKfj
	UTKcZ4VGiXais9QG40tfGgSTreYmr1YfQWRidck+YSlMbf20z5Mf2KH3gywrLqGx7i5sfoR99VvG+
	LnoxAHag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rupwh-0000000B86W-19qc;
	Thu, 11 Apr 2024 08:38:11 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rupwb-0000000B85Z-0Ew6
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 08:38:07 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e4556990cso989344a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Apr 2024 01:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824682; x=1713429482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlTxrc8UGeYsYju69cSCDIVBGjrkM+HpaU154MNsK+c=;
        b=FotUki4FPrCdaSGNNYGQUsPWWoDvn7QgbdRS/21oqpCGHyEEY6UWFpYkmw2tSgT0w3
         MWlLUTFUr86pf9U0I2CaMjkoPXx0pwOY49Pm7HhDDCr/K1Mmz1q9dCG/lZkp0Ejna0DH
         SIQPtY2J+TqkcCm6yROD6SSqc9XogPjwK++1lc5AXT0HwczrU4aAEaUjh2SnuTqNJTnk
         VjXaziUHl9BOjyX84mXjX0+2ofuE/OFrl7+Z4gKoSMJY1yk1WbcByfXCasUwCVAEte+I
         u/tNP7tsQcliccEDT2c28b87TdAm3nfYKORGkCvy+mTss4Vb2tY5tbDDUt3ulDNrvfIo
         /qyg==
X-Forwarded-Encrypted: i=1; AJvYcCXmqaiEbpQQLo9b7w1RLskpiICUbgDf5/eJycd6xiaGKMez0GXr/prGLVrDEMGU6G9yHnUCCR0t6gtfHqIsQzjJOtqvvOLw8k0TNEXKrnY=
X-Gm-Message-State: AOJu0YwN/i5W0AITKbdCAyX3bPbD/dMkUYXy1QKJuhPi+V9Nv/rUgEWF
	An35oluSftTZK++r/Xd3UP4uEAUCyU8RfDVu5PEYTIKjDZpkcUjU
X-Google-Smtp-Source: AGHT+IExhgCxrfw7ZhllSpKTX8uANrAEqjLHXMCdVPydNm8bg8RDAc9UCSptADWK4A4vVBXV/AZJKw==
X-Received: by 2002:a17:906:6a29:b0:a51:d463:335a with SMTP id qw41-20020a1709066a2900b00a51d463335amr3545971ejc.3.1712824681808;
        Thu, 11 Apr 2024 01:38:01 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm4861841wmb.21.2024.04.11.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 01:38:01 -0700 (PDT)
Message-ID: <7dbdce29-621a-4286-a832-2918ec1794e4@grimberg.me>
Date: Thu, 11 Apr 2024 11:37:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
 <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
 <959e5458-4c4d-4ab4-b9c2-8740156005cc@grimberg.me>
 <88684d2f-8b36-40c4-99c8-ea07f42dd805@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <88684d2f-8b36-40c4-99c8-ea07f42dd805@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_013805_221403_3012F3CE 
X-CRM114-Status: GOOD (  25.92  )
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



On 11/04/2024 10:11, Hannes Reinecke wrote:
> On 4/10/24 15:50, Sagi Grimberg wrote:
>>
>>
>> On 10/04/2024 15:05, Hannes Reinecke wrote:
>>> On 4/10/24 12:21, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 10/04/2024 9:52, Daniel Wagner wrote:
>>>>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>>>>
>>>>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>>>
>>>>>>> Any authentication errors which are generated internally are always
>>>>>>> non-retryable, so use negative error codes to ensure they are not
>>>>>>> retried.
>>>>>> The patch title says that any authentication error is not 
>>>>>> retryable, and
>>>>>> the patch body says "authentication errors which are generated 
>>>>>> locally
>>>>>> are non-retryable" so which one is it?
>>>>> Forgot to update the commit message. What about:
>>>>>
>>>>>    All authentication errors are non-retryable, so use negative error
>>>>>    codes to ensure they are not retried.
>>>>>
>>>>> ?
>>>>
>>>> I have a question, what happens if nvmet updated its credentials 
>>>> (by the admin) and in the period until the host got his credentials 
>>>> updated, it
>>>> happens to disconnect/reconnect. It will see an authentication
>>>> error, so it will not retry and remove the controller altogether?
>>>>
>>>> Sounds like an issue to me.
>>>
>>> Usual thing: we cannot differentiate (on the host side) whether the
>>> current PSK is _about_ to be replaced; how should the kernel
>>> know that the admin will replace the PSK in the next minutes?
>>>
>>> But that really is an issue with the standard. Currently there is no
>>> way how a target could inform the initiator that the credentials have
>>> been updated.
>>
>> I'd say that the sane thing for the host to do in this case is to 
>> reconnect
>> until giving up with hope that it may work. This seems like a better 
>> approach
>> than to abruptly remove the controller no?
>>
>>>
>>> We would need to define a new status code for this.
>>> In the meantime the safe operations model is to set a lifetime
>>> for each PSK, and ensure that the PSK is updated on both sides
>>> during the lifetime. With that there is a timeframe during which
>>> both PSKs are available (on the target), and the older will expire
>>> automatically once the lifetime limit is reached.
>>
>> That is a good solution, and will also prevent a loss of service until
>> the host credentials are updated as well.
>>
>> But regardless I have a feeling that simply removing the controller upon
>> an authentication error is not the right thing to do here.
>
> Guess what; that's what I tried to do initially. But then Christoph 
> objected that we shouldn't generate NVMe status codes internally.
> But if we can't do that then we'll have to invent yet another way to 
> return a retryable error, leading to even more band-aid.
> So I am not quite sure how we could achieve that, short of making 
> _every_ error retryable...

So this whole thing is that you want to make the host to not reconnect 
if the controller
sent a DNR and reconnect otherwise?

What are you returning today if the authentication failed? Am I reading 
it right that you are
returning -ECONNREFUSED? I think that for the specific case of 
credentials mismatch (that and only
that) you may want to return -EKEYREJECTED. That according to the 
documentation (/* Key was rejected by service */)
is specific enough that perhaps we can treat it specially when asking 
"should I reconnect?"

Thoughts?

