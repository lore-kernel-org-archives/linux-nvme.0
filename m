Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B3CD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIm1zhR7gsNVHRI/hWf0WO0lqGit6EeoqG5xMFYLc6I=; b=MXOUS+/KdJ6idMDXoGfrFWjyM4
	v6Zqp8UaP5LVsEAIKCMnKVA4hf2XWNcbRet1z4XC5Av24B9DZRe2izSnSBopdijescMOnzF1q5oRf
	RUGXL7EhcK1t5N/hSFplFv5vDnPBEOn5A9eFw7yM6HPbXzy3AzNQraUZ1xUh6ditlX2yxXz2OpEJV
	N+Gg/JP5x1mgU+gg3O8XeT7cQoT01eRqQwtrZIlf+MrXG1J7YXxuKkg92R/G/UDZapIQKMMbDNSWt
	rl8kTlyS6qBbDqnkivY1Us+JZBtWFjcm8LY/+jHlcepYUYbiC+wMikujzxRITwAPdlHxNoyUy3sWZ
	nyxhdjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNov9-00000007uRF-3cLW;
	Fri, 15 May 2026 09:33:27 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNov4-00000007uNw-2BVk
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 09:33:25 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1361457066b.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 02:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778837601; cv=none;
        d=google.com; s=arc-20240605;
        b=bHtcjdJD0JA0NdtaPRI1Z4Yn7b8QyWuhxsaSD1mBWWCPbTmaP7vd5VU7379UW+5fIV
         pRfqKy6rgrUugvoJcwXdAt5KoY2oKqP3TC73VQSRh2sf4xqR9kbPwKpWbHEMd+j4QcPz
         2npL5UVD8QWgF3U8xVsaDodCZ438QfeXILaxbMwiNmHWmyhEJ7n4gKaTk9qVVOWX0psj
         UMYzYFi5YV3jyXHnKEIeenr2RRHLn/qbVqn2O0pAktMAvYqzfPVCNvBxJ1XpMmVkBFZI
         4GT5xz4RSBHv2bc3cPAJuT0i2TQlT3EctOn6JUy+ZYR3c0EnMOnYTEJum/mEUoIGSWpU
         z2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FIm1zhR7gsNVHRI/hWf0WO0lqGit6EeoqG5xMFYLc6I=;
        fh=dfGlokYLPNVEeWhAOGX42T2myn05MpWzXryM6Lh/n8w=;
        b=dlF5JLkB8kCS6JVIEwSVWlz6glpV7juxIbg99uH+wd626SQMIyK8KR464gr8E/0elN
         E2JDjfD0G2v+F3mTBkGRekYX71J8UJHZHESk7BQe7neEhwd1ktU1cWCYzRpqfvUYpvDA
         mDGSdZSjRkJLnWphGqn7BjHmL8hpnVelV3Qvwe5arpNVFquqOSWXMI+j6k31kx9nbYJF
         H0OseTo7Hc9EwJdvAnxO2eVRqdRGc6iWao1XzVk6p1EYN8xxcim0KXNSixjvAXxYnriF
         0r/2ai3o+GiqMGpg2hovwrmum2VvpcDtChLRYJUJL1DsLAnDblVFFEPqPezPUN+GDa6M
         rinw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837601; x=1779442401; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIm1zhR7gsNVHRI/hWf0WO0lqGit6EeoqG5xMFYLc6I=;
        b=HKBYW16Smsuw8Bc7CrSVVQ+3enhHtlr2/9VDn7bwMT4+eupDQZLYoTlzOnDXX8/J3J
         uZ7NbmUd+kqwE/u2M3PIP80zxCSHNfy060T2UwxN7mMNTT2boCPkMG9bWmV5TJAFvYMh
         UNepjE1ShOgqn2e2zORHezcYbnw2w8KteV1BsANB66pEoiDfjp/U20QaClfDjluXeqgU
         /DDff/twEyC1Crnns/xGBvJ/9NWdO2QZHuy63+aQxc5dSmOGgAMYccRKQ86BDQkWqdEe
         T5CDdSkB8FGYEP3l9Wbh7GnFtR7Qppxw6zpP1PhByzmhnLIjdDLLtT+awwWGz7ZKLICe
         3WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837601; x=1779442401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIm1zhR7gsNVHRI/hWf0WO0lqGit6EeoqG5xMFYLc6I=;
        b=NkMi4tYtBLn76L7GPq/yj2I8p0Ho3e/rO2FnoMXAwku/i4N8ne3CXDxgfizVUkAEZ6
         z1COIU2YSLz1j8+zcIBehULJrgvfJMKXDf68NYmL+O1TaL1fCMSd1KqvJ0q44Fx8bBp+
         F/CGTEmyU6NRwRa7ncZz8QU5k7fn/LuRVohocFnhdop5AJ4hBGi2qH3Kn77Lj3PX0QGH
         He9b6Vx/4xZyAI/uX8rRFdFxgUdIVR87LfkwQ/Td98bxgoACSJAKfkalFDtScxU9skOJ
         iMuNHQEh8mpLTQAhKVgkThsMQ2qDuajWnhcX2KTFIrwQBf9/sHJj9r4Tsxo+TK03qerK
         9WCA==
X-Forwarded-Encrypted: i=1; AFNElJ9CN548V53N+Bck2TeGOBhBXZFGiO66Osw2gUTZz/me0dqfyN01LpafLSTU+Bkbgg0/lofvFhdPjifV@lists.infradead.org
X-Gm-Message-State: AOJu0YwbpQdNv+ZcfyJM01AMWTche+xGQokvxDfaJq//OlWzjLPZU7hp
	PMVCye3l3f6h2Lm8AdZ+3yIVK+ITFui6ESAxDJY5G1/8hWTb77NGVv26rrOmJ7VLGaMBa42aHYH
	3XWKJJvYh4rikvFtXeKV8GlS6VQBevwI=
