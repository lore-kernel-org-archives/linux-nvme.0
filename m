Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04084C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 05:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWs/6GxHQxoazFHckud13tONmCIETA3kp/c4/93T8NM=; b=toT9P7M5O0M4ZR29oh+Fk/NeSY
	3Z5Pwl9/G2Zzs6f7vqJO9SbAZda+LY6WiN2L5e3KBCq0k5z/2vZ1jhB4SOdXhhddk62qbha9bSSQB
	4ip+EyNzuxCMvR4S1hGHwbm2RkZF4WeOOwRHdcVlg7kBlBEAue/9E7KsN6Z439fdwwdaQX1MmFSeN
	pPOuX/JhnapaBvk+85WKU8qve7Ib4AdZ85BhwrfyyufWMRIQnzYg/gMvNrNWHCfSsR2zvKAiabohi
	52IDPv8foZdmUdHfydeJb8Nh1hcNJaV7gnLTxhDIvrsSotHFBXTGy8Hn6UQpkEFMhW+Fxe7KSdKfV
	V4SGctCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wowfX-00000006vHI-3jyw;
	Wed, 29 Jul 2026 05:17:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wowfV-00000006vGf-2fLT
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 05:17:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3ADD660A5E;
	Wed, 29 Jul 2026 05:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828C51F00A3A;
	Wed, 29 Jul 2026 05:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302241;
	bh=yWs/6GxHQxoazFHckud13tONmCIETA3kp/c4/93T8NM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EhZImyy49vt9VDzAGhjB3JLqZvmRIkP8dVwVm6zFEToqWk8UED3GrttsvyEZIMjr1
	 xzICm3UOdob564x9n0uwBj2n/8C0oZOZszoY6S6XE7+ug1yZreBTRVOAW/b+56Tlog
	 YaXfxojn0sUte61ZkePHT+5ou9lMB8n2+4bafMetmJVz5/8JnDbOgOdtNkaf9Qle8C
	 jslz9QhFqszhv9Zer7+APDKiL4bUhLVNu0NveFivM2O153YPJ+Tgt8c15WCidP7q7V
	 H9PkRNGTZWcY2/+CIMNaD5apedNQ2GVhj6d9iDJ4BWtXIdIIlTO4LFqiEFW1glXFSK
	 voWjQuyVjcYwA==
Message-ID: <10356f7d8b0ffdba27987c79fc7f4b7574cf873b.camel@kernel.org>
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Mat
 Martineau <martineau@kernel.org>,  "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, 	linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, John Meneghini <jmeneghi@redhat.com>,
 Randy Jennings <randyj@purestorage.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hui Zhu <zhuhui@kylinos.cn>,  Gang Yan <yangang@kylinos.cn>
Date: Wed, 29 Jul 2026 13:17:10 +0800
In-Reply-To: <4df03cad08088fba7fb49beaeb6513cef5b87c2b.camel@kernel.org>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
			<a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
		 <20260528082344.7e4cd1a1@kernel.org>
	 <4df03cad08088fba7fb49beaeb6513cef5b87c2b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
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

Thank you all very much for your interest in "NVMe over MPTCP" and for
adding review comments to this version of the series. This has been
very helpful to me. There are indeed some issues with this version, but
the good news is that I have recently found a direction for improving
it.

