Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70942C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E3oXap9H1DL2KXqdmeRtA1BkafvfC2bDwZ8dHbvZ1JE=; b=o4kOnq0DcPCm3xczPBCX60AkXr
	b4UlmxVRkKl0YEBtAWIFbLuT7mwD4ie2NGm96ew1byHZ7CQ2zXSyj1j4sKUXEzGZfI9nJ++0g9nnH
	dFobXvAweSGf43iHI8vm0Y0hEXkWdoMYTCs4LJiHT4oNyXNNEw0Ji6Si0OIPjVMJuwHQC9v2wfZIa
	MmoI4Yx+jfCbEOflXeryTUyMAjb1AT06uusowOhAzTpwgD8I66cfHsIa+xiOLS6ayhq2eSfkYGIk7
	V3JTA89E7LD1vmyhfVF7y8hOID/O6gmUsUUMK30Jiyofvxt1vIL+fllc47yEbg1ZeFOoKZ6C3OeOJ
	IdQZCwRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r871Q-006XOs-2X;
	Tue, 28 Nov 2023 22:57:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r871N-006XON-2S
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 22:57:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701212253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3oXap9H1DL2KXqdmeRtA1BkafvfC2bDwZ8dHbvZ1JE=;
	b=BpGY6ekWw/cpSx/7aaT9MWLPWHZsLF/b9hdUHCm0CKYuq+Il+0Azx2l9FLI/nJLx3Zen4Z
	5xjyxRRescTwn+vLGZYO1vASyZq1MtwhMiUB7vl7SKCpILt2sA1ubuN9Tl8lZLR56tBjAx
	btGhyq1LtxZxBmK83KJKQbzerX6K/N4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-WKx1iQaPOfi9NHvWEEt1ZQ-1; Tue, 28 Nov 2023 17:57:32 -0500
X-MC-Unique: WKx1iQaPOfi9NHvWEEt1ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083717431eso35278065e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212251; x=1701817051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3oXap9H1DL2KXqdmeRtA1BkafvfC2bDwZ8dHbvZ1JE=;
        b=tiUx7g1Sz1AAk22ZzHpk/XQnKTR+uRFVXljeG1KH0ph1CW73dqwFCkEi/r0/IGp+cu
         hvnrnd1ZYv6040oyE4Z3zQ0CLwnzrRYyoRT8xAMhr07xXC3T3rDV9abHmtsU9UuOWzBJ
         w9edYhBYpgleXzBuP84IHaumA+WX//0553AeW+QjDcJMJOjxD7IBGaackuEA6EbHh3dp
         WKtZE/J+Svl652xJ6JVVMC6PJRnUHelYFFV+kUaHqROHWtHHnpMxvTwCpIWVre3aApI5
         DStI9yPLYieIDE/iqKWoj4jx/zJovxAzqojHek9YckXo8pK+GT4M0WGsIpChViy1f0zU
         kHaQ==
X-Gm-Message-State: AOJu0Yx/+1vUVJ7xGx7mCy8uVftbgJRSA46/C27VoyF/3UmvH0YDGP9a
	W/F5HPSwH2xiKlLpULqMKTMK325EOtPh4IvMPP4V7MJmePW0/VYUPLSAFhq1z34EszSsCCiHjzJ
	HoPGxWELdWt/X8U6DQEiOlkzuBzX0sZ+zhaDNy3/I4++YpLklvbk=
X-Received: by 2002:a05:600c:4e94:b0:40b:4c36:f80 with SMTP id f20-20020a05600c4e9400b0040b4c360f80mr2458013wmq.32.1701212251088;
        Tue, 28 Nov 2023 14:57:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrlXAcfpMY96hkscs+7OE2DInsvAEAm9VPHqq6tebI2n6eTl/Uiw7oiqgUn9QALMRz2Ms17VIRexNfm3Itbp4=
X-Received: by 2002:a05:600c:4e94:b0:40b:4c36:f80 with SMTP id
 f20-20020a05600c4e9400b0040b4c360f80mr2458006wmq.32.1701212250749; Tue, 28
 Nov 2023 14:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20231127205657.25950-1-emilne@redhat.com> <ZWUSILjL_6fJXPgk@kbusch-mbp.dhcp.thefacebook.com>
 <CAGtn9r=KZOmxJLGNp1bu_2HRF_nuGUmJanubNVA=Je=v19Uh=Q@mail.gmail.com> <ZWYkG3qh3N-HT7hx@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZWYkG3qh3N-HT7hx@kbusch-mbp.dhcp.thefacebook.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 28 Nov 2023 17:57:18 -0500
Message-ID: <CAGtn9rnpapdZRiTjq4tuUVfbN9z6Vhk3UHqC7s2-uhJbAdhZ7w@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: check for valid data from from
 nvme_identify_ns() before using it
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_145737_893404_CE2AC2CB 
X-CRM114-Status: GOOD (  20.31  )
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

Sure, the kernel should not crash regardless of what any device reports,
especially an external one.

The _identify_ns() divide by zero happened because the NVMe spec
says a page of zeroes can be returned if a namespace isn't configured.
I'm not really sure why the spec didn't require a nonzero status code.

-Ewan

On Tue, Nov 28, 2023 at 12:32=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Tue, Nov 28, 2023 at 11:10:29AM -0500, Ewan Milne wrote:
> > > Interestingly enough, I think this is the same as what was recently
> > > reported here:
> > >
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=3D218186
> > >
> >
> > Yes, from the stack trace and BZ comments it looks like it.
>
> Slightly related, there's nothing stopping a device from reporting a
> bogus LBA shift value. We're only checking for "too big", but neglect to
> check for too small, and may similiarly shift off to a division by 0. We
> might need a check like this too:
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a55c2a774b9c4..8bf78f876f7ac 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1903,7 +1903,7 @@ static void nvme_update_disk_info(struct gendisk *d=
isk,
>          * The block layer can't support LBA sizes larger than the page s=
ize
>          * yet, so catch this early and don't allow block I/O.
>          */
> -       if (ns->lba_shift > PAGE_SHIFT) {
> +       if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
>                 capacity =3D 0;
>                 bs =3D (1 << 9);
>         }
> --
>


