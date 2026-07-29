Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B43FC54FCD
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6uZGNmBdepXlwQoYnMX8X1rJo3FMSk2iCQXyM2emoCU=; b=MzG6p3BeZ28r5cF224PUU3SmJq
	R4FJjcdspFkwpgQNMLi707EaN50f/YSvgRJ422omw+fhPtju8MoLwE7IhcPIkOAS3D7+A6qebV/sX
	loRJOUqNmRaV6J2mpi/1BFzRaFIn1pnb6y6QeEIwi+gXEJNIq95h7LomMYT08AuJaFaPjaiq1199s
	SYFu2gfrlDk4W2nXbg19AHTCcgr/H7+9C0QyadAecud9yWfoJ5FcTL9wXOt3CG1ZNNd2Ht+z+c1AA
	qYBsN1D9R0W7t6ucpGxBO4IsvSNZZKe28TA72zduagPqHwZfTHVaXg/JDqZZZdsnTUWoOdUJmkBor
	NrSCo1Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpC1o-000000091BL-3eq6;
	Wed, 29 Jul 2026 21:41:28 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpC1l-000000091Aw-3xWk
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 21:41:27 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2cc73e322dbso17079395ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 14:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785361285; cv=none;
        d=google.com; s=arc-20260327;
        b=fHHXYVjf+JKvqmLbQujeIzhgq08GR1CmPfwJesjOI0RBr3xweUk9kXmbFwAZm/JhMS
         7zTeh7KDNCuqRmsVcIikp4YEycLKOKQsWoi3H3TDhKxU7zwzzAisewgiXI8y3/Vyeh9/
         ecY2IDx0SPvKHG4fb7Or1s8FhcxVMTfccBh7g3+3WFdAaGlWs/AoAhdlnv6tIvMyQMRz
         YKwFpS18bMhfl0m0bBLwWrEnApxwbuN+uz4KNtm03GlmKwWxzhlCf3RvI69Rg28sfbKI
         lDi5wfWke2yYaIpWN4PrOcT+Ddk2OQOZHwyB7EI7SWkEq6Lsw57Sz7sCNK8vBsF+28fE
         GfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6uZGNmBdepXlwQoYnMX8X1rJo3FMSk2iCQXyM2emoCU=;
        fh=8r+a9I4T4GaUl23kIOBMX4r7iOFhpfGij/fkgB10W0w=;
        b=a9npef+BPhmx3FMlkx0wX97WoaqG6cR7URw26q+pTUsW33JFPFye47VOAmcQ7shHmv
         XPhBl1VXYJwKksDX8Za4YYlQ/vmpy+UVF/h//HLoiOTT4I+/hxMtKx/5wkG0PuW7p4aW
         ve+PD3BXKT9GckyzG1guHVBYvMKd9eJTYrkZtvFWQyH2ouMbqFyvJ0MDTaKjb1qfAXbd
         4TnHXIJUDyV95sx1zBNaywpL7WvC1oUo5NUYPU5fJRtD9x1UTBJsFxZPB/uEuZfpjzZz
         TH1RAx4TeUFQTVp/Sq6rMvwKxgRFktr01k8BMX6fI2PUj2MyRWxxHjgKar4687hVchVK
         s69Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785361285; x=1785966085; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uZGNmBdepXlwQoYnMX8X1rJo3FMSk2iCQXyM2emoCU=;
        b=viKLdze69fVEFckHP5DgAaHYDj9LjbTK33MLJMsHI0+z5wtvVZ4UlWGf/dCUzDFeFa
         JA6AFN73oFp+VyBJnJGgDlWio1+0ACixs4Cs/BZ6X+1RnRjDwTFnCWIfS/h0EyQncOh1
         ZUfI7X9OYNHEbOtuK3yNUHPX3c97SEdhQt0cnErsaL3SnxB8DoocmVGXT1/rTlIdsW1e
         1NY8Dvwr2lnFbK6r6EHlr6cSJZ24r2y1z3YLidth1IoisSwhfJcRWAIi9SfUmqvOZGPM
         Gyr3pfpnBK0/yucI9JV58pRZf5epPZZ/4zqrFTfE44XMshAjozYMLaEhN+fuMpVkZdH9
         EbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361285; x=1785966085;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6uZGNmBdepXlwQoYnMX8X1rJo3FMSk2iCQXyM2emoCU=;
        b=BWSKzOl5KAeS3QNlNI55H8F1wMdOwl2yu+gANbvVOBqmRR0vm0X8jL4gJLiL/po30o
         N6cYascsL0Bn1DMvxXMipFXn+D/kRNxfDkz+aU/MLSX5adNx4XWzCKJMtVM+F/Z1ezfh
         RjktYKG0PcYq/gTDYz5TWsos4kc2r1GurSlz1kNK+dcIpN8lAD8U6vrHUqBLhcviFmMO
         173nNjs7AuQMJXbXQqYry8OZrQxDUf/kUYdU4aR4ijzPuEhuajYa8H93iagUD38YWi+i
         p14ZNTXgD9J6yFG83gTViMLIlNXrkQdpIgMSPz/nYKoLZcDR+qkPBP43NvsysK+2Oq/P
         x9nw==
