Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C033CCC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGSLHm+5r2YjDZa9OvTpQNpwlOfK9c7WttCpRckwv6g=; b=uLd2AoY0hgqxLjosmE1KIyqeN2
	xcub0a2yKrKby+pezCuoM4Vfs0IDCanDC41elunAM8rfOh6o9luhaK1AwNEi4/+YwOUDHSqj6GygQ
	uaWK0CyI1iXVaYhlcgU6LxGYXdUXzBkJ5b5X+BnhfCjL93zlWFCQGzAVMw0OGSS7d+ic/0B0vAlkF
	U17s3ftfrMjlLVgCqpewag+dMD8OsZiaQyBBiQpEo0q1WKlhcVaA3U5Bp/WqzPKGlg6tCzuN65sja
	Z1Lv1bULfF+m59h9pq0kkFxURt6m4Vt4ZU5FTxna+H+OF7WIpa/7MYKkylS/YBJzXgGAomcDQw2Zw
	V7ObZ6MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHZv9-00000001zug-1YOx;
	Fri, 16 Oct 2026 04:51:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHZv7-00000001zuS-248C
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 04:51:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9B674601F0;
	Fri, 16 Oct 2026 04:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D89D1F000C4;
	Fri, 16 Oct 2026 04:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792126312;
	bh=mGSLHm+5r2YjDZa9OvTpQNpwlOfK9c7WttCpRckwv6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NOZSFC/Tf2CsanFYXB5WHiRVu4KtaVvuxq1LA07PMZNZhbBMcLMo2V83DUDjKzoOU
	 13NLxyI81DDgcubxJqN0CaLIxFPl5l86co7+w23gNyji/6KrByha/A7yRgC2675F61
	 NI5Vao9uw2I9L5reRMmtt2f7Nh9fA+QzLBjlKtvBrHanYr4BrSLPuJEKnc8t3hHNtr
	 qjdJJpzP5P45TNg6eV9vnSMc0FvarasA+bZASqnZ3bbiaAl6IkzC+tcmzzFQR6Ijx1
	 wtfmApVrQVslahtWyELu/+jMRXI715MI/TV56WJiZx8s7m2VA1y3eouhUtNCFsZFJY
	 9cjC6SF3SYZmQ==
Message-ID: <6732a24185668fe8b527f7f562dc8453b85ec138.camel@kernel.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Breno Leitao <leitao@debian.org>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chaitanya
 Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>,  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Geliang Tang	
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Fri, 16 Oct 2026 12:51:43 +0800
In-Reply-To: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
			 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
			 <20260819090439.GB9267@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
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

Hi,

Sorry for the late reply. In another patch "mptcp: sockopt: implement
IPV6_TCLASS" [1] on the MPTCP mailing list, I implemented the
__ip6_sock_set_tclass() helper and hoped it would be upstreamed first,
but it is still pending.

Thank you all very much for your review comments, but I was caught in a
dilemma after receiving different suggestions.

On Wed, 2026-08-19 at 11:04 +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch consolidates socket option settings in nvmet-tcp by
> > utilizing
> > the generic do_sock_setsockopt() helper for options including
> > SO_LINGER,
> > SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change
> > eliminates
> > the need to export and use specialized helpers for each individual
> > socket
> > option.
> 
> Hmm.  I see that do_sock_setsockopt is exported, but it really should
> not be.  It's really just an internal helper exposed for io_uring
> and no modular code should be using it (never mind the non-GPL
> export).

You are right, my current version has several problems:

1. do_sock_setsockopt() should be exported with EXPORT_SYMBOL_GPL(),
not EXPORT_SYMBOL().

2. The "compat" parameter of do_sock_setsockopt() should be "true"
instead of "false" to skip BPF cgroup setsockopt programs, matching the
behavior of the original nvme-tcp code.

3. The helpers should return "void" instead of "int", to preserve the
original behavior in nvme-tcp where these socket options are set on a
best-effort basis.

4. Error logging (pr_err) should be inside the helpers to minimize
changes to nvme-tcp code.

5. The helpers should not be duplicated between host and target, they
should be consolidated into a shared header, e.g., nvme/common/tcp-
sockopt.h.

I wonder if we can move forward with this approach once these issues
are fixed?

> 
> > A key benefit of this refactoring is that it decouples the socket
> > option
> > configuration from the underlying transport protocol. This makes it
> > easier to extend nvmet-tcp to support other protocols, such as
> > MPTCP, in
> > the future, as do_sock_setsockopt() abstracts away protocol-
> > specific
> > differences without requiring per-option protocol-specific
> > wrappers.
> 
> We really should have generic helpers in the networking code for this
> and not duplicate them in driver using socket options.

However, I still need to use do_sock_setsockopt() for a fundamental
reason: the upcoming NVMe MPTCP support series requires protocol-
independent socket option handling.

When NVMe creates MPTCP sockets instead of TCP sockets, calling
protocol-specific helpers like tcp_sock_set_nodelay() or
ip_sock_set_tos() directly will not work correctly on MPTCP sockets.
MPTCP needs to set options not only on the MPTCP socket itself but also
synchronize them to all subflow sockets.

In the previous NVMe MPTCP support implementation [2], I exported
protocol-specific sockopt helpers separately on the TCP side and MPTCP
side, then had NVMe switch between them based on the protocol. This is
not as clean as using do_sock_setsockopt() for protocol-independent
calls.

For MPTCP, we could use sock_common_setsockopt() which always
dispatches to the protocol's .setsockopt for all options. However, for
TCP, this doesn't work correctly for SOL_SOCKET level options
(SO_LINGER, SO_PRIORITY, SO_REUSEADDR, SO_BINDTODEVICE) which should be
handled by sock_setsockopt() directly. That's why do_sock_setsockopt()
is used here - it intelligently chooses between sock_setsockopt() for
SOL_SOCKET options and sock->ops->setsockopt() for protocol-specific
options, making it work correctly for both TCP and MPTCP without
requiring nvme-tcp to know which protocol it is dealing with. This is
the key to enabling NVMe MPTCP support without adding MPTCP-specific
exports or protocol dispatch logic in nvme-tcp. A more detailed
discussion can be found in [3].

I would appreciate any further suggestions you may have.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/c17925172fd53c98f0ec5c0095c86e6e28cbebf4.1786938892.git.tanggeliang@kylinos.cn/
[2]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/
[3]
https://patchwork.kernel.org/project/linux-nvme/patch/a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn/


