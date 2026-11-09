Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F9606D807
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WfDvbmjw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ki/H81tn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s/6rTMTiN3zjj45F6hON9XdsqIM41fhzAmDLM09T6Xo=; b=WfDvbmjwN7zqgz
	eNKF7iXzYZ9s1Lv6rXIbZRKVussfwvt6HkK5N1MzD6Qsk6+C7/g0r2vAbvDxW+LFWEpYye4Yh3lM3
	QCZTNKoSxg+AoheToIyUjaqn06Cpe0zyhGfWsb/dfpwIZWKTL22eNJc4Iyt+Nc3TPNc/OBTWso7Wx
	FR2mOdLn++GrLFdbdP9KGNLto+IfGKLKG2/hU255qYop4Bca6jj20LWmlValWEQ8EOjrw4whwOy3z
	13COgRkFLvyr2kCsoBoXf9pxUpe2OjC58hQpYSVDlIZd3yJLIH172ABNu5WoRIeNPVSln30RMMCe3
	D+CMYJ27Qp7VgiwfnL6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOGG-00000000do6-33mb;
	Mon, 09 Nov 2026 12:14:08 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOGD-00000000dnh-1fwl
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:14:06 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a3d39e403so611683d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794226443; x=1794831243; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/6rTMTiN3zjj45F6hON9XdsqIM41fhzAmDLM09T6Xo=;
        b=Ki/H81tnVuZI72b98l7m9Cu37Zu/t0FzshkC3cOcZLKpOPpQ45Q23NXkFuS43Vgmje
         8diUGfoDPuPFN6iMHPCls2Fvcz5sUjRypUxLaVsNQdOFoNrJPS9fKlE/ziTzSO8FxwfD
         Te8aBUGNmiwKUslRy2HtDG8JFI3kaj+xZOvSjoW4iy11TnJyrM/m5PoC2/Bn/S4dWEOD
         bRzpnkNEiA86wUheOs9gw1svMN8bb/4+KlJsia8m8HtXTWTcpIbhMVgHN2MOSRsMS7Lb
         lVyBEAVE2QxV3iInIoEqR9ZDK2PU/elN5PrkGU9W5LVuAgYxuypWCo8jpbH5u3N6KeyI
         pmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226443; x=1794831243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/6rTMTiN3zjj45F6hON9XdsqIM41fhzAmDLM09T6Xo=;
        b=g1YxNPDaOQS08O1LTxdW4ulv1BeSF68CptcZQBBIXfDEJjw+xwT/GrTxMgn2LHSgI0
         9E6tDq2KLIF9Pn0rkpaANrbhDwdFKaW1Tv/PttcUVhxkVv3KMTFocA/FLIU9rPVFBmR8
         tsSxwfPhp8aLU2MARzEB3V2ULqZ4AGEdDRrutFPNaRsvNad2MeN1KGiQivMtlgAcq2nt
         5RX35hb4Qbj77NCdjGNH5uZPsK/+LxPXX95yaebn51HR1WQTciOrvwVKq/Wz6dK4Jc1J
         Lse96qXtW5hQMf+ZTSaEC58GfavyxPK2KjAiJWiWO/q2xLHCe+lDWhtu/+BdJ5HOKh2e
         Uknw==
X-Forwarded-Encrypted: i=1; AL+hErFQ1lPSf3jfKH5x9i/yr7Osu1yckS43/CyoCXAmC3H9c/LgAPv4Hlq+Eqb6tm/tlugnZb66UjH3axot@lists.infradead.org
X-Gm-Message-State: APuU4Z9FYir7Quulo8Jfzkf32vIlx7yLFXENVRS/gDXbXm2yE0saeZVs
	xc3GjQAgyEsQCe9dE79jq6JL1UYzqYHSZ/vb3QSwEhEWn5nIazxWl2qg
X-Gm-Gg: AYBFou0d3zPyV8+OxkAF9t4Z8gQGFL2pwX/xj+aYOHxFiwnv2Z0cgoUWVxU1vof5lqE
	drhpzBRUFltLSv4Z9suM73zJisVRLuk5I1C9lMSILtVFk2OvAv9AH28QgoXlXVmm2XLzivW5zcG
	dA/d9bXzJewd2RkjsicbbFQXXjJ783ypLuX9k8S4saclXoBHgbvnwRNjeJ8jdiL1sAzSmEsrKNz
	dpet1Nd+BvK3P0tlGtxs2B5j09siZrWaFg5d2HdPOU0Xxvj3I+FTXZtPFSSMEs51D3xh5TXcRrZ
	PQZgDuxBnFYN8FZISJOE32Fbd1egnaEMtS9FAEys4IEUWBm8GA7vyc5MHINEgrgajzW0/wov2TS
	21/5r0AOkyQBFJzD36kHraaattLdI7au1Qdcd2v8VjQZ4GP1/Zwr6jdPfX4+G9Vvf+mNL1ha1hb
	67doloB6Hxjzw3dVkn3M+q6zrb0Oh5X/S0SQCNcfNARM4u62Eheh3zKnzkRCDH3ShSpGr22L0Ep
	nkwE8U4GY1qpHI60S+guSsygNeEECYyomUc8Mx0FCHXMAGDg9fwvB1EzF55JpGQhk1xwLmKyM8+
	JxjFvyl4LY690Lz5ylJBy0EyraOSPy4Zopg=