X-Gm-Gg: Acq92OGZbvF0iDSeLBg5TORGcC2SZnxVJgkp3FEfB/jQS9q0lqSmk89ybMEzk/W65AN
	pdXHY4FMA0LUzSpA8/mQkzGCueJ7hUKZ3YtYx+cQjQBxkPT+Ch1GHoEuD+X3xFoxJ13FdP1bklR
	DhVmaUZoN3I2a7NdNsZW/kH5MI9Vui2P9H72Tvok1i6Pq1e9yK9jGVPCSIjp0jmZTyhShB133om
	OU8LPCwiVXBtxvL9qZvpM2rRQ5wgQdmJPHlggKG+T8APlbq9Ew82eHiaoCTZq6l/JjpqB+sgzdD
	QGTcca6c
X-Received: by 2002:a17:907:b801:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bd517929a34mr147754366b.23.1778837600426; Fri, 15 May 2026
 02:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260418042835.420281-1-coshi036@gmail.com> <DHXZ8MK1AASK.VWC6067TNS7Q@arkamax.eu>
In-Reply-To: <DHXZ8MK1AASK.VWC6067TNS7Q@arkamax.eu>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 05:33:08 -0400
X-Gm-Features: AVHnY4IXzZOplL51nqk6PGS5GxCD49avWh4St0BYd8iK3ZKTy4fKZisiDS0PJuo
Message-ID: <CACd_6n3U=wCnMkWxfj+67YDCGjGdKv2fFoaOd5=uOpkAwk4kNg@mail.gmail.com>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify Namespace
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_023324_715231_07A090F9 
X-CRM114-Status: GOOD (  28.03  )
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

Hi Maurizio,

Thanks for the nit on v1.

> If I'm reading the NVMe spec correctly, ds =3D=3D 0 has a special
> meaning: 'LBA format is not currently available.'
> maybe we should use a different dev_warn() for ds =3D=3D 0 ?

I added the separate warning in v2, but Keith pointed out on the
v2 thread that the "LBA format not available" wording in the spec
refers to broadcast identification.  For an attached namespace,
any unusable flbas index value (including 0) is invalid, so v3
merges both cases into a single check.

Apologies for the back-and-forth.

Also: v2 bounced to your old redhat.com address =E2=80=94 using
mlombard@arkamax.eu from here on.

Thanks,
Chao

On Mon, Apr 20, 2026 at 8:22=E2=80=AFAM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Sat Apr 18, 2026 at 6:28 AM CEST, Chao Shi wrote:
> > nvme_update_ns_info_block() trusts id->lbaf[lbaf].ds from the
> > controller and assigns it directly to ns->head->lba_shift without
> > bounds checking.  nvme_lba_to_sect() then does:
> >
> >     return lba << (head->lba_shift - SECTOR_SHIFT);
> >
> > When called with lba =3D le64_to_cpu(id->nsze) to compute the device
> > capacity, an attacker-controlled controller can choose ds < 9 or a
> > combination of (ds, nsze) that makes the left shift overflow
> > sector_t.  The former is a C undefined behaviour that UBSAN reports
> > as a BUG; the latter silently yields a bogus capacity that the
> > block layer then trusts for bounds checking.
> >
> > Validate ds against SECTOR_SHIFT and use check_shl_overflow() to
> > compute capacity so that any (ds, nsze) combination that would
> > overflow sector_t is rejected.  The namespace is skipped with -EIO
> > instead of crashing the kernel.  This is reachable by a malicious
> > NVMe device, a buggy firmware, or an attacker-controlled NVMe-oF
> > target.
> >
> > Stack trace (UBSAN, ds < 9 variant):
> >
> >   RIP: nvme_lba_to_sect drivers/nvme/host/nvme.h:699 [inline]
> >   RIP: nvme_update_ns_info_block.cold+0x5/0x7
> >   Call Trace:
> >    nvme_update_ns_info+0x175/0xd90 drivers/nvme/host/core.c:2467
> >    nvme_validate_ns drivers/nvme/host/core.c:4299 [inline]
> >    nvme_scan_ns drivers/nvme/host/core.c:4350
> >    nvme_scan_ns_async+0xa5/0xe0 drivers/nvme/host/core.c:4383
> >    async_run_entry_fn
> >    process_one_work
> >    worker_thread
> >    kthread
> >
> > Found by Syzkaller.
> >
> > Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")
> > Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> > Acked-by: Dave Tian <daveti@purdue.edu>
> > Acked-by: Weidong Zhu <weizhu@fiu.edu>
> > Signed-off-by: Chao Shi <coshi036@gmail.com>
> > ---
> >  drivers/nvme/host/core.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1e33af94c24..9b3bf3e4075 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2407,9 +2407,19 @@ static int nvme_update_ns_info_block(struct nvme=
_ns *ns,
> >       lim =3D queue_limits_start_update(ns->disk->queue);
> >
> >       memflags =3D blk_mq_freeze_queue(ns->disk->queue);
> > +     if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> > +         check_shl_overflow(le64_to_cpu(id->nsze),
> > +                            id->lbaf[lbaf].ds - SECTOR_SHIFT,
> > +                            &capacity)) {
> > +             dev_warn_once(ns->ctrl->device,
> > +                     "invalid LBA data size %u, skipping namespace\n",
> > +                     id->lbaf[lbaf].ds);
>
> Just a nit:
>
> If I'm reading the NVMe spec correctly, ds =3D=3D 0 has a special meaning=
:
> 'LBA format is not currently available.'
> maybe we should use a different dev_warn() for ds =3D=3D 0 ?
>
> Maurizio
>

