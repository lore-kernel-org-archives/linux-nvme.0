Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3B3C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scQWPxTX6leGCHoMVtk1H+uYIxgRXtieeMFrI4vjiow=; b=eFjcjKFi4UdZY4CySjXunvXb3O
	PZv/dgh5zLN4SPGIxu3Z0C+c3gXsB8t8gTa37F8k08f1t/02L4AXdURmhNSjFkZdtdMhr2wJyP6tR
	rLfzVfimWvQTZnAdk5NMBAjQTvR58b1vwPOlYH1Uh/myHFJBmRJ5ICKIQ0U/cS9ETqKX1UStsbx3z
	yj5upUBtZGC2kM3rP00Wly1VwwZMHMT18IsQnttFcWmCiY+6qTK9SIDG+2/6okdLLyCPEyA/Tq8Ez
	GSKdqvrVfkE+YDDye9fG7vYjObLi0pkXmSh8OTu0z1PwZwxMtGGKot9ICx/tlQHuF9k2fkWlnKAVR
	hViyQnbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58zL-00000000BuT-0CUt;
	Fri, 11 Sep 2026 21:40:51 +0000
Received: from mail-wm2-f13.google.com ([74.125.225.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58zH-00000000Bu4-3td8
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:40:49 +0000
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso336915e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162846; x=1789767646;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=scQWPxTX6leGCHoMVtk1H+uYIxgRXtieeMFrI4vjiow=;
        b=mRGvCakhrhM/O6bjYA2env1Ib5f6PGBMx/J6xJ0wmIXU3OjW0ocbfZbDSrzwOXvamy
         SwIXmnhWc8XZbvCfMHcw1JFZYz6LessJ92gHO7Q8o5FEHXV85kvTl5YhUcMm3NIdvait
         91P5KsYEjjjaI/J+annmVQ/3SxT7mF+vlqfBYnV6CmACkDpIW6cKMk3Ipg1Z/tVEd7NC
         DkSXTPWDqSYeQQgCJpxKZS12Wi6x5ip3aN5j6x72W6WtnLrsGFvS65YX/Wtcnq+Vltbt
         JGhA7QOn5Dy2jtNiqxPbgi6gVl1ptKSNyAvjTHHiYlYgUQgVnVYvnf+Ua3y+wQHo31FJ
         3GFA==
X-Gm-Message-State: AFuF++nN5F1ITIrp2/PdGtXaHbSXsv+wUcztuM9F78dMpMCEhWkgci8U
	kk8Sz9/03+fsl1kB0v9U9ubXiUh8Nv/42Kb99/E3oChP6Vakq5ZxSAsk
X-Gm-Gg: AYBFou0H2skf7tNaCunuoNnZFwjANEIPVCqCVtNty+FBto/VAbBZoRCuNrE2yJ94xg7
	k7Oh1vCJ2EGdLH+izR9vJLdsHP5rkUhcB14GmnGd6LmCGIwjrfpCVxG71S8Yj3si5wFOxehTJmn
	egp6DwtLh1B8zrCBU+uEbHwqOiYFzOYD4ftb+es/JqI78siLLU5K0RAO0sE+WCS7fjY+PiKJcHx
	F4hdNMV1IwhCPmwpeLjBKDbOjLh4Xn0vEWUwwPy4iDhaePBMio0tJaBWOrQVsnXaKgjiPJgKPj4
	iEEGI1U5KxEzoiuutMVTnK3U02aV69ji9D9c+CUB80n5rK1u6v3z3mQ4e0MzdQA8/neH4chzn0Z
	0d5bqQnsFnhzNHkt6P8nb8WMczGdtwNi1ICMnaVVuvUUlnTwCA1Mtxebl3lHGneT2LMU1AxJgFl
	uXXD+f8MyoHksAfa2PTG8OZCs9kVqJEt4DSl411eMZHav4lUdOWF+uEkQzl7pEmR0B3DhPHxoMP
	3aElwl+YID0cdK9s/BNIWrGIyd8ajmU0Q==
X-Received: by 2002:a05:600c:5394:b0:49c:fa20:cbff with SMTP id 5b1f17b1804b1-49e6cbfeefemr345985e9.22.1789162845841;
        Fri, 11 Sep 2026 14:40:45 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfb5sm196305985e9.5.2026.09.11.14.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:40:45 -0700 (PDT)
Message-ID: <3a06fc29-4364-4573-b12c-39b42d95a4b3@grimberg.me>
Date: Sat, 12 Sep 2026 00:40:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs
To: Andrew Stellman <astellman@stellman-greene.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260910154849.66095-1-astellman@stellman-greene.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260910154849.66095-1-astellman@stellman-greene.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_144048_016180_41820B98 
X-CRM114-Status: GOOD (  20.82  )
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



On 10/09/2026 18:48, Andrew Stellman wrote:
> nvmet_ns_ana_grpid_store() and nvmet_ana_groups_make_group() accept an
> ANA group ID in the closed range 1..NVMET_MAX_ANAGRPS, but then pass it
> through array_index_nospec() with NVMET_MAX_ANAGRPS as the size.  That
> helper treats the size as a half-open bound, so the maximum valid ID,
> 128, is rewritten to 0.
>
> nvmet_ana_group_enabled[] is NVMET_MAX_ANAGRPS + 1 entries wide, so
> index 128 is a valid slot, and the controller advertises ANAGRPMAX =
> NVMET_MAX_ANAGRPS.  NVMe Base Specification 2.4, section 8.1.1
> (Asymmetric Namespace Access Reporting), "ANA Groups", defines a valid
> ANA Group Identifier as "a non-zero value that is less than or equal to
> ANAGRPMAX".
>
> Two visible effects.  Writing 128 to a namespace's ana_grpid succeeds
> but the namespace lands in the reserved group 0, which Identify
> Namespace then reports.  Creating and removing ports/N/ana_groups/128
> increments slot 0 on create but decrements slot 128 on release, leaving
> nvmet_ana_group_enabled[128] at 0xffffffff, so every subsequent ANA log
> page reports a group 128 with no namespaces in the Inaccessible state.
>
> Use NVMET_MAX_ANAGRPS + 1 as the array_index_nospec() bound at both
> sites, matching the array's actual size.  A namespace assigned to group
> 128 now follows the same path as any other group: its ANA state is
> Inaccessible until ports/N/ana_groups/128 is created and configured,
> where before it sat in group 0 with an uninitialized state and I/O was
> allowed.
>
> Tested on 7.3.0-rc1-qpb-cc-base+ (unpatched) and 7.3.0-rc1-qpb-cc-anagrpid+
> (patched) in an arm64 QEMU guest with nvmet over NVMe/TCP to
> 127.0.0.1.  Before: ana_grpid written as 128 reads back 0, and the ANA
> log after mkdir+rmdir of ana_groups/128 lists group 128 with nnsids 0,
> state inaccessible.  After: ana_grpid reads back 128 and the ANA log
> lists only group 1.
>
> The issue was found by Claude Opus 5 running Quality Playbook, an
> LLM-driven code review tool:
> https://github.com/andrewstellman/quality-playbook
>
> Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
> Assisted-by: Claude:claude-opus-5 [Quality Playbook]
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
>   drivers/nvme/target/configfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 413ee2d16d29..0d4c69c4697a 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -698,7 +698,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
>   
>   	down_write(&nvmet_ana_sem);
>   	oldgrpid = ns->anagrpid;
> -	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
> +	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS + 1);

There is a condition above:

>   	nvmet_ana_group_enabled[newgrpid]++;
>   	ns->anagrpid = newgrpid;
>   	nvmet_ana_group_enabled[oldgrpid]--;
> @@ -1976,7 +1976,7 @@ static struct config_group *nvmet_ana_groups_make_group(
>   	grp->grpid = grpid;
>   
>   	down_write(&nvmet_ana_sem);
> -	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
> +	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS + 1);
>   	nvmet_ana_group_enabled[grpid]++;
>   	up_write(&nvmet_ana_sem);
>   
>
> base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c


