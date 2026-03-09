Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC53CEB1070
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=; b=qsK5hwLhmLgy0TFdTPiIdu6V/d
	gapxJQ3IwgyQhMIN9bN2aQDhjetNgW6+JLViqMGzvAvrufWRXvBvUrzQ7DH2QF7YIO7tibLAhuzPx
	4VVCUI9EUESh2aPOR+KwZPbyXjgZR/RUz8y93r4F8d5MwN0GqQv5IRXRq8CO64zRGu9GjuXUxv10Z
	YhSR+uZS3DTJjJr8C1k+lGD0uPM5+fBfr3luJNHfcH89G2CPl0RVGsqsk86Famu9Mq32d13i4y4Bu
	URq684Bt7g4CHVw1MFNrTW1sUl96FYa8Dit2poFEmotKU3cl2C8Laq/zdQR/LCc/nQrxvO1rO1U0x
	EmSLWqhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzz6L-00000009otk-1Msr;
	Tue, 10 Mar 2026 15:34:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzkYG-00000008MC3-35Xc
	for linux-nvme@bombadil.infradead.org;
	Tue, 10 Mar 2026 00:02:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=; b=TzE/+aRKVh3tIL4Omb6aO4lBKR
	XhCqqmL7aQXQiV9z2VnTGuU8NLKPALsBdrZ8nVhnsV+YonUOGclb4/KWfmgjASiGPoeSD5J6ILp9W
	8LjYpibKDihgNlajBZsgyouzMdTrlj/2w6BOSrUdDSHvuqI9IOkx5DqyDCda5oR4yM4U9goQq1rQ1
	YiClrwc+UDjf0wU1XlAGCZV3OG7x4A8X3QJRCup9guECfTFdW7GVnT/FZnGGID+UX85KWtReIi8T+
	k4ltutfSEkOXL5nu/eTi7dH0WGmOFxiuvKI8TdHahpr6l+1C2tbOn0SpScw9alUJRsu5hsLtzR7/B
	OoHOD1xQ==;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzkYC-0000000DN64-1ydS
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 00:02:18 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9382e59c0eso975930866b.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2026 17:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100935; x=1773705735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=;
        b=KgsfvEgzdf/2sEE2T3rlz6HpN0XhruhwbMke1eKgg9u0DKgyBM93va/QEQucAXwRJj
         3CLRuSOlGiaZS1sLurfRd0nwrZF3Bji9vUQLKHHlloxMg61VaiZ9oyRZRnx2mc80tHcH
         yVBsMj2Acli/WhJVUzPXB9o76/7EI4DXZkbgwotnUUKiovQll4i0C/KmdIpMLg+Ltrrg
         bhYB1aKx9AYYPXF3Rd7pEVaHOlDQPLoF9JxtLErs31uEoA7ln8HotexOVhL1JJ5j7aA8
         SPsBErylj6cjE1J1+KCbe+20R5Qga2olRS/Lgn7p+UvsR4haaE5rC8t4EJ+1DtbiKwB9
         KVyw==
X-Forwarded-Encrypted: i=1; AJvYcCVqayxR150LS0NTG7pfDxjJCmM9slDeyGayTu+9WcpmriH917EeQOe/a8VzA2wAPyuubaSzOrb0eu7U@lists.infradead.org
X-Gm-Message-State: AOJu0Yzl/B6j8+LMKzJ/hLXmCbYg3iGNxsJ2hOd2ckBWtzkmU1GAvw9p
	5uvjzI+CD062sT86J+GS+dryjof/RRffV0lpQmXllgVzw9+tOyPFkulL0i0KEsnDvx+187X/
X-Gm-Gg: ATEYQzxr+Xx1qC1SdretBf1m58PzwZ48aN4Rl0ehgmwe6GksnXhM0KE3ov0OY+g3pZy
	mDF0suAXHNwdMg2GwCWdkLT72t6jhbioxmdYLeYS1AwkrKu80CknZEvkpNqXRKwWotUSO0REOvO
	qiBTR6tDhh/KKxB2Xag9pOk2GGqrCRxLsBLv/zX18iGaEOKSt3wBJdVnCdeRAZ0zzc9kRhDXyjq
	W/T0VfQUX1JV7qDdOcxZi6XSuVkRd5cUiTnjHUjpyp33CSIQ735qrS0lIVTX65vm4TbbJ9gw1gk
	mS5nncP7lvRW5UMG8US2U0MdArOHr2FsFhbP9r0kPO9/gcdwItkjeB+iLkI17k7PVOHtlrP32Ui
	s1UP4djOBuAmY8uVg+qyTzQIX1EWHAVYSixGrrrGzKt2PlYo2qvMwK4F7YXOnytvpZM5CPy9nzD
	Irdj94zBjMmidY3mtWcNyZc2Q43RanEZcCXbP4cZB+QvDd+SKd39DqZFueLbc8BSrV/A==
X-Received: by 2002:a17:907:962a:b0:b96:ea92:6717 with SMTP id a640c23a62f3a-b96ea92778amr365572766b.23.1773100934819;
        Mon, 09 Mar 2026 17:02:14 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f18baadsm435332866b.67.2026.03.09.17.02.14
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:02:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9382e59c0eso975926566b.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2026 17:02:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX56ECMKKHFcQIevc57MSayjqPuV/NwSe8k9iU8Zv+P6ODMLIEirtzkG5hSFyjjIww76eQDyQh1a51/@lists.infradead.org
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id
 ffacd0b85a97d-439da66b72cmr23928350f8f.26.1773100503051; Mon, 09 Mar 2026
 16:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
In-Reply-To: <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:54:47 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
X-Gm-Features: AaiRm53vE5uEinTHUYE1aa6bIvdkwyOpz0dn9fOlsjLR4PN8Z_3w05vllGJ47mw
Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_000217_016271_FBAE24FB 
X-CRM114-Status: GOOD (  19.77  )
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:34:27 -0700
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

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result,
> > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
>
> The node argument to blk_mq_alloc_hctx() comes from
> blk_mq_alloc_and_init_hctx(), which is called by
> blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set,
> i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> doesn't find any CPU affinitized to the queue. Is that even possible?

Thanks for your review, Celeb.

blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
exceed the
number of CPUs. Afterward, it is adjusted on the caller side to
numa_node =3D set->numa_node.

set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
proximity information.
But I'm not sure if this is usual in the real machines. We found the
crash in QEMU.

> >  static struct nvme_descriptor_pools *
> > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
> > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> >  {
> > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[=
numa_node];
> > +       struct nvme_descriptor_pools *pools;
> >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> >
> > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > +       else
> > +               pools =3D &dev->descriptor_pools[numa_node];
>
> Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id();
>

Thanks, I will modify it in V2.

Sungwoo.

