Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E89CC001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgAOi0AulmhX3Bd5KBUZ0xiMSJxcMbsevkpcJpCf8mw=; b=l1g0UR9+jTgnDRHvlh56Zt7L1f
	mBkKoCXaN4C2U4qQhl8YVwE0oLgy6f/1+fBcPPCcG7Za+/DoOAJdU+SNyUXpNpcC1aUrOuh9Yt6VO
	pcO1WV891BQ14EAc5iVErtqnlRTGnBKGcCd6rJ2wpWLt5M7fMziB57EdaHd/4fO+robu6ZgcLq0rj
	vOa2bD/AKYpjnzpuKH0q4Rb1/TLWL1GaQzSauGX3cRuN3LcsaP2+OloVs4IE5KbTYQdhoccYFDVP0
	8HDBH6NIuwoUbA2LhDpz8RdgSfrsuIZ6Wi7TTxSUEaetYLyfDC13WClJFxafv7nyf+Yvyzka/D/q6
	+oXd+X3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWb7-00Gqki-1X;
	Mon, 31 Jul 2023 17:22:21 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWb5-00Gqj8-0t
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 17:22:20 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so506405366b.1
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690824137; x=1691428937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgAOi0AulmhX3Bd5KBUZ0xiMSJxcMbsevkpcJpCf8mw=;
        b=WVEgiFopsCCI5ic/Y88N8Q+wBiKTI0Dd0VkkE4d59d0VKWgFSUOJcwpjHMvOHkQScc
         1idoMtDVsXKF1VlvLQ/pf3ha02lpmkpYV6ySqSCc3Ui7XylDkfpxKeHSN/S40SlbfZvj
         Ok0TlgX5VJ2fxnuMsRcRJ/h/0GC8UToKNzSLAn18xY8M5MhGfSuJeAJRC1fizz2UeV8d
         Kq3r/tFLFKeRMucj4dlAKLGXt6Qdg+NnBL1EFf0nUwExVqqRL2dANx6fB4LgGjWwe0Ub
         3Ucl95goAww4wmfgJ9Zxtap/29csSacR8OQgGk95UQhF985VVuhI+ekDLZTPw9sEDqKb
         zLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824137; x=1691428937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgAOi0AulmhX3Bd5KBUZ0xiMSJxcMbsevkpcJpCf8mw=;
        b=GoQa/SyjHGBzA6Q+Xdtv7SevGMcRRjjz1leFtuF3osVWJJyLeRwByWwReCr76NAr5R
         jX1UJhp3jKpUZB3YexFJykBzgBm7rg6s5KLjF2FRWhSIWQCBSXb1aYCznHmQTFdmBbFh
         QVMpne/qAFUiLb+v75SdT1DWMe81MrDFBH9gTwvxS904Rsta6shkF8Imqo1P/RZbdnMi
         scZKZqopxV2Wkvu5oPRm/mtW202pWPLly9ieEYhgi6KDAIs+qT5eryeeGSiai9ZZ0zTA
         wImyZYV8Lb5Joc9L+/WePO3N7GnaHyhYdEGSHu8qhkJNvQ/kohlcsQG7NCsoOUaHNoxd
         RzEQ==
X-Gm-Message-State: ABy/qLZU9se3az0PD61DyNGF/yMzYglDdkBlp8RdS/r2SDbxwnJvu35v
	o7pzpTCUOVIzk372cMHBudfoMiIdpeJ+l48B8wQ=
X-Google-Smtp-Source: APBJJlFdjkjNgBYK35RYkvKzobwQ+iaRm7mQfahASn9z1AN4541IW4Wld6Tqx4D0vGKQAbAkKxv+7F03rWxWYMMEDVM=
X-Received: by 2002:a17:906:51c7:b0:978:8e8c:1bcb with SMTP id
 v7-20020a17090651c700b009788e8c1bcbmr289377ejk.43.1690824136797; Mon, 31 Jul
 2023 10:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <C401F824-646E-4D1B-8157-370320FCC1FE@hxcore.ol>
In-Reply-To: <C401F824-646E-4D1B-8157-370320FCC1FE@hxcore.ol>
From: irvin cote <irvincoteg@gmail.com>
Date: Mon, 31 Jul 2023 19:22:05 +0200
Message-ID: <CALL+9ejKJ-TT6hJLdejiS9Xk1SHF43-2LgZbOMzExEsqg5ObTA@mail.gmail.com>
Subject: Re: Not possible to have PI at the end of metadata
To: ankit <ankit1455@gmail.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_102219_317941_F9133CB6 
X-CRM114-Status: GOOD (  26.87  )
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

Hi Ankit,
Thank you for your detailed answer!
So if I got it right, the driver requires PI to be the first bytes of metad=
ata
because the block layer's implementation of t10
only expects the user data to be used for CRC generation.
I guess ithis would be pretty costly to change so as to have the nvme
driver comply
with >=3D1.0 spec as as you say SCSI also depends on that t10 implementatio=
n.
Anyway I had just asked that in case this had not been seen.
Thanks again.
Regards,
Irvin Cote

On Mon, 31 Jul 2023 at 18:04, ankit <ankit1455@gmail.com> wrote:
>
> Hi Irvin,
>
>
>
> These are the possible scenarios, how PI is handled.
>
>
>
> If PRACT bit is set, and metadata size =3D=3D pi size, controller inserts=
 / removes PI portion for write / read respectively.
> If PRACT bit is set, and metadata size > pi size
>
> controller overwrites the PI portion of metadata for write before sending=
 it to NVM.
> for read controller does not touch the PI portion of metadata while sendi=
ng it to the host.
>
> If PRACT bit is not set, then it=E2=80=99s the host responsibility to gen=
erate PI for write, and verify for read, irrespective of PI size.
>
>
>
> For PIL (PIP bit of DPS Identify namespace data structure), if its set to=
 0 then protection information should be transferred at the last bytes of m=
etadata. The guard tag (crc) of PI for this case covers data buffer as well=
 as metadata buffer excluding the PI portion.
>
> If PIP bit is not set the guard tag (crc) only covers data buffer.
>
>
>
> Now coming to nvme-driver working.
>
>
>
> if CONFIG_BLK_DEV_INTEGRITY is set, it registers a integrity profile and =
block layer provides the metadata buffer. The existing guard tag (crc) calc=
ulation is done only on the data buffer, it does not cover metadata buffer =
excluding the PI portion (you may refer block/t10-pi.c), hence the restrict=
ion on PI location as first bytes of metadata. I am not sure, how much effo=
rt will be required to modify this (crc on metadata buffer in block/t10-pi.=
c) as this is used by SCSI driver also.
> If CONFIG_BLK_DEV_INTEGRITY is not set and device is formatted with metad=
ata with PI enabled then the scenarios are
>
> metadata size =3D=3D pi_size, nvme driver does not need to do anything.
> Metadata size > pi_size, nvme driver sets the capacity to 0 since there i=
s no metadata buffer, which is expected by controller.
>
>
>
> I don=E2=80=99t know how you are trying to use this, but we now have io_u=
ring passthrough (works with nvme character device), kind of bypasses the b=
lock layer.
>
>
>
> FIO has an ioengine for that, and I am currently working on adding PI sup=
port, and will soon post the patches. It will also cover DIF case (extended=
 LBA), which is not supported with the block device. I hope you will find t=
his interesting for your use-case.
>
>
>
> Regards
>
> Ankit
>
>
>
> Sent from Mail for Windows
>
>

