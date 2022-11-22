Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDDAC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZcekbdEI551+xMleK57vCF25zgoBz6qxuq/cA6kByE0=; b=HQ8l3X78gHYgTJ3S8R/KFCuhMK
	zFWokAfrMiWnNYEMShXVsi2QfGGyeOhBMUw/cLH8LtstCzqjS2U/+35E9OCnsLalIBfh9CfDUs9kC
	vI2Pq9fNl3Ycy20w8tI1kGnCUjkNLigqQot02UZfaa+oh7Mq+Bx3kCrocEuhTBy4C83G4qhL/MD6I
	MLBKrFPtSY1R7BPAq2b0btwbv+J/OTKKQ6LbeEgMv6vU3DphQvOENo8GJnv/hgAk8flsYyShz/2eh
	Loi8j1RCp6nMg101wRF46LyszXO/mJHNzRPRTsrw/maixQJKjMoRKjc09osKHzLgSl40r6n1F+XE+
	nVV2knsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUtC-00ADJ7-F5; Tue, 22 Nov 2022 15:08:46 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUt8-00ADFO-LG
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 15:08:44 +0000
Received: by mail-wm1-f49.google.com with SMTP id h189-20020a1c21c6000000b003d0283bf132so1069820wmh.4
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 07:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcekbdEI551+xMleK57vCF25zgoBz6qxuq/cA6kByE0=;
        b=W1g/kpwCpP4LxnZM86ExjYHCnzyvQShdqCSmQfomaqBdFl+Svy/BaY0Rc9HypS6eDT
         tHzZZrqPsH4+Fk7Ww9hQX6uftuXHzIbnw3YwN7cg0BGay9K74WXTnRZTMlCz9moQ5+IU
         fcD8BeDRidWAQh2rg50D8X94ozNfXdcIGaJc2mLUDb0w8Z8l1y8/enBRn/OxTt8a7G3C
         ThIoHTst1qChETA6XrC7CyMJPS5xBkvWjS0vPmm+2VXl5gn0baJf79iE7d6vK5iZ4Yy+
         GOxWcXZ2/q8K1N1Psbs+tZioLGDWu/+7GQ0cpAO/oq6ixXIfchv/DOAAdZdWkD/3K3NV
         awOw==
X-Gm-Message-State: ANoB5pkIQ0QwUKqy7nyoXspkgjSnvmuvX38C8k1IMqCH6bwTTo/9tzs9
	3MnJ4+WRdjhhtnGIdP1gew4=
X-Google-Smtp-Source: AA0mqf4aASfZRI8w5IMTfQN0ZP4YdxyKOCv2xRKRKx0clJMBzPkLBeksfym/79MPZMznJEifDEX9DA==
X-Received: by 2002:a1c:ed04:0:b0:3cf:d08d:3eb2 with SMTP id l4-20020a1ced04000000b003cfd08d3eb2mr16834181wmh.129.1669129716785;
        Tue, 22 Nov 2022 07:08:36 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003c6cd82596esm22031601wma.43.2022.11.22.07.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 07:08:36 -0800 (PST)
Message-ID: <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
Date: Tue, 22 Nov 2022 17:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander <csander@purestorage.com>, paulmck@kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Uday Shankar <ushankar@purestorage.com>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
 <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
 <20221122121449.GA3888@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221122121449.GA3888@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_070842_809686_DE499BCB 
X-CRM114-Status: GOOD (  23.28  )
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


>> 3. removes ns from head sibling list + synchronize rcu
>>     -> this should fence non-sleeping traversals (like revalidate_paths)
> 
> Well, non-sleeping would only matter if those non-sleeping travesals
> are under rcu_read_lock(), but they are not.  They are either part of
> a longer srcu critical section because other code can sleep, or in
> case of revalidate_paths unprotected at all (which this patch fixes).

The original patch comment was that rcu_read_lock/unlock would be
sufficient and we don't need to touch nvme_ns_remove()

> 
>> Maybe it is OK to have it also srcu locked and just accept that
>> nshead sibling list is srcu protected. In that case, your patch
>> needs to extend the srcu also the clearing of current_head pointer.
> 
> I don't see how nvme_mpath_clear_current_path needs (S)RCU protection.
> It never dereferences the current_path, it just checks is for pointer
> equality and if they match clears it to NULL.  (I wonder if it should
> use cmpxchg though).

Agree. it can stay out. because at this point it does not compete with
concurrent submissions due to prior synchronizations. The list traversal
needs to be under rcu lock.


> 
>> But looking again at your bug report, you mention that there are
>> concurrent scans, one removing the ns and another accessing it.
>> That cannot happen due to the scan_lock held around this section afaict.
>>
>> I guess it can be that in general ns removal can compete with a scan
>> if due to some controller behavior that failed an identify command
>> transiently in a prior scan, and a subsequent scan finds it? worth
>> pinning down exactly what happened in the race you got because maybe we
>> have a different issue that may manifest in other issues.
> 
> So scanning itself should be single threaded as it only happens from
> the workqueue.  But nvme_ns_remove can be called from
> nvme_remove_namespaces in in 6.1 and earlier from the passthrough
> handler.

The original patch report did not include any sequence that removes all
namespaces, and given that it came from RockyLinux 8.6 kernel, it is not
6.1... Hence I think that we need to understand how a namespace removal
happened at the same time that the namespace is being scanned. Maybe
something else is broken.

