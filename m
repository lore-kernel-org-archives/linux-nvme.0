Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA6C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lb9PJfXEYzXr5GwEnepDwvH+h3khGSO0zWbctPMuj3M=; b=bm7cozrgRsyfCsvpLYzD9Js4dY
	u41e8xDQSMH49Po+92a2+91gcRfEdx27eS3sjX/LUvCpKxHevEZGRXYKS6W2TJgAiHm++JJuWIoTX
	9WT6oKvTSAn0jpWtfLauO/V3gt67GOhvaS49xghR5+V5zLYvLbsK+qC79MbKgys+TxuhqhdKRaBMu
	5U8g1dNTRhLH2ZHAjToN40QjZW0iC9gc3MjOf4Kn1WaAtA+C7wE9/8CBVTFpK5Fkl7ApWIpxUedg2
	dmZxIpEAmfzqZlPCAOcypxaQBz6UrMg9l8B2E71DSd9Pd2rjhrnY6V5JVsjFebHGD1c4lny/g+S/g
	Y9vdd2Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms3q-0000000GR7n-1BcA;
	Wed, 20 Mar 2024 09:16:38 +0000
Received: from mail-ua1-f52.google.com ([209.85.222.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rms3m-0000000GR5T-3Nxa
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 09:16:36 +0000
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7de0cc4b615so1039178241.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 02:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926193; x=1711530993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb9PJfXEYzXr5GwEnepDwvH+h3khGSO0zWbctPMuj3M=;
        b=bag46s+DtOguAmnAIluWOxh5Kupx/I1w47562Ty7qhkB/xfZ//fmhH/RlOvV11pCN5
         6dtSYL75UsVR7TK0r/25kcPIk4QImfeaD21kDuXwU7keDJDjpNQ5B/TkesmPvziGJbS4
         3SPnHXIpfiRaSJF5DQY5zjuEy6as+1OLAaMe59PGOAyvIymNTmZz6ZQpfEVzwK2SglL2
         fm7R59EgX9GkRqm9DNAm3BUFCgwbEi8QQ1EEZ4sPuW6yfAEczED0VDfYjH4nuNuu2oc8
         EDFJAdP42KBS6S5NsvgOiwMFZzCiVDARzjdYDmkoLHzwIaFN1bwVr1VLCQVL4n4yICHv
         qQTA==
X-Forwarded-Encrypted: i=1; AJvYcCXAWLRhgM0wFnGSnLirJxRgVfmwk7jKYvYFTMy7R7qsIvJTX2d+L41XaoKnE3LvN3odDeGPN+EbW+f0MOMV78yR44z4lr/FnTZuSVat628=
X-Gm-Message-State: AOJu0YwDAQRL56TCQbD9TMgbHz5H/zatYDYeWkCgMlIPJbQHc9W1uc8K
	BMzFU5o1RU1ZecKy37G4IktGUHsZCb1jw0B7S0HYOh/P521TK/OQ
X-Google-Smtp-Source: AGHT+IGQVA6PmYIdAMYPqdXBqTt0jPGoHULsDhtp1+yQYo7yS9uv+8VRdq3kkRPB9UGIfu8tqxGUVQ==
X-Received: by 2002:a05:6102:1142:b0:474:d24b:f5cc with SMTP id j2-20020a056102114200b00474d24bf5ccmr4204664vsg.2.1710926193194;
        Wed, 20 Mar 2024 02:16:33 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id im6-20020a056214246600b0068fdb03a3a3sm7561592qvb.95.2024.03.20.02.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:16:32 -0700 (PDT)
Message-ID: <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
Date: Wed, 20 Mar 2024 11:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: he-IL, en-US
To: "hch@lst.de" <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
References: <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
 <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
 <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
 <20240320015932.GA14551@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320015932.GA14551@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_021634_890714_CCD2186E 
X-CRM114-Status: UNSURE (   9.66  )
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



On 20/03/2024 3:59, hch@lst.de wrote:
> On Tue, Mar 19, 2024 at 11:19:50AM +0800, Guixin Liu wrote:
>> I am adding a per-controller percpu-ref to ns to implement
>> preempt_and_abort, the v9 will be soon.
> Do we need that?  For blk-mq based backends just doing a queue freeze
> would be enough.  That doesn't work for bio based drivers yet, but I'd
> rather improve the block layer freezing for them rather than reimplenting
> the whole thing.

That's a neat idea, we also have file to think about though.

