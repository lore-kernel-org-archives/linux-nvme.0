Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE7CCA5FBB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DX9g4ivFVPNTKG/kBEx/zUz96+yiO19hM2X9UAqzp0o=; b=xojfEyor0399kaTWLpzKYg9doV
	/z9qCr34/LLOuviDBtyltb4qcenju/1+4+1hPtZYgHRBSHjj8OWCrhl2qYOJ6qpCdOA006A7+ouAr
	v6bDB/AahInLuulXxIb94fjlzs8X64K8x+tW0ISvqsHCQqMXCJ6KfYsNwGFW6W+5oYLzbTZIcXLin
	sUG2Oayw64OoOlkABR615R/fXa4RppH0c+Mfme23Yzy+cW2GKkAxwsXsT8+YQGJza7qTS92eYTh0t
	2py59nxuCace9nCWSCdFnxO1FbaaqBkDZ1voGnt1nECxwQAynqg6PjT2Kxie3vCIpQq50zg/vLvoC
	Tiftt/ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnQq-000000055s2-3374;
	Wed, 30 Sep 2026 06:04:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBjbt-00000004tLd-3CpS
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 01:59:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 82740434E4;
	Wed, 30 Sep 2026 01:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530171F000FF;
	Wed, 30 Sep 2026 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790733593;
	bh=DX9g4ivFVPNTKG/kBEx/zUz96+yiO19hM2X9UAqzp0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O1welR2XYxDBYcQMymrp8H6LU8yzVjVEsXTqj+hE3Y6d384E20FR9whrky/Hlyvq8
	 PJBgrnmt0uwt8QYwPmssrtdWFnj9TlvpkUOcLju5O3FJ9+ZO1qq4A3RQp9kbPSJ3JI
	 AQvB1zRp2pyQRux8QZ6NS1/NHs7TRz8Ec101/R5TwolVHbJdIOa6AehLEpMX9RzcYp
	 0/12MShIxqBagJhTZ5n1HD9WpixNqk7ruvokk+tWP/ZJLFstOnlRPsEKrX2BtUpdlO
	 JsTn+twh2/J6S5QCngwhB61nx+6Ifhk+jqBTPr//Obogdmns5GmWCsQY5R9XKfbPgj
	 PklpO8bvU1b8g==
Message-ID: <3453cad85b6ec1d3b36398ba7565d053163a5929.camel@kernel.org>
Subject: Re: [PATCH v3 net-next 4/9] rds: use sk_set_nospace()
From: Allison Henderson <achender@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Aring <aahringo@redhat.com>, David
 Teigland <teigland@redhat.com>,  gfs2@lists.linux.dev, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>,  mptcp@lists.linux.dev, Wen Gu
 <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, linux-nfs@vger.kernel.org,  rds-devel@oss.oracle.com,
 Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg
 <lars.ellenberg@linbit.com>, Christoph =?ISO-8859-1?Q?B=F6hmwalder?=
 <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, 
 drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, linux-nvme@lists.infradead.org, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Date: Tue, 29 Sep 2026 18:59:50 -0700
In-Reply-To: <20260929071743.23624-5-edumazet@kernel.org>
References: <20260929071743.23624-1-edumazet@kernel.org>
	 <20260929071743.23624-5-edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Sep 2026 23:04:42 -0700
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

On Tue, 2026-09-29 at 07:17 +0000, Eric Dumazet wrote:
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
>=20
> No functional change intended.
>=20
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Thank you!
Acked-by: Allison Henderson <achender@kernel.org>

> ---
>  net/rds/tcp_send.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
> index 7c52acc749cf4d4003c749a2646c2b4f87f207fe..824222c475119d91e333123c5=
afc9291005a8696 100644
> --- a/net/rds/tcp_send.c
> +++ b/net/rds/tcp_send.c
> @@ -100,7 +100,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct =
rds_message *rm,
> =20
>  	if (hdr_off < sizeof(struct rds_header)) {
>  		/* see rds_tcp_write_space() */
> -		set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags);
> +		sk_set_nospace(tc->t_sock->sk);
> =20
>  		ret =3D rds_tcp_sendmsg(tc->t_sock,
>  				      (void *)&rm->m_inc.i_hdr + hdr_off,
> @@ -221,6 +221,5 @@ void rds_tcp_write_space(struct sock *sk)
>  	 */
>  	write_space(sk);
> =20
> -	if (sk->sk_socket)
> -		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +	sk_set_nospace(sk);
>  }


