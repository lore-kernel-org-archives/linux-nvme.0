Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FBC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRRTCbiGACPoljjVpBjW3QwozpnkiX8EBP1CGqAYlv8=; b=Aix7q+3GeHjF6WhK+NpCxbkwiZ
	VOgNv+uZX7j4kJpbCEQHdRYBd4HMr/JhzCjwdfvgOjoY02HLTxMV73hzHRi6DMcq/zKYZO5cLXQEF
	/paq9qVOGhaH7ypa9Lr/LGlRajzko5vsj6n47RsObJq43OVCW4LiBcJFGnFeZ62DAJpJ/RYJa3V0U
	bhx0UmwjCevYalSlNVwCsbYlQ25TvhmpWgywMrf150vOwCUHC/3RTQTLoNyZiSOl7t6xOZqRjRDdc
	2AKC8QVYg2sDikoJ8iyWycsODdbZPlGbd1Wf3Onti52Y2myg33mAkOJkWX/IkcQXVUcQV9T2NRM+M
	xgxjfqlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJWy-00FJm5-2V;
	Mon, 03 Apr 2023 12:43:28 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJWw-00FJl3-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:43:27 +0000
Received: by mail-wr1-x42c.google.com with SMTP id y14so29226441wrq.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680525802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRRTCbiGACPoljjVpBjW3QwozpnkiX8EBP1CGqAYlv8=;
        b=C6y5I5N6i+3y5ePLo/VvtJb9Ti6nNN2dPQO6o9nEN7tPhjire+DjEjZmx5VBJP033s
         7hV9+QEne9Zp0843ldbfAVB4xCR1pEmhSyIcjoLviKSHYEbPV8qmogBjdAxzMl8bjsbc
         leantIoNP/Wlt/m2nGc2+U/b56l0oYyejHsLU+W4skX6Kf/XKutxXHGf8/whU8f0m2rQ
         c8wh8xJazc88AH08bUeVGWRrvMyf2Ie8KKxhBuWimx+O/Kgt62AwgQz47lQSJBJQj6YU
         pFIPv1Zyk4ZIlL/7MG+vsv2NwiSZ8cq+Hs/aKPqNu6QmmGQXuunBTOQoyFanoSK1C2pT
         ZR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRRTCbiGACPoljjVpBjW3QwozpnkiX8EBP1CGqAYlv8=;
        b=DW0URmgWGWTTJ2zjDt2hcirLbW3uZOwi+hYhqgHHNb0Ttqkqp7ngueq6jdfIFE6y38
         CNQL1e5UoEM7OCz1dykAnGl3Li9U5X0vtpzrVDXueWDB+cJT80SDt8+0z2fOEC766NpT
         lCz2nRKWdBXUDcf5NFqHNXl1CePgxSDohHOy41GIZdrrp9WMGCg85asJAgeg67gCPV28
         If3pT8z+b8bqb9lUnEtZZSLXzjXyOlj8HUKZoxVuRxTolz7ZDyd6rJyBTkCP7p7KKEOm
         OHdMnwF+vPqucSWAlA7GmOqUL/8Gr87vE/Jp27u09UoFON9tXJYH5e5Hf0aFq/2iTQaU
         SsdA==
X-Gm-Message-State: AAQBX9dUvFYNpO1Zxzw3ErFIT/yKJtm2XvV7NhYED5cWvUDC7Gg5VJua
	BPyTsN1UStN9PO1eKefuHIA39TsI0ZuJleUHyoo=
X-Google-Smtp-Source: AKy350aXpOscQ6kEFa5UuxUnn0eGOFmp4kvli+CJWNXB3ROSV1Vd8T4p86lWHGAY5V8llnRsukBDGhsLSS1jXhzfp0k=
X-Received: by 2002:a5d:5691:0:b0:2cf:efad:9c23 with SMTP id
 f17-20020a5d5691000000b002cfefad9c23mr5891388wrv.14.1680525802212; Mon, 03
 Apr 2023 05:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212803.1837554-1-kbusch@meta.com> <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com> <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
 <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com> <20230328074939.GA2800@green5>
 <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com> <20230329084618.GB2800@green5>
 <ZCRjGmPCeLvi2m39@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZCRjGmPCeLvi2m39@kbusch-mbp.dhcp.thefacebook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 3 Apr 2023 18:12:55 +0530
Message-ID: <CA+1E3r+OrN-sFQ5TGC238Km=KurOZBvx+1ZeLXA=tsrgZZo8Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_054326_499742_C07EAC1E 
X-CRM114-Status: GOOD (  18.40  )
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

On Wed, Mar 29, 2023 at 9:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Mar 29, 2023 at 02:16:18PM +0530, Kanchan Joshi wrote:
> > On Tue, Mar 28, 2023 at 08:52:53AM -0600, Keith Busch wrote:
> > > > > +       else if (issue_flags & IO_URING_F_IOPOLL)
> > > > > +               ioucmd->flags |=3D IORING_URING_CMD_NOPOLL;
> > > >
> > > > If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags=
", we
> > > > could have just cleared that here. That would avoid the need of NOP=
OLL flag.
> > > > That said, I don't feel strongly about new flag too. You decide.
> > >
> > > IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly lik=
e it is
> > > part of ioucmd->flags, is actually ctx flags, so a little confusing. =
And we
> > > need to be a litle careful here: the existing ioucmd->flags is used w=
ith uapi
> > > flags.
> >
> > Indeed. If this is getting crufty, series can just enable polling on
> > no-payload requests. Reducing nvme handlers - for another day.
>
> Well something needs to be done about multipath since it's broken today: =
if the
> path changes between submission and poll, we'll consult the wrong queue f=
or
> polling enabled. This could cause a missed polling opprotunity, polling a
> pointer that isn't a bio, or poll an irq enabled cq. All are bad.

I see, that is because "nvme_find_path" was used.
How about using top 4 bits of "ioucmd->flags" for an internal flag.
That means we can support max 28 flags for "sqe->uring_cmd_flags".
That perhaps is not too bad, given that we use one bit at the moment?

