Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8CFC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87UOMueoSNTje0/aDJgUGwiUI2SdOpFVV8vGxaKKCEk=; b=FAyz4o/rwn1H0vsRaKCMMEyOWr
	bSuH6jgWnfHc24+XVxuIPcjr2AdDxqSW8Go6C2KbE6nHv7PmUWKqtV6b2bQ/9z2pPyY8aPDCAYS8a
	V3cJOHVvonHectcVZQ0enqUd0ymeSKtm1UUPKf1hyD2Mp4/y7Hlb1vgDkcUXh50neCFuIj6eTQmSQ
	XBfUHqlywoRnasPJs27vYPHuYro5f5v76qFZnmiEaKpjfg3tfEBzW4F5/FmdKVHL/VsnElkrvrV6u
	+664CVPitpatSlRLjU6+kOI/lbx/7oKjk4LyzGSjKttKOXxQA/Rb6jTq7E50LhfeC+381AEaJUSFm
	xStzRKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKFy-005Xez-Bw; Tue, 25 Oct 2022 13:46:14 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKFv-005XbX-Nv
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:46:12 +0000
Received: by mail-wr1-f46.google.com with SMTP id a14so18317707wru.5
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87UOMueoSNTje0/aDJgUGwiUI2SdOpFVV8vGxaKKCEk=;
        b=wSgra40prWrZubul0Wk14fFaRKrULhUZ7Y0+pwM2XjqWOokbTsDcg6HPWwlyH1P2Jl
         SD2Iyl6PIwYBUady3zKjH3P6Pv7ogegA+KOp5onOtVMY1Yx+Pi0q42zknmAgprMWSsO+
         /7LjbsvOjGxAQFEMenMt4lKzg7rqcMU2GilTtQY42f2UVMOZVWxzuI9P4f4d9DxSY9Zk
         K4aptQzAj2TPZklrZUnu5FZJB+Xeyx4da+M7K+jvxobnLROMSgsUkAa6qSwsfoae3gMr
         550lwMcx7zJRo03FYiq4FiNJ0PoQ8c/f3G6sT4UducxvmWmdVghkLhs2oVveBCnv39Tp
         BOug==
X-Gm-Message-State: ACrzQf2yJhlAT0lpxiruzCxVUXAOzeqNbIbC+XerB0s3dpNM1cFK+nTu
	cs6MX7UmWlZbQwRv7m3+wfE=
X-Google-Smtp-Source: AMsMyM7VYBdqPebLTZqeQJBY4Betsac3+Kx/ZNxcULzMrTtlaC3qbuTYXT/Qx/5VgkOfRItPzTE3cw==
X-Received: by 2002:a05:600c:4999:b0:3c4:df99:5596 with SMTP id h25-20020a05600c499900b003c4df995596mr26554964wmp.154.1666705569980;
        Tue, 25 Oct 2022 06:46:09 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003b49bd61b19sm11548395wmq.15.2022.10.25.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:46:09 -0700 (PDT)
Message-ID: <9f40e42d-7525-5644-6773-19e3b842f7f1@grimberg.me>
Date: Tue, 25 Oct 2022 16:46:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
 <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064611_809048_A524ADAB 
X-CRM114-Status: GOOD (  16.98  )
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


>>> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
>>> large amounts of requests.
>>>
>>> Cc: Hannes Reinecke <hare@suse.de>
>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>> ---
>>>
>>> IMO, this patch might still be a good idea to add. At least in my test
>>> setup where I only have one ethernet port it makes a big difference
>>> when accessing the system via ssh. When nvme-tcp is pushing a lot of
>>> data via the network, the ssh session is completely blocked by the
>>> storage traffic. With it, the ssh session stays responsive. >
>>
>> I'm not sure whether it is possible but is there a way to gather
>> some form of quantitative data and present it here to we all know
>> exactly which aspect is improving by this patch in context of
>> "ssd session is completely blocked" ?
>>
> Doubt that we can do it. Point is, the send code will run in a tight 
> loop, making scheduling of other processes / packets really hard.
> So if you have several processes on the same interface (as here with the 
> ssh connection) nvme-tcp will eat up the entire bandwidth sending its 
> data, and everyone else on the line will suffer.
> 
> I guess the same effect could be had by adding a 'schedule()' after each 
> nvme_tcp_try_send() call.

Daniel, does adding cond_resched() make the system responsive again?

