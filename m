Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85415CAC580
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XId/gEgYzXqPN02TbAMKmlnF27mifp7assNwY77i+GM=; b=Nscy6JWg4HO0ZFxpzUlZQIswSb
	cONMXB3DMwtpm0yOR28bfpJjFs6QyN5KG0wmqiA+zjdsL6Se/gU9qsrSq+/lYvCt5XFkUP48pSvB0
	H8py3LxzNyrewBHaXMRhjjmel0osgnKo4i9ZvlFkpHF1lem5tfr6QWl58QijMRDLG38aazYOE1evz
	cq8r5q+nL/xjN1CvYOJteh/GjH5QbK9yqSgPxxmzzX/bL/J+PQPseRpmj/BODuktI//PhrMui9Wvd
	OcfcrCFj8/6bsUFT1rmCxtp+kc/vvGuer23qvaTG4PMgoQxagL3Ed/3Yu20qXIlGEKimLNaPgX5Uf
	1ub2ykMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZVh-00000003BGb-2qb3;
	Fri, 05 Sep 2025 16:42:01 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWM1-00000001vmQ-1mqk
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 13:19:51 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 13115ccc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Sep 2025 15:19:46 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 15:19:46 +0200
Message-Id: <DCKWAZAH7QNO.3739YP7O69XKZ@bsdbackstore.eu>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <alistair23@gmail.com>, <chuck.lever@oracle.com>, <hare@kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-nfs@vger.kernel.org>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>, "Alistair Francis"
 <alistair.francis@wdc.com>
X-Mailer: aerc
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_061949_792387_1F5EDF2F 
X-CRM114-Status: GOOD (  11.10  )
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

On Fri Sep 5, 2025 at 4:46 AM CEST, alistair23 wrote:
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int update_tls_keys(struct nvmet_tcp_queue *queue)
> +{
> +	int ret;
> +
> +	cancel_work(&queue->io_work);
> +	handshake_req_cancel(queue->sock->sk);
> +	handshake_sk_destruct_req(queue->sock->sk);
> +	queue->state =3D NVMET_TCP_Q_TLS_HANDSHAKE;
> +
> +	/* Restore the default callbacks before starting upcall */
> +	read_lock_bh(&queue->sock->sk->sk_callback_lock);
> +	queue->sock->sk->sk_data_ready =3D  queue->data_ready;
> +	queue->sock->sk->sk_state_change =3D queue->state_change;
> +	queue->sock->sk->sk_write_space =3D queue->write_space;
> +	queue->sock->sk->sk_user_data =3D NULL;
> +	read_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +
> +	nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
> +
> +	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> +			  nvmet_tcp_tls_handshake_timeout);
> +
> +	ret =3D nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIV=
ED);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D wait_for_completion_interruptible_timeout(&queue->tls_complete,=
 10 * HZ);
> +
> +	if (ret <=3D 0) {
> +		tls_handshake_cancel(queue->sock->sk);
> +		return ret;
> +	}
> +
> +	queue->state =3D NVMET_TCP_Q_LIVE;
> +
> +	return ret;
> +}
> +#endif



> @@ -1408,14 +1474,22 @@ static void nvmet_tcp_io_work(struct work_struct =
*w)
>  		ret =3D nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
>  		if (ret > 0)
>  			pending =3D true;
> -		else if (ret < 0)
> -			return;
> +		else if (ret < 0) {
> +			if (ret =3D=3D -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +				return;
> +		}
> =20

What happens if CONFIG_NVME_TARGET_TCP_TLS is disabled?
I suspect the kernel build will fail with an update_tls_keys
implicit declaration error.

Maurizio

