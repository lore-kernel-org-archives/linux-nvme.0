Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E775CEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3pgPG5HcjoHChSMIHnwxdZq1H4NxDYL9NDU49ig1HM=; b=YnXbNig67Gk27+0uIEtwBTJrqj
	knpK5zCq96q8hG1hkVJmjg+MY6xHQfbKrfZAoib+Oo4l2/Fxu5v7zt9F66/0Jx2IIWG+jastIpbwF
	VY/vVVeI6LLRFjN+YBmUSYteT0ENkflydvX4WJdPy0TqeMoZOjxH0cJ/xJ4jWJJCTL9X8fhTryh7i
	F0QKZzTKBL6AK5ug7B5pGQmo3qvDSYSAqfjooLeFsd/EqZT1KGmHdu1cNGZBKyQ0qbxgWTWjx+j4C
	SOTTJdzWp2cbaySxGNLR74h5u/SMiLp57hLTEjjTQE8uvrlS6uv0ARUbr9BuaWdH6CuYl3xliBhIj
	/T6QCNsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBmZ-00FCww-2P;
	Sun, 13 Aug 2023 14:09:27 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBmW-00FCwV-0a
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:09:25 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe2d889ad7so1329917e87.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935762; x=1692540562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3pgPG5HcjoHChSMIHnwxdZq1H4NxDYL9NDU49ig1HM=;
        b=Ay5sVPB3wMJHp4WTuX40oivBpuWww0J+CeXxZdKdHf8wHKeioGOZFF2vJMV4riNCmq
         2HSP7NTRMfea3ryRySqvTWELE9JWgvlnkVgE0V0O+YLiA9h+e9U3O5FiSby62lrW7Ds7
         fXNAMs9ydOq+5X9+BBDgPH26XD6itGyFZ3PXkx/nO+rEDrNRapdQqTd3lVIskcoXPNab
         0DjPnovBf2fqRQxz/BgLF0026LU/DI5gN+a6tMwQe14++xx7qvk98aQvHcKyraOWq4MF
         nME1k+gaaZOvAB8uhna+CJUUJR7A7LOVTUR4xnuIVsCT3MM1OrgRbijjzb4c2JP1s3QH
         OF3A==
X-Gm-Message-State: AOJu0YxDlMqx6UN3LB1Gz/kU2wLtgiXkdj28LIF8mj6ka68FfuddfddX
	vH9tm3y8H1qtrZhYz5aAuQU=
X-Google-Smtp-Source: AGHT+IFlkgGZkz0VU54SYfn6HU4UiHzf0pfKGDR+vR2ibfzgHaI8IA80ziScxsXvshFWACYjlIk/ng==
X-Received: by 2002:a05:651c:1c6:b0:2bb:7710:1cea with SMTP id d6-20020a05651c01c600b002bb77101ceamr114853ljn.0.1691935761459;
        Sun, 13 Aug 2023 07:09:21 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906115900b00992025654c1sm4690852eja.179.2023.08.13.07.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:09:20 -0700 (PDT)
Message-ID: <994c8e4f-cdbc-4a49-e283-856cd348535b@grimberg.me>
Date: Sun, 13 Aug 2023 17:09:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Rakshana S <rakshanas@chelsio.com>
References: <20230803105839.6139-1-varun@chelsio.com>
 <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
 <BN9PR12MB5324E8DC829612DD1463116BBC0CA@BN9PR12MB5324.namprd12.prod.outlook.com>
 <2a8abad4-8c6c-2353-d056-ea6f04cc0f12@grimberg.me>
 <BN9PR12MB5324D0D07761F9375342060DBC16A@BN9PR12MB5324.namprd12.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BN9PR12MB5324D0D07761F9375342060DBC16A@BN9PR12MB5324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_070924_221610_D4B03C12 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
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


>>>> What is the case for data_length=0 ? I'm not entirely clear how this can
>>>> happen.
>>>
>>> This can happen if H2CData PDU data length is not a multiple of target page size.
>>>
>>> For example if transfer length is 32K, page size is 4K and H2CData PDU data length is 6K,
>>> host will send 6 H2CData PDUs, for the last PDU iov->bv_offset = 2K,
>>> iov->bv_len = 2K and data_length = 2K.
>>
>> I understand.
>>
>> Looking into this, I'm almost thinking we should just give up and
>> iterate. at this point it unnecessarily complicates the code...
> 
> Should I resend v1?

Yes please.

