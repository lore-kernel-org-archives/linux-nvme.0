Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A18E6B272
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Dec 2025 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1eXdIVwHKelFkhb9Ztbf3aqTek3oIROcOvmh4s51PYk=; b=HxlXEgRenSSTrMT+zx2cVDrSPl
	LSNRSKjy5EG7snJ9rE/ci0Jv/2xU00JW+kogVtX7qCxzXzKAPdPbMyvgpViIqxgSi54jId/rfxwHO
	yx6wJs+lxhCxHK5QjCbKCwfNIA2bjJE0Tyna38SJm9nMLrD81VmS4snTcs7ExUi9vHuOOFdb/V8ee
	zFScCN7aULYbBfiKLY64ubRSPdewYPszBzQx01ZhRa8ZhfKtVUPXXVS4zmpstx3YqN3Oaqi9b9mtf
	s8t1+aCaPivoRVOemIVtdGg//F7MZZEaCuv1eUVxTCu0n9NM5lCj3oO5S6VpzscV5fnmu6n7VDG9q
	ozBRlOvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY0QB-0000000EwDi-1oCL;
	Tue, 23 Dec 2025 11:19:19 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY0Q8-0000000EwDH-1FJz
	for linux-nvme@lists.infradead.org;
	Tue, 23 Dec 2025 11:19:17 +0000
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-93a9f6efe8bso1327269241.0
        for <linux-nvme@lists.infradead.org>; Tue, 23 Dec 2025 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488755; x=1767093555; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eXdIVwHKelFkhb9Ztbf3aqTek3oIROcOvmh4s51PYk=;
        b=SMP+Ivo7spHQfWh7zwPpiMVx1AYkiMZyIIdbsOK6jC9D6OtJ/xwaRFp8eU3DIVN0EX
         hNQVrGTafJwlkYpxSW5Om+UZ48ONH6o2cHBPSP7ncSEmsbbVUQbMuj60/dFVPnP6QD1A
         Hu0i1UqdpIkFAablaBJ3RjDWRVIksCYVJ8XtbGoZI9pJAF5uiICcQxN/idDMc3QmbPkt
         IM7pbsVmFM3UM0UqWcAwYR6QsjTEPWM0s2MQcx7sxJfxWbsv58bTqnA7jLM8lugrId+u
         cHRDaCts9uuJKJZC+FSRvBUl0IlwA+7rXdbbP0YT3lIFjtyO6STMn3HqGCO2a44kqFzq
         0uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488755; x=1767093555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1eXdIVwHKelFkhb9Ztbf3aqTek3oIROcOvmh4s51PYk=;
        b=h2AWwt5wtc19J/edUghggLB4mC4AVPe7ypqCr617cWeMVmVAztvNoMu1kO/h1Mg5QB
         /NNcVQ3G4PYLvFXJJMEyCLOdhJOc9jEdE4BtdUl9u9HXbS7w7/Zsq64hSvBn543AON/B
         3A6m5iKH2IcfcR22pUXg1yXy5uoibpiHE1X1xjd2PSHOA6uFu8Dklsu4ysgCYQ4/BC/d
         mraX7apPx2jXnlTe5dnUzoSYlA296pImacyGjhT4bc2DBeakfrRb+lBow9neOh8seYhp
         ADgPOxqv0PgLGcyNmZUz0VZhXUK83k2OXuAJsq013glRhT8sKnprSRccLV7rQrenL/gE
         KgXA==
X-Forwarded-Encrypted: i=1; AJvYcCWbw7eZBk9PRXauJ9qECJC9sOW8+TrvC4tSJ1NmPnYjg5Iys6cmuO+KgLfYlw5+JnYLhU5g9F0dLenL@lists.infradead.org
X-Gm-Message-State: AOJu0YzXzkr6prc0AU3xEv2nO52e5hIIp0DkQV4ZRtQsPOwYiOE7XauM
	rwBF/XI0VAnOai/fVb4I8ZZlZBk/9B1AA4+U9LHUMqbaOzSGVxoVJD/tEqYDQJZLv87gKfp+XTq
	Razbc5ndXTfc+0AQBiqs0zkhg26xl8sU=
X-Gm-Gg: AY/fxX7DLjQI8ouiOundhPqrBTSfM/z7sDgCzl0Dw+HTGHQmwqIbPTWLRLFHW8WaU5n
	dy5WGQ+BSN31/XZc+XY9/ffyU5DHYzdgSnz+/aUGzzMaF3P/jkZbJckpLNyhWqNK+As6Jt8Wq7G
	PB/2i2M2C4OHiAMvLrnxDNzhPC4K8viAlZJKGV3IhlRsayiq4FRojhFcOgahDSltjWEuRxCZ4Tk
	JZSrdo8UlSsWOEmHvkcvpylh8dK1U3UT0p8jfypPQ/KTqCAQxbmOCmRPR7ppJbgJ2MzKZir1ZdV
	oisBGbepn6yO07v5MyP7tWKX2HP4rfcuEtPFA5FKVE/yL167KtJJVgr3P5E=
