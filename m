Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175C9EB362C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4KK143zSlWT2rj+6qA3lip/EaX0klcurIc0vV55AUn8=; b=hXtTvxHHpWnyJIlYfx8kyz2i67
	+DE4rEKjWdshSU+Dcyab01a0vY9WzkEXDpm6uHSEs0OHJdp7vWahUn+9QdSTywH+v7+/GmPhWduR2
	I0vg/UZbe7f1vTYRv5m3uNtm+8wOZQKIQyVNypYuRsJTm+JJ0v1MTKGqS+bsOPyTRZA2lCTLkTulS
	c5tcot9gZ2mab4LP7edkDvw3xyhzmqdsCPPgVobOPx85/rop2Wu1zSYGtVBi8t2FQqNp8dVF2I4/o
	Ad9YOdiKT0wr04JOwuVgBIaYg3GjeHhU53qBpEQiT/aDXnQZ/mbQgKcvQq1OykKz06Fw2qInPLcQp
	NXa++ENg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx8ZJ-0000000DhvO-1P1q;
	Mon, 02 Mar 2026 19:04:37 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx8ZF-0000000Dhua-3QtI
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 19:04:35 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-45f13058ab0so204888b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 11:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772478272; cv=none;
        d=google.com; s=arc-20240605;
        b=N3kKXxhTnxUziUMhlvUSppRyH8yeeDTGsg2vHYFdbDr5m8YhleY951Rn62aoXLIa2k
         QvROF97HKjXZENWoN9CNKh2+ewjTjVUws6dsbrj7p9uLNqGSUX68WLOgRUiKmfbk7kj0
         CwP/kj5vxgVA/dWocyy/QHRBRUMylNZa5e7SPu+vd/RDUlHEbdDZipFCPt5ORVJ1gzZh
         QyY+ZklvMi55sO/9WshPwrhyq8z5q9b+MEVTQkcasKsFnE1Lqt7Hjo4Ps3BU2Fc83wtz
         ToS6AKJ6KGfMbm111W4h2caRGgftlSRK3VwEJ7bko2eeydjatAEdd7hNUp6TJS8n9Oy0
         SFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4KK143zSlWT2rj+6qA3lip/EaX0klcurIc0vV55AUn8=;
        fh=0jVIQWJl28Njcwy4+640nO0+qq8E80Y/EjREdrmLOMo=;
        b=GZJJokS2/VO42R0aUcU0o1wUbJK7JpLjk2CWMnppS4uPk8vF7HRltzlmNqWvKiW7E4
         +XYWrMCLnr/YqUEw+sKZoEwuTTK4gzSU5czQS/XJCx2b90KdJEkraZ4ONW1zGvmVCEhI
         op5iRGQgIf7oAqrcA8A4fgTdFbk6T3KxI4ewgKsC9zqk2KEnTVH90EHZUyCGL4XrNYeU
         rJycvPUG27OKhy1PIF6acYYA0gcfpBLCZks2pR1LfqDx8gqiq9jCr+HBDrFT3vSysySk
         QvMommkUUChj3ysVQ3R+Ldd+UyanfI0rxdMj8redKwwtsYFS9mfu6K2TzaBrGZiUDe2K
         EFvg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772478272; x=1773083072; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KK143zSlWT2rj+6qA3lip/EaX0klcurIc0vV55AUn8=;
        b=e2FjIiX8NyfiHAXE3gsD2/tZwZxscINK6JWk4mh3CdtnS31T6pkzwNsoVkNGlj1i6/
         GzOpHzTU6wHT/KU6BlILDY8cSSP6UtNpuaii1sCQuUFjtTmU8ZIm9yLkrmkfSaQwyALP
         eWI3Wna2mYaGX5SkoNh/mdfQ6OAshfw5D3SmRclMZWwDCgV8HXwIDbzho7Egps05gVpG
         QejRMr33zQeDzkHDPD7sp9Zgwc2NxazGFU61+la63/urvDA3LRDF5zspMcPnULorQZBd
         LmhUnJX/Ve6SrUlfoVvZmAFYOKvJHDFibGygTopcqkmYaeB7HJemCGI6QLvnKA6ye1/w
         xeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772478272; x=1773083072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KK143zSlWT2rj+6qA3lip/EaX0klcurIc0vV55AUn8=;
        b=wrbUY+dRG8BIUo2CSLZuObtrbXxEhP15tUCURDbHsKdbdM+CUyuMK9qkb4FFl+TQ9u
         RvVFPqlLmU6vYtFsYanNCMOiyUOSLL1b5MonUvsDUCoy1hEYHOhFhpUaNpuZsAp/REEQ
         d6+rARDz106ywG/gtz3HDIZiFcvUkaBiQQZohVoGqjKDFM1jKgS/KK36e+z2cPFNvNmQ
         m9jWJ5cQ8XP0LdoCX9yohEGvA2JTIquLvgUraI1RQm/MZEhRDNQRHhAuCF7ECrtTAMcH
         eE3rhCkfRiSyLzRplW95UayyIIq2D0CuFb3WB4asBAYlTDlGVEG6ACei/jk6juBdMUa9
         LC1w==
