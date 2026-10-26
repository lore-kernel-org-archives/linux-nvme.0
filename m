Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB919606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YVVSuWL1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=btfd5w1d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ifcJOVQksIbT4LRSAR+fBN2obWCcURFUjY4fZfdk+Kk=; b=YVVSuWL1R7Y3ej
	eY4Svdon07XnGqFCSSXeZpx24QNPndq1pTbaKDkQ9XODmxoPuqWeqgeDsVwLq4By8iB4uuUAU3HsC
	gnzLqp638BfPaC79/fQXvcJgBpJs+jwM51JA4V4IHpmOnBZGnoGevDeraawwQTUHDafzQNWZwnNb5
	GUwiW/1W6u6K0e9+XSDwA/T/ApKTCUF1hE54rTcD2da6YAzh7YVmr0wYtT5Rxv3JE1HEF2EQGY025
	4OKmaMFu1J1Qc35FaimFHYHvVTFKrzhoNzJMwaF+GuA2wOnSL8McAntvZtmVUn8NsZJAVgxS9q14s
	8/DsSpbPDwaZf/1zUmOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIsX-00000002NTT-2RRm;
	Mon, 26 Oct 2026 11:28:37 +0000
Received: from mail-yx2-x0a.google.com ([2607:f8b0:4864:41::a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIsV-00000002NRs-2GYm
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 11:28:36 +0000
Received: by mail-yx2-x0a.google.com with SMTP id 956f58d0204a3-677bd24a602so1661879d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793014114; x=1793618914; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifcJOVQksIbT4LRSAR+fBN2obWCcURFUjY4fZfdk+Kk=;
        b=btfd5w1dCWlRk3h5nVeeaKaJco9Esb3Lq3DsYOmApY4n60MJ1QwlGtALmYqqYk6Hjx
         /grd5WS0vsktT0efm8ChpIKGNCvgzrxHf9m4dkDM/vqVMZUhTo8c1czBik+/REHDQ/68
         VSUZXfVXjjz6QAAWtNXfM65wG3++Hsf8e5Vr+U+A0t72ZfCKN9JcXiZIaA4+tVPHULID
         4nkYxuVJvNb7XgJqfKhyeW7Jx3mgnyStX44ijDNX9bMKhpBguXR5K2o7kQTo9xRNeSxj
         XBVmmLSMHH+j0Ymh7tCnlcTxkhHtLfHjJly5cbORYOiaE/zlKuISB1FL5gHkGW79DTPs
         jbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014114; x=1793618914;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifcJOVQksIbT4LRSAR+fBN2obWCcURFUjY4fZfdk+Kk=;
        b=bGUieK4Xs3LYEp/z9ycLpP4QgJnxj/18zxq4vu1bsBsLO6iThVXGDVV65u2vN25gr/
         zoU/yqRKwBtRYpLN+aGTN7KyJ4ckDD1nPjzuSQdvhMlThRmLStPmYcW64ZkgadPuBANx
         77SprikM93R2FmZjeHWgQ68ZQrNM1NnGaJlekiZfmTNOHZdWSbdqOXQ4PMyrAQ9gzdw4
         lxNGMbzkzawif+kYUhcFs3dWCPB7IZK1KNOqrwBo2u2pxfjhv5PxoVWnEbxjNvfVkENk
         XC4HrdEAQrndI6MimCV3ikuH81nmERWEAa2QA6Tvdd9WGaQraZgyHxJgxD+R4L/mU5a0
         0KJA==
X-Forwarded-Encrypted: i=1; AKwUvByoooyLIS4AZm+axqLIe0yToWiolJPTCMa14TDOag98gliggd6McF/Agdkp2LHZPl9FZFmM5sA4M8Xe@lists.infradead.org
X-Gm-Message-State: AFq9FYLmXh2MBtDRRdL6e1o8Z+5DdXeCEMgkBv4hdQwKPlbZ2PZa/H5W
	pcrtNoca9YcVRfskuRIGiN4MoylhUbvhfDaTnage0hZrG0fqzZ3Gzrak
X-Gm-Gg: AYBFou1F1wqsU0bp16Ge1E/K8+36bO15j9UC7BZIH4+H2AY0fDASyyn+QQGcqNSuS5A
	iWUuU8JyR8DADwiLsfYqgmMRNTarWL4kRf5E7V/GJpA/GMpQzAiPGOwQys+cROI6M/CvPHBcfW2
	M+ZyuZsDelBJjULbyDPUKmiMpkGj0cj2bZgd4ABrMTWrDq6451dOR3TSjFeA3gJCePRaCbR2ILQ
	pHUs3KZZn0iTGefmKycNpQo8vF3T6g3d0Muv9hJ39YMKI97/4Jq94xjitmW/zh2aIc2Kb2N78Ko
	AsTtdGxdSpRA3emBDe/E5iT50gEQe4y6+viMZNw5PpmMAzmgPywyh8LkaRatAo5NT6ey9tnilpU
	6RbVh3ZBeZF4UvIObjqnGcgy9oJ3AjiHaplguXVf6C8XRMtWDJv8HPmiVthOc1oAKy4I3ysHTKC
	GNiaWrfdw8EZNgZFn07QfCgtW/8wzAFqXHi2d5tUTbg8sbC+D0kGBiYERH60OdhBj7iGTOvKSLJ
	sBK8cnVE8ctHBm2GR+8BnBq6Ggbrm485M1kCT29AgzFqakiM7cDBttu0V8lFw==
X-Received: by 2002:a05:690e:169c:b0:679:a58:148c with SMTP id 956f58d0204a3-67a4519368cmr5729731d50.7.1793014114235;
        Mon, 26 Oct 2026 04:28:34 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a45ff8d6dsm3266096d50.1.2026.10.26.04.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:28:33 -0700 (PDT)
Message-ID: <69ac84e1-14c6-44bd-8eb4-a228918f9b61@gmail.com>
Date: Mon, 26 Oct 2026 07:28:32 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 3/5] tls: update the RX key when a KeyUpdate
 is received
To: Hannes Reinecke <hare@suse.de>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
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
 <8af172e4-0039-4dbb-970e-ab91b3d6e149@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <8af172e4-0039-4dbb-970e-ab91b3d6e149@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_042835_663386_F599C75D 
X-CRM114-Status: GOOD (  36.93  )
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/26 03:53, Hannes Reinecke wrote:
> On 10/26/26 1:36 AM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> When a KeyUpdate arrives, kTLS blocks reads with -EKEYEXPIRED until
>> the user installs the next key. A kernel user such as nvme-tcp or
>> sunrpc never does, so the connection stalls.
>>
>> For a socket with a registered RX secret, derive the next key and
>> install it when the KeyUpdate is decrypted. The record is not passed to
>> the user, so recvmsg(), splice() and read_sock() go on to the next
>> record. Without a registered secret the behavior is unchanged.
>>
>> A KeyUpdate that is not alone in its record, has a wrong length or an
>> invalid request_update value ends the connection, as RFC 9846 section
>> 4.7.3 requires. So does a peer that sends more than 8 KeyUpdates in one
>> second, the same limit as GnuTLS.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   include/net/tls.h       |   7 +++
>>   net/tls/Makefile        |   3 +-
>>   net/tls/tls.h           |   2 +
>>   net/tls/tls_keyupdate.c | 150 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/tls/tls_sw.c        |  35 +++++++++--
>>   5 files changed, 190 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/tls.h b/include/net/tls.h
>> index aacc6d12226e..a5bc28a7d1f5 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -63,6 +63,11 @@ struct tls_rec;
>>     #define TLS_HANDSHAKE_KEYUPDATE        24    /* rfc8446 B.3: Key 
>> update */
>>   +/* KeyUpdate: msg_type, 24-bit length, request_update (RFC 9846 
>> 4.7.3) */
>> +#define TLS_KEYUPDATE_MSG_SIZE        5
>> +#define TLS_KEY_UPDATE_NOT_REQUESTED    0
>> +#define TLS_KEY_UPDATE_REQUESTED    1
>> +
>>   #define TLS_AAD_SPACE_SIZE        13
>>     /* SHA-384, the longest hash of a TLS 1.3 cipher suite kTLS 
>> supports */
>> @@ -142,6 +147,8 @@ struct tls_sw_context_rx {
>>       u8 zc_capable:1;
>>       u8 reader_contended:1;
>>       bool key_update_pending;
>> +    u8 key_update_count;        /* received in this window */
>> +    unsigned long key_update_window;    /* jiffies */
>>         struct tls_strparser strp;
>>   diff --git a/net/tls/Makefile b/net/tls/Makefile
>> index 6edcf1271b75..ce8ac6a59f8c 100644
>> --- a/net/tls/Makefile
>> +++ b/net/tls/Makefile
>> @@ -7,6 +7,7 @@ CFLAGS_trace.o := -I$(src)
>>     obj-$(CONFIG_TLS) += tls.o
>>   -tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o
>> +tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o \
>> +     tls_keyupdate.o
>>     tls-$(CONFIG_TLS_DEVICE) += tls_device.o tls_device_fallback.o
>> diff --git a/net/tls/tls.h b/net/tls/tls.h
>> index b2061f6bf065..63ece8074985 100644
>> --- a/net/tls/tls.h
>> +++ b/net/tls/tls.h
>> @@ -149,6 +149,8 @@ int init_prot_info(struct tls_prot_info *prot,
>>              const struct tls_cipher_desc *cipher_desc);
>>   int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
>>                 const char *label, u8 *out, size_t out_len);
>> +int tls_keyupdate_rekey(struct sock *sk, int tx);
>> +int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
>>   int tls_set_sw_offload(struct sock *sk, int tx,
>>                  struct tls_crypto_info *new_crypto_info);
>>   void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
>> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
>> new file mode 100644
>> index 000000000000..543bf57599c7
>> --- /dev/null
>> +++ b/net/tls/tls_keyupdate.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2026 Dell Technologies Inc. or its subsidiaries.
>> + *
>> + * TLS 1.3 KeyUpdate, RFC 9846 sections 4.7.3 and 7.2.
>> + *
>> + * A TLS 1.3 peer can change the key of the direction it sends in at 
>> any
>> + * time. It sends a KeyUpdate message, then encrypts all later records
>> + * with the next key. A sender must also change its key before the key
>> + * has protected too many records (section 5.5).
>> + *
>> + * The next key is derived from the application traffic secret, not 
>> from
>> + * the current key. User space gives the kernel only the key and IV, so
>> + * the kernel cannot derive the next key on its own. Without the 
>> secret,
>> + * a received KeyUpdate goes to the application, and the kernel stops
>> + * decrypting until the application installs the next key with TLS_RX.
>> + *
>> + * With TLS_TX_TRAFFIC_SECRET or TLS_RX_TRAFFIC_SECRET, user space also
>> + * gives the kernel the secret of that direction. The kernel then 
>> handles
>> + * KeyUpdate itself. This file derives and installs the next key, and
>> + * processes a received KeyUpdate. tls_sw.c sends KeyUpdate messages.
>> + */
>> +
>> +#include <linux/jiffies.h>
>> +#include <linux/skbuff.h>
>> +#include <net/strparser.h>
>> +#include <net/tls.h>
>> +
>> +#include "tls.h"
>> +
>> +/* A peer that sends more KeyUpdates than this in one second ends the
>> + * connection. Each one costs three HMACs and a new key, and carries no
>> + * data.
>> + */
>> +#define TLS_KEYUPDATE_RX_MAX_PER_SEC    8
>> +
>> +/**
>> + * tls_keyupdate_rekey - install the next key of one direction
>> + * @sk: socket
>> + * @tx: non-zero for the transmit direction
>> + *
>> + * Derive the next application traffic secret from the registered one,
>> + * then its key and IV, and install them. The record sequence number
>> + * restarts at zero.
>> + *
>> + * Return: 0 on success, or a negative errno. On error the installed 
>> key
>> + * and the registered secret do not change.
>> + */
>> +int tls_keyupdate_rekey(struct sock *sk, int tx)
>> +{
>> +    struct tls_context *ctx = tls_get_ctx(sk);
>> +    struct tls_traffic_secret *secret;
>> +    const struct tls_cipher_desc *cipher_desc;
>> +    u8 iv[TLS_MAX_SALT_SIZE + TLS_MAX_IV_SIZE];
>> +    u8 next[TLS_MAX_TRAFFIC_SECRET_SIZE];
>> +    union tls_crypto_context tmp = {};
>> +    struct tls_crypto_info *info = &tmp.info;
>> +    int rc;
>> +
>> +    secret = tx ? &ctx->tx_secret : &ctx->rx_secret;
>> +    cipher_desc = get_cipher_desc(ctx->prot_info.cipher_type);
>> +    if (!cipher_desc || !secret->len ||
>> +        cipher_desc->salt + cipher_desc->iv > sizeof(iv))
>> +        return -EINVAL;
>> +
>> +    /* version and cipher_type; the rest of tmp stays zero */
>> +    *info = tx ? ctx->crypto_send.info : ctx->crypto_recv.info;
>> +
>> +    rc = tls_hkdf_expand_label(secret->data, secret->len, "traffic 
>> upd",
>> +                   next, secret->len);
>> +    if (rc)
>> +        goto out;
>> +
>> +    rc = tls_hkdf_expand_label(next, secret->len, "key",
>> +                   crypto_info_key(info, cipher_desc),
>> +                   cipher_desc->key);
>> +    if (rc)
>> +        goto out;
>> +
>> +    rc = tls_hkdf_expand_label(next, secret->len, "iv", iv,
>> +                   cipher_desc->salt + cipher_desc->iv);
>> +    if (rc)
>> +        goto out;
>> +
>> +    memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
>> +    memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
>> +           cipher_desc->iv);
>> +
>> +    rc = tls_set_sw_offload(sk, tx, info);
>> +    if (rc)
>> +        goto out;
>> +
>> +    memcpy(secret->data, next, secret->len);
>> +
>> +out:
>> +    memzero_explicit(next, sizeof(next));
>> +    memzero_explicit(iv, sizeof(iv));
>> +    memzero_explicit(&tmp, sizeof(tmp));
>> +
>> +    return rc;
>> +}
>> +
> Hmm. So this calculates 'iv' and 'key' from the traffic secret.
> But as it does, why can't we use it to calculate the _initial_ 'iv' 
> and 'key' from the traffic secret?
> IE wouldn't it make sense to allow for _just_ the (initial) traffic
> secrets to be set, and calculate 'iv' and 'key' on the fly _always?
> That would remove the possible admin error where the admin sets a
> set of 'IV' and 'key' values which do _not_ match the traffic secrets.
>
> Hmm?
It can. I kept TLS_TX and TLS_RX as they are for two reasons:

