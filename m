Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8269606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3OYAGx8R;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uRnCeb+k;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qrl3dUQv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KNkKskYf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=I5qEvodV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0GoouXsPGRcw5cbujLG++y+WqrC2pK4L8x9S9lJV950=; b=3OYAGx8ROZx2TW
	GuTizQ2GB91W5PAFu54yLsHKgOY+CJ58xZzGNrb5KTKw7RT/FhpotrpLp/Z/WZBNPbOHE5f+/LINN
	7lig25ZDHHUeS8XT3uOx4AjFXiLjaApcbAPTP26iRUxxXoxWdTfSzTQp96qpmI3VEHr9sIwucLavF
	QPHu8Hi6FsWJW6wKsAcHib+D9O3P+4N4gkxz8OwLuVS5I3+/m0u+250kKY3BMz+NkbMolBVgiP8W/
	Kk5sIIajDyGtK9KlHgEnb4CyLDeFQtxL29sw7mHqT5APDqzSB/9P+egRC3C/kGBsy+0JmZzv8lbR4
	CWtkCZr73soFmuI6aU6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWh-00000001t63-0Nw6;
	Mon, 26 Oct 2026 07:53:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLFWK-00000001sPh-3wE9
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 07:53:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE2C41F896;
	Mon, 26 Oct 2026 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793001207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GoouXsPGRcw5cbujLG++y+WqrC2pK4L8x9S9lJV950=;
	b=uRnCeb+kvbPBUo+CO/yLu6CMEfg9ryNzVC05A1ttZYIs+68lvZPZ5dNRcZialvpMHORFuZ
	LL93qXe5Xe5blpsQ/aN0vLdzm+fkaqLu2ba76eztr6ko9ITZ/Z6r5OLQb0VmxDnqA2kpAc
	eGQ1SI+aJzpEXKy3rS0+38V/k4zA2tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793001207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GoouXsPGRcw5cbujLG++y+WqrC2pK4L8x9S9lJV950=;
	b=qrl3dUQv975W+B/2dxU2RMYBcF+h5cJCiwRq/Znxl4mvsKYTqTyDtXVDTprZsAe1E2hCqb
	ZvQp3UDkVKYWUmDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KNkKskYf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I5qEvodV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793001206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GoouXsPGRcw5cbujLG++y+WqrC2pK4L8x9S9lJV950=;
	b=KNkKskYfNChDzkLfqmZ0pZsbuDyi+TFaD7zZ79JALfjh7+LCeSqWpgF8Dy6ULjn2d4yPhz
	uJTts/chkp1oYoOZ8H1b1J+fzgXnLRCp7R+PDbRPFjn6JzlvQbgQtEVw/t85nnWWIOtDGW
	D7McFsjQQ81wSdq/BlZBXt/EjfHlpvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793001206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GoouXsPGRcw5cbujLG++y+WqrC2pK4L8x9S9lJV950=;
	b=I5qEvodVSdIkLZfOOc14K/kNxJpOtm84rnmFD1i/fP40OvO07M40+iJDSRm6DJVci80GSq
	GFOGl2w+GQBno5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1072413319;
	Mon, 26 Oct 2026 07:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q8NoNPUG32rHEgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 26 Oct 2026 07:53:26 +0000
Message-ID: <8af172e4-0039-4dbb-970e-ab91b3d6e149@suse.de>
Date: Mon, 26 Oct 2026 08:53:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 3/5] tls: update the RX key when a KeyUpdate
 is received
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
 <20261025-keyupdate-rfc-v1-3-60b7756eccbd@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261025-keyupdate-rfc-v1-3-60b7756eccbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: DE2C41F896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_005329_320917_C44BB754 
