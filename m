Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD82D116E2
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 01:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=; b=exNIf/wrHIGHBp2/glkneeTz5/
	eKsdw8F2Xcigqw8BdAp7CWfwdNuEIIlAm1UVyuksdVZLdswx5NamdfuwvKxARzI1IPgd7ox7OB3xn
	5JwIYMqCZ9/r7gGAimaPa6sC9GufR/PDpZ5i0Xi9qjoizbaI70f8eUkd8BvQW+OEQRtcuc2cx/MbC
	Aec4pz1lZOJlqQnHu836foFjEgvZEA/dnuD5GfmozXqZtKGn61kMTiElGhSRO4ZFGzWAyGsrGah+A
	XPRcRyysb9kqYlpjGG8+LgssPdcnbHvlINuSPhtGyUbi+YIbcfOzta8R/VLCxtFWOYAGSUeNzNn1S
	MZaLVwcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPA6s-000000019Q0-1LKY;
	Sat, 29 Nov 2025 01:50:50 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPA6p-000000019Pb-2cEM
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 01:50:48 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4eda057f3c0so16854571cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764381046; x=1764985846; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=SCxzh4x/hhsphSFNO+GckeYX1HCBLBLtMbbwpeSp4QFvthT3HfF5h2tQn3lp2/Nmq9
         F9qvp20xiMih8hnlwzJGq+/jE3CvW/qdo06iIa6q4Yw3UhuRrlmR/TuT+iLtDdQfVj1A
         CKiN2ihzKnHD4iOy+z6tCfNcfTYH/KV/GZrZbbRej5S4pXhRiD0zUFn9I4fl6t7vmU6P
         XjLxeBWwKjV8e52iG4B+wl3POOz6F1MA059pf6W4OnO2EZyufXELv2euLGHG4JeOrGhf
         oGEvRMuGWH7l6id5xkT4DU4N0VBTeF7Mx4b4/l559j6/ohE6eMkQhFphoVtZhTSESHSx
         Kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764381046; x=1764985846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXq5BoozcLEtMZPipx/4wTBGFkZq8n4VHxCYYlUf+vY=;
        b=O+v9IFEvLzfmfx/9hBf2GVp12m+A35OqymTQHlLD6gUPM59WOBs3wuSlzzxPcmKu/v
         PUotKUujs8X6wuPUVL0um61o5aRd9mH1pYvcrdK1BqGP/6vqcfzenMTQQqOs33bAwycL
         wu2VAzCAMuFeF490JBkNInti0mk35hP49eS8341gwqMsVzIVAaEPkTaBO+IGnS5uXDvF
         YtjVDJZVJcdnEOE0Vy8AlIWmVkTxkFtfk8l318WuheEoXzRFbsM3PCIzcM4BKGmBWG1p
         KTf/Ht14uNbCH/0ArFbZYxrR2YzuGlsVHr4tEdluel5t4LoxFFtgGD/TKW6veHmGTWlz
         a8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsnmVVq86Si91ySfAFB/PAdIyjfw6pKqd3/EiB87Hfp040MJUWrf+diOizGSlNRRD/qxjc7/RiUzBL@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/DQ+9J34Chi0eP5gtXzIfj/R0Rnx+i4uETUqPF89B5oRjm9bX
	lIAhTeg8Evztlu7+ucyRyymccAwrdBFkVk5fQKDJyb7jUI0yGAhlqlI56m8Y7ozxHnUJGF4qt16
	b4yPqgkJ74WBUG4qB1/XZl9G8EaMcmIk=
X-Gm-Gg: ASbGncs8Y+rsmauLR//u58uT+V8ctV3x5WfguyHkE798DMqHrKXLHLZ+F2nBH9vsWAB
	k5WAH6JhS+Mn3Fl6mEXxWvFQN/Se+ODYaDf9TlOblUNRBTYgvh7BUB3dBw+y+TNBk/hfclme+vU
	G8H+togkdPO80NjuDTwN6XCdf2F0yVZUznGRClAf2apLmjCxHfoXJCWz2T4OAy2etVYs4g9/uLP
	X4+B1vdOGdsh1m7cKTutcVH+DQkmwf1QZedIk8JstF+cw92twfmaUIB+tvyDK3PfPZbkmoNlZhG
	zCN1
X-Google-Smtp-Source: AGHT+IE+Tw+9Y5Bub3lN6sC4Pj0OtdTK9knmaYL6GikYTYtgwTjW4uUHcZO2kGFVdLFpIVKdsMHQoOJ3Bk1wdK27dic=
X-Received: by 2002:a05:622a:1909:b0:4ee:2942:c4fb with SMTP id
 d75a77b69052e-4ee5882d9d4mr417978631cf.31.1764381046350; Fri, 28 Nov 2025
 17:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-5-zhangshida@kylinos.cn> <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
In-Reply-To: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:50:10 +0800
X-Gm-Features: AWmQ_bmFiM-2nj0DOVO633rnw-D1LMnVAvls5FZ2mk8-RJDyk4i3to2si2g7WjI
Message-ID: <CANubcdW7FxbtSRzePgO4wQwUFBpgbSYdL-GR87vUXKq7tAPsJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_175047_678504_FF5C2613 
X-CRM114-Status: GOOD (  19.31  )
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

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
28=E6=97=A5=E5=91=A8=E4=BA=94 20:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Now that all potential callers of bio_chain_endio have been
> > eliminated, completely prohibit any future calls to this function.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index aa43435c15f..2473a2c0d2f 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *b=
io)
> >         return parent;
> >  }
> >
> > +/**
> > + * This function should only be used as a flag and must never be calle=
d.
> > + * If execution reaches here, it indicates a serious programming error=
.
> > + */
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > +       BUG_ON(1);
>
> The below call is dead code and should be removed. With that, nothing
> remains of the first patch in this queue ("block: fix incorrect logic
> in bio_chain_endio") and that patch can be dropped.

Yeah, that makes it much clearer. I will do that.

Thanks,
Shida

>
> >         bio_endio(bio);
> >  }
> >
> > --
> > 2.34.1
> >
>
> Thanks,
> Andreas
>

