Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B2606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yUMBGFXp;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hT4nRyna;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L+renau/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tTWHXYAS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NhhSUtOb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ywj6Y4ISqNzAsc/R9l8HW4ZdxhZotXblT/hHSfCYUkM=; b=yUMBGFXpEuxeDs
	d14l2cQ4ojw3IDeZ5P4hKhbUyjfn7z8KiKOtTG1OMBd8OJOXHBhs10R/nKcEWm1LdAMY8QZlQzHud
	kOMAJ56CZCaSQqPb+9D99ro0aev4gF3RGJwpkfmR9FEcmcin7kswjZYLRqhb1irQhxtzfQKmMsrM1
	QwV+6dAMTGOn5HhE66t61t7VO+xetfm/sda9IraiSaSuOT67qtwfi3NX+Kg+Xceq9TMHb9K4J7YQ5
	mojgNM6Jmuj/zZdaWJT21Y78x1vUn+5PvZEQPYQ9Yyyso4GA9DF+B0Hw78p/dckIos+G0GWDzswQa
	pkBbzBAxChHz5dh/NDhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4Ph-00000007Avo-1Dsp;
	Wed, 28 Oct 2026 14:14:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4Pd-00000007AvK-2zdS
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:13:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E25A31F7E9;
	Wed, 28 Oct 2026 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793196835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywj6Y4ISqNzAsc/R9l8HW4ZdxhZotXblT/hHSfCYUkM=;
	b=hT4nRynaGNh/9S1BPuWDRx/vLvAhwTNyTqzTedj5H1uqxTkMiJZpwzustuzaA6gpK9Gik0
	OhzYhHJqiB7sDkW92UbRS9youua7yWg/Kqf6jasTT8CcVav6I42mfNsI0+YrPtiWWdycIj
	5tH2Oq0cToZsKfmmR0078RXdwJ25VyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793196835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywj6Y4ISqNzAsc/R9l8HW4ZdxhZotXblT/hHSfCYUkM=;
	b=L+renau/KfhS0vejJyPpY58LLQxr2uP1ov9IHqOAnXRQZZVFxyC2s7kVeQ2VdvHgd+VhcN
	gd9d35X1/4o6ekBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tTWHXYAS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NhhSUtOb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793196833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywj6Y4ISqNzAsc/R9l8HW4ZdxhZotXblT/hHSfCYUkM=;
	b=tTWHXYASVmJUvshGwG3+OXE5MTFCss4+7C4TApu0hMuoZ8GPA/YVbqel2wfadATk4Fk9WW
	EHRyXyuGy9/15S+uRtH1t2nJn1ngWCbB8X6wwZ24XghO4a3Ir2aHz8zH8ru8hvAZUc3Wrx
	2G+ye4a2DvYrGA4WXsCsJoiNq1rM62s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793196833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywj6Y4ISqNzAsc/R9l8HW4ZdxhZotXblT/hHSfCYUkM=;
	b=NhhSUtObH0+IQtROzEp+GDP+D2NO6s2Ca0SwVoPO8W+Y5CQcAcStPoSgRB4MNp7KXplLlO
	HSbx3BBN7Jj1YZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 841AE1321C;
	Wed, 28 Oct 2026 14:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mCtuFyED4moDaQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 14:13:53 +0000
Message-ID: <08ce23d6-94a6-4539-bedc-6bb4b77a35b2@suse.de>
Date: Wed, 28 Oct 2026 15:13:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 2/5] tls: add socket options to register
 the traffic secrets
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
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <20261028-keyupdate-rfc-v2-2-eb5143b4c487@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028-keyupdate-rfc-v2-2-eb5143b4c487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E25A31F7E9
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ietf.org:url,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_071358_071748_67C151CF 
X-CRM114-Status: GOOD (  40.19  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 2:52 PM, Martin Belanger via B4 Relay wrote:
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
> The secret must give the installed key and IV, or the option fails with
> -EINVAL. A wrong secret would otherwise fail only at the first
> KeyUpdate.
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
>   Documentation/networking/tls.rst |  26 ++++++++
>   include/net/tls.h                |  13 ++++
>   include/uapi/linux/tls.h         |   2 +
>   net/tls/tls_main.c               | 139 ++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 179 insertions(+), 1 deletion(-)
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
> index 8bdb78718a8d..8bb1b2773f3f 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -31,6 +31,8 @@
>    * SOFTWARE.
>    */
>   
> +#include <crypto/sha2.h>
> +#include <crypto/utils.h>
>   #include <linux/module.h>
>   
>   #include <net/tcp.h>
> @@ -325,6 +327,8 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
>   
>   	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
>   	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
> +	memzero_explicit(&ctx->tx_secret, sizeof(ctx->tx_secret));
> +	memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>   	mutex_destroy(&ctx->tx_lock);
>   
>   	if (sk)
> @@ -757,8 +761,16 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>   		ctx->rx_conf = conf;
>   	update_sk_prot(sk, ctx);
>   
> -	if (update)
> +	if (update) {
> +		/* The registered secret no longer matches the key. The RX
> +		 * secret also needs the TX one, see do_tls_setsockopt_secret().
> +		 */
> +		if (tx)
> +			memzero_explicit(&ctx->tx_secret,
> +					 sizeof(ctx->tx_secret));
> +		memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>   		return 0;
> +	}
>   
>   	if (tx) {
>   		ctx->sk_write_space = sk->sk_write_space;
> @@ -857,6 +869,124 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
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
> +/* The installed key and IV must be the ones that @secret gives. Each
> + * KeyUpdate derives the next key from the secret, so a wrong secret
> + * fails only at the first KeyUpdate, with no clear cause.
> + */
> +static int tls_check_traffic_secret(struct tls_crypto_info *crypto_info,
> +				    const u8 *secret, int len)
> +{
> +	const struct tls_cipher_desc *cipher_desc;
> +	u8 iv[TLS_MAX_SALT_SIZE + TLS_MAX_IV_SIZE];
> +	u8 key[TLS_CIPHER_AES_GCM_256_KEY_SIZE];
> +	int rc;
> +
> +	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
> +	if (!cipher_desc || cipher_desc->key > sizeof(key) ||
> +	    cipher_desc->salt + cipher_desc->iv > sizeof(iv))
> +		return -EINVAL;
> +
> +	rc = tls_hkdf_expand_label(secret, len, "key", key, cipher_desc->key);
> +	if (rc)
> +		goto out;
> +
> +	rc = tls_hkdf_expand_label(secret, len, "iv", iv,
> +				   cipher_desc->salt + cipher_desc->iv);
> +	if (rc)
> +		goto out;
> +

You could add a comment that this follows the rules for key derivation
from RFC 8446, to be clear what we are doing here.

But aside from the:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

