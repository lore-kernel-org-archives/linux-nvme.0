Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC41C87FCA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuCp2yaDlH9a0/HN+kFWzl8GYnQsgCVyAgnWT1J18Xg=; b=jQDzHYFwnlhLE89mxvvcEe5+y0
	n2f9l2z3Ck8G2DI9ikRDycCpvm37GikxiXnKcEI4GZuXyMnrSc01jGuxZPEboVmvanoEcdnQV89Yt
	kRcQPu4s9EIfw3ctcaYiU86W14wj3U/TssDiACSOh6dhbCp3pQ1PQbpck4nJCh76mku7gHtaiQpfK
	weIGW42pP0TNa8829V6BoHkg3sxZHfskeFolsAZFJ9o8Gd9sy8caxhxhG+HnnVFIFIEajIBYyaTT7
	7WPFJ3L8WYa3hvK2JR4l6fOj9zCsYlLHeSRkoFkmEBUDiSfDFMN2MYUkP9kCwANRahPScQgm04URH
	Xlv8bQXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugwAQ-00000000Vwq-0wxC;
	Wed, 30 Jul 2025 02:03:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugwAN-00000000VwK-2Z9Z
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 02:03:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 286FEA55058;
	Wed, 30 Jul 2025 02:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E63C4CEEF;
	Wed, 30 Jul 2025 02:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753841015;
	bh=rXganNSbsAxjX4C0tlQM7GA7BaRg78maG3+4QDEOGn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ty+UwtK1X14dl5gUZG1J2Hj6VjT+dU3K3qiRf238WGNXaOTbC8O1osqym0rOkWM/R
	 Urr0JVIxpUFRwtn8jQdzGXmzfQnSxaq0XHO1MIHuv7kl4o5TcF/67zVkEJI7l+dpha
	 Dgg14u2TGafzg6kQN9b666d9Yr4s4mlaGu9qFeobZCk4IkCTx9UI18FBT8kY1VqFZk
	 78jH/hLb+jb740mNKIjOlAnyzULilA/cU+25t6cCL3wWRdxZUL8y8NtOh5FAHcaLWz
	 l9PEOulShHh+E48OfnS5v/gk+y59tFrl8x/i4g8Ssgp/QycOk2GaBUm1Mlk1WLE+8M
	 j8YIrvR1Q4Ssg==
Message-ID: <3187d1749216df5d48e362489ed3aef337634820.camel@kernel.org>
Subject: Re: [RFC PATCH 0/6] nvme multipath eBPF path selector
From: Geliang Tang <geliang@kernel.org>
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Date: Wed, 30 Jul 2025 10:03:31 +0800
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_190339_784564_8283C287 
X-CRM114-Status: GOOD (  28.76  )
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

Hi Hannes,

On Tue, 2025-07-29 at 09:06 +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> there are discussion on having to deploy more complex I/O scheduling
> algorithms for NVMe, but then there's the question whether we really
> want to carry these in the kernel.
> Which sounded like an ideal testbed for eBPF struct_ops to me.
> Taking a cue from Ming Lei's patchset for eBPF on ublk (thanks,
> Ming!)
> I've started messing around with eBPF.

I happen to have experience in this area and would like to participate
in the development of nvme-bpf. I have previously developed the MPTCP
BPF packet scheduler [1], which is already in the export branch of the
MPTCP repository [2].

[1]
https://github.com/multipath-tcp/mptcp_net-next/issues/75

[2]
https://github.com/multipath-tcp/mptcp_net-next/commit/e83320eb669f48effae8a2d203d834ca2454308a
https://github.com/multipath-tcp/mptcp_net-next/commit/397b7213a2e45bc0c188d5fefa0889899657716f
https://github.com/multipath-tcp/mptcp_net-next/commit/0c59c5d43f6babd016bdbbf00365257ea57796e9

> 
> So here's a patchset to implement nvme multipath eBPF path selectors.
> Idea's quite simple: the eBPF 'struct_ops' program is providing a
> 'select_path' function, which selects a nvme_ns struct to use for
> the I/O starting at a given sector.
> Unfortunately ePBF doesn't allow to pass pointers, _and_ the
> definitions
> for 'struct nvme_ns_head' and 'struct nvme_ns' are internal to the
> nvme subsystem. So I kept those structures as opaque pointers for
> ePBF, and introduced a 'nvme_bpf_iter' structure as a path iterator.
> There are two functions 'nvme_bpf_first_path' and
> 'nvme_bpf_next_path'
> which can be used for an open-coded loop over all paths.
> I've also added sample code as an example how the loop can be coded.
> 
> It's all pretty rudimentary (as I'm sure people will need accessors
> to get to any namespace or controller details), but that's why I sent
> it out as an RFC. And I am by no means an eBPF expert, so I'd be
> glad for any corrections or suggestions for a better eBPF
> integration.
> 
> The entire patchset can be found at:
> git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
> branch nvme-bpf
> 
> As usual, reviews and comments are welcome.
> 
> Hannes Reinecke (6):
>   nvme-multipath: do not assign ->current_path in __nvme_find_path()
>   nvme: export nvme_find_get_subsystem()/nvme_put_subsystem()
>   nvme: add per-namespace iopolicy sysfs attribute
>   nvme: add 'sector' parameter to nvme_find_path()
>   nvme-bpf: eBPF struct_ops path selectors
>   tools/testing/selftests: add sample nvme bpf path selector
> 
>  drivers/nvme/host/Kconfig                     |   9 +
>  drivers/nvme/host/Makefile                    |   1 +
>  drivers/nvme/host/bpf.h                       |  33 ++
>  drivers/nvme/host/bpf_ops.c                   | 347
> ++++++++++++++++++
>  drivers/nvme/host/core.c                      |  17 +-
>  drivers/nvme/host/ioctl.c                     |   7 +-
>  drivers/nvme/host/multipath.c                 |  69 +++-
>  drivers/nvme/host/nvme.h                      |  11 +-
>  drivers/nvme/host/pr.c                        |   2 +-
>  drivers/nvme/host/sysfs.c                     |   9 +-
>  include/linux/nvme-bpf.h                      |  54 +++
>  .../selftests/bpf/progs/bpf_nvme_simple.c     |  52 +++
>  12 files changed, 585 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/nvme/host/bpf.h
>  create mode 100644 drivers/nvme/host/bpf_ops.c
>  create mode 100644 include/linux/nvme-bpf.h
>  create mode 100644
> tools/testing/selftests/bpf/progs/bpf_nvme_simple.c

