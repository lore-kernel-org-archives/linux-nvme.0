Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B640C61DBD
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 03:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=; b=212yGYRv5GBGtiFlzgBv4HXx+f
	ZgSu+oFd9XShMtVPPnbCmbE3B/u4CxnWKhuetxBOM6fA0SO5sjFsHZmPZq6x8mfpaIkXa8IGxiMxh
	xCbk7Rb36HSTe1kB39OQ80IY+2umTRTkAKImPvxKblcV0mU8pduayXeE7vwolgIiYB6KCNotY9c6s
	v95SMZ+6SqR39vref4S8MbSANXg3XqshLkXIOitNfdwb60VdISSxxiwIAJ99nNqdO5PT0BMcMOYgd
	lu5KddMma7lUF6GS/SLaHGvZ2Or//IpgNJykJQN/P/K0g9aaK2TrSsDyjUFebscFJ0KCHvrDbey0z
	DT6qqlgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wznLy-000000054A5-46m4;
	Fri, 28 Aug 2026 03:34:06 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wznLs-00000005496-1T06
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 03:34:01 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso192996a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 20:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787888039; cv=none;
        d=google.com; s=arc-20260327;
        b=c7KAgSfnlrQ1e0vm8zEoy54d9M4fzA74KJRotuaI0lFKMZv1+IFoyN+jE8cHIyl49g
         plPPQVROrFPqRs9A9sVsdKcssgBPyexAfSsg7CA9vpDAhErPm4Aahc94laEYVRd4tKtf
         JFzM5I56MbsV2ZJIscmZCYCZ2a45O1I0SQeBFmlWQeLMf1kp7ZygaVeO085An9HdVqEG
         IXSRXGFRh8qaCjly1DadfihMWcWvegk11OLADii8REt4ZOqvQZU3GCp0Rd9hSrS18MTd
         lCEgF//KWOupRTydh4Uev+DGSHlXbxDEN0XRJwuk0pNywCjIWAgImTnjpnaSZlhrW4kG
         79QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        fh=nqTudy4fQYf8aOU3WAW5wUUPC2UV72dhW8ktwApPMBw=;
        b=HYHxOO3BCTxq7omcOO+qhEqNMpSpz7hNIBbeVnEmVRMtXCnmiK5vuC6RmBzwzWRXHD
         zjTHdD2xinXXTMgnKifEN4VT4PdnwahQ13P312c6b5H9YWDzLve3JxKxWijIAdfoJtEF
         TIAZTB7781mQrLu7+ksBFUwWart5AT+9tpaUc1FkLGEf4jUVly1aFLO8pLaqBI/8hOv4
         NJfw7IOS/gid/HjXMwEOWUAvl5UPtMA32CzWAGDS7nJ4KV7DvAeXIWGEYNWSnQoO9pk/
         4FobLb/Mh/OizWKJrZ9D4HB5h+SFV0JjpRT6ARRIjSM+mcCtQPLNQUkjhqdxYVa88ahl
         i+iw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787888039; x=1788492839; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        b=lkp9Yow1BNnC6SXaNvJpLgFxLzyGdC0P7IqpLDCJ/VQE6vbL7UZKO/CLLEijbtYiXx
         mw9WbnXw52UWrnyh34ZKpbs5rxdgYfdY16YV4bGduWG2LVYInslt3qt4dMkKljcZkgzH
         2CKvj/6LZc23882C+/q5x2DEu/aZTIzofp5dVBQ6wXM6LgKVx+LtRlHk6qf6hnHCz/ug
         wHePznnmBAqA8mscMiGtE8SjyMkXGQYt8HKvZJu//MQ19zbcxDWPyir9v2zTvHXH0mOw
         i3mF0o3vFIRpJXvct5AcBii6RMbdCyycXH55ZmcJR0L4Qz/ujomipp52nbIAWcNOyIKi
         +1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787888039; x=1788492839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        b=mgX+yLGTqqvUxwQAf+yqogTK9HTQ1v9GtCJYGhyuI4gfQIIVsrkHj7JRt4MzNpzz9+
         7VTWoEZYvk1G0+W/xyLbIjt0RMuMBrgzUoqBsvxQ9kcwsyUVWlBBsiTGRIiavl0UASkC
         BIBdSOo8691GILYL01atrSrJ8196aXld+IriPifHlDxq2Ge77ABHRulJyDSwkO1WghDP
         70T0FFPVpt3vBqxaqkcfaNz2qUy2lVVZaXyuShn3pxa7QaExtPf2SfMi6emVZe+xKv4c
         Q2fniiQExWVUjiYpKT+GrTly9UG50rHTGngAL6GVfDysSsvwyJZkSOTwA5/fuhJ26Hae
         baug==
