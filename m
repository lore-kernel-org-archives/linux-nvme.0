Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AE5C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 21:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXrn0Lr79Xx4WaPYsj/Z1OBljINiFe8PiX2x+MR8c2s=; b=p+jLnuUzp5WJIjFWxlffCFgRSD
	xkz4pe3uXGZwy9Y5n/ZvdCZryMS1vms0Elj9T952BcPyxoiXhYuIYFTz83RE/RpQ0IRJIPKC7igBv
	SL3lGLh6vnCMAG7mfR4D+3Qz8OgMRao0GeYEW1GXCrSdxWEtHJQAIxoljGxbe7ijU9kq/FLp6xpuG
	9l4qiVojuOShmK1VGGIGhXAy9t+9GLrmj3QRmgMIID1tGRvc899rO58BW5nCuFEN+CRPveA7bPzHK
	LpbgfMlmKJ8k5q1b5P5+3mWwwlog+SvWDRZ2uouw6H7/rEx2ffgbGwLRaFW5Ze95xpuejS9xNPM/m
	IxnyFapQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXRIO-0000000CbIM-0e0X;
	Thu, 03 Jul 2025 21:16:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXO2a-0000000CBNp-3ThJ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 17:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751564886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXrn0Lr79Xx4WaPYsj/Z1OBljINiFe8PiX2x+MR8c2s=;
	b=ZuuwZ2Y0D1eDZAcJ6LZqrsHhLNu0Z0dorhMaGDvqBPHFw6xEVLz7x+SZuIkD39XAiEAb8a
	OvqMOHCMdKVZyUBXQhWd1vIYRmP2u7wCwPsRoMmsWucbUjXx3hnX2J0KWAVmveRg7XEhGS
	XiwximJhUhqXsFtsZBU4WiSfY5K7Lfw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-zG9Atc2iMamdZ-04cZ9s-A-1; Thu, 03 Jul 2025 13:48:05 -0400
X-MC-Unique: zG9Atc2iMamdZ-04cZ9s-A-1
X-Mimecast-MFC-AGG-ID: zG9Atc2iMamdZ-04cZ9s-A_1751564883
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32b378371b1so654671fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 03 Jul 2025 10:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751564883; x=1752169683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXrn0Lr79Xx4WaPYsj/Z1OBljINiFe8PiX2x+MR8c2s=;
        b=IYT0t0VUpGfUXYfigGPH3av2pWxzZTd6Swo29O5+Vasj2q6KlHyi39ry/J6BlQHcvO
         qSNik5pxLP3OFHDn39JU2YT3mdYYsq/eAkzzPRtqVlOPIzMENpcbVmoXhab8wI4hWxoB
         YtarS/+obdzmLjI+4Joyv5sg113lK1g8vRaA0GZ7EDGbwiy5VWkXVIEUyjq3tgyD/46S
         5uVn+Lb0V1VIQ/ALc+a59zYSik1JAWclTVMvlGqDhRY6JT44Jd6nixrl2UuLJJGA9isj
         1PDk4DpDH6IYMHx7DF1Z4im3+dv850r/urDE9yPQWVBbNceXE+jOz74bVEOj7VsGESr7
         6MEg==
X-Forwarded-Encrypted: i=1; AJvYcCWEHEZ4lh+PQ4vzPaT3Gtfj6exowmzLDA8743TVXSsahzCfxzlWfax12XcFMEIgeShVw5unaasz/JvA@lists.infradead.org
X-Gm-Message-State: AOJu0Yzn/EYpdy7IYEjmbFmENyWuTN5qfiju7SNgmtCmzaVCX9Uc24K2
	hfB1uH3YxsvExkz2onjXSkDJbTDUmSw1uFXqsEPa+SiS2Jt1gHyzBAGng3FHuOVi7VtY7R5qpap
	+9Sykk78acIwFC3nZQIuZRA1/JW5bUKG0t+MYZ268E1KcWoYBdJYXLyN8waepPOoAVb5T93V97t
	e6JXmz4c72CgVj+HzwIAY+nECzmPSE/Ch3s8cy3RdtxQM=
X-Gm-Gg: ASbGncvcS6w+PjZyHKulZgu78iaN2JoiMOaIUnHzyutTGcHTCmEkjoU/cbWdc6cPdhU
	3b3X/KFSe+Bir0y4293sXa27zbE66kqlISE73btLLWv2M9CDSyBJQhdzgKmrXELzWQ1DNlhaMun
	pFDZx2
X-Received: by 2002:a2e:7214:0:b0:32b:585e:30bd with SMTP id 38308e7fff4ca-32e0006aba2mr24225021fa.21.1751564883173;
        Thu, 03 Jul 2025 10:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvVSz8tzXtJu5+PFQ/r3o6wJcqxkoU3DjA9mvAGAU2k/HNhldxr1s2Gm5hXdkuGVL9X/RNdgi1jJHXUcHjgw=
X-Received: by 2002:a2e:7214:0:b0:32b:585e:30bd with SMTP id
 38308e7fff4ca-32e0006aba2mr24224941fa.21.1751564882741; Thu, 03 Jul 2025
 10:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
 <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com> <20250703080359.GA365@lst.de>
In-Reply-To: <20250703080359.GA365@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 4 Jul 2025 01:47:50 +0800
X-Gm-Features: Ac12FXwYGPoZMFiijA-eK4zGwljz6KFT2iLdmeRncVvmIltAxq0IUgIFYHpG788
Message-ID: <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added (0/7).
To: Christoph Hellwig <hch@lst.de>, alan.adamson@oracle.com
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, John Garry <john.g.garry@oracle.com>, 
	Ming Lei <ming.lei@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vWWyHHTmz4qeMrReINwhd7MJF8AaNS98dmtSZJxyLVA_1751564883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_104808_940283_9E1DD73E 
X-CRM114-Status: GOOD (  12.73  )
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

On Thu, Jul 3, 2025 at 4:04=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> > Looks like the device isn't reporting AWUPF after the format/reset.
>
> The other option would be that the format changed the value.
>
> The mess NVMe creasted with the totally un-thought out atomics is
> beyond belive :(
>
> I wonder if we should just back out the whole thing and wait for the
> working group to come up with something that can actually safely work.
>

Yeah, the format operation will change the awupf value.
Here is the reset operation pass[1] and fail[2] log
[1]
+ nvme format -l0 -f /dev/nvme3n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 7
+ grep nawupf
+ nvme id-ns /dev/nvme3n1
nawupf  : 7
+ nvme format -l1 -f /dev/nvme3n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 0
+ nvme id-ns /dev/nvme3n1
+ grep nawupf
nawupf  : 0
+ nvme reset /dev/nvme3
+ nvme id-ctrl /dev/nvme3
+ grep awupf
awupf     : 0

[2]
+ nvme format -l0 -f /dev/nvme5n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme5
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme5n1
+ grep nawupf
nawupf  : 7
+ nvme format -l1 -f /dev/nvme5n1
Success formatting namespace:1
+ nvme id-ctrl /dev/nvme5
+ grep awupf
awupf     : 0
+ nvme id-ns /dev/nvme5n1
+ grep nawupf
nawupf  : 0
+ nvme reset /dev/nvme5
Reset: Network dropped connection on reset
# dmesg | tail -5
[  597.973393] nvme nvme5: rescanning namespaces.
[  598.292285] nvme nvme5: rescanning namespaces.
[  598.584937] nvme nvme5: resetting controller
[  598.626440] nvme nvme5: inconsistent AWUPF, controller not added (0/7).
[  598.633064] nvme nvme5: Disabling device after reset failure: -22


--=20
Best Regards,
  Yi Zhang