On Fri, 2026-05-29 at 22:20 +0800, Geliang Tang wrote:
> Hi Jakub,
> 
> On Thu, 2026-05-28 at 08:23 -0700, Jakub Kicinski wrote:
> > On Thu, 28 May 2026 11:10:36 +0800 Geliang Tang wrote:
> > > Dedicated MPTCP helpers are introduced for setting accept socket
> > > options.
> > > These helpers (no_linger, set_priority, set_tos) set the values
> > > on
> > > all
> > > existing subflows using mptcp_for_each_subflow(). The values are
> > > then
> > > synchronized to other newly created subflows in
> > > sync_socket_options().
> > 
> > These are not protocol specific options, why do we have to export
> > MPTCP-specific functions for them?
> 
> Thank you for reading the code. In addition to the three MPTCP-
> specific
> functions implemented in this patch, I have implemented and exported
> the following six MPTCP-specific functions throughout the series:
> 
>     void mptcp_sock_set_nodelay(struct sock *sk)
>     int mptcp_sock_set_syncnt(struct sock *sk, int val)
>     void mptcp_sock_set_tos(struct sock *sk, int val)
>     void mptcp_sock_no_linger(struct sock *sk)
>     void mptcp_sock_set_priority(struct sock *sk, u32 priority)
>     void mptcp_sock_set_reuseaddr(struct sock *sk)
> 
> These correspond to the following six functions originally used for
> TCP:
> 
>     tcp_sock_set_nodelay()
>     tcp_sock_set_syncnt()
>     ip_sock_set_tos()
>     sock_no_linger()
>     sock_set_priority()
>     sock_set_reuseaddr()

Here I missed one option, SO_BINDTODEVICE. Currently, NVMe TCP sets 7
sockopts: TCP_NODELAY, TCP_SYNCNT, IP_TOS, SO_LINGER, SO_PRIORITY,
SO_REUSEADDR, and SO_BINDTODEVICE. The first 6 are called through the
following 6 functions:

    tcp_sock_set_nodelay()
    tcp_sock_set_syncnt()
    ip_sock_set_tos()
    sock_no_linger()
    sock_set_priority()
    sock_set_reuseaddr()

The last one is called through sock_setsockopt:

    ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
                          optval, strlen(iface));

In NVMe TCP, the first three - TCP_NODELAY, TCP_SYNCNT, IP_TOS - are
protocol-specific, while the last four - SO_LINGER, SO_PRIORITY,
SO_REUSEADDR, SO_BINDTODEVICE - are protocol-independent.

When we add NVMe MPTCP support, all sockets created when using NVMe
MPTCP are MPTCP sockets. Using the above functions to set sockopts on
MPTCP sockets will not succeed. The implementations of these 7 sockopts
for MPTCP are all protocol-specific. MPTCP needs to set the sockopts
not only on the MPTCP socket itself but also synchronize them to all
subflow sockets, so that the sockopts actually take effect.

Therefore, in this version, I defined MPTCP-specific sockopt functions
for each option, and switched between TCP and MPTCP by defining the
struct nvmet_tcp_proto and struct nvme_tcp_proto structures.



A better design is to initiate protocol-specific sockopt settings from
the NVMe side by calling the sock_common_setsockopt() function. This
can automatically select the appropriate protocol and call each
protocol's .setsockopt implementation to set the sockopt, thus making
it compatible with both TCP and MPTCP, without needing to export
functions from the TCP or MPTCP side for NVMe to use.

For MPTCP, all 7 sockopt functions can be implemented by passing each
sockopt to sock_common_setsockopt(), similar to:

static void nvmet_tcp_sock_no_linger(struct sock *sk) 
{
    struct linger ling = { .l_onoff = 1, .l_linger = 0 }; 

    sock_common_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
                           KERNEL_SOCKPTR(&ling), sizeof(ling));
}

However, for TCP, the three protocol-specific options - TCP_NODELAY,
TCP_SYNCNT, IP_TOS - can be implemented by calling
sock_common_setsockopt(), but the other four protocol-independent ones
need to be called through sock_setsockopt(). To hide this difference,
we can call the higher-level do_sock_setsockopt() function instead,
like:

static void nvmet_tcp_sock_no_linger(struct sock *sk) 
{
    struct linger ling = { .l_onoff = 1, .l_linger = 0 }; 

    do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
                       KERNEL_SOCKPTR(&ling), sizeof(ling));
}

In this way, this wrapper becomes protocol-independent and works
correctly for both TCP and MPTCP. Moreover, all 7 functions are
uniformly converted into wrappers that call do_sock_setsockopt(), so
every one of them becomes protocol-independent without needing to
distinguish between TCP and MPTCP internally.

