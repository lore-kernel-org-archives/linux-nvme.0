Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A1606A334
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O4xTnpOE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKlKJGyh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=; b=O4xTnpOEGo0XgM
	AKXpHlmhkEqZZCLnqVQ1n1Ta/YQWZxNpzNVP28gUHPuC1psv0AWKFdGtoE5lJRMWqK9wBdFPTeRa0
	VmGh+QYzHYAp+FuUV1lWETNi2ArCGLP77fqHc7nxlXWzFKMgcGNF1ioeo3nibrnX4a+Hm9PJviTH0
	yIlT+lkZfdY+GIOgez0CaEyi/pdFtxSmpbKly77eeb7lN+KTQUmely6MYkYhGK2r4pOFbJVru7Wxh
	iJ5Ky4LueighrTbNGS9uTYxe7kvgI4esdhee74ciBRd3vKksZlb8TGqERDTUApRRZxs38enXPEPIb
	vvCwumWlIOp/+whXIKQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5CM-00000007IM7-0AfG;
	Wed, 28 Oct 2026 15:04:18 +0000
Received: from mail-yx2-x0b.google.com ([2607:f8b0:4864:41::b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5CI-00000007ILi-1gRH
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:04:15 +0000
Received: by mail-yx2-x0b.google.com with SMTP id 00721157ae682-8b0b746503fso2573887b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199852; x=1793804652; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=;
        b=wKlKJGyh09QUlmYnFvB3o/TAz1pyfaC7hgSe5GqtJ7d5uY5JM0pnBvDF7DHf50ld3s
         ssdTz3z7sfbhPUX6m7H7FmN5ZMYmRO/ZeEE1Jz1I4iboCtKcAVSYAequgWKy7mnJxEsA
         1UfGIgJ2PHXW/nXHKDb3jWG4fZs5VsvBtn4XeY5F5k/oiwN6WHKjtE5RiHAhkHIY21CM
         mBZmHt2APlnaxvXf638A7XnLTCEQ23m99lp/Z5IxI+HgB1kuLQNFe8fpsnJo/RiEILLN
         4erm/lYpfvqaHQrJXWi5lZMjcAyaKjF5lC55zNaSRMd9uOBzye00aMWXEYfzWNM/sP5u
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199852; x=1793804652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=;
        b=1DhHDKb2g1jsePOF+O/mW9IOomXtuVCAzYindxL0f2yJIePDCOI2TnIvA5tipZsohj
         Ne/1YJBRn1YmUwXT9GJ73Wi7KetM/xHa9qlAsWxx74qhVlihrzFZ+4Dc6S1VmwQK3Egz
         wEaMyzahgj/kQ/jEUe9DlrYy+4t0wd6AGQR+fEfaNeYXxE3Dl7CZWCUoBJ3+we7IAoyU
         tlVD9UhVlfhUhPy/Azf2ueb54RKyHRLGPZKczPSe1WDt+bq/rssiIgglKC7KqBQVZ/jM
         8j1jNOP/5BacCUm5O0kLvljMOw+3nsJQGoVOTE/rTthBC2s6BwtkhXCFXxZCCg7LYzkJ
         HEqA==
X-Forwarded-Encrypted: i=1; AKwUvBxfvdsua/ZV6Gosj+N0srwCswNyWfGHlnXcrniGsfMin8InN4s0AMU84kftk6ADXvYlDZ3mtnGS/7gg@lists.infradead.org
X-Gm-Message-State: AFq9FYLpkGt+Wg1BPw394wxQjaSW9K4m3qalKLCc6/+BS1IZU4qwS3RF
	lQtmS58XEAfJENzgmOXi6qzTtEARJ31gYvUOmnisk6cZUah2yumPY1rZ
X-Gm-Gg: AYBFou1kB6YBZElvBr8K4nIt+4zHS2QtcgqPJvg9WEn3iYguzWKGSiBQnC+x0xVJcew
	o8rfsGYk3FL870UzvOwX0BOalq3nMLN45w0Y3CP17ETRNv55tu9MIjhxFn4I6/7TLRyFngekuMI
	n4LjOUOYf3CQnnQtdy0P1Y2acsLGO8QFET5Hohh9sZOR+KNXrucd9cPrhLg/W4GnnHaNBw5Sw+g
	WL6My/fCfFWHNp1UuZmc1QMU0XYsuA3bPGafEchYYMpIpdff2yl2+YTzDfT8L7Aonqvfcu6lnH/
	43aSTqMviuHNp2pw/9ukJGN+d5AVhnk1IPltPjAlEJMy9FDhjVmktHNuff7LeNqLAh9Vu8QuQ2u
	V8lKgdMjQyB5IpZggKH+zo/YZ584Goqm1wwj7kzNtPLa2NUP+pVRMJ5jwC351asWgcHwk+uGmfn
	ZuR38YgY503MQq5zBRaYimQf+6sYHNjKaF32ucQGL+Zh1pu2vlsWyoVCwMpwIK6w5lijglxRsid
	cWEVIVHDJB4p3ONpJbzWJbUQbq8yE/DhZZMg9Vga+TnPjk66FQkdV70V0HPETnp0NNt8Rr70BnW
	jqLupKITtQJLhWyJqkquPP4ufMO2yubdC902
X-Received: by 2002:a05:690e:441c:b0:677:d9d8:d927 with SMTP id 956f58d0204a3-67a7bebab48mr1814453d50.74.1793199852326;
        Wed, 28 Oct 2026 08:04:12 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a1887c9sm1801270d50.20.2026.10.28.08.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:04:11 -0700 (PDT)
Message-ID: <69b373c4-4a1f-4863-a1e5-dd8aeea7b02e@gmail.com>
Date: Wed, 28 Oct 2026 11:04:09 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Hannes Reinecke <hare@suse.de>, Chuck Lever <cel@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
 <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_080414_462977_A4C8404D 
X-CRM114-Status: GOOD (  39.51  )
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



On 10/28/26 10:42, Hannes Reinecke wrote:
> On 10/28/26 3:21 PM, Chuck Lever wrote:
>>
>>
>> On Wed, Oct 28, 2026, at 9:52 AM, Martin Belanger via B4 Relay wrote:
>>> kTLS does not currently handle TLS 1.3 KeyUpdate. It never sends a
>>> KeyUpdate. And when it receives one, it blocks the socket until the
>>> application installs the next key. kTLS also does not enforce the key
>>> usage limit on transmit.
>>
>> No argument here.
>>
>>
>>> This applies to TLS libraries in user space as well as kernel users such
>>> as NVMe/TCP or sunrpc:
>>>
>>> - GnuTLS sends a KeyUpdate after 2^24 records when it runs its own
>>>    record layer. With kTLS, the record layer is handled in the kernel 
>>> and
>>>    GnuTLS therefore never runs the check. OpenSSL never sends a 
>>> KeyUpdate
>>>    on its own.
>>> - NVMe/TCP and sunrpc don't have a mechanism to install a new key. A
>>>    conforming peer that sends a KeyUpdate stalls their connection.
>>
>> The design intention of these consumers is that they are supposed to 
>> break
>> the connection and create a new session, rather than stall. If that is 
>> not
>> happening, that's a bug. KeyUpdate is complicated enough that backporting
>> to LTS is not really an option, so that bug needs to be addressed first,
>> IMHO.
>>
> Yes. But Martin send already a patchset for that (well, for NVMe, at 
> least).

Thanks, Hannes. Two points to add.

A reconnect is also a valid answer to the record limit: RFC 9846
section 5.5 allows closing the connection. The cost is the problem.
Depending on the load and link speed, the 2^24 limit can be reached in
less than 10 minutes in many cases. Each reconnect stops the I/O of the
queue and needs a new handshake upcall, for every queue of every
controller. A peer that sends KeyUpdate on its own causes the same
reconnects. With this series, the connection stays up.

> 
>> The argument that was made that put tlshd in user space is that we do
>> not want the kernel to handle something that the libraries are already
>> good at (IOW, mechanisms that have been soaked in commodity usage by many
>> consumers).
>>
>> Is that rationale different for handling TLS KeyUpdate? I see that the
>> series adds back the HKDF functionality to the kernel. That seems like
>> an indication that KeyUpdate should be handled via an upcall.
>>

The series does not add back the HKDF library. It computes the HMACs
inline with the HMAC library, as the NVMe PSK derivation in
drivers/nvme/common/auth.c does. That is why commit 6d888db2cfd9
removed the library. The QUIC series also derives its key updates in
the kernel.

GnuTLS does handle a received KeyUpdate with kTLS since kernel 6.14,
but only when user space keeps the GnuTLS session. tlshd does not: it
hands the socket to the kernel after the handshake. So the library
cannot help nvme-tcp or sunrpc here.

Martin.

> Yes. TLS KeyUpdate requires that all records _after_ the KeyUpdate 
> message are encrypted with the next key; idea is here that one can
> (and should) do this in-line without stopping/resetting the connection.
> _And_ TLS KeyUpdate is done independently on the RX and the TX side.
> 
> This makes it extremely hard to implement via tlshd; we would need
> to pass the KeyUpdate message to tlshd (which is easy), but then
> we would need to stop processing incoming packets until we get
> a response from tlshd indicating that it has installed the new
> secret.
> 
> Which makes the whole idea of KeyUpdate (namely that you can
> do it _without_ stopping packet processing) a bit pointless.
> 
> And I haven't even mentioned that you would need to be able to
> stop RX and TX _independently_, which I'm not sure the various
> ULPs can do.
> 
> Plus there is the question why ULPs need to be burdened with
> protocol specific knowledge; why would I need to code hooks/
> handling for an extremely protocol-specific know?
> It's far better be handled by the protocol itself.
> 
>> Are there policy decisions that need to be made during KeyUpdate (like,
>> has the peer's certificate expired, or has it been put on a revocation
>> list in the meantime) ?
>>
> No. This is not about the certificate, it's about traffic secrets.
> If a certificate is expired you need to reset the connection
> to install a new certificate; TLS 1.3 does not allow you to do
> that while the connection is established.
> And handling of expired certificates is an admin choice, not
> something one should do automatically.
> 
> (The last thing you want is your root fs becoming inaccessible
> just because a lazy admin forgot to renew the certificate ...)
> 
> Cheers,
> 
> Hannes


