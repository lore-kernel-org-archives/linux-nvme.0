Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC067CF64B1
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=; b=sOkQ8MvptBOOas21CAaKbBMrBm
	qH1SvnF1mKG0blVASvNJVJ+tB/9JPSIwNjjRCPnJceJVElDO0be77o3YN9yzwG4BYt1G9XksbYVD+
	iH+DrVVn1fXG4pgyWLV3yG27YkyZs+w4WPj/EXdM22Vd1M8At8p3p42YA8QaNHdgJ248yZlvVOTrs
	g3VTxZyD9mma+byFwW7c/J1aT8IFwSd+NVAnDpCOyz+3lUQcdvzlprM25d+xhGedE6kd4a6+P+unQ
	9Es2ODPbh1TvuBWu25yLz/dqc8vLzGLgH7D0i0EDqb54MuOmLTL3V70ejZZXIjpOUHWn/5L6TRIPL
	9dHkPdJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhL9-00000009Jg6-0Uqk;
	Sat, 22 Nov 2025 06:43:23 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhL6-00000009Jfh-2fTf
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 06:43:21 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4eda057f3c0so23498111cf.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 22:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793799; x=1764398599; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=fqDvX1FXn3mFbp7lY+q6L2tp0685gRNPB5sOoUQrsAr2jMfijlzKsLS+h5MDqg1Pe7
         868B/x5/9OcvM9osFaarFDvV9zqvE3mSm9HarOyg8QAMsuEVGAfaP7ILZmksp2q1Ne5T
         +Iq5fKxgjnzjnuh0Yphfck1I2dWBooPlZZ6eQZtYULZGZb28pMwVJgDZ1Aw20XleTSbi
         nV8oMWbxMRi9k7AtmFStddfdfOhBhC5dF4rGx1g9HtdaRc4ZbPJ8DjziSbvn07ANsOS5
         psxNAYovpNmvTRUILEtBLMOLr09zNdmcKLymgGHm31WhX01AbeBnopZgUVFPkh3uZhJY
         f9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793799; x=1764398599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=YyknncLgrnhe2UEJ7h0TnKsQo7OA/ozBCQ1PMpXp4PnqdvVBR2HCZFz7sIERoSlMGG
         yXAfM+5xyW3w23eciU/HZm4lO3fqzR3LHnCRa/dkaAdV3B25BiH0Wr9uWMVxA+BaRvS2
         4BydcQRVD0w1+1EvquteiCFlddpe5gtUNvabG1f+Nm0geD14mgGG/dYroZlI1qgGRwFl
         uLJgYSmRbTkQkOCllJQ1/IlrKCiaaxw3YYtgS5UPjUOcaxh2LOXll8dzYETYnbo7mivv
         JifKVPFnn3sl8K3snB3CTU5wgnbqHXTp9u12eS178pj7EUMlbgMkxrxlowfWX+2QBIa+
         8k2w==
X-Forwarded-Encrypted: i=1; AJvYcCVnc0KgJo9ys/RJsJnmlv7nngN+ttpj9WlPfSVwudQ7klQx1YMZyZnKW5pLWnlVIG+rldPxxyu3e6PX@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm3gr+qXxyv2MTYQcJjaBb4SPp2rH3BeXhhi38pnm49W2n6hoF
	xCb6UmzmEQUaELAvaJglidaTEZ80vjBHurJRv8hTUav05cxxjFDVf+lEEJcdthvA0LihhCkcKLF
	SUaeblQ49nYWM/BIAj2eBtvv6zbg1qqQ=
X-Gm-Gg: ASbGnctWjgKdcBw8kGLt6gsBhHtVvftNTWrMk/tWR15gsLbna8hes4ceI/PLORSd27s
	IjWWX/AAV5oLg1t4OwIVt9m9hdUomatQ+HkNciXJRI0hNQY8KGy05dIr+8AA5Or9eUvn4psZ7Rz
	l+LAvczczyU3f+EuSq/EbnIyFCGuokIq+TH3Qy1CrI1bVl6dcBk6Yyf+uva8FpegRoIxpNVatqp
	y8tWY0YyhC8TPLDio7YIP9t4h+WxJIQM5l7mqr57JrBUVHT4o97kFpHAxVBKj5ryr6ATZM=
