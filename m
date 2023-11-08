Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B16C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPD8reSRo720kOSJhc2V8W23n1UilQcGQX81M+3pXQQ=; b=jtqbsAOpyIqb7JYMfcmYdZXmci
	RLmHUKSIgPmT+beIaXFrj3p1YG0tDj5ihqC7k5dAJE2dNXTSeyhpRK/5A+fHHEP6EyrwehK5dwgxR
	HpDmmtW5KZs9E4ROMw6Q+q+8CniT/Zm299O9KtW6R/cRaTB82+S8P5gOSSy4qZsRAa3bYv6cxlKXC
	H02Hgt77eo9fvJBOAGlXAtDeo57JP7o3Fj7aXCJMPC+fndmEqfxHy3Zs0sjw2F7cSJ7ZqABsjjjkb
	SBg8pBAJTRE/nlNZzR5Ujkm91P/6OP2aAokm9cMleP9M7miUle0d+txd/Ako8IecEq5MR+drLNR9V
	5WoT7SDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0nRc-004Vms-09;
	Wed, 08 Nov 2023 18:38:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0nRZ-004Vlu-2Q
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 18:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699468704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPD8reSRo720kOSJhc2V8W23n1UilQcGQX81M+3pXQQ=;
	b=W86RRvjimYNxJNUaZRRtIgUA1lDmnomFNCpPG/okae5zIkCqIqwswYZvX7zJhZTLIKVEUP
	N2zNtwhiSATX9InXy6kguLJ/h8vIxz6hfiKM9Jk9ImUHhrZqLfl6eu8Z88vQJqvsu4ohEl
	LrgwpOJj9BVTTVag+IVpyDdQoa9vT4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532--TiaHM_VO9Wp7WZDJaV4dg-1; Wed, 08 Nov 2023 13:38:23 -0500
X-MC-Unique: -TiaHM_VO9Wp7WZDJaV4dg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4094d1e52daso47665265e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Nov 2023 10:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468702; x=1700073502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPD8reSRo720kOSJhc2V8W23n1UilQcGQX81M+3pXQQ=;
        b=mAWErQm17dRbL6xh9FPfdzbMM+gaup9RqW2mrhiajlIPLAzOssst256d+fduua5wPm
         mOlKmfW8NIrSjqb73M9JGt4gDPBpbb1F9mfg04gRnuxg41AGh5coUDnHeuJTgm0/i4yU
         FPhuAUia09whsMzjO0G7Xmt+9vvYuPO+Oi9Kz/hhiaiAjyQjJoPRN6jt08i63zxxemK3
         s1YXpRFXxP1VSzsidln+n2LsJI4htFOIA8toKWJu4mQYN3IkaiRWH0NLBdyotcnEZQFi
         BdSkuQI7xqCoxtZrJ8ziDDSRMjirQEH8NlODx/mzaaYeqbE/e/GGVvywaA0NV7Z78ms8
         X6tw==
X-Gm-Message-State: AOJu0YwzZJTnxBteeaY7Uw7uI0SMeZvsnmp1+2KnOWfuvccLCPJ8BC8j
	7CBuS1QEjxIs7i+uVMD8vc6yvVC1MaOd6GAD0tYmjdfYPBlTBQ+i8W5dpCrXb4ukmN6jZZsTcBp
	5sAydpdtlGRaETvJPr3GQ2jUVgUAfvSKvpJduVOUPFtU=
X-Received: by 2002:a5d:5281:0:b0:32f:a5af:99ca with SMTP id c1-20020a5d5281000000b0032fa5af99camr2126604wrv.69.1699468702116;
        Wed, 08 Nov 2023 10:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg6XA7JeKJID/+4KMs63/iAqKLDc12G9RNhMgSKyaGnqLMXjiPx5ZZldWrjfYqqE+u5wyWTZDbAIDjxJxZ2WM=
X-Received: by 2002:a5d:5281:0:b0:32f:a5af:99ca with SMTP id
 c1-20020a5d5281000000b0032fa5af99camr2126595wrv.69.1699468701826; Wed, 08 Nov
 2023 10:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20231107212331.9413-1-emilne@redhat.com> <20231107212331.9413-2-emilne@redhat.com>
 <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com> <ZUtCPeDYRaGszXnE@infradead.org>
In-Reply-To: <ZUtCPeDYRaGszXnE@infradead.org>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 8 Nov 2023 13:38:10 -0500
Message-ID: <CAGtn9rmkEda9yyaG6Bar6O1QHE5g_Gsw0yewiJNEVDihS8VHXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	tsong@purestorage.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_103825_858604_E5E0761F 
X-CRM114-Status: GOOD (  20.19  )
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

I did attempt an implementation with percpu counters but I did not
see enough of a benefit.  I also tried updating the counters for only
a fraction of the requests, what I observed is that it does not work
nearly as well as counting them all, unfortunately.

-Ewan

On Wed, Nov 8, 2023 at 3:10=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Nov 07, 2023 at 02:53:48PM -0700, Keith Busch wrote:
> > On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> > > The atomic updates of ctrl->nr_active are unnecessary when using
> > > numa or round-robin iopolicy, so avoid that cost on a per-request bas=
is.
> > > Clear nr_active when changing iopolicy and do not decrement below zer=
o.
> > > (This handles changing the iopolicy while requests are in flight.)
> >
> > Oh, here's restricting it to that policy. Any reason not to fold it in
> > the first one?
>
> It should, and I agree with all the other comments.
>
> But I'm also pretty deeply unhappy with the whole thing.  This is a
> controller-wise atomic taken for every I/O.  How slow are the subsystems
> people want to use it for?  And is a global max active really the
> right measure, or would e a per-cpu, or at least batched per-cpu as
> used by the percpu counters by a better option?
>
>


