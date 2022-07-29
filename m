Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386AEC00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dy2kNKL1JhMWWnuIBBMhcLAKU8xcYvN5JWPftmW9fQY=; b=k9TidqyLY9lbS0IpPaDRtuop/o
	/BiZrenL8b1DBM5BscRLYLM9AOdMT1akXahOaR6sXYj0pj8SV6XKjcLIYsGXNmrIG/vpF/0sYQ7yF
	yaOsaGv8X3ZN869Y0lXzICoFAhC1K5UjUOQ+v8pp33xuHNf041VD0rMFygWAFL7Y0WBdp5NfOcg+J
	X7tubAbeFovbACsl3lJq3l2S8jp91ODBHv+cCW8Sg8ISl727JTp1DcnUQdEtvmoaU4V2EnJsB327L
	t/B7xdgUdBwgSSnFVTpcztKpAdp6mNzbFffmopSaXVUiQxizUID98jSfpHfSe5UYN28ihanf9a6my
	Ez7v0aSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKYu-002fj7-Rc; Fri, 29 Jul 2022 07:37:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKYp-002fdp-96
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 07:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659080243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dy2kNKL1JhMWWnuIBBMhcLAKU8xcYvN5JWPftmW9fQY=;
	b=hl6nKBOAladG11PjgEvHkrP27O62CtLmYv2ioh9JqRrNlkpSXq7utxECGXfcrKaptDjSn6
	6tsEyy6oS1LSNruevC8BASHFv0FyGSEwejpDfXyBE+7p0ioF01zYjukrWK7t0NQCuYZ+RC
	oNBpZ7fgQXsirheXagEgJltOUTVhJ1w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-NnNVH7syMC-jrje_SDekBA-1; Fri, 29 Jul 2022 03:37:21 -0400
X-MC-Unique: NnNVH7syMC-jrje_SDekBA-1
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a056402270a00b0043c0fed89b9so2439066edd.15
        for <linux-nvme@lists.infradead.org>; Fri, 29 Jul 2022 00:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy2kNKL1JhMWWnuIBBMhcLAKU8xcYvN5JWPftmW9fQY=;
        b=Ia1pwV+VG/j9PSTkwXWdCa2pDYje755xAHDCVvNPNfH+4xXg6+SOX7LYRupLvwEgQE
         OCecvSrCers/urI3zOUlIl+caUrhaPLxQqVmEhgmNjXD+x7otedpB4AJQDl0VR8NXUud
         R66d0wGy0+C0dJKjSC3RYDiBFKdP5UqAXt5Bbc4KlFZvG/z2nSR9NeZKybtLZQO1dmQ8
         W5wSIKeT6TpnbUpXbd+Vqa+GC02Tf+FXw9XaXdyD6YeojfS+MlWyTI6dDFioXgxnusoV
         +F0Sgj4HxjotA5j9WCEi2YHv9WLulw0ukvDYGRMWfOXtD9p9UC4TsZEy7vjrUP/91c8Z
         hyzg==
X-Gm-Message-State: AJIora9z7LiSR0fzZSR+0ZpcK7QkJCfEd2/B1Logx6EUGX2WZ3vvCcpJ
	wIMTcNsliLM+4Dx5xaUr7UY0RuKKKCnCiUnkiUc8PPgkhxAZ04Y0+TO4mv5GWGNSbKVcOAoP+yo
	C1Jc4jQHEK5ckEwRe3qbALYY5XRormXi54F9eqz0B0Ks=
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id gb18-20020a170907961200b0072e56bd2b9amr1962354ejc.526.1659080240353;
        Fri, 29 Jul 2022 00:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcOwVtg9ZNSypqnyzQpoYneT+Bc3aZjIXbOnZugGXRgMTg/1a7c3QhrtouZNuay5TaHkpZ1RIy1tdkCprE5sw=
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id
 gb18-20020a170907961200b0072e56bd2b9amr1962336ejc.526.1659080240006; Fri, 29
 Jul 2022 00:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me> <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me> <YtoriAQGW8+p4pFe@infradead.org>
 <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
In-Reply-To: <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 29 Jul 2022 15:37:07 +0800
Message-ID: <CAHj4cs_y9WtRDSpc27axBMpuzN55G7LE_MxMf5NUbePWyg1QXg@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_003727_474945_00D499D0 
X-CRM114-Status: GOOD (  22.91  )
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

On Sun, Jul 24, 2022 at 4:21 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
> >> for the socket threads, that does not need to be MEM_RECLAIM workqueue.
> >
> > Why don't we need MEM_RECLAIM for the socket threads?
> >
> >> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
> >> queues, and that must involve flushing queue->io_work in order to
> >> fence concurrent execution.
> >>
> >> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?
> >
> > I think so.
>
> OK.
>
> Yi, does this patch makes the issue go away?

I tried to find one server to manually reproduce the issue but with no
luck reproducing it, since it has been merged, I will keep monitoring
this issue from the CKI tests.

> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 0a9542599ad1..dc3b4dc8fe08 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
>   {
>          int ret;
>
> -       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
> +       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
> +                               WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
>          if (!nvmet_tcp_wq)
>                  return -ENOMEM;
> --
>


-- 
Best Regards,
  Yi Zhang


