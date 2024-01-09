Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F05C4706C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9xTLocbxJtZ/EsVzz8IzAHiTCzUNRLczzpqZlO0pg4=; b=UGfBMuyNY8D8QsWB4asxRX//f8
	leyIimLuMaMQv+5lU8lzpFocP1Wp8/Ay60OFlNoeQI8YJIdNR+vYw8PbRgK3Jr4EmLew7mUdCxS+g
	6fLGzOjGRg1utsT1naI3DcgMJxpAXZdM+gh9vdIqgpShTGfw+x2y+QEgD2Lvb/bI4sqJL4+wylgss
	vvCwnaXNtPx7aVpdDobr3+Dwbb3rTqZ7opNqb6OPd+6ogtbPEm56qfkArJconECSdymHhiaNbPpcd
	wSJ8GHNFzyQqKACN7IZL7UNXqMim8Nf9dxZJFqVXeUSXX4u77KU49eQCNxgHgNa1kFZzXJEH7POvK
	9m/XjNDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKpo-009kLO-1j;
	Tue, 09 Jan 2024 22:44:36 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKpi-009kHb-35
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 22:44:33 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso11425755ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jan 2024 14:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704840263; x=1705445063; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9xTLocbxJtZ/EsVzz8IzAHiTCzUNRLczzpqZlO0pg4=;
        b=hkT9RfQ0JNoht2XeC3ALoKBjbBZQjM9YW/e96CYELikVY1Ml9Ii+lokdkOLVQB09cx
         +dz5ttM1aFRgtcTBHSjJV4m0vOCXOUzqcsbP8JcltWWNKxCimkyFU3MfueWqRW7O07fP
         /xsuTEQhfnr9NWFu3Hp7kV8sq/yQKAtp4PoA/JPlqhhSsjUR9zSKd5L8e45RTzZZSHF3
         z2XXHNtihpDa/yMAqt5YYR/e7wPVqPw1AhBxAp9esKg2b7zarmALBtNDNbzRzeK+G90t
         z9CVVq2p8geAjINuB4kz0kfAQdi76yzlJKhDJLLTS8W/3n5TmMQa54EysCcH2OyWiy5n
         h/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704840263; x=1705445063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9xTLocbxJtZ/EsVzz8IzAHiTCzUNRLczzpqZlO0pg4=;
        b=EAtduhHwNXHiZ/OkFqvFWIRMYQEKgwWSKTtCf+1Takk9p/VJQ8MslJp7IGO6IhHbk3
         abVRh8Ep5JQ+v+nBKg9UpocEpTJ0M8QzHdXpZnWVLt/IEDA1Wx0KIY+Dknza5zsHkZWw
         JvT0wvL4V//KzxIwr25XxmcVuW2uUBdJhRlyNFNOLO/nr5qU6ngkNpFe2GeCGMbXUT4V
         j+lLwISy36OuY8hw8RZ+JEfxM+x+7MzoZyT7673jVdZyMngxNt61XMFwu8ot7Jj1CLSZ
         2zw3ycH0glEcXrydPLyswks3RQxZ0No6BLZbamRx6KNS4L097OuxXr3bFEC3kx4+LpuM
         2aFg==
X-Gm-Message-State: AOJu0YzYslFCZfxxdvo+HmUhEEw5yofF7ma2W1r/VX5KvbKaIBoBGrWY
	31Cd98gB/d0Aq1vfQcukB4NuHLonjGEUtA==
X-Google-Smtp-Source: AGHT+IHSKNtjcO8bUbdBcwmcDlNZLFhTfOw5pswdA67ew28nBq3+gGgOSAobh3nBsnKFOjOmUdXBuw==
X-Received: by 2002:a05:6e02:1845:b0:35f:bd12:5488 with SMTP id b5-20020a056e02184500b0035fbd125488mr183647ilv.30.1704840262829;
        Tue, 09 Jan 2024 14:44:22 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id o5-20020a634e45000000b0050f85ef50d1sm2059281pgl.26.2024.01.09.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:44:22 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNKpX-008G6o-07;
	Wed, 10 Jan 2024 09:44:19 +1100
Date: Wed, 10 Jan 2024 09:44:19 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZ3MQ1nFcyaMVuCv@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_144431_007640_169FB358 
X-CRM114-Status: GOOD (  22.77  )
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

Another thing that needs to be considered: GFP_NOFS has been used to
avoid lockdep false positives due to GFP_KERNEL allocations also
being used as scoped GFP_NOFS allocations via different call
chains.

That is, if a code path does a GFP_KERNEL allocation by default,
lockdep will track this as a "reclaim allowed" allocation context.
If that same code is then executed from a scoped NOFS context
(e.g. inside a transaction context), then lockdep will see it as
a "no reclaim allowed" allocation context.

The problem then arises when the next GFP_KERNEL allocation occurs,
the code enters direct reclaim, grabs a filesystem lock and lockdep
then throws out a warning that filesystem locks are being taken
in an allocation context that doesn't allow reclaim to take
filesystem locks.

These are typically false positives.

Prior to __GFP_NOLOCKDEP existing, we used GFP_NOFS unconditionally
in these shared context paths to avoid lockdep from seeing a
GFP_KERNEL allocation context from this allocation path. Now that we
are getting rid of GFP_NOFS and replacing these instances with
GFP_KERNEL and scoped constraints, we're removing the anti-lockdep
false positive mechanism.

IOWs, we have to replace GFP_NOFS with GFP_KERNEL | __GFP_NOLOCKDEP
in these cases to prevent false positive reclaim vs lock inversion
detections. There's at least a dozen of these cases in XFS and we
generally know where they are, but this will likely be an ongoing
issue for filesystems as we switch over to using scoped memory
allocation contexts.

I'm not sure there's a good solution to this. However, we need to
make sure people are aware that GFP_NOFS will need to be converted
to GFP_KERNEL | __GFP_NOLOCKDEP for allocations that can occur in
mixed contexts.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