X-CRM114-Status: GOOD (  42.10  )
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
> When a KeyUpdate arrives, kTLS blocks reads with -EKEYEXPIRED until
> the user installs the next key. A kernel user such as nvme-tcp or
> sunrpc never does, so the connection stalls.
> 
> For a socket with a registered RX secret, derive the next key and
> install it when the KeyUpdate is decrypted. The record is not passed to
> the user, so recvmsg(), splice() and read_sock() go on to the next
> record. Without a registered secret the behavior is unchanged.
> 
> A KeyUpdate that is not alone in its record, has a wrong length or an
> invalid request_update value ends the connection, as RFC 9846 section
> 4.7.3 requires. So does a peer that sends more than 8 KeyUpdates in one
> second, the same limit as GnuTLS.
> 
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   include/net/tls.h       |   7 +++
>   net/tls/Makefile        |   3 +-
>   net/tls/tls.h           |   2 +
>   net/tls/tls_keyupdate.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>   net/tls/tls_sw.c        |  35 +++++++++--
>   5 files changed, 190 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/tls.h b/include/net/tls.h
> index aacc6d12226e..a5bc28a7d1f5 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -63,6 +63,11 @@ struct tls_rec;
>   
>   #define TLS_HANDSHAKE_KEYUPDATE		24	/* rfc8446 B.3: Key update */
>   
> +/* KeyUpdate: msg_type, 24-bit length, request_update (RFC 9846 4.7.3) */
> +#define TLS_KEYUPDATE_MSG_SIZE		5
> +#define TLS_KEY_UPDATE_NOT_REQUESTED	0
> +#define TLS_KEY_UPDATE_REQUESTED	1
> +
>   #define TLS_AAD_SPACE_SIZE		13
>   
>   /* SHA-384, the longest hash of a TLS 1.3 cipher suite kTLS supports */
> @@ -142,6 +147,8 @@ struct tls_sw_context_rx {
>   	u8 zc_capable:1;
>   	u8 reader_contended:1;
>   	bool key_update_pending;
> +	u8 key_update_count;		/* received in this window */
> +	unsigned long key_update_window;	/* jiffies */
>   
>   	struct tls_strparser strp;
>   
> diff --git a/net/tls/Makefile b/net/tls/Makefile
> index 6edcf1271b75..ce8ac6a59f8c 100644
> --- a/net/tls/Makefile
> +++ b/net/tls/Makefile
> @@ -7,6 +7,7 @@ CFLAGS_trace.o := -I$(src)
>   
>   obj-$(CONFIG_TLS) += tls.o
>   
> -tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o
> +tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o \
> +	 tls_keyupdate.o
>   
>   tls-$(CONFIG_TLS_DEVICE) += tls_device.o tls_device_fallback.o
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index b2061f6bf065..63ece8074985 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -149,6 +149,8 @@ int init_prot_info(struct tls_prot_info *prot,
>   		   const struct tls_cipher_desc *cipher_desc);
>   int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
>   			  const char *label, u8 *out, size_t out_len);
> +int tls_keyupdate_rekey(struct sock *sk, int tx);
> +int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
>   int tls_set_sw_offload(struct sock *sk, int tx,
>   		       struct tls_crypto_info *new_crypto_info);
>   void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
> new file mode 100644
> index 000000000000..543bf57599c7
> --- /dev/null
> +++ b/net/tls/tls_keyupdate.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Dell Technologies Inc. or its subsidiaries.
> + *
> + * TLS 1.3 KeyUpdate, RFC 9846 sections 4.7.3 and 7.2.
> + *
> + * A TLS 1.3 peer can change the key of the direction it sends in at any
> + * time. It sends a KeyUpdate message, then encrypts all later records
> + * with the next key. A sender must also change its key before the key
> + * has protected too many records (section 5.5).
> + *
> + * The next key is derived from the application traffic secret, not from
> + * the current key. User space gives the kernel only the key and IV, so
> + * the kernel cannot derive the next key on its own. Without the secret,
> + * a received KeyUpdate goes to the application, and the kernel stops
> + * decrypting until the application installs the next key with TLS_RX.
> + *
> + * With TLS_TX_TRAFFIC_SECRET or TLS_RX_TRAFFIC_SECRET, user space also
> + * gives the kernel the secret of that direction. The kernel then handles
> + * KeyUpdate itself. This file derives and installs the next key, and
> + * processes a received KeyUpdate. tls_sw.c sends KeyUpdate messages.
> + */
> +
> +#include <linux/jiffies.h>
> +#include <linux/skbuff.h>
> +#include <net/strparser.h>
> +#include <net/tls.h>
> +
> +#include "tls.h"
> +
> +/* A peer that sends more KeyUpdates than this in one second ends the
> + * connection. Each one costs three HMACs and a new key, and carries no
> + * data.
> + */
> +#define TLS_KEYUPDATE_RX_MAX_PER_SEC	8
> +
> +/**
> + * tls_keyupdate_rekey - install the next key of one direction
> + * @sk: socket
> + * @tx: non-zero for the transmit direction
> + *
> + * Derive the next application traffic secret from the registered one,
> + * then its key and IV, and install them. The record sequence number
> + * restarts at zero.
> + *
> + * Return: 0 on success, or a negative errno. On error the installed key
> + * and the registered secret do not change.
> + */
> +int tls_keyupdate_rekey(struct sock *sk, int tx)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_traffic_secret *secret;
> +	const struct tls_cipher_desc *cipher_desc;
> +	u8 iv[TLS_MAX_SALT_SIZE + TLS_MAX_IV_SIZE];
> +	u8 next[TLS_MAX_TRAFFIC_SECRET_SIZE];
> +	union tls_crypto_context tmp = {};
> +	struct tls_crypto_info *info = &tmp.info;
> +	int rc;
> +
> +	secret = tx ? &ctx->tx_secret : &ctx->rx_secret;
> +	cipher_desc = get_cipher_desc(ctx->prot_info.cipher_type);
> +	if (!cipher_desc || !secret->len ||
> +	    cipher_desc->salt + cipher_desc->iv > sizeof(iv))
> +		return -EINVAL;
> +
> +	/* version and cipher_type; the rest of tmp stays zero */
> +	*info = tx ? ctx->crypto_send.info : ctx->crypto_recv.info;
> +
> +	rc = tls_hkdf_expand_label(secret->data, secret->len, "traffic upd",
> +				   next, secret->len);
> +	if (rc)
> +		goto out;
> +
> +	rc = tls_hkdf_expand_label(next, secret->len, "key",
> +				   crypto_info_key(info, cipher_desc),
> +				   cipher_desc->key);
> +	if (rc)
> +		goto out;
> +
> +	rc = tls_hkdf_expand_label(next, secret->len, "iv", iv,
> +				   cipher_desc->salt + cipher_desc->iv);
> +	if (rc)
> +		goto out;
> +
> +	memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
> +	memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
> +	       cipher_desc->iv);
> +
> +	rc = tls_set_sw_offload(sk, tx, info);
> +	if (rc)
> +		goto out;
> +
> +	memcpy(secret->data, next, secret->len);
> +
> +out:
> +	memzero_explicit(next, sizeof(next));
> +	memzero_explicit(iv, sizeof(iv));
> +	memzero_explicit(&tmp, sizeof(tmp));
> +
> +	return rc;
> +}
> +
Hmm. So this calculates 'iv' and 'key' from the traffic secret.
But as it does, why can't we use it to calculate the _initial_ 'iv' and 
'key' from the traffic secret?
IE wouldn't it make sense to allow for _just_ the (initial) traffic
secrets to be set, and calculate 'iv' and 'key' on the fly _always?
That would remove the possible admin error where the admin sets a
set of 'IV' and 'key' values which do _not_ match the traffic secrets.

