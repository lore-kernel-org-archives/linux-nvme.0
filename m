Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7937C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gditj3pIK4QuzcqOW8qGUvUL1/lFL5DV7yQpng/n4Bg=; b=NeI2zmS/X6tgB7BCQ7VCaQms+h
	g625n8MxvMI+aAYdOFfWwquXMdnmVEI8Xg5R21KwwvQYGrrPrNJwY/QWnPgQRV0T7Rg8MXw+rUfeU
	v4dt1l3dyb+MQi9sXwW/OUx8joTK9nIAcbtDrX020zGUBRZAKNFg2bVOUg2TTBvWMJvA1Zs5zuFwS
	CbKC1UtMBZ+Y/hi7Ja6CH3YKTEu8+C2nuVTPABbHDJ1pWWEw7jtTfivox+6t42Gqj5P7NIQ8b83uz
	Ns12iBcY5B+lGKFNvWOd2VMdJs8dUlA40/cRbKqasP7Mxn0lrziwRHoLY0suDhtQDwdzrlZKuDlas
	GF9sFIWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njzq8-005ari-6j; Thu, 28 Apr 2022 08:49:32 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njzq5-005aqx-Eu
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 08:49:30 +0000
Received: by mail-ej1-x62f.google.com with SMTP id i19so8105924eja.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=gditj3pIK4QuzcqOW8qGUvUL1/lFL5DV7yQpng/n4Bg=;
 b=SmZEqrKEzVcD/2dBQBE39Ir32WYWyyv0LiXdMOEk2y91yqcjv1JRy9jecPoHlk3Mse
 /p7JZ8A3RIZwyXmD4gccsFRmWfxQc8OjeDRQk7WQi2I4CZpsjNphd1NMriagdl9lCklS
 Sq3j6xpZ481R5ZdFCD7Kgs7+Suid8oKytyoWTmrM1Ul+2cMyqkE0MkJcSYwK46+tO3hz
 yPQDT719L4Aotjyc4mV5MrNA37dM5Px1ffA2YqesVpleJS5B8B3m/BCgSNQNilyZFD4P
 6qoLuxTMp2dYZUTQBtB08izby3FMSG/cS+YK8Mogr+1TIsh7pQWvo2YLf6NK4/NoLgHL
 S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gditj3pIK4QuzcqOW8qGUvUL1/lFL5DV7yQpng/n4Bg=;
 b=uDu86eCx/RkwyElkFlKlqzF43IXUrr9I9fmCkmgwc4cTpMk8O0zE0W0jmU46++snvW
 ZEHSlRbFqF8zvCWN8/Dy712zhJAGuCcMxMtwBJNBT9tNmg2E3KttSQmG8yG+siA1sEzQ
 w+RtRbCDUOApSJLoaA8xw4OIpdJlkO1VFMQdhIaMbSLRZ2cb8H1E9RT1rD3P9IzuzuQY
 YMeQ6LSIQTN9B7Aa0AYUdXQHcb/zaryhdCJhNJr9TLylncG7IwmQLTa+d12XDxQs9eBx
 MRQnECp4PrDoE7nkKq1knppRJsWUz5TsIWZg3Y+Ms2kmNRXV6Nez3lddpHTo3iQw7Yh8
 f9sg==
X-Gm-Message-State: AOAM532DJ2d5Uf5tCUEyHI7tr7Mkm7yA+iJ/ImYZcA2MjkCUl/3Xd94F
 e9EX1rw8t3gnUcPEYfHSmhI=
X-Google-Smtp-Source: ABdhPJwh7NCntuLtaQyH1pXzw5R201XZqA2FCHT/035nb8SkKfuoFK92gkdub5ES2IyVmhRVRRQrRA==
X-Received: by 2002:a17:906:99c1:b0:6db:f0cf:e38c with SMTP id
 s1-20020a17090699c100b006dbf0cfe38cmr30591051ejn.692.1651135767166; 
 Thu, 28 Apr 2022 01:49:27 -0700 (PDT)
Received: from [132.68.43.112] ([132.68.43.112])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a1709064cd100b006e78206fe2bsm8193855ejt.111.2022.04.28.01.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 01:49:26 -0700 (PDT)
Message-ID: <068945db-f29e-8586-0487-bb5be68c7ba8@gmail.com>
Date: Thu, 28 Apr 2022 11:49:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS handshake
 listener)
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: ak@tempesta-tech.com, simo@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
From: Boris Pismenny <borispismenny@gmail.com>
In-Reply-To: <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_014929_550033_EC9B8AA6 
X-CRM114-Status: GOOD (  17.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18/04/2022 19:49, Chuck Lever wrote:
> In-kernel TLS consumers need a way to perform a TLS handshake. In
> the absence of a handshake implementation in the kernel itself, a
> mechanism to perform the handshake in user space, using an existing
> TLS handshake library, is necessary.
>
> I've designed a way to pass a connected kernel socket endpoint to
> user space using the traditional listen/accept mechanism. accept(2)
> gives us a well-understood way to materialize a socket endpoint as a
> normal file descriptor in a specific user space process. Like any
> open socket descriptor, the accepted FD can then be passed to a
> library such as openSSL to perform a TLS handshake.
>
> This prototype currently handles only initiating client-side TLS
> handshakes. Server-side handshakes and key renegotiation are left
> to do.
>
> Security Considerations
> ~~~~~~~~ ~~~~~~~~~~~~~~
>
> This prototype is net-namespace aware.
>
> The kernel has no mechanism to attest that the listening user space
> agent is trustworthy.
>
> Currently the prototype does not handle multiple listeners that
> overlap -- multiple listeners in the same net namespace that have
> overlapping bind addresses.
>

Thanks for posting this. As we discussed offline, I think this approach
is more manageable compared to a full in-kernel TLS handshake. A while
ago, I've hacked around TLS to implement the data-path for NVMe-TLS and
the data-path is indeed very simple provided an infrastructure such as
this one.

Making this more generic is desirable, and this obviously requires
supporting multiple listeners for multiple protocols (TLS, DTLS, QUIC,
PSP, etc.), which suggests that it will reside somewhere outside of net/tls.
Moreover, there is a need to support (TLS) control messages here too.
These will occasionally require going back to the userspace daemon
during kernel packet processing. A few examples are handling: TLS rekey,
TLS close_notify, and TLS keepalives. I'm not saying that we need to
support everything from day-1, but there needs to be a way to support these.

A related kernel interface is the XFRM netlink where the kernel asks a
userspace daemon to perform an IKE handshake for establishing IPsec SAs.
This works well when the handshake runs on a different socket, perhaps
that interface can be extended to do handshakes on a given socket that
lives in the kernel without actually passing the fd to userespace. If we
avoid instantiating a full socket fd in userspace, then the need for an
accept(2) interface is reduced, right?


