Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB02C5B555
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=; b=bgN4iQbAHxSO3GBafUXtlrj8o0
	jz9kkcNGd3Cx35B1DziNuPzd9KEdT9M6YoQ3op3KMguohTRIi6KKdcxs8m2sF9zMDC1/6yLKgFh73
	KGQ95bpGTIp8Wn6d4YxTpejDw1mjWrEDajm3lB8sNHSQQE5My7tHwKwyJVEm2LwOheyegdoxemM1w
	NVR3dyvW1iRiefBMLILcyN8MFZI6j1f+xCfRKvrLopzvoPNmALbJpYpbl5JirXxkUuWgwz351qVMl
	Fsua8f+CFG7MNQHTsOm0/gJ870uj04nvGbnB4Ue9B8oR2F45F2kDKTObuPGHXRpENEXQMvubPp3tY
	RyXtDgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNY12-00000000QGz-1YYs;
	Fri, 06 Jun 2025 14:25:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNY0u-00000000QFY-1A6Z
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 14:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749219942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
	b=NOHgSDYSQZGf2K4yejY5oi5wPxdYYu9DkW50/kq/SvOs8b2Nci8Qa7rkUpik7mmhIk+yF2
	RgKsz2hrGxHeaKNXXXDmlTDgkrtyorQLdscKq3CmyirKQSCIXwR1D2zLsLiLFLlnRnAtEN
	tyqfAFVQ+EaW3B8XjbhRtjI9V7N0lF8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-gIr-4OeaPxibpEeXkdVU1Q-1; Fri, 06 Jun 2025 10:25:40 -0400
X-MC-Unique: gIr-4OeaPxibpEeXkdVU1Q-1
X-Mimecast-MFC-AGG-ID: gIr-4OeaPxibpEeXkdVU1Q_1749219938
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32add2506abso8302011fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jun 2025 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219938; x=1749824738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
        b=M/eNWgvJGIZ+PU/PbXiEOOizuBezYVMkNNT3POuKd9EFe0b1QhIIE82B1BencYZbwz
         uM134C6Jyumc/tXHV5PvSEjoFp34vl3yjf6BjoPfmRTQVn4bxPGlUWu6mWXk3IxyfWO9
         pRRTTVUDZC50IVgtU4wsOE//C59ib/1layfu4sPzoGqHagH1MgIe1ZCI+kAMC+v3RWi3
         K5o0zFwUyCaRsjQI+J3uvsRSZBZ65wTaUqYyx4BV6+qbp/f8zjRcZ5t8idRJeCQrdOjU
         PRuqcZU6Tk4oWXwDG6GgRS03eQY+1ePzZuGHyAFGMdh17+exXAv0IyoPy/ukd/um7en3
         B+3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2n2ReqHPyumViYRS4NabarGFLI3RrhcV2VSd4lPYkRpl2ur5KC+bfB6duwwfR8f5Bv78CoOK2g45K@lists.infradead.org
X-Gm-Message-State: AOJu0YwAc0H8y5cXGp2bKpetNQod5WWQb88yI7ia9PngpPBtHCS2soeS
	PH4n6rbwwnO28nP8Zwzb4ZRGD8/ts+yODRQ7LS6Ciy9QpMfyG8zhFE227KPE0GBLGiaYfIDnLL6
	mKv685GsWLl3U53JhRkI5YEBtbp8J3B02cjRrPh0VIPggOL64IT5vs3SoHwUgTl3hcrdIWly2Lo
	9ZKub/70rPqPsALsZtF7cmZnsBAnYLv5HUwSoNGfzWwCk=
X-Gm-Gg: ASbGncvKisNGAvmTgQjV3OyBSUtDTKX4ZcJfN5DGlSWKibu9aKyg+C4Uii7vCUJKQMg
	wno3uScCu9SXFNIX9MjlGJwOYhFqYlpW1TrZmpg66ak7nK8/4mSnuQDWne8Vn6I53rATpMYVLOo
	Y6+uwh
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id 38308e7fff4ca-32aec98e7b9mr2665421fa.15.1749219938108;
        Fri, 06 Jun 2025 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXglcxl80BE482xq4dx91qTebsclNfPlMg1sw20ymT3/ZEh0z8jxknKBzXzbqnEY78ZQMjNrsOPiXqzhYfTLw=
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id
 38308e7fff4ca-32aec98e7b9mr2665271fa.15.1749219937714; Fri, 06 Jun 2025
 07:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local> <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
In-Reply-To: <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 6 Jun 2025 22:25:25 +0800
X-Gm-Features: AX0GCFuL4XNUJVJ0lfr1A30P6N_O92q6LMT8TriVlRQc68jUCEDZAsCtx8zBrpc
Message-ID: <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
Subject: Re: blktests failures with v6.15 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Tomas Bzatek <tbzatek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nguNTb3vlQxFZCGcLYZezVLOR8zAFDDCAnuWsS10KRo_1749219938
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_072544_385929_DE12F4B0 
X-CRM114-Status: GOOD (  17.52  )
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

On Fri, Jun 6, 2025 at 3:55=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> To+: Yi,
>
> On Jun 05, 2025 / 15:02, Daniel Wagner wrote:
> > Hi,
>
> Hi Daniel, thank you for the fix actions!
>
> >
> > On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> > > #1: nvme/023
> > >
> > >     When libnvme has version 1.13 or later and built with liburing, n=
vme-cli
> > >     command "nvme smart-log" command fails for namespace block device=
s. This
> > >     makes the test case nvme/032 fail [2]. Fix in libnvme is expected=
.
> > >
> > >     [2]
> > >     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323=
f5d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee
> >
> > Should be fixed now. If you want, I can do another release soon, so the
> > fix get packaged up by the distros.
>
> As of today, CKI project keeps on reporting the failure:
>
>   https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aar=
ch64-kernel_upt_7
>
> Yi, do you think the new libnvme release will help to silence the failure

I've created one CKI issue to track the nvme/023 failure, so the
failure will be waived in the future test.

> reports? I'm guessing the release will help RedHat to pick up and apply t=
o CKI

Yes, if we have the new release for libnvme, our Fedora libnvme
maintainer can build the new one for Fedora. I also created the Fedora
issue to track it on libnvme side.

https://bugzilla.redhat.com/show_bug.cgi?id=3D2370805

> blktests runs.
>


--
Best Regards,
  Yi Zhang


