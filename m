Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AB4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N88nLT4L6z/JF/RJA7o0qOw7Kf3O6B6315PPqtS9v2M=; b=DQjd81M3P1ok0NU7JQ/8mJ/jsc
	4jOZEQ2nd1sAeFcHkGwob4YovB6eilswSXOPKCoddDW7LtbZKDJpV2se7ntwUUy4VfDBuZGpVsOP0
	41PY+FJqikHkhYwEUEi/AfIhBBYDhara4RRnhpHWuRM6zMh8CyLH+a0LbTz0DxU6bI5rLjJdvQ2Lk
	qiVxhy30gdsY+TvQZt22wmjA2kKuqXAlfaMN4G1XUQNpy4GHSEAw2yWW4TjqMsaSQ3piPPK85/gCf
	UW3Tl3Q7QkPJuPRMo7sTaOl8U6meEKo0XrMWWuvPT278GoqJbEsch/Du1GuIfTceNx8SJyfM3wcja
	j5w8WOOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oktlE-00ASpc-Hy; Tue, 18 Oct 2022 21:04:28 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oktlC-00ASo3-46
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 21:04:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AF10FB81F7D;
	Tue, 18 Oct 2022 21:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D062C433D6;
	Tue, 18 Oct 2022 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666127060;
	bh=q1t1PbrlGl6iZJRB/zuNsJ66BAoVK03rUt+vkqh71e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ustaEgG4xYIT5tmqATm6n5saQUkObLGCYZIx/Gw8DOKwJNYgWEJnyxWSV76o20iEa
	 /BJVFME/GVb655+DOEi0bhesSHvNfc/F2yLtwcolJXgepvwhBmHpxtGfxOc/6N8Jw4
	 4sCus/T0C2PbA1I2FH7sGkYREOSKUoRqbzHTlyuaG77vPtV+uHeGm4zt/SnGxIxyYK
	 Px/B6b580AssWZmESEhgzrhgtu74CGf54XDTHHUOfXMz/x8bGcUla7cTLcw2nDO/Bd
	 7e7WILOPiT8frKFVhR4a6JQ4U8QbC5nyW2NvwhW66y6IkZFNnhGyi94MTze7J7W+FS
	 DGl6v2ZxAk78g==
Date: Tue, 18 Oct 2022 15:04:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [Question] nvme namespace enumerated to 2 when hot-reinserted
 into a server in 5.14 kernel(RHEL 9.1)
Message-ID: <Y08U0dr9Kgl0Pbvt@kbusch-mbp.dhcp.thefacebook.com>
References: <f3b75aec-d29a-8c6a-1b12-6cf7b83d9892@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b75aec-d29a-8c6a-1b12-6cf7b83d9892@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_140426_362220_9681207F 
X-CRM114-Status: GOOD (  19.46  )
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

On Tue, Oct 18, 2022 at 01:22:01PM -0700, Munoz Ruiz, Francisco wrote:
> Hi,
> 
> 
> We are hardening our tests for RHEL, and we'd like to know if this is the
> expected behavior.
> 
> After a couple of tests via trace-cmd and booting with
> nvme_core.multipath=N, we found that the number "2" presented to userspace
> comes from nvme_init_ns_head()->nvme_alloc_ns_head() when an SSD is
> hot-reinserted
> 
> 
> ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
> if (ret < 0)
> 	goto out_free_head;
> head->instance = ret;
> 
> Then in nvme_alloc_ns() the string representing a disk name is assembled via
> sprintf because nvme_mpath_set_disk_name returns immediately due to
> multipath == false
> /*
>  * Without the multipath code enabled, multiple controller per
>  * subsystems are visible as devices and thus we cannot use the
>  * subsystem instance.
>  */
> if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
> 	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
> 		ns->head->instance);
> ns->disk = disk;
> 
> 
> We also observed that the ida API used in core.c was updated in a recent
> commit 8b850475c08caa9545c460d7. Does this fix the namespace numbering
> presented to the user via disk_name? if not, should we pass our tests if
> nvmeXn2 is observed instead of nvmeXn1 when hot-reinserting an SSD?

If the last number is incrementing, that means something is holding a
reference to the older one that you removed.

Assuming a reference is being held, a hot remove-insert sequence would
expect the controller holding the namespace to be removed. The
subsequent insertion would have the controller enumerate with a new
instance number instead. Ex, if the namespace was nvme0n1 before, we'd
get nvme1n1 next time instead of nvme0n2. Or are you just detaching the
namespace without detaching the controller?

