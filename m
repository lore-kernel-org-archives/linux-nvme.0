Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D03DD2E021
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=; b=tSNESFaSDw96guzJ2cXP3M8Xvl
	HbN4WBo7i0peGsHDxr/l0JsrbJEsAmVpl5J+UPDfv7sXkBl0A2Xa0SqtgzTG3FCyEpKog+3rpjr+h
	PqOGH3QVJo2ubDRFO03Gy69bVOyMq7KgKxY1yRiKjAMx0+iMsHGkVtXf0hjg6HoMLKqlY4CSkmWGE
	wwpMPK565EW3M9KOZKa/pO0VGFQspJmzF9aLKPP0anQBboxWh6UULS80SHMq+enc2CgXmtG8UG6zL
	Xx4rGHM4YcPFdkQ53LWEchh/ZwXbS4OESGgNyh50hiqnrfq4STmAhO1rJGjLxOfa1IIwA+74f3n8K
	I01XohKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQW2-00000009BCx-2h6f;
	Fri, 05 Dec 2025 07:46:10 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQVw-00000009BCF-0KZd
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 07:46:09 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4edb7c8232aso22878851cf.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 23:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764920762; x=1765525562; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=nqKOkFRCWlH8eku3AFX9ufrWd9nHpOAy1FBlLt/Ed4L7sm2Z4A2OB8KrJc82Uhdg0L
         YMbf9JhH1k1AEdXbJVgvulZgoDxeBULPT+uEjFDZXlWZbwFPXMdox+s8lbvom+c3LxD8
         cHZRwAJ0WcwRPrOpUh8dVbjh6cQW7riZvPRsYQSuex23DoMkLLVDWU3kGXPVPA7+j5mg
         f8U9UrI6Ww3Uj2kYVwinrxptQEj/bUqWudMC57ymEIQFimCkLZlahCWKDG8wQw6fYWQs
         FKz+0WIviCbqGL2UvtG+xC7AgCR6YSYx0J+uBgMv19Uzl40ta19R3MjhNeYhqTEMYPVb
         kKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764920762; x=1765525562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=eh09S9V02jivb60XvGFuaURHYOEYBp7sSnV1noDEvw8boR8NVK6h1jyu1hg9ZNmLIb
         +uuitn20dVFBFJOxM89qH3GkkJBaYnLOuEnATvy6+7L7GkfFPV0kv31k+SBs04bji+MH
         nq0l15N3oFeVUyqO7WCv0IKXx/MvDwKmjAxqf7WLoevXjjB7BRZEIivmnMgy5pHdKZoQ
         G5cIFmWtMD1L2bT753MU6/i+fVybR4Vn9hqFBsZdy+FsK/UlRgNf36HA/bcCf9uUT5dm
         IS8aLKiBxQVwaBZ9urRXzzak2vY8VuncuNK+93tkBInbe50YjD2Hdx04yekIRYR54l3j
         SC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2UIQtvfqzlsGulwtArdkojkAvli5Il69AHvNO/dl7OraRr2KiugvGZGU/6s+gi1QVDJeBA7kLJSKM@lists.infradead.org
X-Gm-Message-State: AOJu0YyC8YAMdO6BiCWQdL8XMm0MWQbWqX9eLbYIdSRgoxG0Vn9+h/Uy
	ItlUN35odNpLL4sSs4enpfNSFYUWw1rWKQ8y1xYBwRT9PWtQsY0siTZv8ifVGHphUm8Ruti6hMI
	rkojdTG81xmLvUvad1QoODv6M7Eumvoo=
X-Gm-Gg: ASbGnctLP8GRc4kibbnp/mmzPvm/wGPG7eIOM6Lpr1Uzo3NetNyM4JEm1FxKASwIgDk
	gL0OXX4jQJbe846vnk9L1MCqTGCxc88/wHnDrYY1rUzOE4DoVyy9uusA4jI9W/Km6GQ+wKbXCne
	yraxNlWRdOXBgEtOhvWBfJnS8ZVe5ifPfNsUC+LGS/0hixZxPWHNF2B3czvDYgVb97qFH1E3KSn
	YV7dUfA0qqY0FuM2dbH6J2x8xmEpNOYYqzi9emorn0+YgEbl6U7P+CQGSutoQQUan1R9J1PnfsD
	AIUBug==
X-Google-Smtp-Source: AGHT+IGno4YCEk34HtoQAUN6GrFl01k867Kp7tydcNcb8xmuE9aFUTESOSk0G3T3M/y8W6zfCnRmuyMISYmpdGJqEvo=
X-Received: by 2002:a05:622a:5c6:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-4f01770bf40mr116570781cf.80.1764920762038; Thu, 04 Dec 2025
 23:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com> <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
In-Reply-To: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 5 Dec 2025 15:45:25 +0800
X-Gm-Features: AWmQ_bnqjBxuauDVJJL96EAzZiNCKi7bmfbcq5aA841m6f5U8UUuamAPefRv5L8
Message-ID: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_234604_177037_86F58214 
X-CRM114-Status: GOOD (  14.29  )
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

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gma=
il.com> wrote:
> > > This one should also be dropped because the 'prev' and 'new' are in
> > > the wrong order.
> >
> > Ouch. Thanks for pointing this out.
>
> Linus has merged the fix for this bug now, so this patch can be
> updated / re-added.
>

Thank you for the update. I'm not clear on what specifically has been
merged or how to verify it.
Could you please clarify which fix was merged, and if I should now
resubmit the cleanup patches?

Thanks,
Shida

> Thanks,
> Andreas
>

