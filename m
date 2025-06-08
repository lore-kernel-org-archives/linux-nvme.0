Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E50C5AD49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jun 2025 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=; b=IctDWVO7CoDW6SBOjMwlSAOGj1
	kYQLH4WTdP0fYyqgYY3PfjqvhfrwvQSK1F+EGkEyL05XfnkP5eRlqOslr4C7C7bbyjWE8rnoulZ8K
	YVK5PHkfm7IeFzlFfRs3uw7C4S6HPC6Xwc6GYcbzIPAeSN0LUcdD6LrmA37tW2xaZwmeQU3d9cPJc
	IUHD6Ph4YpYGECk9qc5d/cHgTNf35rIuHrxMVHlEMgDtqwJI6PwTp/LUha2GvvSos21BD0kaK9QyQ
	iO2oRYHoVQ0Oed495QyayU3TBkhbqKoWlEeToaFegm/WlcMoDSrrcRX+cgrmsj428aPTcNrYdGs3r
	CyHwkL9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOM7T-00000002vU2-1Sks;
	Sun, 08 Jun 2025 19:55:51 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOM7N-00000002vTh-090e
	for linux-nvme@lists.infradead.org;
	Sun, 08 Jun 2025 19:55:46 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-ade58ef47c0so82526766b.1
        for <linux-nvme@lists.infradead.org>; Sun, 08 Jun 2025 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749412543; x=1750017343; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=;
        b=IPBxfnSEOcT8FKSRMJ36WpFu8G+CcOfxMCieSplPIBNmxBSNsv22v2qnBA8SAEz91H
         Ab2OUpcYwqr6IVLwwp2CPLL3PJZyk/7FYobL6xyLTXUUmAGQKw4PuDwxlFIYI6tRXoQC
         zaSLHlbLJGkAG13rq4Sh0WccCMu2Hsd8fnG0YhfaINPGNePznWzSvD+bi6gFAZEI4px7
         25jNlYQmd/JvACLqTnTkVw4FcYyTKRIFhlFzCnAE8giaMIXF26p0E57vev1h+sN80mUY
         2m1PJjZGFlg52L5QL45eKrLNWxIFsrk6WOMkLibg+YIp/WAzFfUzwSKktxeeNrwm1sc9
         qc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749412543; x=1750017343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hE+oRRutgPV6rgWo+rwQK76ndwS9S8ZF1xQ1IyJ6agE=;
        b=G5EozOxOBQgRgCkWrl9AZnfqGst+CjFTSuITHczSOawVsFx/u8gENBmYcikVHQJpzY
         tPUhL0BNNlnyj4xlZKgMOzOlrnUKZXslaehCzKhSJOnhThEYoVEN8BuHF9DLzpppPZcI
         i4Lu1Ol9pJGzBjTkW3MIQ3livJnFSliwZddSOD7SvSnIFid7jXN7nI0T1ZPh/IKBoAyN
         6X7MtbGJoTqjnBF3K9hI3g6BHHOaRShW0chKaVBxWyOYB87v324vqLYVV8vmzna1SDL+
         bZEjntMhT/1URjTEX09ZeW+ILWadnzeCjprcVtg5FaeVZBeP/eStApQrFibCNDEAgUqQ
         Tw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXby58QmYltLLbvBI9XThDv3QPuHQbQcI4gbsRAG2yfzZu3Y8472nfzbHC+1ZGT8GkxA5cxlFqmQng5@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6qFvXMfM7btW0X46rWtvDoTR1SkatW40xRxCCQcXrVPjMUQeg
	PKGaxisIErvvU8/OD9cUkaLYi6WRP/yzEYoIKA+rAZhN4qeqUKOD/Lfrd/OnHaSfCEHBZ9CPf/b
	JVlhfgHvXJ4QPaT8XmJ6QdViBvY5mqA==
X-Gm-Gg: ASbGnctzvL5pNfV5g3bChbK6/K1SbvfEvlXvRsE10kdi9VKoA3yhqqFj1katLIMhnrl
	DbqPAQG8+Hc7glRJdsJo8uhhoXKByYEgT9S4+6v7sZKrR3P+R6r2iwIUKPUOejUHTHPQM+71uHa
	wZ7lh7i2bCPwAnJB1jEeRvpd1SerYNiBxm6kgk1VRA0JRkSTEMi5dZN/RtSJ+IPcOxr4Ap35bCP
	w==
X-Google-Smtp-Source: AGHT+IGNh7UzWlxJ4Gt73kTF0hEBq6eRb2XddjaPurUJ15JVrSn+IjasAht+wTEijx0Se0nOuyBuYfDZAXewiZcd18k=
X-Received: by 2002:a17:907:7f29:b0:ad8:5595:ce07 with SMTP id
 a640c23a62f3a-ade1aa8c109mr952954466b.19.1749412542764; Sun, 08 Jun 2025
 12:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250606003015.3203624-1-kbusch@meta.com> <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
In-Reply-To: <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 01:25:05 +0530
X-Gm-Features: AX0GCFs9xe5ni6Am2N_20PzQkxb_CdjA_46QNUL-7LzyYRW0ZMOxdf7ydcfl8xU
Message-ID: <CACzX3AsFG-aORqNM0oV8TCqotCvnR3fdQD9QvzLHpWFWeYVo_Q@mail.gmail.com>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250608_125545_069894_451A566A 
X-CRM114-Status: GOOD (  13.52  )
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

On Sat, Jun 7, 2025 at 6:25=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jun 05, 2025 / 17:30, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Get more coverage on nvme metadata passthrough. Specifically in this
> > test, read-only metadata is targeted as this had been a gap in previous
> > test coveraged.
>
> Thanks for the patch. I ran the test case on the kernel v6.15, and it pas=
sed.
> Is this pass result expected? I guess this test case intends to extend te=
st
> coverage, and does not intend to recreate the failure reported in the Lin=
k.
> So, I'm guessing the test case should pass with v6.15 kernel.

As Keith mentioned in that thread [1], this test can catch the issue
only in the more unusual or corner-case configurations.

Additionally, if your NVMe device is not formatted with protection
information, the test will exit early and report success, as the
integrity path won't be exercised in that case.

[1] https://lore.kernel.org/linux-block/aD-J9mzq_bJe26rD@kbusch-mbp/

