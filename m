Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800D8FF885A
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmNymKc+WlzZEEC+pNTT+/WQ3FaUTTrwyjCxZ/xSL2Q=; b=uq13ovpibpUM2oCUAfyfa3ncIu
	z1Q3kcuwt/ItaHej8ijeclyRS0OpXpizC5EahPRXnThWL1tXKSyuNDG/s1Ai1csdK1aZxLjxGGFGE
	t+bYMn28V4pA3evEb5JK/hMkhG9dzOo1AO0JabJY0m3jhyhhsexGV0SWe+bnZfJOC2a9T4W+Gew6a
	ZHgsZLX3nPUzQf6//6UPPyLBQW5JFU/m0NVI6rdI+tVKuym/eSqiC1sWofs7ysU0qxnAKTcjGVe9L
	D2LjkUQW6UFgcBDjIt34kYMFGpAhqLYDrqBQP/vVzxSTFTIrju1owcYY1sqm6UyPPOIJmvTQFV1Fs
	p2F9jBuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJxWS-0000000DvIb-2Vd6;
	Mon, 04 May 2026 17:56:00 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJxWP-0000000DvHu-3CG6
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 17:55:59 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-7dbd7a1e989so416212a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 May 2026 10:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777917356; cv=none;
        d=google.com; s=arc-20240605;
        b=cIpCFmpyjWyYl0PzhWbGtaKCixtytMb6Lz9ijMpYIwc/yS/7zGrUuUZqjn0WIbWhT/
         EJPjR/J6KYPo98nPxgINr9aQI4e6OrQhR4KDup9UzT4BHh2I5vutB0aorsXmeEV/6Ong
         BNIMAmVeDsUsFI5rKiP1ouuf1rpb0cAy13Uma+PzQUWHWjhjndhlMIZud4YVCssHMvXz
         oEqUxD7Qf1Ew9SknbGGEQ/ERVoV9GiTfoTbd9wzuNzHkbJyaieWdD6VIaloIIi//pS4P
         1ZuBRqrK9Xfik2RqCkBnn/Hlr2sz0YVJwb/DnHSFXeoLzbcw2vx8j9WWL0NInBo4gYph
         WHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmNymKc+WlzZEEC+pNTT+/WQ3FaUTTrwyjCxZ/xSL2Q=;
        fh=6yE/PCCcx2d018xzLqUwxmDCiKgITKDU/zDboT0viP8=;
        b=jpTzNlCiDy3YXztcSP15+qB7dsM0DFK9ms/OP2rXa7P3f2GSRI165AlO8EbrARBXk8
         GUH6CeGPxwFZXgiYa811+ERvMnlYueEkYG0kcWRgBk7xbyxT5+EehKBGqHQTnTEqTsNV
         bsVZui5Jnhg0KfeJxbX1IPoXGFMZdhLXELD9K47GuIUE+jpDyqTUlIYVVNn3jeATYSCl
         2LHg1x71rl90/Kn9pOiYpLGdLcakFoEQgHGVcs/TMQp7WRTYfAxrRnLVCGXu6WVbedAO
         1sz4McbBoGgbGg6wSaPR8dgUat1F6skbuJjJRX6xyJZfi/reoEP1r/lkYuKZK84NwOIZ
         9VwQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777917356; x=1778522156; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmNymKc+WlzZEEC+pNTT+/WQ3FaUTTrwyjCxZ/xSL2Q=;
        b=AK6wLGJkYRG3+e+XZUqo+81PW/WZaXd8HmyaIhA9V2OEAKR+GQDCUwFj/gFyNUpWv0
         BD68jVPO846k7z+lFIJ9VyS7HgFwg5en1Ixj5biIHdd7XeUU12+cDSGKgxGzyUGQRC+y
         8c8lIClmbGFxt0Y4PoxJEHmIDs7LS7052G2OkK++uwL0zeAk5rOmoSsWEkL7FuP3Wu5U
         SHoNdhE0ETXtgOILc4O2IuQXk7+JN9KtlnKLrgIs3nSGOAR7LkR1i3tRRmOyLnJcCPdU
         eqF0l66sVn+YUcQEctcWsJUoDiSiE/BtMNdDDz51hV1Q0heEfn+UmOHvaBDDAlaJdl6z
         S7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917356; x=1778522156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmNymKc+WlzZEEC+pNTT+/WQ3FaUTTrwyjCxZ/xSL2Q=;
        b=S8lK1Ow/2H7eywPoC+CNpiBd+kWgKTsCTkt1CgP5rqrtKeMS8PStDY8MYSlumVXeoG
         Oo+R1kGgD9vP+yihh5+ZzHAZuFnUFu6BYS2BG/s+DbIOnTb19gHEoOL1u0A66hM+tCCA
         bh5qnuD2ZJ5kR/2Tw3cYVPLHzl8SXEZzMBvAUPD/D41z5uhHt/fgOCnBZ0ngbaVbRHcR
         fjJUddjxHE/cHdi3lqt17GKyX/OgfLxBNALcl4HcAY5zLHotwsw30sBSEWdzdG2m5oXF
         S84HRyqnrvwzkaWVFec65Zi3oyZv8+yNRuLtHf22vIUDMAIQxAvnM3P6tR9aCTWsVZf0
         HrIw==
