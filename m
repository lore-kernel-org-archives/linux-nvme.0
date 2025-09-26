Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F4ECAC5AE
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4t2YeU64BkXqdaE1zLYmQFmjSbsA5lX3MiUg+ASecU=; b=Gl8FKkT5Wa5gg89Bu3ze2b2VN7
	8/puD6oo4aSmTC26yJykw8UxP+qfwx+nlSAlR+OJib+lou/rA4NRyHc1bOwZo4Why3IirPubF+ETH
	/x0ELQH2twJvx/nXghD9UYpUJDdpY5wnLOXCn4vWytC4A81i/3fW8GGVP9ZpVoLiIftF8x5MMCwqs
	cOVP1vCzFh0KLFuJ+HunyhPNzY5prDnc76/0d/UoI3h9s3kSQWRL6RhQURXJW5G1IfwdXDB7D76jr
	ymZYhXj/ZP0DcaZcJ3x9dvb1tCY9nMnFEUXkb4fPoVERSneuaCIjvOJCSjtxTKk3Ihww7bY6sLeQx
	L/EyUY6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v27ru-00000001Hii-2f6A;
	Fri, 26 Sep 2025 12:48:10 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v27rr-00000001Hea-2qNi
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 12:48:09 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 9d863723 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Sep 2025 14:48:02 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 14:48:02 +0200
Message-Id: <DD2QS4LQ8MDJ.ZQ6LZSFF0R0M@bsdbackstore.eu>
Cc: "Sagi Grimberg" <sagi@grimberg.me>, "Keith Busch" <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>, "Yi Zhang" <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <hare@kernel.org>, "Christoph Hellwig" <hch@lst.de>
X-Mailer: aerc
References: <20250818093245.41641-1-hare@kernel.org>
In-Reply-To: <20250818093245.41641-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250926_054808_059524_47038579 
X-CRM114-Status: GOOD (  14.30  )
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

On Mon Aug 18, 2025 at 11:32 AM CEST, hare wrote:
> From: Hannes Reinecke <hare@kernel.org>
>
> When the socket is closed while in TCP_LISTEN a callback is run to
> flush all outstanding packets, which in turns calls
> nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
> So we need to check if we are in TCP_LISTEN before attempting
> to get the sk_callback_lock() to avoid a deadlock.


Ping, I guess this patch has been forgotten

Maurizio

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Tested-by:  Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 470bf37e5a63..2e9a3e698b70 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1992,14 +1992,13 @@ static void nvmet_tcp_listen_data_ready(struct so=
ck *sk)
> =20
>  	trace_sk_data_ready(sk);
> =20
> +	if (sk->sk_state !=3D TCP_LISTEN)
> +		return;
> +
>  	read_lock_bh(&sk->sk_callback_lock);
>  	port =3D sk->sk_user_data;
> -	if (!port)
> -		goto out;
> -
> -	if (sk->sk_state =3D=3D TCP_LISTEN)
> +	if (port)
>  		queue_work(nvmet_wq, &port->accept_work);
> -out:
>  	read_unlock_bh(&sk->sk_callback_lock);
>  }
> =20


