Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A179D3C92C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COyc6iR3jvbu59oIFhVtLe4FVtru7Lz75pvKkU5TT+c=; b=ucexXajcfVUp26Dk0jWYP1zfZJ
	pr+Pw1Ktts6l0fQUHD8165+9DCS8CbUrignyPD/Tn3HjhL3jbVS99FwaYhwEzFjdyQaWUaaA2NRtE
	fBCm3ufZzrcNxRnGpkRLFrfFp1gdSLQzrB8B9bhgynKuBmxk5KquzslL5Cv3y8ECxycPe2IpYDmOK
	q6V+F8Hy1QFGZNoHrAt6maRCNMYesoGuzhvZu6NEsb8gf3kfmMMjH8p33sG3WFXh3Mp6mrxb5+6H3
	lo9of3W+dV8DAGs7heRuYZNCzDJWNpPoDDBHdU8MtxVzJveryVWYRCWU9xuSOF5E5HHqiQu2U5iIa
	14XLmOhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTMup-0000000FdEu-2KDB;
	Wed, 10 Dec 2025 16:19:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTMuh-0000000FdEV-1geV
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 16:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765383577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COyc6iR3jvbu59oIFhVtLe4FVtru7Lz75pvKkU5TT+c=;
	b=ZNaDCxLZ4DL1wBf6rEatXofuWt8mJZ5CqQVPpGxx8pJN63G9vLHV+k5AqDiFefGVvkm/pD
	4JlQOcaTNzZQzYSzC18Y7Hn7IecG+oGxurx+gSDBGO8agnuszaQhDMmXmsBRi9VVdcMKV5
	Kp1tSWgS6l3lP0pYDfQ9F1ooD0MqBF8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-nfGbKOtvPOSh1oQ_sdCbzg-1; Wed, 10 Dec 2025 11:17:37 -0500
X-MC-Unique: nfGbKOtvPOSh1oQ_sdCbzg-1
X-Mimecast-MFC-AGG-ID: nfGbKOtvPOSh1oQ_sdCbzg_1765383454
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88238449415so202490056d6.2
        for <linux-nvme@lists.infradead.org>; Wed, 10 Dec 2025 08:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383454; x=1765988254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COyc6iR3jvbu59oIFhVtLe4FVtru7Lz75pvKkU5TT+c=;
        b=gNMq47JX5DQyQ6AzkCFZTC42rcTTK32NKNwBUP0Z1HNgSIfWv1G/bi7ethvGB/Svo7
         qsriGZk0MgbvTZyAhT6SQ1wBiXTbOjTH+gSuR4R/dVAlUbNsSdqgvkaDrtDrzxSyd/oX
         eBdkuqV3DE+wPFpCmrKoWHQZxod/kqM3ZiakGCCoPaSnswuR5D+yalshIeqSyDFUpKXE
         x7XFS29qnw5lxINMmWd2nsOAmNbnSMqmfKGbdhRjW4nDUnm9H+PjLR4of7uxX/3nZMyy
         Poz0uL61pLrQ8zJYzVScMVl5WoWHUIL7AL9acFSR5DUt08WrjwlPUQ9FWIv3M3UQnfcS
         H9og==
X-Forwarded-Encrypted: i=1; AJvYcCWLl/V8byp5ycssIun/M8hy4upfuo1lXdEc1iv/nUhsTWOMjcBwrJsLuqbf9NRqYTb/sI3Ug1qU9f4c@lists.infradead.org
X-Gm-Message-State: AOJu0YzlrMqKq+Ukj9pHQLYWZIX0+TaaIebnb0V8FrAkgS+UDS3TR8qV
	mw9fjsfwEuNWlKSheVuDYC+uDg3XIVnSH9VgoOIqAD5ou03INzTcBPkcb1Ipu1ji2UjLwAag+1g
	W2iBmVHkUkBIO/Y6LStZk14RZMxRH16QWzAm0EChGkJ3HfPSqyaoHrUazbVNJ96IcD0w3yZgxxI
	dBMMSIB3Q/X7XHpyO6kENd1zpAqWggA17iqMrj+oRRzWo=
X-Gm-Gg: AY/fxX5EwOd2x3xuFSFOH77b06QYOlI5IMySR2u6K8cw50oOVjsznM3ejAbEhNcqWj6
	JidNg+QPuXA7yA16/o8a1EuogaFqQg/KfTmBDAvIIHbdfxbYi1AtSxVAKjPy0Ec9NePTn4KJRWF
	jjFR/frM4xGDz5+eMllcgMszGvPCgcDzXOqRXllqf8IJwfZfRVwzGToq3QW8/cMqFJPA==
X-Received: by 2002:a05:6214:5d92:b0:884:6f86:e07d with SMTP id 6a1803df08f44-88863a3e0dfmr40341326d6.15.1765383453856;
        Wed, 10 Dec 2025 08:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGprEIn9a8vBAdg/06T73oZ+18MA0pjY9PbOsFN6AB0AA9wFPHilLLsgvgBdCpVgkFEa+1Z7R+jp/s84NDYnTQ=
X-Received: by 2002:a05:6214:5d92:b0:884:6f86:e07d with SMTP id
 6a1803df08f44-88863a3e0dfmr40340846d6.15.1765383453479; Wed, 10 Dec 2025
 08:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20250818093245.41641-1-hare@kernel.org>
In-Reply-To: <20250818093245.41641-1-hare@kernel.org>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 10 Dec 2025 17:17:22 +0100
X-Gm-Features: AQt7F2pwJsmbnae60IiPI5N4SZ3ble59DZaas6BUyYFH9vEaTGrJiTk9LsC2F0w
Message-ID: <CAFL455=iY=PfYC19n+dFKO5YU8Q9W=L=XJ5BTuidZLVvAqMUVg@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 27w0ZQuEYidF52U6Tsf7OMJYLvlkBHLEtbRAS5rzMKM_1765383454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_081939_514232_5480A8CA 
X-CRM114-Status: GOOD (  16.47  )
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

Sagi? Could you review this please?

Thanks,
Maurizio

po 18. 8. 2025 v 15:41 odes=C3=ADlatel <hare@kernel.org> napsal:
>
> From: Hannes Reinecke <hare@kernel.org>
>
> When the socket is closed while in TCP_LISTEN a callback is run to
> flush all outstanding packets, which in turns calls
> nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
> So we need to check if we are in TCP_LISTEN before attempting
> to get the sk_callback_lock() to avoid a deadlock.
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
>
>         trace_sk_data_ready(sk);
>
> +       if (sk->sk_state !=3D TCP_LISTEN)
> +               return;
> +
>         read_lock_bh(&sk->sk_callback_lock);
>         port =3D sk->sk_user_data;
> -       if (!port)
> -               goto out;
> -
> -       if (sk->sk_state =3D=3D TCP_LISTEN)
> +       if (port)
>                 queue_work(nvmet_wq, &port->accept_work);
> -out:
>         read_unlock_bh(&sk->sk_callback_lock);
>  }
>
> --
> 2.43.0
>
>


