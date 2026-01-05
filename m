Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A88CC79FBD
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=; b=nnAg20LwMUmJZ0Ned/g9ZxNy41
	bthpXYMvngHZ9kkCkSXXAqz6ypcbfMDLayay37Vh6JC82SlZKoQ8nkTUkC5G2Kz0Sd/eRkRddhNkl
	QX1W87YhBddXachUoWfb+TXnu40Km2Gy5P3YfgmCwSVJI2vmklEu+SbX3fEziZPw19r5OvX+okI/9
	Kh+U8Q30z+Skxh0gbh3kskSWFPYtm4DzbAlxkNfu+fQKuysVfKpfeHtVmhRLePnFxYYrPGXuGbReF
	e1AT6TuH0HdRUGAwkJSV5JHYghHC10at7ZR/ZBejL2FtVtLpuNu3tPIrBUIoD8gOcr4QbSl6ysVwW
	417BVLiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcqGZ-0000000Byhz-00I7;
	Mon, 05 Jan 2026 19:29:23 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcqGW-0000000Byhe-2AHh
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 19:29:21 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-5eae7bb8018so93396137.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jan 2026 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641359; x=1768246159; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=;
        b=JW8YvmIIIGdnkjT/5gankx2ugHIMJ8DPezYhhrjSbBNdZe9tz7UfWZ/Vc5X/l34P5M
         Z0koJQiT4XLDxgfShOqpL33QiSVogoWoCB07yRTOyAzXa3gBF8ZQPJdj4ns+NJc/xsO+
         BkatOMXhaDgHjvwRiRT/r6Llkh62cmhBxGURQ74itBAVONVWB+TCNasKw3/faCaxa4xy
         i0Mc0hGkytlBtae0VGcIoMFUrta1k398DE+MOeFS6pijWfvVHQAg2BBsVys5wBTV7AdZ
         JzjiZquzQ0U9riJz6fcCRG/XNB6AeESR4GV0OPrjldeu18AA7b6vPSZQwCsycVUejZbz
         4yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641359; x=1768246159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4q7zjiMztx4TqbiphqF7KyHD7GkrdILcLu6qGCKShJE=;
        b=HRzr/x+9nH31MgiS1AsK3I4xJcEXGPnCDZXB6pIwlyxbWOZEEfXIEmDLTi6+BbmxL4
         NwQuEcOnE72067thg8eRuST5I4OdGhVYtxeAReV7UetXW4AOuDy3XsZLWXeXhLy2TrCC
         u/PORbzdkNDMYsQ9XoewuC/rqzGaBT9VY1Hgh6Xvm73TAY93ij3UDg6JMAHeccvci2dU
         0Rb6GHIAqhg1lBR/YDxgLDMzqxkUIdtxQgkV9cYFKOxjzRZ/9d8IfYn9VJ/Uw55nQFsx
         S59Q4nZf/rVVySwRrsUPgUh8/u9UyFrTEUEUqJfiR2Bk3PDdgKKE3no4xTuOBYr3VVF2
         sO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUH+hsBAffPMsTgywMiWg25eOmV8oYwgD1szI/TocVr9UjwwX0dQQ/dfTj5N33i8ne1L7yBvh+1UpP@lists.infradead.org
X-Gm-Message-State: AOJu0YzrwcZYI0mngn/g6RemiWDg21jb65xGATtedDzqRBvqjh/BscEX
	L1sFD2wMAQbJhdMncI1bCWSIOGfF2OLX4rwCHRjtrPSIan7jIPzJL/l5leAC/jyDb5qIXu9u5QL
	/W/vaRPgqctzpf8cOVRjDIKd6DE39aGs=
X-Gm-Gg: AY/fxX6Sd+xIOnCMgHtguVykvzxvNkkkJsA9PwH227vDEzedvKqPRm8h0FavEO/12Vj
	FwaSgxlUDk17R/3pWvogpAccILudukOyXRADGyE1Blx/fZoF/IZ5/dsKYykirtkkGg7Stt3O9bn
	nRXhTr70lf6UFmvcrLYnl9IGmctcC8ELyvCjpVM7OFP38vtgveUZHjOwgYLQHNqgekAzBp7MdCl
	qWGlqnYQAtdCbXjA3hp3dMAw4IyWmmgmYM+r5jEGYhAKy56+3VWbQOyJC2q/jxspo+YSvmn768d
	Km9+jj5Ukw4va4/1QHSGwfW2wcNH
