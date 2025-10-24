Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C74CCD1A5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 03:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=; b=pv1m4+P5uUAIwdWgECXrVREAKq
	X2W7GouF9CXH0Bhhbeihev8QPSwbNff8n3UfGbikngVHT7Op4s4x/wXuY2QzsenwF4AuufPXgxw6F
	CkJGlHdrOhiFwbjxBq+dlus3JqReovw8dxk/Lo6TfEItIjltq8UTQAS7JUpg1YJy26YZROudJNzio
	d0dBgQMiXq3iuYsej23N9tRNU9OjblCc7Z7oQwT8SHtwSpXfdNYhblH0mLGben3q+DqYezw8Eee6g
	QgoyDEHYnbxqKf7dmpJEWXFVzjtnM/SWkGK2knfZSgC6cAv2sk+vh9injkJWOzkLBUheXk4Ed7wkM
	FjcY7AgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8oP-00000008Atv-0lJR;
	Fri, 24 Oct 2025 03:49:57 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8oM-00000008AtV-13sm
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 03:49:55 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-29245cb814cso2694995ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Oct 2025 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761277792; x=1761882592; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=SRJoj0CJspz8p/p5ka1oMtjEjVnrVB570nR66LqP4wXSFzWN2nqQq2NFuD3zZ8rx5g
         d+AYs2EkzC3Xme2XP2v4S71QeZAhuj6/OiO8M6t2+FUOLOgkP64KX9QsQc3et1FCk5Iv
         Qga1qbD2105XSxzEy4izGA5eGz60EN9ktnHq+GH5e1QiVqf819wA7KUXBwprhh2cdqas
         Szj4hI6vVsmBgPsWUMFHw6opD06VDqJAYXHRPvNdr87qiri+LsNhAzsmqm2rKbx1+TOn
         +uduzth+GovX5Ey7Oo1w9L3jtqivTb0Cau4KA7e1O3h4ZwCuaO+pDXb+iy8qw1nrbptk
         wtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277792; x=1761882592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=QotV8Ww+5Qm9YenLnyCq+Vt8I17oMVB6LPe3Z6HF24Yx+h64+2QqVdIiDduEz5LYYH
         JpLGIElMkyhE4RkHjGcK/dNg+VvMyYI3DYDgd/OW3wLqRJ425P6anG51baBRovd6JrHF
         ndF83lOtOlqDLSUcEYgrp7+oRFMfGSbeTZyqDbPIjNfTE6P3br8uMaTpqCeOWlkyLxEV
         lqgPgLeyYszGB5kU91dD+0UCb1GZP8YbW7KJ8egeJe3S0X3HYyiAbSkvfrnkt3RTch6q
         /HLy9EWrgpfP1WL0PG9yX7Lax9zcb7G3N0OGFhJrg6g2sTFdWlJVTh3WvJ2ePcXGhGzb
         veRA==
X-Forwarded-Encrypted: i=1; AJvYcCVpevwzF8pjnUVmddfs5V7gbgyDWNwaR/FQcV6Ba9GK+gYkjrKnaP9AsgGuYqbcfrYK+nbJpRVG0d7k@lists.infradead.org
X-Gm-Message-State: AOJu0YwuQU7nLYjhUETeo8rxXZ7iuoTGcXWX9AmcyYdj88FgdzW14/y3
	IaZZU3XvZVnr18z6wMiT58MVUx07vrp0rJnkSmzbmlsvBV0x15GrRzOCR15GxzGxccmAtxJWluD
	HY2Kq5XPYEfIqmimnWe50qExw1T5hy/veBl0fRWZ0kQ==
X-Gm-Gg: ASbGnctvVprdXR3oa9rePGgqVC8+G4usD6sg2qlzVnbZ5Rql5SJN+PBcsHXEAtzt6Wu
	Bxf8Tn9eaOF+wHkXYYlqsd3E5XULqYIYTB5L+g2dSWEhMp4mg1/NeWQzVkf3fgTvYbwc2Gva4+R
	fdR69yziCAein0ntwwwuZoOKyMdwxSXebhXMdjedxGKDsoNY1vbptkWjrj6a2K1xVh+iHivb05a
	Ike+JF9qiEkGGx/b8UwNRnq+U+XIGrSos6idRJjXhVF91xHhUv6dk+js3ewA13gLOr2eud8Bmmm
	Fez88ALwOtztsjoieF6awOz0XouT
