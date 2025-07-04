Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811BAC83F09
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ri7wIPTfUQLSftkoC6BuEI3X+cP44AczGwiXzphuLKk=; b=dWiCuklPJnffg1S+LyPZ5PN3tI
	j/Y5JHMkhCEae4O0JhRm8pE+ek8Eryo6qtR+koUdh5MinelhAopr0cQIUW+tRllrY2Fs+LNCE23/W
	Lp328hX5BvCf5qWIVN7R2y+PfQ01SO1S0wTLeXjNnZsOHgMiwkKS10DAGIfLgfzMDUG8btsjx+cgM
	66KT/lttktrIgWE6qWuNZmkaB+YXCMwIMamqGAQJFCNMpfIm2bdDOwedlhDP9M/79LfWYOlTfuZwm
	maZLu65CKnOK3kTM5t4Slfa0aY3UC3w3FUbeHoALSaxYCOD+ndFEBciJB4KakBdgb8Wt23oQLkJ40
	pWxKN4eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhtZ-0000000Ek4B-2VlD;
	Fri, 04 Jul 2025 15:00:09 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhi8-0000000EiS3-3K10
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 14:48:22 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id b2b9af30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Jul 2025 16:48:15 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 16:48:14 +0200
Message-Id: <DB3CQE1V4WTO.1QCLZGZLSJCFG@bsdbackstore.eu>
Cc: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, <hare@suse.de>
Subject: Re: [PATCH] nvmet-tcp: fix callback lock for TLS handshake
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>,
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <20250704144455.244359-1-mlombard@redhat.com>
In-Reply-To: <20250704144455.244359-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_074821_173020_4EAA9CAB 
X-CRM114-Status: GOOD (  13.30  )
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

On Fri Jul 4, 2025 at 4:44 PM CEST, Maurizio Lombardi wrote:
> When restoring the default socket callbacks during a
> TLS handshake, we need to acquire a write lock on sk_callback_lock.
> Previously, a read lock was used, which is insufficient for
> modifying sk_user_data and sk_data_ready.

I forgot the Fixes tag

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")

Maurizio

>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..470bf37e5a63 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1928,10 +1928,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tc=
p_port *port,
>  		struct sock *sk =3D queue->sock->sk;
> =20
>  		/* Restore the default callbacks before starting upcall */
> -		read_lock_bh(&sk->sk_callback_lock);
> +		write_lock_bh(&sk->sk_callback_lock);
>  		sk->sk_user_data =3D NULL;
>  		sk->sk_data_ready =3D port->data_ready;
> -		read_unlock_bh(&sk->sk_callback_lock);
> +		write_unlock_bh(&sk->sk_callback_lock);
>  		if (!nvmet_tcp_try_peek_pdu(queue)) {
>  			if (!nvmet_tcp_tls_handshake(queue))
>  				return;


