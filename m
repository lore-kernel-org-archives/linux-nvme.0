Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E94F54ACD
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1uhGFa+yQpeO+kemY0lQ8RCGsIpaRRvPF2vlBRYcDE=; b=i7LoaJ++ZCUvlBxOgkS8Ov2Rlj
	DkPzp/9CHnb12GUdSHjgeUBCQc04VnG4IiNfxctNFldZH4aGWE9/VxJzlFJXyPVUAFulZhyFOwS/t
	PvBszxRQGBw6zwsxLFmfoi39/mNN0UNQsatTu9kOLpF11SJCrAArPRYf4ffdILiOdILrWYKapsEDB
	CSUpRJw2EBg4sZxKO7nPH1FJ/5C/F7ySb1jltDIXvuIobjmHVusV1wkxmnhRjvkUHRweycnzDA4co
	zqeBqDrN/tFZjI1QOxmGg/nfQoVoBFF9iQw6dZNYS72H/9ZI8sLOdzMtQc6jHJXWCyyyxXFCVo9s1
	+gIOaOMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53ie-00000001lOR-2m4L;
	Tue, 24 Mar 2026 15:31:00 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53ic-00000001lN2-0J4Y
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 15:30:59 +0000
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-38bcda08c76so36849481fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2026 08:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774366255; cv=none;
        d=google.com; s=arc-20240605;
        b=DRjBV1ROLHFdNftrpqFS87FG+68n8WGmC2rp4zvpeif4fHWSHcM3qRAWt9yeC5XbIF
         1hya7zyf0IwRIx9kPApl+f/zgjqQw45aGglIYx92PyT19WRjUrCGNHb8FUCN5CyQlgQv
         STxGCQJ3PdyPFC5X5otPy/dkB8IKMTGYwKnSV2X2XhP6W6hji5Fp3LsyZNGMUS546c+w
         9GJ7wkrtfNmDbG4Q3aX1iwBNK184JS4DCS7XaoQLrtI8uQtI1TXUlVs5sV6iIbPN+PVV
         gp2D4h+ns/SflnaRd4F0/SLrKwIK7kxG3o4jnt4noR/QlxEFJeVUhmSMmIrbOgbtpH7J
         72IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1uhGFa+yQpeO+kemY0lQ8RCGsIpaRRvPF2vlBRYcDE=;
        fh=ddgW5i1iOF4Nwr+J9jhjB2ed+xqkaekIr47Aykh4+/c=;
        b=Is+uuVV5IHPRMoueGgO/hWeoaAF8zt0DSiJtUfDrWCYf78+AgkzHCXMoskIqvTwRib
         2jd1+2DtFulZDeHf5O4XDyCSr4ui/nKG8knFW7165qBwPp3DIC/1g0ejaLMwyVGCWjHa
         0R1+ODqt05iEUc6fDBzD4I0KAdls3M26DY+skqozakJsqO7VtdkwpaEegFEx2CwLyn0D
         LutyDqs2Fafh7nv9IlOEshgb3QDeS3A602S5cD7TfDRWCKe+KDFwcSBMXWiuLc/I/ViX
         8cAeXMEK0zBpy5JdR5AbDzA6cIVdNkDY1/W3pgGZ7qroKg+FgofGXNx6yWaZ5cH6WIYY
         n+jA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774366255; x=1774971055; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1uhGFa+yQpeO+kemY0lQ8RCGsIpaRRvPF2vlBRYcDE=;
        b=Hf5a4ZMW00X5W4Ss1qZytuDOhG2ppbCZDX867Pxl296AM6AnfAz5MGOPBLeuDx4e8d
         bw7TbZXq2WRGcl7eAYMziYhuLG1wsPxsUIqdFGjLmNdssgI9u69v8sAYUoGFUGko2htL
         Kdht3jr4aZoX3QnLqNDmiO3PHURkAsOKdBRWMYJ8wXNS4J/hutV6WAWstFCyUV4x2x3R
         OkdvXFOcZaxOjakxS3Jg/RMZ9uCKLQS1TJLIbk4jJLuK1HjrnsSvpZHT/4dC4y8u58PL
         w+dDaJYsujMHUrrIXUTT4EEieXfc8NDyjYM152ry2Jq7BvCBLow/pR/DQklaPbuH7Cj1
         Zf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366255; x=1774971055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1uhGFa+yQpeO+kemY0lQ8RCGsIpaRRvPF2vlBRYcDE=;
        b=BQbpFk9Koo/3i2BTfGj5B2oa8nc4HwNI3S4+2U78Khcz0iZpeEkbiCB/qvx1compw7
         REorPXapLft29/j09uAT3C+xfTzDfqTIoYmBUQ/psnfCaj2CL531avgAimOH1lx9YNjk
         4Me/TyP1vBxug8ixnrvHyfn+llVRon1BobbjvyY51wsKVvOdy0zWIjXv40xjDD8SCGU7
         IXhDpWM4V4lo+0wAU/upnNPV3y/WoIIKjZ+A8kcN0qh65sd/WnkTlqQdVKxqLVwR7WDY
         BQ+QD/00FgJXavPobENVItQgrJg8z0Jv5UkqvqSHTMul5wWxVF69LyAAFzBN39Fq92HR
         897g==
