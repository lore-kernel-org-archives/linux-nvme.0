Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F16C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFwP6/aEzDXb7V3asjHCxB7mLohKxyQDXCmx48m6brQ=; b=jpwKo4AMhZZQAVfCQ7lIRfk4+R
	iNffgUcDCJn1DoA7j3X3yK6unSlO7/Yt2oieIg5kKGTIsd83qpvwxALTeHyJ/ayKES6hmyVCXsfcf
	PE6Fr/5czYI5qNqMC4Z/+8pwMo4cPu7Sxru8d9Q5xMq+C5wpqhI+aTd/X/G9v468qjlxHl6AHE5Vd
	VnFHp/ZZdkgezH5pDWnGSRw3vMBC9Tt8DsHQczp0Ds/9AMNbzq1JJbCvHLjzkpNgiNiMwulGVjCrz
	qB1s/ODfVwI712FPLw2vVOoedZbiZH++Tv/LYOFvvSzLwZv/MVsN2tueM9t6CUghi6089NGlmThxF
	2xj2s7gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQBT-007dRM-Sj; Tue, 22 Nov 2022 10:07:19 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQBO-007dEI-0u
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 10:07:15 +0000
Received: by mail-wr1-f47.google.com with SMTP id s5so6712767wru.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 02:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFwP6/aEzDXb7V3asjHCxB7mLohKxyQDXCmx48m6brQ=;
        b=rO5YetrFFF5+8YOe8jy4T+EEW6UUHTstEHNy2NcWRPnqxt8l5tuEa/d0FaNE5RHZBx
         Tr8xWUBzZjrJYPxWJGKBqbpAhc+cpGJz3fQhpgQlPRoZPhbSUr0VdMPGJ7kKbSPrF+IV
         2RgUEHCjO96NP9RJX2P8A5zImbD4SnpJPnS4rJ4JToxOc4/HA/AnxbKjD4Xe1JF693IG
         w3/FN5KsW8ztUO/ijfLjGUCUJdDIo5NTLMT+MZ2OxvmUIdsgH+bzcLOUAjnYUvLKlQXT
         LOs9Dpv1cg9wKVtUS1c44KtP814p9iduja3oNUnzacW0dMavdo/Dqs1sX5OaIiiMN3C9
         Lb2Q==
X-Gm-Message-State: ANoB5pkhKtTKa+gAjzCHmNGaYIZQjBTYPpuMPyaTL5c8cVJj6EXFeXIs
	u5vB9Zh2K2FJMJKkoORwXgw=
X-Google-Smtp-Source: AA0mqf5AxbeRwZdSKauvx7oVfhW36DpZrOMv9W5Sf/z3RYPpqsRuCCPDd5ua3Aul7lWEMtT3jNX4KQ==
X-Received: by 2002:a5d:408e:0:b0:22e:3397:2e96 with SMTP id o14-20020a5d408e000000b0022e33972e96mr13353720wrp.535.1669111619251;
        Tue, 22 Nov 2022 02:06:59 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b002366f9bd717sm16249436wrx.45.2022.11.22.02.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:06:58 -0800 (PST)
Message-ID: <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
Date: Tue, 22 Nov 2022 12:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, paulmck@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Uday Shankar <ushankar@purestorage.com>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_020714_129175_3DC5AE20 
X-CRM114-Status: GOOD (  17.44  )
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


>> Of course, the easiest thing is to try it both ways and see if you can
>> measure the difference.  If you are unsure whether or not it is safe
>> to replace rcu_read_lock() with srcu_read_lock(), you can just add
>> smp_mb() after each rcu_read_lock() and before each rcu_read_unlock().
>> That won't be exactly, but it will get you quite close to the cost of
>> srcu_read_lock() and srcu_read_unlock().
>>
>>                                                          Thanx, Paul
> 
> Regarding your suggestion to use synchronize_rcu_mult() to wait concurrently,
> I'm not sure it's possible to write an equivalent to call_my_srrcu() here,
> since the srcu_struct is per-nvme_ns_head rather than global.
> I think we would probably need to synchronize with RCU and SRCU sequentially.

I don't think rcu_mult is necessary.

Lets look at nvme_ns_remove.

1. clears NVME_NS_READY + synchronize_srcu()
    -> guarantees that nshead->current_path is not re-selecting this ns

2. nvme_mpath_clear_current_path + synchronize_srcu()
    -> if this ns happens to be the current_path -> clear it and fence
       concurrent bio submissions

3. removes ns from head sibling list + synchronize rcu
    -> this should fence non-sleeping traversals (like revalidate_paths)

Maybe it is OK to have it also srcu locked and just accept that
nshead sibling list is srcu protected. In that case, your patch
needs to extend the srcu also the clearing of current_head pointer.

But looking again at your bug report, you mention that there are
concurrent scans, one removing the ns and another accessing it.
That cannot happen due to the scan_lock held around this section afaict.

I guess it can be that in general ns removal can compete with a scan
if due to some controller behavior that failed an identify command
transiently in a prior scan, and a subsequent scan finds it? worth
pinning down exactly what happened in the race you got because maybe we
have a different issue that may manifest in other issues.