X-Google-Smtp-Source: AGHT+IGVLYN9Qj6K5Oe/DW7c2O9tXpDx7qrMeaGk8fBmXzVZ28GOkgKOMdnoBQ6ElA4mEZO6qJsf1CoAlmZoTYuCH80=
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-292d3fb7f47mr85578795ad.7.1761277792499; Thu, 23 Oct 2025
 20:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-4-csander@purestorage.com> <aPr1i-k0byzYjv8G@fedora>
In-Reply-To: <aPr1i-k0byzYjv8G@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Oct 2025 20:49:40 -0700
X-Gm-Features: AS18NWDTISZzm2iqXdmRxUGBIwGGbwvM87S0nOqV0xhWOuEGVlx6sx6Z4Yq4U7g
Message-ID: <CADUfDZp21icTKrWHcgRTfmsxtdab85b6R75wAYXW2dA+dzXmoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_204954_335765_4809B71E 
X-CRM114-Status: GOOD (  31.71  )
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

On Thu, Oct 23, 2025 at 8:42=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Oct 23, 2025 at 02:18:30PM -0600, Caleb Sander Mateos wrote:
> > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > io_task_work.func field to allow running arbitrary task work functions.
> > In the uring_cmd case, this calls io_uring_cmd_work(), which immediatel=
y
> > makes another indirect call to struct io_uring_cmd's task_work_cb field=
.
> > Define the uring_cmd task work callbacks as functions whose signatures
> > match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
> > constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
> > uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
> > single indirect call to the uring_cmd implementation's callback. This
> > also allows removing the task_work_cb field from struct io_uring_cmd,
> > freeing up some additional storage space.
>
> The idea looks good.
>
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  block/ioctl.c                |  4 +++-
> >  drivers/block/ublk_drv.c     | 15 +++++++++------
> >  drivers/nvme/host/ioctl.c    |  5 +++--
> >  fs/btrfs/ioctl.c             |  4 +++-
> >  fs/fuse/dev_uring.c          |  5 +++--
> >  include/linux/io_uring/cmd.h | 16 +++++++---------
> >  io_uring/uring_cmd.c         | 13 ++-----------
> >  7 files changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index d7489a56b33c..5c10d48fab27 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsig=
ned cmd, unsigned long arg)
> >  struct blk_iou_cmd {
> >       int res;
> >       bool nowait;
> >  };
> >
> > -static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int is=
sue_flags)
> > +static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
> >  {
> > +     struct io_uring_cmd *cmd =3D io_kiocb_to_cmd(req, struct io_uring=
_cmd);
> >       struct blk_iou_cmd *bic =3D io_uring_cmd_to_pdu(cmd, struct blk_i=
ou_cmd);
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> Now `io_kiocb` is exposed to driver, it could be perfect if 'io_uring_cmd=
'
> is kept in kernel API interface, IMO.

You mean change the io_req_tw_func_t signature to pass struct
io_uring_cmd * instead of struct io_kiocb *? I don't think that would
make sense because task work is a more general concept, not just for
uring_cmd. I agree it's a bit ugly exposing struct io_kiocb * outside
of the io_uring core, but I don't see a way to encapsulate it without
other downsides (the additional indirect call or the gross macro from
v1). Treating it as an opaque pointer type seems like the least bad
option...

>
> ...
>
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index b84b97c21b43..3efad93404f9 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -9,18 +9,13 @@
> >  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
> >  #define IORING_URING_CMD_CANCELABLE  (1U << 30)
> >  /* io_uring_cmd is being issued again */
> >  #define IORING_URING_CMD_REISSUE     (1U << 31)
> >
> > -typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
> > -                               unsigned issue_flags);
> > -
> >  struct io_uring_cmd {
> >       struct file     *file;
> >       const struct io_uring_sqe *sqe;
> > -     /* callback to defer completions to task context */
> > -     io_uring_cmd_tw_t task_work_cb;
> >       u32             cmd_op;
> >       u32             flags;
> >       u8              pdu[32]; /* available inline for free use */
>
> pdu[40]

I considered that, but wondered if we might want to reuse the 8 bytes
for something internal to uring_cmd rather than providing it to the
driver's uring_cmd implementation. If we increase pdu and a driver
starts using more than 32 bytes, it will be difficult to claw back. It
seems reasonable to reserve half the space for the io_uring/uring_cmd
layer and half for the driver.

Best,
Caleb

>
>
>
> Thanks,
> Ming
>

