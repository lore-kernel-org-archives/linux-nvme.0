Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D5D116F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezVdTe66hCsBHe9YjPW97A/EKiK/en1LjTKvvDte1tQ=; b=uWSoIWMPPrSyEQ8MowYh6IWX74
	gF6VycLiKg0NbRID9HI87ZCEZF3/TJvzhPoZTeBhngCKvsCDA5yQCRiCFAkixMjjwElQNWEYXW2BI
	1vImLMM7r6HqBDwtdKRNyKkQK0eQ6YgyKZYRTIGyYecIct2ZUMhxeRIPgC3j4kMltsRt+eW/ohBo6
	tlA1NLCRInmf/G8oZlBWcf3Af5rnGNminAbYce5Ha9C/9TNWdMXjwzkaOXCgRw3RyuWEzs4MeTA3x
	QThUNEYdRu7TRQgkMt8XA6rQldkC5puIEIlEfaWoL2TNS8+mLVd3e7oravXZPNGNYcBmEvcVkBPVA
	l8aaGOrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQlB-00000005T0A-0IlW;
	Tue, 02 Dec 2025 13:49:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQl9-00000005Szq-1E4w
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 13:49:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4415A43874;
	Tue,  2 Dec 2025 13:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89B8C4AF0B;
	Tue,  2 Dec 2025 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764683378;
	bh=+k6IKNHwyDdeRTStkY5MAPDxxoHM3AKMvpgF0ZW5rLg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q1DHjj3vO+WgIuWMmF2sfel+ikrQJMwJkBpJlWQ/pc3pBcbOpa5HmjbytMUiB1DRj
	 ADYqix0irgqg80KkxkbB/LSoSCXGTRBtTLJiIq8e+dgQjC6aAePFpqohyNW3u8tUc2
	 dx48KcdwWTPauE5FEynWh/IIFP1S9bXq9jpC3WKt2ZJNbj/6ZL4H4q+dzMTdgigPer
	 LSLEYnfY8xEKnWyplf4cRp1v+bDO/Dr5lFNu3eWR3IICrFIGXjhcsleicNcIBNDIZR
	 bPU0KZuVIgDhAnwJ5+r/Teit++jzetszLneUPVr/OGpnXeIy+pAua3guLB9UUX5JDX
	 ZUBhHKcqUrU5A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B15BCF4007F;
	Tue,  2 Dec 2025 08:49:36 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 08:49:36 -0500
X-ME-Sender: <xms:cO4uabX4rRqLAF8911zqMXEORtCjsQKXWq531zCnZxZ6TedFFoBVvA>
    <xme:cO4uaeZW8MHuDlbIGGBdRh7wTXq6XbcQBegCGHhdwEHYF1Ye8jvYg-2zZDNKFRMG1
    3sAymyPROPDwiQ-zr1c0QbvstMAeYuuDty2QhjeyqsxfXTKS7n53PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghlihhsthgrihhrvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrghhise
    hgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdp
    rhgtphhtthhopehhrghrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgsuhhstg
    hhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishht
    shdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdqhh
    grnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehhtghh
    sehlshhtrdguvgdprhgtphhtthhopehktghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:cO4uaZ18EOCh4eaxjtPxseWol4MMiABA-hHsO_BvIcXrWLkkfinFHg>
    <xmx:cO4uacbmN-ujhZi6be-rzXACSehX7XGzIJy88iyrDt-hnya3Mrm8QA>
    <xmx:cO4uabjIoIxgTC7q7JMUfRDBMcE1VDe11Fs8AWQSNPoWZwXqtKfEbA>
    <xmx:cO4uaT-FrzfKGHAUQBo1TQBfLmhxC6Mbta9Hkc374-aj8AwtNa35jg>
    <xmx:cO4uaRPyZ6LKxRuJQ55kTv38cCee-Ua_s0d0wIS4OqGyvTXuDcINuSiD>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32AA078006C; Tue,  2 Dec 2025 08:49:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: At8y7R5pevGF
Date: Tue, 02 Dec 2025 08:49:12 -0500
From: "Chuck Lever" <cel@kernel.org>
To: alistair23@gmail.com, "Chuck Lever" <chuck.lever@oracle.com>,
 hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, hare@suse.de, "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <962da16d-b16c-461f-bb35-75c58d89fe3a@app.fastmail.com>
In-Reply-To: <20251202013429.1199659-3-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
 <20251202013429.1199659-3-alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/5] net/handshake: Define handshake_req_keyupdate
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_054939_397059_1772C0C6 
X-CRM114-Status: GOOD (  29.14  )
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



