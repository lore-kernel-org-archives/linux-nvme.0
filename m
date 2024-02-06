Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5681EC4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfgTTEjFEe4mmqCmem4YGJ61XDDGe/Oqn+sKbHxZjBk=; b=ZtKQDWpVhz2sF4l6AhBUkmQOjy
	febgD1ilZX7H1zCupLtagYEG0ES9OiDtarADNuE9DZzNCUST0eZdXlE/9RaVD87OKq9h1vxKdCaqN
	1kD9q5GdBANUVvQrPgbDQFwSuIGOy8tpy64NkcYxgjvHMdlww0r3RVafr7W9lSBVyb+rZwdp8oV9p
	hUUAzdqBSNsxGB+C9ojt+xsKKkDcmNmJEdZj5BJ/KLFjQQ8baWtNvxcIMW6DaPGRIpg3ZjBH4jOtL
	b6y7TmRHtnBa5qIhTPowzOiVAyL7c+nmsh4zf1YBv3ZyLdrYkC6+xH8lHICuF9DTOWkzvKFuBtxRO
	ZbvdE04g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXF8q-00000006DSI-1RU5;
	Tue, 06 Feb 2024 06:41:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXF8m-00000006DRn-2eIO
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 06:41:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D93F8CE0AFD;
	Tue,  6 Feb 2024 06:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D5CC433F1;
	Tue,  6 Feb 2024 06:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707201665;
	bh=OSLetQMID5FeIYJJwpuY7GsAT5oWKsdrTnedY4Ps0ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKwXEN8bub5HwI2QVfBc0+ijQAimY73kwHi4xF6DkIZ+HmBoJo3+uxwUccSl3Kmco
	 unG8Oof2RNQhCft0P42Riqj6lBiY7ezYJdXAfGoQMGv/og6vTyPZ/YFp6bTqXUnzSg
	 ljdfNSurlMQLKq1prDXioDey+vp2jSmtAuZOs7tFxTF+zD6pGP0TQRCOppW8Cyu6ik
	 Dz5vwK+6kC25kfs87psJB1o3OkrOIPzVactX/7wKhHANI9cZACU7GKWFPjHhR6++/1
	 VftOaJUzytCQqm1qou5gT7cDQ+nj6vfbUgn2eeVzA2suDkdclyyirihjcR5rL2m+9K
	 e4wnu/BAYdBNA==
Date: Mon, 5 Feb 2024 22:41:03 -0800
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Message-ID: <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
References: <20240205185225.2878642-1-kbusch@meta.com>
 <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_224109_044386_F9B34173 
X-CRM114-Status: GOOD (  22.76  )
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

On Tue, Feb 06, 2024 at 06:02:24AM +0000, Shinichiro Kawasaki wrote:
> Hi Keith, thanks for the patch.
> 
> On Feb 05, 2024 / 10:52, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > I've encountered a device that fails catastrophically if the host
> > requests to an error log with a non-zero LPO. The fallout has been bad
> > enough to warrant a sanity check against this scenario.
> 
> Question, which part of the kernel code does this test case cover? I'm wondering
> if this test case might be testing NVMe devices rather than the kernel code.

This is definitely a device-side focused test. This isn't really
exercising particularly interesting parts of the kernel/driver that are
not already thoroughly hit with other tests.
 
> Also, was there any related kernel code change or discussion? If so, I would
> like to leave links to them in the commit message.

Not a kernel change, but a tooling change. smartmontools, particularly
the minor update package from Redhat, version 7.1-3, introduced a change
to split large logs into multiple commands. The device doesn't just
break itself in this scenario: every non-posted PCIe transaction times
out after it sees an error log command with a non-zero offset that AER
handing fails to recover, taking servers offline with it. A truly
spectacular cascade of failure from a seemingly benign test case.

FWIW, while the device handling is completely wrong, this log has read
side effects, so an application reading non-zero offsets is pretty much
nonsense (and unfortunately nvme-cli does similiar things too). I've
filed a bug report on smartmontools' github. I believe someone else will
be taking this up with Redhat because the backports from 7.2 to the
minor 7.1-3 update are wrong anyway.

> I ran this test case on my test system using QEMU NVME device, and saw it failed
> with the message below.
> 
> nvme/051 => nvme0n1 (Tests device support for log page offsets) [failed]
>     runtime  0.104s  ...  0.126s
>     --- tests/nvme/051.out      2024-02-06 09:46:03.522522896 +0900
>     +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/051.out.bad   2024-02-06 14:50:57.394105192 +0900
>     @@ -1,2 +1,3 @@
>      Running nvme/051
>     +NVMe status: Invalid Field in Command: A reserved coded value or an unsupported value in a defined field(0x4002)
>      Test complete
>
> I took a look in the latest QEMU code, and found it returns "Invalid Field in
> Command" when the specified offset is larger than error log size in QEMU. Do I
> miss anything to make this test case pass?

Ah, good catch. I don't want to fail the test if the device correctly
reports an error, so I'd need to redirect 2>&1. Success for this test is
just if the command completes at all with any status.

