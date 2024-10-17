Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE461D3C535
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJoUgs76KW8iMEp7X0ayKSzwwzLf9U+J90WGoUiahvQ=; b=q99RpDqr1ofP2opXQmchYGj7BC
	HJfME36Skn3Ra/SIzFBIU237Hq9b+wekYDlcZp+yO8rimR1chlb5Ps/yEJIRUYfRS1sNWxvS+0Zr5
	cxByPZAkPkIrVQXcU4dpB02jF6efc8yO/GUa1+eTax8vFOoRQip4PETu3ZOjgbE1zMTcAtDiolvDT
	JqHR98Qmu97Nlt1Bp/onhzuB1AE/0/zE9Fd765W0PaUF39BiyfTmfR7vrek3nu26rov8J2VLhl+8i
	WykrnVHStIGY2u50brMChduag9rrL3w4pIPR5zWgumENBny99bShOHbPELYAgAl6UN0YmIFAalhjL
	8/clfp7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Xl1-0000000GBXd-1oxB;
	Thu, 17 Oct 2024 21:10:07 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Xky-0000000GBWF-0bVn
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 21:10:05 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-20ca03687fdso59985ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729199403; x=1729804203; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJoUgs76KW8iMEp7X0ayKSzwwzLf9U+J90WGoUiahvQ=;
        b=ItX8deYnOdGK9m3ZbjeBOgZv6QifXIBBPyIeP9k5jKkJOOFEL65F777USARm5nXb2B
         qfWNVUQioq24SeChRXgVxla6roZLiAE7OmPReYjKwti9cnu/O/ouLaGwDMWSKyukajjS
         B2mUa+6i9k3UG+ch7/MvX3XH1HSf9V5eKWHrMu8+nYFToEzDOi0Msl6HE8pafe7oADDW
         sQbp/1Ois5MmQK1WuRZ4Bro6DUClhb8vCeQ+fb/rPRvD/YfLaOOM6CSqnGtvmRqPeAYq
         V4OHNCuKjEG/NajiK219B4HlUmdstdbZ77tW7BSdK1+gE16Jss/WlnkoLDsbBWaKO/l2
         EZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199403; x=1729804203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJoUgs76KW8iMEp7X0ayKSzwwzLf9U+J90WGoUiahvQ=;
        b=r+EVe54Ir6tZUp8h24UwjRhHnJlklHh1wrfcssP0ea7oik5q2UhQN9YzFmkwJrcIxJ
         T6WXYk9OkP+j/XRG9IxcrNPrK6WQqfZskel4zYinzJpc+Xcx8BIhr7jlaMb8SzX51eyg
         vbVofTX952c0wn/wRsoekDYeoQdhZrBQ6lwWqxVrDHDHKmK7Y3Lq7GV158mRsZeUMYLm
         kphR1Ic6NFckGZWDPuntzuEpL6I4AyTsIopoEdvlWSNVXie9lQ5gznk0+ZdJVzo16f+v
         s6FH1154AZzGnzfUZW5NP3rEII4zF2q96SzNlQyE5E1Ns4VKvSgRXF43HEwdovbgBkxq
         odxw==
X-Forwarded-Encrypted: i=1; AJvYcCXitZvSQLzWNkyqzmWbnSrYJxoxGRQB8S4lUwbxytYCTeyoyqsronJhWD0eZyNH2BINXv2XLiAJiX+V@lists.infradead.org
X-Gm-Message-State: AOJu0YwNtcK3ca5YtulIR3S4BtzXCeNNXVSqWWrdx1ys24gm/8NtyqhI
	XYFO28Xscr2cCSCWsBhC81lcpdVcsXitJY3PozWaYn5Y7OIu9HXFHaCKUxB6eiVbziGa7hRQIt/
	nOH+O1Uwxj9sXgXvkorhNM1HwI9QKHEsaxdBe
X-Google-Smtp-Source: AGHT+IGWsubV2/qf0wzewlmnr4QnLiQKPbnulmaHJECIGxuPD15ftHNK5oR18XqOzJA1/SfG+WsDQ/s1fPoDvKQ1egc=
X-Received: by 2002:a17:902:e852:b0:20b:b48d:6ae with SMTP id
 d9443c01a7336-20e5ba1e5d3mr168015ad.13.1729199402682; Thu, 17 Oct 2024
 14:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
In-Reply-To: <CAFivqm+mJ3RTo4ArrkjPJLj8m3vh=czt=sAXZ0iPN7n6=F4z3w@mail.gmail.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Thu, 17 Oct 2024 14:09:51 -0700
Message-ID: <CAL41Mv4=hbLdsc2cVm_Kwsp-vjC_tfXF5St7s7jZGkjr31wHjg@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Prashant Malani <pmalani@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_141004_209338_55A73A57 
X-CRM114-Status: GOOD (  17.56  )
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

On Wed, Oct 16, 2024 at 2:54=E2=80=AFPM Prashant Malani <pmalani@google.com=
> wrote:
>
> Hi Abhishek,
>
>
> On Wed, 16 Oct 2024 at 14:31, Abhishek Bapat <abhishekbapat@google.com> w=
rote:
> >
> > From: Abhishek <abhishekbapat@google.com>
>
> Here and in the S-o-b line: Please use your full legal name.
Acknowledged.

>
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index b68a9e5f1ea3..1af2b2cf1a6c 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -546,6 +546,17 @@ static ssize_t dctype_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(dctype);
> >
> > +static ssize_t max_hw_sectors_kb_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +       struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> > +       u32 max_hw_sectors_kb =3D ctrl->max_hw_sectors >> 1;
>
> In what unit is max_hw_sector stored? If it's "number of sectors", is thi=
s
> conversion to size correct, or should SECTOR_SHIFT be used?

The unit for max_hw_sectors is sectors. Left shifting with SECTOR_SHIFT
will change the unit to bytes, and then we will have to right shift by 10
to convert it into KiB. The net effect is right shifting by one as the valu=
e
of SECTOR_SHIFT is 9. This programming pattern is used within the
Block layer code as well.

