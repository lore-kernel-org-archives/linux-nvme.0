Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D44C87FCA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIHgRjWM//3Z7Iq76Xe8PI5GrPe5UPxfu1XaM7OOAdI=; b=uRKN0a8WwVckBG2t1oTowLvJ1D
	QXvJXemOFlunjL3cUeSYIX2InrPlakHiZextF+0h9LkOH556/+cteTMRFeBa0GbxQGbhBRNoGRL03
	S7DihGpPlduBN8CW5ZWnLrzqxOQA7sBeTj1wQOdEPTUfJDMOxr4TKtX+jtbgLlDEwUNhk/d+ATZlS
	yfltGiIJPDU6S/Gxg/Lttcqm0umoTux1XArRHLHQ0FjZ1rz2Grp5x0RvVYHw0zACbzF1W6/txJMA4
	UemP+xXIm7rNlHn6XRUjpOYCgyFmCNFzI+KBSKWMiF5LmAqUFhs50k/vgUFSz7Av8Fkq3zgVUIizR
	zYa23wzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugwAc-00000000VyT-3OpO;
	Wed, 30 Jul 2025 02:03:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugwAa-00000000VyI-36Zm
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 02:03:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C7ABC60008;
	Wed, 30 Jul 2025 02:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC60C4CEEF;
	Wed, 30 Jul 2025 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753841031;
	bh=tbw/FfmubPr+bXdHZ2g1e1ISzt9nntPjNtY+Tk3qMt0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T6T5cc20j5oQePKHNXEoWN+eYgSQ/aG/quI1XHXr4vKdD5z8LCmomzLbUfZMSKW5e
	 JC02f8jytARWA+bukpYuZZBpPeNBt3VeXxsiwtr5ABmDxyjACO/kPeqBRTUuk8AA4M
	 TNWGSnC3bBA2o+jWWskZG11WgJMopcqk91nbeh3JamkHv94E+aKWMaUBd1zMuNknFl
	 CxVDKaZz1AlYLtmnalG2r/Domjs9Owj4QfbHu3Ys2FWl1CD4JbPebfVACjx/6A9ILW
	 Z8ggl7T/LihIY3WE3IgKr1rCjTGIXavbnG+B4TiH4DZXW9qXM+oguN+EpWI0+pmm3b
	 hnfgbHnkF2JoA==
Message-ID: <2700214e9aa7c7a886c0742826d10f052042ba62.camel@kernel.org>
Subject: Re: [PATCH 6/6] tools/testing/selftests: add sample nvme bpf path
 selector
From: Geliang Tang <geliang@kernel.org>
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Date: Wed, 30 Jul 2025 10:03:42 +0800
In-Reply-To: <20250729070653.125258-7-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
	 <20250729070653.125258-7-hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I tried to compile this BPF program, but got a compilation error. To
fix it, NVME_BPF and its dependencies need to be enabled in
tools/testing/selftests/bpf/config:

+++ b/tools/testing/selftests/bpf/config
@@ -121,3 +121,8 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_NVME_CORE=y
+CONFIG_NVME_FABRICS=y
+CONFIG_NVME_TCP=y
+CONFIG_NVME_MULTIPATH=y
+CONFIG_NVME_BPF=y

On Tue, 2025-07-29 at 09:06 +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> As a simple nvme bpf path selector to demonstrate the namespace
> path iteration.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  .../selftests/bpf/progs/bpf_nvme_simple.c     | 52
> +++++++++++++++++++

We also need to create an nvme test program in
tools/testing/selftests/bpf/prog_tests/ to load and verify this
bpf_nvme_simple BPF program, just like I did in
tools/testing/selftests/bpf/prog_tests/mptcp.c. I can try to implement
it if you think it's necessary.

Thanks,
-Geliang

>  1 file changed, 52 insertions(+)
>  create mode 100644
> tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
> b/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
> new file mode 100644
> index 000000000000..c9cafb6bd253
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * simple nvme ebpf path selector
> + *
> + * Simulates a RAID layout with chunk size 2M
> + */
> +
> +#include <vmlinux.h>
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +static sector_t simple_offset = 0;
> +static sector_t simple_blocksize = 1048576;
> +
> +SEC("struct_ops")
> +int BPF_PROG(simple_select, struct nvme_bpf_iter *iter, sector_t
> sector)
> +{
> +	sector_t offset = simple_offset;
> +	sector_t block_size = simple_blocksize;
> +	u32 num_blks, num_paths, num_iter, i;
> +	int cntlid;
> +
> +	if (sector > offset)
> +		sector -= offset;
> +	cntlid = nvme_bpf_first_path(iter);
> +	if (cntlid < 0)
> +		return cntlid;
> +	if (!block_size || sector < block_size)
> +		return cntlid;
> +
> +	num_blks = (sector / block_size);
> +	num_paths = nvme_bpf_count_paths(iter);
> +	num_iter = num_blks % num_paths;
> +	bpf_for (i, 1, num_iter) {
> +		cntlid = nvme_bpf_next_path(iter);
> +		if (cntlid < 0)
> +			break;
> +	}
> +	return cntlid;
> +}
> +
> +SEC(".struct_ops")
> +struct nvme_bpf_ops bpf_nvme_simple = {
> +	.uuid = { 0x86, 0xee, 0x41, 0xd5, 0x25, 0x6b, 0x45, 0xd0,
> 0xa4, 0x81, 0x5e, 0x35, 0xf6, 0x02, 0xf5, 0x11 },
> +	.subsysnqn = "blktests-subsystem-1",
> +	.nsid = 1,
> +	.select_path = (void *)simple_select,
> +};

