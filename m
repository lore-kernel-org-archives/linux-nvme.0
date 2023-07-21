Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B5AEB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhGna8U3AbjXTK0GfHupfBmw9y8F8MsICtVmYYEO33w=; b=qUZTckrsS1aO9bU+VeCgZ5F/lU
	4IaHD9drYLQcdtqDkSaV2Il6XCUOTH+puSjZPNNsVIId57+LBPHHQfdm8mM78O85fSZFJHU7LnAye
	noL7bSn3m6E6WJOOLBq274fmlJR2sBkmu77jAyty/0OTP1DYs3k014Xt14d43lcW8szGjXyvRTj5+
	SS2x1qMfzSc1yg6Vnj5PIkRR47M759xL1GZnyjGZJC7FwYve/CXHpZY0umsS+R4NfYxoJ58yZ1IR8
	fXD3PwwNdgqpM/7wAP0WxpMHV9ZnU+lHUDy9aTud5ddfCFTb5rAOEOl3GPpDVFotfOeWN1628iKT4
	sMj/IPwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMfPr-00CaH8-0A;
	Fri, 21 Jul 2023 01:58:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMfPo-00CaGU-0v
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 01:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689904722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhGna8U3AbjXTK0GfHupfBmw9y8F8MsICtVmYYEO33w=;
	b=GP4XLbt5cvl0czhwCNdUNGR7NmIAiETdcI5KdQMK9h/olGsvhZH+Jpq7yMb44Fb8qwg33y
	BWijMnDBxSW3ZgqX8a9b/AYo977EilXLjNWf8L+Tt14ducjZF+uzhKw/u3diSZDl/QXUNo
	+p4bYfb4uf6MOpb7qXPI/9IYA9DR4jI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-PONvEakyMkeDP0mABkIzhQ-1; Thu, 20 Jul 2023 21:58:40 -0400
X-MC-Unique: PONvEakyMkeDP0mABkIzhQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262dc227ca9so1026399a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Jul 2023 18:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689904719; x=1690509519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhGna8U3AbjXTK0GfHupfBmw9y8F8MsICtVmYYEO33w=;
        b=N0kXNKldN0zbFcw5zHGhQWSXZ9lS/wUEEUB+pfyRVXzTKsMiSQVYXl6+gbc8cNVMMB
         7rgCSedDdtBdYmSpcmuJMwglZ0X506hRAtfbuLUSS0A7qP62CqsUFbnJYtkJH5qwrbeM
         kSZyO3XZLFyL45LZxcvlzNkapoMEb/H9E6O03c2nVjINXf0jZwhSFWc06NICT1tV3Cmi
         xmpdP2UIq/6V6k5K5g+PeQb/bGL6Kw0F7osPDUoojZVvgxUyxbEAXpEdS5JPDGVc4GWU
         HqtrYE5KHA864vpTGAjkpsN7On67Pjjfu2g3sa3Nqt7e7+IzChB5MFhhE9c++K3SmQ/8
         /bFw==
X-Gm-Message-State: ABy/qLaxenUeBKKwbkIVxzYoZv9HKP1ypRlFAa6kB63K3TQ21TZ80HHh
	waRO45v1Ydjf/LUonmlFw9J/O43ouCaLiXdsF+1dx6jV7OPBqiz1bJhvUt9n/4/dF4AeTYzheNZ
	SgxJI8KjyhqdWBQSXrtWmm3EjqmdKxFKv4V1aM64sZdg=
X-Received: by 2002:a17:90b:4a09:b0:263:f8e3:5a2a with SMTP id kk9-20020a17090b4a0900b00263f8e35a2amr412032pjb.36.1689904719612;
        Thu, 20 Jul 2023 18:58:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmx7gzkmzHO8hdH2sBhDw+aAQB8z1c9a31bsYownTohBa6EDZtW882rjYQyue4CMwbuhLM5a3unc3+zyFdoOE=
X-Received: by 2002:a17:90b:4a09:b0:263:f8e3:5a2a with SMTP id
 kk9-20020a17090b4a0900b00263f8e35a2amr412026pjb.36.1689904719352; Thu, 20 Jul
 2023 18:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711094041.1819102-1-ming.lei@redhat.com> <20230711094041.1819102-3-ming.lei@redhat.com>
In-Reply-To: <20230711094041.1819102-3-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 21 Jul 2023 09:58:27 +0800
Message-ID: <CAHj4cs9FfHRRJSQz=SPFJuMj_u9hSL5AaN3EyTdTdXkBSiqJ3Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] nvme-tcp: fix potential unbalanced freeze & unfreeze
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, Chunguang Xu <brookxu.cn@gmail.com>, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_185844_423272_EB3781FA 
X-CRM114-Status: GOOD (  20.94  )
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

Verified it with the nvme/tcp scenario, Thanks Ming
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Jul 11, 2023 at 5:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
>
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
>
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
>
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
>
> 1) same problem exists with current code base
>
> 2) compared with !mpath, mpath use case is dominant
>
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e7dd6f91832..fb24cd8ac46c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1868,6 +1868,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                 goto out_cleanup_connect_q;
>
>         if (!new) {
> +               nvme_start_freeze(ctrl);
>                 nvme_unquiesce_io_queues(ctrl);
>                 if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>                         /*
> @@ -1876,6 +1877,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -1980,7 +1982,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme=
_ctrl *ctrl,
>         if (ctrl->queue_count <=3D 1)
>                 return;
>         nvme_quiesce_admin_queue(ctrl);
> -       nvme_start_freeze(ctrl);
>         nvme_quiesce_io_queues(ctrl);
>         nvme_sync_io_queues(ctrl);
>         nvme_tcp_stop_io_queues(ctrl);
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang


