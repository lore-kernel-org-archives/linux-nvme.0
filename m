Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972C2112583E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=; b=wy0VyoWtn30jEBD6Ve1ipFisC1
	Q4Jpbss1dZpPlXN5rvpwRKrCFSaMzRMY4p86/58XOtoS0xsFKev4lMkDSQTS9LD8Ka9dlT7WVTxdQ
	7rEUroSgQipB2EbNUZ/4QRTp/+qY6jWxnJCXRyXvBYgmhbBfM3GngFoDc7FWrlk2H3GxbyH53PN58
	uPcxI+9eMd/RxuHyoBs3gH7HCjNPsQCl3ceOfdUQTNzHecaT1KuikspQmQvIE13FTgJWG37WhPruW
	segYGKjR3qlp0RhkdGc9BCSoI347PCNfxX3AdwZOc8bksEDJNAZikyybKx1t9cUzobntFCnptdGrO
	PAuxPn2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0L4r-0000000BlEz-3aGV;
	Wed, 11 Mar 2026 15:02:25 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzzS9-00000009rsy-3mNL
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 15:57:03 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-41540f23deaso561671fac.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 08:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158220; cv=none;
        d=google.com; s=arc-20240605;
        b=H+02pfaB80Hq7bbjVr1/mj9Lqysw0MEhs1cZwDy5dujm/RVg1mjOdipADXUbiWXu89
         LECPg/mJqqiZ0TZABlnp6GmEE6JZ83iSFc+Cm/92JFf+yF3cmBmHsn15PzUv6rig5QsG
         HDTj7X3O7bdrwJMygIoOTqJf3kKVE+B109Wp5KUA0T2vLxJsCmC6hCf3EgEl9nI5A//P
         H9vxnxVbSuNAt7Cw2ZK6m9QmVsJ0+e6rTTr7QTUK2ogdA2ulYX75Gpr59pss3ROh/WsE
         5UKJaN/XsDvLz7vaLqBcihsrVDYICJ3l84MqO4ybdoxRdQFRINT34JL4c6swRMy5JUxQ
         LkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        fh=Lh8zeuprvtiUUL5S+zVc1gJHHlq/PIYKZlPceH0q/94=;
        b=NQi06XDhRq482zJG3WNTlt4hyMJXBxAzyX5+edHr0DKs01aG7ijd2Pc2y1HA/TGqR5
         xvfRBfS1PYc3uZWyt6L6bTBydApVPV8eDQRAkX++10RphEPdo+YOra3k/0RiCQMWxBYY
         SdNKLQZjAhX22gLR/fmAJVcKoiL42KUxgBM0OIoEci8tdIFdTFcAd2R47AUAYLeNtA3U
         prJ7vrCYeSmE3l8VeRMHfcjcQMWdvVswKGMD/ZTHXaBuUicMT0RoLhPg+9yAHRH2a0I3
         OW/69k+wO1TsVrtHAcLwvNBKDrTOLzDpRVcDDvW6QUNVrmrFO44a6FT/vbJU1CIHbrEM
         uflw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773158220; x=1773763020; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=Hle9sW6Fu2aRonCKUeTgczqon4CQBEtOK36ksYLjuy4nJPbMYbGyL53lWN5Fw3/5Wl
         HP7qvFnQ9cl8UmyYEAjPi6VdZ08k0hEFzkWCzqtmn1vm4Pk+S99EHVdsUXDrwFpybBJm
         vyzjp9tP22xczj07xbIfPWHAFNOx2YDXEaO4SsyB8LQxdX4TwrtruJ/Q2hWjqOtHoBFX
         CgDwzVdp8mrzgOQcHET1lDoK8PHpOUi0NHKSRQ3eyUh0G5NL88YmrnHCGhK4xKMSCrNA
         KBWaA2gx6sTOK1myE1p0798wNjuJPh2Q/mZfjk09RU5lXr4mIoT4rvZvre+pMlmdy7Qh
         OPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158220; x=1773763020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=HpoOopJXzpGfOZfwVqOsacpAVU22wnkQcbkOzptt0iOwqVVPErgExWedhWv97H/sSA
         vhwmoECoh8ouVZuPpYKG3tadQBFZEBAEnQ9vjiSfGv/J820IYT/mVdqOfeAbD0unXRdb
         wYn+6ZIyJrXDXh7P4LCD27F4byCOmNPTxWucMzLYgiJ7E3T33RZz5Ga9pf4zErdyqnXd
         pO4QP0wym1nbZW/ho9S0rhBFFQxZNhb/wQEE9t/AB2mFC6fy5VV+1uwHva5TR8tU5qHo
         PTBHofWwnEMFGaqIimg7ThsQ2rjmZ1w5BOf2vdBSpyiviXylpvnksKocqSqw0zn+FkUC
         YCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zaIZZkECRWvWXUFvoObh3/UOm60MFMWHhHd6dBwV0to5RHLINOBUO3ryJQmtOftIzKFCwfrcLcDg@lists.infradead.org
