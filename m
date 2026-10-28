Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28E606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dXHu/R0a;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmeJYntv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=; b=dXHu/R0auxiNFh
	0Pi/ENhDg6yqA0s7wGNS457AxgyqHJcR5RkmciORj+b9fqdU/j2YQbNm/4unWzXDqvfE8j+e+nc/Y
	FtfQ3+YB7tN4y7iLoZEFXdIrsrA6Spt0sKaaPEfGRyITXgmAf/b0W+omgfwtaX/26IZ4HuxqWQYBh
	H+CPhpK9OVrNXDppK8afcOq7l3Wbaq/5Z0YiLTk7+7xrLJU5VSr94vEhSV/ZRy5cXGu2nCb7d0rn8
	3+qjEfdUYFk4BmqWTxIln0VuGR0xbgLYiNwKOUmbe3gH6r45w1Ab/fVDDrbGagepQ2ldOBZagCsch
	msFLRiaTDPGspFbve7/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5Kb-00000007JeI-1DeO;
	Wed, 28 Oct 2026 15:12:49 +0000
Received: from mail-yx2-x08.google.com ([2607:f8b0:4864:41::8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5KY-00000007Jdi-0TmB
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:12:47 +0000
Received: by mail-yx2-x08.google.com with SMTP id 00721157ae682-8b1809cf49eso4914127b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200364; x=1793805164; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=;
        b=XmeJYntvfYPaDs0RdrJvhRg78Oi+Y75VyWI6jzNgpQmcopR/fThX9kysCW8WS9JUk0
         WYPSRySk3aaPeEiEa5TEbCpJ3BiZZEuBmqskAEPvk/R2yIR5ceXBOyC9KksOQeK3lEh9
         2DgqTs6s71vWnIMJYd+gYFNCSiZScli4VAIMzG193btm/quxdvPyUKPtnT+xv1rZOsp1
         MXvIz+QeOtj4LtJ7Ae6+NjJwpuN3087nZXfdJRadgBjmEECw2Kfzc1Cg6zHaFAmE6U0K
         xZ3ToTITEInZJ46GIxwOv3lMQK7KuQrL3FmaANQm4z0y38pEKloGAf6U4wC0MA4VU+NY
         ihfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200364; x=1793805164;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=;
        b=aPBoBSo1hooqFjuYbCm3f4kLOAZMEm/No0CC7O1mZVmJzuR3H3ftGA8AzXbgCvcq2d
         +BzLHTKMm6ciaYVvnpoZ7QwNmbYZ0aFFq4o4bzHTrOPfwwym43kbZRkNTK02a8KB+qi0
         qT8IjK995KPLYHHEGHy1Rk4+Ax+vqLIP2Afh14Y1rx+MH4+OSG0dksNGamJTSMnJ+Xe1
         oi1LB4vqD32ZZaf/G2N2+kUc+gCJTI+YH1KUZGO0hj5gl6q884+LrU3imNlT42XWv5aT
         HqJGAszzoOHhyDNmtMiGFGelV1Yc2NiPfguNXDKZZAJf6i7r9+VF43vQWnDgcLSZx1b2
         IA5w==
X-Forwarded-Encrypted: i=1; AKwUvBxktiZEsRKCglreM15J6hFenrP7+VJBp10lTTLtY00fIj3ryvleEvDB5cJ0SS3kt6PqLW/mPn4QFod0@lists.infradead.org
X-Gm-Message-State: AFq9FYISUozCeMVcVr62uEiaiQ1JyttHJEVuQUlOIh9d9PVdX5h1u7vk
	FSW70oXKteIYF0A7cBB4BeFh8TowDe+0usw4pN27xsAtWqGvnuDPjuVJ
X-Gm-Gg: AYBFou3TLcT0ycyph7Oej9TXeV0RsARmqTBLpiPGRt7SbY3+Jcv6CHtCVJU4yDinPgc
	Zp4erX17QIhk0XUwgfW4nIjZDryG5c3VGn2+t6d4SSMpcY0AKg/lyQDCRW21PvWZCtkmBRlnb+T
	4t3RIEgcPN/ulMyWlmWFP4CEJ5f8rhTtrr0/sz9+M7R0JjmbrFUxTqdQX1ISD09U2NOsucEA1d/
	KsT7qmZSmy6DFn7odpDg91VMJ2QAtXbDlGheH8z85TDkRfadgoZ4itjHZtttmh4Irh+cKWG3qB4
	3pTpuSPRes9PfEp93uP8Ud1CRBRBESTKdBvlcYGVhcRh5/NtceZZWw/GIX7xlWcRXRkCL3Xf5Qz
	W3u16qdUKxeRM/Pie7LWKDPc1g6ZdbxzptmL5yLXOWcmgCpq5i6itgKZmPg3QOyYdwjDg40lbch
	Bwhg7wi0Xtn1GU6YGzwBN2/m+CWhkZ4dgB8en2iBCeizQDXZDb6/A3CmT0waeG+WYehOlyjMOgg
	qFw1FeHEjGuCjffIn6pBOqyrx1ubfXfZWSUs5xPH7/3hVQFjEtgZW+DRXYk649ZEeGpqyevxRAd
	jM+hrNSlZ/ANeMdtGEZ5mltKL562ebgqtig=
X-Received: by 2002:a05:690c:386:b0:8ae:dfee:cd30 with SMTP id 00721157ae682-8b1b5b457ffmr18430047b3.56.1793200364364;
        Wed, 28 Oct 2026 08:12:44 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e539e34sm29934517b3.9.2026.10.28.08.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:12:44 -0700 (PDT)
Message-ID: <e674379f-819f-4334-99b2-7b8dfc89d1a0@gmail.com>
Date: Wed, 28 Oct 2026 11:12:43 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Chuck Lever <cel@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
 <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
 <CAPG1HMsnUDa=Q5O4fwZOU=Pd+m7ahzu574Cs+mWoB_9KUT5ASA@mail.gmail.com>
 <097a2d7a-af80-47b0-b800-238396e6e662@app.fastmail.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <097a2d7a-af80-47b0-b800-238396e6e662@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_081246_183860_7555BE8A 
X-CRM114-Status: GOOD (  15.62  )
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



On 10/28/26 11:01, Chuck Lever wrote:

> 
> I get that dropping the connection is bad; the current weak-ass
> implementation is meant to handle KeyUpdate until we have a proper
> spec-conformant implementation.
> 
> My concern here is if the current design is malfunctioning in LTS
> kernels, the only mechanism we have is to fix it upstream and backport
> the fix. I don't believe stable@ would be happy absorbing this full
> series.
> 
> Your commit message claims the connection stalls rather than getting
> replaced. If that's true, that needs to be fixed before this series
> gets merged. Can you confirm? I don't expect such a fix would be large,
> but the ordering matters.
> 

Yes, for nvme-tcp. Since 6.7, tls_sw_read_sock() returns -EINVAL for a 
KeyUpdate record. nvme_tcp_io_work() then stops without error recovery, 
and the queue stalls until a command times out. Only the timeout handler 
replaces the connection.

The fix is small: "nvme-tcp: start error recovery when read_sock fails". 
I posted it on Monday, and Keith applied v2 to nvme-7.4 yesterday:
https://lists.infradead.org/pipermail/linux-nvme/2026-October/066937.html

The queue now starts error recovery at once and reconnects. It has no 
Fixes: tag. I will ask Keith to add Fixes: be8e82caa685 ("nvme-tcp: 
enable TLS handshake upcall") and Cc: stable, so it reaches the LTS 
kernels before this series.

I have not checked sunrpc. Does xprtsock replace the connection when 
tls_sw_read_sock() fails, or does it stall too?

Martin

