Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81408C369DC
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SknNweDJMYv6Cc7JXUCuginAJHi4T0ZKllMpOn1Yf9A=; b=p9OnN5fCl2dpyT4iE/9hBALYA5
	E5TmOpyL+EUk65IpzbTSvTs0bvzx6d6uXa0IZHnOqNx/1WN8gi5UCRaiv4BRGT366IoFoxwpRr2cQ
	t1Srkfsc+sHBWy881h5TATBFkciBdNi9I0Qp3Gc7gXrOo1LWPtVLQdk9yW/JJE+oR7foGmPVKHSIZ
	8VR5Cs3mkh5epDZX8Mdkbaa4mX6fWOMiuC5XmCyis6TZicAaiOJsHidpuvshaHayDpRM4SwZ6wf9b
	1vsH+i9N6ftiSh9MoNMr80KYVAvW64XFQit61wwiV9/5Q/7ftC84J0lMSPzqKD0wG1sX5jjAwLs2P
	TyDOx2Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAW8c-0000000G6wk-0smr;
	Thu, 01 May 2025 15:47:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAVQw-0000000G1nZ-2ndj
	for linux-nvme@bombadil.infradead.org;
	Thu, 01 May 2025 15:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SknNweDJMYv6Cc7JXUCuginAJHi4T0ZKllMpOn1Yf9A=; b=QE9K7S0FqJXdRMiI2MUQfyFVKN
	zJkaOZZAvX0UK9xBOJnD6xr1oo4dLko0vESRIIkP4sjHHPxZkleb2D8Zai321exEYA2JJr82ElX7s
	y72vsCa48dbNhj3sR2u6AvvpDc6GUftTpqrd7fLDiVr8l4ZJcPOvCc/B4Kso/X5VwtY001koeorb7
	w0lpR1LpdbzQwtNNGzQXqNnli6Sbl3pH+QAdCVePhkf3FUFd/ngVNiv41q8dPOdm8t1mbTM/UmJ5P
	NuryBBTCcNBBOjT/+JRWnUfQQL+DhMwA+igl0308JTBNEPRBnnqN+OImNHFtw2Imib6YH9ERSKUcP
	cmUpe09A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAVQk-00000000oH8-33tB;
	Thu, 01 May 2025 15:02:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B7DC30072F; Thu,  1 May 2025 17:02:30 +0200 (CEST)
Date: Thu, 1 May 2025 17:02:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Christoph Hellwig <hch@lst.de>, chenlinxuan@uniontech.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, Winston Wen <wentao@uniontech.com>,
	kasan-dev@googlegroups.com, xen-devel@lists.xenproject.org,
	Changbin Du <changbin.du@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce
 CONFIG_NO_AUTO_INLINE
Message-ID: <20250501150229.GU4439@noisy.programming.kicks-ass.net>
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de>
 <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
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

On Thu, May 01, 2025 at 02:19:47PM +0000, Brendan Jackman wrote:
> On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
> > On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
> >> This series introduces a new kernel configuration option NO_AUTO_INLINE,
> >> which can be used to disable the automatic inlining of functions.
> >> 
> >> This will allow the function tracer to trace more functions
> >> because it only traces functions that the compiler has not inlined.
> >
> > This still feels like a bad idea because it is extremely fragile.
> 
> Can you elaborate on that - does it introduce new fragility?

given it needs to sprinkle __always_inline around where it wasn't needed
before, yeah.

Also, why would you want this? function tracer is already too much
output. Why would you want even more?



