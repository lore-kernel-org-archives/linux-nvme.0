Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A87C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 06:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fj9T88LMPhq/W+gZT33BiRBrppqEGmCqVmZ8hLdHzvk=; b=IgqxY/CqIBq0hvj18ROMdM6Mkv
	7ch3BA/8Ilea8FPBiUVvRua+gJVcsDaF4elW6caejjo64N+6/u6+l8lqiXiUiyWNpCDlQcPhyKwZz
	NyTHR1PKFLawcKSEH1oSh0amXYQHOiVxVVicjz185Lx32WgxZMFxeC6dSJ80qTh6n3CVoW0tOXW90
	Qu0L4HnMfYMiX+WvlUn+ClYkwWWpvqOwGFk/RGD1nA9MBqiiwmYWHHRUygMoHLAR3G5aXessZO2QD
	pUgpAteKruS6Kz14SlIUUzlEnAilnt4yk0qEQRviMfG2t+xoFjXvEAurxaEEPVOC0+gyyGTG0rLF6
	i56GY4Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzVxm-00000002oza-1bkb;
	Wed, 24 Apr 2024 06:18:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzVxk-00000002oz6-0n21
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 06:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713939513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj9T88LMPhq/W+gZT33BiRBrppqEGmCqVmZ8hLdHzvk=;
	b=hfrY+lPAIFjmji3Y+r43lASfL5fl+SA67b6w4ax5ilNYFwYs99jYzrAPa+j6EAa85LtTs/
	QrC0ic/k5FtNzLE7lxZvW+k/ySMKZ+Y9z3XdlG/BdWJjAD/Z+u/rN4+7cWHwN4mZLSLdeG
	cgY8F05VLOwjmhIZNhCqMb2NPrG/ZjM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Ad9OzVoIPyWvTQ70aXGR0w-1; Wed, 24 Apr 2024 02:18:31 -0400
X-MC-Unique: Ad9OzVoIPyWvTQ70aXGR0w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2adb84b10c1so491812a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 23 Apr 2024 23:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713939510; x=1714544310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj9T88LMPhq/W+gZT33BiRBrppqEGmCqVmZ8hLdHzvk=;
        b=EoMDrc1MpIozl6KfQMnN4KHhV2hGuJe1/Zwcu6qlD0d4Wk4SvBr9yt+Nt0VzxXYIFw
         4zW03GYOQ0HEhpyhIYwX9GcLwim4hqh8gsduLGYneaKvL2/Jv2gfGcYCOfpt01Vps02D
         XA5Lo8AEop6G+RYasVbHp1R5N6ZkwKbrBqDBwU6ftz7Ou1P461WFkQXnBf4x6U6AXKSE
         f/NFu6rxvUv+MgMHNwqT4XHMv3mVK92K4dQrBhMVS79kgDXZ7SEXHz0E+mZt6ZHupVwJ
         Y7YGeil8NevsNLB8DRqsbZTXFK9VmLCn9uah/X9CQZfX0UhaUCqSgYNIy8lZhiShTZ8+
         CMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHlvbZpBQvqPyvzM77Bf+jdt9MwtTlizE3QWyVdVeGvq+Cj9dQuc2GdMJJ7EcCZrHJ2ozF0sRPxcHhBGeyguTtwraUEjBRrs5aT1L5bI=
X-Gm-Message-State: AOJu0YzgtEOO+w/bk9QS+ZLcarG9XI9Su9OdokSWaJ11+M8CZncvJcL2
	NVFBgsEhj/BtJNGLO4UwI3lWC2jGI/5WKHflAs4aRtr6En8T+NHyD2erf4d6PtXhV1bdWKP4eim
	I5EMhYXUi7S7ne0Wod79h9Cs/A0JY8CIJ1tc8VRVX9jTxUqGTd4beBSOJa7rg+KZjMVh2/N5wfe
	odb60WhewLoX77JJrXIWSON2LEdFkw92M2TU2Qk4w=
X-Received: by 2002:a17:90a:6b46:b0:2ab:5348:67b7 with SMTP id x6-20020a17090a6b4600b002ab534867b7mr6129219pjl.22.1713939510077;
        Tue, 23 Apr 2024 23:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9wWgmw2dl9RZIhC6/CyxCOvEM4nlYoKGb4EXkY4KHzA5kZYg7iBlr7R24KI1aw5OE80MOAfvxEhMir1pERw=
X-Received: by 2002:a17:90a:6b46:b0:2ab:5348:67b7 with SMTP id
 x6-20020a17090a6b4600b002ab534867b7mr6129203pjl.22.1713939509708; Tue, 23 Apr
 2024 23:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com> <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
 <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com> <54666822-4e7f-4ec2-982b-541380cec154@grimberg.me>
In-Reply-To: <54666822-4e7f-4ec2-982b-541380cec154@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 24 Apr 2024 14:18:16 +0800
Message-ID: <CAHj4cs9paSVXQFoFCc2N3DkcUA18cAn9D=q61Gh=W0n3zaFndA@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_231836_336048_655D3046 
X-CRM114-Status: GOOD (  27.71  )
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

On Mon, Apr 22, 2024 at 6:46=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 22/04/2024 7:59, Yi Zhang wrote:
> > On Sun, Apr 21, 2024 at 6:31=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> >>
> >>
> >> On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
> >>> +linux-nvme list for awareness ...
> >>>
> >>> -ck
> >>>
> >>>
> >>> On 4/6/24 17:38, Yi Zhang wrote:
> >>>> Hello
> >>>>
> >>>> I found the kmemleak issue after blktests nvme/tcp tests on the late=
st
> >>>> linux-block/for-next, please help check it and let me know if you ne=
ed
> >>>> any info/testing for it, thanks.
> >>> it will help others to specify which testcase you are using ...
> >>>
> >>>> # dmesg | grep kmemleak
> >>>> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
> >>>> /sys/kernel/debug/kmemleak)
> >>>>
> >>>> # cat kmemleak.log
> >>>> unreferenced object 0xffff8885a1abe740 (size 32):
> >>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>>>      hex dump (first 32 bytes):
> >>>>        c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.........=
....
> >>>>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
> >>>>      backtrace (crc 6328eade):
> >>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>>>        [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
> >>>>        [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
> >>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>>>        [<ffffffffc262a881>] 0xffffffffc262a881
> >>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> >>>> unreferenced object 0xffff88a8b03647c0 (size 16):
> >>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>>>      hex dump (first 16 bytes):
> >>>>        c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.........=
....
> >>>>      backtrace (crc 860ce62b):
> >>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>>>        [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
> >>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>>>        [<ffffffffc262a881>] 0xffffffffc262a881
> >>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> >> kmemleak suggest that the leakage is coming from lo_read_simple() Is
> >> this a regression that can be bisected?
> >>
> > It's not one regression issue, I tried 6.7 and it also can be reproduce=
d.
>
> Its strange that the stack makes it look like lo_read_simple is allocatin=
g
> the sgl, it is probably nvmet-tcp though.
>
> Can you try with the patch below:

Hi Sagi

After re-compiled the kernel on another server and can find more symbols no=
w[1],
With your patch, the below kmemleak issue cannot be reproduced now.

[1]
unreferenced object 0xffff8881b59d0400 (size 32):
  comm "kworker/38:1H", pid 751, jiffies 4297135127
  hex dump (first 32 bytes):
    02 7a d6 06 00 ea ff ff 00 00 00 00 00 10 00 00  .z..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5be147ba):
    [<00000000dbe27af4>] __kmalloc+0x41d/0x630
    [<0000000077d4a469>] sgl_alloc_order+0xa9/0x380
    [<00000000f683c92e>] nvmet_tcp_map_data+0x1b9/0x560 [nvmet_tcp]
    [<00000000527a09e7>] nvmet_tcp_try_recv_pdu+0x9d0/0x26e0 [nvmet_tcp]
    [<00000000521ae8ec>] nvmet_tcp_io_work+0x14e/0x30f0 [nvmet_tcp]
    [<00000000110c56b5>] process_one_work+0x85d/0x13f0
    [<00000000a740ddcf>] worker_thread+0x6da/0x1130
    [<00000000b5cf1cf3>] kthread+0x2ed/0x3c0
    [<0000000034819000>] ret_from_fork+0x31/0x70
    [<0000000003276465>] ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8881b59d18e0 (size 16):
  comm "kworker/38:1H", pid 751, jiffies 4297135127
  hex dump (first 16 bytes):
    00 7a d6 06 00 ea ff ff 00 10 00 00 00 00 00 00  .z..............
  backtrace (crc 9740ab1c):
    [<00000000dbe27af4>] __kmalloc+0x41d/0x630
    [<000000000b49411d>] nvmet_tcp_map_data+0x2f6/0x560 [nvmet_tcp]
    [<00000000527a09e7>] nvmet_tcp_try_recv_pdu+0x9d0/0x26e0 [nvmet_tcp]
    [<00000000521ae8ec>] nvmet_tcp_io_work+0x14e/0x30f0 [nvmet_tcp]
    [<00000000110c56b5>] process_one_work+0x85d/0x13f0
    [<00000000a740ddcf>] worker_thread+0x6da/0x1130
    [<00000000b5cf1cf3>] kthread+0x2ed/0x3c0
    [<0000000034819000>] ret_from_fork+0x31/0x70
    [<0000000003276465>] ret_from_fork_asm+0x1a/0x30

(gdb) l *(nvmet_tcp_map_data+0x2f6)
0x9c6 is in nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:432).
427 if (!cmd->req.sg)
428 return NVME_SC_INTERNAL;
429 cmd->cur_sg =3D cmd->req.sg;
430
431 if (nvmet_tcp_has_data_in(cmd)) {
432 cmd->iov =3D kmalloc_array(cmd->req.sg_cnt,
433 sizeof(*cmd->iov), GFP_KERNEL);
434 if (!cmd->iov)
435 goto err;
436 }
(gdb) l *(nvmet_tcp_map_data+0x1b9)
0x889 is in nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:848).
843 }
844
845 static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
846 {
847 queue->offset =3D 0;
848 queue->left =3D sizeof(struct nvme_tcp_hdr);
849 queue->cmd =3D NULL;
850 queue->rcv_state =3D NVMET_TCP_RECV_PDU;
851 }
852

> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a5422e2c979a..bfd1cf7cc1c2 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -348,6 +348,7 @@ static int nvmet_tcp_check_ddgst(struct
> nvmet_tcp_queue *queue, void *pdu)
>          return 0;
>   }
>
> +/* safe to call multiple times */
>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
>   {
>          kfree(cmd->iov);
> @@ -1581,13 +1582,9 @@ static void
> nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>          struct nvmet_tcp_cmd *cmd =3D queue->cmds;
>          int i;
>
> -       for (i =3D 0; i < queue->nr_cmds; i++, cmd++) {
> -               if (nvmet_tcp_need_data_in(cmd))
> -                       nvmet_tcp_free_cmd_buffers(cmd);
> -       }
> -
> -       if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
> -               nvmet_tcp_free_cmd_buffers(&queue->connect);
> +       for (i =3D 0; i < queue->nr_cmds; i++, cmd++)
> +               nvmet_tcp_free_cmd_buffers(cmd);
> +       nvmet_tcp_free_cmd_buffers(&queue->connect);
>   }
>
>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
> --
>


--=20
Best Regards,
  Yi Zhang


