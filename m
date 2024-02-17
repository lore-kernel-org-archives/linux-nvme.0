Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173AC48BC4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Feb 2024 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:
	Subject:Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUsOgHzp8r6kWIn49FLfR/dfD+6UhIXiD2CyZpx4J48=; b=pu9mZKuCshxCWwor5zMXNaoAMS
	HSEMDB1u9rdSzGI48AB+z1J50Tm5Uv7qLcSHOw0augtpx89y0UtwIXzlfeoKFoLxHQtUI7q9+3/q4
	v/ePdamZBHIajGfLke9sSEmvy6T4G01RcRWzHmIOlSjiYRbEDTS7sjiRCJJQtEPxB3jbjCc4Ag/xY
	hDaHE5QXc+EWh11mpcG/Df33cVFIqRjEKZnys5r++DsgTwLGWhd4+gILLiy0+HBcAwPDxSLHZuW2M
	3D/0Mgr+kZcmemHhxgfwVAbPtbRqWC9ySNGH2H525pYbYjQDE1XQWcxqoH/pVXPmpWxU5Ort83V3c
	YqoIfmXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbJK8-00000005bmZ-2qFN;
	Sat, 17 Feb 2024 11:57:40 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbJK0-00000005bkq-11Rn
	for linux-nvme@lists.infradead.org;
	Sat, 17 Feb 2024 11:57:33 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-41258904302so3829855e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 17 Feb 2024 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708171050; x=1708775850; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUsOgHzp8r6kWIn49FLfR/dfD+6UhIXiD2CyZpx4J48=;
        b=AQjhIb3aVsBVW8LwS2JS3z75KWM5YOf/SxzZLrt0Mxpg9kHf7XIGqqGVWURn1Q5MZb
         Aa9ykXAX3e2nej193FEFe9gD9GmADe7cg3aTTpETClJj/v/QEL+pjXMGkgTVd6gF2QF7
         d8ebpZM1Osmvkla0VycB4uX/020FrV8BxYj+ipPozu/FaNgHeP1KrWfQ7jWjq/mEs6dW
         mVPpcuSRqjuQzqXGauQNHIwBBFaEuC+M1DNVxJgWLapqGTGrm3TZEPMr9U1TS0KnZEJh
         8Q4x18vTmWyF1JortgeHDKaae9wLkF+d1MOZBHdoh0M5rf+myBwDagOs6tgY2Ep1KaBu
         bNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708171050; x=1708775850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUsOgHzp8r6kWIn49FLfR/dfD+6UhIXiD2CyZpx4J48=;
        b=N2N+y5VFMBHlAUNsExpQh+N3XS2ItzuoZNWxF4kRgBwawHyZXYo6KGpybMiEpdxpf3
         VeW0IibJK00A1lnLbdNBurccrCsjaQ1pG4MuQ9WdMlSH1Um7KyrmlX4A3yLdO0gQ0Bnb
         rO4p4/H0FtQO3ZAY6/38fVg/auCrJi/jKbB9/bOf4xBRKwBMKsYTsB4fNRwmEmbTf5Dx
         cu4B9efo6jEX1PJM5JCQ+AcEHidtxye8q8068PBa2ikAAJz5LJ6YxiWYsTItMM47Pama
         usWlehvhe2mg9vw+FM9nM+IwAqYYZsTkhm7Gu7RLyLMlmh1rm21TW7KMdJQiaLxpn47E
         O7GA==
X-Forwarded-Encrypted: i=1; AJvYcCX6772UWtTzae3hoaiDX2eZOUGjIeBV66JPpogjv+UjHwGy06JfvdBrC2Aod7DkxRfu4PG/qQC+lxnCM1+7kiv6TfLO4N7j6WhrTmXQKvs=
X-Gm-Message-State: AOJu0YyMnwmyKybRuSG4znK305gPLES/UoJTVTBeLxoBYE5MbT01vMjl
	dZW/GEgWXsNieXoJIOadd8TPX0hIaicXKayRs80hIWHJzKJ2EkQQU+eBRI0rvvg=
X-Google-Smtp-Source: AGHT+IEgt4lASuS58P85SkCYtQ+4L6sOssHAkGTZm9qejp+87GdqbxGLue1Q9HifEME4xc7jobqShQ==
X-Received: by 2002:a05:600c:3ba6:b0:411:d89d:d7ba with SMTP id n38-20020a05600c3ba600b00411d89dd7bamr6456069wms.7.1708171049914;
        Sat, 17 Feb 2024 03:57:29 -0800 (PST)
Received: from 192.168.10.34 ([39.45.172.107])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm5096840wmb.20.2024.02.17.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 03:57:29 -0800 (PST)
From: Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Google-Original-From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
Message-ID: <0e96289fdbda200b9608284c7d5fb72546ce4267.camel@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
To: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Date: Sat, 17 Feb 2024 16:57:51 +0500
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240217_035732_311132_68F28E24 
X-CRM114-Status: GOOD (  14.75  )
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

On Mon, 2024-01-29 at 04:32 +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
>=20
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
>=20
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
>=20
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...
This is great idea. Instead of having a session to write
documentation, we can have a session which would be documentation
itself even if nobody translates it to text.

>=20
> [thanks to Amir for reminding me that I meant to propose this topic]
>=20