X-Google-Smtp-Source: AGHT+IEe8UKkk2h7BpzVcEwHWC/sWqwc2MZY4Kvn4Z+IHlV1a0a+CwpvSiV8XUjBASIJ7qPF9b/FYFNA6BO9PO85Rmk=
X-Received: by 2002:a05:6102:3f55:b0:522:86ea:42c with SMTP id
 ada2fe7eead31-5ec74330421mr177233137.11.1767641359029; Mon, 05 Jan 2026
 11:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 22:29:07 +0300
X-Gm-Features: AQt7F2pMgKTlnuto4S9HkLyjodLaVsqWExGHp9yO0nB4jzx8fHD3I6QJ8e7Kamk
Message-ID: <CAPqjcqrqQ7PjPywFgdA-2eXf5LRAP2fAqcFGknnDYrMyqw3W8A@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_112920_564725_0C2BE955 
X-CRM114-Status: GOOD (  27.19  )
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

>As I said before, just don't use RWF_ATOMIC if you don't want to deal with=
 these restrictions.

But how to get the torn write protection then? What if the kernel
decides to fragment my 'once atomic' write?

I'll add some details:

The real NVMe disks with atomic write support which I know are:
1) Micron 7450 / 7500 and probably later
2) Kioxia CD6-R / CD7-R / CD8-R and similar

Both use AWUPF=3D256 KB and NABO=3D0. That means any write up to 256 KB
size is atomic regardless of the offset.

Actually it results in atomic_write_max_bytes being 128 KB when IOMMU
is turned on because max_hw_sectors_kb becomes 128 KB because it's
limited by iommu_dma_opt_mapping_size() and it's hard-coded to return
128 KB =3D PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1) =3D 4096 << 5. But
that's not the main point.

My use case is: I use raw NVMe devices in my project and I want to use
atomic writes to avoid journaling. But for me it means that I want to
do atomic writes at arbitrary 4 KB aligned offsets. And I want to use
atomic writes **safely**. That's why I want to use RWF_ATOMIC - it
allows the kernel to guarantee that it doesn't fragment the write.

With the current restrictions, as a user, I can't do that - I get
EINVAL for some of my writes when I enable RWF_ATOMIC. So I'm asking:
what's the reason behind these restrictions? Could they be removed?

On Fri, Jan 2, 2026 at 8:41=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/12/2025 09:01, Vitaliy Filippov wrote:
> > I think that even with the 2^N requirement the user still has to look
> > for boundaries.
> > 1) NVMe disks may have NABO !=3D 0 (atomic boundary offset). In this
> > case 2^N aligned writes won't work at all.
>
> We don't support NABO !=3D 0
>
> > 2) NABSPF is expressed in blocks in the NVMe spec and it's not
> > restricted to 2^N, it can be for example 3 (3*4096 =3D 12 KB). The spec
> > allows it. 2^N breaks this case too.
>
> We could support NABSPF which is not a power-of-2, but we don't today.
>
> If you can find some real HW which has NABSPF which is not a power-of-2,
> then it can be considered.
>
> > And the user also has to look for the maximum atomic write size
> > anyway, he can't just assume all writes are atomic out of the box,
> > regardless of the 2^N requirement.
> > So my idea is that the kernel's task is just to guarantee correctness
> > of atomic writes. It anyway can't provide the user with atomic writes
> > in all cases.
>
> What good is that to a user?
>
> Consider the user wants to atomic write a range of a file which is
> backed by disk blocks which straddle a boundary - in this case, the
> write would fail. What is the user supposed to do then? That API could
> have arbitrary failures, which effectively makes it a useless API.
>
> As I said before, just don't use RWF_ATOMIC if you don't want to deal
> with these restrictions.

