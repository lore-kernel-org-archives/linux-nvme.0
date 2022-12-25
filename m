Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44817C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+48L8Ebv4aPP9Sakn0pKuKNsmP77TbDjxN1IU0ghN8=; b=mif41V0vTfv8S6LSoLyGYV7AcI
	4ortxl/vvd1b/PCu44UyzdimeHlMUiHSrhtrxYQD0XYtSwy0Mb8qMhTtuA6BaAdCLfK4LIdl730tM
	9ARJ9Xz8/xrmRNInRX4mCDKekt1bH0JYf07Wa+wefzUBBQ+DPUEizolGj7FJf5tfRMC/RrJvfUZsp
	Enx1uFejD/512c4RC1Scn7WDhCZ8EHsOlcdHs/TA6b8U5mYJWR1vLFd9kHIIBbPN0/FkSWnVt89uS
	GixxFHWdg4xn7Fbg58maGKFs3isC0xMGo02gdMtN6NhG3tF2suj2E+4S8TOQmKQzo5fVEABoYwv19
	i7IovDiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9O28-009u5j-CR; Sun, 25 Dec 2022 10:15:08 +0000
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9MRl-0090oZ-9q
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 08:33:34 +0000
Received: by mail-oo1-xc34.google.com with SMTP id y194-20020a4a45cb000000b004a08494e4b6so1411425ooa.7
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+48L8Ebv4aPP9Sakn0pKuKNsmP77TbDjxN1IU0ghN8=;
        b=C/KrYpL0yQVWEjfNR/+zh7hkyjCD67VfVkBqy1K8+RQKSfbhpUBLc1qOTnF0fCDGyX
         abvvTi4Ix3YCZHlLWgq3LiOzF+h0Jtp54tbGUKxFzIMPy/Mpzyd09v75l/qsGq59dvEP
         vZcgG8Ifqg0FTq8C+68pJIcdKu6utedNm/1HHAE+7dAImU3/8jOyGUz2zzzOU3yxHeGw
         IK0IUzxxXjHgH/x/hO0Dr1CepqxRhwo1OODAk+gO3kUB4ZRcnKyOhX2CD1WcT86Y+PTw
         Epqv/zocptsxO/54HcQBq6fKOw8yBahgM+C3M/0Kxcc0eVkTLtMKyM/ZJawcDJtSjg/6
         SihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+48L8Ebv4aPP9Sakn0pKuKNsmP77TbDjxN1IU0ghN8=;
        b=iIxbRkMEq4f9gkpZIHTMq4gUiDS9Pu2NgZrEJqAd3tKfA2y7913cYkcJ0RsRLHBDW9
         On5ciI8ESRc4HCHxdiH+Xxpj/pFjjvG791BgYCLbVHLGTvC+WWVECQPbh48RYq8NTlww
         k3HQvhGpPiRBgGW3YQLwV/kU8siecXsKsf14HRjMbbB8HBSo6lfP5E3xLm0FKWATHKZP
         0gjPYYcgeJ9tTw9tuGNJFmgSEgf1m1Tt6pIlaLvoeTgeNEtbQbWREnix+NHQKJ0sLSNd
         ZSL6CzSdYPI7644F6rFt7JtjxGeYULttKb+BhlJVinpef+G1PjTHeHqMVRUmi9ITxPUM
         WZZw==
X-Gm-Message-State: AFqh2kqlDNKwWojRDI4pJ3CiLUAHcSqq+MmxEnuRjNsHSI9PFfO1RQ9N
	8NB2OkI5uk/Dqn+vVcYvFExiSA==
X-Google-Smtp-Source: AMrXdXvLMgnRzgpvkvKHbG2Qq8+wQ0bi6W7/3nrnjeyJTI28yHtg1Aezw0WEm0FwzzMz0ZLIptgr6Q==
X-Received: by 2002:a4a:df0e:0:b0:49f:dec4:10db with SMTP id i14-20020a4adf0e000000b0049fdec410dbmr7115498oou.0.1671957202776;
        Sun, 25 Dec 2022 00:33:22 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m2-20020a4add02000000b004a3d98b2ccdsm3213620oou.42.2022.12.25.00.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 00:33:22 -0800 (PST)
