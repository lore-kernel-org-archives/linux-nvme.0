Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49913CDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4FeNWprudZxQlt1QL8KDXCBzcl81LLzp84ZGP+Pd/I=; b=gZ61lTFmzHSXEu2EKFPvnYRz4W
	r7btovN9QR07Lacgk38s8f3MXFDfkiLRAaIg3anABF5oxT6l0Jj4dNE2nps/TKyEO3cWo49WVAJMP
	YtmNfXr8OxPxhqADovejR0uiCHvlSifF7/pw2/L4RPz9I6KALFlto5fSiYuE/lP2n/TNvMOqH9Z+I
	3WfjGwc3NBxG2VXI2m7vLWjgofnLceWYd5FOZx7ADuiSdilSDdwUMcXQJt5pW8L9ptC/DaSoM8Ws1
	EVrnZN+41jcRt6mVOH3VqIPQlWvfNufmET0+s9NskkQzs1toA/3B2cS/C7OABGoZ1EXgAuwBAW1oX
	H3Qk9sTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr7mL-002HmX-03;
	Fri, 13 Oct 2023 02:19:53 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr7mH-002Hlf-1H
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 02:19:50 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso1602339f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Oct 2023 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697163584; x=1697768384; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4FeNWprudZxQlt1QL8KDXCBzcl81LLzp84ZGP+Pd/I=;
        b=HVZ+r8C1TgvKVg7jtSo80HfTPV70JYsphKxhEhcdJqYl63wvSAoy8NiW8ZJw3Ojod7
         Oos32RiDLGiD9iIc18ywCA1JpjjSNTGIEqw4gsPMIf7M2YS0l0JnTM/AyMyzuFub9N0S
         AOD2sVrN9Nk9K+Ydw7bTdwRib7xBFnTQIvFkiL2EGBf69lhyyb9918yqD5TJDWwJjwBx
         WOrLNAcK/XhdHpiuHRVg8bD0TM+0oSMsVlWNIRPx8X58aXpZfD/8eNDShoOFZmG2GoiU
         jyejGfxd9QbBGsOvv/TFazWRjnbhyYb/iAH3uD3TjyA0Z6obVm79lAj5011ePjl+bt0F
         dFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697163584; x=1697768384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4FeNWprudZxQlt1QL8KDXCBzcl81LLzp84ZGP+Pd/I=;
        b=o+bTorZbpX7Dyu7nFbgefgNa5QDICdeJYIMtsVV4jjQJI708FkWwiaqMY93UsB3fI1
         l0d8zJ9aWp4OP9p4HqOzxRFYS+wSDMvAfvlfXhcEdqGNAdFEyUaEHVtLPQawI4YH4Hzo
         mYzacAHrQEzg60TI4FBS3g1YuNJszKBKHP7RA4RQK/R/pEjdAJofpJEoCQUf3aFmcWld
         3cWRMt+TGoEk1NFEhzcWKLTAuZAL50Iq4unuzOyaRV5gnjWir1D6gMlAcZCcb967rsYv
         Q17+/4RKvc49rkACO++QK5mczx4QyebhORMdxoiJjctaQWY30wymMjuajy0Swi4D04rh
         EFyQ==
X-Gm-Message-State: AOJu0YxN1MKTrNNWl8JqU162zlPRSAhshuTFbJ6X+227ixzlYk9au4la
	tanWJpV+yElOSIcDSIbdBtTqbFnqL2g568p21No=
X-Google-Smtp-Source: AGHT+IHbEdeP/FvLtQBUA8coqiiD4ImLqKj5OYOku5Eh7GTT7WjD2zfvAGRtXD7pgWQNFNXZBRhDrLU3s/uj6iW5gk8=
X-Received: by 2002:a05:6000:109:b0:320:9e2:b3a2 with SMTP id
 o9-20020a056000010900b0032009e2b3a2mr22835447wrx.33.1697163583792; Thu, 12
 Oct 2023 19:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 13 Oct 2023 07:49:19 +0530
Message-ID: <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, vincentfu@gmail.com, ankit.kumar@samsung.com, 
	cpgs@samsung.com, stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_191949_460654_EE440C21 
X-CRM114-Status: GOOD (  22.89  )
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

On Thu, Oct 12, 2023 at 9:01=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Oct 12, 2023 at 06:36:52AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> >
> > > I don't think it's reasonable for the driver to decode every passthro=
ugh
> > > command to validate the data lengths, or reject ones that we don't kn=
ow
> > > how to decode. SG_IO doesn't do that either.
> >
> > I don't want that either, but what can we do against a (possibly
> > unprivileged) user corrupting data?
>
> The unpriviledged access is kind of recent. Maybe limit the scope of
> decoding to that usage?

I can send an iteration today that takes this route.
Maybe that can be considered over dropping a useful feature.

> We've always known the interface can be misused to corrupt memory and/or
> data, and it was always user responsibility to use this interface
> reponsibly. We shouldn't disable something people have relied on for
> over 10 years just because someone rediscovered ways to break it.
>
> It's not like this is a "metadata" specific thing either; you can
> provide short user space buffers and corrupt memory with regular admin
> commands, and we have been able to that from day 1. But if you abuse
> this interface, it was always your fault; the kernel never took
> responsibility to sanity check your nvme input, and I think it's a bad
> precedent to start doing it.

In my mind, this was about dealing with the specific case when the
kernel memory is being used for device DMA.
We have just two cases: (i) separate meta buffer, and (ii) bounce
buffer for data (+metadata).
I had not planned sanity checks for user inputs for anything beyond that.
As opposed to being preventive (in all cases), it was about failing
only when we are certain that DMA will take place and it will corrupt
kernel memory.

In the long-term, it may be possible for the path to do away with
memory copies. The checks can disappear with that.

