Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28181C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=; b=UzVjoTa8Crp+ZQnUDXbdMlFzG4
	HE2DbzU3arXtV0Z6aBaK4b74zpKGyODIpxtIU9EZ7dXXsfSeRX3MdcAVdISjnU7ntlDN+otZFfQT3
	xDBUGocNK7UYyHfVbpUVCSvQljSiKsuF/QBar9/7jVftFI6mBT6I5tsbpGojO9oHKZrijS5TE/7QK
	PbW4VzAVjf5tElY4kgQRNJPiQmzMCWtvTKeZm/ZQiswsVlDZs0cQlfGZZnvk+2mXng1wFyQ3akIQB
	KaWS225JqXnbkMuSYfqwpz30SBmKGXQKGP4ICQD1g0YMietlQSqmuqWoXAY7QzyDQzdJ4qVbu/HcW
	40PTNWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYXH-000000061ME-0dMH;
	Mon, 12 Feb 2024 15:47:59 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYXE-000000061Kb-2RIW
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 15:47:58 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-411a54365cbso2828685e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707752875; x=1708357675; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=;
        b=kBOGcXZ4/yIXiNV3hSAU07fqONmJWTEBChNJ99LnHsXUDT2I0VYlfBlAw2bVZcTP8K
         5VufUbnQKoJ0FawPczNGHlZI/+786KVe5c8vON1IBi0ZBraCxxYEk3XKSX1p9fBq3gsU
         AKOp5SNuq7vRaW4acf9QKMykm6ebRRFpq+0IRJ2ih00Nnuq25ZMYlZZzAzhgZlONUYD2
         oP26B+CqsN7P60Vb0KAhRmabEuPOuLR3LD5ykFnk1el31VBEH2O734PLcOO4Kj1gqYsw
         g67NwH4lwyauoESF3Vktko9+mD7izaXqIFsQxgg/YPAjiR8O+hp8pIIJZH9asgZufxsa
         njIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752875; x=1708357675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=;
        b=eEltM6fX7COcMQdIxNvSIUb7nK4APTJ/Cr3ntNCThji+ewA3YFpG+EstCzl77PnrDJ
         MVPnvUTO5hnXiJGSVTAURNsv+WWVTu4a4rYDri6a/aQ4rFLdSiuK0h29e6mX6dwcrIjH
         JgOZO+P348s1u8AQ9ULTCGV21p6bIkucsNehaUSzoP5KXRZ52CYWOle3wmh3KDjCGIlY
         Kn/3fKhegqXToR3BsfMFNEwKJTkmV25moKONYAodwyQPgAVqEtUpnxRAsDSfLljpH7fg
         UN1Jae3jXnQVzamTaoct8IjYxhet0Fp/y2JuOTRut7s9cfbreKUjnYnHMaP8UarjF2lL
         aSZw==
X-Forwarded-Encrypted: i=1; AJvYcCXtVdOlKaOplwrGR00otHeakar+QbOmAFy+hhZHseVouZx3HQCju1QE/dUX9ipgIYLA5stxtpb2IixaDW4lvGv4kPL3F5wFGegZSLHyitE=
X-Gm-Message-State: AOJu0Yyxhpj9pU0YP8n1aoe0tjD7ZGG/c+t/3Uq6OQ5PX4McjGTLz2x3
	BXNEaft1jc294ZtmneBnXi6QBEMGfAJ5Ks0kMN6KSCpRttXhjpu4HcYUp9JEBl4kM5WSRS4Wvhe
	3xI3Crx3uutsfM5lSOjxrPSRcu4wNsJ26B4I=
X-Google-Smtp-Source: AGHT+IEUWTXAM49cUgKgHiedCs5fv11Ii+BR9KeDc28nS1BeCbfCLQgXMXuqH0Z5zD2nBsVFI67ZdYiYvl5aKmlfsaM=
X-Received: by 2002:adf:eac9:0:b0:33b:7947:d22 with SMTP id
 o9-20020adfeac9000000b0033b79470d22mr3100446wrn.57.1707752874459; Mon, 12 Feb
 2024 07:47:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44@epcas5p1.samsung.com>
 <20240201130126.211402-1-joshi.k@samsung.com>
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 12 Feb 2024 21:17:27 +0530
Message-ID: <CA+1E3rJKw67damynQbi0L61+D--oC3BBUF_KSEOKWJpUd7Dhdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Block integrity with flexible-offset PI
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_074756_691200_6CB31B73 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 1, 2024 at 6:39=E2=80=AFPM Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
>
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.

Hi Jens,

This has got the necessary reviews. Can this be picked up?
Or do you see anything missing?

