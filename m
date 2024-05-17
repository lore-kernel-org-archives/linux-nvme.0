Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1C5C04FFE
	for <linux-nvme@archiver.kernel.org>; Fri, 17 May 2024 21:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyrneMtT2roM/mXv9xc7jF6yRyXUeDAQ1aSOo1P0c+s=; b=juN9j/qhP9KURXsxVMukao+0gj
	DNj81UaAyCP0UfYcvGJmIRPbnfkVe5z5n7YiGKBkHdgDdEnsrZavVPZIY6nbiE/bqI2k5x++lYJ1r
	DbUs493jgl1QdGVFQpHsEaBIBJmD+R6i940dBrezGTFMOjFY31d05zAJM6+fIJSu23PAwJx7FhF5e
	0BMBGb2LbmAnEU892JhGfla47arUfNzwqzOgLE9cnjEUYsFLKj3VahsJsn22wcPi9ZKqCiuSZ6g3m
	e/qV27HlUMxwmFQgiYoHkjrhIU4jT5Pj/ISNbAGS8uFrv9iNsnQyx0uNevQ+sc6334GQ2PyR2IXxq
	Hba9imhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s85Bz-000000092hd-2eCJ;
	Fri, 17 May 2024 21:32:43 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s85Bw-000000092gP-2f3V
	for linux-nvme@lists.infradead.org;
	Fri, 17 May 2024 21:32:42 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2b9cdbd6da9so1282425a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 May 2024 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715981558; x=1716586358; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyrneMtT2roM/mXv9xc7jF6yRyXUeDAQ1aSOo1P0c+s=;
        b=BJSKvO8iE9qSdqfurQEF4vabk/eT7ecLzTazfXNAvge+HJoO48l4Yf3RTY+KGYBuTc
         MDr7XRgZxdExW9ggXcmlEaHeVvOYLegyQwjNwsQi5K/PA0Hq5fq8h7SiQAQC0P10w7L9
         toMLJDV3zvnPQrI9oDUnD3qKLnqaz5pUOVAcHDbEg72HgLKD8wDkeqUiLU6uNBOvfv+Z
         WRNAJtoJoFnZSPOHc8iEYliZriAvvAm72UDdnJSu7u8Wdi5GXys2f52dTqNupE2pRE7v
         bOX3xu32uw7ALcuSNa1xTDy6UbXd28Z/9Wq7uOGOoRbyx9ncheuN+F/A6efU5+YJKPsk
         wjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981558; x=1716586358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyrneMtT2roM/mXv9xc7jF6yRyXUeDAQ1aSOo1P0c+s=;
        b=IeogTyepC3eQEHQ4YP0qNGpjyiA732bWI6+p6NxJhBiVhhumT05MRtkNYmZowf/6kE
         biL12+0so30716ngGmlAIWHLPTr5d10JmCE39ZG4hfhjjVPeWEENP4bPl/PneGNrg65/
         eMumTAkQZn7eMqAj65xzswB1iAUSzHZiI9DVbG6YII6wGBol24ASE+VDYgdAWoqQhmdn
         nXD+ZxGFbP/nFUVGQ75Cva8rjseAcWXjcXHq/5wNgpq+CJ6n5GlOGNeG9BbkDqqAQMc9
         r5LWfuoeGBbDKRqnLoo8I3H05FbORQghhzOAYCq7sQCf6pyFQxQelq7JGnGQpEowabA4
         u6sA==
X-Forwarded-Encrypted: i=1; AJvYcCWBqdVzNVBd62sITLD01d16H8jS/7Nm697cqdEGvmh73WC7m4hQKhH/7xcyZQo5WAvtzvAgtoVHL4KPdo1XVZ+61H/GZ+mhQOYZ5f33CpQ=
X-Gm-Message-State: AOJu0YypXxw/5SBoXpInyjwf654xfb4q/2LTesOQmDz1n3hISzgvZKPW
	qZ3LxgEiA82qpdtcF4kTnzBQ7DQlNpY6/vP00PsMiT3GFDuLJ6Jj
X-Google-Smtp-Source: AGHT+IFXyePfAU6GysoFIX/3SNu/9wWzEv6Uf6hwUK7S74vkedQQo6HP3kvP2IJec5JbP/nPkQmlFg==
X-Received: by 2002:a17:90a:68c9:b0:2b3:6898:d025 with SMTP id 98e67ed59e1d1-2bd6038cdabmr402648a91.9.1715981558358;
        Fri, 17 May 2024 14:32:38 -0700 (PDT)
Received: from nvdcloudtop.c.googlers.com.com (32.39.145.34.bc.googleusercontent.com. [34.145.39.32])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b5e02bcf6asm15563186a91.1.2024.05.17.14.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:32:37 -0700 (PDT)
From: Navid <navid.emamdoost@gmail.com>
To: willy@infradead.org
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org,
	navid.emamdoost@gmail.com,
	yuzhao@google.com
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Date: Fri, 17 May 2024 21:32:31 +0000
Message-ID: <20240517213231.2934591-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240517_143240_792238_4C06D7C7 
X-CRM114-Status: GOOD (  17.69  )
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

On Mon, 2024-01-29 at 04:32 +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
> 
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
> 
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
> 
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...
> 
> [thanks to Amir for reminding me that I meant to propose this topic]
> 

On the "Reclaiming" part of this thread, we might consider this:

Optimizing Page Flags: Reclaiming Bits in page->flags via folio->lru

Limited bit space in the Linux kernel's page->flags field, especially on 32-bit
architectures, is a source of challenge [1]. This proposal aims to free up bits
by relocating flags like PG_active and PG_unevictable to the lower bits of
folio->lru as they are always unset. It helps with encoding zone, numa node,
and sparsemem section [2].

Proposed Process:

Candidate Evaluation: Assess flags for relocation suitability based on usage,
dependencies, and functional impact.
Impact Assessment: Evaluate the impact on kernel code to ensure correct behavior
and compatibility.
Relocation Implementation: Modify code to read/write flags from folio->lru and
adjust related macros/functions.
Thoroughly test changes.

[1] https://lwn.net/Articles/335768/
[2] https://blogs.oracle.com/linux/post/struct-page-the-linux-physical-page-frame-data-structure



