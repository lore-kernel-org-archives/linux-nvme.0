Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF9C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpaDBvskrRdFcVSJcvcoeHNodZq+DBRwbSThE3+BCHQ=; b=NdjtJ7tTV+nZD81IkTmpCNTxx0
	SkWkEyMixKjyjS5TPwV56Sa+mKBjiABu8AIiQ/iUJzkmiEbjkdcmwMigI5tt2vNIaVdSGmyvlIfid
	g+wcwDzbfYtwyDaf4wv4L2rq4zRc3xGCcoXDQPImq0TZAvc7eI+1oovJC/KjIhk0gT6dNujuLape2
	fk3sGGZFb1jLioFT0TbUtSuRkTVlAaNHkL1j4pOTeeK6VTA8XO0e5yop+fAP+I4H09w+3d1NAlnKJ
	s7z+wFdPRskgfGxOHMR56c/tMr6x5jen/JmPgTTmb6Uibmer27g8aBKvrg8l7H5ndDbMtYo/CiyzJ
	4Kg8nyNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9iw-00000007c8I-0pYB;
	Tue, 12 Mar 2024 21:31:50 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9is-00000007c6S-3ewy
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 21:31:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e972c8b67so585433f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Mar 2024 14:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279103; x=1710883903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpaDBvskrRdFcVSJcvcoeHNodZq+DBRwbSThE3+BCHQ=;
        b=gozGXSzAWuw93iwrv+olfaL6sPLvO1Dk4dApHrC/RJC9TZNMmcv8ZLm5ctrLPoAj2c
         +/uBCWXlg/PlyGp9tvnsQ/5BjAlG05sczkmFtuSaJ5J8LWamRSoyeQbQIM48aQG2JH31
         4OgOLZxYNuCjFBaQZb8+Hc3FBZSz7mqNBXBKAqcF+kQwLA/QTXUqH/zQnvTQ93Ck0CNg
         cDe6SUJFwvlze3mN+/BrDj3uUNVkqyddI5jgSq8uOwfVz6HpFCIxjj2r5CiKhzRYwSU9
         o4wI3vN8a5o93mMDMS7wxDlv/n7Pf8GAXU6x/LiZj+A1E5JSETCoWUlI57RRKZXOD+rK
         9tCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeE2QQ9HvYvFl1oz0Q8rRnQJgsldmL6ZxR/pG6qLIYKeQRPUw/18lGdOobMsD5wTZNrSLpodb1gpZUSX5zhRPR4pCHx+sV4ERaw6nFFFM=
X-Gm-Message-State: AOJu0Yz/xEFd9AHQfHvQyvtQca1TOgdgWCsFvdgRJqeMblkKOPwY7ZlN
	rJJv2Ex5GqiUYZpXz/40HnTC9ttFv5VygktmPAAFBOQaeKQ0w4n6
X-Google-Smtp-Source: AGHT+IG1Lg0waYh1Qniw7eQDQqCTrTp9XJJ3mStxKaoL/2dhAFDnqLVmKvRle62cKqfKAB/ZVl9WHQ==
X-Received: by 2002:a05:600c:358e:b0:412:f887:644f with SMTP id p14-20020a05600c358e00b00412f887644fmr7892284wmq.0.1710279102784;
        Tue, 12 Mar 2024 14:31:42 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b00413e523b7f9sm132574wmb.43.2024.03.12.14.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:31:42 -0700 (PDT)
Message-ID: <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
Date: Tue, 12 Mar 2024 23:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
 <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
 <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_143147_065903_905C6907 
X-CRM114-Status: GOOD (  14.19  )
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



On 11/03/2024 13:19, Guixin Liu wrote:
>>>
>>> What do you think Sagi? Or may be we can declare that 
>>> preempt_and_abort is not supported, just
>>>
>>> like SPDK does.
>>
>> It can definitely come incrementally, but at the very least it should 
>> be incorrectly supported.
>>
>> Out of curiosity, doesn't your use-case need a fencing protection 
>> against inflight I/Os reordering during
>> preemption?
>
> The cluster use stonith(shoot the other node in the head) to protect 
> sources,
>
> and the backend storage(our storage system goes like this, so does 
> disk firmware I think.)
>
> can process write I/O operations on a first-come,first-served basis if 
> the range of
>
> data accessed by two I/O operation overlaps, for example, hostB 
> preempt and abort
>
> hostA, then host B send I/Os, the backend storage will handle hostA's 
> I/O first(by the timestamp).

So I understand from you that there is out-of-band mechanism for fence 
guarantee?

In any event, Christoph reminded me that preempt and abort is mandatory, 
so we cannot
get away without doing it.

I suggest to introduce a per-ns-per-controller percpuref, with an xarray 
that is rcu protected.

btw, I also think that reservations on nsid=0xffffffff should also work. 
IIRC there were at least
two use-cases that would have benefited from reservations on all 
subsystem namespaces.
It can also be a lot more lightweight to implement that (outside of 
conflicting reservations checks).

