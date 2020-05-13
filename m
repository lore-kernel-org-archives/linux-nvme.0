Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B104C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:01:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB111205CB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6tzWjC3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAlDH4C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB111205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6i5HkIHiJ475AmvrySua4i7Uh8myB1y/MYMLOBEPcw=; b=D6tzWjC3yKiGCc
	zTrU+dBb07/vjrG43E5diJ09NINMq08j40+EUAQSZ0xBSlEFt/8LkBZf/ClIZmIj2cgZRJsrX2T/E
	BDUMKnxfxcD6ZVldzv11TmUVTtgu4lcTg8G+b5YL7/7qj5zlTHIirK8/vLnsfLjnn8nIRtziS4la5
	1SnGqtYerb2epLoGVyo1/LR5Wt3zcxYVog5zkfI0GWeDVeOX19Snkau4NqYd1KGgCU6kV5a1jV/LE
	qUodwDZTx92FuXZgE8ZCfILoW2kxeU9+AFt5rWBnCWQQ9gz/DlulOy47paCWxxpaG3wwYk6FjD9sV
	MAwBCSNcn5n1QPvGMn5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYvgo-0003Ab-Ah; Wed, 13 May 2020 18:01:06 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYvgl-0003A6-OO; Wed, 13 May 2020 18:01:05 +0000
Received: by mail-qt1-x842.google.com with SMTP id 4so579481qtb.4;
 Wed, 13 May 2020 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=djizPthGumhy0aa82+s6m3Q9KQZDbFYAxoC6yOMwIJE=;
 b=bAlDH4C90L0WzuRWsV4+5Ckq+bqXFHL0YffjYTiIuP49rNtPXi8CvoXPRhlbDCns+x
 gC+7ZNqshiqIAcsWjLCQjmdrO9oOMlgzWJt0Xj3ZekTSDW9iCVFPAciWKXwTtsaX1rZ2
 VXCvvcg46I46jlg7EFLEyU90g8qDy5piGIZW0hen68PREB7hgPLiPfR3hs/JkD6zQYkN
 qhNZuKBqh3uPmvPNqsvUQXsiprnLUtG/XpqeqOiXfQs/5jIJPARkKZ81vF+9uN+yzLI2
 eDKxA7G8EEOFtgRLiqaZBFmhCr8blUDY0MqJ/GRWYF1K7PJ/mlVIvS7rM9jzk67nFQW1
 Y3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=djizPthGumhy0aa82+s6m3Q9KQZDbFYAxoC6yOMwIJE=;
 b=lL3QtcIBP3hHIjn5W5Dnp+J+Pa4VKIVNIeVz4FOAz+wQh80c9UrrHhKns9B9FE+f5G
 IrbZp9GKxr1aZ81YodCJxFb9ZQ/Ysch+g69/6Q3DB3TZC+b/TcloPCy2ZdcNWiAAznYx
 MxC0zEddiw59TCbiXTRUMrQ/IqN0HveqlMytwooujviiY3rnGFNQtcOiwBAoYVJ2FmxE
 tXJrpgMebNxLjN/bhnj56pTfU8GBPpjtkXgXIZjs4OMgzaGaQ0F2HIyu6uHR6c+2DD/U
 gILgVWazqZ5paWd5eHalSASVxz3Bdbm04L8h2f7PTUecwNwpMUtSFhYwh2lAW+o5ibhV
 GbMQ==
X-Gm-Message-State: AOAM532+BRC3emK6pRcRybOvYVtwOyoL3DoL7j1REqd7HYjRnazwOg8J
 dLJHFwpQfgEeMRAaxgUMY9s=
X-Google-Smtp-Source: ABdhPJzqbx3RBTNCuLykPLCx+cM+JeljoJjlYEyBds2uiDxtrploYjJasdpV7X3XZIToMReWEu/bXw==
X-Received: by 2002:ac8:4b67:: with SMTP id g7mr328118qts.346.1589392862149;
 Wed, 13 May 2020 11:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:f4e9:6bc3:5a0:7baf:1a14])
 by smtp.gmail.com with ESMTPSA id v28sm310105qtb.49.2020.05.13.11.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:01:01 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 88707C08DA; Wed, 13 May 2020 15:00:58 -0300 (-03)
Date: Wed, 13 May 2020 15:00:58 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
Message-ID: <20200513180058.GB2491@localhost.localdomain>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-28-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513062649.2100053-28-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_110103_789884_2B22A125 
X-CRM114-Status: GOOD (  17.60  )
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

On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> And call it directly from dlm instead of going through kernel_setsockopt.

The advantage on using kernel_setsockopt here is that sctp module will
only be loaded if dlm actually creates a SCTP socket.  With this
change, sctp will be loaded on setups that may not be actually using
it. It's a quite big module and might expose the system.

I'm okay with the SCTP changes, but I'll defer to DLM folks to whether
that's too bad or what for DLM.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dlm/lowcomms.c       | 13 ++++++++-----
>  include/net/sctp/sctp.h |  3 +++
>  net/sctp/socket.c       |  5 +++--
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index b722a09a7ca05..e4939d770df53 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1005,14 +1005,17 @@ static int sctp_bind_addrs(struct connection *con, uint16_t port)
>  		memcpy(&localaddr, dlm_local_addr[i], sizeof(localaddr));
>  		make_sockaddr(&localaddr, port, &addr_len);
>  
> -		if (!i)
> +		if (!i) {
>  			result = kernel_bind(con->sock,
>  					     (struct sockaddr *)&localaddr,
>  					     addr_len);
> -		else
> -			result = kernel_setsockopt(con->sock, SOL_SCTP,
> -						   SCTP_SOCKOPT_BINDX_ADD,
> -						   (char *)&localaddr, addr_len);
> +		} else {
> +			lock_sock(con->sock->sk);
> +			result = sctp_setsockopt_bindx(con->sock->sk,
> +					(struct sockaddr *)&localaddr, addr_len,
> +					SCTP_BINDX_ADD_ADDR);
> +			release_sock(con->sock->sk);
> +		}
>  
>  		if (result < 0) {
>  			log_print("Can't bind to %d addr number %d, %d.\n",
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 3ab5c6bbb90bd..f702b14d768ba 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -615,4 +615,7 @@ static inline bool sctp_newsk_ready(const struct sock *sk)
>  	return sock_flag(sk, SOCK_DEAD) || sk->sk_socket;
>  }
>  
> +int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> +		int addrs_size, int op);
> +
>  #endif /* __net_sctp_h__ */
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1c96b52c4aa28..30c981d9f6158 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -979,8 +979,8 @@ int sctp_asconf_mgmt(struct sctp_sock *sp, struct sctp_sockaddr_entry *addrw)
>   *
>   * Returns 0 if ok, <0 errno code on error.
>   */
> -static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> -				 int addrs_size, int op)
> +int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> +		int addrs_size, int op)
>  {
>  	int err;
>  	int addrcnt = 0;
> @@ -1032,6 +1032,7 @@ static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
>  		return -EINVAL;
>  	}
>  }
> +EXPORT_SYMBOL(sctp_setsockopt_bindx);
>  
>  static int sctp_connect_new_asoc(struct sctp_endpoint *ep,
>  				 const union sctp_addr *daddr,
> -- 
> 2.26.2
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
