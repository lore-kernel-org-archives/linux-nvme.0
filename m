Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C97CD4F54
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLE9+XAPG4f46HyNwpGtUdLJDwiw2m2vPxaZCmY7ZCs=; b=LARxmqaUDwq5lLqwiczzIe6vtm
	amIXyiaLCy2NTkf769ibVhIrJmpeFB8lwJWAQqElqGlwgiDTVuq4nIxkAVtt7VM5M6281EuiNLRLL
	ur1ILlHwSeKfHy7uOMN49JmuDv2wNM7ZJFWB8yFSQoaLNXzzxA3YSEwrpws/abFQjMKNv7yNAV3TC
	4/GSFmUoPPhNUD3KkzgjHG+oCWjlVaJLeux6o4lVIlLgwcMygrd/aOThgig9HTjQ7O16Qk40EtZ+b
	xC8u32GJso/MkXOq5Ejgqs5foJ/KYG58I637816wu1LtSMsVyrYHmtHgcOVx1hwHmuYGlC3eo22mE
	sdvyi3zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSy5B-00000007Vkv-2YRY;
	Fri, 29 May 2026 14:21:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSy58-00000007VkG-3UyA
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 14:21:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE6ED4397F;
	Fri, 29 May 2026 14:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9991F00893;
	Fri, 29 May 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780064461;
	bh=wLE9+XAPG4f46HyNwpGtUdLJDwiw2m2vPxaZCmY7ZCs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kUCS4WzItv2nQMqEyJDBOP9ufttGz6xM6Eqjxxm92DkT/9TlS98Qz7KVt/CVrL5md
	 NrsAHK8Jo7Cai97MJrm1+KJDrUTtUVlJYe9v3m2yhzUA8nwMhRAMTZkNSZIdaTQLcJ
	 +sAUxG2RlVkKZZZlEyLxewXUljvLQqTgA9ymP4+QA+nzC1qlnzlmU15KaW8clvq9JZ
	 m++Mw9t2z5HNH843AOqC55Nak/xrq54r+jo6Lacy/912vZ57vB7SU7lvscWtks03+y
	 M1IHtkox/Ra9y9DaeyVYBaP4AqWQRVbJexiP/ztxroci/cv2tPfgEn9vOz1P+mNToF
	 THsdk7zxjcG1A==
Message-ID: <4df03cad08088fba7fb49beaeb6513cef5b87c2b.camel@kernel.org>
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,  Shuah Khan <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org,  Hannes Reinecke	 <hare@suse.de>, John
 Meneghini <jmeneghi@redhat.com>, Randy Jennings	 <randyj@purestorage.com>,
 Nilay Shroff <nilay@linux.ibm.com>, zhenwei pi	 <zhenwei.pi@linux.dev>, Hui
 Zhu <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 29 May 2026 22:20:51 +0800
In-Reply-To: <20260528082344.7e4cd1a1@kernel.org>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
		<a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
	 <20260528082344.7e4cd1a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_072102_915234_80186B97 
X-CRM114-Status: GOOD (  16.07  )
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

Hi Jakub,

On Thu, 2026-05-28 at 08:23 -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 11:10:36 +0800 Geliang Tang wrote:
> > Dedicated MPTCP helpers are introduced for setting accept socket
> > options.
> > These helpers (no_linger, set_priority, set_tos) set the values on
> > all
> > existing subflows using mptcp_for_each_subflow(). The values are
> > then
> > synchronized to other newly created subflows in
> > sync_socket_options().
> 
> These are not protocol specific options, why do we have to export
> MPTCP-specific functions for them?

Thank you for reading the code. In addition to the three MPTCP-specific
functions implemented in this patch, I have implemented and exported
the following six MPTCP-specific functions throughout the series:

    void mptcp_sock_set_nodelay(struct sock *sk)
    int mptcp_sock_set_syncnt(struct sock *sk, int val)
    void mptcp_sock_set_tos(struct sock *sk, int val)
    void mptcp_sock_no_linger(struct sock *sk)
    void mptcp_sock_set_priority(struct sock *sk, u32 priority)
    void mptcp_sock_set_reuseaddr(struct sock *sk)

These correspond to the following six functions originally used for
TCP:

    tcp_sock_set_nodelay()
    tcp_sock_set_syncnt()
    ip_sock_set_tos()
    sock_no_linger()
    sock_set_priority()
    sock_set_reuseaddr()

The first two functions - tcp_sock_set_nodelay() and
tcp_sock_set_syncnt() - cannot be directly used with an MPTCP socket.
In fact, passing an MPTCP socket to tcp_sock_set_nodelay() even causes
a crash. Therefore I implemented these two MPTCP-specific functions.
Actually, a better approach would be to add protocol-independent
sock_set_nodelay() and sock_set_syncnt() in net/core/sock.c.

The third function, ip_sock_set_tos(), takes different arguments for
TCP vs. MPTCP. For MPTCP, it needs to pass inet_sk(msk->first)-
>rcv_tos, so I implemented an MPTCP-specific function.

The last three functions - sock_no_linger(), sock_set_priority(), and
sock_set_reuseaddr() - are not protocol-specific, but attributes set on
the MPTCP socket cannot be synchronized to its subflows because
mptcp_sockopt_sync_locked() checks msk->setsockopt_seq. Thus I
implemented these three MPTCP-specific functions, explicitly calling
sockopt_seq_inc(msk) inside them to increment msk->setsockopt_seq, so
that mptcp_sockopt_sync_locked() can properly synchronize the
attributes to all subflows. There should be a better solution for this,
and I will discuss it with @Matt.

Please give me some advice.

Thanks,
-Geliang

