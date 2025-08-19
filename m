Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA4FCA0EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eo2OzXaWXrg9eNJ7UH8sJvDDBhVWVF8gvexv6jwTzMM=; b=pZt7PCAZbvaWdiYmq+EjqGZQn/
	kyXhNWWmNtxxE14YXYUjthLOQJoN/yP51CyQX6tRCvZa77lqL59IIViWwBSDWlgqzGADOL9jEKy7W
	x5640sO5Ctm6Lw5vi75+FL/GB6IQjuKIX+nDA9JfItyyjnDcKN3g+ohKuzkAC2WtZ4cKkQOxEuFDL
	fpRcV7e3kQuDwUXvg7E4RBOfUAuA5+5/HEjy3nNnvR3dyYrNbGyjpXyZUuTRGbiDqw7PI8w6fFFu8
	CnOKlEH09rhisQmMW5W33+I9M1VDR29SE2GfbO5mb+YKRX0ZSNTM3/dfx9vWrUnhkrIxPH3OoLROu
	/SqIoU9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoEF5-00000009OBa-3HnO;
	Tue, 19 Aug 2025 04:46:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoEF2-00000009OBD-0Sm0
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 04:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755578793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eo2OzXaWXrg9eNJ7UH8sJvDDBhVWVF8gvexv6jwTzMM=;
	b=T2cFXeM5aXCPB3wTMTk0kjJfxSP5UvF3/xiAbz4ZeB6kpEnctCgtVTblsKhGYzoZJ6J02e
	zQexEA0lkeXGby5BgGvvssTeJmcQqf09Aoey2LCMBBxTYTXcr7DxMGxw3XbGjBvT7kG7/e
	9PMZttLQA12Dj+TWvf/Z0IMvKElZhME=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-p86sZU0GOYyKmRcZYR7oSw-1; Tue, 19 Aug 2025 00:46:31 -0400
X-MC-Unique: p86sZU0GOYyKmRcZYR7oSw-1
X-Mimecast-MFC-AGG-ID: p86sZU0GOYyKmRcZYR7oSw_1755578790
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-333f92ad4ffso18750501fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 Aug 2025 21:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755578790; x=1756183590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo2OzXaWXrg9eNJ7UH8sJvDDBhVWVF8gvexv6jwTzMM=;
        b=o7xlqeDUVVNg+dv4SVyh3lIyerOobQ+TdAyYh/10Bk7quKswX52p4ErgOtNEQuHENo
         sQcIgI7YCuKZTZqTVBY/+j5UPSJLimRRX3Q7sEII4Nd5T3zLTEI/3GGN4rUHH6TFuUBu
         HSRb/CIkuno+VWoM3ME4pdiazbvST634zp639tkvU/5DlK4fgDoUR0bEbWuU4OyfBr+t
         szAFYSDxoscyD5JRkkBirwzxCV6HB9sQIlo98lR5RDU7kqvm4Nl5MT8bLl6eWmvYgHhI
         gV4ID3owX096fdntFUg1DZBhl7CDFZagyay5FW/QIgFximb2+EeyZFoqXUBSbsOCz0+0
         EMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJQvfU4BWNoSxQzHEbWQvmdksLNd60HyrQZkf95Rt2xX+1St0rDfeJZcFtReItjNsDxqTCK7F7gJao@lists.infradead.org
X-Gm-Message-State: AOJu0YwkiTUdJhkGeWmDi2ApFCs025liyyzybvRjmNbbvwnCYlGfYi0P
	EhBdCVfBVTPU1IHTdOZKVwT8gVdLTjDUe1cy9sPOiMklDIInRM05GrJJFqJZiv+mwOGNE0A5Ngc
	IrFu9wlZL4esASNT5vphk4qRo/MUUvBUf4NeRo8QbeNjSMr2WtLcHaYHu0b5TdAEezTi/3s83HF
	8c0xQzOt4msxvFG9BHLAr4+hoj3Dd5IuHKXjVfOgFH8Uc=
X-Gm-Gg: ASbGncvALgU8lgVKLc7Ww8xsCbrXu0/cH+XNiHOKMVVBF2tOdo1XdOcw4BfSLnKZSuM
	vOlfHQNh2zvw/sUBlSuQhmtQNgfx672543P8UY/D03mucNWBQeLz+uTMJ7l6XMQgFPE02pyZncX
	aki2bDGJUlLR9V3fFjh3mY7A==
X-Received: by 2002:a05:651c:330:b0:332:4e49:cfcf with SMTP id 38308e7fff4ca-335305fd10fmr1856161fa.19.1755578789731;
        Mon, 18 Aug 2025 21:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEivJ3UpBKRjU40gU3WfH31BIi3V1z1wXDomFLzqVK2tcJwcLp10QVVSYYSetT8rU6cDTFfRhtP2ptEG3sxgYs=
X-Received: by 2002:a05:651c:330:b0:332:4e49:cfcf with SMTP id
 38308e7fff4ca-335305fd10fmr1856091fa.19.1755578789287; Mon, 18 Aug 2025
 21:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250818093245.41641-1-hare@kernel.org>
In-Reply-To: <20250818093245.41641-1-hare@kernel.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Aug 2025 12:46:16 +0800
X-Gm-Features: Ac12FXzPSch-cBjjvDFbqyRbDvJzUz6_MZhTgomjJuspRSRYJ2Q5XC2zJk7luJk
Message-ID: <CAHj4cs9WVQ_J-aQtMG=xgy0UBZHCWDmpUvH6ZBjJM-SDAU=zaA@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qkgseoe8tMG4SHDlcrG2XVTGerI5gTXTfEDgrMO4npc_1755578790
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_214636_225384_58319258 
X-CRM114-Status: GOOD (  20.57  )
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

Hi Hannes

Thanks for the patch fix.
Could you also add the bug report link to this patch so that we can
get more info, like the reproducer?

On Mon, Aug 18, 2025 at 5:38=E2=80=AFPM <hare@kernel.org> wrote:
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


--=20
Best Regards,
  Yi Zhang


