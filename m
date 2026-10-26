Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF30606A320
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aDWoWcew;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o04SKfON;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FdUlnHs3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=i6CcgjXl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ly0HoaH5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2Tlji1wL3C5Miea4Vt5faKcWvh3GAyU4yBXGwQXSxqg=; b=aDWoWcewFtPq/M
	tUelODMtU1XcTEZUBQhOZJHYAD3Q9QiEj5L3RvtEhzWQOVioemqHei+cbnC/OT0mOF42gLRZP6jle
	ny3xkFOTZdLMzZ7ZMLNrtjGhqKmDJwiX7QO2SjMlrmeNZEEnIkoyXKTMf186P+/3eWsANfU/iGjB3
	yRiMwFe9w4t6Y69OX2OQLZDrsDsoalJTEmvqhSuuQ0AOYcE5mmPG+uBo7XK13q17sMsbUEg9Ywm8N
	zjWOv3ihW6cXaf1aWBXxwhIpX1NBvydPcMSwwygQ9VmYUpm4WDMmtoaSogptKGIsb0kNXoMZFRW1R
	0KafAP33ew9E6cVP1Wtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFGW-00000001qiH-0YH1;
	Mon, 26 Oct 2026 07:37:08 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFGS-00000001qhr-429E
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 07:37:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB313222C7;
	Mon, 26 Oct 2026 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793000223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tlji1wL3C5Miea4Vt5faKcWvh3GAyU4yBXGwQXSxqg=;
	b=o04SKfON50HyvoMwpBtX88PbtmuNHgWFILFXT3+FTIFj+ltc0laLMmAcz4gmynkvc3xuMn
	SZVYnc49JHp0u/zalW81GeaDBbvghJAK0ryY3XgaNQ5rxhBv06uEjHA6NvyCAStmzAaTtk
	86gen5ljqivHgEIHk+nHJ+ctPwHvxOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793000223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tlji1wL3C5Miea4Vt5faKcWvh3GAyU4yBXGwQXSxqg=;
	b=FdUlnHs32cf2ZnSHgxOdJzH9Dgqy8neVhFnafgilixyr/9l0X4P5pakk2OuiSOu4QXq382
	urlHBAxBWKpcuMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793000221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tlji1wL3C5Miea4Vt5faKcWvh3GAyU4yBXGwQXSxqg=;
	b=i6CcgjXleFfiJkAT7ZQOZxTt5AlboPowtNIQgNx50vPUbf1iFmimwV1PdRv346EQ82eNRr
	Xz4wFa3kEY1Iqbay0UguGhoStFOhlxeiOyrKsQhsflc6Hk0PfS3fRLqB5F47W4Db5CehWE
	6kAzlaiGUq9VqiLIQL/r/81GGE9tSVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793000221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tlji1wL3C5Miea4Vt5faKcWvh3GAyU4yBXGwQXSxqg=;
	b=Ly0HoaH5Axxz9P3uPKknOkqHRbtER2LU2Ug0oBT4E0AKvkC4wc+n3bc6MaO2w+i57XPvZd
	QkCxgi+C5AvloZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD9413319;
	Mon, 26 Oct 2026 07:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S9pZJRwD32prAgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 26 Oct 2026 07:37:00 +0000
Message-ID: <131fc354-ff38-4aca-ac3d-8e3a6f3716f4@suse.de>
Date: Mon, 26 Oct 2026 08:37:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 2/5] tls: add socket options to register the
 traffic secrets
To: martin.nvme.dev@gmail.com, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
 <20261025-keyupdate-rfc-v1-2-60b7756eccbd@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261025-keyupdate-rfc-v1-2-60b7756eccbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_003705_321684_1BB4AAED 