On Mon, Dec 1, 2025, at 8:34 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Add a new handshake_req_keyupdate() function which is similar to the
> existing handshake_req_submit().
>
> The new handshake_req_keyupdate() does not add the request to the hash
> table (unlike handshake_req_submit()) but instead uses the existing
> request from the initial handshake.
>
> During the initial handshake handshake_req_submit() will add the request
> to the hash table. The request will not be removed from the hash table
> unless the socket is closed (reference count hits zero).
>
> After the initial handshake handshake_req_keyupdate() can be used to re-use
> the existing request in the hash table to trigger a KeyUpdate with
> userspace.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v6:
>  - New patch
>
>  net/handshake/handshake.h |  2 +
>  net/handshake/request.c   | 95 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>
> diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
> index a48163765a7a..04feacd1e21d 100644
> --- a/net/handshake/handshake.h
> +++ b/net/handshake/handshake.h
> @@ -84,6 +84,8 @@ void handshake_req_hash_destroy(void);
>  void *handshake_req_private(struct handshake_req *req);
>  struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
>  struct handshake_req *handshake_req_next(struct handshake_net *hn, int 
> class);
> +int handshake_req_keyupdate(struct socket *sock, struct handshake_req 
> *req,
> +			 gfp_t flags);
>  int handshake_req_submit(struct socket *sock, struct handshake_req 
> *req,
>  			 gfp_t flags);
>  void handshake_complete(struct handshake_req *req, unsigned int status,
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..916caab88fe0 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -196,6 +196,101 @@ struct handshake_req *handshake_req_next(struct 
> handshake_net *hn, int class)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
> 
> +/**
> + * handshake_req_keyupdate - Submit a KeyUpdate request
> + * @sock: open socket on which to perform the handshake
> + * @req: handshake arguments, this must already be allocated and exist
> + * in the hash table, which happens as part of handshake_req_submit()
> + * @flags: memory allocation flags
> + *
> + * Return values:
> + *   %0: Request queued
> + *   %-EINVAL: Invalid argument
> + *   %-EBUSY: A handshake is already under way for this socket

Or, an initial handshake hasn't been done yet. Perhaps that
deserves its own errno value...

Thanks for considering this idea!


> + *   %-ESRCH: No handshake agent is available
> + *   %-EAGAIN: Too many pending handshake requests
> + *   %-ENOMEM: Failed to allocate memory
> + *   %-EMSGSIZE: Failed to construct notification message
> + *   %-EOPNOTSUPP: Handshake module not initialized
> + *
> + * A zero return value from handshake_req_submit() means that
> + * exactly one subsequent completion callback is guaranteed.
> + *
> + * A negative return value from handshake_req_submit() means that
> + * no completion callback will be done and that @req has been
> + * destroyed.
> + */
> +int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
> +			    gfp_t flags)
> +{
> +	struct handshake_net *hn;
> +	struct net *net;
> +	struct handshake_req *req_lookup;
> +	int ret;
> +
> +	if (!sock || !req || !sock->file) {
> +		kfree(req);
> +		return -EINVAL;
> +	}
> +
> +	req->hr_sk = sock->sk;
> +	if (!req->hr_sk) {
> +		kfree(req);
> +		return -EINVAL;
> +	}
> +	req->hr_odestruct = req->hr_sk->sk_destruct;
> +	req->hr_sk->sk_destruct = handshake_sk_destruct;
> +
> +	ret = -EOPNOTSUPP;
> +	net = sock_net(req->hr_sk);
> +	hn = handshake_pernet(net);
> +	if (!hn)
> +		goto out_err;
> +
> +	ret = -EAGAIN;
> +	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
> +		goto out_err;
> +
> +	spin_lock(&hn->hn_lock);
> +	ret = -EOPNOTSUPP;
> +	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
> +		goto out_unlock;
> +	ret = -EBUSY;
> +
> +	req_lookup = handshake_req_hash_lookup(sock->sk);
> +	if (!req_lookup)
> +		goto out_unlock;
> +
> +	if (req_lookup != req)
> +		goto out_unlock;
> +	if (!__add_pending_locked(hn, req))
> +		goto out_unlock;
> +	spin_unlock(&hn->hn_lock);
> +
> +	test_and_clear_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
> +
> +	ret = handshake_genl_notify(net, req->hr_proto, flags);
> +	if (ret) {
> +		trace_handshake_notify_err(net, req, req->hr_sk, ret);
> +		if (remove_pending(hn, req))
> +			goto out_err;
> +	}
> +
> +	/* Prevent socket release while a handshake request is pending */
> +	sock_hold(req->hr_sk);
> +
> +	trace_handshake_submit(net, req, req->hr_sk);
> +	return 0;
> +
> +out_unlock:
> +	spin_unlock(&hn->hn_lock);
> +out_err:
> +	trace_handshake_submit_err(net, req, req->hr_sk, ret);
> +	handshake_req_destroy(req);
> +	return ret;
> +}
> +EXPORT_SYMBOL(handshake_req_keyupdate);
> +
>  /**
>   * handshake_req_submit - Submit a handshake request
>   * @sock: open socket on which to perform the handshake
> -- 
> 2.51.1

-- 
Chuck Lever

