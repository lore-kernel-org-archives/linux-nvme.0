Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1284E81E1B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYLhV8RKvbCInhnzqZ/HGBAbLzuMZXeZ10wGn+QIDt0=; b=bNviYn52Cg2YNDtyo17WW7xcMx
	9/61IZgv0CI5uBgE8jdDicS5u5GmJhyELl800eXEZs/Jp5R5v58GtYpyfSEiSHosKy+Vvnx6fbn90
	iwZv6qKsUFlhUFbiXrpC3RFgw6RWtgUezUZ53cXQwYN0qI0spiMjYDD/v/H8GQTTL14zoTZrn4dQd
	fAbGDf+O3SohpMrVS/hmoZYZjue5auWhMbB63jf+dkNXkNSgZDGrtqPH1WLKzn4/1Jk6KJ7KJXVQQ
	g+DToq8toA1LxD6eIoarWMCGt7uSdJWKtyAePZ/RTEZlZJlgdwpENu3sdBeoXRN6iGBpRPgIFVl5D
	Tt3y7LGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qopMJ-006Ifg-1Y;
	Fri, 06 Oct 2023 18:15:31 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qopMG-006Id0-0u
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 18:15:29 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81afd5273eso2605688276.3
        for <linux-nvme@lists.infradead.org>; Fri, 06 Oct 2023 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696616122; x=1697220922; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYLhV8RKvbCInhnzqZ/HGBAbLzuMZXeZ10wGn+QIDt0=;
        b=Ig/ItowDkDkPLMLmMgbgUn0SuEqIvucaZuO1qYov7V26VeJbw89ZcMaTxzO6kq9faB
         YIw73EQCJ4T5aFncPtgjVxSExz/oshuqSnG+VUIymmo+oNQq0ylM2hbs9DzUDaZPpqYx
         e7gCnS7ktpy+UhEXoji1xlUG2XdrrRczS8NOIdpPA1b+8no8qIYtlPIB0pRy4FkIkrM2
         lNQlA8j45s0eWGh2TvFycBUqdYmjMPz75vAsfcpTlFOzdwogrn6Mku+74NNzLLZlCURQ
         BQ0tuEWHpf1lZkaYHgCIA31SqerMxY/FoWfA9XVj4WAh80EY7QqJTnDfvTBK3XHXJN4q
         L0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696616122; x=1697220922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYLhV8RKvbCInhnzqZ/HGBAbLzuMZXeZ10wGn+QIDt0=;
        b=vffVQzC4MhYOtHtYfKUeDVELQ1i96ORNM95jd5DvNG9gBXg6Ih2UuTFWVqoWq1n4dR
         B2QLhBJihag+ZV1wL6ldwq7QQtET2USWyw/dNU639QxpjAS2j6JR/VNuGScC8MOt8yt+
         AjXEF4hQWhHNK0V/mXZMV03ksfSEiSdI60avWMpzhxHu3xDxO9VxYPcYiPsOwkMeSYIr
         2crJHYBSbNiw60HExwIIKTjPN5xwJw9kZ/LCGoGciqBzsOgM3gyqWHCvHBhh4DSh08o8
         jn8bG1o957fVe0SP3CrNf14CVg3sCyxru7wSNot8xpkYts2GPK+zgdcjDBCH8JxijknO
         aLtw==
X-Gm-Message-State: AOJu0Yx89QZOEMHpiJ3CKslmGaDpJ2bdWQtaqKz+5jMi+HKlZf80tsIp
	xBGDub06pWGkCZDTZervLQ0t/EPGWwr5TVhbCWHNJw==
X-Google-Smtp-Source: AGHT+IHzqypY4NdUT7zu05+MFHgfnxNiLO+3lSgUozk3D6Rhta9XqDneUgYhohjCWFkKwZkcLQmr90WO9qHqGTSh0Io=
X-Received: by 2002:a25:509:0:b0:d7f:cdc8:e184 with SMTP id
 9-20020a250509000000b00d7fcdc8e184mr8607707ybf.49.1696616122514; Fri, 06 Oct
 2023 11:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-5-john.g.garry@oracle.com>
In-Reply-To: <20230929102726.2985188-5-john.g.garry@oracle.com>
From: Jeremy Bongio <jbongio@google.com>
Date: Fri, 6 Oct 2023 11:15:11 -0700
Message-ID: <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
Subject: Re: [PATCH 04/21] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic
 write support
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com, 
	dchinner@redhat.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, 
	linux-api@vger.kernel.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_111528_322180_F5918A9C 
X-CRM114-Status: GOOD (  23.64  )
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

What is the advantage of using write flags instead of using an atomic
open flag (O_ATOMIC)? With an open flag, write, writev, pwritev would
all be supported for atomic writes. And this would potentially require
less application changes to take advantage of atomic writes.

On Fri, Sep 29, 2023 at 3:28=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>
> Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
> write is to be issued with torn write prevention, according to special
> alignment and length rules.
>
> Torn write prevention means that for a power or any other HW failure, all
> or none of the data will be committed to storage, but never a mix of old
> and new.
>
> For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
> iocb->ki_flags field to indicate the same.
>
> A call to statx will give the relevant atomic write info:
> - atomic_write_unit_min
> - atomic_write_unit_max
>
> Both values are a power-of-2.
>
> Applications can avail of atomic write feature by ensuring that the total
> length of a write is a power-of-2 in size and also sized between
> atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
> must ensure that the write is at a naturally-aligned offset in the file
> wrt the total write length.
>
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h      | 1 +
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b528f063e8ff..898952dee8eb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -328,6 +328,7 @@ enum rw_hint {
>  #define IOCB_SYNC              (__force int) RWF_SYNC
>  #define IOCB_NOWAIT            (__force int) RWF_NOWAIT
>  #define IOCB_APPEND            (__force int) RWF_APPEND
> +#define IOCB_ATOMIC            (__force int) RWF_ATOMIC
>
>  /* non-RWF related bits - start at 16 */
>  #define IOCB_EVENTFD           (1 << 16)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..e3b4f5bc6860 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND     ((__force __kernel_rwf_t)0x00000010)
>
> +/* Atomic Write */
> +#define RWF_ATOMIC     ((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -                        RWF_APPEND)
> +                        RWF_APPEND | RWF_ATOMIC)
>
>  #endif /* _UAPI_LINUX_FS_H */
> --
> 2.31.1
>

