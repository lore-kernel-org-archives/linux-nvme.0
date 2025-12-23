Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43211E6B274
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Dec 2025 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uksPH/bt5lZqNSEYs+iqY9x3zVZnqcBLH6mlcdZ6GZM=; b=x90Q4E2LZKce+ApWNrIiWY51EO
	7bEzK+fMJh/dpEpyWh6hp+NON6BJsdHfSJs2pLqDyKJsV5DK3hmN+qiDfukMo5IgA928zZKxn3Cyy
	MYLB8xb74v8OURp+fx6TL46CfKP94tESqwxDQjXvSiKF4lXMc4phrY9O/gglRSGc2GhAksJx2k7vW
	ZKWGopk040ZYul3aVH9V7HdCxlWLZgbyvWaLo/rGsqQQyVt2Hs/bRuLwMZKwnZvvFUtsmxRwfrUKs
	mhPic8op2E9bSkmaXRrgP2RuQDIKwrwK2XhyDSsbbIW5lxPO2fWYCnfloSTNcfdoFSdlMrvnZW1bh
	w7g+W0pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY0et-0000000ExUF-0sp7;
	Tue, 23 Dec 2025 11:34:31 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY0ep-0000000ExTc-3i58
	for linux-nvme@lists.infradead.org;
	Tue, 23 Dec 2025 11:34:29 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-5dbddd71c46so1678652137.2
        for <linux-nvme@lists.infradead.org>; Tue, 23 Dec 2025 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766489666; x=1767094466; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uksPH/bt5lZqNSEYs+iqY9x3zVZnqcBLH6mlcdZ6GZM=;
        b=WjsMkupQ0gxbn4zYn8eO+I0MxhMaiGBDldiHg9TLbygz3/irexgV09+sP6UplVTDp9
         eqBs6WDBnherp7sTfKvXQMhmuUTT4FxQIrlNjJ3npEthA9vmII32owR8W4wy28D3SZOV
         0Lq4g+n+8PcwTDALz+Bp3BRQqSPupszNjDz6+qI3KZ3E8ao5aFTDG3wF6GzIePbwCGkX
         9CqTSLFQ4Tfb5mGotf0lI1pHzogeY9SsWJVqLN1qgjFM8ey9Loy7UJHFsAbuuQXC40hN
         Gbbbtv8EQ+KjNqgRnInaIlTIJETiMWeeIpe+qTTnJgBRFbobNany8UqN2CAqO50P23xL
         4P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766489666; x=1767094466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uksPH/bt5lZqNSEYs+iqY9x3zVZnqcBLH6mlcdZ6GZM=;
        b=GyQ1Af8xp6Q3OmDqxxqov97acYU+FRwgYQx/7zn+/mPSzCsUYx2MlN+7Q9jAb8m2KN
         H/7YBV5DX9fa37CHHSdU8Zr/XR7JCwulSmFH1IS36ovcm8PCUbDt0bJtQR7QOcTsSyHa
         nTAjQMO/Zf6zzRZRdRkY5oJ3nrjZpG5nlKJPN9l5ATMgpNme5w+ta3iSsCOsxszLXWgO
         /P+RSMEt5Pn8x6ekXyNzaCo74rKh9+2mo7WOKXCkRYKJIO1JmmNoK2TvdQAUFatI7/3L
         /ImQZjxvPmZTuSeiXo1a+m1lGRY99QkawAsovETBoji8jpY9gj6hzn05rulGquLkK4bR
         kgHg==
X-Forwarded-Encrypted: i=1; AJvYcCVbyxQBALB9FzdmXvVLxtkE2vT5NBMdAKrw3BMY20zpxJeuoZpKc4FOJlC19EgJVIAeyDdme3an92UJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8AFoRYtkFjieyegjFfhQEtdHwSHuD1cQXDBDxmMb5YwkmDBKF
	cYh/egYqYUctGv8lxrD41xMCFianpVQ1BZvAiSoqm6cjFQdKAsnOnUYFNAWp7+AzSo6tLGvxsO+
	D1OA7kw7lJGvaCtpCZGLzRXx62TdVexs=
X-Gm-Gg: AY/fxX7kOYsR8ycyFZf44Ei+Sa/t5yk8XAki6kmVufGS/Utm+8dQhCHelvZdY+ILBkF
	2/BJ9AZ/F81iLkm4Jeov1WtkwE1wiG/f2+qSjzDoO4AgEc5MJ9hqHHnXR2+nw0g8LUgWe5z4jQb
	1TUOun13zok8nyVvN/s933jRU0kGSOISa1TWl6XCbMi2StFAu5v+JOcXuNrfR+ZnDLf3lkNe/A6
	B/BultQvYhzfh5mtdFbFCEY/1p6weIQ8dxQLr39f0EKUNK1dV/h4jTrKPTCE2u9Wea/aF2AOyH4
	8ehZT7ggoWsnz6x11IqzAYpqanl0gRW0OuDorPIj+j8mWv57Fd7KDmp+n8o=
X-Google-Smtp-Source: AGHT+IHtMewDH0nrwLunp0cbNlGCqqmmT0A2FaYrWgIGKLCXmMaR4WuAI5YT0d+sWBg1VpYMONc30rJT+m366Xk8YJM=
X-Received: by 2002:a05:6102:2b84:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5eb1a40decbmr4169085137.0.1766489666247; Tue, 23 Dec 2025
 03:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
 <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com>
 <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com> <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
