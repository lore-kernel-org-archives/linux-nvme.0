Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60C112583E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=; b=jcM+MC5Yu3FqNZrUO7h3Z3lZi0
	xLCLClHkN/f7w9VZMGgKhnZjVS61nBClxBHiIit2a6HqFi8XjkVnuUzcodFC6EPoULde2Ls7jCS2G
	Z1grhev6rOO66CrJzvCU8ePs763ffcPYy8Darnr1f1rMgUQNtucC5/QzA3tZZzpO5oE78BG6yVYNC
	rOk+/qe73CGgeQ8+W/P9D5xAU1lSeaQwccIa1Q1MGQLLlbas+MKLY2jFlaXEtR18CR0UDGAfpN5F1
	QwiwcRIOu8VwUHL9GtVx6F4bOOK6j+HmMTDYDbR84ghGA7phEbnovuUjdflUfp/NWqp7RgJqUiA10
	E7sUg1Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0L4s-0000000BlF5-0cGr;
	Wed, 11 Mar 2026 15:02:26 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w08AK-0000000AU2w-1ZIf
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 01:15:13 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-660d77cacc2so1099793a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 18:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773191709; x=1773796509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=;
        b=D4jt8FHz+xqp6pQDDHb5tEJhAr8P6eVqQ2ZKKNrPlEzW3oIP8IWVJ28XV6K3NyV+69
         gjTcBziFKB7GE+qUKmYrcIdmHSCN5ehAxY62IrXLmRYYzT0+Nx4Lckj8V1Qudpk3hB2J
         PM7h8TGkGtfzvCViTJ5vXA1Yl4H2CxA0CcrCZu05uMEmE/7j2xQwTRkRea3Pwy1ai+Pf
         X4lbHYSJBjeIsGWfh8WBU1MPxALRik8iHmpDORch/MtS0GLFhS3Yn+FL1vXlIEvegNCl
         JqME7m8DM1u4MuEPkDDOE3tUJum6F6Vb7tSM2N7E7Y/EgjnbJKzMSBT3WkKf92D9GEfI
         ZNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPWE0aYGtSe++WnZj7OjdyzapSxC8+tajtiJ0zk2Ng3YSFr0YdKYrQUBX8TXfyCDBIF0/DDE+ZvxLK@lists.infradead.org
X-Gm-Message-State: AOJu0Yzo4auVwoGzkqyuJqY0pRPxZN4MKo2kLpIh1X1pnloxGO1OGgf5
	GLUzu+YpNYUg1EQWM/loYEUVy5gq8q1bdjaFz63SDkXdM3E+v/dx9F01fBfVa3+v
X-Gm-Gg: ATEYQzwJf6uhzH7hMF8wvfzMeun0uHHAvGjOPhB3t+glwk74z1P+5869nk268wNC0iK
	vy05VJ73VKnmPfHXk/FNB1PC0V/Oc951e7yrdjzrcw9z7xvIKnnfIt61ZIzvpDeGyvhrScgFU/1
	OK6ToCHdp7QrdJ9cHU1uG9oSv144iLvmdYHGOQdCCA4p9ozpKHTCMHqWo2x9dELg8aRhQTBTxUc
	Q04/jXGjGu8F7lnZncwQIsIv04RxUqm86wL7ir6/fybPlyndJ6ZYFB87ZVfub1iHk0Sb/gUzCmX
	SZHPgOXd9iwWDrarU/fWE2peJ0BVQw6gedu8M/DlGIzueODksSJT5DhA6khBAnSQ6WWuA3Kjz8b
	kudMTE6Pu0pdiL4fafGNpH11Js9Y6OQ2Js3+YvKKYWchq6/cVI1cuW1XcncweUChTssPSC2yvqO
	B5mybKKLXfXurvfSeigIz5d8dAFOhXS236V3SQf9GsoAiACVxOxn4W+Dc=
X-Received: by 2002:a05:6402:3552:b0:65c:76a6:4bdc with SMTP id 4fb4d7f45d1cf-66317bb940amr330147a12.9.1773191709297;
        Tue, 10 Mar 2026 18:15:09 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631532dcbcsm201846a12.30.2026.03.10.18.15.08
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 18:15:09 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b790af67so363871f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 18:15:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6xq74opySthXRdVF2ZBKmAZH2VHSbcKJI3M1sJ0P9+v3PfOFO3atDfyltiFHNoXeR2MKJ0WBXTkkT@lists.infradead.org
X-Received: by 2002:a5d:5d05:0:b0:439:bb46:7457 with SMTP id
 ffacd0b85a97d-439eff518c7mr10359487f8f.16.1773191708627; Tue, 10 Mar 2026
 18:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com> <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
In-Reply-To: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 10 Mar 2026 21:14:52 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
X-Gm-Features: AaiRm51cz7xo1V1erpi09gKFdY9TTILawmEFCzQE55oadwxdss7qBUImRUPZq3I
Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260310_181512_630008_67522A09 
X-CRM114-Status: GOOD (  23.35  )
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:02:23 -0700
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

On Tue, Mar 10, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
> >
> > On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim=
> wrote:
> > > >
> > > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a resu=
lt,
> > > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx(=
).
> > >
> > > The node argument to blk_mq_alloc_hctx() comes from
> > > blk_mq_alloc_and_init_hctx(), which is called by
> > > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(s=
et,
> > > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node(=
)
> > > doesn't find any CPU affinitized to the queue. Is that even possible?
> >
> > Thanks for your review, Celeb.
>
> While I'm flattered you consider me a celebrity, my name is Caleb :)

My apologies, Caleb. I'll be more careful.

>
> >
> > blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> > exceed the
> > number of CPUs. Afterward, it is adjusted on the caller side to
> > numa_node =3D set->numa_node.
>
> I thought the NVMe driver capped the number of queues so every queue
> is affinitized to some CPU (see nvme_max_io_queues()). What am I
> missing?
>
> Best,
> Caleb

You are right, every hw queue should be affinitized. It seems I'm
missing a lot. I'll look into the reasons and get back with V2.

I appreciate your review again.

Sungwoo.

