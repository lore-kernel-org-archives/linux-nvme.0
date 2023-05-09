Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3F5C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W/N3pcBfnQPBnUUMgsRi6kpua3qjfmkeyC4zps5w8o=; b=LeUmG+bz3M9ih1tNDN6vbYCBFn
	RTqaN0fr6qltZuI6P3oTLPVc04QG99SvS/G4Glf0EC5DW2Kmy7/m4zKYCSo2CVEJM1DkRUNmWfD69
	vQ/PpLP19LVeQZgBuuJ9ikwMfAVZIO/5X87KGxnVZ/RLX50F8z6U/3pSHe+nhOQUTNl82VtBkGTBx
	3zw6e/Vg0tcHFset/uElSVU3xhPeoYUbg9F1z0yWLuLcm+nuks+DxJ8PWRmtz2587O4ZoDXhEfqJd
	ULT3Tsi0iRjzrJI7woSkEoBiLZlZa4u3LxjWhrvqAwj8cqLsn8rFj5I/Lv7X6B9+O1q+aqc5WDwT4
	HSt1veIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWyY-004Xc2-2f;
	Tue, 09 May 2023 23:42:34 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWyV-004Xb7-1N
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:42:32 +0000
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aad55244b7so50053645ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 16:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683675748; x=1686267748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W/N3pcBfnQPBnUUMgsRi6kpua3qjfmkeyC4zps5w8o=;
        b=WqlisDYmFdIXJ3RUSmkXPb2ktU7ZSFb7U4zAoMZ3AWD83KGHEMagNyrvm09wOhRyPm
         sRFWXG3ZDq3XbHWwP6fWWOim76qxFQYMZp8Jr2v6oj+o0+XSJ8YI4L5nLuCiTgszt3uH
         YHtGkfM/tfK12bo9wPUIKVViCyUXjfCwUn592oT0Sd1BbxbH7cx9EbkiZ+8t69CxyGtN
         eCOAAUGVHXJSZy00kmHLAMOOc6orFjZPscqPQUbgkVgL+pxG/INuSil4LRLnmZZHI7Yt
         /2D2K5Z5KUWfM7l1pvMXJ1H9QtssXZlh1GqeFooBsri9ouWaYx3QYcwNVxTNE6kuLbVf
         sssQ==
X-Gm-Message-State: AC+VfDx0nMk7BGbqY5e7160A1dcEDpAIpOBHzdN1e7kMX9imYBd9IAUY
	bNes2LGh8QryC3nk1IgzlAM=
X-Google-Smtp-Source: ACHHUZ5aOsFgw4JgjZ+hWBJiDwR+ReG1NbNtErj/SeI8JMK1HvmWlw7Kmb4ee+8yoSGo4LbThSSOEA==
X-Received: by 2002:a17:902:b94c:b0:1a9:8769:36b7 with SMTP id h12-20020a170902b94c00b001a9876936b7mr15776117pls.5.1683675747987;
        Tue, 09 May 2023 16:42:27 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001ac69bdc9d1sm2233949pln.156.2023.05.09.16.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 16:42:27 -0700 (PDT)
Message-ID: <b076b23c-8d85-8187-e6b0-32e9f5783985@acm.org>
Date: Tue, 9 May 2023 16:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
 <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
 <046765f0-01a9-eca7-7f36-a0b62c7beb93@nvidia.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <046765f0-01a9-eca7-7f36-a0b62c7beb93@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_164231_485449_11384A2D 
X-CRM114-Status: GOOD (  14.04  )
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

On 5/9/23 16:24, Max Gurtovoy wrote:
> But the concept of "dirtying" the base code only for the sake of the 
> above reason sounds like a bad practice in general.

The use of the words "dirtying" and "bad practice" in the above sentence 
seems completely inappropriate to me.

> Maybe for that we can have some mechanism of side patches that one apply 
> before running the blktests ?
> This will leave the base code clean but will need to maintain these 
> patches to be applied cleanly on the base code.
> But I guess we can have some automation for that..

So you are proposing to maintain this patch as an out-of-tree patch? 
That sounds like a bad idea to me. Anyone who modifies the NVMe code 
wouldn't see the out-of-tree patch so the out-of-tree patch would get 
broken quickly.

Bart.


