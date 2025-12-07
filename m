Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F06D1CDC6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Dec 2025 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=; b=XEae9pVAHK1IVgNJhitGusJlZb
	KOcnrboV/cUlIf/GFMmMTk8yAcWQye8XFc2JsgcxHk9gPX/D45T2cEPNTPlkyGhY/h/2NY2oprRZq
	BLsHeuzEt6BFJjMb17+Z/iVgYXq8yGKRrb+RS5ABVRoxD84N9g3dSxLOajymjz6Cr+P2BNRahvR3W
	LfaIK3eX5sFN/q+7lbdct4phn1k/YFK5gnFzyvkEOoV55JB9rzlPHjtmXhTcY8QlD7skT+PSLIfeT
	HJbTdEo7SmG3oGLf1Mc2phDjRZ6/Jwez3CAUeVOwhR4gszmtm+1sDyT3Mv0Q6iuZ1mttHc5i+XOun
	yrXnRA3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSBd7-0000000Bee5-2d75;
	Sun, 07 Dec 2025 10:04:37 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSBd1-0000000Bedc-2gHT
	for linux-nvme@lists.infradead.org;
	Sun, 07 Dec 2025 10:04:33 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4ee1939e70bso29112861cf.3
        for <linux-nvme@lists.infradead.org>; Sun, 07 Dec 2025 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765101870; x=1765706670; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=kCO/+iTcfGKP8yCAm8pzG0R2w1ljTrJ+/poyUT9ZhSa0OEPX0LIeMer6gEhF35Fstx
         00BI+S/34qvRYGZDwz11GzBTpnvEvNW6k+P1o9llzMgoL45deKEjMHRoYc7k7pcmMLds
         6DbnnvKqCRzH+RrlQhkRBiwaiPAKnnlWdQ/Wcb2hY/p41RTSMWX4F3IcMg7ciW46LdAG
         KD9XqkgPqdRmCkX/KxVyIn+oP897lzF2vIxxNZLTkbsLjoL7ZijpKkUC4jaINtOATk7F
         nP0R2pEVUX4/ui42uBolUr2CH+3dGsYgs2wdtR0ZiQRHRA5rMQWmNJ329Se19hcIrL8P
         A0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765101870; x=1765706670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=cytz94S/mFx4se1c5BcgOaxmgBnazVm8U5Fg1Nm6/jLlMH0WXKqDqJHfBru9ond+3B
         VliXI6OdJFys4YbN0F7RaMuVAOHe9v4Q3an8/7a96QBaNo0FxypW/pHFf0vKvsLR4kGs
         1WxxK5TvzC6KGkxfQGsm+SPRgrQPflLbh8inT7L74bRQ+/MK+aNfUF/9Mqatzkn0y6LD
         9qOrS0FgNORZeksTyQWoA+UjB9CZwSeu8vnGC4tPHHMBb5zH/XbfqdF8D6Ll2oWohV/d
         L4qdOg32IGPFRuBw2+OPHK5qpB5zqr4VxOn6PWQvUpjdMrLxIhxBNNDvw9H9ozBObd3I
         6m/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWONCD2nNk77/YbiNRiVUt3g+Y8Z6SPtUH3njpkYZUeFGv1KfQ5bcwZPmWPZ0Xe+F6EjveeV8DejxqZ@lists.infradead.org
X-Gm-Message-State: AOJu0YxOY1bBlFPx1Vovf+6PkxZGClQggIv5CjFJ6M04mtQNueYC2Tb/
	sGjNDjtDFDDa1Suv5w4jH3RXus9MTVsnI/ko7TjyDBCh+orN0BpWswjcfQlNPNbPYp7y8Z07m62
	GvKTk1lep3l+0kv7DE0LY1R40wfK+6CM=
X-Gm-Gg: ASbGncuaih5M6P1dXJ0+Tv4f6EjXN4j7do4Vj1S2jm0LOsl138tUUU9lBcOXD1qeFQM
	oDPuZA/VDMYczIu9US7wfagwuGYRvuwPxsDsnJcXIMKAwY0Ii3tC3pVMyKk0yHRFnci9Xp7iUAd
	wAgFjT1M07rTq41Qk3kFntALDc9xuPnHIAIPXRNt8gSTPPdwUi5tKp37BvLdmRWC9eTp1/sJ679
	hp+mo6D07L0O9PYCmTtPShWOITG4sG/WIpiV0wltExB70GiNi+4oqKAeYZiPZpWiUj2ULE=
X-Google-Smtp-Source: AGHT+IFyS19gciaAgZhRx4HvH1R1sNPMXGO05IWdCy0tyufd5AG5DROw9tSZhuIt2ZeFQYvOMOepLj8Zf3YwFI1IGTs=
X-Received: by 2002:a05:622a:1249:b0:4ed:aeaa:ec4d with SMTP id
 d75a77b69052e-4f03ff48c23mr65405971cf.77.1765101869874; Sun, 07 Dec 2025
 02:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
 <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com> <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
In-Reply-To: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sun, 7 Dec 2025 18:03:53 +0800
X-Gm-Features: AQt7F2r1YNFWGA2Q9VwdNr_tG5KYi4lqES_2HjNJQ6tE7fdz6CI5_Dt06IQV2e4
Message-ID: <CANubcdVAitTW_aBqwxC=TV77rg_iie0uX54_qEtMCjgdN+zeig@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>, sashal@kernel.org
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251207_020431_800241_F7686B38 
X-CRM114-Status: GOOD (  23.41  )
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
5=E6=97=A5=E5=91=A8=E4=BA=94 16:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.=
com> wrote:
> > Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=
=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd=
@gmail.com> wrote:
> > > > > This one should also be dropped because the 'prev' and 'new' are =
in
> > > > > the wrong order.
> > > >
> > > > Ouch. Thanks for pointing this out.
> > >
> > > Linus has merged the fix for this bug now, so this patch can be
> > > updated / re-added.
> > >
> >
> > Thank you for the update. I'm not clear on what specifically has been
> > merged or how to verify it.
> > Could you please clarify which fix was merged,
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8a157e0a0aa5
> "gfs2: Fix use of bio_chain"
>
>

Thank you for the detailed clarification. Here is a polite and
professional rephrasing of your message:

---

[WARNING]
Hello,

I may not have expressed myself clearly, and you might have
misunderstood my point.

In the original code, the real end I/O handler (`gfs2_end_log_read`)
was placed at the end of the chained bio list, while the newer
`bio_chain_endio` was placed earlier. With `bio_chain(new, prev)`,
the chain looked like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`bio_chain_endio =E2=86=92 bio_chain_endio =E2=86=92 gfs2_end_log_read`

This ensured the actual handler (`gfs2_end_log_read`) was triggered
at the end of the chain.

However, after the fix changed the order to `bio_chain(prev, new)`,
the chain now looks like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`gfs2_end_log_read =E2=86=92 bio_chain_endio =E2=86=92 bio_chain_endio`

This seems to place `gfs2_end_log_read` at the beginning rather
than the end, potentially preventing it from being executed as intended.

I hope I misunderstand the gfs2 code logic, and your fix may still be
correct. However, given how quickly the change was made and ported
back, I wanted to highlight this concern in case the original behavior
was intentional.

Thank you for your attention to this matter.

Best regards,
Shida




> > and if I should now resubmit the cleanup patches?
> >
> > Thanks,
> > Shida
> >
> > > Thanks,
> > > Andreas
> > >
> >
>

