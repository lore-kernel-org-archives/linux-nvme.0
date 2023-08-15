Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986C4C001DE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FA7UNvLh/NtwE8oB7thsQ+ZgxpcPVqBILp5Db1EACXc=; b=ulRQDggIeGqUiS7evcvftn5OdF
	2LBYolEMII2R2aGtDq1Q+JWUXDO/V0amwTxA/jxx3LLCVvTCpK6lefYGrnLUlnXXsbMDHdpI2sD6+
	smO9MR7sUJaB8dm3cVopbLmNO1su0oWTMLDKb7nbbN2ooq0f6yv2Os9LXIhyNflySqeI4Ym46okIx
	5LCD7Ea0trJnvMJtz8jGVhG8kQH6QtCXKUdXBfU4YqVbCIMvmBBinzdE/bN7bqnZurruu4iDLF7D/
	3GF9omHk7GLIEViFI4meK3g/AXxbmj8f+So4RcwRIwm8C9ULC/Vez8zuO2wG9PKzsSKxYbZFqh0mr
	T61AGVQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVoou-0015rf-0j;
	Tue, 15 Aug 2023 07:50:28 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVoos-0015r5-1I
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 07:50:27 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d62ae3fc7f1so3876935276.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Aug 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692085824; x=1692690624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA7UNvLh/NtwE8oB7thsQ+ZgxpcPVqBILp5Db1EACXc=;
        b=i0vKNHq1GyS7aJEKx4XbRrsU+PCcQIEbW/RUDNyYjiAhDowmhMMCSpCW5uqmbQYhfU
         0aUkNENEhyHUH4Og5FtJz4fLzUNs8pGPtvJaT5Pkmq4GcQ/RG1xOk8lJmVot4NzXWVVT
         +EMe6Dsl16OBo1dKVXSrxy5sAXiDQQSezHfSLr+N0mYaql5ivZV9RC8qIGjF3BhqSdKg
         j5NtGUd5VhucPZcectiLfIEWE2KX5unNEKK4w7eXIN6v5EBbc+sUKe2KXowzCE0hsBLU
         IEfIZ1j3G9HfgN28SkhRqgplcntyqqZY6LS3sxLFknEs9+E4rix/NQLSeE45SDLAtyzU
         d/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085824; x=1692690624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA7UNvLh/NtwE8oB7thsQ+ZgxpcPVqBILp5Db1EACXc=;
        b=HZSJ883eCgZLd5TkbcEfz89MMf4BFoXyjlRSs1xm6OpBx6UNwLmCLYtsrMkM+8y15Z
         UrRNJC/vnpyp4QbOB2sZcMEB6ksv9njLkk35EuGgmH6UQfFE4cRotbCWlMH/YQHZuIbe
         B7tojheBEzyIzNzGr6YE2kgAJ1Kz3vlMftqHG/VXLvJPaYQz0So6e0x+PGNo0ZRRKRmc
         ftmHLvBXmVD7o2Z9GuFTSNuETaDmTjnEOd1gCJg46ugNAg9uYZ/9+8HFJpcZmcwh0tod
         Eb4dzSysEZgkSInMduaT/KqU88CSGYiu4y2+Fn3xAowgf6Xh7q0FRvm154yUzjNHz6gQ
         c9tA==
X-Gm-Message-State: AOJu0YzamwZDTVb6vbhVb8Zt4R9DQ8XibLsoeBM7uWnlTVvM3STm3MUE
	4xsf3UKzJYDS0TXwYA2frf260EHiXSYlKwAVqfA=
X-Google-Smtp-Source: AGHT+IHaiDSMY+QkhVwb3BPgUZZO+nmIvLSHf5aXIVOauSuFeN6IaJFsD4dH94ZZRJntrGxxCFrmO4AX2M6byBZ62ig=
X-Received: by 2002:a25:bf86:0:b0:c83:27d4:c0d6 with SMTP id
 l6-20020a25bf86000000b00c8327d4c0d6mr9479331ybk.37.1692085824032; Tue, 15 Aug
 2023 00:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com> <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
 <20230814121853.ms4acxwr56etf3ph@green245> <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
In-Reply-To: <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Tue, 15 Aug 2023 13:20:12 +0530
Message-ID: <CAOSviJ1XL1UyMk2Ur37cJpW5BJAE5Ts6J4BtTSRd2_h_NPtGCQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, 
	linux-doc@vger.kernel.org, gost.dev@samsung.com, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_005026_441184_A2A08B63 
X-CRM114-Status: GOOD (  18.14  )
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

We had kept this as a part of blk-types.h because we saw some other functio=
ns
trying to do similar things inside this file (op_is_write/flush/discard).
But it should be okay for us to move it to blk-mq.h if that=E2=80=99s the r=
ight way.

Thank you,
Nitesh Shetty


On Mon, Aug 14, 2023 at 8:28=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/14/23 05:18, Nitesh Shetty wrote:
> > On 23/08/11 02:25PM, Bart Van Assche wrote:
> >> On 8/11/23 03:52, Nitesh Shetty wrote:
> >>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> >>> index 0bad62cca3d0..de0ad7a0d571 100644
> >>> +static inline bool op_is_copy(blk_opf_t op)
> >>> +{
> >>> +    return ((op & REQ_OP_MASK) =3D=3D REQ_OP_COPY_SRC ||
> >>> +        (op & REQ_OP_MASK) =3D=3D REQ_OP_COPY_DST);
> >>> +}
> >>> +
> >>
> >> The above function should be moved into include/linux/blk-mq.h below t=
he
> >> definition of req_op() such that it can use req_op() instead of
> >> open-coding it.
> >>
> > We use this later for dm patches(patch 9) as well, and we don't have
> > request at
> > that time.
>
> My understanding is that include/linux/blk_types.h should only contain
> data types and constants and hence that inline functions like
> op_is_copy() should be moved elsewhere.
>
> Bart.
>

