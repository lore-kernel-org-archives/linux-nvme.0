Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFEBC54FB9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RBGKQocKxUxf6twWFcIb/xQw6zB8OJmxa1oD7YkFH5Q=; b=35ipSbEND2LtMiWpCwz9PuoK5/
	Jq9eI0SUF1GETbKkR3ww8ofpMIsA1JxpSlbsCyLBVK8VFfDQfFVeaQiw/Ni+TnWNEQyubhIq/JPHz
	okHJWcAMtMIUHb+ubrqkh/+Fl3QkxDDizl9oLf3TnRrwDxFI4hshBL6SeWh4v6TjlvqhFYcicitOc
	fOXgrK3zDIyAIjNeKreyH/hEWBCTkPys+U++nlVY73lrFvSaeupOHEUlcsxsviVRGgEvZQKR+sb+7
	NmGp5EfvkzdDcbG3SbGx5QtizQvztznOnmEo8+8PX9VVmPABB7HcBwIZZGr6rirunTab/qOzGJVm6
	quZ9EP9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5PGL-00Gbkj-1D;
	Tue, 21 Nov 2023 11:49:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5PGJ-00Gbk8-0E
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 11:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700567389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBGKQocKxUxf6twWFcIb/xQw6zB8OJmxa1oD7YkFH5Q=;
	b=A3jFMkyAIzCcw9tFzjpX/zEdc61+sUULKnVYrE8cWK0huL7F9iKFXl4LJKphHkpELgdepY
	1GaTxZC9o7BH+fu30DbXxRM+QHeudjuFRljJ4TLc7cOt9obsORpZqFh4ZmEjfu22zokhf/
	spGEY75A7kxG1YRMh0xH0RFXUtMNqpk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-glCB_HaNPnypMBaEOxsSCw-1; Tue, 21 Nov 2023 06:49:47 -0500
X-MC-Unique: glCB_HaNPnypMBaEOxsSCw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d879cac50so2793971f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 03:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567386; x=1701172186;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBGKQocKxUxf6twWFcIb/xQw6zB8OJmxa1oD7YkFH5Q=;
        b=SDvFfXrXYgKjgfZLjAEpjgmYRzKbqrPOHVsBQhaMTX2Sx6SgOS0RjVZcWs7vOAopHn
         eYA26nKxgPNRAO3EDJEiCiTgcoC0NNy6xc7NQXQhk9p1dMNE6atc7tMAmFU4ax4758Ls
         nZgto0uMK3QPG2YG0MXLU+5g4ATmv3KRhtahUrceIwlGeOsA8+Gl+3ErbOJdI0u9hu8i
         X/WwFEPIzvgWloXnk0k5UCeW3Te2wVuECQF3iQdhCmGXszKkEEhkXS3Fv04FoS8QD/Mg
         vIytIMUKm0dz45NduALqgbHeOCnEyQV5V5S+TII1iwXJJ5LWeFdfDPMf1CPPQcA91ZJC
         Y4Ow==
X-Gm-Message-State: AOJu0YxHrPB+AeTJCsZ/Fi8aKmfTQwUpozf2tEg9/2YOO9u495F7WN7h
	IqWg+ESnU7eXdS74V8l76oS1QCBQ7jg0VC9pMJ4DMs8Mc8rxZbXXgQH4YU+AVXHIoCOEW7Aj6uf
	SUqZIhKcsJb7DzTrrbWyjDARJG8uD4XakqmCOYbBffFngQ7L2N1o=
X-Received: by 2002:adf:f2d2:0:b0:331:6963:287a with SMTP id d18-20020adff2d2000000b003316963287amr7355004wrp.38.1700567386641;
        Tue, 21 Nov 2023 03:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMD4w59GxZHCflrb/S7RRLGePGuFth1nIy/iIeYodYRB1+hdOMAxrQcN06tUQOsMjxy+BrHZCCdOx+3K5+pTQ=
X-Received: by 2002:adf:f2d2:0:b0:331:6963:287a with SMTP id
 d18-20020adff2d2000000b003316963287amr7354995wrp.38.1700567386280; Tue, 21
 Nov 2023 03:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20231110163721.15292-1-emilne@redhat.com> <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
In-Reply-To: <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 21 Nov 2023 06:49:35 -0500
Message-ID: <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com>
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
To: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_034951_179324_5C908B4B 
X-CRM114-Status: GOOD (  25.61  )
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

Oh, never mind, I see it.  Just didn't see anything on the list.  Sorry.

-Ewan


On Tue, Nov 21, 2023 at 6:34=E2=80=AFAM Ewan Milne <emilne@redhat.com> wrot=
e:
>
> Keith / Christoph-
>
> Can you take a look at this fix please?  I've got someone
> getting this crash fairly reliably, their customers are vulnerable.
>
> -Ewan
>
> On Fri, Nov 10, 2023 at 11:39=E2=80=AFAM Ewan D. Milne <emilne@redhat.com=
> wrote:
> >
> > When scanning namespaces, it is possible to get valid data from the fir=
st
> > call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
> > call in nvme_update_ns_info_block().  In particular, if the NSID become=
s
> > inactive between the two commands, a storage device may return a buffer
> > filled with zero as per 4.1.5.1.  In this case, we can get a kernel cra=
sh
> > due to a divide-by-zero in blk_stack_limits() because ns->lba_shift wil=
l
> > be set to zero.
> >
> > PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:1=
0"
> >  #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
> >  #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
> >  #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
> >  #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
> >  #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
> >  #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
> >  #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
> >  #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
> >     [exception RIP: blk_stack_limits+434]
> >     RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
> >     RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
> >     RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
> >     RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
> >     R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
> >     R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [n=
vme_core]
> >  #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]
> >
> > This happened when the check for valid data was moved out of nvme_ident=
ify_ns()
> > into one of the callers.  Fix this by checking in both callers.
> >
> > Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespac=
es during sequential scan")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >  drivers/nvme/host/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 88b54cdcbd68..ae35b19cd562 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2027,6 +2027,12 @@ static int nvme_update_ns_info_block(struct nvme=
_ns *ns,
> >         if (ret)
> >                 return ret;
> >
> > +       if (id->ncap =3D=3D 0) {
> > +               /* namespace not allocated or attached */
> > +               info->is_removed =3D true;
> > +               return -ENODEV;
> > +       }
> > +
> >         blk_mq_freeze_queue(ns->disk->queue);
> >         lbaf =3D nvme_lbaf_index(id->flbas);
> >         ns->lba_shift =3D id->lbaf[lbaf].ds;
> > --
> > 2.20.1
> >
> >


