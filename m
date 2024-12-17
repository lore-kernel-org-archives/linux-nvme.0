Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D33DE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1+lVSzsebFBMkDGJuafpKQ0aBmf15PYA5xQGfL/VsQ=; b=z05ZspEMUDMy3DyWyr+qXFWfqa
	b1Mt16vD/XcFUyPoNFzEt9UUOIkf8S26nmEL0Sldh14FL+JPWpwZWuqRz5aqcpRHathk/Nx0dJkZ9
	41fXalsqBp5s+fpZN2gUGxSMFXDn1uSqEgA1MmgIKXKtRYl+UDTi73lEXqc3EnEM8UN85mpI6tOPa
	5vJ2ZCd0c0mq4RiXlJd0M/LIsjcmCnE2iQT/HJE5abpYLr2gN0ybo/Euy86CogvsEH/vsnWgse0jf
	LYJ8gnA0zlQM7FoSIoQs0i5jH6mSYuD5yBn3aI+9rxntop9edFZ8XAj+EoS0vZqRsdupe6OKA6dVW
	A6jb2xUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNVb1-0000000DEYg-3NEM;
	Tue, 17 Dec 2024 11:18:35 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNVax-0000000DEXx-2WPL
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 11:18:32 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso376730839f.2
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734434309; x=1735039109; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1+lVSzsebFBMkDGJuafpKQ0aBmf15PYA5xQGfL/VsQ=;
        b=0jXPBjfNY7XcSIyTNv5M1SbTYPuVom1mv8lp5XqTFOqRfffPDfidffXQbo7AMkikSc
         7qhIuT4ANBGhgKap1J8WVb6DGy6N8jAZMqdUK+0GPyN8bV82BJv//9GZvWnRVfqp2dd4
         VvYattEBTa2In2Vr/MRXEqD0txmivZSpLLHr8XSraesVOagXzNcjm6jq/QUbtTdemomk
         9/9FFuUjm3+3HOza0pNTk6fAu/LVs1dJrOZ7iOj4x78PB35l6jwvBoY23aN8wQMtsCw8
         29VzFNm36mWzjAXzqlu/zmuWqSPZUexHQR2Bb8uvKRwoSKl+cb3jX3biHsNtOfRA8M8t
         lvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434309; x=1735039109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1+lVSzsebFBMkDGJuafpKQ0aBmf15PYA5xQGfL/VsQ=;
        b=f4wyWX7Ya/ECQjslGUcX0Ux6xDk8XsGc3X0gYXyyhrh3FSbkG/eeHd59aC9FAWdyxU
         U47A8p/QMCaGXUBuYzyT9Y1K5hjLtg8ZsgshJYwYEAeDML7KSXnybb5jlZBvJ6bVFI09
         9/NqoKbTTJR5RPLBoMbvSwainWn5V0/nBfR22FygXUSUPHFoBMX62nBjx/Ip6RMewV6x
         GJf/rz4VKPnODzDF1KtCokpMHSL893jDawReoW57oP8xgIC+RaCP4KcczE72uhQ6vqeU
         07XKRqJS04TPRrzqwVppsAK4WAXeDf9OwwkVB1c9sAC0w1iBSTtb1ha7BTuon6zGlODI
         TurQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR8Apfz0MuAmPEVoO+S46M1finnbVvYToeds6VKLf340JaWMqNKWXLYbm8slu+uDrAaY2mzLBvA6aN@lists.infradead.org
X-Gm-Message-State: AOJu0YwuTpfJ40G9Y/HQnhQL7ZD8aciZh037NUaFUcbHrbkUGtdhAm20
	18pV7lNC/K6/+isdzJkVwU6JS6MPpXAsLCuDlDZJOqBN8SGrx/2eMG1IxxFeoc7RNKRGG5BLKSW
	pZF7gpR/gUea8wcgrUGXv3tQ+bX6gx+oqTUxp
X-Gm-Gg: ASbGncseh/3Z+LZM+z97WDDJHpUrfKtSi6GS9YSXGOAjMoZeVXJrt+cBsPjADRIX/Lc
	AIxAi+emPz8kUL2JNDj9+eu0E9EFx7vUahdqp8rdw3/eVpBHJxWmmKMCNP0OM4330lGs=
X-Google-Smtp-Source: AGHT+IHSgUICatngFDKsLlfJZtWdjdQLFfiFZmgQSZZfOD+iv95mJRnW/sRvGTmpc+dCci8p0d7CInQLAfIlyWHm6uY=
X-Received: by 2002:a05:6602:6417:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-844e8802107mr1704393339f.7.1734434309341; Tue, 17 Dec 2024
 03:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com> <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
 <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
 <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com> <193b55c7998.d66e7e7c1942154.6474606603462169748@collabora.com>
In-Reply-To: <193b55c7998.d66e7e7c1942154.6474606603462169748@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Tue, 17 Dec 2024 12:18:18 +0100
Message-ID: <CAM5zL5pBfQQyRqjd5iV7ouTTii1sCD5fZJWE0zRkGkL18iz+-Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe <axboe@kernel.dk>, hch <hch@lst.de>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_031831_640457_4BCECA6C 
X-CRM114-Status: GOOD (  23.86  )
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

On Wed, Dec 11, 2024 at 11:56=E2=80=AFAM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
>
>
>
>
>
>  ---- On Tue, 10 Dec 2024 21:36:55 +0000  Keith Busch  wrote ---
>  > On Mon, Dec 09, 2024 at 04:33:01PM +0100, Pawe=C5=82 Anikiel wrote:
>  > > On Mon, Dec 9, 2024 at 1:33=E2=80=AFPM Robert Beckett bob.beckett@co=
llabora.com> wrote:
>  > > > [...]
>  > > > I have no further updates on this. I have received no further info=
 from the vendor.
>  > > > I think we can go ahead and use the alignment patch as is. The onl=
y outstanding question was whether it is an
>  > > > implicit last entry per page chain vs simple alisngment requiremen=
t. Either way, using the dmapool
>  > > > alignment fixes both of these potential causes, so we should just =
take it as is.
>  > > > If we ever get any better info and can do a more specific patch in=
 future, we can rework it then.
>  > >
>  > > I think the 512 byte alignment fix is good. I tried coming up with
>  > > something more specific, but everything I could think of was either
>  > > too complicated or artificial.
>  > >
>  > > Regarding the question of whether this is an alignment requirement o=
r
>  > > the last PRP entry issue, I strongly believe it's the latter. I have=
 a
>  > > piece of code that clearly demonstrates the hardware bug when run on=
 a
>  > > device with the nvme bridge. I would really appreciate it if this wa=
s
>  > > verified and my explanation was included in the patch.
>  >
>  > I've pushed this to nvme-6.13 with an updated commit message here:
>  >
>  >   https://git.infradead.org/?p=3Dnvme.git;a=3Dcommitdiff;h=3Dccd84b8d6=
f4a60626dacb933b5d56dadca75c0ca
>
> lgtm. Thanks!

Looks good to me as well. Thank you!