X-Received: by 2002:a05:690c:e3ed:b0:8a0:76e8:c738 with SMTP id 00721157ae682-8b36c664b7dmr25866737b3.0.1794226443428;
        Mon, 09 Nov 2026 04:14:03 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b95cf4bsm3720905d50.16.2026.11.09.04.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 04:14:02 -0800 (PST)
Message-ID: <7f9b7ab9-9728-42be-a5c1-9e8e62c23ab9@gmail.com>
Date: Mon, 9 Nov 2026 07:14:01 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/6] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Daniel Pereira <danielmaraboo@gmail.com>
References: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
 <au5JP__7P_PzwDUe@krikkit>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <au5JP__7P_PzwDUe@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_041405_488033_E4EF0287 
X-CRM114-Status: GOOD (  26.65  )
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

Hi Sabrina,

On 11/6/26 16:40, Sabrina Dubroca wrote:
 > I'm on a medical break so I won't be able to give this a proper review
 > for another week or two, but since it keeps landing in my inbox, I
 > want to make a comment.
[...]
 > So this is kind of a "can we slow down until we agree that we
 > really want that?"

I am sorry to hear that. I hope you feel better soon. There is no
hurry. I will not send a new version before we agree on the
direction.

 >> kTLS does not currently handle TLS 1.3 KeyUpdate. It never sends a
 >> KeyUpdate.
 >
 > Because it isn't meant to handle any part of the handshake at all,
 > just the record layer.
[...]
 > So what you're proposing is a very fundamental change to how kTLS
 > works, I'm not convinced we want to go this way.

KeyUpdate is a handshake message, but it changes only record layer
state: the traffic key and the record sequence number. The new
secret is one HKDF-Expand-Label of the current one. Nothing else from
the handshake is needed.

 > If userspace libraries don't do the right thing, we can fix the
 > libraries.

I agree. The main users of this series are kernel consumers:
NVMe/TCP (host and target) and sunrpc (client and nfsd). They have
no user-space process above the socket. tlshd does the handshake,
hands the keys to the kernel and exits.

 > And that can't be handled with the existing handshake subsystem?

Not without new problems:

- A handshake daemon cannot write the KeyUpdate record to a kernel
   socket. It has no file descriptor for it.

- NVMe/TCP sets sk_set_memalloc() on its sockets so that it can
   write out pages under memory pressure. A daemon has no such
   guarantee. With root or swap on NVMe/TCP, the daemon can wait for
   a page-in from the queue that waits for the daemon. An upcall or a
   reconnect every few minutes makes this deadlock possible every few
   minutes.

- The traffic secrets must reach the kernel in any design. If each
   consumer does the KeyUpdate itself, NVMe/TCP, nvmet-tcp, sunrpc,
   nfsd and every future kTLS consumer need the same state machine.
   In kTLS it is one implementation, which user-space applications
   can use too.

 >> the 2^24 limit can be reached in less than 10 minutes in many cases.
 >
 > My math says that's 28k records/second, it's a lot.

Storage traffic is different from HTTPS. The NVMe/TCP host sends one
TLS record per command, and a 4 KiB read is a 72-byte record. The
record count follows I/O operations, not bytes. 28k operations per
second on one queue is normal for NVMe. I measured one queue reaching
2^24 records in about 80 seconds. Connections stay up as long as the
host does, so even at 1000 records per second the limit comes after
about 4.7 hours.

Without KeyUpdate, the consumer must reconnect at the limit. For
NVMe/TCP this tears down all queues of the controller, stops the I/O
in flight and repeats every handshake. NVMe/TCP is storage for
critical systems: databases for banking and stock trading, AI
training data, and systems that hold personal data. These systems
cannot reset their storage every few minutes.

 > I'm not yet convinced this is a strong enough argument to justify
 > changing the model under which ktls operates

RFC 9846 4.7.3: after a KeyUpdate with update_requested, the receiver
MUST send its own KeyUpdate "prior to sending its next Application
Data record". If a sendmsg() or sendfile() is in progress on another
thread, nothing above kTLS can stop it before its next record. kTLS
checks before each record.

 > Why does this need to be a socket option? It feels wrong to use a
 > socket option to trigger sending data, why not hook on sendmsg()?

I agree. I will remove TLS_TX_KEY_UPDATE.

Martin