X-Google-Smtp-Source: AGHT+IGqYfuMT+Zwl+tl6UsRAbxMzMDeJ7TsorbHaeD/KnO8N5c6jy8v1pEwVtaIgrR5qFcARBvMi/oUNg2AZwrR8DM=
X-Received: by 2002:a05:6102:510d:b0:5de:31b1:2011 with SMTP id
 ada2fe7eead31-5eb1a663371mr3330211137.17.1766488754627; Tue, 23 Dec 2025
 03:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
 <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com> <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com>
In-Reply-To: <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 23 Dec 2025 14:19:02 +0300
X-Gm-Features: AQt7F2paTDUpwAoVlsdj8zTzltEorO00TKp7nbh-r7QW6ssOVcfvD3jDLALkKPg
Message-ID: <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: John Garry <john.g.garry@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel+subscribe@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_031916_382333_0360B1E5 
X-CRM114-Status: GOOD (  41.40  )
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

What does "just the kernel atomic write rules" mean?
What's the idea of these restrictions?
I want to use atomic writes, but without this restriction.
And generally I don't think this restriction is needed for anyone at all.
That's why I ask - can it be removed? Can I remove it in my patch?

On Tue, Dec 23, 2025 at 12:26=E2=80=AFPM John Garry <john.g.garry@oracle.co=
m> wrote:
>
> On 22/12/2025 13:28, Vitaliy Filippov wrote:
> > Hi linux-fsdevel,
> > I recently discovered that Linux incorrectly requires all atomic
> > writes to have 2^N length and to be aligned on the length boundary.
> > This requirement contradicts NVMe specification which doesn't require
> > such alignment and length and thus highly restricts usage of atomic
> > writes with NVMe disks which support it (Micron and Kioxia).
>
> All these alignment and size rules are specific to using RWF_ATOMIC. You
> don't have to use RWF_ATOMIC if you don't want to - as you prob know,
> atomic writes are implicit on NVMe.
>
> > NVMe specification has its own atomic write restrictions - AWUPF and
> > NABSPF/NABO, but both are already checked by the nvme subsystem.
> > The 2^N restriction comes from generic_atomic_write_valid().
> > I submitted a patch which removes this restriction to linux-block and
> > linux-nvme. Sorry if these maillists weren't the right place to send
> > it to, it's my first patch :).
> > But the function is currently used in 3 places: block/fops.c,
> > fs/ext4/file.c and fs/xfs/xfs_file.c.
> > Can you tell me if ext4 and xfs really want atomic writes to be 2^N
> > sized and length-aligned?
>
> As above, this is just the kernel atomic write rules to support using
> different storage technologies.
>
> >  From looking at the code I'd say they don't really require it?
> > Can you approve my patch if I'm right? Please :-)
> >
> > On Mon, Dec 22, 2025 at 12:54=E2=80=AFPM Vitaliy Filippov <vitalifster@=
gmail.com> wrote:
> >>
> >> Hi! Thanks a lot for your reply! This is actually my first patch ever
> >> so please don't blame me for not following some standards, I'll try to
> >> resubmit it correctly.
> >>
> >> Regarding the rest:
> >>
> >> 1) NVMe atomic boundaries seem to already be checked in
> >> nvme_valid_atomic_write().
> >>
> >> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
> >> already checks it, at least
> >> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
> >> max_hw_sectors_kb.
> >>
> >> 3) Yes, I've of course seen that this function is also used by ext4
> >> and xfs, but I don't understand the motivation behind the 2^n
> >> requirement. I suppose file systems may fragment the write according
> >> to currently allocated extents for example, but I don't see how issues
> >> coming from this can be fixed by requiring writes to be 2^n.
> >>
> >> But I understand that just removing the check may break something if
> >> somebody relies on them. What do you think about removing the
> >> requirement only for NVMe or only for block devices then? I see 3 ways
> >> to do it:
> >> a) split generic_atomic_write_valid() into two functions - first for
> >> all types of inodes and second only for file systems.
> >> b) remove generic_atomic_write_valid() from block device checks at all=
.
> >> c) change generic_atomic_write_valid() just like in my original patch
> >> but copy original checks into other places where it's used (ext4 and
> >> xfs).
> >>
> >> Which way do you think would be the best?
> >>
> >> On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.org=
> wrote:
> >>>
> >>> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> >>>> It contradicts NVMe specification where alignment is only required w=
hen atomic
> >>>> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe =
atomic writes
> >>>
> >>> Commit header is missing the "fs:" prefix, and the commit log should
> >>> wrap at 72 characters.
> >>>
> >>> On the techincal side, this is a generic function used by multiple
> >>> protocols, so you can't just appeal to NVMe to justify removing the
> >>> checks.
> >>>
> >>> NVMe still has atomic boundaries where straddling it fails to be an
> >>> atomic operation. Instead of removing the checks, you'd have to repla=
ce
> >>> it with a more costly operation if you really want to support more
> >>> arbitrary write lengths and offsets. And if you do manage to remove t=
he
> >>> power of two requirement, then the queue limit for nvme's
> >>> atomic_write_hw_unit_max isn't correct anymore.
> >
>

