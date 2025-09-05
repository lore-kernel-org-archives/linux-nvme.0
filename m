Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E242CA1010
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 07:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIYa1uabPb7CiivwiFFsec4sYrpIEmcrJXQzq2Lib2Y=; b=oLJ2VkeQnC1WLbNZfKo92gNxVN
	LGYqL/ee2MEho44+OE09R0DW/gX1qDUXMByrHMm7rtZx9+62KL1gvsfzaw4OhBGltvmLsifKmZZfr
	bqTWF2DWFQaWpbJCCAsN2n12YN9sB9dMSnSQmCQizmlKEEPm6IvAR9cIqcbKzYsCwEV0clEM+cGt2
	jfxDBuCnw2HPWyTgx2KbhHCGtxRyo5T7O28d/EGuLwSDyExhi9ouos1XEMvX20HfhjVcpdAF8u2L3
	hX7jlAoR/iupNDs15LFJ3oehIhB6/tBIzbRJr3tbrPV05YkL3prUR0AcfFOO9l0QyAzqZFkkRSjJV
	k5UmH8/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuQdm-0000000HW8z-2cs2;
	Fri, 05 Sep 2025 07:13:46 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuPNQ-0000000H70h-2xsV
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 05:52:50 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id cf8a8994 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Sep 2025 07:52:41 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 07:52:41 +0200
Message-Id: <DCKMSNY3N59V.3KQCDWA1VJQNQ@bsdbackstore.eu>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>, "Alistair Francis"
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: <alistair23@gmail.com>, <chuck.lever@oracle.com>, <hare@kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-nfs@vger.kernel.org>
X-Mailer: aerc
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_225249_074652_7E7B8DE1 
X-CRM114-Status: GOOD (  24.74  )
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
> From: Alistair Francis <alistair.francis@wdc.com>
>
> If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
> a KeyUpdate handshake type then the underlying TLS keys need to be
> updated.
>
> If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
>
> This patch allows us to handle the NVMe host sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
>
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>  - Use a helper function for KeyUpdates
>  - Ensure keep alive timer is stopped
>  - Wait for TLS KeyUpdate to complete
>
>  drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index bee0355195f5..dd09940e9635 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
> =20
>  	/* TLS state */
>  	key_serial_t		tls_pskid;
> +	key_serial_t		user_session_id;
>  	struct delayed_work	tls_handshake_tmo_work;
> =20
>  	unsigned long           poll_end;
> @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
>  	struct sockaddr_storage	sockaddr_peer;
>  	struct work_struct	release_work;
> =20
> +	struct completion       tls_complete;
> +
>  	int			idx;
>  	struct list_head	queue_list;
> =20
> @@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_q=
ueue *queue,
>  	return 1;
>  }
> =20
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> +#endif
> +
>  static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
>  		int budget, int *sends)
>  {
> @@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue=
 *queue,
>  	for (i =3D 0; i < budget; i++) {
>  		ret =3D nvmet_tcp_try_send_one(queue, i =3D=3D budget - 1);
>  		if (unlikely(ret < 0)) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret =3D=3D -EKEYEXPIRED &&
> +				queue->state !=3D NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state !=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}
> +#endif
>  			nvmet_tcp_socket_error(queue, ret);
>  			goto done;
>  		} else if (ret =3D=3D 0) {
> @@ -1110,11 +1125,52 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>  	return false;
>  }
> =20
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

Shouldn't "sk_user_data =3D NULL" be protected by a write lock?

Maurizio

