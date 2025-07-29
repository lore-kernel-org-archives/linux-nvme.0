Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7410FC87FCC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RX9pg46YNbU61hfqpey0N0cah82KfzYjlge+SkMWHoY=; b=2CtZ09WtFVcIqvoe/ypdeMe1Lw
	Yp7t6LPXERhao4gWkBqQbt5edXTyBXIypqhFoSjayMxmz4uGLUWX8I5NL9oHuBbO1gfZSr5+rxkwi
	8+w1fajAlMHlCW5VkSQzWhcK5TJUp5JBtWwIQgdb7hGQ+OM0r8FbUxW3Vgqdct/kc68IYfXE+CnyL
	cWeyqyVgxQPQd6ROZFsl3dH+9Hb0FOIYsZTdQnhmCzrfJhzqkzgSCThboV0v549iF+Aw8Of92rKEa
	n3gjiIvePQQL1E/1bX4e3TJ6/B+2B6qS6Y45WzQ7Fkhj/4LgcbqSROCBFxL2sDinfzEM1rmWmAkk6
	hn+iCmYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh94S-00000001sUs-1ZHs;
	Wed, 30 Jul 2025 15:50:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfNR-0000000GCu5-3CSC
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 08:08:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC20B45C8B;
	Tue, 29 Jul 2025 08:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61926C4CEEF;
	Tue, 29 Jul 2025 08:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776479;
	bh=LVJKkN36qjkh4TnMJiHplxyR9I2VwOGyfMGru+KsKTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LooOaRcDqVFj6TYPVM4bElH0sal8d+yU3vpj7mh7Po0EyZu3w+oLX5+/zt7nQCzdz
	 +vAFMS5zL9RlCAWEhdqbuoOM+E5IA5rfCGvgDbvUNJOwIMrsT3cEZGBlnK2qbS4y+7
	 pA3IYoFMvrwEorSeqRqxmIIDGWzwRDlpEF2aWQGrAe9BDg9PdI3mXGGdTAFlXaWii9
	 sUzxzVgnR9vETwweQNlTaJk28YK8dGPUWCzcY47eJL3yxe7h5pVNMqHXwH3bhyLSBT
	 l2JvI4VShASNpPFfvNiAgOg3lfZ8/2jhFBWlA2kuS+yKa4xwC2ZBqGpo3XfIjZPjU3
	 XXuGk0mW/8JxQ==
Message-ID: <624296dc-69d6-4bdd-bed1-ffcb747fb96d@kernel.org>
Date: Tue, 29 Jul 2025 17:07:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729024150.222513-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_010801_901548_32AB3FBF 
X-CRM114-Status: GOOD (  26.23  )
X-Mailman-Approved-At: Wed, 30 Jul 2025 08:35:22 -0700
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

On 7/29/25 11:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, this limit is not visble to the kernel particularly in the case
> where userspace handles the handshake (tlshd/gnutls). This patch adds
> support for retrieving the record size limit.
> 
> This is the first step in ensuring that the kernel can respect the record
> size limit imposed by the endpoint.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  Documentation/netlink/specs/handshake.yaml |  3 +++
>  Documentation/networking/tls-handshake.rst |  8 +++++++-
>  drivers/nvme/host/tcp.c                    |  3 ++-
>  drivers/nvme/target/tcp.c                  |  3 ++-
>  include/net/handshake.h                    |  4 +++-
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  4 +++-
>  net/sunrpc/xprtsock.c                      |  4 +++-
>  10 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index b934cc513e3d..35d5eb91a3f9 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -84,6 +84,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +        name: record-size-limit
> +        type: u32
>  
>  operations:
>    list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..cd984a137779 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -169,7 +169,8 @@ The synopsis of this function is:
>  .. code-block:: c
>  
>    typedef void	(*tls_done_func_t)(void *data, int status,
> -                                   key_serial_t peerid);
> +                                   key_serial_t peerid,
> +                                   size_t tls_record_size_limit);
>  
>  The consumer provides a cookie in the @ta_data field of the
>  tls_handshake_args structure that is returned in the @data parameter of
> @@ -200,6 +201,11 @@ The @peerid parameter contains the serial number of a key containing the
>  remote peer's identity or the value TLS_NO_PEERID if the session is not
>  authenticated.
>  
> +The @tls_record_size_limit parameter, if non-zero, exposes the tls max
> +record size advertised by the endpoint. Record size must not exceed this amount.
> +A negative value shall indicate that the endpoint did not advertise the
> +maximum record size limit.

size_t cannot be negative... Did you mean:
"A value of 0 (TLS_NO_RECORD_SIZE_LIMIT)..."

Also note that even if the endpoint does not advertize a record sie limit, we
still have one (16K was it ?). So I think that the name TLS_NO_RECORD_SIZE_LIMIT
is a little misleading.

> +
>  A best practice is to close and destroy the socket immediately if the
>  handshake failed.

[...]

> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e1c85123b445..2014d906ff06 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -417,13 +417,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote peer's identity
> + * @tls_record_size_limit: Max tls_record_size_limit of the endpoint

Please make a proper sentence to describe tls_record_size_limit instead of
repeating that argument name.

>   *
>   * If a security policy is specified as an export option, we don't
>   * have a specific export here to check. So we set a "TLS session
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */
> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   size_t tls_record_size_limit)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 04ff66758fc3..509aa6269b0a 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2569,9 +2569,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote's identity
> + * @tls_record_size_limit: Max tls_record_size_limit of the endpoint

Same here.

>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  size_t tls_record_size_limit)
>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =


-- 
Damien Le Moal
Western Digital Research