X-Forwarded-Encrypted: i=1; AFNElJ8FPLUrKO9cXoosgDyHEWfLFilW0zeZUnn/cLIs8rZPV7kjbPSviAmyiWDtyooigb1azxn1Xu8TSQrh@lists.infradead.org
X-Gm-Message-State: AOJu0YxAYAEjYRmIiRh82BvoXh5RZV7Bhs3J3ESbvQJmRlTIFHlX0pzF
	wKTJSN+O/r7Aqt+z2RGVZ65wC3sKaxzeIJ80ivpXYY3w/9FjtdiO4FQ++FWwFCwveLmkD6jCjKX
	6bJPk1jjsJQustqnEVrwbNCTeWR7/ItxbkL1Kp8y6Lw==
X-Gm-Gg: AeBDiesKjEuAn0/mTCaxjzaqo6gcILHhUKXPbD1Z5zkFOowMo8ojmO+Pjt5pxdOrXGc
	1/IrrjKm3+E7Rdy02lwqvsWqgA4/NDlUDb7bzhxko5YZh29vDufO4a7Ya4sX1ex0o6+K4Y/jZeV
	1568UnPpMBpVvJFjCWAbZPAe/+iYsl8Wwo4V5S2KpxypB1bjK9plGO1vW8bSzHEsGMwGNCz1BKI
	E+SxR9mzVqzS5WLnh0hyac0t8ROWCAtpAJKgi68R86rR4ZmpmP5/Ag1ih7KyASnAg01fFw26zZh
	mFJzHCoyXnLR47emVAA=
X-Received: by 2002:a05:6830:314a:b0:7dc:cba1:8306 with SMTP id
 46e09a7af769-7dee11cbc2amr4169091a34.2.1777917356159; Mon, 04 May 2026
 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com>
 <yq18qams3re.fsf@ca-mkp.ca.oracle.com> <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
 <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com> <CADUfDZqkT4g3T6uE=hxt9J6JDMXbJt49rM7_Vgs3EBPdFeuuLw@mail.gmail.com>
In-Reply-To: <CADUfDZqkT4g3T6uE=hxt9J6JDMXbJt49rM7_Vgs3EBPdFeuuLw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 4 May 2026 10:55:44 -0700
X-Gm-Features: AVHnY4KNYsVR2kYl7eJ0Hwf9__aBJ8ZzUEN24LJvPWcKnRGqgghNGjpf2B_6MDk
Message-ID: <CADUfDZq+BZ4Xn19TXH53NndDwDwMKm3xS8wSMnMtRsF7dWSyGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_105557_827539_6788B46B 
X-CRM114-Status: GOOD (  43.80  )
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