Hmm?

> +/**
> + * tls_keyupdate_rx - process a received KeyUpdate
> + * @sk: socket
> + * @skb: the decrypted record, which starts with a KeyUpdate message
> + *
> + * Called with the socket locked, for a direction with a registered
> + * secret. The caller does not pass the record to the user.
> + *
> + * Return: 0 on success, or a negative errno if the connection must end.
> + */
> +int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *rx_ctx = tls_sw_ctx_rx(ctx);
> +	const struct strp_msg *rxm = strp_msg(skb);
> +	u8 msg[TLS_KEYUPDATE_MSG_SIZE];
> +	int rc;
> +
> +	/* A KeyUpdate must end its record (section 5.1). Another message
> +	 * in the same record is not supported.
> +	 */
> +	if (rxm->full_len != sizeof(msg) ||
> +	    skb_copy_bits(skb, rxm->offset, msg, sizeof(msg)))
> +		return -EBADMSG;
> +
> +	/* msg_type, a 24-bit length of 1, then request_update */
> +	if (msg[1] || msg[2] || msg[3] != 1)
> +		return -EBADMSG;
> +	if (msg[4] != TLS_KEY_UPDATE_NOT_REQUESTED &&
> +	    msg[4] != TLS_KEY_UPDATE_REQUESTED)
> +		return -EBADMSG;
> +
> +	if (!rx_ctx->key_update_count ||
> +	    time_after(jiffies, rx_ctx->key_update_window + HZ)) {
> +		rx_ctx->key_update_window = jiffies;
> +		rx_ctx->key_update_count = 0;
> +	}
> +	if (++rx_ctx->key_update_count > TLS_KEYUPDATE_RX_MAX_PER_SEC)
> +		return -EBADMSG;
> +
> +	rc = tls_keyupdate_rekey(sk, 0);
> +	if (rc) {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYERROR);
> +		return rc;
> +	}
> +	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> +
> +	return 0;
> +}
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f29..a314fa638dc3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1551,15 +1551,26 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
>   	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
>   		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
>   
> -		WRITE_ONCE(rx_ctx->key_update_pending, true);
>   		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
> +
> +		if (ctx->rx_secret.len) {
> +			err = tls_keyupdate_rx(sk, skb);
> +			if (err) {
> +				tls_err_abort(sk, err);
> +				return err;
> +			}
> +			return 1;
> +		}
> +
> +		WRITE_ONCE(rx_ctx->key_update_pending, true);
>   	}
>   
>   	return 0;
>   }
>   
>   /* On decrypt failure the connection is aborted (sk_err set) before
> - * returning a negative errno.
> + * returning a negative errno. Return 1 for a record the kernel consumed
> + * (a KeyUpdate): the caller frees it and does not pass it to the user.
>    */
>   static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>   			     struct tls_decrypt_arg *darg)
> @@ -1883,6 +1894,11 @@ int tls_sw_recvmsg(struct sock *sk,
>   		err = tls_rx_one_record(sk, msg, &darg);
>   		if (err < 0)
>   			goto recv_end;
> +		if (err > 0) {
> +			tls_rx_rec_done(ctx);
> +			consume_skb(darg.skb);
> +			continue;
> +		}
>   
>   		async |= darg.async;
>   
> @@ -2019,9 +2035,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>   	if (err)
>   		goto splice_read_end;
>   
> -	if (!skb_queue_empty(&ctx->rx_list)) {
> -		skb = __skb_dequeue(&ctx->rx_list);
> -	} else {
> +	skb = __skb_dequeue(&ctx->rx_list);
> +	while (!skb) {
>   		struct tls_decrypt_arg darg;
>   
>   		err = tls_rx_rec_wait(sk, flags & SPLICE_F_NONBLOCK,
> @@ -2036,7 +2051,10 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>   			goto splice_read_end;
>   
>   		tls_rx_rec_done(ctx);
> -		skb = darg.skb;
> +		if (err > 0)
> +			consume_skb(darg.skb);
> +		else
> +			skb = darg.skb;
>   	}
>   
>   	rxm = strp_msg(skb);
> @@ -2118,6 +2136,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>   			err = tls_rx_one_record(sk, NULL, &darg);
>   			if (err < 0)
>   				goto read_sock_end;
> +			if (err > 0) {
> +				tls_rx_rec_done(ctx);
> +				consume_skb(darg.skb);
> +				continue;
> +			}
>   
>   			released = tls_read_flush_backlog(sk, prot, INT_MAX,
>   							  0, decrypted,
> 

The rest looks okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

