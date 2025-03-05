Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D98C282DE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YYMU1ONvumZN07XPBCtkjUrstfEAtCPPddr7Hfo9Atk=; b=4ahp8neiNDZUOFpng/FQoq/vSZ
	AJbkxhuLkag6MsB4c1oy0lTm1nW0oLX2sOoq4XvUyNHbEyvzQGMGScD1koVmgDeXB4v8pIKj/aC0A
	qi5lY6WFSuGHUtor9oMVwe5ibSdd/8PZ8mInYssy5eYHx24MFcGLU/2KzXLcbCj1AHlDIULWngGnY
	hyp0dWKC5K9f2j+bSrKu7Amo0AavxuvW3SkWhV2BqqtUd+UK01fqtvyOYZFrBbiEI/dayvn+c2T6v
	UWofYBNPQ7DjUsA34xppFo6mvn/2UmC43vUz54ow9Ct9+ecoQ/SUyLHQQDaWoKmX1k2vHIiM47n/2
	JsZ6/mYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr8Y-00000008aHm-2u5B;
	Wed, 05 Mar 2025 15:58:22 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr8W-00000008aHS-1DM1
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 15:58:21 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2fe9fd5e7f8so1971602a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741190299; x=1741795099; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYMU1ONvumZN07XPBCtkjUrstfEAtCPPddr7Hfo9Atk=;
        b=d+xv9ZT0Rw8w5MgvFeRaAeZYcGDOjpoQUkhLuCx7tQ7glG1N02wsBdrBVKlh8qacDi
         p+5eLpHot9NcTloKZx4Gjz3lYCBYj9a+ZZNw2ias84mZDkmtk3Xev99OIYI5tHHG0Xa8
         3tvH1x86RW/crhv1bdWIhbjcTkjQBtfB9SdV7VDBN7ea3NuYhxKZxM/HGcGgBN1276hB
         XfYdr5s/DmwJeZu35bOKi7ZEV7/3VjMSP0KSIfzVb6at8KOy2jXLIy3zACDsXQtj52mO
         P+Fsr+nog7sujYgv6jF/krzYsW6zS1+SCrWLOledscmLW0IFrFwpUnxluPXSZPMlwjoq
         O5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190299; x=1741795099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYMU1ONvumZN07XPBCtkjUrstfEAtCPPddr7Hfo9Atk=;
        b=c7axKU5pqinNEsEncyiDZtH13IDxfkbhFrHwo+jHbLeQ0pEcZHQdJos8jQjH0yRfok
         dFmI+Rdb1da6lPfEhc+2mn47Ev4irZM4nhvMig2xeTYEtQb5YM9zVr7EvPjG2Fl6B/xP
         DP+AimDwwOmNUr9z7fJ55/Z7UMgeRv9WLfYyUI3QP2YRYVQPQISuV6YBjZ6s1rfzgyRj
         yB+ghYZ6hOT/ID9zU1RHHChP9mIkhxmhYJlCYYsLuyAPiO/Yo6+hesmN1Uva8p9zyK2b
         8Q1uyKQwEBRZ8kp0iqJqYe8h69CQeaDUIsagKFgyDAWVjL2fWRgdlfUHKRMu5L3tMq0w
         kBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpdUgiOaUM+fc5SH6szC8I9a35Vv3goz4ZX6G6/BM6S2zU4JP3kSWotpjRUwI3zkZWoIu7X3tGTWwz@lists.infradead.org
X-Gm-Message-State: AOJu0YzwacKQDW43brQ1Je1Wxl0SwhN+SH0hVdx/vQ3xyHQxawBrYX3G
	LVbuiQ+WKy6R6TjSuQtgr1vyJZVslpzQ1/6vX3ISofSwitudbtptrZXFwnEWPPsP11ASo1jBkvq
	Ub5StvzVJAwnCPOt25Mq2K8E0HJj914NUEIo2iQ==
X-Gm-Gg: ASbGncv4K1nzBUWGOWGHvFiraQi+prRgh07WEW1/HGQa5BU2mdYHSV4l1M0rrTYEHAS
	RYiVXYUKlqSmNYzsEwTvH5dFATnlQz9FVx+pcqI4dzi/Osh9ruke2VP5uiGRSqKuBzuoXi8sqHL
	CYCt4tD1Bm8S9Z4eJb5akVpbAippo=
X-Google-Smtp-Source: AGHT+IE039RKehIzWkPoz9Pwq8myqyy+FZsujwKtDDyBFn8FwGJVt10BuBtMIRgg7fWx3zw0WYibWGpIpl/Q2cToPds=
X-Received: by 2002:a17:90b:3848:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-2ff4e9041aamr1711334a91.4.1741190299046; Wed, 05 Mar 2025
 07:58:19 -0800 (PST)
MIME-Version: 1.0
References: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
In-Reply-To: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Mar 2025 07:58:07 -0800
X-Gm-Features: AQ5f1JpSLtbPYSGimhA0YnzX_t62kjsBmHrLeI4W_9M3JJL8fO_onDsebrkT6Ww
Message-ID: <CADUfDZphhneo1g7TSpCh4iNW_PjgyuM52Nm3mVQrG5PSzDUnnw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_075820_371098_CE26121A 
X-CRM114-Status: GOOD (  24.94  )
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

On Wed, Mar 5, 2025 at 7:53=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
>
>         if (ret < sizeof(*icresp)) {
>
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Handle invalid positive returns separately from negative
> error codes to avoid this problem.
>
> Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial =
ICResp PDU")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> v2: Change the style.  Add the Reviewed-by tags.  (I will feel really bad
>     if I introduced a bug in between v1 and v2 and cause everyone
>     embarrassment with the R-b tags.)

Still looks good to me.
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
>  drivers/nvme/host/tcp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8a9131c95a3d..b23ce31df97d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,11 +1495,11 @@ static int nvme_tcp_init_connection(struct nvme_t=
cp_queue *queue)
>         msg.msg_flags =3D MSG_WAITALL;
>         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> -       if (ret < sizeof(*icresp)) {
> +       if (ret >=3D 0 && ret < sizeof(*icresp))
> +               ret =3D -ECONNRESET;
> +       if (ret < 0) {
>                 pr_warn("queue %d: failed to receive icresp, error %d\n",
>                         nvme_tcp_queue_id(queue), ret);

This log line is slightly less informative now if a partial PDU is
received, since it will log -ECONNRESET instead of the number of bytes
received before the connection was closed. But I think that's fine.

Best,
Caleb

> -               if (ret >=3D 0)
> -                       ret =3D -ECONNRESET;
>                 goto free_icresp;
>         }
>         ret =3D -ENOTCONN;
> --
> 2.47.2
>

