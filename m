Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED77C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 21:01:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF10D2054F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qdyMjkXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF10D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gu7NY56cGlktZx0Zk/zm93o2uihLhh2kR0mz9K2hVAI=; b=qdyMjkXroR6V/5
	6ksyPwTWkVxhnY2X1mIXykYQND209HF/oflyTvBK1OJQJCaAX2a89DyesfuycuE/MP8UIprwO0Vn8
	ogY024BT+WfYAeMgUDqrAtYhADX2Kzu/nrXW4oL5LqUKcAL2/ffwWnWCeQ7a6Mo1z8wwCs+V6mK8f
	8KvLxkQ1V/zheTUx4HIa29C7MOLyL+I2NjIgwdpMnUuHKHji1mKBf4/ZKa2B7nyCgd36Iru8WIO74
	xfLIFinGiUnj6WPFsd5FyZ7S+X74eW8hiwlgTgtBICDFPAj+KOkucPPnD9SJ+OBsRdq5yhJoqcRTN
	gB3mG8sc11cLcpT313gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYyUn-0007zX-QI; Wed, 13 May 2020 21:00:53 +0000
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYyUl-0007uc-5L; Wed, 13 May 2020 21:00:52 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id CA6F0182CED34;
 Wed, 13 May 2020 21:00:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist41_5dde648048f06
X-Filterd-Recvd-Size: 3554
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf01.hostedemail.com (Postfix) with ESMTPA;
 Wed, 13 May 2020 21:00:44 +0000 (UTC)
Message-ID: <0ee5acfaca4cf32d4efad162046b858981a4dae3.camel@perches.com>
Subject: Re: [PATCH 20/33] ipv4: add ip_sock_set_recverr
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Date: Wed, 13 May 2020 14:00:43 -0700
In-Reply-To: <20200513062649.2100053-21-hch@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-21-hch@lst.de>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_140051_274683_7C35C332 
X-CRM114-Status: GOOD (  13.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-05-13 at 08:26 +0200, Christoph Hellwig wrote:
> Add a helper to directly set the IP_RECVERR sockopt from kernel space
> without going through a fake uaccess.

This seems used only with true as the second arg.
Is there reason to have that argument at all?

> diff --git a/include/net/ip.h b/include/net/ip.h
[]
> @@ -767,5 +767,6 @@ static inline bool inetdev_valid_mtu(unsigned int mtu)
>  
>  void ip_sock_set_tos(struct sock *sk, int val);
>  void ip_sock_set_freebind(struct sock *sk, bool val);
> +void ip_sock_set_recverr(struct sock *sk, bool val);
>  
>  #endif	/* _IP_H */
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 0c40887a817f8..9abecc3195520 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -589,6 +589,16 @@ void ip_sock_set_freebind(struct sock *sk, bool val)
>  }
>  EXPORT_SYMBOL(ip_sock_set_freebind);
>  
> +void ip_sock_set_recverr(struct sock *sk, bool val)
> +{
> +	lock_sock(sk);
> +	inet_sk(sk)->recverr = val;
> +	if (!val)
> +		skb_queue_purge(&sk->sk_error_queue);
> +	release_sock(sk);
> +}
> +EXPORT_SYMBOL(ip_sock_set_recverr);
> +
>  /*
>   *	Socket option code for IP. This is the end of the line after any
>   *	TCP,UDP etc options on an IP socket.
> diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
> index 562ea36c96b0f..1b87b8a9ff725 100644
> --- a/net/rxrpc/local_object.c
> +++ b/net/rxrpc/local_object.c
> @@ -171,13 +171,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
>  		/* Fall through */
>  	case AF_INET:
>  		/* we want to receive ICMP errors */
> -		opt = 1;
> -		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
> -					(char *) &opt, sizeof(opt));
> -		if (ret < 0) {
> -			_debug("setsockopt failed");
> -			goto error;
> -		}
> +		ip_sock_set_recverr(local->socket->sk, true);
>  
>  		/* we want to set the don't fragment bit */
>  		opt = IP_PMTUDISC_DO;


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
