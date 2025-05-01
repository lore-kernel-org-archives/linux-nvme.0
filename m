Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D50C369DC
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wm8HDKzWcPs/ZOJ7u1MGp3oUtkY4RQR0TPLRQCBj5DQ=; b=wnva0xWo1G9RZ9NmeEc/cwI1Rf
	R+nhq5rIyO+fC6hKAOlu2T5q5WBPDP9FBFJtfDOtCd/9PGyYnhzThRKTm8fscwx8LDzbTHxs0SYMe
	pBkDvVBS+0Glr0jVKYxQgxrjg27EclvcsYeVQsmDQfhqB2OT3zb37DiTCWLQsLD0hR61T+9IpKqgB
	je7+zHWPRZc1H4BzNTqy0A4xyiDAAcxEoX2eHK8T+q7jRXcxtGEqmrtzruHXExG9dn4FmkKVBnou2
	jX1OPquofVbLGV3udRzDyuRnX8qErklV89dO2UTj6OnYKmiiYN812A18KE87lX3WZkRDObW7w7BNl
	hxnV+hzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAW8c-0000000G6wt-3PTe;
	Thu, 01 May 2025 15:47:50 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAVkY-0000000G4kp-3l2z
	for linux-nvme@lists.infradead.org;
	Thu, 01 May 2025 15:23:00 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so4127745e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 01 May 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746112977; x=1746717777; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8HDKzWcPs/ZOJ7u1MGp3oUtkY4RQR0TPLRQCBj5DQ=;
        b=wTK8L8loTjgLQO/JWuENu7gbyF5BYTc9SQpI7EkkTaAL12KGE4/K+IO3YdB0ajMq4T
         x6h5f6ilYZaE3Wy8bo00orEE9ELKFG+y9jEyscIs+yS9TSyFdbWGixXRmeidpd1dloDn
         gvvnGCIEhXIrdCd5u3wBXAI+/WDfMBoSMn+jl+ZADfpJ3RCUJ5Q/y3MXV5/mIGl/yun1
         jmhcHfq1CCUGL+PE1zbXPifpwksxb00ZTeyw44g13Pbjmp6CUpOoKxwh6G+iR5rnqooL
         vLJ3OT2vRpnnTi+lkNwhrmxIOI7/asQftFmepgxLRPrK9R2zkbInETx69naH0YLaf6VB
         FnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746112977; x=1746717777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8HDKzWcPs/ZOJ7u1MGp3oUtkY4RQR0TPLRQCBj5DQ=;
        b=lKAO51N4hJ1yT9owKWi7DCicM2nYyPgbCOennfHc7g+5FOEemBv1oOEPZjDRAEs3a8
         I2evAjOMNY04q1eJ7N6H2Ok8q8aOXcf004xqI5fRCcgw57RFxCr3BvVaAqsF8aJ9Mtob
         1peO+svYRLNbTes4WKD3EhKDjmD/32QA6Jpnlzh+Zq5/9YgQs7mpw77m7MD4F5Dywdk8
         hpwl9J2lfJiOFPOjC2pdmVVlcaE0yzE+Q/uMnQY/VCVgs9Zw6sk3CaqcVcLv292b0s0/
         Yj8QXJagJ+Mjt0HD0f7pGXVwItLuiDfsAqi20BQPGo4OY1fKBmKCh+vYQyc1EQnPxtvI
         xKNg==
X-Forwarded-Encrypted: i=1; AJvYcCUXo3NzC1d4Hkf117aHafyv6mM9+lz0k9QHi44gj5WX71qFoZ2JAWkiUViUlQV+ZelwJduECE/jZkfi@lists.infradead.org
X-Gm-Message-State: AOJu0YzBVt5VsN2d06SijJNpu2l1HFyAsD0FYpc46sZO4KP4v39Uud6S
	Ik9lHNIU+ntkMdToefwxhaR/VLkn8yBQ5NKaANk4HVtVYh9VlGbGTgQ9iQnTnYdTUJqLePWnAQM
	544YArOiXSQ==
X-Google-Smtp-Source: AGHT+IG1H8EWFmTdy9mXUfcCJxQBprr6abVa1X9treBvRrD020Cub+yFF9voa0K8UUVl5WCrL4gH+SDc7+SKLQ==
X-Received: from wmbel14.prod.google.com ([2002:a05:600c:3e0e:b0:440:5f8a:667c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec6:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-441b2635482mr61130455e9.6.1746112976936;
 Thu, 01 May 2025 08:22:56 -0700 (PDT)
Date: Thu, 01 May 2025 15:22:55 +0000
In-Reply-To: <20250501150229.GU4439@noisy.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de> <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com> <20250501150229.GU4439@noisy.programming.kicks-ass.net>
X-Mailer: aerc 0.20.0
Message-ID: <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
From: Brendan Jackman <jackmanb@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, <chenlinxuan@uniontech.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Yishai Hadas <yishaih@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
X-CRM114-CacheID: sfid-20250501_082258_959379_6F47C2D8 
X-CRM114-Status: GOOD (  23.90  )
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

On Thu May 1, 2025 at 3:02 PM UTC, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 02:19:47PM +0000, Brendan Jackman wrote:
>> On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
>> > On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>> >> This series introduces a new kernel configuration option NO_AUTO_INLINE,
>> >> which can be used to disable the automatic inlining of functions.
>> >> 
>> >> This will allow the function tracer to trace more functions
>> >> because it only traces functions that the compiler has not inlined.
>> >
>> > This still feels like a bad idea because it is extremely fragile.
>> 
>> Can you elaborate on that - does it introduce new fragility?
>
> given it needs to sprinkle __always_inline around where it wasn't needed
> before, yeah.

Right, I guess I just wouldn't have associated that with the word
"fragility", but that's a reasonable complaint!

> Also, why would you want this? function tracer is already too much
> output. Why would you want even more?

Yes, tracing every function is already too noisy, this would make it
even more too-noisy, not sure "too noisy" -> "way too noisy" is a
particularly meaningful degradation.

Whereas enlarging the pool of functions that you can _optionally target_
for tracing, or nice reliable breakpoints in GDB, and disasm that's
easier to mentally map back to C, seems like a helpful improvement for
test builds. Personally I sometimes spam a bunch of `noinline` into code
I'm debugging so this seems like a way to just slap that same thing on
the whole tree without dirtying the code, right?

Not that I have a strong opinion on the cost/benefit here, but the
benefit seems nonzero to me.

