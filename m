Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DACCF64AA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 02:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qz0Kt9BVZotF+W8b8C03wV9uEpjzU2IZVkSaOcZVd50=; b=yOh1SFgh+ZTjIZIogQh4WhbfQp
	OPAb7lz1DM0Wb7cQHZ3/K0EwDuma480fEzOPNROcG97LVmeiHPeCyzoWXvLXUkB7pHFxVbD9Frekb
	1iVl+N+meeON0CJ1vXMmyDVNNP2g0+eLXECIFZDCMHuFfHYKDzVzopiEIbA6ulTe9Qp84wjaOgd09
	4vgwpNx9ui+B4U0b9P83G+b53mfxwSD2wTK6/ooavkpcFJkchlC+jRikSrzPiUrCJFAGrAja4Y2zT
	Ad4cW8IoaEge5PhY89Qkef1RrphJX+/be8HNmBKcp5/RX0iMfDG5yJQgD6Zwjsbo6qrd2wH8sJ2id
	+tgMAzsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLuqY-000000061No-2EKX;
	Thu, 20 Nov 2025 02:56:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLtls-00000005wYd-0awJ
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 01:47:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E650E43A3A;
	Thu, 20 Nov 2025 01:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC38C113D0;
	Thu, 20 Nov 2025 01:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763603258;
	bh=Qz0Kt9BVZotF+W8b8C03wV9uEpjzU2IZVkSaOcZVd50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uF2z7xSsJBEF2o7jOCGEA8BICVnf2Ll7GN/YdEoLbs8PaQeAHioKS/o3SZ7QSxsKt
	 vFnjbh6TICH8PLye1zHlHKdpzDE5Fm345e4L/w0hg/fEJ7Itp2slYgup6C6JZwwIym
	 LLCi+QyeEmLY48F4L7ZzcbTStdyHeEENY8Hfnp0DqQrXSF5r2MrZk7t4OMHkvbN7PR
	 8Qcsuc8hp1q4+vdSlLZQjWoYyrPh5U9WhuFsg9TNqdi8dNwuUtBQRxPyNJujXI9VwL
	 mc5s7M6miwKRs2zV2Elwkq7lUfoGg+X1KHfkkxDDXD+SynQUk6oIGjhckD0gmUEmi4
	 nBJOVjtHwyLhA==
Date: Wed, 19 Nov 2025 17:47:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov
 <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Ard Biesheuvel
 <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, Christian
 Brauner <brauner@kernel.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann
 <daniel@iogearbox.net>, Dan Williams <dan.j.williams@intel.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, David Hildenbrand <david@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "David S. Miller"
 <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jens Axboe
 <axboe@kernel.dk>, Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, John Allen <john.allen@amd.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Juergen Gross <jgross@suse.com>, Kees Cook
 <kees@kernel.org>, KP Singh <kpsingh@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Mika Westerberg <westeri@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim
 <namhyung@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 nic_swsd@realtek.com, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Olivia
 Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, Peter
 Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Srinivas Kandagatla
 <srini@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, "Theodore Ts'o"
 <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, x86@kernel.org, Yury Norov
 <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 io-uring@vger.kernel.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 00/44] Change a lot of min_t() that might mask high bits
Message-ID: <20251119174734.5cba3f95@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_174740_248507_69BA92C8 
X-CRM114-Status: GOOD (  14.25  )
X-Mailman-Approved-At: Wed, 19 Nov 2025 18:56:32 -0800
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

On Wed, 19 Nov 2025 22:40:56 +0000 david.laight.linux@gmail.com wrote:
> I've had to trim the 124 maintainers/lists that get_maintainer.pl finds
> from 124 to under 100 to be able to send the cover letter.
> The individual patches only go to the addresses found for the associated files.
> That reduces the number of emails to a less unsane number.

Please split the networking (9?) patches out to a separate series.
It will help you with the CC list, and help us to get this applied..

