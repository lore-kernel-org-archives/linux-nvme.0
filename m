Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8675BC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174E1205CB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSTFbW4s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgheQSt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174E1205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DYRtIc+S2TLvSra6skmVZzoPhbLmv6xrd+yk1vhpBgU=; b=TSTFbW4sx6tccg
	h+rbLGSHQOjQlV9DUSPyz7fNOOx1C9aGYSlDrp1UJ76I/9k9JvGDEu8p5w2CwqDnUV+iP506UUOyw
	FC62qR5YwIZNVbs7RzL/kLv6MMnrkcx+Q0aD7YUaDa5h4zuWu8nAT9wXAfISDdqcKpgbTOPFHVj7u
	CoYP/wNvlfRxt6vmpHCYd3A6fSkpyuCf5U2vGN2SDYc++CmQaypI+vSDTOl1Y+GQKOw2+wF70nLqp
	nfNl9F+wGMzzS6g96Nny1zb8KwJXsl/ACQETLQXj+I7AXU5tOXC9ugYhbAQe9anPuQAHuz5t2KpYJ
	zjE65DQfSq3ZKwU9ip/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYvio-000417-7P; Wed, 13 May 2020 18:03:10 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYvil-00040V-BG; Wed, 13 May 2020 18:03:08 +0000
Received: by mail-qt1-x844.google.com with SMTP id x8so602790qtr.2;
 Wed, 13 May 2020 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3rJSQfC8qhqPgAdT7p7uqG4zYxw0cOP69JvDMu+AmoU=;
 b=rgheQSt1YItEgWJaK+D0bGz+/qHfNOAGsXjdVRWwUQiGqsFIGS1wvoYG+aGTafU+PV
 /Wam8diPaOgVXFRqoqZXtgZpq5ZoS7P+w+jAXFzuJRlWX6AXxlicjH1KtuahsCm7X1oB
 1KM/eHxvJqcmXNEYPF4b+olwDLqfGRmRJKuO8mBihqp1FZjIXqkKRuN4K2fkmkt1KR4y
 BY4TuAPJr9Fm34DqlaEou7vS5F0NmzH1lmiODzJGQ+/eBluPCt8Nwyn9o9iFlcChI8ne
 mr8KP8dnkN8R85f07cGwIMBpujRbjafuA86KSdBGJqLxAx2+yPjgt33/gw2dY8MXvXik
 E3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3rJSQfC8qhqPgAdT7p7uqG4zYxw0cOP69JvDMu+AmoU=;
 b=kheMCKla/0o+LXNg4PGR1PvYquX69ZE/95pYOK/BMrdChgGTYkX6lIY03VBEeSzGq2
 AhlphDa/bPe+WPzH1oaorLgQb8qreVZe7wkk/uCySwS2Nj1YPZXYmOmrnXVLokmVcjB0
 9cwtb5ew1KvJezqWQCnOReIy+CMeSXAH2BGBAGtzhzTjBB/SMyOXruzRHOrCC5wEEp3E
 QvmzLEVH+4H8nlLJ1IJbwzJJmDpLjBhOMgvATNjumdzo3zsLG0YJfA/0XxaEySJ5AcOT
 G1l9aHCIXQ9udjMUCq+omcJsRX2JZneJLkTtgl18amm9OmrlU2r4nZM1cd1yAIVVfzuB
 CEyQ==
X-Gm-Message-State: AOAM532BLm4KN51od2rV3jp8JSHH80CjgIWzYiTt2Dmt5S1WMWpesdiY
 Ep6trGmwQ9EGJiveH+tfNk8=
X-Google-Smtp-Source: ABdhPJxDn2Ym2XNFWojVR75lfnXVzFyakSG9ONLgdWGtZA79aHqlLy1IZQIR41clkG4iLZ4VQYg8Bg==
X-Received: by 2002:ac8:67cf:: with SMTP id r15mr355571qtp.258.1589392985891; 
 Wed, 13 May 2020 11:03:05 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.228])
 by smtp.gmail.com with ESMTPSA id f68sm476350qke.74.2020.05.13.11.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:03:05 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 8AE9BC08DA; Wed, 13 May 2020 15:03:02 -0300 (-03)
Date: Wed, 13 May 2020 15:03:02 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 32/33] sctp: add sctp_sock_get_primary_addr
Message-ID: <20200513180302.GC2491@localhost.localdomain>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-33-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513062649.2100053-33-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_110307_388910_9826CD3E 
X-CRM114-Status: GOOD (  19.75  )
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
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 13, 2020 at 08:26:47AM +0200, Christoph Hellwig wrote:
> Add a helper to directly get the SCTP_PRIMARY_ADDR sockopt from kernel
> space without going through a fake uaccess.