X-Forwarded-Encrypted: i=1; AHgh+Rr/XdMK90SprbhiXLewfnjtZNqvbCeZINUFpRkvuiV4EG8rKCp7PJCCu6jPltM+0xoqcI6aDdnp+zHb@lists.infradead.org
X-Gm-Message-State: AFuF++naE8mpFpLJxXbYi+ZvyONDKP8qyWigyQ8M2V/Yg+O8Zru5ROHe
	3tyWVacLNxGwGwjved/VC31EuYzSTbD4OZ16B2rju/QhJCEpEUzaLDc6+1t7sRgPs2T51giwVrW
	j9N6SMLdcrMYwPVSUGz9mkrDqRxM2dsE=
X-Gm-Gg: AR+sD12L4+1nSjvcK5fshNuf7TUX+scfD4KjGylTZhk0YK+Fz0GIIz71c4wIpB/5+Vs
	rtJLajbwvDsgce7+UcYjbISGqhXyZWMm5cfVeqvmYvNKNe/08zftOOjIsJyrckSAOgJdacivRqp
	LM2VTBsVi69hbe2hZsBRN8JmO0zRRvN7bL4MVxOKZFhhpoOZ9z51vSGaogN03b9ghtKdtyItGYv
	hPLtUedEFQ6t3KxiPcYCewzbheZ1Xpldtm2LWDByteaOAEU0Y/mXHkvcVhX+FoO8O8ZGFbFtjCZ
	kqsethdcHnKKoN1Op3526gY8whIN9lGgJvGX4+KABlWHeC3X6IYuLprIou0JyIPeGOEuu4AkKT5
	xWYcY0viBIuRyAa804VwjO8gC6zfixw468p3LTUfK8HxE
X-Received: by 2002:a05:6820:340e:10b0:6b1:67e1:fc8e with SMTP id
 006d021491bc7-6b1c66e6ce5mr2559540eaf.25.1787888038951; Thu, 27 Aug 2026
 20:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com>
 <20260827185722.3234622-2-csander@purestorage.com> <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
 <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
In-Reply-To: <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 27 Aug 2026 22:33:46 -0500
X-Gm-Features: AcwNN1V96G10EnqkMmlBEbQoJ8ihVOlJhML3SIuW3TsrH3jrmu0CBU7aGovmtII
Message-ID: <CACVXFVOLBVVGwfo+mbn+4jnGKZS66dL_2ghsKiaT6buscWJg6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_203400_394938_1C9B5576 
X-CRM114-Status: GOOD (  22.46  )
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

On Thu, Aug 27, 2026 at 4:44=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Aug 27, 2026 at 1:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Hi Caleb,
> >
> > On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > In preparation for setting the io_uring NVMe passthru CQE results fro=
m
> > > the blk-mq request completion rather than the task work callback, spl=
it
> > > out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}=
().
> > > This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> > > consolidated into a single CQE-size-agnostic function with 3 fewer
> > > arguments than __io_uring_cmd_done().
> > >
> >
> > The conversion looks logically correct to me but the interface feels a
> > bit annoying / fragile on the caller side.
> >
> > Is there a way nvme can get what it needs without changing the other
> > callers? Would it work to just keep the existing
> > io_uring_cmd_done{,32}() as is and add a separate API for special
> > callers like nvme, eg:
> >
> >   void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 re=
s2);
> >   void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_fla=
gs);
> >
> > where io_uring_cmd_done{,32} would then just be inline wrappers over
> > those? afaict, then only the nvme callsite would have to change and
> > fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
> > think something like that makes sense to do?

Yeah, this way is definitely much better from a driver viewpoint.



Thanks,
Ming Lei