X-Google-Smtp-Source: AGHT+IFYY0hB1AT6+W29RBnT+t78nVJtbCkr0AJ7fjgv+YE4gLfc5ZYb5TuO0P1olfjrCgZ/JHFnyc+OtjdZpbL7HYc=
X-Received: by 2002:a05:622a:653:b0:4ee:1301:ebaa with SMTP id
 d75a77b69052e-4ee5888fd9fmr61705651cf.54.1763793799235; Fri, 21 Nov 2025
 22:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <aSEvg8z9qxSwJmZn@fedora>
In-Reply-To: <aSEvg8z9qxSwJmZn@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 14:42:43 +0800
X-Gm-Features: AWmQ_bntN_rMHyZMaZTesMCRvMp7VgMi9_ZfkRlzVtT_jBUQrddcI4xac8nvuc0
Message-ID: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_224320_684903_50DB65C3 
X-CRM114-Status: GOOD (  23.03  )
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

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Hello everyone,
> >
> > We have recently encountered a severe data loss issue on kernel version=
 4.19,
> > and we suspect the same underlying problem may exist in the latest kern=
el versions.
> >
> > Environment:
> > *   **Architecture:** arm64
> > *   **Page Size:** 64KB
> > *   **Filesystem:** XFS with a 4KB block size
> >
> > Scenario:
> > The issue occurs while running a MySQL instance where one thread append=
s data
> > to a log file, and a separate thread concurrently reads that file to pe=
rform
> > CRC checks on its contents.
> >
> > Problem Description:
> > Occasionally, the reading thread detects data corruption. Specifically,=
 it finds
> > that stale data has been exposed in the middle of the file.
> >
> > We have captured four instances of this corruption in our production en=
vironment.
> > In each case, we observed a distinct pattern:
> >     The corruption starts at an offset that aligns with the beginning o=
f an XFS extent.
> >     The corruption ends at an offset that is aligned to the system's `P=
AGE_SIZE` (64KB in our case).
> >
> > Corruption Instances:
> > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> >
> > After analysis, we believe the root cause is in the handling of chained=
 bios, specifically
> > related to out-of-order io completion.
> >
> > Consider a bio chain where `bi_remaining` is decremented as each bio in=
 the chain completes.
> > For example,
> > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > bi_remaining count:
> > 1->2->2
>
> Right.
>
> > if the bio completes in the reverse order, there will be a problem.
> > if bio 3 completes first, it will become:
> > 1->2->1
>
> Yes.
>
> > then bio 2 completes:
> > 1->1->0
>
> No, it is supposed to be 1->1->1.
>
> When bio 1 completes, it will become 0->0->0
>
> bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> zero, and bio2 won't be done until bio1 is ended.
>
> Please look at bio_endio():
>
> void bio_endio(struct bio *bio)
> {
> again:
>         if (!bio_remaining_done(bio))
>                 return;
>         ...
>         if (bio->bi_end_io =3D=3D bio_chain_endio) {
>                 bio =3D __bio_chain_endio(bio);
>         goto again;
>         }
>         ...
> }
>

Exactly, bio_endio handle the process perfectly, but it seems to forget
to check if the very first  `__bi_remaining` drops to zero and proceeds to
the next bio:
-----
static struct bio *__bio_chain_endio(struct bio *bio)
{
        struct bio *parent =3D bio->bi_private;

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;
        bio_put(bio);
        return parent;
}

static void bio_chain_endio(struct bio *bio)
{
        bio_endio(__bio_chain_endio(bio));
}
----


Thanks,
Shida

>
> Thanks,
> Ming
>

