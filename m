Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30250CCFA18
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 01:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=; b=qb3mywdHOCyBJCSw8djGLlru0o
	1OmEXHhYEa2bLiPC4SfLQbbPegg0JFIKm+4vn1eWqfDkqHy6of+E1oAJls3Oq/Ot1UnzYhx0Jmm26
	EGHdnROJQy/pw1laXXSe+7Ws0/iVs4hgkro74TI7y98hhHkecB6+hc268WeJ8546IcqnaQ720Iyap
	bL+bR+xQZbpHnkXDmsF2ebKZrRmgHzwjlnbBiHu8viwxwpCBe+NHV2H8HlvmdGQshL6xFQxbU8z2K
	EDpi4ZJIGRZUeIO2ZMWyQuSpb76aNdLh3Fi/zSu0jekAw5RggkGiqXBoyButMQW/XIdYU4QEsB/E3
	UKJVjrsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIzQx-00000007wvK-2t2N;
	Wed, 12 Nov 2025 01:14:03 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIzQu-00000007wuy-14j9
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 01:14:01 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3438231df5fso352715a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762910039; x=1763514839; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=;
        b=UAROafRWapZQzhNU9yfFUvZD1U9xQiQ189A8PFS3xADdzLN1vCjRcLu7agXG9RxujL
         Sz7nJ+5IgHPEcMzwU4gN/YGiEbAB9fzP4rCM8G16EQsCMEqWeX6F6HvymndtqCbgOCjH
         jAO807Fr8VBLm4NMJbcgArtZJnSGJecJJqyOq8QmLFBKSYvKHdmXELmd8q14TZPU7ye4
         yqnQiwJoj7ZZKWcuW5uC6lP3uzk9T+AaYRlHIeOgxlg8gEmD9vyfsudA3G/tA4mmx3Kg
         diipMCdYuX3/WAtsSeZozI3b1NJqNMcBOE2/exsl4A/qeBDpAy3IWLSVG5+FHaIqJwY4
         avrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762910039; x=1763514839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ2lc74KyVVrREG4zhB8cAjGo9u4ikhiO1Oyz21vwcc=;
        b=PbP1mM7An/lQw+D5EE8f+f+XgSOZ5Le9VxGHTRS6vr3WPjYkBhY9FGUhD/6BMq4PBJ
         Wtb+b7DdEGyao1LGAuIMTWaf9vD1ssv8//jUbGe5CLHfqyBkcRqzBYtmsxyH0mjUo2Pd
         F9sORGhhwP38GH84SYt9rhBvAiaPi38NZhWH1yNKSR1F1z2HDnkjQDHDdhak643zyEC8
         Cp299jYqHiIEnPLGGIZCje58URAT1V/OrsQcqh/4r8Pq/rK9gdq/wNbh0q4JhdL0H52e
         RUje09zoqGnCm9GKPO4KpT+LKTlI31PHi7VEc12c+rtYRsRdJ4eQS7As8XLNHfjSql06
         TT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKV2M1wvBp47O7VgLz2Nlj6RFENq4K1se5AZy4qhqVsIHJYa06LKT/H4akMk01Hb68R29a+2xgB+P0@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3Fuoca7tOfW2DyOsN3K921Nk4S++qWKeD+8g9htIKnh3MAHYd
	l2+fIdVdAbFpwwrANV+pu+1qZqfcz0H0uTVrpit7NIOHohiZq7/U1+d7
X-Gm-Gg: ASbGncv0T2ut+T/cC1iGvrCGBdCPOCxzrabUQqHRHdPUd/FvFHJDi06Vaexdz4EXqHi
	uGa0C7uO8PvA5CHY5TJHewSA3aVTCFXFZ/9JGxPUL5Zc7X7ne1j1Nxok6LE6KedsC9L4yQp9O2G
	+jkhqWeDGc7A62u0tDVD0Oe4Mz2ONiEGm3KxQyW2N6S055NXIP6OTb9heyUo7x58AYXT9hCVTRD
	BiG9XgRnpFY8qYV/JuJ/JXSgSXltSva+HVe9nSmQcW5J/rD+EtCyxQtC2TGoUX1r+EvwCHNmjDI
	JxDGWYl2Ao7ljWp4NcZ0CYSgk9nbKrudhGbRP4+jBbYO7jWs+zeahpRBFEsGqolk2COB97D8WWd
	5grIJ4sAQbzOD1Lac5xUJvMmggxhiWAe95RaD1fOOJvCASIkR7Hl5a+h2hJEYxsqjd8ep5Hlctd
	e37368K7+GCnvNSgI=
X-Google-Smtp-Source: AGHT+IGmVXVOcEk+++9gYdT5vZS2t28n1mKBeSL++XpbAzlWU13n2vU3KLOXhWUVeVvZFIiya3Zzsg==
X-Received: by 2002:a17:90b:5252:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-343ddeadf56mr1617088a91.19.1762910039035;
        Tue, 11 Nov 2025 17:13:59 -0800 (PST)
Received: from [10.224.102.62] ([134.238.36.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm448403a91.2.2025.11.11.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 17:13:58 -0800 (PST)
Message-ID: <e9ed25a049ab88bb976f1b625d659c568434d93a.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a
 reset
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 12 Nov 2025 11:13:53 +1000
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
	 <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_171400_299030_4AD351C5 
X-CRM114-Status: UNSURE (   5.72  )
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

On Wed, 2025-11-12 at 09:45 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
>=20
[...]

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