Date: Sun, 25 Dec 2022 00:33:13 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Christoph Hellwig <hch@infradead.org>
cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>, 
    Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
In-Reply-To: <Y6ff4tpk1Su/Q9bP@infradead.org>
Message-ID: <6715d48b-7670-527-38ab-42f865fe3c10@google.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com> <Y6ff4tpk1Su/Q9bP@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-442772056-1671957202=:1683"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_003329_747466_4E756617 
X-CRM114-Status: GOOD (  30.91  )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-442772056-1671957202=:1683
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 24 Dec 2022, Christoph Hellwig wrote:
> On Sat, Dec 24, 2022 at 03:06:38PM -0700, Keith Busch wrote:
> > Your observation is a queue-wrap condition that makes it impossible for
> > the controller know there are new commands.
> >=20
> > Your patch does look like the correct thing to do. The "zero means one"
> > thing is a confusing distraction, I think. It makes more sense if you
> > consider sqsize as the maximum number of tags we can have outstanding a=
t
> > one time and it looks like all the drivers set it that way. We're
> > supposed to leave one slot empty for a full NVMe queue, so adding one
> > here to report the total number slots isn't right since that would allo=
w
> > us to fill all slots.
>=20
> Yes, and pcie did actually do the =E2=80=90 1 from q_depth, so we should
> drop the +1 for sqsize.  And add back the missing BLK_MQ_MAX_DEPTH.
> But we still need to keep sqsize updated as well.
>=20
> > Fabrics drivers have been using this method for a while, though, so
> > interesting they haven't had a simiar problem.
>=20
> Fabrics doesn't have a real queue and thus no actual wrap, so
> I don't think they will be hit as bad by this.
>=20
> So we'll probably need something like this, split into two patches.
> And then for 6.2 clean up the sqsize vs q_depth mess for real.

This patch is working fine for me; and, in the light of Keith's
explanation, so far as I can tell, seems the right thing to do.

Thanks!
Hugh

>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 95c488ea91c303..5b723c65fbeab5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, s=
truct blk_mq_tag_set *set,
> =20
>  =09memset(set, 0, sizeof(*set));
>  =09set->ops =3D ops;
> -=09set->queue_depth =3D ctrl->sqsize + 1;
> +=09set->queue_depth =3D min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH -=
 1);
>  =09/*
>  =09 * Some Apple controllers requires tags to be unique across admin and
>  =09 * the (only) I/O queue, so reserve the first 32 tags of the I/O queu=
e.
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f0f8027644bbf8..ec5e1c578a710b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2332,10 +2332,12 @@ static int nvme_setup_io_queues(struct nvme_dev *=
dev)
>  =09if (dev->cmb_use_sqes) {
>  =09=09result =3D nvme_cmb_qdepth(dev, nr_io_queues,
>  =09=09=09=09sizeof(struct nvme_command));
> -=09=09if (result > 0)
> +=09=09if (result > 0) {
>  =09=09=09dev->q_depth =3D result;
> -=09=09else
> +=09=09=09dev->ctrl.sqsize =3D dev->q_depth - 1;
> +=09=09} else {
>  =09=09=09dev->cmb_use_sqes =3D false;
> +=09=09}
>  =09}
> =20
>  =09do {
> @@ -2536,7 +2538,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> =20
>  =09dev->q_depth =3D min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  =09=09=09=09io_queue_depth);
> -=09dev->ctrl.sqsize =3D dev->q_depth - 1; /* 0's based queue depth */
>  =09dev->db_stride =3D 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  =09dev->dbs =3D dev->bar + 4096;
> =20
> @@ -2577,7 +2578,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  =09=09dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>  =09=09=09 dev->q_depth);
>  =09}
> -
> +=09dev->ctrl.sqsize =3D dev->q_depth - 1; /* 0's based queue depth */
> =20
>  =09nvme_map_cmb(dev);
> =20
>=20
---1463760895-442772056-1671957202=:1683--