static void nvmet_tcp_sock_set_priority(struct sock *sk, u32 priority)
{
    do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_PRIORITY,
                       KERNEL_SOCKPTR(&priority), sizeof(priority));
}

static void nvmet_tcp_sock_set_reuseaddr(struct sock *sk) 
{
    int val = SK_CAN_REUSE;

    do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_REUSEADDR,
                       KERNEL_SOCKPTR(&val), sizeof(val));
}

static void nvmet_tcp_sock_set_nodelay(struct sock *sk) 
{
    int val = 1; 

    do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
                       KERNEL_SOCKPTR(&val), sizeof(val));
}

static void nvmet_tcp_sock_set_tos(struct sock *sk, int tos) 
{
    do_sock_setsockopt(sk->sk_socket, false, SOL_IP, IP_TOS,
                       KERNEL_SOCKPTR(&tos), sizeof(tos));
}

static int nvme_tcp_sock_set_bindtodevice(struct sock *sk, char *iface)
{
    return do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET,
                              SO_BINDTODEVICE,
                              KERNEL_SOCKPTR(iface), strlen(iface));
}

static int nvme_tcp_sock_set_syncnt(struct sock *sk, int val) 
{
    return do_sock_setsockopt(sk->sk_socket, false, SOL_TCP,
                              TCP_SYNCNT, KERNEL_SOCKPTR(&val),
                              sizeof(val));
}

With this approach, there is no longer any need to define structures
like struct nvmet_tcp_proto and struct nvme_tcp_proto, nor to export
special set-sockopt functions from the MPTCP side. We only need to
define these 7 wrappers for NVMe, and then replace the original
function calls with the wrapper calls to enable MPTCP support. For
example:

-   sock_set_reuseaddr(port->sock->sk);
-   tcp_sock_set_nodelay(port->sock->sk);
+   nvmet_tcp_sock_set_reuseaddr(port->sock->sk);
+   nvmet_tcp_sock_set_nodelay(port->sock->sk);
    if (so_priority > 0)
-       sock_set_priority(port->sock->sk, so_priority);
+       nvmet_tcp_sock_set_priority(port->sock->sk, so_priority);



With these changes, implementing NVMe MPTCP support is simplified to
just choosing which type of socket to create at socket creation time.
In addition, I am also pushing the company I work for to join the NVMe
membership, in preparation for submitting an MPTCP proposal to the NVMe
technical working group in the future.




I'm thinking that this approach of unifying NVMe sockopts via
do_sock_setsockopt() could actually serve as a general improvement, and
it would be valid even independently of this MPTCP series. If no one
objects, I will send these patches of do_sock_setsockopt() improvement
to the NVMe mailing list for review in the near future.



Thanks,
-Geliang

> 
> The first two functions - tcp_sock_set_nodelay() and
> tcp_sock_set_syncnt() - cannot be directly used with an MPTCP socket.
> In fact, passing an MPTCP socket to tcp_sock_set_nodelay() even
> causes
> a crash. Therefore I implemented these two MPTCP-specific functions.
> Actually, a better approach would be to add protocol-independent
> sock_set_nodelay() and sock_set_syncnt() in net/core/sock.c.
> 
> The third function, ip_sock_set_tos(), takes different arguments for
> TCP vs. MPTCP. For MPTCP, it needs to pass inet_sk(msk->first)-
> > rcv_tos, so I implemented an MPTCP-specific function.
> 
> The last three functions - sock_no_linger(), sock_set_priority(), and
> sock_set_reuseaddr() - are not protocol-specific, but attributes set
> on
> the MPTCP socket cannot be synchronized to its subflows because
> mptcp_sockopt_sync_locked() checks msk->setsockopt_seq. Thus I
> implemented these three MPTCP-specific functions, explicitly calling
> sockopt_seq_inc(msk) inside them to increment msk->setsockopt_seq, so
> that mptcp_sockopt_sync_locked() can properly synchronize the
> attributes to all subflows. There should be a better solution for
> this,
> and I will discuss it with @Matt.
> 
> Please give me some advice.
> 
> Thanks,
> -Geliang

