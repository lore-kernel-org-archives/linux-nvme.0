Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E00EC282EC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+35VwW0guPAXPD3vm8P/KmL9oBW5pOr3grFjFyiZYJM=; b=swAAXVuCgV154JSHHpAk0LzHpH
	oh0X67Q3Ur6PiUeB03BPzjMLj7Ttoh8C71dNZxoi4YpHxAbykXE3mIfKZa1/Ikqbomge6SZ0k4geb
	6Fvbr++OUTxUthg9+e7T3S5pijQ7ATHPl9UjRewK8IQubKs6MLfmCPXHgKwzpyWRzsYSnzJ02xGU1
	vWEjbHuJ1ZNBWm1QcbdQH/EJdt2bg+GkoVa7el7JNbEuNcR+KQAAXLRvPWH9+eJGh9ZMSGJ51RUdY
	9XKC06cUkwQ3AtuNKYSUMac3n8l5/R9oINyNy2eu07Yzbj54t9EtuUEZnoVo8u899XHTWc3dDf//c
	hK33Fv7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpzO5-00000009jIv-0yVt;
	Thu, 06 Mar 2025 00:46:57 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpzO2-00000009jIF-0dYq
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 00:46:55 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-22334203781so27658375ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 16:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222013; x=1741826813; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+35VwW0guPAXPD3vm8P/KmL9oBW5pOr3grFjFyiZYJM=;
        b=EaoztJt9zjJRVRByi9whuAYC1moB/txJZagxnPjBKDN6oZWNodhmJpWpPQxlB0PD/m
         HMH9zLh98V/R2I6rmTISi78918/ZHisXarMaqhUxMBdPjKVzDB8sBFQEdhhXG55K6c4i
         pZLvjDtd0RdjFQRKLYutdeKZgM2kXsPdBuYNz7Wi39EwpYjCfwrBa810OVLNbfAGEQeU
         KcohCgBmv03fBftUYRlxrJFsSaSLocr9lB0R4pDIRqAKw5o59YjbDueAP2fLU8GhslkX
         mVq1ES8TWL9Jwv4/nHRaNcw872445C3CeyApSMmNkxxNPqIamSoYZjoL4YcewQ3SsbWv
         xfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222013; x=1741826813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+35VwW0guPAXPD3vm8P/KmL9oBW5pOr3grFjFyiZYJM=;
        b=TjJ9TVB4p6XuO3lIxoDN809Z8F/vEbTgfUfTyZlgieSTprrgbx2K+Mum8BtXGZLfwi
         7ULNNzUVrJsEtusBGGirP5+NkSbRPqT3fGyQpqXg4O8IFxGs3viP1A0M9tojAb2t8sy4
         SpAPje8o73nPcOvWUHkEH+bx3rkFAtcSdFIS0ceVbX/lvcjeBbfolAeFQONrwmYnfN2w
         FUM72gWYBPAfSb7Wpg6MPwUh+X5ovaRSbYfW7slX/6cVv63b1bug7Dz3GL7WI/kzzrLL
         vF3A/RLJT1a9A8GFT0EMSi10Y111sn3AU0wqQVJJBO5U+/nNoCuPux980NcY5ypXSsMJ
         mOOw==
X-Forwarded-Encrypted: i=1; AJvYcCV70Pjo44ZMlaqAOIKyOsb4rg93/kdKgy2GyOh70CTd9Fvcpd0G+IguQKEx1uIsbcTNvJu4Ft8/x+Wc@lists.infradead.org
X-Gm-Message-State: AOJu0YwI+cew4vVrhFsTIPIow3GhrjInC+ubEvp9wYAxJp9F57uxH52V
	YaTcW5ICFOi94Nx13TkABndbu6WfPklkk7T6a0r9w8RpW+WnbG5L
X-Gm-Gg: ASbGnctzJ0gKjbgcD6rODCtQw1ui0yw0gZnp2C/Aukqm0+7ywrQbzWMvEKn+Gcv2gUE
	LaNgTmTzmZXPar2GmyOCXM92HyzTMVGzVNDzH30y0AbSeEu+Glz7tIxOF6OYdhN6RB5Dit7yPkr
	H+GZUawjkhc0e30h5l8BmECjpY4PNOJd0UUaBnsd5xar3L0rWqv9lRCsParrIfL34V8lltYdMF5
	NOnIo5B6hfeP+vNhhSUWkJd+MSr1+dpvANM6dyl8LCOi5A4JkwIEqNEiO4/DTIfn4RHwlgZBdav
	4e0rAfJc2SDOByuqey8AU5/OK4XEvxvopWfU8H9Pi+o89t85
X-Google-Smtp-Source: AGHT+IF7vCbcPdVKVzzzP+Jt9zGpX61vizMrmay+ZL8kmmG60vfaBPu0w+ySA1n4Rl5PNTclnwnm5g==
X-Received: by 2002:a05:6a21:3983:b0:1f3:3864:bbe0 with SMTP id adf61e73a8af0-1f359b18686mr2000333637.8.1741222012978;
        Wed, 05 Mar 2025 16:46:52 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c1d24sm70649a12.41.2025.03.05.16.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:46:52 -0800 (PST)
Date: Wed, 5 Mar 2025 16:46:51 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <Z8jwe7dFXVEI9fT1@pop-os.localdomain>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
 <Z8iTzPRieLB7Ee-9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_164654_190817_61B37458 
X-CRM114-Status: GOOD (  25.44  )
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

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 05, 2025 at 12:43:02PM +0100, Hannes Reinecke wrote:
> > Oh, sure. But what annoys me: why do we have to care?
> > 
> > When doing I/O _all_ data is stuffed into bvecs via
> > bio_add_page(), and after that information about the
> > origin is lost; any iteration on the bio will be a bvec
> > iteration.
> > Previously we could just do a bvec iteration, get a reference
> > for each page, and start processing.
> > Now suddenly the caller has to check if it's a slab page and don't
> > get a reference for that. Not only that, he also has to remember
> > to _not_ drop the reference when he's done.
> > And, of course, tracing get_page() and the corresponding put_page()
> > calls through all the layers.
> 
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
> PAGES.  That will speed up networking (eliminates two atomic operations per
> page).  And of course, it will eliminate this hack in the MM.  I think
> we do need to put this hack into the MM for now, but it needs to go away
> again as quickly as possible.
> 
> What worries me is that nobody in networking has replied to this thread
> yet.  Do they not care?  Let's see if a subject line change will help
> with that.

Since it triggered a kernel crash, I am pretty sure people care. How
about sending out a patch to get more attentions?

I am not sure what patterns here you are suggesting to change w.r.t page
refcount, but at least using AI copilot or whatever automation tool should
be very handy.

Thanks.

