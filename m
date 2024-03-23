Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F65C54E67
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uk6eQbL0uDow32M0SFiRD93/nes6eoWiB3ykwXQw2F8=; b=IL19TxfwkpbyeyoyWudBa8bzxX
	3C+fVwOiCNT+ve52+piAIeJ6UjkAi/C3GiXqiv2nIdYKVrLTH+ZQWZPwzxCEiV6Vna/El09nGEJJE
	lZ2zNT8VDFN3XrFlnhb/JJznxemnrb6pzCN1nHPz7Hr5D3T6VDIQ9vai4D4CAkvJJMXRHE1Gmjwjk
	u0tUm7w6HP2lTn1+mQn2R6+Tsnj4mivFK18VXI6B8YFW9tLKGaAEapW+eX2AfZma+yBAO74K2aYyL
	whiLnE1q3nYTz3X2sVrYV4ARNDiqw0waaY/wdfmg5rSUQpjF92QpXdUwctt+mLylA7jbb5uvlJO4F
	hC+56ebQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro8BQ-0000000B8zK-2Zez;
	Sat, 23 Mar 2024 20:41:40 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro8BO-0000000B8yr-0Lnx
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:41:39 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e9115d501so897810f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711226497; x=1711831297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk6eQbL0uDow32M0SFiRD93/nes6eoWiB3ykwXQw2F8=;
        b=EEBG5hbrAQ5Hu4a9UTWKcAd2AGdPQMlcLQxdSiaxhz4m7td7AhLL68Mwf3AjGdteXq
         oK4dl/cWoZRhofeFb0hgG5LqI4rGBzTLSUJHcnzEvXzQH/RJ1avzsdMxYnOutYrzb+Jl
         zepaktmjBODEhhB+F1zWtOVWli36XpFAlbryLNA7BpjPVqxKkKqM9dGVrOJ4yolQVW1S
         iEODvDx1uFXe5A2imKMmP117/Fh/wqqOeyAFWMCTqTEwqYw0LppvOFSIh9hpjtwy5XkH
         BjZxEPxX7e4hSQEhwoqXNBmZPQrtdwJHQ5G4vQXcIvpTYgFo93BfNk16S5H7hHZSZfh3
         jKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVBq2/Q5zemE4wjEkYV76coFXiSh4GyWX9uJ5QFqAlTBOek99XdFhnO6Q5/tdkhz0pg1x4vM/y+8ZFs634z0ZNGl+upeM/cq1IFdnxVEVk=
X-Gm-Message-State: AOJu0YwaBFTK8StKtYIF+RPXXeO7/bxfONuMYaqUb97xvNG28O3JNfuz
	qAmHlByIWURXiOL3ARXGFHrJqOOPNtORpKsOcG/ogG5Sg+tT1scB
X-Google-Smtp-Source: AGHT+IG7jCt57u3C7uzMv9q/1KZJC5DPg1CLlPorH2yfs0wHxZaOkGGAkb0z64Gk0lkTaTlDDrn1Uw==
X-Received: by 2002:adf:ec4b:0:b0:33e:527:e1a7 with SMTP id w11-20020adfec4b000000b0033e0527e1a7mr1835317wrn.2.1711226496560;
        Sat, 23 Mar 2024 13:41:36 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id t17-20020a0560001a5100b0033dd2c3131fsm5190310wry.65.2024.03.23.13.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:41:36 -0700 (PDT)
Message-ID: <7b7fa5ab-389c-4ad7-b8cf-9b3375f7f817@grimberg.me>
Date: Sat, 23 Mar 2024 22:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: he-IL, en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
References: <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
 <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
 <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
 <20240320015932.GA14551@lst.de>
 <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
 <20240321210205.GC21139@lst.de>
 <b3b90aa1-7026-4d58-9a3e-5c1ede800d94@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b3b90aa1-7026-4d58-9a3e-5c1ede800d94@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_134138_163151_3A119138 
X-CRM114-Status: GOOD (  16.05  )
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



On 22/03/2024 11:34, Chaitanya Kulkarni wrote:
> Christoph,
>
> On 3/21/2024 2:02 PM, hch@lst.de wrote:
>> On Wed, Mar 20, 2024 at 11:16:29AM +0200, Sagi Grimberg wrote:
>>> That's a neat idea, we also have file to think about though.
>> Indeed.  It still would be good to avoid the extra overhead when not
>> needed, though.
> I still don't understand how this solves the case for file back-end ?
> can you please explain in detail ?
>
> as far as I can there is no equivalent provision that we can use for
> file back-end as you have suggested for block (bio/blk-mq)back-end,
> if there is can you please provide some details ?
>
> In case there is no such provision, how do you see file backends to
> handle this case ? perhaps you are referring to use above suggested
> mechanism for block backend and implement percpu-ref to for file only
> backend so we can keep the code clean for bio and passthru back-end vs
> file back-end ?

Yes, the latter.