X-Forwarded-Encrypted: i=1; AHgh+Rp47FqesIaZv7AVdddITnZZR83hJQBUH7LvW5lXvX9kgZ3+ErFMZK6EvYH5tuggBP0c07lov5qceGhT@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq4f7AX/bFbt0XsgQO/pVAMJ7KwFoyNy2/d/L0AXCuyUb1SP4l
	tnTiVBOs3/ioD4A89FZYEKs8c5nv742bDmnUgRlGYJnOrfBEjEawSsf2lPxJMwpVYdYU3/Ztiqj
	p7mj6nAt2mTCwAX9y80c6HQchBeDdCirBnNOMGfT8
X-Gm-Gg: AR+sD10lBaH5TbgF3Y+8BJ6Xv4SUh5x7BPOUG5h5l3GJDkKUmdxuPC0w9nIutjIKdUi
	3+nplSzYjqIyeHq38k2Nx7blaWGvC5lQF4qZykoBxwYww5VWup5nsaTM2BaYQufqi2y6d432hzQ
	WyI+oaR7pxE6eUqRqh5uAYsIVTa4GlKucJXMZk5ps1ElpgBicxG6QbPIH5VO947yb4IrrxTrT8u
	MKTaztBTnlEn2MPPEh4MFHkMdUJ6hdBFiJ57fNL2Cr2RT3TnoLTMmEkcTFfdoD3zOhR7ysuwyss
	jYfspxg/fsdg/R/q/SpnSea/jeMsd39AvFAwOybXU1nI3N0KybFLRFf9AHGLx/6+vO+gbzO9IxZ
	+wkm/EVQvuQ4=
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id
 adf61e73a8af0-3c8ba63bac4mr10287770637.72.1785361284533; Wed, 29 Jul 2026
 14:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260713115444.465704-1-nilay@linux.ibm.com> <amjp4ymLa-u9iO_U@kbusch-mbp>
 <CANpmjNN2+m7O206xFDRwyCoihsEr9J972pOFSa5Uc=xx6kkTHw@mail.gmail.com> <amoI6iw_e3DeACKD@kbusch-mbp>
In-Reply-To: <amoI6iw_e3DeACKD@kbusch-mbp>
From: Marco Elver <elver@google.com>
Date: Wed, 29 Jul 2026 23:40:48 +0200
X-Gm-Features: AUfX_mwbC2AyyVtzenBDIPE8-p_CVUJTt483Fc_tu8enPM5lBfCpzK04Jvrpcvw
Message-ID: <CANpmjNNxxS54mgOv29mVPHo51g_VdyH=iVaW8OGCvn6fwZWJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Support Clang context analysis for NVMe host drivers
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	bvanassche@acm.org, gjoyce@linux.ibm.com, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_144125_992293_5E534090 
X-CRM114-Status: GOOD (  14.11  )
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

On Wed, 29 Jul 2026 at 16:06, Keith Busch <kbusch@kernel.org> wrote:
> On Wed, Jul 29, 2026 at 11:03:52AM +0200, Marco Elver wrote:
> > On Tue, 28 Jul 2026 at 19:41, Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > It doesn't look like there's a single source for updating list.h, so any
> > > concern with taking this series through the nvme tree?
> >
> > I think that's fine; conflicts should appear in -next, but I don't see any yet.
>
> Sounds good, applied to nvme-7.3!

I saw this warning:
https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com/
But that'll be fixed by
https://lore.kernel.org/all/20260716002339.11717-3-paulmck@kernel.org/
, which was deliberately split out from this series. Unsure there's a
good way to resolve this, other than waiting for the merge window...