X-Forwarded-Encrypted: i=1; AJvYcCWIKBkqiGfTT+MSkujJPxbGZwxyxUbfLEg0fPa5GsBTCbfWYynH6JcjetoybzkbORhf1ML3Ha6F07MA@lists.infradead.org
X-Gm-Message-State: AOJu0YzMuiXwK6wG+dWPEZeoR6gFQk3pNQ/vWRAA5MEyuoP5Qb4bevjc
	TdI4HehnBZrcmiPUfz+lg0ksN9fX71dq9/34mVabWHU6v765IQGV/vGqRFMOMtYfywLa78klJAU
	30TzolNKcANV82OpLyvN7jzvSX1gAmMKAmclnKQOsSA==
X-Gm-Gg: ATEYQzyEdQskOG4kVxTy4ZdOVUCLJMedtJDRQU4efuryH9GZaLL3sYu/yEpqDe2uJjC
	ChQxiG8wB7m99Ze8KgULfafd/GLV1w0DWSnQxfSbwFwpsqmItJ8i24I6JIsP/Znfaw4X3Y3DRSO
	BPThdT8yLrcRTSdU8kQgV6zknC4KcLVU8brTv+etpVRUSFTvfh0Q1P5xzIFxTAqic87kaHQAndk
	HDYCMGhqoD1zZvK2HwIaXXMMLf7JkfYzFXcFQU5JcWQplh7lq4b1IO667zst54PAc1QW1MjJ91E
	AgRi7x7nirsdGl7XjQwTDbRRY6VCSPhPoV2ZrATL
X-Received: by 2002:a05:6512:692:b0:5a1:d354:2fb3 with SMTP id
 2adb3069b0e04-5a285b5417cmr4708363e87.27.1774366254944; Tue, 24 Mar 2026
 08:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260223102336.108512-1-marco.crivellari@suse.com> <acKsf_tK-mHtwO-m@kbusch-mbp>
In-Reply-To: <acKsf_tK-mHtwO-m@kbusch-mbp>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 24 Mar 2026 16:30:44 +0100
X-Gm-Features: AQROBzC22eUieAhZd6ux0wVsVpFYpTN-WOcqTJr63yTF2WQbQtNSxofv-X4Pcak
Message-ID: <CAAofZF70SThkiiFsVu0Z7vMoGFMLuBJW0-P2eCHyfXa3vz1rTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] replace old wq(s), added WQ_PERCPU to alloc_workqueue
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_083058_129828_B21CA6EF 
X-CRM114-Status: UNSURE (   7.24  )
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

On Tue, Mar 24, 2026 at 4:23=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
> [...]
> Thanks applied to nvme-7.1.

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer

