Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CFEC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Apr 2024 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+3e3eCGo4nm9dz8UhyegFl/LK0wMJ1Vd0lLDqclVzw=; b=1fvEOgnnB7Hc8nkdB482yCkZs2
	X+OBnzs3gHSUTK1WJBg8pIdBqYZ47Z+OwAZFndyML8lFmKXyllH+uEc/Vv2NxtqK6du2M7knDH5DC
	juGFVkJOVpvz2Zbt7hTDmdOwamBQIxDXilImoQoNdvHaI8mZKCg6Ge/hukeTJ6gHatOVOxnXQe6IT
	9o69dABwKql8l4rCQdwUCxrhCVPuO28yA7iN7Gz7Y03mBdGRR//789FTiGoLq1vUFZJeXUNoCV/gP
	Y0Jc2+x2VJeYFqOTI/p7w0XZ3zsFsbs27SSGVkc6rJ9i3VPThtNXBiDu/a7tYdpehVGJdP9uM4eNA
	YO+RZiDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxcgH-000000042WT-03Yh;
	Fri, 19 Apr 2024 01:04:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxcgD-000000042Vs-1C1Y
	for linux-nvme@lists.infradead.org;
	Fri, 19 Apr 2024 01:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713488678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+3e3eCGo4nm9dz8UhyegFl/LK0wMJ1Vd0lLDqclVzw=;
	b=NI/CqJI2VNM9R0ZnMZBfURPp3aoFb7cHguZ+1gd4KAPtqwsL6XKPiuXzG8d4xUCo1N0RGG
	mMnEQk7jonCooiTefEXFEnmRCDNrqucEIKDqQxr8/QDYri21lXVdXWcMB5rvFTHCnE7rmg
	/EQXjSehGSPh+TLPWM4GzgcPSCfu2xM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Kb5OtFBzP0KWtKI_j5UDhA-1; Thu, 18 Apr 2024 21:04:35 -0400
X-MC-Unique: Kb5OtFBzP0KWtKI_j5UDhA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c65e666609so1610221a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 18:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713488674; x=1714093474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+3e3eCGo4nm9dz8UhyegFl/LK0wMJ1Vd0lLDqclVzw=;
        b=cIaN0BS6D6HGxm1X/Dr3jE32yCMUIipTueAUdlwugRxGkHtw5ELZX83v+R9JeJ0ycI
         Cmw6DkO0D4Fxb5pf4y91hwH/rfhUOJn/ld0XaFzSyWm8byohG0mr1pix3f1QBtqR9hfi
         EmGahBcsxep6qMzflx9VG/I+qfz7XCRYK40FKV1DKSQsfXpRmF+xEQeaiiQhzFsiG3ku
         a2okGRmFZZZBl0DG7UuVhbjepco/hrKjJN1aSSj+JUOgTnLNpoXwuablFnNC+iOctnrS
         Zgpc5ukJx+xDMcvZFmVUuBBqvCFL8KwK08f3zeiv/lFLrJ+J+CjeXzIxZUsU6n+WZnUN
         Vh4g==
X-Forwarded-Encrypted: i=1; AJvYcCUgeihytjU1HbeVMb9FEAVcLwovHC1HqgwgNU7kUiyD59smREU25KQt1UFOf28egXv0msFqnRUb7J7vUw5XLDTuJ/Aw9iQ5GNm+LdM/HM4=
X-Gm-Message-State: AOJu0YzQycZjD4PcOdMaePZ6P/9267jmeVtC6L/ktNDaisbE7isTfu+P
	SXw0bHkkWnWTx4Ehegn3wf1t4/QxooETsWnpjwt/ijNNU7Wfp7w96QhGNbnuQ5j12U0XWtUiv3X
	A0nlCJKjH/8LHnoGe4x9TUYhRZdNQdtynGeFuW5zX0qSF/DqSD0Uk4r/qu9oFUAjLVQ2Ocp1th9
	YX0SkSQ0K55c3218EtMQqVbhm1TZHlhXMyspa8os4=
X-Received: by 2002:a05:6a20:dca0:b0:1a7:4e61:ebc9 with SMTP id ky32-20020a056a20dca000b001a74e61ebc9mr849520pzb.62.1713488673839;
        Thu, 18 Apr 2024 18:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE82T5xQIfeDjtrumOf6pdCljrW/8FBfXSroNFwimhM+1DeCA+JWLhS4X3+oNMWqcsCRv6HkoXcbK3SkYPjmlk=
X-Received: by 2002:a05:6a20:dca0:b0:1a7:4e61:ebc9 with SMTP id
 ky32-20020a056a20dca000b001a74e61ebc9mr849506pzb.62.1713488673429; Thu, 18
 Apr 2024 18:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
In-Reply-To: <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 19 Apr 2024 09:04:20 +0800
Message-ID: <CAHj4cs87PcOMVhapnisaje8bZEgHyBwq98FmtJ6z9O_CkLXfYQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_180441_425403_CD6AF41A 
X-CRM114-Status: GOOD (  18.41  )
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

On Tue, Apr 16, 2024 at 11:19=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> +linux-nvme list for awareness ...
>
> -ck
>
>
> On 4/6/24 17:38, Yi Zhang wrote:
> > Hello
> >
> > I found the kmemleak issue after blktests nvme/tcp tests on the latest
> > linux-block/for-next, please help check it and let me know if you need
> > any info/testing for it, thanks.
>
> it will help others to specify which testcase you are using ...

I finally figured out it was triggered by nvme/012, and after the
test, I also found some I/O timeout from dmesg, here is the log:

# nvme_trtype=3Dtcp ./check nvme/012
nvme/012 (run mkfs and data verification fio job on NVMeOF block
device-backed ns) [passed]
    runtime  303.431s  ...  384.831s
[40886.926741] loop: module loaded
[40887.798283] run blktests nvme/012 at 2024-04-18 20:29:53
[40888.220034] loop0: detected capacity change from 0 to 2097152
[40888.320215] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[40888.442496] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[40888.685458] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[40888.703682] nvme nvme0: creating 48 I/O queues.
[40888.843827] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[40888.999828] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[40890.194368] XFS (nvme0n1): Mounting V5 Filesystem
064bbcf2-489b-4e7e-b264-a304e656990c
[40890.310950] XFS (nvme0n1): Ending clean mount
[40950.620522] nvme nvme0: I/O tag 49 (a031) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.628389] nvme nvme0: starting error recovery
[40950.633351] nvme nvme0: I/O tag 50 (8032) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.641915] nvme nvme0: I/O tag 51 (4033) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.649588] nvme nvme0: I/O tag 52 (1034) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.657313] block nvme0n1: no usable path - requeuing I/O
[40950.662841] block nvme0n1: no usable path - requeuing I/O
[40950.668484] nvme nvme0: I/O tag 53 (f035) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.676141] block nvme0n1: no usable path - requeuing I/O
[40950.681648] nvme nvme0: I/O tag 54 (a036) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.689323] block nvme0n1: no usable path - requeuing I/O
[40950.694913] block nvme0n1: no usable path - requeuing I/O
[40950.700372] nvme nvme0: I/O tag 55 (e037) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.707973] block nvme0n1: no usable path - requeuing I/O
[40950.713419] nvme nvme0: I/O tag 56 (6038) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.721007] block nvme0n1: no usable path - requeuing I/O
[40950.728055] nvme nvme0: I/O tag 57 (a039) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.735655] block nvme0n1: no usable path - requeuing I/O
[40950.741098] block nvme0n1: no usable path - requeuing I/O
[40950.746532] nvme nvme0: I/O tag 58 (c03a) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.754126] block nvme0n1: no usable path - requeuing I/O
[40950.760160] nvme nvme0: I/O tag 59 (303b) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.767822] nvme nvme0: I/O tag 60 (403c) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.775482] nvme nvme0: I/O tag 61 (703d) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.783139] nvme nvme0: I/O tag 62 (603e) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.790795] nvme nvme0: I/O tag 63 (303f) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.798465] nvme nvme0: I/O tag 64 (0040) type 4 opcode 0x1 (Write)
QID 25 timeout
[40950.806157] nvme nvme0: I/O tag 65 (1041) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.814373] nvme nvme0: I/O tag 66 (1042) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.822061] nvme nvme0: I/O tag 67 (1043) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.829735] nvme nvme0: I/O tag 68 (1044) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.837424] nvme nvme0: I/O tag 69 (1045) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.845108] nvme nvme0: I/O tag 70 (1046) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.852804] nvme nvme0: I/O tag 71 (1047) type 4 opcode 0x1 (Write)
QID 41 timeout
[40950.860677] nvme nvme0: I/O tag 80 (0050) type 4 opcode 0x0 (Flush)
QID 41 timeout
[40950.937368] nvme nvme0: Reconnecting in 10 seconds...
[40961.383043] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[40961.394978] nvme nvme0: creating 48 I/O queues.
[40961.922944] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[40962.017504] nvme nvme0: Successfully reconnected (1 attempt)
[41239.890559] XFS (nvme0n1): Unmounting Filesystem
064bbcf2-489b-4e7e-b264-a304e656990c
[41240.088647] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[41329.981146] kworker/dying (319) used greatest stack depth: 18384 bytes l=
eft
[41733.311055] kmemleak: 46 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)


>
> > # dmesg | grep kmemleak
> > [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> >
> > # cat kmemleak.log
> > unreferenced object 0xffff8885a1abe740 (size 32):
> >    comm "kworker/40:1H", pid 799, jiffies 4296062986
> >    hex dump (first 32 bytes):
> >      c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace (crc 6328eade):
> >      [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >      [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
> >      [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
> >      [<ffffffffc26287ef>] 0xffffffffc26287ef
> >      [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >      [<ffffffffc262a881>] 0xffffffffc262a881
> >      [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >      [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >      [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >      [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >      [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xffff88a8b03647c0 (size 16):
> >    comm "kworker/40:1H", pid 799, jiffies 4296062986
> >    hex dump (first 16 bytes):
> >      c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
> >    backtrace (crc 860ce62b):
> >      [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >      [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
> >      [<ffffffffc26287ef>] 0xffffffffc26287ef
> >      [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >      [<ffffffffc262a881>] 0xffffffffc262a881
> >      [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >      [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >      [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >      [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >      [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> >
> > (gdb) l *(lo_read_simple+0x1d5)
> > 0x66c5 is in lo_read_simple (drivers/block/loop.c:284).
> > 279 struct bio_vec bvec;
> > 280 struct req_iterator iter;
> > 281 struct iov_iter i;
> > 282 ssize_t len;
> > 283
> > 284 rq_for_each_segment(bvec, rq, iter) {
> > 285 iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
> > 286 len =3D vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
> > 287 if (len < 0)
> > 288 return len;
> > (gdb) l *(lo_read_simple+0x315)
> > 0x6805 is in lo_read_simple (./include/linux/bio.h:120).
> > 115 iter->bi_sector +=3D bytes >> 9;
> > 116
> > 117 if (bio_no_advance_iter(bio))
> > 118 iter->bi_size -=3D bytes;
> > 119 else
> > 120 bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
> > 121 }
> > 122
> > 123 void __bio_advance(struct bio *, unsigned bytes);
> > 124
> >
> >
>
> -ck
>
>


--
Best Regards,
  Yi Zhang


