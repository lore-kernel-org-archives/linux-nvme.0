Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D767C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 04:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9d1a6daFwQBP+JMhfWhKWCeVA+a5Q2tDHFKvp5Evgc=; b=gQDnGIuvzQZ1REhAlE+EjwpoR9
	T/gpW/4Ew6bOEqltfsN0Td/vasJvDG6XUa9SnVSdcRBdxGAoJDm6n/CZ44l4XY9XgZDUXjxVyk3fO
	SvV2x8CUNuyxrYB+ZQ0se9Iml7IeV9UoPn6qscDkjqXP4dYrXbWfoMJGGLJ1waOuXV1PO/hEiRhXv
	eWhS9bxNw9G39Qjk8c2dQFund79OyU0+Rnt0SZnebmdheJdtbtUnVALUzI+03yK6jPwiaeydZfYO0
	W1UktAje+ZNk8+tjpHCWRw+TasMUorIlKJuuwpmyI1+UBA7XmaDKoPee3bJiQnUvqGYddYGr3awRW
	A9PKiwjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rN41k-006w8G-06;
	Tue, 09 Jan 2024 04:47:48 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rN41g-006w7d-23
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 04:47:46 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so902249a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jan 2024 20:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704775662; x=1705380462; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9d1a6daFwQBP+JMhfWhKWCeVA+a5Q2tDHFKvp5Evgc=;
        b=rCUIQ5VmYGWWtnM4acYORf6WdBx/10snGvTF+mQStbSbOtzYmHW02BiMWKthh7mSu8
         oBhBZLT5RAMybsbpDyg2n5Gru4qeh2P/eqxqbsYTfwnZgJrViS3eMh75o8p1jj8cIPom
         /crBbrGhc1tN7utwz4qZqBMXYfSJm+qu+D4EnieLEt8Csx3KiaM911fURLO9Ce3+Z+q/
         mgM2BvixOfh/fpiweBfpVroBHhMA6xmHebVUpR6aD1e5ooqVgNeBI3jZCLAeWGJfS9r9
         tDLJX4d9iy4/WYEVipJxF28J8uCxKzc44sJaq61Zuk1ONTUGRBTwHeZ/+d+FElNumGFi
         6pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775662; x=1705380462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9d1a6daFwQBP+JMhfWhKWCeVA+a5Q2tDHFKvp5Evgc=;
        b=c2NuDbEiO7hLjSqPm2S6x6vwsSxoCIuGkJkBEcL6HcaVoM+JtJZ7iDJBNoDcxUeXXf
         c8ac3fuoEKlniobjZdaPVj0NRoq7r1h8R9ORAFPUNHJaVHHkU1gVSwf7sQ0v+0FAgljU
         yor1Qi7DG0fxpVXyn6hDXRER0mGUaROC9V8CpB41/WCGmSTg/9DUk1CO3BYESgi1n4Td
         ekOq953GruUn9fCFtTCDvtZSl3HsGDDeA/fkZGnQsNeiy/3VaXy+S4Z6/duJmCYOpL/3
         KXK0fh3oN0B6r0rlgriDS089fjmyQnX+q+j3IkF16+mpZie1qp184UVV57Yen/Y/8FR4
         8ptw==
X-Gm-Message-State: AOJu0YwIilu1LfMa1wdPLAvLhyuJrfJe2tsUB9w/c2fFSmP2bZE+HtFU
	5tVPTYkfZBNruP3l2K9dcdm2qt+MSdBBZQ==
X-Google-Smtp-Source: AGHT+IEXGWamsR7Yytcu+DAmr0p08k3oitSFEY8voIlETwQIHC6HU43wCVNAvJQUiECekKewVk/oIw==
X-Received: by 2002:a17:90a:4b8e:b0:28c:a5e2:1652 with SMTP id i14-20020a17090a4b8e00b0028ca5e21652mr1845080pjh.12.1704775662422;
        Mon, 08 Jan 2024 20:47:42 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090aa58600b0028cf59fea33sm812372pjq.42.2024.01.08.20.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 20:47:42 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rN41b-007vgb-0Q;
	Tue, 09 Jan 2024 15:47:39 +1100
Date: Tue, 9 Jan 2024 15:47:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZzP6731XwZQnz0o@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_204744_878836_5EC2D5F7 
X-CRM114-Status: GOOD (  25.66  )
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

On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> been done on the MM side; the FS people need to do their part.  It could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
> 
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
> 
> The old way to solve this problem is to specify GFP_NOFS when allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of deadlock.
> 
> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.

So in rebasing the XFS kmem.[ch] removal patchset I've been working
on, there is a clear memory allocator function that we need to be
scoped: __GFP_NOFAIL.

All of the allocations done through the existing XFS kmem.[ch]
interfaces (i.e just about everything) have __GFP_NOFAIL semantics
added except in the explicit cases where we add KM_MAYFAIL to
indicate that the allocation can fail.

The result of this conversion to remove GFP_NOFS is that I'm also
adding *dozens* of __GFP_NOFAIL annotations because we effectively
scope that behaviour.

Hence I think this discussion needs to consider that __GFP_NOFAIL is
also widely used within critical filesystem code that cannot
gracefully recover from memory allocation failures, and that this
would also be useful to scope....

Yeah, I know, mm developers hate __GFP_NOFAIL. We've been using
these semantics NOFAIL in XFS for over 2 decades and the sky hasn't
fallen. So can we get memalloc_nofail_{save,restore}() so that we
can change the default allocation behaviour in certain contexts
(e.g. the same contexts we need NOFS allocations) to be NOFAIL
unless __GFP_RETRY_MAYFAIL or __GFP_NORETRY are set?

We already have memalloc_noreclaim_{save/restore}() for turning off
direct memory reclaim for a given context (i.e. equivalent of
clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
allocation contexts, then we should be going all in and providing
all the contexts that filesystems actually need....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

