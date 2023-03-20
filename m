Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF5C7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33WpduTVgXbSCGkNgW1ZL1i4Q3P2kLE0lySsDwuA7XU=; b=KRkXEQOwzphpOUA4b31bQQHXmD
	yarCc8+8QK1ccMDjSRW8dg6bNCwPC8I0Kj20sb+Vy3Az8Rayfy30yU+LGtjY6V6X9mY8UQNRXUOXS
	+zcAblpbQOI9aCjAmdq7HTuxsquFmVz+Y1EbRvh01iL2nxLs9OlTsGOOg8RRnNMtKh9/kSvmWSztK
	ziM2kciQl9ixspeEfe4rpwChSPJ2Yqlw+xcWPEjq7CTMM+9DOUuhjnDdBA2F7GRm1QI5Oh/kAlQqO
	KPVe2NW4E0cftklfPcq3nNWs6OrN3ayTK8/2nL8ZpPeAjK7Qh9SEDI02fownZuSx9Rste+BOwZM6Z
	dgn+Letw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peLh4-00AMKM-2Z;
	Mon, 20 Mar 2023 20:01:22 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peLh2-00AMJ3-0M
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 20:01:21 +0000
Received: by mail-ed1-f53.google.com with SMTP id h8so51424440ede.8
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 13:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342473; x=1681934473;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33WpduTVgXbSCGkNgW1ZL1i4Q3P2kLE0lySsDwuA7XU=;
        b=Zhbvpisb3e/XKDqQrVRTGcs3ML1b0fVsJlrTlhuEseuSmCCRNrvX1r4mnLAa53SZi2
         eAY2oiEoELXfhh9oWEEqsE8ZtSF0a5Chdnu9AW1SA2HyPdMuM0ZoLZTIrP0fjsenfIZd
         hHj4xGmpDFFwWELej6TJgMIev16KPomlCI6colNmNA7Hd58UlD3Ka5dz1AW5oCdCUS7A
         hmQ0wPktca6ll8vAeWSb+dzQFNoRWEx6ORpvhZWvU6PVqtaM/NYPNPFbmfGXpF1o/0/G
         HEjG1PRutW4Y82naHEa+bFc/wmBBXbJHx3Rz3cZvA8DCNaTv7KgOK2dREREWtZbC7wAP
         AOow==
X-Gm-Message-State: AO0yUKUm1woU6J1tA0pI2PzTK0XFQn7kgpFl2YvaoBCyLr6x/4wXwzHk
	m0fbOMPcVzrR7pm5zYn6BRE=
X-Google-Smtp-Source: AK7set+Re6vMgqOUZJ6MYbmIDVEfRV2bl7HlYNJJpjDSbMLJDimedF7iDaUV9b8+PT8UZnCSZpwBZQ==
X-Received: by 2002:a17:906:20d8:b0:931:5145:c51f with SMTP id c24-20020a17090620d800b009315145c51fmr210594ejc.4.1679342473437;
        Mon, 20 Mar 2023 13:01:13 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b008e82cb55195sm4816570ejq.203.2023.03.20.13.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:01:13 -0700 (PDT)
Message-ID: <ff4fd0e2-588c-4e41-a9ed-52e76ea8e7d6@grimberg.me>
Date: Mon, 20 Mar 2023 22:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp poll queue crash
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
 <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
 <20230320145113.md6dcyv22yqhppmz@carbon.lan> <ZBh2bCPAnShTMxoF@kbusch-mbp>
 <5f38f8fe-5180-04bc-6b77-a5b1e4960dda@grimberg.me>
In-Reply-To: <5f38f8fe-5180-04bc-6b77-a5b1e4960dda@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_130120_151628_E1F5A153 
X-CRM114-Status: GOOD (  13.52  )
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


>>>> nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034
>>>
>>> Thanks, I couldn't remember this discussion.
>>
>> It just happened late last week, so no worries.
>>
>> I believe we can get rid of bio and bdev dependency, and I am working on
>> detangling how to get the cookie through without these.
> 
> Keith,
> 
> I think we shouldn't have an issue *today* because the only non fs
> I/O that can be polled is the fabrics connect, which has a payload
> and hence has a bio. The minimal change to fix the regression afaict
> is protecting against a polled request submission of a user command
> that doesn't have a payload (just fail it), which again, shouldn't
> happen afaict.

On top of the fix you already suggested of course...

