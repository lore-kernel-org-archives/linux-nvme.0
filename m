Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE2AC55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 05:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=; b=rfrrG/hN+MQOZZv7KZUW6BO5hr
	tlNrpofVs/5d6JwrClbRO4v8ZAPtLlFV56MpYssXwD9VrLLfE1ITt36F37f134UCy7Ab6bHMIajzt
	tTpSjZJoWQ+9Y5+Ac/nIFdj6FblioGa/NpqPncUdF+5yFLEfZs+ul9e+LI6mM11u0rdM0r019bruL
	2WUf3e+tFbMUpVc6BJdoMATiUvl8N9CBYaGTPSFG7DyENV9uAA0gmX9xTHYX8CYpRzeg27AKCQGt+
	iWa+etHbe3k0fb9xicrn7iU4ATxpYaoX/eLR0hDwCi7r4n650vR6E+eBSHC3N7lw6Ctgs3VbL0Atr
	+HhvukfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpfSb-0000000Blnt-1OOe;
	Fri, 31 Jul 2026 05:07:05 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp7XA-00000008csE-1L3d
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 16:53:33 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1789427a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344010; cv=none;
        d=google.com; s=arc-20260327;
        b=oQalXC0XgFYa5r/ecboumgUMXiWLm3F1d6zPJ78wdtYo3T9jx7M6G9LBru9pZlO3V3
         s0j6rfb1vD5MJo85epOw5fjzBG/3YwcpUhYfu9RHKAJ3kOmPF+WBYoeutHDxbojBaFXm
         slkq2/ACqTkQbeDfYpmQtWSNaOXrAx3I9mEbv7dzeUTHGE3cmDXpk2HZ2r7lGwQUYVCY
         KxR74rONOerIBYQfiYN1dQl7WcMgwrErkLhtFE13PW0rmKNynSnlWg8tOIPFZhQAeMHs
         PkqYTY7yP1sKO1+19O22v5NNajRJMsdB52M8aAcXXb7N2IDoSjVCUrGPYgBxmlB4E+Zs
         fgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        fh=KnrRxDPuV40jJGJXjLKUU6fAgQOLqzvIWtgQIydfKlA=;
        b=PV67ErryBhcw2EtW2RAYSpj5mAqQTa6O7B7S6dCgcbYfXuNdWttZOywPbj0MVEkMZ5
         neTDcQAhBNVd7bPcQKF7EGFDxpYkxV/p19A53dKa+VbJZCNIVpxzmgSLqLY7ndoIhyh4
         JIdgNzOyiX3zz9OxpD0WHad8vqh7PBiih2XbuRUV40nf6YwoVu+dWyWG4SUda7LL6qs4
         X5APCp7yeWW8TXuLXuFJ6WhKkRsRCJKIWpAfFQHrnd6/L34tjHraxBNEjfuq2AmnW1C0
         6EueIwT0sFPzwf29ydYF5geTYy5JL0jtasvMf+5i9WcJrtfdqgQAeZ8e/OYscD0pdXdM
         IfQg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344010; x=1785948810; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=mwXsAI67S8RhCZsYHeDqDYO1OtRHKUw9ECNVtUJKHEpHDzPfrn+0Sd+jifltWMcjLd
         VzYFcb+VV5f24iz9YcDqS2XfhcaqOSrZ30KJEqFFkFY2gJTrVJcX1mWDM35ISo0ODNhT
         DmeNiqQ6YdVhNueLejo+G4qsZjF6o8GdA/nMlgnG0f9DLc872FlQ7t4iEdBJk+Jz1cFe
         EPGE7l7zMHf/qUR1NNCKYo60EEGR8aYBdO9hKIPb3Ai4uzaE72i9HMorU3lP6uKzn2hZ
         qn2TsNkod+MfGv0BaGvGRlmItm6GHRnxsEcY5x9a24zIiBTm7SErs5sA7OVWo9SXBAy1
         pubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344010; x=1785948810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRO7Ed4PohyaBZ/SmZ+npcgI12Qnh1MLhDgk3TF8jow=;
        b=T49eD3hQIIIHkXgTrCPbMuz7cau8vQlaxQff3SXIYSBeW3zIUo6VmGyAtr06lsaTBr
         CT4qVyW8wSyNEN0nS8+iRXJ2kwkmeKVqdZIjipW39F24XfKWCKARE7YX7ipb3c7/yKH9
         k2cpy7zIxXkhuhsy9n2NC79mJotnHDJ7eQojJwxSm45MjMl7KDVWn9tErgqoJEz63f0c
         1YPKBPmCvInkXMTA/JeDrUH/t+I1KDDw7RFjwAK97VIeMaFKi5QEMSyK1TD46Df63+/i
         q+fIKsNrRds0fQGtC4ikcP8vLHEFxRLdKq1z6A3QzZZqkT8/PhbzHbSnCFKmkHSH9l3m
         Recg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9IgjNTbog9/QNNLOX0Z4+xEjSE49MjWvgaC+yvqdEmSGgBfO7TjDNFJunThAAdNck0FqN+Bg+smvs@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5QFYS803hW8oprLyiCG8lrl5YAabUZzrmmw1lxHb8rKk55fL3
	F37XYVsjgy9JyIjoe74HrpE9wV10IUKwjH1WDsm1WDffhCodIcIPPzpXFsKPOW6rUzpxs3TBZvK
	GmYRh//jo8MJxk6acqPP9AuXnH2F4Mw==