Same comment as on the other dlm/sctp patch.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dlm/lowcomms.c       | 11 +++-----
>  include/net/sctp/sctp.h |  1 +
>  net/sctp/socket.c       | 57 +++++++++++++++++++++++++----------------
>  3 files changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 6fa45365666a8..46d2d71b62c57 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -855,10 +855,9 @@ static int tcp_accept_from_sock(struct connection *con)
>  static int sctp_accept_from_sock(struct connection *con)
>  {
>  	/* Check that the new node is in the lockspace */
> -	struct sctp_prim prim;
> +	struct sctp_prim prim = { };
>  	int nodeid;
> -	int prim_len, ret;
> -	int addr_len;
> +	int addr_len, ret;
>  	struct connection *newcon;
>  	struct connection *addcon;
>  	struct socket *newsock;
> @@ -876,11 +875,7 @@ static int sctp_accept_from_sock(struct connection *con)
>  	if (ret < 0)
>  		goto accept_err;
>  
> -	memset(&prim, 0, sizeof(struct sctp_prim));
> -	prim_len = sizeof(struct sctp_prim);
> -
> -	ret = kernel_getsockopt(newsock, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
> -				(char *)&prim, &prim_len);
> +	ret = sctp_sock_get_primary_addr(con->sock->sk, &prim);
>  	if (ret < 0) {
>  		log_print("getsockopt/sctp_primary_addr failed: %d", ret);
>  		goto accept_err;
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index b505fa082f254..c98b1d14db853 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -618,5 +618,6 @@ static inline bool sctp_newsk_ready(const struct sock *sk)
>  int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
>  		int addrs_size, int op);
>  void sctp_sock_set_nodelay(struct sock *sk, bool val);
> +int sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim);
>  
>  #endif /* __net_sctp_h__ */
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 64c395f7a86d5..39bf8090dbe1e 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -6411,6 +6411,35 @@ static int sctp_getsockopt_local_addrs(struct sock *sk, int len,
>  	return err;
>  }
>  
> +static int __sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim)
> +{
> +	struct sctp_association *asoc;
> +
> +	asoc = sctp_id2assoc(sk, prim->ssp_assoc_id);
> +	if (!asoc)
> +		return -EINVAL;
> +	if (!asoc->peer.primary_path)
> +		return -ENOTCONN;
> +
> +	memcpy(&prim->ssp_addr, &asoc->peer.primary_path->ipaddr,
> +		asoc->peer.primary_path->af_specific->sockaddr_len);
> +
> +	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
> +			(union sctp_addr *)&prim->ssp_addr);
> +	return 0;
> +}
> +
> +int sctp_sock_get_primary_addr(struct sock *sk, struct sctp_prim *prim)
> +{
> +	int ret;
> +
> +	lock_sock(sk);
> +	ret = __sctp_sock_get_primary_addr(sk, prim);
> +	release_sock(sk);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sctp_sock_get_primary_addr);
> +
>  /* 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
>   *
>   * Requests that the local SCTP stack use the enclosed peer address as
> @@ -6421,35 +6450,19 @@ static int sctp_getsockopt_primary_addr(struct sock *sk, int len,
>  					char __user *optval, int __user *optlen)
>  {
>  	struct sctp_prim prim;
> -	struct sctp_association *asoc;
> -	struct sctp_sock *sp = sctp_sk(sk);
> +	int ret;
>  
>  	if (len < sizeof(struct sctp_prim))
>  		return -EINVAL;
> -
> -	len = sizeof(struct sctp_prim);
> -
> -	if (copy_from_user(&prim, optval, len))
> +	if (copy_from_user(&prim, optval, sizeof(struct sctp_prim)))
>  		return -EFAULT;
>  
> -	asoc = sctp_id2assoc(sk, prim.ssp_assoc_id);
> -	if (!asoc)
> -		return -EINVAL;
> -
> -	if (!asoc->peer.primary_path)
> -		return -ENOTCONN;
> -
> -	memcpy(&prim.ssp_addr, &asoc->peer.primary_path->ipaddr,
> -		asoc->peer.primary_path->af_specific->sockaddr_len);
> -
> -	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sp,
> -			(union sctp_addr *)&prim.ssp_addr);
> +	ret = __sctp_sock_get_primary_addr(sk, &prim);
> +	if (ret)
> +		return ret;
>  
> -	if (put_user(len, optlen))
> +	if (put_user(len, optlen) || copy_to_user(optval, &prim, len))
>  		return -EFAULT;
> -	if (copy_to_user(optval, &prim, len))
> -		return -EFAULT;
> -
>  	return 0;
>  }
>  
> -- 
> 2.26.2
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
