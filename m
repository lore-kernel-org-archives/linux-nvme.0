Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B134BC369DC
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3VRTKEBNLquqRhFZYT5aVzDoqfQbBS2lj2/Gfm1dd8=; b=lWnU/7JUYqJz5qGu7oZBPw6nbz
	I/DcZDBYcVFmnnIR1ne+i3VKuu7ScBEdON7+bHMNfWnkTrlnaMe/8Ob9lTsGnJpdRPz+0sMpYke5s
	l/vut7++9IQRcxQnYhvu4OSDJZnkjaeuemw/VBZa4uzpbROopZhCSz7ui1D7hyyb3QP2GpV5IL8cv
	Stl5jxKt0gs7vG1i3KVEyJmHIqS+vRko/cIERz1z4YLUpQ+74b/sM7uL6M9Wpi9Kr64Ga4hXSMhVw
	8YaWt149ZmUNTJxnX7Z197IKLio8y3e5zFtD10bOf72I7hHisVBViogQi2L03fzhVHwfGdN90Eaoh
	2aR1/viw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAYzi-0000000GQ43-0gNz;
	Thu, 01 May 2025 18:50:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAWBV-0000000G7Vw-3VtX
	for linux-nvme@bombadil.infradead.org;
	Thu, 01 May 2025 15:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P3VRTKEBNLquqRhFZYT5aVzDoqfQbBS2lj2/Gfm1dd8=; b=Vvw1f1nb4tZTNYWo7mO6z9pHzV
	MDmnoqAqu2hmb0i0BZCMhG/WDMQlC58Cw73kwpES9YsUR9uVYBATrwEJOHRNIo/+tiKLtb+lnOGfX
	3RQDTcQJHo8yw/zOwlj2RzWNFYXhC2VQIUF/gJjLBZWYPMdo4SndGy1x8v2X1nLPEmzP9XY04eDER
	6wiFSA1LKBYitCkX2q34LCGcLleraMkw5CpiczInfDqlRcnA1DkoaezY3MLQ7ZnDpb3tBsrvLAH0S
	h83K01vh+L05Z2s0lZBeMEnAZ2cFAgQ3S5nprdKJg8w8nz2cckeve7tiH0FBgOln3Yo1AMJl2OmyX
	jjUfpXpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAWBP-00000000vWm-1k5y;
	Thu, 01 May 2025 15:50:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04927300642; Thu,  1 May 2025 17:50:43 +0200 (CEST)
Date: Thu, 1 May 2025 17:50:42 +0200
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
Message-ID: <20250501155042.GR4198@noisy.programming.kicks-ass.net>
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de>
 <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
 <20250501150229.GU4439@noisy.programming.kicks-ass.net>
 <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
X-Mailman-Approved-At: Thu, 01 May 2025 11:42:46 -0700
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

On Thu, May 01, 2025 at 03:22:55PM +0000, Brendan Jackman wrote:

> Whereas enlarging the pool of functions that you can _optionally target_
> for tracing, or nice reliable breakpoints in GDB, and disasm that's
> easier to mentally map back to C, seems like a helpful improvement for
> test builds. Personally I sometimes spam a bunch of `noinline` into code
> I'm debugging so this seems like a way to just slap that same thing on
> the whole tree without dirtying the code, right?

Dunno, I'm more of the printk school of debugging. Very rarely do I
bother with GDB (so rare in fact that I have to look up how to even do
this).


