Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B936C36005
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Mar 2025 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qtl4aMOEbfVOV1/Eu8J0ZwV0cESQwszhmL0cG268KPo=; b=iGsDDotA0vD7YSTnb/VXWNd3Gx
	OC2YRPoMZUrSgjdaI+VlQavn4Ux1CIfZpcEJpg1ROpssCHM6+VQZ2hdAP5uuTbQUmJ41jgDzZ0Boy
	4C4mi7TbiQEo32naT6opfhot6KjHG0O2gVd+ZXEb7zNKp1oE7LErY8V2CnwSFwT+yiLGzjcvo8KsJ
	Ztfk3NvIh975VH0hfW6MsBvJ0Yph2ar/TMczJi6mEIzlo6vQAyrAjghXkYN9Q2KSKzy6Y5FDvd4EA
	0zQ/fLOdw0gdyrC49XIdZhnFFeUVhiCTCa6p7bwGUdcSBrpxChIerWEbpACZ2ArIOwgPV+OaofMjo
	q5qQP38g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twHxq-00000000yOD-48fC;
	Sun, 23 Mar 2025 09:49:54 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twHxo-00000000yNV-3PHw
	for linux-nvme@lists.infradead.org;
	Sun, 23 Mar 2025 09:49:53 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-2c77a5747e0so1496422fac.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Mar 2025 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742723391; x=1743328191; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtl4aMOEbfVOV1/Eu8J0ZwV0cESQwszhmL0cG268KPo=;
        b=hFmo6rUTWhIEzJ+X95T52cV+eRz3uuYAiZ6RejDXuMqDJ5/6nSctzs7zo84rrPyhvU
         I7dIdQBGKS/rnx2jrN2I8hdFWLBeNU8/SdWhrZI7/brG1XG+/r5NhGz2PWBgrv98Uups
         ljN0+JlN53RzFEiOzl64csfBPe0dwHEuUTCgXy2toYHi8b7wyi4pLdfbTt0SjXH/mUeE
         2on7mneRWohvbDr2Z85hbW1BB5o5sBxh7O62+0oHuyGgp+NyArwgW3GuSmYgZAMvi9gF
         pYFlXTbYLKgIZ/cr8Buvrt2je+Vhh6Gsur//Uy5HtGyRquj+6WzMQhjbKj3vQHDduoYT
         nHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742723391; x=1743328191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtl4aMOEbfVOV1/Eu8J0ZwV0cESQwszhmL0cG268KPo=;
        b=i/QFQaRl4YflfLWkxb7X/m891V5XBjVzgZ6fXERz0xYfJD++VLGEjcMR+l35CvFfzI
         TO/klIUecLgWoMiGs+CwNEfe0GbiQAMpLlykK9Qw1RxcYL80h7GGKqlXOrNen6NTzsqf
         l7AB4SfvJWtioRgaa1PW2Kr5AgBdKDQ6IluBoCTIKiFDCUs8J7zhpUPzKC47FJvwX0w0
         xymQ8KzkxkYJGN/RVbIImy+GzmTzP+i7eq9dmbAeWXjM2LOfwwgsTLMMIJ/WM3tPWXqK
         c0yh2U/q6J0CM30vQu29dVXzoOI1i7CHypJWC+/n4wealHAfTq11hcq4j6RWLAAoCL8O
         UO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrPM3tvZgYlLtN1pmHU0m0feiUxc0f5G0XTxixd++14c0avtl6Cj1WLjOuI5+1W6rmEhYyERf0yBSi@lists.infradead.org
X-Gm-Message-State: AOJu0YyPU9Mz7ULQt8NSvncBxaB56yQcOENV+Aogb+cCRAjVWYff7Whq
	f2tdOdAx99L/QXUuPAMBpG7lX7jImb6dxHl8atldWU2Rew0iMYYMbpkeWOj9LH7TOWwz6N41+9Q
	dao0rPT0ve9q6ar7sXAC1HV8xDl0=
X-Gm-Gg: ASbGncshFSueVi8+2VNN5/XodwgtnOlA87o8krDbXnbakmnCrWnFSEwF2b/cqaW/sAR
	XvdK5BvIc+S8hoIaL96AEvWjF18u+pRLo6drz43oBQwK1QBaB1ebBYzOQUrkInhhF13LaKJwZ3Q
	iWiBGttE84gqZXejo6PDpnQyHvoUIK
X-Google-Smtp-Source: AGHT+IFbAl12hGCj2PVn2R4kzM0/iVrZhywz5UfVG+Lep2sLGwhL+4qnhCJvzW2eWiZaBz44180IIgiem78C1Cc7ib4=
X-Received: by 2002:a05:6830:620b:b0:72b:7cc8:435 with SMTP id
 46e09a7af769-72c0af0c2f2mr6743315a34.24.1742723390919; Sun, 23 Mar 2025
 02:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>
 <Z8m9AbD3tjNpBt6p@kbusch-mbp>
