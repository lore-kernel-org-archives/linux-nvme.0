Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A498FF8868
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLQrFz5Io0HWrBbPfgkDM3Mh0/GOTFIXHrUB8jjZJ7o=; b=q4YFXFlbC2Ybaz+aPoARZ43N0N
	0OvMa1NVCNRWLfeeUmzi0DrrBWhcwmtzC5FXpqhLi3QktfuCkuwATzCY+dL2L9bUH0VkafE2BfVsX
	xrPlNu1JZAMXCPJZyLu8jut9xsZyQ8TuZJwEg5LoqmuXtUs7GrqHj+ncTgz82Dh92ta1PVIuajPl7
	7S9KnvanTcl6kosLWkTqIEYDsA+DNG+b0thc/BVBXl/6xsV4Fp8dpQEOAEQZtMR/l/NaXH67IUwfq
	BOUZMBPwb34EA2kAUSduuOIsEse/Kkffg8R3pAbNrdyhiBN8uioWvPkW18Hra2voTdDrXorHYeXuB
	Lt0tgjiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHS80-0000000059R-3sfB;
	Mon, 27 Apr 2026 20:00:24 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHNln-0000000HBNK-1qgn
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 15:21:12 +0000
Date: Mon, 27 Apr 2026 17:21:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777303266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLQrFz5Io0HWrBbPfgkDM3Mh0/GOTFIXHrUB8jjZJ7o=;
	b=d2odqkFTtOfYMHI6l11Y5qQhA/SgclKDt28mdbZOL4QKwSBMCsVWgOaXpb+D3OD1S8sCMl
	gp67+l5XCzoRpQ/3oTRyD21Y36dD3Ub7qcGdki+5UEcfdd62f9B02S/9uDFtQdFWWSGZWN
	m4B9082FAFULSmXJfIGO4UYhh3NWiLHCIjdx2zNx9eCwuuXgUxx0gol0tfTWFMJuxsM78X
	g1PWOd8cwwJy/dtYhZ9H5KOuEKSu+8d/Eeg6qig54XYbdQXI+ISOcg+7AeXpaIos6slIIq
	Z0El3jx8p/AjP60KN5+rLkoBMz0Qn8ba3qWJhW0QGjK2ez776mOM8enhTVEQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777303266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLQrFz5Io0HWrBbPfgkDM3Mh0/GOTFIXHrUB8jjZJ7o=;
	b=ddMw9PoHj38WUcP0Ahe1qRnWtNk7mF4VE4gCD/um/VTkXCw0TKFpzNLUdzZPWOOEnsfhdo
	qsix0uECSoYIa/Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com,
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com,
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v12 02/13] lib/group_cpus: remove dead !SMP code
Message-ID: <20260427152104.WTGAesGs@linutronix.de>
References: <20260422185215.100929-1-atomlin@atomlin.com>
 <20260422185215.100929-3-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422185215.100929-3-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_082111_697937_90B1A8E0 
X-CRM114-Status: GOOD (  18.24  )
X-Mailman-Approved-At: Mon, 27 Apr 2026 13:00:22 -0700
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

On 2026-04-22 14:52:04 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> The support for the !SMP configuration has been removed from the core by
> commit cac5cefbade9 ("sched/smp: Make SMP unconditional").
> 
> While one can technically still compile a uniprocessor kernel, the core
> scheduler now mandates SMP unconditionally, rendering this particular
> !SMP fallback handling redundant. Therefore, remove the #ifdef CONFIG_SMP
> guards and the fallback logic.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> [atomlin: Updated commit message to clarify !SMP removal context]

This look unchanged vs previous submission. You could explain why you
want to remove the !SMP case. It looks like the !SMP makes things
easier ;) I don't know how much of this gets removed because of !SMP
code elsewhere.

The description still does not make sense/ is accurate.

> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  lib/group_cpus.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index e6e18d7a49bb..b8d54398f88a 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -9,8 +9,6 @@
>  #include <linux/sort.h>
>  #include <linux/group_cpus.h>
>  
> -#ifdef CONFIG_SMP
> -
>  static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  				unsigned int cpus_per_grp)
>  {
> @@ -564,22 +562,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>  	*nummasks = min(nr_present + nr_others, numgrps);
>  	return masks;
>  }
> -#else /* CONFIG_SMP */
> -struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
> -{
> -	struct cpumask *masks;
> -
> -	if (numgrps == 0)
> -		return NULL;
> -
> -	masks = kzalloc_objs(*masks, numgrps);
> -	if (!masks)
> -		return NULL;
> -
> -	/* assign all CPUs(cpu 0) to the 1st group only */
> -	cpumask_copy(&masks[0], cpu_possible_mask);
> -	*nummasks = 1;
> -	return masks;
> -}
> -#endif /* CONFIG_SMP */
>  EXPORT_SYMBOL_GPL(group_cpus_evenly);

Sebastian

