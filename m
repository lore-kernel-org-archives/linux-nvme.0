Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490ADC61D92
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HWknQm3EdTZNY7c/PjrmdU44Zs8ztB+zscA1hwOtqI=; b=HaZXTza0+s+AjgnS4kedr96DHw
	a+ld0BUTm5BGlEOTPreDs24lm2IB34/FdmFUwiP4GUNMF5xg5HTfBi1dauIRDJH3QBEU12lweHZpu
	KtrKQ4KEjWS6pFYU0WuaSrQASu7agEJ+tJhRQixKcow8WudNkQhKcPgIfO3HJVZl55UEXCQj+0lZ3
	ofhxL1ndXZ8mgn1K4+S7FA6RIixfQsCPwCk0MJv7/+iJ90EAIqGDZJw4a9wc/vY1FPfJvaTAa9bwJ
	pXRV3JV9Fbfs4OWdwiE7PAE2LDIWY5WeWqrZV/65N1gdmyQw9C5HbOANHED5vuzjF8CXGg8k5vBxC
	gjquXtAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5P1H-00GYjJ-2T;
	Tue, 21 Nov 2023 11:34:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5P1E-00GYgC-1k
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 11:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700566454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HWknQm3EdTZNY7c/PjrmdU44Zs8ztB+zscA1hwOtqI=;
	b=DLQKZjvBLwuA01+MGlWXQPBIdGOBJBh4txziNlIyh2selC2sGSdo89+NuPI7jZdE83omu1
	ETG1WEzAgNn7R05WlILBjKoxb8Fydz+8zYKNhL1lCoMwWpdAvYfEZfdqH6VMPKGqcUA1ZQ
	OWYmcTWec4qzKOTOQwZXFSaY7Q4EF3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-AD0XpHbUOMOzf0_AOq-HsA-1; Tue, 21 Nov 2023 06:34:12 -0500
X-MC-Unique: AD0XpHbUOMOzf0_AOq-HsA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33174557ed4so1718593f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 03:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566451; x=1701171251;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HWknQm3EdTZNY7c/PjrmdU44Zs8ztB+zscA1hwOtqI=;
        b=l5kLtf923IXEDmwt0neWlCWMMjqpjaMv4fM2DarHXZdygBsU3HzQom/iCU5io8ikQ0
         ynqCGG2YSBtPBlQuOKm/03tNEd7FtmTmDxRUGxUnY3Kclb1cpnxGHgcWOhYu+Ht4MPbk
         RCfX6WfJhsB82vyHpSBmm/MiOkM3E/WWVFF/OkNe8mtRvo0DWDzxkoztXWh+XPj0bUYw
         nKVq1AJI2jDGx2hzsC3LskTLgoG2eldXuD21b3PTlgRE+YSUGA18u2AkjRi2IybhyRKf
         MgMwBRaWIIs9QddVs0iWr+lBgvlNzdfx4tWjbl1t1cnLBgNn5Jq7E0hy4MUiGlYipI6p
         zJhA==
X-Gm-Message-State: AOJu0YxVVUACXARfq2va6YHQis2JLS3RaDOyXSw3M4XfYDWE1pTbIPMS
	yehLUTs8BO3G/7WPc+0LVzFcvqFGNl5ikLmaRESExLhgrS/8z+L1CHwYI3t5ovu8Krzs2qD3pgC
	V6BibQuB1KCV/hF/AUk6JGWe8EGykQRSFIe9mePHzG27AEwian6c=
X-Received: by 2002:a5d:634e:0:b0:32d:c792:fcaf with SMTP id b14-20020a5d634e000000b0032dc792fcafmr1754532wrw.26.1700566451660;
        Tue, 21 Nov 2023 03:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyiGG1O2+ixgWIcc03nWV7+tsxRIMaecgqtFnyOVP79uqnyACvYe0PANf4Eq6xdVMzOafkhqbm1RsQFSSI/5Y=
X-Received: by 2002:a5d:634e:0:b0:32d:c792:fcaf with SMTP id
 b14-20020a5d634e000000b0032dc792fcafmr1754517wrw.26.1700566451247; Tue, 21
 Nov 2023 03:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20231110163721.15292-1-emilne@redhat.com>
In-Reply-To: <20231110163721.15292-1-emilne@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 21 Nov 2023 06:34:00 -0500
Message-ID: <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
To: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_033416_672542_6B5A847D 
X-CRM114-Status: GOOD (  21.85  )
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

Keith / Christoph-

Can you take a look at this fix please?  I've got someone
getting this crash fairly reliably, their customers are vulnerable.

-Ewan

On Fri, Nov 10, 2023 at 11:39=E2=80=AFAM Ewan D. Milne <emilne@redhat.com> =
wrote:
>
> When scanning namespaces, it is possible to get valid data from the first
> call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
> call in nvme_update_ns_info_block().  In particular, if the NSID becomes
> inactive between the two commands, a storage device may return a buffer
> filled with zero as per 4.1.5.1.  In this case, we can get a kernel crash
> due to a divide-by-zero in blk_stack_limits() because ns->lba_shift will
> be set to zero.
>
> PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:10"
>  #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
>  #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
>  #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
>  #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
>  #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
>  #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
>  #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
>  #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
>     [exception RIP: blk_stack_limits+434]
>     RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
>     RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
>     RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
>     RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [nvm=
e_core]
>  #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]
>
> This happened when the check for valid data was moved out of nvme_identif=
y_ns()
> into one of the callers.  Fix this by checking in both callers.
>
> Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespaces=
 during sequential scan")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>  drivers/nvme/host/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88b54cdcbd68..ae35b19cd562 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2027,6 +2027,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>         if (ret)
>                 return ret;
>
> +       if (id->ncap =3D=3D 0) {
> +               /* namespace not allocated or attached */
> +               info->is_removed =3D true;
> +               return -ENODEV;
> +       }
> +
>         blk_mq_freeze_queue(ns->disk->queue);
>         lbaf =3D nvme_lbaf_index(id->flbas);
>         ns->lba_shift =3D id->lbaf[lbaf].ds;
> --
> 2.20.1
>
>


