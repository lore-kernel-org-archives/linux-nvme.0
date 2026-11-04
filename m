Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97C606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wbhTxhEJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymKESkXy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=; b=wbhTxhEJN6N310
	hdr+ac7ftxlS8WyGcUW6N1P2BbrJ3jfhRjwb6R/DlsYht0uhoPYSv9hJ6xHKPBT8am9LgAXY+ea8C
	K2xWdKQ9CA0w+FYBYxfWHV2VXeE/oeaoTK0hc4vN6PD+240IRc6h1YPvDnAnDdZyCCR82ZmXy8UIM
	hQyEg4gw27MnN1NUw8MRdYWqpqr1XTdty3wULvaEiu8FiwxLLzd+2U7xC0QaWdD/nRTeihrwTtyUr
	wX0GD1QKfwnb68QFPbjGtrkcNvsCqQB8D+egsJc3Kfg5Rt3YVpJNBn+xVoefsebJGfRT82chFSNWg
	q6oGq9YfEz4M5UXZQ8ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkVL-00000007G4L-49rJ;
	Wed, 04 Nov 2026 23:34:55 +0000
Received: from mail-qk2-x08.google.com ([2607:f8b0:4864:34::8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkVI-00000007G3z-2prS
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 23:34:54 +0000
Received: by mail-qk2-x08.google.com with SMTP id af79cd13be357-93e63db6681so89787485a.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835291; x=1794440091; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=ymKESkXyy88SwAeZ/Obl/xJ+MzaxldfKltZwEjtm3waGOAWlV6qzMhMCUH2/t9diZy
         3Lm7ASI3DxSiLC8llLU8aFzBe41fzH9U93LnzGEUCD0P8Rk3b5ND2vouyc6pbr6XSyoD
         5l4HqvGrK+nTjFRbcpzWOtN1mH5wdzJ2HpaOFqfk+O/5HTC++ApvFRhmVFgRnCC3EDNq
         kKKV94oCrPEsWIjTZw6jNL5M+b5j3Ai73jgjR5jYst4lkzHORszPplCe1WqHqvb0hFI+
         PCNnKbqCCDiZYRwXp6v0140aa8QhRV+RrdV2gClcr8BjgUhRyqzkBMqYPVWr4y9cQ6FL
         nbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835291; x=1794440091;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfE6XYGuOtutQi6QIVbHin4gqCciGQW2WLAtGNmvG6Q=;
        b=HuGMSJ22fz7lD3zQPsHsv24om4BFhAGX4wsfSutw0b1GZAOce14O2DzIOhSwVGD707
         FhDFWCn+vsqARmF88DSQW+U5DF2iu9XdUkW9ZJkKTTMInpcJRXtKLRElKJizGRXkawmh
         Pfn+zQsmJnXdK0ZTZI/YWfSE31EeLBFRDHLQCj6OhNe+IvhBrccWBuiYtTVqWj3yOUAB
         7khoDwEzzpa/8/3ttSifEeEqapbMemIGqXcgS5CIPVcSkOu9MXNg5P0etkoU8jInUa+w
         aaRD9FzJJyNYCWgpHex7W7bS2ydW/ea6LyK1xNC8cYNRlTMr6oG8kO8crqsDyRSvU1sa
         C6qg==
X-Forwarded-Encrypted: i=1; AKwUvByRiR9CZucKDgZaQZT34wUkFzdMEEkRu7UC8hoe8fnHF+6uwclUvr7L5BbWrEZk4om8QMaemrJPd/h7@lists.infradead.org
X-Gm-Message-State: APuU4Z+aQ4ruaUFZtxYDh03aRrd+q2dJhbIknWKTmDRLlOOVHL1TYLag
	0AdXB9yqHF1zEusgCSsgdLNsZyuc6h1MFSd4PEScCpl3gbKXEkK8l/j0
X-Gm-Gg: AYBFou1lt7z8iyv3ykW/a6CB6vsfk75mcVLqHc4lT3Zms4IBhzw5xqVV1J76KegpcqR
	pgdus+Bnhh4F2awk/4EcYYHBLohgZZ2oilXHOi2UMxqhuSblQVeFjIpC6bxUWYmss0twrC4DWtl
	Ond5jEp+h8oqHzFAEF6YcAsRsi02TDrEgguwqyxcSy0OIEP5tplfE+cpm7FhcqkSyS8eBKMlF53
	cszF4VE4/671qLWOPOjW/xE0ATTul/l1OFVvdYUWkCPqcne4IMbXrIQunueyhjs6yG/xz5VybeN
	ByTxp8PDlZDHvrQBNmBRrabG5iTWjDqI9nXKQXtoCEEH2ANuJUqacP4cZ/ByCcc2dtuoLkgJO2B
	23d6gBfl66PXmSAu9m7+wfpsR4BgKIEjIlgUqbIHYdxb9t/KWdSwIxa5A2ScV4YISpaitiOOfhG
	gfCQ+p2xQmHPM7WVF+S6WGIrt2CfXJZnFfvwXIVqRwZDC6DbXdkLGoD9jxovFW/ZhPPUW11xkKl
	kOp+PmWr98w6W84+Xx/mrrAkoWT0I2C78QSIgKvrJJjuT6j+wl3X+oRmX8A12KRHHC3ib4nirv6
	msFh+Tklcbn81JahLohWiUmoH7K0DhlhRGQ=
X-Received: by 2002:a05:620a:2994:b0:939:4a44:5f99 with SMTP id af79cd13be357-9442156ab2fmr2992527785a.10.1793835291266;
        Wed, 04 Nov 2026 15:34:51 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm324141685a.39.2026.11.04.15.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:34:50 -0800 (PST)
Message-ID: <0f61c649-6e27-4f09-a69f-026f91d89848@gmail.com>
Date: Wed, 4 Nov 2026 18:34:48 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/6] tls: update the RX key when a KeyUpdate
 is received
To: sashiko-reviews@lists.linux.dev
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198140@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198140@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_153452_738131_E831FAC1 
X-CRM114-Status: GOOD (  10.19  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 16:43, sashiko-bot@kernel.org wrote:
 > > +   memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
 > > +   memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
 > > +          cipher_desc->iv);
 >
 > [Severity: High]
 > Won't these memcpy() calls trigger a CONFIG_FORTIFY_SOURCE field-spanning
 > write warning when tls_check_pending_rekey() -> tls_keyupdate_rx() ->
 > tls_keyupdate_rekey() runs on a socket with a registered traffic secret?

I could not reproduce this. I built with CONFIG_FORTIFY_SOURCE=y and
GCC 15.2 and ran the keyupdate selftest with TLS 1.3 AES-GCM. There
was no warning. In this build, __member_size() and __struct_size() of
both destinations are unknown (-1), so the field check is not compiled
in.

The result depends on the compiler. A small user space copy of this
pattern gives a member size of 0 with GCC. In the next version I will
take the info pointer from the union itself, as c43c1c24f3cd does for
the same reason.

Martin

