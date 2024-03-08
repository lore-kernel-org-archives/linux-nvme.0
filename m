Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68361C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=; b=pKOGXx0IyE62ZFazGydlmrkoCE
	P5CskwS3MDFujmVuTSmNVWao1VVparuUwUaRh+iczLrbU3brnLVa+SuDgyRMA9m5S0X8aWeZyNB/8
	7MXAel+qRXWkuaYvDtrR+w/eLnOH58aYLOWqiUzVF+fe3wWCAiJ7u11DSjiZmyKzQ1uwYyHFr5IMv
	qOniCDAuMyFolRcBd9oZdJlg1ZP/ZxR4e7z+rbc6zDKpLzj46s+EJ9Y0boulup9tiBUg8c8S3iWwH
	5Be0iezPyHtMDtSplOJceo/UHxX8q6kWmogRlwfSWbTcvKxQUcjjmGWCvSYSfypLe/dhL/szOPrg3
	Aw4iEhfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridUv-0000000AK9T-0Nh7;
	Fri, 08 Mar 2024 16:55:05 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridUs-0000000AK7H-1EDi
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:55:03 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a450bedffdfso316086066b.3
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916900; x=1710521700; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=;
        b=cCZYwBg6IGQ/CyEpNjOicldg1ahflqIPAb45VbfWJc2ynoDepx8QZzuMJb4pvmCCv3
         Mso1jeFDOkBb0XCdFzBUR4fdzdd09FxQCXL7CoieVIRpgreCuD1b9fajyACSheBFhYrq
         cncFV3QOB4DJnrW63uFKdS5+apgQuF/7P3rRZRzB2umHG1I4m4u0AY4S/k5kgQzKOTi8
         zK9dZGtHm9xKwKSUJS/2fURcT2f5paNaDH8bjAuyTGvNQ5/839a4Y2yxXvltXQmzo4YI
         aOQkM4ets5ruC9wp3pf+JFULo8PRuv+4YSPlLohJhqB/sjR9p/WxCpb88QQPghKPWxIL
         JXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916900; x=1710521700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=;
        b=Os1Vu49BHv9zgZwuc4aoWCcviEm84Mcea/K1Ndmo0W3jX7Q1yzRMDJYX4HuJYP15Gp
         wsLE1DHpbLTf1bHL1rp0bVxspMgDZ/UtVUE+3/gI+jZLY47zrrpAy4awwT82Kc/66Enw
         86VjTyJC4+ePi2AaqKcboR+MAsL7GrrEd0IqqazssNCY5kEo29DghZip5NgvknHUbiFw
         dDk1bsrs8Q4Z3GVb5P38h99AVkT99Diy/ngae5HtxVG6JLNmxH5E3nyMjlb5Lu6TzYjN
         dwHC4yc3X9p/Yoe3qiy7YeEPL2DrGNrBQasNNvilCoBNETAkNZFjvYZE1GKT08wBAxPn
         VGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6YZCbO9r4+2rz7m3pZKvg2SmUzibXEP4h0dbwXVJrUvKlm1OcL4UZMpu9k6rC3VzVj7b3TkIFkmzBPBJqbjajPPwQWQzPodgeAnjmbsI=
X-Gm-Message-State: AOJu0YwLANyK3hEdSkzKeYlNQQLpQdrW50mbYTV+TTqPQdY84N7E5wOR
	PPayzpyKgJn+c4Y1DrTxF9BGW4E0y6lsoctJSS8waLfvpcY7cw7mciPvUObEi7eBVKa0FdBthEA
	eqW6Y3Rei7VbnQvxkkpWno9g06hY=
X-Google-Smtp-Source: AGHT+IHPaEuoZ2wYzkCSZZVGbiK7nhV2ABWMPa7IrCpsZRsuBbuDS2YhIlyjMQRH6lYqnIsQOfQRm9RxZldOFOYTnnc=
X-Received: by 2002:a17:907:cbc3:b0:a45:f1a6:8485 with SMTP id
 vk3-20020a170907cbc300b00a45f1a68485mr1794114ejc.44.1709916900338; Fri, 08
 Mar 2024 08:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
 <20240308163100.GA17078@lst.de> <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
 <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
In-Reply-To: <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:54:51 +0800
Message-ID: <CADtkEecN8nCmNAEm_p972J3mieffqrTk3z5xqC-rbrZakYMtLw@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_085502_377242_7BCE710D 
X-CRM114-Status: GOOD (  11.34  )
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

Keith Busch <kbusch@kernel.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:43:12AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Sorry for delay to reply, I found the patch have applied just about 10
> > minutes ago.
> > According what you plan to do, I think as-is maybe fine, But anyway if
> > need, I will
> > send another patch to cleanup, thanks.
>
> The next pull request will be late next week, so I'll back out the
> commit if you want to submit something else before then. Or you can just
> submit an incremental improvement against the current tree, and that's
> also fine.

Got, I will send V4 according to the suggestion of Christoph, thanks.

