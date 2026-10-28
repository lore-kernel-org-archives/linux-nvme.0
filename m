Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4A60A2618
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OhMcG2qh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t41cM/wE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=; b=OhMcG2qh2VsIco
	gYlR4jgkL9FkYUmEYTwnAvFU77ahFQb87+CrCxf72YnSVp9VbnMk5J7mrdhVP5KGU0KddxbCRi+ZU
	srX5ePegp7ROJUzciT11f+HGCVt/v/Il2ctPKJaZMIPCpiGY2QJPGSBR+SrW7fdasNTB6w37Rnp2C
	HcRe0gUMDlFXnHaleh++2R0Kx/UPfQHluLSyGREvUh2z4MWHKz8smpyZosgrWzXGJ18GJlx9Wjtw2
	hUQQjhcUzdLVGORsbQCtcG1iFE+35Wg7TgJ4rYcUVw1vU2k3DG2YcgSEU+JJLF6rxRLajScPNBOKn
	cNcSI65oTR8P2DLCCEvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Hx-00000007ech-0NWb;
	Wed, 28 Oct 2026 17:18:13 +0000
Received: from mail-yx2-x02.google.com ([2607:f8b0:4864:41::2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Hu-00000007ecN-3hIO
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 17:18:12 +0000
Received: by mail-yx2-x02.google.com with SMTP id 00721157ae682-8b0e810ca39so2835557b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207889; x=1793812689; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=;
        b=t41cM/wEVvlG2nfaFlyr/2OyYOq5xp9jQwPIbmT6laU+iFfFDfwV/18syPD4C0nAOU
         EQTGV1Qi2cnPVvkJIKeu4LuZQlc3PtewwVaWv4MORZQuYVVE8O0K0Juhk2pQnr9fo1Ee
         hB5TXRM2iNAMyYzQ6MR8yGzoT3HS9WV+4tFJGpoQFWoPNtOOPyvtkrNt39RJridHDrLB
         t+wsS8zOUIq/3Q6FnDMxr3bcYNS1j3vEXVCM4oPy9Vq8Pl7cCxiaMVS+O8te20bu5iS+
         c/B3rZ3xrOMhi7p85Pg843Tqccc+29RWsAoJH8j2E4i9bcrPJJ0fq1t0ejrHc+4o5+PE
         kL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207889; x=1793812689;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoqGoVuIDj85F9T+yZlnMdvqGFtpm28q4hBm37Nfu4I=;
        b=VrYVHPjp8yl1L9jQLuK3KFgS8May2SzD8RXAsOmpUGD9kuBrzNn4ppsyqgLQ5yokGk
         H9WIYbq5pyOG94ywo97Zh/Jifcjbsk9LVosNrYh6wylco0j59N+2EEjZoXHLm/SjTlgZ
         AI9c1ueYi1VHZrhHPZBcCMsirQmCpSLgnpG35Gb07X9kBvgMO7+RglSkd1lryPdV+2om
         C7alrsx8ZWvKv8TVek+q82snL0/kSW0ytnsFo67aCSuwPjeuFOFuk2Q64dELSTImGUfb
         mOGlloE0qVCb4QIoMx/s3XhLBchigcHVZpX9mPkT/VdsBaWEvkSzVBhkyUPK9O116s8o
         pFYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/p0nHBEi7vvAnye6kRIlhzxwgBGyuUp8EM2DPxQcjAEfOvizQv/R2mdwuDN9rXnxrpeOr+MVYk1tp@lists.infradead.org
X-Gm-Message-State: AFq9FYIJmu4b9RxWWPgNMIslIHUVG7HnoJ41x29zWlAe2k4FtdvmNuni
	nr9o+J15Z9RgrSd53d+mSumU1TuI/OdY/B4D5ac1fwRo4MuWp/DLN7IJ
X-Gm-Gg: AYBFou01lUalhGZUwhGv7F77KuQo917r1iedMVLnJANXBFiC6tE75EGiBoSbLXZB402
	/1rIN1WgNcydmexX2BEAZ2cndVuSvx4QGi1WcoZ9kGcoz/oMnrfy/LN/RlshgRINDUMercexXp6
	55WcSiE2tNwdwnFgNSNPaZp1mcCPLUlFVxkgHanL8WrHXT1OMvIo0Kah2cWEFd2xUL16DlvBmrP
	vNZQQkRoBRwVTe93MDcroNt1YjUni+KYhkXScEb5HLixhGWb9uwqqOypMZmd36ywB2UZjblAWv9
	S3/AqvhwXjmrlDpRGMLcMkfYuWRGbv14chCJsuzRJiCwMgqUneNZNV1VfB40egyiGD3zmHNEoFO
	cbX/txVVdDmOVffgBBBKAc+N5/Dobq5sDy4S/Ynjosh7KMnGyfNvWURPERdxRYmkkSi4iJtsnnb
	7/2Pe6yV8mi7HwXpsiA8dZxiafMXP93GdI5e+Yl/Swqw4o3YEy6zBUwJw2UZvD/C8+v08HVzlI4
	jFgB72RxAkTdXhUMoreBb0KF8u9nAhOWu/Q85P3DgmHKhvEK7b82bx34SD6uW0vZIyZwt/y+/Hr
	kMRoQNwkd+jbTiQ9fKFf+NT3COdP0Z1mxeo=
X-Received: by 2002:a05:690c:6602:b0:8a4:d87f:8d52 with SMTP id 00721157ae682-8b1b59cdb34mr17759107b3.2.1793207889578;
        Wed, 28 Oct 2026 10:18:09 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e43d5c6sm31865247b3.2.2026.10.28.10.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:18:08 -0700 (PDT)
Message-ID: <0fe51c04-f399-448a-9975-0112cc573e40@gmail.com>
Date: Wed, 28 Oct 2026 13:18:07 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 4/5] tls: send a KeyUpdate at the record
 limit and on request
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
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmail.com>
 <82963fe6-e908-4c1a-b963-ac1ab86f2bdc@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <82963fe6-e908-4c1a-b963-ac1ab86f2bdc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_101810_977434_321C4C93 
X-CRM114-Status: GOOD (  29.79  )
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



On 10/28/26 10:23, Hannes Reinecke wrote:
> On 10/28/26 2:52 PM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> RFC 9846 section 5.5 requires a key update before the key reaches its
>> usage limit, 2^24.5 full-size records for AES-GCM. The limit counts
>> records, and only the record layer knows where records start and end.
>> Section 4.7.3 also requires a reply to a KeyUpdate with
>> update_requested, sent before the next Application Data record. Both
>> need a KeyUpdate at an exact position in the record stream.
>>
>> For a socket with a registered TX secret, send a KeyUpdate before the
>> next record when the key has protected 2^24 records, as GnuTLS does,
>> or when the peer asked for one. ChaCha20-Poly1305 has no record limit.
>> The KeyUpdate is sent as a handshake record, which closes the open data
>> record first. Pending encryptions are then completed, and only then is
>> the next key installed.
>>
>> Add TLS_TX_KEY_UPDATE to send a KeyUpdate now, optionally asking the
>> peer to update too. It can only bring a KeyUpdate forward: the record
>> limit is enforced either way. Following section 4.7.3, a new request
>> to the peer waits for the answer to the previous one, and no more than
>> 2^48-1 epochs are used.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   Documentation/networking/tls.rst |  17 +++++
>>   include/net/tls.h                |   5 +-
>>   include/uapi/linux/tls.h         |   1 +
>>   net/tls/tls.h                    |   1 +
>>   net/tls/tls_keyupdate.c          |   5 ++
>>   net/tls/tls_main.c               |  38 +++++++++-
>>   net/tls/tls_sw.c                 | 150 +++++++++++++++++++++++++++++ 
>> +++++++++-
>>   7 files changed, 214 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/tls.rst b/Documentation/ 
>> networking/tls.rst
>> index 2e011bd1ce4a..69752a6d67df 100644
>> --- a/Documentation/networking/tls.rst
>> +++ b/Documentation/networking/tls.rst
>> @@ -326,6 +326,23 @@ direction is then left to the application again.
>>   The secrets cannot be read back.
>> +With a registered TX secret, the kernel sends a KeyUpdate before the key
>> +reaches its record limit (RFC 9846, section 5.5): after 2^24 records, 
>> except
>> +for ChaCha20-Poly1305, which has no limit. It also sends one before 
>> the next
>> +record when a received KeyUpdate asks for it. With a registered RX 
>> secret,
>> +the kernel processes a received KeyUpdate and does not pass the 
>> record to
>> +the application. A peer that sends more than 8 KeyUpdates in one 
>> second ends
>> +the connection.
>> +
>> +TLS_TX_KEY_UPDATE
>> +~~~~~~~~~~~~~~~~~
>> +
>> +TLS 1.3 only. Send a KeyUpdate now and install the next TX key. Needs a
>> +registered TX secret. The value is an ``int``: 0 to send a KeyUpdate, 
>> 1 to
>> +also ask the peer to update its key. Asking the peer needs a 
>> registered RX
>> +secret, and fails with ``EBUSY`` until the peer has answered the 
>> previous
>> +request.
>> +
>>   Statistics
>>   ==========
>> diff --git a/include/net/tls.h b/include/net/tls.h
>> index a5bc28a7d1f5..d3123b17030c 100644
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -282,9 +282,12 @@ struct tls_context {
>>       union tls_crypto_context crypto_send;
>>       union tls_crypto_context crypto_recv;
>> -    /* Registered for KeyUpdate, protected by the socket lock */
>> +    /* KeyUpdate state, protected by the socket lock */
>>       struct tls_traffic_secret tx_secret;
>>       struct tls_traffic_secret rx_secret;
>> +    u64 tx_key_updates;        /* KeyUpdates sent */
>> +    bool tx_key_update_reply;    /* peer set update_requested */
>> +    bool tx_key_update_asked;    /* we set it, no answer yet */
>>       struct list_head list;
>>       refcount_t refcount;
>> diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
>> index d1b136ecea96..c85408cb6ce7 100644
>> --- a/include/uapi/linux/tls.h
>> +++ b/include/uapi/linux/tls.h
>> @@ -44,6 +44,7 @@
>>   #define TLS_TX_MAX_PAYLOAD_LEN    5    /* Maximum plaintext size */
>>   #define TLS_TX_TRAFFIC_SECRET    6    /* TLS 1.3 TX traffic secret */
>>   #define TLS_RX_TRAFFIC_SECRET    7    /* TLS 1.3 RX traffic secret */
>> +#define TLS_TX_KEY_UPDATE    8    /* Send a TLS 1.3 KeyUpdate now */
>>   /* Supported versions */
>>   #define TLS_VERSION_MINOR(ver)    ((ver) & 0xFF)
>> diff --git a/net/tls/tls.h b/net/tls/tls.h
>> index 63ece8074985..d12c9278c814 100644
>> --- a/net/tls/tls.h
>> +++ b/net/tls/tls.h
>> @@ -151,6 +151,7 @@ int tls_hkdf_expand_label(const u8 *secret, size_t 
>> secret_len,
>>                 const char *label, u8 *out, size_t out_len);
>>   int tls_keyupdate_rekey(struct sock *sk, int tx);
>>   int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
>> +int tls_sw_key_update(struct sock *sk, int request);
>>   int tls_set_sw_offload(struct sock *sk, int tx,
>>                  struct tls_crypto_info *new_crypto_info);
>>   void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
>> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
>> index 543bf57599c7..851d5b54b336 100644
>> --- a/net/tls/tls_keyupdate.c
>> +++ b/net/tls/tls_keyupdate.c
>> @@ -146,5 +146,10 @@ int tls_keyupdate_rx(struct sock *sk, struct 
>> sk_buff *skb)
>>       }
>>       TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>> +    /* Any KeyUpdate from the peer answers our update_requested */
>> +    ctx->tx_key_update_asked = false;
>> +    if (msg[4] == TLS_KEY_UPDATE_REQUESTED)
>> +        ctx->tx_key_update_reply = true;
>> +
>>       return 0;
>>   }
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index 8bb1b2773f3f..d71de99d8890 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -765,10 +765,14 @@ static int do_tls_setsockopt_conf(struct sock 
>> *sk, sockptr_t optval,
>>           /* The registered secret no longer matches the key. The RX
>>            * secret also needs the TX one, see 
>> do_tls_setsockopt_secret().
>>            */
>> -        if (tx)
>> +        if (tx) {
>>               memzero_explicit(&ctx->tx_secret,
>>                        sizeof(ctx->tx_secret));
>> +            ctx->tx_key_update_reply = false;
>> +        }
>>           memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
>> +        /* the answer now goes to user space */
>> +        ctx->tx_key_update_asked = false;
>>           return 0;
>>       }
>> @@ -987,6 +991,35 @@ static int do_tls_setsockopt_secret(struct sock 
>> *sk, sockptr_t optval,
>>       return rc;
>>   }
>> +static int do_tls_setsockopt_key_update(struct sock *sk, sockptr_t 
>> optval,
>> +                    unsigned int optlen)
>> +{
>> +    struct tls_context *ctx = tls_get_ctx(sk);
>> +    int value, rc;
>> +
>> +    if (sockptr_is_null(optval) || optlen != sizeof(value))
>> +        return -EINVAL;
>> +
>> +    if (copy_from_sockptr(&value, optval, sizeof(value)))
>> +        return -EFAULT;
>> +
>> +    if (value != 0 && value != 1)
>> +        return -EINVAL;
>> +
>> +    rc = mutex_lock_interruptible(&ctx->tx_lock);
>> +    if (rc)
>> +        return rc;
>> +    lock_sock(sk);
>> +    if (ctx->tx_conf == TLS_SW)
>> +        rc = tls_sw_key_update(sk, value);
>> +    else
>> +        rc = -EINVAL;
>> +    release_sock(sk);
>> +    mutex_unlock(&ctx->tx_lock);
>> +
>> +    return rc;
>> +}
>> +
>>   static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t 
>> optval,
>>                    unsigned int optlen)
>>   {
>> @@ -1020,6 +1053,9 @@ static int do_tls_setsockopt(struct sock *sk, 
>> int optname, sockptr_t optval,
>>                             optname == TLS_TX_TRAFFIC_SECRET);
>>           release_sock(sk);
>>           break;
>> +    case TLS_TX_KEY_UPDATE:
>> +        rc = do_tls_setsockopt_key_update(sk, optval, optlen);
>> +        break;
>>       default:
>>           rc = -ENOPROTOOPT;
>>           break;
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index cc0177320e7e..4fe78624859d 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/splice.h>
>> +#include <linux/unaligned.h>
>>   #include <crypto/aead.h>
>>   #include <net/strparser.h>
>> @@ -1005,6 +1006,151 @@ static int tls_sw_sendmsg_locked(struct sock 
>> *sk, struct msghdr *msg,
>>       return copied > 0 ? copied : ret;
>>   }
>> +/* RFC 9846 section 5.5 allows 2^24.5 full-size records per AES-GCM key.
>> + * Send the KeyUpdate a little earlier.
>> + */
>> +#define TLS_KEYUPDATE_TX_RECORDS    BIT_ULL(24)
>> +
>> +/* Section 4.7.3: the epoch must not exceed 2^48-1. The application
>> + * traffic secrets start at epoch 3.
>> + */
>> +#define TLS_KEYUPDATE_MAX        (BIT_ULL(48) - 4)
>> +
>> +/* Send a KeyUpdate with the current key, then install the next key.
>> + * Called with tx_lock held and the socket locked.
>> + */
>> +static int tls_tx_key_update(struct sock *sk, u8 request, int flags)
>> +{
>> +    u8 body[TLS_KEYUPDATE_MSG_SIZE] = {
>> +        TLS_HANDSHAKE_KEYUPDATE, 0, 0, 1, request
>> +    };
>> +    struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +    struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
>> +    u8 record_type = TLS_RECORD_TYPE_HANDSHAKE;
>> +    u8 buf[CMSG_SPACE(sizeof(record_type))];
>> +    struct msghdr msg = {};
>> +    struct cmsghdr *cmsg;
>> +    struct kvec iov;
>> +    int ret;
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    msg.msg_control = buf;
>> +    msg.msg_controllen = sizeof(buf);
>> +    msg.msg_flags = flags & (MSG_DONTWAIT | MSG_NOSIGNAL);
>> +
>> +    cmsg = CMSG_FIRSTHDR(&msg);
>> +    cmsg->cmsg_level = SOL_TLS;
>> +    cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
>> +    cmsg->cmsg_len = CMSG_LEN(sizeof(record_type));
>> +    memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
>> +
>> +    iov.iov_base = body;
>> +    iov.iov_len = sizeof(body);
>> +    iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, sizeof(body));
>> +
>> +    /* A control record closes the open record first, so all data
>> +     * written so far goes out with the current key, ahead of the
>> +     * KeyUpdate.
>> +     */
>> +    ret = tls_sw_sendmsg_locked(sk, &msg, sizeof(body));
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    /* Nothing may be encrypted with the next key before the KeyUpdate
>> +     * is encrypted with the current one.
>> +     */
>> +    ret = tls_encrypt_async_wait(ctx);
>> +    if (!ret)
>> +        ret = tls_keyupdate_rekey(sk, 1);
>> +    if (ret) {
>> +        /* The peer expects the next key: the connection is lost */
>> +        TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYERROR);
>> +        tls_err_abort(sk, ret);
>> +        return ret;
>> +    }
>> +
>> +    TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
>> +    tls_ctx->tx_key_updates++;
>> +    if (request == TLS_KEY_UPDATE_NOT_REQUESTED)
>> +        tls_ctx->tx_key_update_reply = false;
>> +
>> +    return 0;
>> +}
>> +
>> +/* Send a KeyUpdate if one is due: in reply to the peer's
>> + * update_requested (RFC 9846 section 4.7.3), or before the key reaches
>> + * its record limit (section 5.5). ChaCha20-Poly1305 has no record 
>> limit:
>> + * the sequence number would wrap first.
>> + */
>> +static int tls_tx_key_update_if_due(struct sock *sk, int flags)
> 
> '_if_due()' ? Hmm. 'tls_tx_should_update_key()'?

A "should" name usually means a check that returns bool, like
tcp_should_autocork(). This function also sends the KeyUpdate, and it
returns -EKEYEXPIRED at the epoch limit.

net/tls already uses "maybe" for a function that acts only when needed:
tls_rx_msg_maybe_announce() in tls_strp.c. I will rename this one to
tls_tx_maybe_update_key() in v3.

> 
> But otherwise looks good.
> 
> Cheers,
> 
> Hannes


