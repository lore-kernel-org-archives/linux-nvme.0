Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897BAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWYmBDUn9tvU5u6qEGxQJR/1ougaPI182llWdJS/wHw=; b=KMizJuIUVWrVdElX4zqlg7ISqZ
	EVa7F1Uz9JmrMH1RHcXsNdNsOm3jpEYKbXrDeN5ksbx7uBARWcZXFmxuRHQxFSTHDOBQLgFAP7eth
	INM7aOHIkjACaNeTMxB8MetoiwXGVZK/ygsxZKFOIvJdPjfQfqiEB7Am2cHtdTt09kEmukZk+idXP
	3py/Ucivd3/I+vodQAj7Rga3T1bJSW0OcmlcbSUCWQgdyV3JCLD1GeVUHw3IzuLlRPjLBxhdC7ddc
	ibmOcTXThE55NTyJl/cqAohhdfGzfnz/NMrrJz5rA7p0Mz8qPW9QtLbgJP6gci7/QnFCgRc2jEm+d
	HcfmxAWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJa0c-00EzL3-48; Mon, 14 Feb 2022 11:59:10 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJZ5E-00EfG5-Hj
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:59:54 +0000
Received: by mail-wr1-f49.google.com with SMTP id d27so26148731wrc.6
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 02:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RWYmBDUn9tvU5u6qEGxQJR/1ougaPI182llWdJS/wHw=;
 b=DFjBYJfMfSAJlkqxNyd863Io4ufrpVTPtHq+CAjYJWcxHWyTgxB3F5TOwP1Fvps92u
 xPVHukGmCl9ILMPCJds1kvCm7kpyR1y4uKVNbWH+ecjir0rcv7mic+AAsmBxhRsU25SD
 l6GF3DolIJnW4fEwRUnkWclMlr/liIuDAf/iIn3QwjklQutdGiIbyaPeQKtoKFlsztmW
 108Ns1jLwf+1bbelUH0qXZHPbsSbwTkq5FVcpq2zQ+SN3YCsqEKpS++GcL5aQqnVjwFS
 iJUrIOWlEMopm3M15lS+iOHXXHTSpJMk5fPot48NEy0dk/NV04cxoWzc8Fqz7dswG/Jh
 r8ww==
X-Gm-Message-State: AOAM533tWSnvAiwTKM2K5rpDjLl3zEnd/qlqTtG39e5vUR65W6P3+bTH
 F7gWZ9F4izWOYxLI7D0/HvE5ctcL/B8=
X-Google-Smtp-Source: ABdhPJxLNuUSz5emgvEyREql1mCOibXBLNwqOvtuA6JZ2JCfahmmqonPvlkMvPUwESVYxsnlk9XgBg==
X-Received: by 2002:a05:6000:1e07:: with SMTP id
 bj7mr281205wrb.522.1644836391052; 
 Mon, 14 Feb 2022 02:59:51 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p17sm11338155wme.25.2022.02.14.02.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 02:59:50 -0800 (PST)
Message-ID: <705ce6ee-3c1a-c4a0-1662-2f0794b1a6fe@grimberg.me>
Date: Mon, 14 Feb 2022 12:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
 <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
 <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_025952_673253_EAE90CBB 
X-CRM114-Status: GOOD (  10.63  )
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


>>>> We have the simpler and more convenient idr_[alloc|free], use them
>>>> instead.
>>>>
>>>
>>> you sent the same series :) either ways seems like a useful cleanup..
>>
>> Didn't see yours for some reason... Did you CC me? Can you point me to
>> it?
>>
> 
> I did cc you, here is the link, somehow it takes a while to appear
> on the mailing list than it appears in my mail box :-

Yea, got it, just a tad late...