- Every kTLS user (OpenSSL, GnuTLS, tlshd) already derives the key and
   IV and installs them with TLS_TX and TLS_RX. The secret is an
   optional addition for KeyUpdate. Code that does not use KeyUpdate
   does not change.
- The crypto_info of TLS_TX and TLS_RX also holds the version, the
   cipher and the record sequence number. An option that takes only the
   secret needs a new struct for these.

With the check from patch 2, the kernel refuses a secret that does not
match the installed key and IV. So the error you describe cannot
happen.

Martin
>
>> +/**
>> + * tls_keyupdate_rx - process a received KeyUpdate
>> + * @sk: socket
>> + * @skb: the decrypted record, which starts with a KeyUpdate message
>> + *
>> + * Called with the socket locked, for a direction with a registered
>> + * secret. The caller does not pass the record to the user.
>> + *
>> + * Return: 0 on success, or a negative errno if the connection must 
>> end.
>> + */
>> +int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb)
>> +{
>> +    struct tls_context *ctx = tls_get_ctx(sk);
>> +    struct tls_sw_context_rx *rx_ctx = tls_sw_ctx_rx(ctx);
>> +    const struct strp_msg *rxm = strp_msg(skb);
>> +    u8 msg[TLS_KEYUPDATE_MSG_SIZE];
>> +    int rc;
>> +
>> +    /* A KeyUpdate must end its record (section 5.1). Another message
>> +     * in the same record is not supported.
>> +     */
>> +    if (rxm->full_len != sizeof(msg) ||
>> +        skb_copy_bits(skb, rxm->offset, msg, sizeof(msg)))
>> +        return -EBADMSG;
>> +
>> +    /* msg_type, a 24-bit length of 1, then request_update */
>> +    if (msg[1] || msg[2] || msg[3] != 1)
>> +        return -EBADMSG;
>> +    if (msg[4] != TLS_KEY_UPDATE_NOT_REQUESTED &&
>> +        msg[4] != TLS_KEY_UPDATE_REQUESTED)
>> +        return -EBADMSG;
>> +
>> +    if (!rx_ctx->key_update_count ||
>> +        time_after(jiffies, rx_ctx->key_update_window + HZ)) {
>> +        rx_ctx->key_update_window = jiffies;
>> +        rx_ctx->key_update_count = 0;
>> +    }
>> +    if (++rx_ctx->key_update_count > TLS_KEYUPDATE_RX_MAX_PER_SEC)
>> +        return -EBADMSG;
>> +
>> +    rc = tls_keyupdate_rekey(sk, 0);
>> +    if (rc) {
>> +        TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYERROR);
>> +        return rc;
>> +    }
>> +    TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>> +
>> +    return 0;
>> +}
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 312e51270f29..a314fa638dc3 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1551,15 +1551,26 @@ static int tls_check_pending_rekey(struct 
>> sock *sk, struct tls_context *ctx,
>>       if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
>>           struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
>>   -        WRITE_ONCE(rx_ctx->key_update_pending, true);
>>           TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
>> +
>> +        if (ctx->rx_secret.len) {
>> +            err = tls_keyupdate_rx(sk, skb);
>> +            if (err) {
>> +                tls_err_abort(sk, err);
>> +                return err;
>> +            }
>> +            return 1;
>> +        }
>> +
>> +        WRITE_ONCE(rx_ctx->key_update_pending, true);
>>       }
>>         return 0;
>>   }
>>     /* On decrypt failure the connection is aborted (sk_err set) before
>> - * returning a negative errno.
>> + * returning a negative errno. Return 1 for a record the kernel 
>> consumed
>> + * (a KeyUpdate): the caller frees it and does not pass it to the user.
>>    */
>>   static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>>                    struct tls_decrypt_arg *darg)
>> @@ -1883,6 +1894,11 @@ int tls_sw_recvmsg(struct sock *sk,
>>           err = tls_rx_one_record(sk, msg, &darg);
>>           if (err < 0)
>>               goto recv_end;
>> +        if (err > 0) {
>> +            tls_rx_rec_done(ctx);
>> +            consume_skb(darg.skb);
>> +            continue;
>> +        }
>>             async |= darg.async;
>>   @@ -2019,9 +2035,8 @@ ssize_t tls_sw_splice_read(struct socket 
>> *sock,  loff_t *ppos,
>>       if (err)
>>           goto splice_read_end;
>>   -    if (!skb_queue_empty(&ctx->rx_list)) {
>> -        skb = __skb_dequeue(&ctx->rx_list);
>> -    } else {
>> +    skb = __skb_dequeue(&ctx->rx_list);
>> +    while (!skb) {
>>           struct tls_decrypt_arg darg;
>>             err = tls_rx_rec_wait(sk, flags & SPLICE_F_NONBLOCK,
>> @@ -2036,7 +2051,10 @@ ssize_t tls_sw_splice_read(struct socket 
>> *sock,  loff_t *ppos,
>>               goto splice_read_end;
>>             tls_rx_rec_done(ctx);
>> -        skb = darg.skb;
>> +        if (err > 0)
>> +            consume_skb(darg.skb);
>> +        else
>> +            skb = darg.skb;
>>       }
>>         rxm = strp_msg(skb);
>> @@ -2118,6 +2136,11 @@ int tls_sw_read_sock(struct sock *sk, 
>> read_descriptor_t *desc,
>>               err = tls_rx_one_record(sk, NULL, &darg);
>>               if (err < 0)
>>                   goto read_sock_end;
>> +            if (err > 0) {
>> +                tls_rx_rec_done(ctx);
>> +                consume_skb(darg.skb);
>> +                continue;
>> +            }
>>                 released = tls_read_flush_backlog(sk, prot, INT_MAX,
>>                                 0, decrypted,
>>
>
> The rest looks okay.
>
> Cheers,
>
> Hannes

