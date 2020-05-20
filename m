Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C895C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:10:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CF20884
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OEuh+0um";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6nrdRt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CF20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qGcwTlQBu5EPhZxzKeJPxv58SdOz6RuU+rSebb/j/XU=; b=OEuh+0umJvt5jf
	IRybbkTE5rrnm12jYJnoD54cd5VLCy4IMFglNt3hsDhC99OpPw3wLzKdGuFTILjiLukHxleIOqAER
	DN/ZKfz1sZnghXXHlGf4nn1xtXF2gHioNVqZ4ZsypUTakQiAM7PwtZi0YmsYHYcIRR1DNJih+gatk
	QUWCkbM+qz+uikTslm45wUTngCKNw9DkoQdEl5Eks61ckNX0VG2gXu6VFT2BGLWvDINvbC7IZD+Ce
	doGIR4gYdk3m4KVDlq9kH5QamnI9grwasnDLBHYPGbtUy2hIxn3YSDZKNmrhf1XQRKGk/U5v5Hv7p
	ClyAo7ny445U/Q4+AaLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbXqm-0005Ge-2Z; Wed, 20 May 2020 23:10:12 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbXqh-0003bs-Pj; Wed, 20 May 2020 23:10:09 +0000
Received: by mail-qt1-x841.google.com with SMTP id d7so4021480qtn.11;
 Wed, 20 May 2020 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/qygMQEHgAHnXXlcBf3bWz8hekZtO5JE6hUpY/E6MlI=;
 b=P6nrdRt7oaMJFGVn8tdcieLX1Y0jzSKCiVAEYNtArrwifpga+dN5v83cMRIKerr4lw
 S6tkBAkA2pzBZjc0nUkbiuQyYHvOajF4yI1Q6trOeI35JHSiPIaxzZCbG3Qtsy2IBEa3
 0u/0e0g7iT4mi/FhVlpzyBQ3hBLshkLlZGHWrVd+CnnFjHpAgBIE+8ymdFvfsvnw6oP1
 vrswReGAc6hPcqUAp+cE2FXwLqOAkzyS//X9yOiiedFgThmSWHlqXdSgAkTBcBgd7wGx
 VhCZmmEUAtG955eDuUNmBsKKkyJTq5OMaHqmy6az6aQ6f3SohaWpveT0RKHmFyEz+bny
 g7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/qygMQEHgAHnXXlcBf3bWz8hekZtO5JE6hUpY/E6MlI=;
 b=Hk3u8AJ5+GHsmvUXHfrWzd1IvPFt2FNYAJ6tCgPHWcCbRlE5H1mud6Sq/wnbuaTsaT
 LzDOc8Hsc4lx0KlJnC4NOv7mb2uOHUvoOqaJlPux6LpzjN0upyPzDLgnM+S+v0TE+sJR
 sZIahhT4AacER0hiGXuc2dB6LSeASRsoQUiFa6OPsZFQgFAnUC+P1HniEoNamUOtYPka
 9WpEfjqCZt42vT+FMJpEOS41GinbXHbqnJDqMK0BGwxA/zUIMx71JokN+kroiyEtuzPF
 6G+arKvt6M/MHvTkRYdXTt92D3GUiHHb0Qcsm6+MEGmuD0TX9xv9Mg1CvrBPB6NGDi+3
 HDqQ==
X-Gm-Message-State: AOAM530YLVkchk2MlPsBSDQRKh5SGqX72Hr4ACo0tx7RRRXJB503qMeR
 vAJj5hSoyTgEDsAoN60vuDo=
X-Google-Smtp-Source: ABdhPJwRWSgggkzxnJn0dwyU2QDiQnm5wTM+hCXxxx8a5qFL0yi0c7Z5VunfQVgq58oD4bmA7XAdrQ==
X-Received: by 2002:aed:3f7b:: with SMTP id q56mr7818149qtf.152.1590016204171; 
 Wed, 20 May 2020 16:10:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1284:f013:b7f5:289f:a703:e466:2a27])
 by smtp.gmail.com with ESMTPSA id e28sm3451287qkn.17.2020.05.20.16.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:10:03 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 2EE17C0DAC; Wed, 20 May 2020 20:10:01 -0300 (-03)
Date: Wed, 20 May 2020 20:10:01 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 31/33] sctp: add sctp_sock_set_nodelay
Message-ID: <20200520231001.GU2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
 <20200520195509.2215098-32-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520195509.2215098-32-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_161007_865323_7E2E6C4A 
X-CRM114-Status: GOOD (  19.21  )
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
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Jakub Kicinski <kuba@kernel.org>,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 09:55:07PM +0200, Christoph Hellwig wrote:
> Add a helper to directly set the SCTP_NODELAY sockopt from kernel space
> without going through a fake uaccess.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dlm/lowcomms.c       | 10 ++--------
>  include/net/sctp/sctp.h |  7 +++++++
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 69333728d871b..9f1c3cdc9d653 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -914,7 +914,6 @@ static int sctp_bind_addrs(struct connection *con, uint16_t port)
>  static void sctp_connect_to_sock(struct connection *con)
>  {
>  	struct sockaddr_storage daddr;
> -	int one = 1;
>  	int result;
>  	int addr_len;
>  	struct socket *sock;
> @@ -961,8 +960,7 @@ static void sctp_connect_to_sock(struct connection *con)
>  	log_print("connecting to %d", con->nodeid);
>  
>  	/* Turn off Nagle's algorithm */
> -	kernel_setsockopt(sock, SOL_SCTP, SCTP_NODELAY, (char *)&one,
> -			  sizeof(one));
> +	sctp_sock_set_nodelay(sock->sk);
>  
>  	/*
>  	 * Make sock->ops->connect() function return in specified time,
> @@ -1176,7 +1174,6 @@ static int sctp_listen_for_all(void)
>  	struct socket *sock = NULL;
>  	int result = -EINVAL;
>  	struct connection *con = nodeid2con(0, GFP_NOFS);
> -	int one = 1;
>  
>  	if (!con)
>  		return -ENOMEM;
> @@ -1191,10 +1188,7 @@ static int sctp_listen_for_all(void)
>  	}
>  
>  	sock_set_rcvbuf(sock->sk, NEEDED_RMEM);
> -	result = kernel_setsockopt(sock, SOL_SCTP, SCTP_NODELAY, (char *)&one,
> -				   sizeof(one));
> -	if (result < 0)
> -		log_print("Could not set SCTP NODELAY error %d\n", result);
> +	sctp_sock_set_nodelay(sock->sk);
>  
>  	write_lock_bh(&sock->sk->sk_callback_lock);
>  	/* Init con struct */
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 3ab5c6bbb90bd..f8bcb75bb0448 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -615,4 +615,11 @@ static inline bool sctp_newsk_ready(const struct sock *sk)
>  	return sock_flag(sk, SOCK_DEAD) || sk->sk_socket;
>  }
>  
> +static inline void sctp_sock_set_nodelay(struct sock *sk)
> +{
> +	lock_sock(sk);
> +	sctp_sk(sk)->nodelay = true;
> +	release_sock(sk);
> +}
> +

The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
API could be a bit more complete than that.

Like for the other patch, this one could build on David's patch, do
the ternary check before calling sctp_setsockopt_nodelay and then move
sctp_setsockopt_nodelay to the header, or something like that.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