X-Gm-Message-State: AOJu0YwkcObKErVe1YtrnKUwQ+hPMgsK1lJw0SDgV99GwWa5q2ZItcgS
	7C/EW6Ap/u3bdtr0BBh/lHInOfYSb9seIWBrqguBTkousABCJs3oR/y/QJm1fiZ2FnmUW2YfK5D
	gFGQkcv3/Zsnc69TTNulPUTt6EjyqxvmZey8bYAKRDQ==
X-Gm-Gg: ATEYQzwBenWwIE0b8PpW2wH/qiKOwofivhJtA2pIDHmBB7of+I84RBKXzEaFguI/uJP
	5egpxNOxfLeC3SPsvNVDjGQOjI/9UdgGSvtrjyTsef36JeSKkTn7rO4h957IMTMCdzEtxjx9Yx2
	xHw4dCXQ625dMvVKWJrI2oChpR4BdNv6/vLDViRbC5hILKSrJ6HZLzN1HNgBJ5cEF3eCWwTGzUJ
	MsgdlfxNKZqDA1l6hW84fN+fqiWlkQneuZd/AOAcUKsaqxxgYe1Bh8JftRE8QmJiAYMuoStHE6k
	Rbig612Q
X-Received: by 2002:a05:6870:854b:b0:416:3f50:ea2 with SMTP id
 586e51a60fabf-416e45c1dc6mr7199342fac.8.1773158220092; Tue, 10 Mar 2026
 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
In-Reply-To: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 10 Mar 2026 08:56:48 -0700
X-Gm-Features: AaiRm52sHfM1lLReXhJ6K_-eQeuNMsoWbyv4AHit6rY5_ursGYcV9eDpU-ihUic
Message-ID: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Sungwoo Kim <iam@sung-woo.kim>
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
X-CRM114-CacheID: sfid-20260310_085701_947602_CB5F1F98 
X-CRM114-Status: GOOD (  25.26  )
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

On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> =
wrote:
> > >
> > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result=
,
> > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
> >
> > The node argument to blk_mq_alloc_hctx() comes from
> > blk_mq_alloc_and_init_hctx(), which is called by
> > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set=
,
> > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> > doesn't find any CPU affinitized to the queue. Is that even possible?
>
> Thanks for your review, Celeb.

While I'm flattered you consider me a celebrity, my name is Caleb :)

>
> blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> exceed the
> number of CPUs. Afterward, it is adjusted on the caller side to
> numa_node =3D set->numa_node.

I thought the NVMe driver capped the number of queues so every queue
is affinitized to some CPU (see nvme_max_io_queues()). What am I
missing?

Best,
Caleb

>
> set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
> pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
> proximity information.
> But I'm not sure if this is usual in the real machines. We found the
> crash in QEMU.
>
> > >  static struct nvme_descriptor_pools *
> > > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node=
)
> > > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> > >  {
> > > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pool=
s[numa_node];
> > > +       struct nvme_descriptor_pools *pools;
> > >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> > >
> > > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > > +       else
> > > +               pools =3D &dev->descriptor_pools[numa_node];
> >
> > Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id(=
);
> >
>
> Thanks, I will modify it in V2.
>
> Sungwoo.