X-Gm-Gg: AR+sD12Y0jUm3Mq8tKLRwN9eVbW1jLsHG3FP1zP674Yjn358sf6sdErTbceNRKEB2qp
	e0tTCwt9QtWxSfEaJeUNNIVQ1+KqUj8mVZZgnf26EDZ+V84fac7Go7TOBDPYZhDX88r129ib05X
	qtLfX/PDdtc0SN0ZaStuVGkJmSqpFUVGqL1dEHkXgJjs85veX9qzI5k94Sd+LWCJEbhvrBpJ8Ye
	zLX81BsaF8Yh0+kTdb04UPAfNTRxQepVh4KWY8SsWMkcR3INIyFzHfw+cw+JAzPYy8tH9VB/0O5
	xapgGelcmMtw+CoxDGOhs6uEBI1zBQrP8u2gN+Bv3UnDsXa4o/qJfGYgJkzsLfKMWzrDeWVLKKF
	EixNYPnnqHs1kaKy7yA==
X-Received: by 2002:a05:6402:5018:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0349ec697mr4404066a12.16.1785344009469; Wed, 29 Jul 2026
 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com> <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
In-Reply-To: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 29 Jul 2026 22:22:50 +0530
X-Gm-Features: AUfX_mw2n1ETd8ASN5Vcu4oMSqcqp6oKyV0zFdoD8l7zvxibNrqO80gPOx-5lV8
Message-ID: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered buffers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_095332_403702_9EA115F8 
X-CRM114-Status: GOOD (  15.55  )
X-Mailman-Approved-At: Thu, 30 Jul 2026 22:07:00 -0700
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

On Wed, Jul 29, 2026 at 7:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> >> +static int io_import_dmabuf(struct io_kiocb *req,
> >> +                       int ddir, struct iov_iter *iter,
> >> +                       struct io_mapped_ubuf *imu,
> >> +                       size_t len, size_t offset,
> >> +                       unsigned issue_flags)
> >> +{
> >> +    struct io_regbuf_dma *db =3D imu->priv;
> >> +    struct dma_buf_io_map *map;
> >> +
> >> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> >> +            return -EOPNOTSUPP;
> >> +    if (!len)
> >> +            return -EFAULT;
> >> +    if (req->file !=3D db->target_file)
> >> +            return -EBADF;
> >> +
> >> +    if (req->flags & REQ_F_DROP_DMABUF) {
> >> +            map =3D req->dmabuf_map;
> >> +            goto init_iter;
> >> +    }
> >
> > O_DIRECT is checked only during registration; we should recheck
> > (file->f_flags & O_DIRECT) per request.
>
> Nobody should be able to clear O_DIRECT, unless I missed something?
> And fwiw, io_uring wouldn't be the right place to do it.
>

fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
open fd succeeds. The consequence is that subsequent I/Os switch to
buffered I/O and cause silent data loss. Something on this path needs
to reject this combination.

> --
> Pavel Begunkov
>
>

