Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFF606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=suZaf334;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tK4EJPkv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+KAqS8M+/qoJA2pnACOUntqjOG8j1ld8MRFk1qGoTjs=; b=suZaf334eruZQz
	l99vXMbk+nk45QDleCfBK3+bNGJ+f4HotrXSK+TxwX9y2E3qu564Kk7JeCz/7V08m9yZpCFtGHFKP
	Jj/O4Xc6S4jg05EDCNsBpriqQNBc1+1K5UgNGSd2Ck64PWA16wtherlN6KqfRDMhInniL0fh5SKcZ
	F0sUJPl7gcTcOntLCOx6OBsRrLPjXE/05J0IW0nW/3foVaXTCFEb4+jBFhYCeReAhJdys+uPz8sd5
	oHHINVr1Xbt1OMNmHJHOxjJusW2SSAUAY9Urq3guVxaERbWPBb+A0ya6jDG6Q6pHEVSxJmy2xrHyC
	NBONeJhjuoalfMzK2TvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIrq-00000002NHO-3VQG;
	Mon, 26 Oct 2026 11:27:54 +0000
Received: from mail-yx2-x0a.google.com ([2607:f8b0:4864:41::a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIro-00000002NH3-191z
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 11:27:53 +0000
Received: by mail-yx2-x0a.google.com with SMTP id 956f58d0204a3-6798efe507bso1307453d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793014071; x=1793618871; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KAqS8M+/qoJA2pnACOUntqjOG8j1ld8MRFk1qGoTjs=;
        b=tK4EJPkv37AY0EXBSYSpJiwn0VokgostIqYBKxqDke3JZsGZ0BMaqXbRETammnFTDY
         hY0ZF4PnOHV6jx6Uh8G8Xh112mup0LxxkFCdWnGBS+t995Q7z8y3s5dM7kNJ5ugunKfH
         E8bPtPE7GKbmjnOfunaG8EsJEF59dYSyL6weIoREUgNPZ6yA90LAqNkCwDD+3iotmJpQ
         mKnlEzq0DEEaEyfnjbG2WYpmBGwGdcCw1E10qXRKmALKwDCxfz/fcz5C80KaP26ZEyow
         ClvsmSM/yN6RJf5PBWkBHSw9qzNFXsc0Xsa+yU3Ssjk6u4RbsfP9FNiJbxb8aFQu40Bb
         2Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014071; x=1793618871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KAqS8M+/qoJA2pnACOUntqjOG8j1ld8MRFk1qGoTjs=;
        b=IvtYz0y/fFFxLyTD7vGm61OA8qurb3ybcodf+y7uNq+VcbpYIseBKay8mVW2HsCFPp
         JFUR9rkTYXfnXrjjzIfmqjjxLh4RBf2qgvZH1HT96Od6Z6UNPf7990f8wvni1aP4lRuO
         y3mjMHR/kz8qypBvsrdbrWqTwsi4k8/Zg4IfeGoeaBmSGJKa2xpmgiJ7q+9n++xD4aHK
         R9WH+GbEHiP/s9FQ464Ki6F4RCdwdm2efuQ4l6qOw9twN/mbxT158KUtpQ1fyrOYFYCM
         bTQ/Q4CI1D8NS+EZdSCrUqK7vvrAQXSf8jzShbsXVl7bG0yVl5clOhvDdbduyKDGzq9L
         /FxA==
X-Forwarded-Encrypted: i=1; AKwUvBz8uFatliTS6PcBeNKAcGD1WvSGCSOc1xobh++qa9wLCfElacrluJ8Sjc0Q9liiTeHBRaylq434BkGn@lists.infradead.org
X-Gm-Message-State: AFq9FYJYmUAk4rt/KV/L90XLvHuebfqosQKG73MVhF2k7U4C8Vhp/Vv/
	nrI6UDnPkIj3pBJ9j4bBhKgnhLhRO9jGJiT9FF7xdBS7WUDzZFXvz5Os
X-Gm-Gg: AYBFou3Vo88sDMm+Aor+ykH4xWf88YngPLuAI+CExXT6JYy4/i7c0EuNX4UzGpXJOVq
	INm8szcz9iYr5ilN7hbcsrrhv7TO1LK2MJU8DY2jZalTf3eNoQ1jochvV0adxpCbMs4mmntl3BX
	GZfVoaNCGJwP6HIim8TBNRQQbCuXsWmANH3iaTNI6X8SvA8eHhEimzN4t6m/KhiX5z6a3Dov1mW
	yJu5h8A+nQnXtGXpfsdsAgJozJtJtxJCB6H6eShe4z8mdcmJxkH4MLJwFBOXmL4zg3mQsBMTTk1
	nshRC9ahBM+l9Kihf5yFe0MkW6aPrHLAqNwFC+gEFI5dsDnIG5O3T8cbg/BVVGZ1bd7yCixtb3X
	FNBNlrhNWtuFb55T1V/ILNDEM5m91HRrSpU+76V37W109IFV5k4pq/Yn4uE7VsJjTre+bVaPDfj
	4B/OuLXqIq+PDXrka2/4judIw+RhLhsb2o8VWfnjJTQqyIrDpnq0A5j0K/17jOOYDAun2CjkOtq
	18lpw74gzE7sZEXnV39HY5Gtkm9Ow+9Wk39FK8Y/zpfqK+zMoAvlySObYK39tY=
X-Received: by 2002:a05:690e:144a:b0:67a:5e25:607b with SMTP id 956f58d0204a3-67a5e2565dbmr2989868d50.54.1793014070886;
        Mon, 26 Oct 2026 04:27:50 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a46235de1sm3114048d50.13.2026.10.26.04.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:27:50 -0700 (PDT)
Message-ID: <6ad9cd0e-e5a4-4b8b-8b5f-c93f6b249647@gmail.com>
Date: Mon, 26 Oct 2026 07:27:48 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 2/5] tls: add socket options to register the
 traffic secrets
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
 <20261025-keyupdate-rfc-v1-2-60b7756eccbd@gmail.com>
 <131fc354-ff38-4aca-ac3d-8e3a6f3716f4@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <131fc354-ff38-4aca-ac3d-8e3a6f3716f4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_042752_364232_7DB46DE0 
X-CRM114-Status: GOOD (  39.70  )
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


On 10/26/26 03:37, Hannes Reinecke wrote:
> On 10/26/26 1:36 AM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> kTLS holds the key and IV of each direction, but not the traffic secret
>> they were derived from. The derivation is one-way, so the kernel cannot
>> compute the next generation for a KeyUpdate on its own.
>>
>> Add TLS_TX_TRAFFIC_SECRET and TLS_RX_TRAFFIC_SECRET. The owner of the
>> socket passes the TLS 1.3 application traffic secret of a direction 
>> after
>> installing its key. The cipher of the installed key selects the hash, so
>> the option takes only the secret. A socket without a registered secret
>> behaves as before.
>>
>> The TX secret can be registered alone. The RX secret needs the TX secret
>> first: a received KeyUpdate can ask for one in reply, and since the
>> kernel consumes the record, only the kernel can send that reply.
>>
>> Installing a new key with TLS_TX or TLS_RX removes the secrets that no
>> longer apply. The secrets are cleared when the context is freed and
>> cannot be read back.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   Documentation/networking/tls.rst | 26 ++++++++++++
>>   include/net/tls.h                | 13 ++++++
>>   include/uapi/linux/tls.h         |  2 +
>>   net/tls/tls_main.c               | 86 
>> +++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 126 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/networking/tls.rst 
>> b/Documentation/networking/tls.rst
>> index 980c442d7161..2e011bd1ce4a 100644
>> --- a/Documentation/networking/tls.rst
>> +++ b/Documentation/networking/tls.rst
>> @@ -300,6 +300,32 @@ extra byte used by the ContentType field.
>>     [1] https://datatracker.ietf.org/doc/html/rfc8449
>>   +TLS_TX_TRAFFIC_SECRET and TLS_RX_TRAFFIC_SECRET
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +``TLS_TX_TRAFFIC_SECRET`` registers the TLS 1.3 application traffic 
>> secret
>> +of the transmit direction, ``TLS_RX_TRAFFIC_SECRET`` that of the 
>> receive
>> +direction. With a registered secret, the kernel performs KeyUpdate 
>> for that
>> +direction itself (RFC 9846, section 4.7.3). The value is the secret 
>> itself.
>> +TLS 1.3 only, software path only.
>> +
>> +Install the key of the direction first, with the ``TLS_TX`` or 
>> ``TLS_RX``
>> +socket option described above. The cipher of that key selects the 
>> hash, and
>> +the secret must have the length of that hash: 32 bytes for SHA-256
>> +(AES-128-GCM, AES-128-CCM, ChaCha20-Poly1305) or 48 bytes for SHA-384
>> +(AES-256-GCM). Other ciphers return ``EOPNOTSUPP``.
>> +
>> +Each secret can be registered once. ``TLS_RX_TRAFFIC_SECRET`` needs
>> +``TLS_TX_TRAFFIC_SECRET`` first: a received KeyUpdate can ask for 
>> one in
>> +reply, and only the kernel sees it. ``TLS_TX_TRAFFIC_SECRET`` alone is
>> +allowed.
>> +
>> +If the application installs a new key itself with ``TLS_TX``, both 
>> secrets
>> +are removed. With ``TLS_RX``, the RX secret is removed. KeyUpdate 
>> for that
>> +direction is then left to the application again.
>> +
>> +The secrets cannot be read back.
>> +
>>   Statistics
>>   ==========
>>   diff --git a/include/net/tls.h b/include/net/tls.h
>> index e57bef58851e..aacc6d12226e 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -65,6 +65,9 @@ struct tls_rec;
>>     #define TLS_AAD_SPACE_SIZE        13
>>   +/* SHA-384, the longest hash of a TLS 1.3 cipher suite kTLS 
>> supports */
>> +#define TLS_MAX_TRAFFIC_SECRET_SIZE    48
>> +
>>   #define TLS_MAX_IV_SIZE            16
>>   #define TLS_MAX_SALT_SIZE        4
>>   #define TLS_TAG_SIZE            16
>> @@ -224,6 +227,12 @@ struct tls_prot_info {
>>       u16 tail_size;
>>   };
>>   +/* A TLS 1.3 application traffic secret. len is 0 if none is 
>> registered. */
>> +struct tls_traffic_secret {
>> +    u8 data[TLS_MAX_TRAFFIC_SECRET_SIZE];
>> +    u8 len;
>> +};
>> +
>>   struct tls_context {
>>       /* read-only cache line */
>>       struct tls_prot_info prot_info;
>> @@ -266,6 +275,10 @@ struct tls_context {
>>       union tls_crypto_context crypto_send;
>>       union tls_crypto_context crypto_recv;
>>   +    /* Registered for KeyUpdate, protected by the socket lock */
>> +    struct tls_traffic_secret tx_secret;
>> +    struct tls_traffic_secret rx_secret;
>> +
>>       struct list_head list;
>>       refcount_t refcount;
>>       struct rcu_head rcu;
>> diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
>> index 1245ab38afc1..d1b136ecea96 100644
>> --- a/include/uapi/linux/tls.h
>> +++ b/include/uapi/linux/tls.h
>> @@ -42,6 +42,8 @@
>>   #define TLS_TX_ZEROCOPY_RO    3    /* TX zerocopy (only sendfile 
>> now) */
>>   #define TLS_RX_EXPECT_NO_PAD    4    /* Attempt opportunistic 
>> zero-copy */
>>   #define TLS_TX_MAX_PAYLOAD_LEN    5    /* Maximum plaintext size */
>> +#define TLS_TX_TRAFFIC_SECRET    6    /* TLS 1.3 TX traffic secret */
>> +#define TLS_RX_TRAFFIC_SECRET    7    /* TLS 1.3 RX traffic secret */
>>     /* Supported versions */
>>   #define TLS_VERSION_MINOR(ver)    ((ver) & 0xFF)
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index 8bdb78718a8d..1c6e993ec012 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -31,6 +31,7 @@
>>    * SOFTWARE.
>>    */
>>   +#include <crypto/sha2.h>
>>   #include <linux/module.h>
>>     #include <net/tcp.h>
>> @@ -325,6 +326,8 @@ void tls_ctx_free(struct sock *sk, struct 
>> tls_context *ctx)
>>         memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
>>       memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
>> +    memzero_explicit(&ctx->tx_secret, sizeof(ctx->tx_secret));
>> +    memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>>       mutex_destroy(&ctx->tx_lock);
>>         if (sk)
>> @@ -757,8 +760,16 @@ static int do_tls_setsockopt_conf(struct sock 
>> *sk, sockptr_t optval,
>>           ctx->rx_conf = conf;
>>       update_sk_prot(sk, ctx);
>>   -    if (update)
>> +    if (update) {
>> +        /* The registered secret no longer matches the key. The RX
>> +         * secret also needs the TX one, see 
>> do_tls_setsockopt_secret().
>> +         */
>
> What is a bit unfortunate that we don't have a direct link between the 
> key and the traffic secret. So a user might set a key which is _not_
> derived from the traffic secret, rendering the KeyUpdate non-workable.
>
> Can we add a check here?
> It should be possible to calculate the key from the traffic secret, no?
>
Yes. The key is HKDF-Expand-Label(secret, "key") and the IV is
HKDF-Expand-Label(secret, "iv"). When the secret is registered, the
kernel can derive both and compare them with the installed key and IV.
A secret that does not match fails with EINVAL. I will add this in v2.
>> +        if (tx)
>> +            memzero_explicit(&ctx->tx_secret,
>> +                     sizeof(ctx->tx_secret));
>> +        memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>>           return 0;
>> +    }
>>         if (tx) {
>>           ctx->sk_write_space = sk->sk_write_space;
>> @@ -857,6 +868,72 @@ static int 
>> do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>>       return 0;
>>   }
>>   +/* Length of the TLS 1.3 traffic secret for @cipher_type, the size of
>> + * its hash. 0 if KeyUpdate is not supported for the cipher.
>> + */
>> +static int tls_traffic_secret_len(u16 cipher_type)
>> +{
>> +    switch (cipher_type) {
>> +    case TLS_CIPHER_AES_GCM_128:
>> +    case TLS_CIPHER_AES_CCM_128:
>> +    case TLS_CIPHER_CHACHA20_POLY1305:
>> +        return SHA256_DIGEST_SIZE;
>> +    case TLS_CIPHER_AES_GCM_256:
>> +        return SHA384_DIGEST_SIZE;
>> +    default:
>> +        return 0;
>> +    }
>> +}
>> +
>> +static int do_tls_setsockopt_secret(struct sock *sk, sockptr_t optval,
>> +                    unsigned int optlen, int tx)
>> +{
>> +    struct tls_context *ctx = tls_get_ctx(sk);
>> +    struct tls_crypto_info *crypto_info;
>> +    struct tls_traffic_secret *secret;
>> +    int len;
>> +
>> +    if (tx) {
>> +        crypto_info = &ctx->crypto_send.info;
>> +        secret = &ctx->tx_secret;
>> +    } else {
>> +        crypto_info = &ctx->crypto_recv.info;
>> +        secret = &ctx->rx_secret;
>> +    }
>> +
>> +    /* The key must be installed first: its cipher selects the hash */
>> +    if (!TLS_CRYPTO_INFO_READY(crypto_info) ||
>> +        crypto_info->version != TLS_1_3_VERSION)
>> +        return -EINVAL;
>> +
>> +    if ((tx ? ctx->tx_conf : ctx->rx_conf) != TLS_SW)
>> +        return -EOPNOTSUPP;
>> +
>> +    len = tls_traffic_secret_len(crypto_info->cipher_type);
>> +    if (!len)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (sockptr_is_null(optval) || optlen != len)
>> +        return -EINVAL;
>> +
>> +    /* A received KeyUpdate may ask for one in reply. The kernel
>> +     * consumes the record, so only the kernel can send the reply.
>> +     */
>> +    if (!tx && !ctx->tx_secret.len)
>> +        return -EINVAL;
>
> Hmm? What is this? Doesn't that imply that you first have to set the
> TX key before setting the RX key?
> The documentation says we can do either way ...
The order applies only to the secrets. TLS_TX and TLS_RX can still be
set in either order. tls.rst says "TLS_RX_TRAFFIC_SECRET needs
TLS_TX_TRAFFIC_SECRET first".

The check refuses an RX secret without a TX secret. A received
KeyUpdate can have update_requested set. The kernel consumes the
record, so only the kernel can send the reply, and the reply needs the
TX secret. An RX secret alone could never answer it.

An application normally sets both secrets one after the other, right
after the handshake. A KeyUpdate is processed only when the socket is
read, so it cannot arrive between the two calls unless another thread
reads the socket.

Question 1 of the cover letter, one option for both secrets, would
remove the order. I will wait for other opinions on it.

Martin
>
>> +
>> +    if (secret->len)
>> +        return -EBUSY;
>> +
>> +    if (copy_from_sockptr(secret->data, optval, len)) {
>> +        memzero_explicit(secret->data, sizeof(secret->data));
>> +        return -EFAULT;
>> +    }
>> +    secret->len = len;
>> +
>> +    return 0;
>> +}
>> +
>>   static int do_tls_setsockopt(struct sock *sk, int optname, 
>> sockptr_t optval,
>>                    unsigned int optlen)
>>   {
>> @@ -883,6 +960,13 @@ static int do_tls_setsockopt(struct sock *sk, 
>> int optname, sockptr_t optval,
>>           rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
>>           release_sock(sk);
>>           break;
>> +    case TLS_TX_TRAFFIC_SECRET:
>> +    case TLS_RX_TRAFFIC_SECRET:
>> +        lock_sock(sk);
>> +        rc = do_tls_setsockopt_secret(sk, optval, optlen,
>> +                          optname == TLS_TX_TRAFFIC_SECRET);
>> +        release_sock(sk);
>> +        break;
>>       default:
>>           rc = -ENOPROTOOPT;
>>           break;
>>
> Cheers,
>
> Hannes

