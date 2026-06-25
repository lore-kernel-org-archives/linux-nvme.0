Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1F1CDE00B
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 21:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNJXObhuc80JJYRIbgz8YBrnkiKjNqPYQ1jYTpzRuWg=; b=zUBa/XtENoGdSWQ2Yizt/7JZrk
	O89xcbIqyLzV4OYeyYdVIiGHVdiGvX8dsZ5Sefgacee9/rfyHLmWKIG48CPBUVQqhbF4gHt8OQN2x
	V1shS3+oPEpBOPQOb2r3ovp1+zMFlMsIdKZZMmxScFaMunw/X66lEvC1pN6FqUjuThIauxMEUkbtZ
	STxk/KHJg28xh2ZZ4mALB1pA0m1L6Qg8RCgnMGfkz4iLRiqcY4+99GCTLCfmswgtNDk3VkZkSXOJy
	aZqndPsyAGHcq28d93wyEr3xr65+QISRyyRBSmWrq5sRN0yUlINlJE6H4gHGseFju5YYj7L0aNSHP
	x/BCigSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrFz-00000009ptV-3Q2I;
	Thu, 25 Jun 2026 21:05:07 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrFx-00000009pt4-21Zd
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 21:05:06 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-5174a3d9598so2284821cf.3
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2026 14:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782421504; cv=none;
        d=google.com; s=arc-20260327;
        b=SbSuxy9OqKxblBbshJS/WkPwQBxU6gGrP8DJiUyJ4EmEpveLujDnaPzntBawJgInuf
         dGHWKuLgR/GW+MHC0HH0wNHcHaAv7eHKarCdU2sHK2S6KK2UxoXwd9R2xflkqKahIFuL
         fqX5NITpm9x82tobjvF2q9vJ3sug6wpGmOThHIBUUSBBY3Ag4r4Gkuidx/gxU6c8AmS4
         9awM2KhCGguZcGgAAdjmyr3RkXiAO+dWgGVmk0xzMwa5WCgUD0Jf/tRyvSqHyyu0WHp4
         tTv1WLque9LeAGAZgGuFFkBUK2hz2x0oHjNyAa5hiL9aTZM4ZJXch7E6Jo8tOhELLe2P
         a8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nNJXObhuc80JJYRIbgz8YBrnkiKjNqPYQ1jYTpzRuWg=;
        fh=SPiOrL98yB6YSVcch5y6W/f5f0QFp/rD1tnm5ntekTQ=;
        b=XXKe+dTCRw5fpCJinbN2w3tp5tImwGus3y35AZZYB6DqumJd+/elA239G3Hg7uw4H0
         LAvC5Ch1SMsyBI+O/5xGIjoFNc5rWd5+lu9vWm6XwnJeofr7LBbv7ly5ES/BLoUfin3o
         l9/SoYmsw0Q55+Q3LcNU0XOjzFHk+50SJt/fQHsvkndd1d4QsC7JWFY4WA3G4sN06kLa
         N6gLfnFEpvKbR9AKlWF8WfTPyBaeJTJ7MSO0qxVuxUlKwMOIXyQEE9IlkFH0W9JVImNx
         DrjUTe8ltCtZDmJPblM3COhKVpfRIcs7vBKST76vdRwIclR3x3Ob0Xmt67elbfQU2T7E
         9IXQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782421504; x=1783026304; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNJXObhuc80JJYRIbgz8YBrnkiKjNqPYQ1jYTpzRuWg=;
        b=Py0TcsTzxKadfXaVf5+60Btr8vwr+PFkS9CIYwnMrZpuoX/SSEEqjNDw5OuY3A50cw
         umafcDq5FlqxEReut/4hJwebqVvpRh2E06dx6ZMZd43tw37hFyDx5DDqoJsdm5aSPNHb
         DM6fU7E55+A4bKNAO0Ju60hh1jV4jM3cQ0k78587tsIyK4ii5mz/UthJJq1NLBXekFSc
         F/MjK2/UXeS74Z3WOBGl7fHcOsTwXiC6KbY6hznv/w5gj6YNGTdOfdIMbtCiK+qRtXr2
         vyPIAoJ6C4lBh8UUjKV9abWZETt83cZa939mt1GeVGOaihUrR7Vs7DB4y+SBQVCJtYis
         sOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782421504; x=1783026304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNJXObhuc80JJYRIbgz8YBrnkiKjNqPYQ1jYTpzRuWg=;
        b=Vq2GUmLbNPGv5X0+v5rc+Wp3lEDp2yxW50g8QTICkTUJragLGJ2Aaq1XTVxuh+x6uO
         /w/UHTHF7vL63DWP058YRfENAhVEoUU7owsSISiW6HuEmDxWWMLiekwVIX36CNAR7TmF
         YD9Doz1RLXg6lttcwSFOLLxAv9BELhWk15uE8dfrqs6DGYWMYkYpDvaUEKIoQDrl2Bkn
         HSKE6Qn2zoUhgXjaTKQKgygBbzQPhnMJfkNRrZCrTbBCqoQrUje1g6HyHR6eLncXmFGj
         BHRuwCAn/PWLmSuLveXN4anUCxOPDl8q/yFRcjp/BhcQugKLvZlRAAEURBzq4MoU2mxp
         aHpg==
