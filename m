Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B924C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 16:50:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECF761050
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 16:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DECF761050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=riv7MHKUvXPzhSHN9XTuLFI50rg+gHQacbvBmboi+Kw=; b=QvHX0ezK70Z4Kx
	t996IC8C+HNRxPTu+PFxOwSC3Qoj7j5gfuidfCB2CvdjkIZfo7iF62IJsX1y0zg7dUch+Cxkb2hBX
	/ioQ2juUFbIP0kMexcLhvaLwPrAyxHI1l9Kuw3RK02rpHkt0x+iW9FlIZiIXu8WwxpqCeUh4wx7Qd
	Yf8JCkjg9Drjdp02ZR0QFJtDo2+T844z0gVw/4y98znJ2MR3j4PZo2jPCYN9UfHRqp4WjokMGF07X
	U14+u4CPo1EL2m5NBN1yM96TziD8Wdsf+UM07uyAW4zBtFupsr19xaqhFIlkS7YrBSI1bG8M1tkQS
	boM5eXmTWva0a6FAmhJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAb88-00HDtX-VW; Mon, 02 Aug 2021 16:49:32 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAb7p-00HDnu-Up
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 16:49:15 +0000
Received: by mail-vs1-xe35.google.com with SMTP id f27so3600844vsp.8
 for <linux-nvme@lists.infradead.org>; Mon, 02 Aug 2021 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ktgQ/TD5iYkKWCNr/+Fn5xUdVLhZh0Ay0DCCx+V+XZM=;
 b=kMdxMrKsEZT73QQyNLALNfdjbEiyDuLMM4T8iC8DU5I6m6sfyeytmHh3hwEnA5rpdi
 TXPlwdRDMumbgRXFHb1S9U5UKt6m2hgCyLXEoEHxLaLxqP2IPAKQWgStA31eqKXoDrwY
 sT1bnGDgddYi1deDg6XHvRcdKsM54vIN8+ilfNhDi1jvJmdMiAB+Zq8u3cvYE+ShnM0A
 Ig3kO9VUs42NfyDGh0eBX+FyyoytRIKQPsePHohZavVa+AM4GCfigddjiCgSjg6sdJiu
 BO9qdhQS4oGLxoI1Li2HqSHBYaDNcvK1wtDwcogyksZaCzX8pjKvITQrxZZYN2L+5xL6
 x12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ktgQ/TD5iYkKWCNr/+Fn5xUdVLhZh0Ay0DCCx+V+XZM=;
 b=A7HR5gKqt4ydYCkoYzOucEVcI/RkcmP8EW+3VUD3oiVC0EHZqHx5v1Iu4I3VS6rZoi
 ZCGN9RpBVszRHJM16OwWQM6htcPiDeMZDON++lVJK9iSmCnEz+cKkd//CmpvcdqZh/UW
 mrFQ0L2PfrA9zEHgh2mixgQevw3EvBELj4ikHJDMPf7emdXp1uEMR9RpltfnAmnTHNOF
 SkAOXSFjrJK9GaNLDsOWjH41hWpOyqIOLzv2ntTvlkeNxbttt8HES7nC/nzkUi/Dmpdb
 roG/iDUNYclCRmUeoMYwMTZCwzERuvbKsuM+7SBnGWFTB8gokA0PnNPrsEVBGHahgH+j
 p2PA==
X-Gm-Message-State: AOAM531afilwlJmf6pMvtW2WT7C/vKRK3sjZKotRURHGR9h7CDJde3Q1
 icD7bvbgae7zpG5ARhFtbSwQ0LS+YaFOuY0VY+Y=
X-Google-Smtp-Source: ABdhPJxXgFcm0V05KG+PfE6Zf3WwxTEOcCW9uZbcf7VXn6f3uFGSvgd01muc0H1r+dPlQvWRhRE9NoDIb3MfTUsS5hQ=
X-Received: by 2002:a05:6102:3661:: with SMTP id
 bg1mr10624634vsb.50.1627922951961; 
 Mon, 02 Aug 2021 09:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
 <20210802155639.GA2293188@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210802155639.GA2293188@dhcp-10-100-145-180.wdc.com>
From: koos vriezen <koos.vriezen@gmail.com>
Date: Mon, 2 Aug 2021 18:49:00 +0200
Message-ID: <CAGCbPWSK+AnEwM79vAfU7GG1eTjPB5xvDju4DofTf_vqWQBNyg@mail.gmail.com>
Subject: Re: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log
 entries
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_094914_058385_AFCBEB9A 
X-CRM114-Status: GOOD (  17.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Op ma 2 aug. 2021 om 17:56 schreef Keith Busch <kbusch@kernel.org>:
>
> On Sat, Jul 31, 2021 at 10:32:20AM +0200, koos vriezen wrote:
> > Hi,
> >
> > On my XPS 13 9380 I get local mails with content
> >
> > "
> > The following warning/error was logged by the smartd daemon:
> >
> > Device: /dev/nvme0, number of Error Log entries increased from 28 to 29
> >
> > Device info:
> > PM981 NVMe Samsung 512GB, S/N:S3ZHNF0KB11472, FW:EXA74D1Q, 512 GB
> > "
> >
> > after boot and increasing numbers after resume. Git bisect report:
>
> The controller shouldn't log an error when we request an optional
> identification. We don't have another way to determine if the controller
> supports this other than to request it. I think this should be reported
> to the device vendor for a firmware fix.

Thanks for your answer. I have the latest Dell bios installed (which
applied quite some firmware updates as well during install -- not that
I remembered which one exactly) and officially this device is too old
for support from Dell.

I didn't see any recents hits with google for this error, so maybe
it's just this device. I guess I can add a `return 0;`  just before
the `nvme_ctrl_limited_cns` call in `nvme_init_non_mdts_limits`
locally for now.

Cheers,
Koos Vriezen

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
