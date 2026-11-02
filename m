Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C65606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=D7nvAw2q;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABefyPq2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GGgFPYYG6oWLUvP1KotHDJ9Xw83iP8ii3ww9kM3hKP0=; b=D7nvAw2qF4iiPH
	7oscKnBKcJVEvcnT5HDMURKhbwdXs93+TUfSCU0gV70sPmDw4H/FWvpPCMaFSC90/H1ins2UuHtiW
	E6usriYoB+mj3J5CNxqnyLIw+6NSBkUbXzfDPZBS3EEooj3+3ZeXdLm/yRoMmyTvgxlQd4e7zLt3G
	cf88kTvA4t6YvONGEr/he9etrc8ps/trUwZ1EfVb8aANVs5ocJUYTg5UxMvMHLbGep34AYrD7UaCC
	MHQVJ04vcmwSrRer6r6aPWuz9NodjAwWIb1DlafHKMskOZHT9s1hRPYafooKui1QR5BtgsAzWCbYV
	0ARgH0fGASED65/J62TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNxgC-0000000064m-3aey;
	Mon, 02 Nov 2026 19:26:52 +0000
Received: from mail-yx2-x01.google.com ([2607:f8b0:4864:41::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNxgA-0000000064H-0Axx
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 19:26:51 +0000
Received: by mail-yx2-x01.google.com with SMTP id 956f58d0204a3-679a254a724so1824384d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647609; x=1794252409; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGgFPYYG6oWLUvP1KotHDJ9Xw83iP8ii3ww9kM3hKP0=;
        b=ABefyPq2XSPrMK4ade+xViq5V00C+eBcRKPJTV2hTCT/OSjvk7g7cL5QqNsA82geb1
         gq+iVxzHL15AklfANSyzUM8AK7MVyo5lxZVrF7YD2lJ9d+Ogl9y6ffu5JyCG9WnxISvW
         iYSUSuNzHSxiLum6K+QTnX9KymCEkJwIKUKalP9IFDCgWALF/K7M9UbtQ4du1xinOZ7s
         TaFnsYyAdzWUhLpmClwmTqN7SuQbWWkvO0g5Vkn888S1NH1xHeqGM7HoQG/wgkR+IFs2
         jvi1qp/AkmKePk2EYvyHXXYyysUG/eFymPgC59i7kNKusK355+z+v1bFt3buMq5SfQTI
         Z44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647609; x=1794252409;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGgFPYYG6oWLUvP1KotHDJ9Xw83iP8ii3ww9kM3hKP0=;
        b=IUznbuFwuQmqxQyyIigEOxSuu7PCRLrxplmILXv2PotY83C1s4/NLJWVwKRqGAIsQ1
         ibG/vB3GlETW2tDEttsjRL3TfbaByHNI65kfCxWIM+IOhCYKAhsWnlxfClhotV7bsBLN
         5D0+imHHMtvHJWEoR6q1vYg+PbnnPzSWboPS7U/w91+MMWL25LSEjy1viTYmOm3Nsg10
         A9bKqcXNasyJCbpX/uMoveMRHvuVFw2tOrVRRsO9KF5lLIneyRRbK6YaTDt7e5v3uD9L
         /RobZtLmmZF4ceqfvzpTIemjaHXDjvaayAf5AOz0NYIJFmDdFa/eezrvo7aDVdX0UW5+
         sSFw==
X-Forwarded-Encrypted: i=1; AKwUvBwUxYF8NDnRb7B5B6tbi0iAVjFo3BZcD1yTQ1rBf55y2PuCHW36kdBiC/qWe1hmqww3Nj2tMnncX/mI@lists.infradead.org
X-Gm-Message-State: APuU4Z+GmWH4bhFjh06POw0HI4y/Iev/bVmvUaTcbhb4CVmfDs7GpMeb
	2oJWFA8lO51aIPuA3KwXMWjHnq9n/UDMQOB2/2yuo0rsHGuZ0Zu8+WgS
X-Gm-Gg: AYBFou3KPivlLPLTLTz+FKd9mXyhAtwetklwxJIUAQTPnNhApIY7lC1PSMmuC9ylZi5
	F6c8ZjPRqX/xa+OWNIgEHkpMqylDazoSCrqZmZ0AlorGd76cxqDsBJ4vperO+TD9/tAXnmizN0z
	ndl/GkjpsdwbLURhn5Kl3G5ocGpiq+m1l9pjhwxc9AY2aJMsmUejCQNin3O1FGs8n6v+oK2VEQk
	kRlE6rqlDj+AP1t/Iz0bCE87+jFk+DdTLJwN59aPqOz3G3i84j3L0MQrp8EOLnXsXUtpRrKfU0P
	nmcCX9ynoXjQt9c8vlqZOL5xKBRHJX48nN2i67V9eEDiihqi4SKZkiO0Tax8bYnxUpamzv8Krdx
	6hkCbVj9saHmhby/X9fMJ8BZBJWFpDhwv76MgR5nivn41wbFwjwMnU0+uCWb423aHszmDQp1cka
	poFADhRLiSzCvXoSU7IrdCbCNFF4fIZM3ZqhhueAt4M9MYda0RdQ3Zu3vgI0L789upmcRoikHMA
	8CTR4zM0gvJLmh/aJdEdL+MSkow0CoduMZ5aaB41fy4jfnmgPB0V7Rg4H6hTWHqjCOw0KQpWlF9
	/LJ7XdoKV84VSbfQESCNJXQRK3zprRHm53s=
X-Received: by 2002:a53:d148:0:b0:679:93bd:85ee with SMTP id 956f58d0204a3-67ba4ffc1a6mr6007860d50.39.1793647608751;
        Mon, 02 Nov 2026 11:26:48 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3700b8sm5719489d50.23.2026.11.02.11.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 11:26:48 -0800 (PST)
Message-ID: <d39dfdac-e0e3-4c42-9a55-fbcef6806d77@gmail.com>
Date: Mon, 2 Nov 2026 14:26:47 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Chuck Lever <cel@kernel.org>, Martin Belanger <martin.belanger@dell.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>
References: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
 <785aa669-8229-4909-ad33-66f0824687bd@slotpi15m67>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <785aa669-8229-4909-ad33-66f0824687bd@slotpi15m67>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_112650_100742_3B0CA77B 
X-CRM114-Status: GOOD (  19.26  )
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/2/26 13:24, Chuck Lever wrote:
> On Mon, 02 Nov 2026 11:57:57 -0500, Martin Belanger wrote:
>> The matching tlshd change for ktls-utils is a small patch to be
>> submitted at a later time if this series is accepted.
> 
> Recognizing that there may be further API changes, for the series:
> 
>    Reviewed-by: Chuck Lever <cel@kernel.org>
> 
> I don't expect any changes for the sunrpc consumers will be necessary.
> For tlshd, as far as I can tell the whole change is:
> 
> - In tlshd_start_tls_handshake(), register a callback with
>    gnutls_handshake_set_secret_function() before the gnutls_handshake()
>    loop, as quic.c already does. We rely on SSLKEYLOGFILE to decrypt
>    NFS traffic in Wireshark, so that needs to continue to work.
> 
> - In tlshd_initialize_ktls(), after the existing TLS_TX and TLS_RX
>    install succeeds and only for a TLS 1.3 session, set
>    TLS_TX_TRAFFIC_SECRET with the write secret, then
>    TLS_RX_TRAFFIC_SECRET with the read secret.
> 
> - A configure.ac check for TLS_TX_TRAFFIC_SECRET in the installed
>    uapi header, so the build works against older kernels.
> 
> I assume you plan to send tlshd patches, but let me know if instead
> you'd like the ktls-handshake folks to take care of this.
> 
> 
Thanks for the review.

Yes, I will send the tlshd patches. I have a prototype, but it uses
gnutls_session_set_keylog_function(). That replaces the default
SSLKEYLOGFILE writer, so I will switch it to
gnutls_handshake_set_secret_function() as quic.c does, and add the
configure.ac check. I will post it to ktls-utils once the kernel uAPI
is settled.

Martin