X-Forwarded-Encrypted: i=1; AFNElJ96PNcVbyRT6fqV3kGQq5XlgL22R8+TMYDz1tw4jUDxZkcNEyc+PFXiWVc6rVWmO9i4hxB0nj3wY5J+@lists.infradead.org
X-Gm-Message-State: AOJu0YxLgj5VCbGgJQfnr8LW5hwWBmvsCmaMcbqLXNE4fs2LDh47MSlU
	Uo7DNt+cSOaAQTydkAwMOwrl47HfFS4rx1/0s5oA0aZFFsDSRHW0bCqeaqyooaSnZjG4+HB6E0q
	cYRutUNPRXADEpp95gwqfg4zL1NJve10WrhokzbTDMOCyMQ6lATCe0t1ZUA==
X-Gm-Gg: AfdE7clUmmJux4C2wBUBarH77hZuAPCwoomGu9Qr+yGO5BPt4/dky1kuF477VEInpRL
	ZMW9lAycxsjFduksudHv3TRaYflHFaPY2hPsw+S/+oiz2yOuyRsIU6O2v9m543k5yrhNzECHyrr
	4/fE2g2hnKsdE0NTUeZwjn5l8tt+81oo7tAToeOu4wnoPHvtuB0+L4JGmQ4u/Bkte/Zb5k9RmNa
	cs5twc9PbjqgComxcspP/UQ//S3lcnyOwOY8+vxiMcZJ9z1HsltKx0QrJKn7ctW/LIbGhDflMwB
	i4d72gI=
X-Received: by 2002:a05:622a:180f:b0:519:51a9:fc84 with SMTP id
 d75a77b69052e-51a727cb368mr60024431cf.41.1782421503934; Thu, 25 Jun 2026
 14:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260604195321.2232838-1-sgogte@purestorage.com> <20260610120458.GD19624@lst.de>
In-Reply-To: <20260610120458.GD19624@lst.de>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Thu, 25 Jun 2026 14:04:26 -0700
X-Gm-Features: AVVi8CcR6224056QR7fx4VbeYN7hzVP58EIivDKO0GFgLUywb_hmgj4PkVNwG1c
Message-ID: <CAMof9cXbj1ATEm+VOzrqiVLFXgbRbOWS4o4=PjTn33iYiYsy9A@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-rdma: parallelize I/O queue allocation and startup
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_140505_534499_21DDA888 
X-CRM114-Status: GOOD (  16.33  )
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

On Wed, Jun 10, 2026 at 5:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Jun 04, 2026 at 01:53:21PM -0600, Surabhi Gogte wrote:
> > +static void nvme_rdma_setup_queue_async(void *setup_queue, async_cooki=
e_t cookie)
>
> Overly long line.  Easily fixed by renaming setup_queue to data
> as in the async_schedule_domain prototype.
>
done.

> > +static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, int =
first,
> > +                                  int last, size_t queue_size)
>
> should first and last be unsigned?
>
> Also please use two-tab indents for prototype continuations.
>
converted to unsigned int. yeah using 2-tab indents in v3.

> > +     async_synchronize_full_domain(&setup_queue_domain);
> >
> > -out_free_queues:
> > -     for (i--; i >=3D 1; i--)
> > -             nvme_rdma_free_queue(&ctrl->queues[i]);
> > +     ret =3D atomic_read(&ctrl->qsetup_err);
> > +     if (ret) {
>
> Jump to an error label if there was an error to reduce indentation
> a bit below.
>
done.
> > +     ctrl->queues[0].ctrl =3D ctrl;
> > +     ctrl->queues[0].queue_size =3D NVME_AQ_DEPTH;
> > +     error =3D nvme_rdma_alloc_queue(&ctrl->queues[0]);
>
> The nvme_rdma_alloc_queue prototype change would be a nice prep patch
> to split out from the main change.
>
done. Separated the patches in v3.

