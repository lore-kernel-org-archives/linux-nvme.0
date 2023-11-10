Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4BBC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIw/exLlKLYp4gKJkyoTMY+CIhFhl9igwzNyzw57OIQ=; b=bcUzETVIOMNQaNLDvEcy7u5zD5
	J5U2BWFNYRR0Tc2bv7wTqJSV0vCJKoBTRhmgyxVqOvi3g1sYE3XkaJ9WgmpOXXEg7KO94Yv3Q1+WL
	cOloxHnAqq3YuwyvRBJWzX+sdxz9OnEx5uajAHijgDUHvHwmq1dUOiwnFm6F7BnJzDf41ue3Msg7e
	uvblHp8CvW7KPYWcY3VkHrgzHXDcljgItsdssRdZgw/AbZcAWoGhxL/Bs8cWNP7XlMpaKNwjXLBqr
	vmGuVULiShFaBQ/XXJvYmgoyEkNHq1ByoiFKnIJQEN3Si51Y+mS9ph3uesfUYaER11OeyvXuqXDiw
	97n+4NaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PsU-008QMt-1i;
	Fri, 10 Nov 2023 11:40:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PsQ-008QLs-2F
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 11:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699616437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIw/exLlKLYp4gKJkyoTMY+CIhFhl9igwzNyzw57OIQ=;
	b=BlaVcLsugJzdT9qxtuzZEyFrKf0h/nN8Aid6IH62bGLbB0KQkk+9aXUhG/7qCvqfVcnZs3
	QX41iOkWwq9LlyDm1dG1v2o5/gCDVi/a0TTUL1Rm/oQ9k9OzVax2FImprFPWRJ3ZK1YkA6
	9wXRzYx9qIkp5p8PPYeNlpWLaHcu+xg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-i3h9VqKAMzic2TJyatYqjA-1; Fri, 10 Nov 2023 06:40:35 -0500
X-MC-Unique: i3h9VqKAMzic2TJyatYqjA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28001f80712so1825844a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 03:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616434; x=1700221234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIw/exLlKLYp4gKJkyoTMY+CIhFhl9igwzNyzw57OIQ=;
        b=bghL3Kta2TBE9ofFRHFFA684z3JMSlhkgiTu2FM0GQfN5BJ62NSLKnTkIspxKL8ZVU
         zwrYyTKvvSzdqaoT1D1CgoHLBXEUHk5fyIm/dkogvxgTfL+6GrZ67t0c8JW9JxUxM2IE
         uzpsgiKJH0DoZJv/WCMGg5iNpM3V+wwrXQwjGyCPPCkR8IOIf6rITIRatPnoruF1b9mz
         V+FCVZvi2IMk/tt2NkgG1wuLJBQ2KixNmDkURRn3qEKz4m3a3v65+hw6BvVB5AEMVILH
         R1n9Vkl7kJUSG4dwQ61TTihuUo4gCcU/Q+048rwtQkJcokjvI7st++Icx8Uy8a1pbhXM
         3HFw==
X-Gm-Message-State: AOJu0Yx+TPCBCLwIn2H+sGzbXb2F+BNl+4/fR6MSAw8ugB69PIHswaYr
	Hzw68FcXBW429BtTUQOmullLODCAoNdviQK1mrrzY2Ajf6gh7iR8CKU0lL1FxM9mPBiEVNE8qMC
	6N849+5WE7xiU6l8gx3H+dfpuLg5+Ok7aqH/dTrYKzIg=
X-Received: by 2002:a17:90b:1d0d:b0:27d:669e:5a10 with SMTP id on13-20020a17090b1d0d00b0027d669e5a10mr4728697pjb.13.1699616434272;
        Fri, 10 Nov 2023 03:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+QYF3ahZNlhH0tY/8b21zRNj8QOyTTIzxttZ9FGkhjbLKTyLSron6dQWXG2Nvn2I4qwu/nUvjMJgTIx7fxuQ=
X-Received: by 2002:a17:90b:1d0d:b0:27d:669e:5a10 with SMTP id
 on13-20020a17090b1d0d00b0027d669e5a10mr4728686pjb.13.1699616433990; Fri, 10
 Nov 2023 03:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20231020050606.9464-1-hare@suse.de>
In-Reply-To: <20231020050606.9464-1-hare@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 10 Nov 2023 19:40:21 +0800
Message-ID: <CAHj4cs90L9BSo+EMSj7HGt0jHo=zFkh1Mj+w-Bu5LPAsjp3pcw@mail.gmail.com>
Subject: Re: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_034042_828147_5BECF880 
X-CRM114-Status: GOOD (  16.97  )
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

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Confirmed below issue was fixed by this patch.
https://lore.kernel.org/linux-nvme/CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOY=
vU9SLpmLTtw@mail.gmail.com/


On Fri, Oct 20, 2023 at 1:14=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> The TLS handshake timeout work item should always be
> initialized to avoid a crash when cancelling the workqueue.
>
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/tcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4336fe048e43..b3c1cc6690f6 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1856,6 +1856,8 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp=
_queue *queue)
>         }
>         return ret;
>  }
> +#else
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
>  #endif
>
>  static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> @@ -1913,9 +1915,9 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_=
port *port,
>         list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>         mutex_unlock(&nvmet_tcp_queue_mutex);
>
> -#ifdef CONFIG_NVME_TARGET_TCP_TLS
>         INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
>                           nvmet_tcp_tls_handshake_timeout);
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>         if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
>                 struct sock *sk =3D queue->sock->sk;
>
> --
> 2.35.3
>
>


--=20
Best Regards,
  Yi Zhang


