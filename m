Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF6C54756
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=; b=hz3EuuhiuQilPbzhgkD4rIKRz1
	8X9QgZldW8izt3KwbUdPSXeyGFw9Or1MNnXZyYwAtlUg61yug3Vq80azqqPo0zsvGyYna2UYxUQIZ
	GvM6oeV8PHjxJDKqM023Z/LweX2I+V7DtBMMHuYVRD1SaW9BWZYyy12qHpUHEuAbxJiQRBPxwlhs+
	LyBr4M9KQWB2eui24OSFSxNjIuDY6A3Zv1H9/5wgpHlDfhAT5cwi4c3MwkXaB28LqK2EaoqLJFNvY
	vvObo51zoXPVmoMcrqMBX4nBnDiM7GOy9mfp9fbLbV1+5TuzJK1VYZk2q1uH4ePKIokCDc3bNLnb1
	yb6K/+oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI1m9-00000000OjQ-2xc3;
	Thu, 22 May 2025 08:59:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI1iV-00000000Nk5-3R8e
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 08:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747904153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
	b=Plt04XWpD0bB8dXYd4QoNbQDF4AgWT6uIaeogpiXA9rEz52Hh5ep5OgQKVWcixMJ/+f/zW
	du/U3k/x5CODoR/41rwec+6SabIIeWnx/QMuATan/L+mZFg65/F4C33pizSenqVh7wewL8
	fFgU5gEOFQBoBZ8MMYY5JIZO146pjp8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Z4qElcR2MmqdelEi1Gt1qw-1; Thu, 22 May 2025 04:55:52 -0400
X-MC-Unique: Z4qElcR2MmqdelEi1Gt1qw-1
X-Mimecast-MFC-AGG-ID: Z4qElcR2MmqdelEi1Gt1qw_1747904151
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso39789385e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 01:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904151; x=1748508951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
        b=aEdAlongBMywJC1LEZhjqBInaNVo6xhS+iRr0EKywKO6RRZpwRDPQdaJDPOlInax1V
         yh8xbC19pY+NvS5LXd1G4xtV9sfA/KXZ1+QKHboIFWNvTFGDd64EjauW32UlEh9yehMZ
         TM6hZUuLKMryk0xUcsn7jaIQrb5ugA3qq3pvEv0f4y3RqBp8TSEI1DopT0I5QWRwP0x7
         HfsG8GHysqwj1Y1nLYCWENQMgY9OhxA5+NX2dMvpl5tYg1/6b3Y9R1xXLNND+XJol4K2
         yewktGwuQ3EhG/YQE6Msj3evoSibp0oSrWNa3kh3RluofoPDrwO/CgTpnKRkpMbHpBOx
         aybA==
X-Forwarded-Encrypted: i=1; AJvYcCXo/nMFjteMvWtOh4XIjdCx2PB7Wpx6R05UVBSsAlJkVwz/8VH2o/zCckT25xDRessfavSTJPwKrYRj@lists.infradead.org
X-Gm-Message-State: AOJu0YzRdyQ7MvjSsfB1L/GyWT9Jfqi9YQ72te8TfErFjLzOQCTi4SBD
	vixGlHQe9oNWoPVj28mG0zoKYB/wHMvqP3qlxdINWpeETHzHbjTv4Ho7YkN4isgmgaQd0OYFsgs
	IC5PW/z86L6nlvOeV39CJuF/db+01DUDSql7Qt5BY9zNMMMCVnvIu0pACRY1waYxZraWm
X-Gm-Gg: ASbGncuxUoXaqi4JU1BjphGjaiBEb4zsJNSuz8WPrLCLhcW24y5A4gNEd+V/SCAr/jh
	34wRIPpPkM+wUM4uDxqz5ni1Fsz2IeX8Z/yyTomyMy9AebFlseqz0mNzL6S0MbOiwAhtaa+ubTJ
	WX8WTMxnmahSmezCg24Fy1c5dSWh1KfDm1QygHQuLRW03yrLgQZKNJjuO7AwsaoND4COf5acyKx
	L7haMt320yaZPRO4lz3hsol3gR3jWgck3NsPYb7TffkJ8ra8/LgNBY+DqmB7tVclYzgPS4srtQT
	RKLlgDFODqSNSpKt9Yo=
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238685e9.13.1747904150758;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZWLfHYdYPfwzdbwFycNAp7aliAoZubbXRRwKwS5IPvqLZEKoM1L6RvMRd6G8MB4cd63apg==
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238455e9.13.1747904150355;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm99616195e9.19.2025.05.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:55:49 -0700 (PDT)
Message-ID: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion
 except for net/rds/.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Matthieu Baerts <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-5-kuniyu@amazon.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250517035120.55560-5-kuniyu@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eVBJ-OQP-LpiNJehmS4dsydWpKAD7QoQBi9DhhAV9n0_1747904151
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_015555_944078_3EE2505F 
X-CRM114-Status: GOOD (  20.31  )
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

On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> count the netns of kernel sockets."), TCP kernel socket has caused
> many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have
> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> 
>   __sock_create_kern(..., &sock);
>   sk_net_refcnt_upgrade(sock->sk);
> 
> Let's drop the conversion and use sock_create_kern() instead.
> 
> The changes for cifs, mptcp, nvme, and smc are straightforward.
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call __sock_create_kern() for others.
> 
> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> sockets.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

This LGTM, but is touching a few other subsystems, it would be great to
collect acks from the relevant maintainers: I'm adding a few CCs.

Direct link to the series:

https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 37a2ba38f10e..c7b4f5a7cca1 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
>  		socket = server->ssocket;
>  	} else {
>  		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
>  
> -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> -					IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> +				      IPPROTO_TCP, &server->ssocket);
>  		if (rc < 0) {
>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>  			return rc;
>  		}
>  
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);

AFAICS the above implicitly adds a missing net_passive_dec(net), which
in turns looks like a separate bugfix. What about adding a separate
patch introducing that line? Could be in the same series to simplify the
processing.

Thanks,

Paolo


