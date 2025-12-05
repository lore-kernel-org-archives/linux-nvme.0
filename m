Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F59DD2F7C3
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=; b=2nXFdfaOxBrDj6HRr2/IYgkvlB
	MZ9xvZzON55vSSdVAfQ2vmG9XAuTW0xwpZWPImWNm9KXs8NF/IxUakl7k2VrxyL2IbzMEn0hngtex
	LpeFyIhKuYhdvPCJ6G/EdKPejrF9vdwN+AfDRlU6v6t5GMCTKIfMLXc79PG+PSFVctrm59gjPg3WW
	7C8fzUSH3j7CUn+VyT1uZRtseEch0CsRccp13AA3HmTTz3FTOHJAyr6ABJdRQlH1i/c07Kl0SBtJS
	dVsLJdKfvgKw4+SLJZpVPhfIgotkAV4IaL5R6DN8BUYDCo3U/ButAIOqk/QNICAJ9ak+7ap2Eu2XC
	i/x9YJ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRbZ-00000009FNb-47bh;
	Fri, 05 Dec 2025 08:55:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRbX-00000009FMx-30hw
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 08:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764924954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
	b=cU1RodDPJ9JgGz8qtXc7VF3MvDevWO/vhXymqmp8mXJ/UWHccgWSJW/GNykwibIPT2Rb4B
	aheKbDeHd4cad+otO8mOxBjF0bMTVdafR+OsQ9GBiYXTz6msMCDLS/HBZd2L4TEwWFPQzi
	JriTQFJHLH1kHw8/scLqZWaW/JJbpfg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-gGWKovzpPMO7GKM0v78-RQ-1; Fri, 05 Dec 2025 03:55:52 -0500
X-MC-Unique: gGWKovzpPMO7GKM0v78-RQ-1
X-Mimecast-MFC-AGG-ID: gGWKovzpPMO7GKM0v78-RQ_1764924951
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e08ae023cso3276765d50.1
        for <linux-nvme@lists.infradead.org>; Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924951; x=1765529751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kI/BmZknfJEnMAoux6UNqNWZZavATt2Ci9CEQ2NFztc=;
        b=LM2xQl3O8qMm6OWKWa9rrnFE5AxepUzVw7om6pPY7MguPJbye+Q2ExFkEv5unc3M1J
         4XLo3CinX2wa05kImPJYvY0rNsruu4/o5bZFZnUOhuFLY0wg6HR5Xg3r62E3/m3qlGbK
         AABE4ADvzTahWQJv8Dyqg9QKOwW05ug8+bR4hQAk4U0+gibaIYHo0En+PM0QJk8sipMS
         /nP64dhu7ZJkuLRGOfG/+La+vJpW5tVG224aZrJ61V4o9tOtuu0a6faPch6PMy0ZnQZP
         OJzejDw6i9HaaxMtXwwWZC0LMl4OM/gl/Kb6XysCtThX2oIHnjFuSs752Zsvw/WrNJqO
         9XqA==
X-Forwarded-Encrypted: i=1; AJvYcCVIZyAqwqW290+NZ9eplk4ShxPAga5O5rQlq8zpetIC4KTeilrUME2I+ZeSAAcs7GDbVhTnQXco9Q0x@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5pLE2w7a5xH2n3F29a/bObMKV2IHYSmLK+41O+qNRK0oSGigJ
	w3LEBJpvr9vqS7quvKdoDs4yG3qwVVnqV0e7ndLDjv8lN/JW2fUKqdzKPPLJoUNS11VXqjNffCe
	LEoLyaFODpTh9tjq15cQI12QCuqncmfqgEpK/ZiJI4e7g2hAVWkmrJdzwIliFQEOYLIY3GdNCL/
	kjDOWbEMRyjscFE2xbvPVwicf4sCyxOsJ5CugAoo1dMjY=
X-Gm-Gg: ASbGnctc58A9ffQbbKULyY9OyLeQr7ysMTCtst4aqhOj72823Q/3naeLR6xZ8N/pWFj
	kzP36eeA9K1NUQsPjuGEUiAf8EIQFL8dTMJWrA0r98ke30X5a3o8J0IumVNHQVQhejsqwtHBcCZ
	3mpzi8fl/hzdM69JMIqoY8xjFr82ltemajMeKsgSah0UvP3SX+wtqFmH5TloFmT+In
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id 956f58d0204a3-6443d6e683bmr5035629d50.9.1764924951057;
        Fri, 05 Dec 2025 00:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH06t5ScTL3/41cXQ9/KNdNBUKke6bRZRDIIsDOJI/s90MmtU+OELXMsXOy8CKQ41Y5BIrK12B8cMtyqGUq3aU=
X-Received: by 2002:a05:690e:11c7:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6443d6e683bmr5035612d50.9.1764924950709; Fri, 05 Dec 2025
 00:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com> <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
In-Reply-To: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 5 Dec 2025 09:55:39 +0100
X-Gm-Features: AWmQ_bn5nYIfNoOVXdPvu9TIQvwvBK4TRvGDwrtrakvgOSxNJSsbjWkIZFSXMho
Message-ID: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oOOmJZ_mtsvui3BMraoRaUvLFQ97Z433OpSDm-a1JuI_1764924951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_005555_935401_FCDEBDB1 
X-CRM114-Status: GOOD (  18.01  )
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

On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.co=
m> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=
=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@g=
mail.com> wrote:
> > > > This one should also be dropped because the 'prev' and 'new' are in
> > > > the wrong order.
> > >
> > > Ouch. Thanks for pointing this out.
> >
> > Linus has merged the fix for this bug now, so this patch can be
> > updated / re-added.
> >
>
> Thank you for the update. I'm not clear on what specifically has been
> merged or how to verify it.
> Could you please clarify which fix was merged,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a157e0a0aa5
"gfs2: Fix use of bio_chain"


> and if I should now resubmit the cleanup patches?
>
> Thanks,
> Shida
>
> > Thanks,
> > Andreas
> >
>


