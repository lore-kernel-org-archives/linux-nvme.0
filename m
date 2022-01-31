Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BFDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//LK3/stWdnSIoqkOvZWy1q8y/N0xxg6qcQ5QwPeUNQ=; b=ghTr9eCDcN8wsRP8NUQZZChr8w
	Ua+BeIUo7MuCa5p5H7sQdpSlsvE1JYIQaplaXijzT2eXNYqYge2hJuxm6mTP/H36QgSHvJec4/9oA
	rUjBTGuGOYteGym4hT6PfXjNfaYb4ADiIbxWNA8mTkkt98jV5LlMQdiNWdEjikB77DIz5ddsihGQc
	lNc2b1p/oZGOxpJLdD6UvFrSs2GidVMmfqiw/yQvHdSJXI7MqmreERhsoccfA9GMjf36nlMhnRzUs
	Yvm9BTs2G2rW8DXZjQnkSyOb9LQuyX9g/+XDGwVHL/F9iE+j8hQIHZxRZJIshmBhR0yymRbBKniOw
	H2lke3Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEbrN-00ASmb-Cl; Mon, 31 Jan 2022 18:57:05 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEbrD-00ASjF-0v
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 18:56:56 +0000
Received: by mail-wr1-f48.google.com with SMTP id k18so27319341wrg.11
 for <linux-nvme@lists.infradead.org>; Mon, 31 Jan 2022 10:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=//LK3/stWdnSIoqkOvZWy1q8y/N0xxg6qcQ5QwPeUNQ=;
 b=1LDmbKTDg0NMcBo0dT2Nqs5gD7Gag8B6cySDR09+1zCtv3xVcNgtkAbT5c3DexixPa
 lTH9afTxGaTKWqAJZtnQejTxQXXMl2cBxh4CjxhomyXjwhkiCA57pw9mLfMrm9GTyb+2
 vhw+DyVE3DG+XOZ/mGC/Bp7/G+5eVr/U039to2Zkt7rwlC8AVLDUbY34QEQCQi2WI1No
 1PxWCO73a8DTIHs6x+4vDvFjQwJvbQVe+ullc+cUhty8uMU/PBNKRB/M4ApA45S8LY7n
 Du95H48gRS2TK6ho7KFvRKLIOutl1CqYu9LpKwMpXLcIyNN9EsXWbWhhLNqtlw8tVLCv
 X76Q==
X-Gm-Message-State: AOAM530quO5ZPE3NNCZze/NKK40kS5QKkmMRaDbwObExQfngroaYkCEb
 y2Qgp6hqvR/8NJRJhvd6C8w=
X-Google-Smtp-Source: ABdhPJxd8mlFbrVVe+qMDZvmKEjSm5Rtj6d3y5L9PHjy6ccKYDJ+h6DSgv52rThllFzOASfw2/r4UQ==
X-Received: by 2002:adf:d1e7:: with SMTP id g7mr19650606wrd.396.1643655412974; 
 Mon, 31 Jan 2022 10:56:52 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id a9sm141862wmm.32.2022.01.31.10.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 10:56:52 -0800 (PST)
Message-ID: <d48c4be4-e678-adc7-c5db-e862b9d84658@grimberg.me>
Date: Mon, 31 Jan 2022 20:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
 <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c5e4cff-2a5e-c1d2-34ed-ac7918c3991b@grimberg.me>
 <SJ0PR19MB4544AC1F430E3B025FE8D0C5F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544AC1F430E3B025FE8D0C5F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_105655_086786_EA51B2AA 
X-CRM114-Status: GOOD (  12.14  )
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


>>> You say that you don’t see any point to send an event on the
>>> disconnect because it is async.  I don’t quite understand that part.
>>> For example, I've observed that when connectivity is lost the kernel
>>> will try to connect every
>>> 10 sec. And it will keep trying to connect 60 times (i.e. 10 min)
>>> before giving up. Wouldn't sending an "offline" event when
>>> connectivity is lost give user space apps a heads up that the nvme device
>> may not respond.
>>
>> Why does userspace need it?
>>
>> When the host will disconnect it will send event asynchronously, so
>> userspace cannot reliably do anything before the host disconnects.
>> Other than that I don't understand what would userspace do with "offline -
>> I/O is going to fail"...
> 
> I was just asking for completeness. Some apps may use it.

I think we'd want a real use-case before decide we expose it.

