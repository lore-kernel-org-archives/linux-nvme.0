Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1621C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ces5dtMU7ZC5afk8dWXkHnGo6+L3IZXa1VvHNJSOIlM=; b=VF7nNWrHBObDf57+QKdFd40zba
	s1vh+DNOayiCA4gqI4oO4qLHibqHuc3Maw8XF4Mp4GHm8KcBUp2q0xl8d6V3CK2QCaUTLJevq047m
	HyBjUZdjTAqJys/PGVeWfEppkskZGQYDDtrFL0DqnIblMPWs8bOQBH3WkkE0gGHhiDqPs3sdfJkW6
	GP2xtcZHNWqYfqes1Z916Qo93u1DD/zMYts7Yz0ToJTO7EacQKnAmF7MNLeH6KAF1kujdH7RQEIpH
	8b/hjRx8zNr3lXv98tUdjLzAzi16Gaw1TUXolkj31w7UVniZjARqx22v7z30uG8d61dfcYhQh+Sqc
	Srazy2Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhnt-0000000A2Xu-0czN;
	Wed, 19 Aug 2026 15:02:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhnr-0000000A2Xl-198G
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:02:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AADC84060A;
	Wed, 19 Aug 2026 15:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633001F000E9;
	Wed, 19 Aug 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151726;
	bh=ces5dtMU7ZC5afk8dWXkHnGo6+L3IZXa1VvHNJSOIlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVwdpjUj2RhZHfPhbtZ8G8nUUYlmllZ0pLSYdUn3kJUpLSvgtWQAb7LO5Ss4PrzfN
	 Hec1ZX0Z2U+drM5ZcaTW3TXWQPpuOgjlbKwUmRmobFVKw63BBYXMsQktvjn0L2n4mJ
	 aBrndks8MMgcHVnC/MH0rN4Hz4gqOJ+T5d5w8WPnEzQV03Y1PG9p+8ArwqSTfW+sD8
	 UgeB7lt9icrn03hY1aguoH8RTU0/Vxm0P5Cj/iGcVnKyhl6fMgfCIUwU/K8LHCvQDB
	 /CR4/Laij5tjaiaHWnjSsSJx83GR+1Fj8DXgKRVW6bfxAZY+SSR5X4utC9qMMhbcms
	 cMLGb/1N5ss1A==
Date: Wed, 19 Aug 2026 09:02:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: return -EINVAL when failing to parse quirk
 parameter
Message-ID: <aoXFbSOKEnOMrfYB@kbusch-mbp>
References: <20260815134745.7263-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815134745.7263-1-sreekuttan2156239@gmail.com>
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

On Sat, Aug 15, 2026 at 01:47:45PM +0000, Sreeraj S Kurup wrote:
> In quirks_param_set(), if nvme_parse_quirk_entry() fails to parse an
> entry from the user-provided quirks string, the function prints an
> error message with pr_err() and jumps to out_free_qlist to free
> resources.
> 
> However, the variable 'err' is not updated upon parse failure,
> retaining the value '0' from the preceding call to
> param_set_copystring(). As a result, quirks_param_set() frees the
> allocated memory but returns 0 (success) to the kernel parameter
> subsystem, silently masking the parsing failure and incorrectly
> reporting success to the caller.
> 
> Fix this by explicitly setting 'err = -EINVAL;' before jumping to
> out_free_qlist, ensuring that parse failures are correctly propagated
> to the caller.

This fix was submitted earlier:

https://lore.kernel.org/linux-nvme/20260729105958.1403095-1-kanie@linux.alibaba.com/

