Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43FC7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1vcSNEeSe4sgntFVqBDD5/DDbczC6NThqgSC5fIJEc=; b=ilF7yoEtmiQQnlAP3fJ1/84Pa6
	geR5nLjpcIFaEwFXT8++Dr2Z9hrYhJRjExz+R54le9xjbLdckCEyZ28duY/oqoELogB0dsyU78qkG
	AS3tUc8r/BxS1XtV2Y4/rE3Ha741RFsXw3jOfVjIpTPkSpFRFgx+7onE9tBDsXoZ1PRxihjhH1ck4
	IbjdpVkX+ulKJeyr+gMT9hYvWWBLy45Ym4QpPP5qaBJcF0fPFkVcXpKX3+VTGuJXhMkKpcCsTPEXV
	/rxUyEKtb1FgnDlxeVYy9+Yl/gewS156AGNo0mDS33sbaf8/6grAN3D7F+Ose+z6c7YUYTMYRBMdv
	7Al6iHaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ig5-00H0L3-2K;
	Mon, 05 Jun 2023 22:27:53 +0000
Received: from mail-lj1-f182.google.com ([209.85.208.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ig3-00H0JS-0W
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:27:52 +0000
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b1a4be0ba1so10749271fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004068; x=1688596068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1vcSNEeSe4sgntFVqBDD5/DDbczC6NThqgSC5fIJEc=;
        b=LLNT1+r7QR5FBX/3dLgHWumDOK146yQSJQxHTxim5ChQkMjnWjjlXUdeCVJfn4kPJL
         2DnUKYnOm00cfr/JQ+gzNjQkDoqqOfh2J6+znrv0UCyy1u4VltTYZpb+bPMSbQqJIevi
         N0cC7abCZLT0hwfvhSRGyKrYf7IWsmN/WbEgceg/a/EfIgVSiznEBJXGwnocZp79OXNU
         uA324TSv4GnoyJr47CGATcTOFWNkxXxMxde834/7+xq8tkb13WDVycIFelHAYzlT6/DR
         LnpTiutBSBr9BIOFkIW5WSAYOR0YwHiSczMWTtAvCH184xLocBU9MKSjL0eLFxzi5Z7S
         WW5Q==
X-Gm-Message-State: AC+VfDyR36Sc94RjZqPBdAwNPdIs0uPnJboKLm1udfhoryktWYrUXkWf
	ubXr5HVVMW0iKv0WIlIJr/DdUE0zKEo=
X-Google-Smtp-Source: ACHHUZ50awhGl0MW08wmiCsk7zUzFpundeVzLQaQ6ISyr4UanROPLy4k1VN5juydh3YOBlxpYKd89w==
X-Received: by 2002:a2e:b80c:0:b0:2b1:dc69:67fa with SMTP id u12-20020a2eb80c000000b002b1dc6967famr270969ljo.0.1686004067704;
        Mon, 05 Jun 2023 15:27:47 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id l7-20020ac25547000000b004f6150e08a6sm1183810lfk.288.2023.06.05.15.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:27:47 -0700 (PDT)
Message-ID: <584d4ba6-6fc5-2149-b270-f196537ca6ca@grimberg.me>
Date: Tue, 6 Jun 2023 01:27:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 0/3] nvmet-auth: auth send / receive cleanup
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <20230605091920.34253-1-kch@nvidia.com>
 <8b0a0524-b898-0ab4-df73-6d851f5010a4@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8b0a0524-b898-0ab4-df73-6d851f5010a4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_152751_205208_D1E43F0E 
X-CRM114-Status: GOOD (  12.79  )
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

> On 6/5/23 02:19, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> nvmet_execute_auth_send() and nvmet_exeucte_auth_receive() share a lot
>> of common functionality such as :-
>>
>> 1. Checking secp/spsp values and its error handling.
>> 2. Initializing transfer buffer len and its error handling.
>> 2. Allocating transfer buffer and its error handling.
>>
>> This code is repeated in both the functions.
>>
>> Add common helpers with very small restructring of code to remove
>> duplication of above functionality in the nvmet_exeucte_auth_receive()
>> and nvmet_execute_auth_send(), it also makes code easy to read as both
>> the functions are doing substantial work.
>>
>> Please note that this series is generated on the top of this :-
>>
>> commit 01cff945c026f1e245ba6401f7df2336ddbae11d (origin/nvme-6.5)
>> Author: Chaitanya Kulkarni <kch@nvidia.com>
>> Date:   Fri May 19 02:40:52 2023 -0700
>>
>>       nvme-fcloop: no need to return from void function
>>       
>>       Remove return at the end of void function.
>>
>> -ck
>>
>>
> 
> Please disregard this, I'll send V4, apologies for noise..

:/