On Thu, Apr 23, 2026 at 11:02=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Apr 20, 2026 at 7:09=E2=80=AFPM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Hi Caleb!
> >
> > > NVM Command Set specification 1.1 section 5.3.3 requires the referenc=
e
> > > tag to increment by 1 per logical block, so that seems to determine
> > > the increment unit:
> >
> > SCSI allows PI to be interleaved at intervals smaller than the logical
> > block size. This was done for PI compatibility in mixed environments
> > with both 512[en] and 4Kn disks. Interleaving allows 8 bytes of PI per
> > 512 bytes of data on devices using 4 KB logical blocks. That is the
> > reason why we use the term "integrity interval" instead of assuming
> > logical block size.
>
> Thanks for the explanation, I'm not too familiar with SCSI. I meant to
> refer to integrity intervals in my explanation if they differ from the
> logical block size.
>
> >
> > > The ref tag used for a particular block needs to be consistent. And
> > > since reftag(block N) can be computed as the reftag(M) + N - M if
> > > block N is accessed as part of an I/O that begins at block M, the
> > > function must be of the form reftag(block N) =3D N + c for some const=
ant
> > > c. Thus, the ref tag seed needs to be computed in units of logical
> > > blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
> > > works.
> >
> > Whoever attaches the PI decides on the seed value. In the case of the
> > block layer it made sense to use block layer sector number since that
> > value is inevitably going to be the same for a future read.
>
> I'm not following "going to be the same for a future read". The block
> can be read back by an I/O with a different starting
> offset/sector/seed, as my example illustrates. When the integrity
> interval size differs from the sector size (512 bytes), mixing the two
> units results in a different ref tag seed for the block depending on
> the starting offset of the I/O.
>
> >
> > Note that with MD, DM, and partitioning in the mix, the sector number
> > seen by whoever submits the I/O is going to be different from the LBAs
> > on the target devices which eventually receive the I/O. Nobody says
> > there is a computable constant offset. Think scattered LVM extent
> > allocations. Or RAID stripes placed at mismatched LBA offsets.
>
> The constant offset relationship still needs to hold over any
> contiguous range of a backing block device that can be accessed by a
> single I/O. For example, with partitions, it's not possible for a
> single I/O to cross a partition boundary, so each partition can have a
> different constant offset between the ref tags and absolute integrity
> interval numbers. With RAID, each shard can have a different constant
> offset. etc.
>
> >
> > > To see the issue with the current approach, consider an example
> > > accessing LBA 1 on a device with a 4 KB block size. If the block is
> > > written as part of a write that begins at LBA 0, its ref tag in the
> > > generated PI will be 1 (sector 0 + 1 integrity interval). If it's
> > > later read by a read starting at LBA 1, its expected ref tag will be =
8
> > > (sector 8 + 0 integrity intervals), and the auto-integrity code will
> > > fail the read due to a reftag mismatch.
> >
> > Something is broken, then. Because the ref tag in the received PI shoul=
d
> > have been remapped to start at 8 in that case.
>
> Ah, I missed the remapping piece. Thanks for pointing that out. I
> guess I was testing with a ublk device that doesn't advertise
> BLK_INTEGRITY_REF_TAG. Since commit 203247c5cb97 ("blk-integrity:
> support arbitrary buffer alignment"), the ref tag is unconditionally
> set in the PI from the (sector) seed, but the remapping is conditional
> on BLK_INTEGRITY_REF_TAG. That explains why I was seeing ref tags in
> the PI that didn't match the integrity interval numbers.
>
> So seems like patch 1 ("block: use integrity interval instead of
> sector as seed") doesn't need a Fixes tag. Still, I'm confused why the
> auto-integrity code bothers setting the seed to the sector number in
> the first place if it's going to be remapped later. Why not just leave
> the seed zeroed?

Martin,
I would appreciate a response here. Would you be okay with patch 1 if
the Fixes tags were dropped? Do you think we can get rid of the ref
tag seed initialization entirely if the ref tags get remapped later
anyways? Even if patch 1 is not required for correctness, patch 2 is a
fix for a separate issue introduced in the 7.1 merge window and has
reviews from Christoph and Anuj. I would prefer not to hold up that
fix over this ref tag seed discussion.

Best,
Caleb

