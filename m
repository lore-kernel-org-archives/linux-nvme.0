Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FE1C3ABA3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=; b=eBFPcNmgBMIh26qrRUX8DNCfth
	XUTgfbbgcEtSFMqlSavjl2P8MUnxkhzh5PNeg7vte6lNj8NnPlxi7bw2UIosMwMHkb9Qp95AoKpWs
	f2X234OnfE3eTA7VyHRHDSl+jedPNqGB/K5zwc/KQyPd7HGveEdaabugctp2lzxyf2B2QLd51XOFw
	hkyogK42uN7nOM4siUZ9cTo9Q9qjw4Jivhuhij4JLm7QasesmK8lih2pDwl4ZkSeMaPqicxjR8GRV
	G2ypMBdrMfFuT5w/AB7nNTOamGiNDThc2541lgaEe/SYBTJQsp/CgMknFY2UEQXrE/TtfZRBFaDEg
	9Mmm0uQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAW8b-0000000G6wd-2lDI;
	Thu, 01 May 2025 15:47:49 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAUlT-0000000FwiK-2kuL
	for linux-nvme@lists.infradead.org;
	Thu, 01 May 2025 14:19:52 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so3858605e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 May 2025 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746109189; x=1746713989; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=zKkGOYmdVZBcsApeJYP9IxaFEnsQ8thRVozojCCKNTIBr2pWqYJzBIAj2GoHBw3faI
         US9821qklUPOYuyQXRoAIeW2UScdf39Oj31pTBZtjGZO8SlfHXEBlarUA601mXWUHcb/
         +vVWMY07+wMnSzaR3ABWFAK6C1mSayCHuL0wrfQ40gL3ulBmE/hZgcJ6v7QgScC8ZtAf
         fU26ykr+/E8ihtsBjIRwIa1v+gItAEtN1/TfqF5ukCrFzk/LUjjBS4+j1ZDvMaVcCz6N
         cGDtZgkDpORDPRZBS+YWqN1+jlKw4xN1eV3jfQtiFGf/1JVMFnHLLOvY4vA8StEZRrS6
         6kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109189; x=1746713989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=aRrorFpo4K1uC0m8UIH35/8IqY2a1LcXprESlz39ai8Ly2izRqg7XMz1R/qBrCcdBC
         nQx5R0zXMyAsMUrkCGnmRBwA9ct6YHucaFhh2pU5KwMXd41R8MIs7vHO5IxeDBL/XQn1
         JLGsTc4dNmMcbCFYO1dmzrJB+L9GqWlPhwHUuuoOI+D1ZFw9r24W9EV80ZOZdJgkSCuC
         3zbpRanUWXcRSVox9WGWuueA2fE3XTiXOGUUBHKNfhHyJMLPTm4z7sgBMtIqe9qbLlQp
         +Tc+ebckJ7vF4z8sx5TM8iEUxZ/8lvUWt6mAIRmldMTyIQksGcpOYN4jizzgFEzeudh4
         ceng==
X-Forwarded-Encrypted: i=1; AJvYcCU2x9aiguIR8QNTtXR5DDQ3pkbp7biMn4YXtuOfBOG96vPR70+rWzZ5aPtPqQpK/MlrLyNm9CED9U4M@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5IpMmWOrFoxqqDmB/yWAGnLeRudwsQwoZO0emJRt0loKkGT99
	8EYkJE7W2HZClmvy7fs6GFlnN08MmDxm9llzEdUVu3K5pvWWLKGycPeTCXVYDh2rKqrjaCxOTdD
	VoKuCi70jjw==
X-Google-Smtp-Source: AGHT+IE4OWD5XxcERH4cgRX5gY9PM+u+mzYGVEd/YlTx4e+t3SrV5tDi5azUj0xMuNVR7NdRXpnF4uWQLtuxPQ==
X-Received: from wmbhe15.prod.google.com ([2002:a05:600c:540f:b0:441:b79a:76cf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d6:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-441b64ed9d8mr27510245e9.3.1746109189194;
 Thu, 01 May 2025 07:19:49 -0700 (PDT)
Date: Thu, 01 May 2025 14:19:47 +0000
In-Reply-To: <20250429123504.GA13093@lst.de>
Mime-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com> <20250429123504.GA13093@lst.de>
X-Mailer: aerc 0.20.0
Message-ID: <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
From: Brendan Jackman <jackmanb@google.com>
To: Christoph Hellwig <hch@lst.de>, <chenlinxuan@uniontech.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>, 
	Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, <linux-nvme@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>, 
	<virtualization@lists.linux.dev>, <linux-integrity@vger.kernel.org>, 
	<linux-kbuild@vger.kernel.org>, <llvm@lists.linux.dev>, 
	Winston Wen <wentao@uniontech.com>, <kasan-dev@googlegroups.com>, 
	<xen-devel@lists.xenproject.org>, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_071951_711017_68212F83 
X-CRM114-Status: GOOD (  14.77  )
X-Mailman-Approved-At: Thu, 01 May 2025 08:46:46 -0700
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

On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>> This series introduces a new kernel configuration option NO_AUTO_INLINE,
>> which can be used to disable the automatic inlining of functions.
>> 
>> This will allow the function tracer to trace more functions
>> because it only traces functions that the compiler has not inlined.
>
> This still feels like a bad idea because it is extremely fragile.

Can you elaborate on that - does it introduce new fragility?

