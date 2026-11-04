Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622A606A32C
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=puXn0B0K;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouSS5mQx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=; b=puXn0B0KuUUc7K
	XwI3yk8mK5raLrgPQCLcvpxQYtGr7NOxQ7pKp3RuNF1bklm99i4N6mn05bhd7HIahQQ/bYjrO7HXW
	711FuAU3hNGD+RA0a13YInFJ+fc3W4Ce5JbVsOSB9KerBHyxHMd6+OB/JuHgZ8+PiDhldGofz3HnR
	ayV2lPkMudGE3H9ujpZFXqiKS3sIh6REj4Cyl/SRhx8bd0SZSIqwwLcTPhBjO2wo96spRWh7fv1jr
	FIjnh/V+OKfzcIfSYLWjHzmf0bK5/czVgpj1Zq8TlEfCYNMW5oW1ASrOFWKIE/RDtX/+1qO3en9EM
	6DscXqGt/QzzphktDF4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkWO-00000007GAc-0gBK;
	Wed, 04 Nov 2026 23:36:00 +0000
Received: from mail-qk2-x01.google.com ([2607:f8b0:4864:34::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkWL-00000007GAF-45au
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 23:35:59 +0000
Received: by mail-qk2-x01.google.com with SMTP id d75a77b69052e-5332a0f6dbbso8351671cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835356; x=1794440156; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=ouSS5mQxf2aA4tOratVT5kufEEXuUDvR5IDes8F2XLkuaDenTmGBLP+RGZJYazah8x
         S+Za7P/MGFkQo+OxqxNvgBXVILoUp7JjLRJqTI3Lc1EgxUU+/fnVGpj1r5NmNIBuoY9r
         oe3W7cETQCBOCdK+UC8qp9PD/hicnFjb3fexIkkQVM2YzsEjWcsOaF1DjQ3P2W4pr5DK
         KKjqsLUWc5mVY5WDNjeIT3GzEzsj6EDUzv7sIl3Hs0KDTPFTa6X7YEFwyqNDbiS0tFBI
         Sct7PXOuHg+Ec5JztKTfiI9TWiJTxpZgNuDiOzbCoxi2ekCyOSwByg5irs7B/ypytCXy
         H7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835356; x=1794440156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=rRkIpXLk3P3+Gm72ew7dFJor/c+rad9NZnr6L4IpYe9ICSgxacqTbPa93i+chyWveS
         TRb4j9gXVtpZ/Qdd98FhDeA8eE6sqYUqZVnR6p1vd69lUBmdLAtzNoJEUi2ZfO6+0Orq
         vOVkEKHwiwy+ook5ek5iuQGxpyiL+rxTx9RHUa33aJOsK3uzNG7+4Ke5RIGZd+wgqRyU
         ZriXyCd+KX4/txMTYpi/k1jEmBK9wTZfnUtUPmNB5f9MASHsoAg4yj6NPmWiW2Kz5377
         4RmYUOXHauYo5nJ9UEU9dg41lJcVPETc/MSbr0n3VEd/IgPdlx5We3CTjfMDbfdVVzXp
         ea/A==
X-Forwarded-Encrypted: i=1; AKwUvBxxiep5ewJGndtLhyAWsmljmiYlxbD/hyX9LW2jBjIrBENu1M4yvO9Z+SAiFl95nmU1emWdzwc/O0XI@lists.infradead.org
X-Gm-Message-State: APuU4Z9Me86xYJooc61UW0/S737CQhqxpeXg2P8uiElxyY3j70yEkLIH
	Henf1ZCly0MwT5b1STEITNHIct9xf0hrlIQjPeFr8u2WN0PTV/f7QoAI
X-Gm-Gg: AYBFou2D9YZ1lRBmCfKulCB9rnVy4xunpFSfH+VsQ1dqf9B48eQucU2+3mQyJL+G7Hg
	Rw4mphCFmHnqPsFgYEMrJwCJ6Il+jFE9fDJHOW26ao8r0eOBl9MmbpScBald3UkFp9uXBzvSLVK
	IXZ3AG9Iua7ZXEUQNzaylW5VX0CIY3IDzTy3s27PmTTp8up6prw7IvtEmCdlpFF6kpLIV163rxW
	I8dQSLgC2gcUGayuPNKpgQSfd4gR8jCIBFFQhXFzEjUJamwvESjuM4J4YEzc7llqxmr8ACg5I+1
	zNAmQumR2PPY919vNcrfbzLDv1qMib1oofahmf7i7Z5R+AvPjzIVH9XfjcTDfY5npUoReX2V8gh
	AZTmd/7U+VFmYcYNA26kdhGyypAYFnMo4tBl2LSuMyzSVjhzj+IxbVXQ6yW4sZQNo9h1nwXLRMd
	16zWZY36Q5BUGo+V0s5WdVf0hL6uhzah5LJ+0FlmJeRBIeiW6jKQkRjx4ZossQnJ08KOpOY/EXd
	sQrxibEq8XtMeqkLr7mZ52ygjzC953wzGatLIeL1Y/NgHWUzY76/LSxKVoTfRm2EFC3SlL1O8wW
	vmR5AHKW227WBUZFJIJa/dWsaYnMTXw/eg==
X-Received: by 2002:a05:622a:1aa9:b0:536:766f:271d with SMTP id d75a77b69052e-542b781f632mr306774901cf.51.1793835356393;
        Wed, 04 Nov 2026 15:35:56 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a63462sm36858141cf.15.2026.11.04.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:35:56 -0800 (PST)
Message-ID: <2a1728c5-2856-41bb-9ffd-c80df4ffda6e@gmail.com>
Date: Wed, 4 Nov 2026 18:35:54 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] tls: send a KeyUpdate at the record limit
 and on request
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
 <20261103-keyupdate-rfc-v5-5-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198141@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198141@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_153558_019278_C22E8C43 
X-CRM114-Status: GOOD (  13.83  )
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
 > > +   ret = tls_encrypt_async_wait(ctx);
 > > +   if (!ret)
 > > +           ret = tls_keyupdate_rekey(sk, 1);
 >
 > [Severity: Medium]
 > As reported by Sashiko on v4 [1], can tls_tx_key_update() ignore fatal
 > transmission errors and rotate the TX key anyway when 
tls_tx_records() fails
 > with -EPIPE or -ECONNRESET?

Yes, but this is not specific to KeyUpdate. After shutdown(SHUT_WR),
send() on a kTLS socket with no KeyUpdate also returns the full
length. I tested this with TLS 1.3 AES-GCM. As I read the code, the
KeyUpdate record then stays queued and TCP does not send it, so the
peer never sees a record with the next key.

This corrects my note in the v2 changes, "The next call reports the
error". In the same test, the next send() also returned success.

 > [Severity: High]
 > As reported by Sashiko on v4 [2], how is the KeyUpdate state in struct
 > tls_context synchronized when sk_stream_wait_memory() drops lock_sock(sk)
 > during a send or TLS_TX_KEY_UPDATE?

No change, for the reasons in the v4 changes. I checked these points
by reading the code.

Points 1 and 2 need a TLS_TX or TLS_RX setsockopt() during a blocked
sendmsg(), which is an application error.

Point 3: tx_key_update_reply stays set after the update_requested
KeyUpdate, so the reply still goes out before the next Application
Data record.

Point 4: a record that was already being written can go out before
the reply. RFC 9846 section 4.7.3 allows this for records in flight.

Martin