X-CRM114-Status: GOOD (  43.54  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 1:36 AM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> kTLS holds the key and IV of each direction, but not the traffic secret
> they were derived from. The derivation is one-way, so the kernel cannot
> compute the next generation for a KeyUpdate on its own.
> 
> Add TLS_TX_TRAFFIC_SECRET and TLS_RX_TRAFFIC_SECRET. The owner of the
> socket passes the TLS 1.3 application traffic secret of a direction after
> installing its key. The cipher of the installed key selects the hash, so
> the option takes only the secret. A socket without a registered secret
> behaves as before.
> 
> The TX secret can be registered alone. The RX secret needs the TX secret
> first: a received KeyUpdate can ask for one in reply, and since the
> kernel consumes the record, only the kernel can send that reply.
> 
> Installing a new key with TLS_TX or TLS_RX removes the secrets that no
> longer apply. The secrets are cleared when the context is freed and
> cannot be read back.
> 
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   Documentation/networking/tls.rst | 26 ++++++++++++
>   include/net/tls.h                | 13 ++++++
>   include/uapi/linux/tls.h         |  2 +
>   net/tls/tls_main.c               | 86 +++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
> index 980c442d7161..2e011bd1ce4a 100644
> --- a/Documentation/networking/tls.rst
> +++ b/Documentation/networking/tls.rst
> @@ -300,6 +300,32 @@ extra byte used by the ContentType field.
>   
>   [1] https://datatracker.ietf.org/doc/html/rfc8449
>   
> +TLS_TX_TRAFFIC_SECRET and TLS_RX_TRAFFIC_SECRET
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``TLS_TX_TRAFFIC_SECRET`` registers the TLS 1.3 application traffic secret
> +of the transmit direction, ``TLS_RX_TRAFFIC_SECRET`` that of the receive
> +direction. With a registered secret, the kernel performs KeyUpdate for that
> +direction itself (RFC 9846, section 4.7.3). The value is the secret itself.
> +TLS 1.3 only, software path only.
> +
> +Install the key of the direction first, with the ``TLS_TX`` or ``TLS_RX``
> +socket option described above. The cipher of that key selects the hash, and
> +the secret must have the length of that hash: 32 bytes for SHA-256
> +(AES-128-GCM, AES-128-CCM, ChaCha20-Poly1305) or 48 bytes for SHA-384
> +(AES-256-GCM). Other ciphers return ``EOPNOTSUPP``.
> +
> +Each secret can be registered once. ``TLS_RX_TRAFFIC_SECRET`` needs
> +``TLS_TX_TRAFFIC_SECRET`` first: a received KeyUpdate can ask for one in
> +reply, and only the kernel sees it. ``TLS_TX_TRAFFIC_SECRET`` alone is
> +allowed.
> +
> +If the application installs a new key itself with ``TLS_TX``, both secrets
> +are removed. With ``TLS_RX``, the RX secret is removed. KeyUpdate for that
> +direction is then left to the application again.
> +
> +The secrets cannot be read back.
> +
>   Statistics
>   ==========
>   
> diff --git a/include/net/tls.h b/include/net/tls.h
> index e57bef58851e..aacc6d12226e 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -65,6 +65,9 @@ struct tls_rec;
>   
>   #define TLS_AAD_SPACE_SIZE		13
>   
> +/* SHA-384, the longest hash of a TLS 1.3 cipher suite kTLS supports */
> +#define TLS_MAX_TRAFFIC_SECRET_SIZE	48
> +
>   #define TLS_MAX_IV_SIZE			16
>   #define TLS_MAX_SALT_SIZE		4
>   #define TLS_TAG_SIZE			16
> @@ -224,6 +227,12 @@ struct tls_prot_info {
>   	u16 tail_size;
>   };
>   
> +/* A TLS 1.3 application traffic secret. len is 0 if none is registered. */
> +struct tls_traffic_secret {
> +	u8 data[TLS_MAX_TRAFFIC_SECRET_SIZE];
> +	u8 len;
> +};
> +
>   struct tls_context {
>   	/* read-only cache line */
>   	struct tls_prot_info prot_info;
> @@ -266,6 +275,10 @@ struct tls_context {
>   	union tls_crypto_context crypto_send;
>   	union tls_crypto_context crypto_recv;
>   
> +	/* Registered for KeyUpdate, protected by the socket lock */
> +	struct tls_traffic_secret tx_secret;
> +	struct tls_traffic_secret rx_secret;
> +
>   	struct list_head list;
>   	refcount_t refcount;
>   	struct rcu_head rcu;
> diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
> index 1245ab38afc1..d1b136ecea96 100644
> --- a/include/uapi/linux/tls.h
> +++ b/include/uapi/linux/tls.h
> @@ -42,6 +42,8 @@
>   #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
>   #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
>   #define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
> +#define TLS_TX_TRAFFIC_SECRET	6	/* TLS 1.3 TX traffic secret */
> +#define TLS_RX_TRAFFIC_SECRET	7	/* TLS 1.3 RX traffic secret */
>   
>   /* Supported versions */
>   #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 8bdb78718a8d..1c6e993ec012 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -31,6 +31,7 @@
>    * SOFTWARE.
>    */
>   
> +#include <crypto/sha2.h>
>   #include <linux/module.h>
>   
>   #include <net/tcp.h>
> @@ -325,6 +326,8 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
>   
>   	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
>   	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
> +	memzero_explicit(&ctx->tx_secret, sizeof(ctx->tx_secret));
> +	memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>   	mutex_destroy(&ctx->tx_lock);
>   
>   	if (sk)
> @@ -757,8 +760,16 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>   		ctx->rx_conf = conf;
>   	update_sk_prot(sk, ctx);
>   
> -	if (update)
> +	if (update) {
> +		/* The registered secret no longer matches the key. The RX
> +		 * secret also needs the TX one, see do_tls_setsockopt_secret().
> +		 */

What is a bit unfortunate that we don't have a direct link between the 
key and the traffic secret. So a user might set a key which is _not_
derived from the traffic secret, rendering the KeyUpdate non-workable.

Can we add a check here?
It should be possible to calculate the key from the traffic secret, no?

> +		if (tx)
> +			memzero_explicit(&ctx->tx_secret,
> +					 sizeof(ctx->tx_secret));
> +		memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>   		return 0;
> +	}
>   
>   	if (tx) {
>   		ctx->sk_write_space = sk->sk_write_space;
> @@ -857,6 +868,72 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>   	return 0;
>   }
>   
> +/* Length of the TLS 1.3 traffic secret for @cipher_type, the size of
> + * its hash. 0 if KeyUpdate is not supported for the cipher.
> + */
> +static int tls_traffic_secret_len(u16 cipher_type)
> +{
> +	switch (cipher_type) {
> +	case TLS_CIPHER_AES_GCM_128:
> +	case TLS_CIPHER_AES_CCM_128:
> +	case TLS_CIPHER_CHACHA20_POLY1305:
> +		return SHA256_DIGEST_SIZE;
> +	case TLS_CIPHER_AES_GCM_256:
> +		return SHA384_DIGEST_SIZE;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int do_tls_setsockopt_secret(struct sock *sk, sockptr_t optval,
> +				    unsigned int optlen, int tx)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_crypto_info *crypto_info;
> +	struct tls_traffic_secret *secret;
> +	int len;
> +
> +	if (tx) {
> +		crypto_info = &ctx->crypto_send.info;
> +		secret = &ctx->tx_secret;
> +	} else {
> +		crypto_info = &ctx->crypto_recv.info;
> +		secret = &ctx->rx_secret;
> +	}
> +
> +	/* The key must be installed first: its cipher selects the hash */
> +	if (!TLS_CRYPTO_INFO_READY(crypto_info) ||
> +	    crypto_info->version != TLS_1_3_VERSION)
> +		return -EINVAL;
> +
> +	if ((tx ? ctx->tx_conf : ctx->rx_conf) != TLS_SW)
> +		return -EOPNOTSUPP;
> +
> +	len = tls_traffic_secret_len(crypto_info->cipher_type);
> +	if (!len)
> +		return -EOPNOTSUPP;
> +
> +	if (sockptr_is_null(optval) || optlen != len)
> +		return -EINVAL;
> +
> +	/* A received KeyUpdate may ask for one in reply. The kernel
> +	 * consumes the record, so only the kernel can send the reply.
> +	 */
> +	if (!tx && !ctx->tx_secret.len)
> +		return -EINVAL;

Hmm? What is this? Doesn't that imply that you first have to set the
TX key before setting the RX key?
The documentation says we can do either way ...

> +
> +	if (secret->len)
> +		return -EBUSY;
> +
> +	if (copy_from_sockptr(secret->data, optval, len)) {
> +		memzero_explicit(secret->data, sizeof(secret->data));
> +		return -EFAULT;
> +	}
> +	secret->len = len;
> +
> +	return 0;
> +}
> +
>   static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>   			     unsigned int optlen)
>   {
> @@ -883,6 +960,13 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>   		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
>   		release_sock(sk);
>   		break;
> +	case TLS_TX_TRAFFIC_SECRET:
> +	case TLS_RX_TRAFFIC_SECRET:
> +		lock_sock(sk);
> +		rc = do_tls_setsockopt_secret(sk, optval, optlen,
> +					      optname == TLS_TX_TRAFFIC_SECRET);
> +		release_sock(sk);
> +		break;
>   	default:
>   		rc = -ENOPROTOOPT;
>   		break;
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