X-Forwarded-Encrypted: i=1; AJvYcCUnsC27Havq0nMpoX+dfIS5nFcQLz0fS8LwD+lNPmCOKZSHJS/ErR6fR82d1awpfiVDLzhh+UG+BmVi@lists.infradead.org
X-Gm-Message-State: AOJu0YxjmEA2Jkp0SElihsvSB6C1hMNhpYw5F/GaSWjDXmiWzmCkA9+J
	UACL/V4q5i/AqXpShhNMoDweSIAKHsyvQBQzgO0KIuPskqJgdotzgYMNDdCQ7QYMZh18W+I1AtP
	EdbjNs5aOm8g5VJNHO6t7syE/WJxrF+hMRiO2QsbWbg==
X-Gm-Gg: ATEYQzwa6Igw/OVAigsMiWn3Cy193jHgvWU+9ES6EqGUJF9ppqyrqms12twFWNUVYYW
	X/QDgSlpOwQCZzb/MMF+wTWK3KXsFxlkFfYYuKmCUOh6ty9dgbjauFWRAX+FFaouqr+frhmc0IO
	yPql3iEFwor8K8oSZ2MASfGmL+sx/sXW/QZmgX6MnRFR3yhhvliYaVVV20MUi4gtfnGeR3DL7jk
	XoXEXAGNzgOsn0f5Q7zLhrc3KaLDbP2PXQ0x27fsrYSH0a+DYVesYkZauj8OsfEzushVgx/Jyv4
	xVrVYIgj
X-Received: by 2002:a05:6808:158c:b0:45a:9068:6421 with SMTP id
 5614622812f47-464bebbfe83mr5399557b6e.3.1772478272460; Mon, 02 Mar 2026
 11:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20260227202354.1012322-1-csander@purestorage.com> <aaXc7oun2IgjJ21F@kbusch-mbp>
In-Reply-To: <aaXc7oun2IgjJ21F@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 2 Mar 2026 11:04:21 -0800
X-Gm-Features: AaiRm5030ZXvC_6VTEGCAg9q_Dwq9gYTmqbGBxRg3DFYCE-6zqhVfumcRdl9nSs
Message-ID: <CADUfDZooxfLuSxV7OUmLe0Nkj61A-TSgGGtCszZYRiZJjNo1uw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] nvme: set discard_granularity from NPDG/NPDA
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_110433_910547_6E82E72B 
X-CRM114-Status: GOOD (  18.18  )
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

On Mon, Mar 2, 2026 at 10:54=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Feb 27, 2026 at 01:23:45PM -0700, Caleb Sander Mateos wrote:
> > NVMe block devices always report the logical block size for the
> > discard_granularity queue limit. However, more accurate values may be
> > available in the NPDG/NPDA fields of the Identify Namespace structure o=
r
> > the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
> > Namespace structure. So use these values to compute discard_granularity=
.
> >
> > Also fix the use of the OPTPERF field to better comply with version 2.1
> > of the NVMe spec.
> >
> > Update the target side to report NPDGL and NPDAL as well, in case the
> > discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.
>
> This series looks good to me. I'll queue it up later this week. I just
> want to get a pull request for my currently way-behind 7.0 nvme commits,
> then rebase the tree for new stuff.

Sounds good, no rush

Thanks,
Caleb