In-Reply-To: <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 23 Dec 2025 14:34:14 +0300
X-Gm-Features: AQt7F2pD0dtUBlO9h4RGLaeS2l0qoy1k1xLOnOT4yB-0G6pm-UBDhObfcpDmadA
Message-ID: <CAPqjcqqjUMNSc20OeNtK7QO+6EZsjVZgvogKskBBP1expmWKrw@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: John Garry <john.g.garry@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_033427_973671_0139D082 
X-CRM114-Status: GOOD (  47.04  )
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

For example, in theory, there are also SAS disks which require a
separate WRITE ATOMIC command for writes to be atomic.
I'm not sure which actual disk models support it, though... :)
But as I understand, Linux won't be able to send this command without
the RWF_ATOMIC flag.
And RWF_ATOMIC is limited to 2^N and length-aligned writes so it would
block SAS/SCSI atomic write usage for at least part of use-cases.

On Tue, Dec 23, 2025 at 2:19=E2=80=AFPM Vitaliy Filippov <vitalifster@gmail=
.com> wrote:
>
> What does "just the kernel atomic write rules" mean?
> What's the idea of these restrictions?
> I want to use atomic writes, but without this restriction.
> And generally I don't think this restriction is needed for anyone at all.
> That's why I ask - can it be removed? Can I remove it in my patch?
>
> On Tue, Dec 23, 2025 at 12:26=E2=80=AFPM John Garry <john.g.garry@oracle.=
com> wrote:
> >
> > On 22/12/2025 13:28, Vitaliy Filippov wrote:
> > > Hi linux-fsdevel,
> > > I recently discovered that Linux incorrectly requires all atomic
> > > writes to have 2^N length and to be aligned on the length boundary.
> > > This requirement contradicts NVMe specification which doesn't require
> > > such alignment and length and thus highly restricts usage of atomic
> > > writes with NVMe disks which support it (Micron and Kioxia).
> >
> > All these alignment and size rules are specific to using RWF_ATOMIC. Yo=
u
> > don't have to use RWF_ATOMIC if you don't want to - as you prob know,
> > atomic writes are implicit on NVMe.
> >
> > > NVMe specification has its own atomic write restrictions - AWUPF and
> > > NABSPF/NABO, but both are already checked by the nvme subsystem.
> > > The 2^N restriction comes from generic_atomic_write_valid().
> > > I submitted a patch which removes this restriction to linux-block and
> > > linux-nvme. Sorry if these maillists weren't the right place to send
> > > it to, it's my first patch :).
> > > But the function is currently used in 3 places: block/fops.c,
> > > fs/ext4/file.c and fs/xfs/xfs_file.c.
> > > Can you tell me if ext4 and xfs really want atomic writes to be 2^N
> > > sized and length-aligned?
> >
> > As above, this is just the kernel atomic write rules to support using
> > different storage technologies.
> >
> > >  From looking at the code I'd say they don't really require it?
> > > Can you approve my patch if I'm right? Please :-)
> > >
> > > On Mon, Dec 22, 2025 at 12:54=E2=80=AFPM Vitaliy Filippov <vitalifste=
r@gmail.com> wrote:
> > >>
> > >> Hi! Thanks a lot for your reply! This is actually my first patch eve=
r
> > >> so please don't blame me for not following some standards, I'll try =
to
> > >> resubmit it correctly.
> > >>
> > >> Regarding the rest:
> > >>
> > >> 1) NVMe atomic boundaries seem to already be checked in
> > >> nvme_valid_atomic_write().
> > >>
> > >> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
> > >> already checks it, at least
> > >> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
> > >> max_hw_sectors_kb.
> > >>
> > >> 3) Yes, I've of course seen that this function is also used by ext4
> > >> and xfs, but I don't understand the motivation behind the 2^n
> > >> requirement. I suppose file systems may fragment the write according
> > >> to currently allocated extents for example, but I don't see how issu=
es
> > >> coming from this can be fixed by requiring writes to be 2^n.
> > >>
> > >> But I understand that just removing the check may break something if
> > >> somebody relies on them. What do you think about removing the
> > >> requirement only for NVMe or only for block devices then? I see 3 wa=
ys
> > >> to do it:
> > >> a) split generic_atomic_write_valid() into two functions - first for
> > >> all types of inodes and second only for file systems.
> > >> b) remove generic_atomic_write_valid() from block device checks at a=
ll.
> > >> c) change generic_atomic_write_valid() just like in my original patc=
h
> > >> but copy original checks into other places where it's used (ext4 and
> > >> xfs).
> > >>
> > >> Which way do you think would be the best?
> > >>
> > >> On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.o=
rg> wrote:
> > >>>
> > >>> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> > >>>> It contradicts NVMe specification where alignment is only required=
 when atomic
> > >>>> write boundary (NABSPF/NABO) is set and highly limits usage of NVM=
e atomic writes
> > >>>
> > >>> Commit header is missing the "fs:" prefix, and the commit log shoul=
d
> > >>> wrap at 72 characters.
> > >>>
> > >>> On the techincal side, this is a generic function used by multiple
> > >>> protocols, so you can't just appeal to NVMe to justify removing the
> > >>> checks.
> > >>>
> > >>> NVMe still has atomic boundaries where straddling it fails to be an
> > >>> atomic operation. Instead of removing the checks, you'd have to rep=
lace
> > >>> it with a more costly operation if you really want to support more
> > >>> arbitrary write lengths and offsets. And if you do manage to remove=
 the
> > >>> power of two requirement, then the queue limit for nvme's
> > >>> atomic_write_hw_unit_max isn't correct anymore.
> > >
> >