In-Reply-To: <Z8m9AbD3tjNpBt6p@kbusch-mbp>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sun, 23 Mar 2025 14:49:40 +0500
X-Gm-Features: AQ5f1Jqdg6rQH9CczdkRGALGwIfqDyOG2EaR3hIqmo1zElkNd9miN3R3DAWLx2Q
Message-ID: <CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCxQRO7cjPtgWg@mail.gmail.com>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
To: Keith Busch <kbusch@kernel.org>, mlombard@bsdbackstore.eu
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-nvme@lists.infradead.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250323_024952_857050_CDDFB6DF 
X-CRM114-Status: GOOD (  28.86  )
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

On Thu, Mar 6, 2025 at 8:19=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Jan 15, 2025 at 02:58:04AM +0500, Mikhail Gavrilov wrote:
> > Hi,
> > During 6.13 development cycle I spotted strange new nvme errors in the
> > log which I never seen before.
> >
> > [87774.010474] nvme nvme1: I/O tag 0 (3000) opcode 0x1 (I/O Cmd) QID 1 =
timeout, aborting req_op:WRITE(1) size:131072
>
> ...
>
> > I still haven't found a stable way to reproduce this.
> > But I'm pretty sure that if this error don't appearing within two
> > days, then we can assume that the kernel isn't affected by the
> > problem.
> > So I made bisection with above assumption and found this commit:
> >
> > beadf0088501d9dcf2454b05d90d5d31ea3ba55f is the first bad commit
> > commit beadf0088501d9dcf2454b05d90d5d31ea3ba55f
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Nov 13 16:20:41 2024 +0100
> >
> >     nvme-pci: reverse request order in nvme_queue_rqs
>
> The patch here uses the order recieved to dispatch commands in
> consequetive submission queue entries, which is supposed to be the
> desired behavior for any device. I did some testing on mailine, and it
> sure looks like the order the driver does this is optimal, so I'm not
> sure what's going on with your observation.
>
> Do you have a scheduler enabled on your device?
>
> How are you generating IO? Is it a pattern I should be able to replicate
> with 'fio'?

Sorry for not answering for a long time, but all because I was testing
the off-list patch that was sent to me by Maurizio Lombardi.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 950289405ef2..990d9ef1eef9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue
*nvmeq, struct rq_list *rqlist)
 {
        struct request *req;

+       if (rq_list_empty(rqlist))
+               return;
+
        spin_lock(&nvmeq->sq_lock);
        while ((req =3D rq_list_pop(rqlist))) {
                struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);

And I want to say right away that this patch solved my problem. I
double checked, and both times the system worked for 4 days without
errors:

nvme nvme0: I/O tag 960 (33c0) opcode 0x2 (I/O Cmd) QID 7 timeout,
aborting req_op:READ(0) size:16384
nvme nvme0: I/O tag 961 (33c1) opcode 0x2 (I/O Cmd) QID 7 timeout,
aborting req_op:READ(0) size:8192
nvme nvme0: Abort status: 0x0
* * *
nvme nvme0: I/O tag 960 (33c0) opcode 0x2 (I/O Cmd) QID 7 timeout,
reset controller

and subsequent freezing of some applications.

> Do you have a scheduler enabled on your device?
No. nvme0 is server-tire 30TB SSD.

> head /sys/block/*/queue/scheduler
=3D=3D> /sys/block/nvme0n1/queue/scheduler <=3D=3D
[none] mq-deadline kyber bfq

=3D=3D> /sys/block/nvme1n1/queue/scheduler <=3D=3D
[none] mq-deadline kyber bfq

=3D=3D> /sys/block/sda/queue/scheduler <=3D=3D
none mq-deadline kyber [bfq]

=3D=3D> /sys/block/sdb/queue/scheduler <=3D=3D
none mq-deadline kyber [bfq]

> How are you generating IO? Is it a pattern I should be able to replicate =
with 'fio'?

It's very complicated. Because it happens only when I update (podman
pull) a large (16 GB) Docker container.

$ podman images
REPOSITORY                                                   TAG
      IMAGE ID      CREATED       SIZE
dev-image-store.my-company.com/local-stand/service  25.2100-latest
513139713b48  19 hours ago  16.5 GB
dev-image-store.my-company.com/local-stand/service  25.1220-latest
920708d4b3dc  9 days ago    16.8 GB
dev-image-store.my-company.com/local-stand/service  25.1220
67d2af91f323  10 days ago   16.8 GB
dev-image-store.my-company.com/local-stand/service  25.2100
24e6817bff52  3 weeks ago   16.4 GB

Podman stores its images on the 30TB BTRFS partition located in /home.

--=20
Best Regards,
Mike Gavrilov.

