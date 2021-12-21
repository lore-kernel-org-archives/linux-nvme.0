Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B32C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8jE341W1QQCF0BMQ3eJhnwqfyppjUpPG3Qf5Do/V8U=; b=nY5osu+cY/nhIePKeCFKgdCVkG
	OwkWnkFu1KSoQpWVr7iFB1pY3GcG7+XYF5xnLsEpXdR9QXhNvN29q0te+5nFiLdRd/1g8sdMzf4A4
	9gx897w1tD8GtHH2PY6id1OlITp9wZSpxD9xcmzIolpSqerFhU7XD5a/V8Mul5hedB6Ruki2aeMzb
	nljuz85VckCwR+Jp+zxIomWkqjve0rTmqRJxXXyM/jWUDaBfNcS6R2eVdaTmeurm9FT4gOTeAjAQg
	zpZsKa0ph1asG1wWJFhGngeNFbZzvERg1ZEGZuaanpALUYAFjngHs/cPVUb9eH88MkttjfJxx8f6A
	ruJEUu1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzgFs-0079nk-Ia; Tue, 21 Dec 2021 14:36:40 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzgFq-0079m1-6k
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 14:36:39 +0000
Received: by mail-wm1-x32d.google.com with SMTP id y196so9203851wmc.3
 for <linux-nvme@lists.infradead.org>; Tue, 21 Dec 2021 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F8jE341W1QQCF0BMQ3eJhnwqfyppjUpPG3Qf5Do/V8U=;
 b=aMMNumUWJ2GspzR9H7HL8OHX24m3PjWiiZALtkmyuV/NwBwPeJkiabZTjAJFa8Jts1
 Y6XRpXOtkdLVwWHz4Ulr3ADIFYuguTyxgv0U1XEcJpbfIye8rChxOrKdgQqwsMTZIquc
 1qdz1uGtMxcNegoJX93OpE2evYKgj/4McOKPfDEEWDzSXI7HkSuFEptssWPy19stcsEV
 l1VwxE2FqbxK928T0q1VLmKIjJOPmlkypOdVnDcQ7k642w0vUjn1fsET/Pt/LFjm4jTk
 wbScW/6FXQXnwnC6ImLa27KPTyMhuMfnk2HMmoPDyNvaLIMbOWsn5R1f209OWa9NIlVR
 kBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F8jE341W1QQCF0BMQ3eJhnwqfyppjUpPG3Qf5Do/V8U=;
 b=lgNwFPZdK7RZDjwu5xlYhytSo8NP4np66kCU2s1BmW05pWUlmDv82GaA9kk9Hr0wTE
 bmgp5AWKL0z5uQ9jQKZwW/eZhQfjSX7B9lpBJ/QI7Q3ZNe0btA5biFHmtCGvpBFqMBCa
 KwF9zqG+amcOMsyTyyI0dMZGKnVpEqBAqIvRJZLAFu8l+l7HfuwHFylSRxCyIPb1Xlpz
 M57cYftrpxWFaSwHFDKyCZfbA9fp0TLuCytPG8Dv7KohvB4fNoCKm90Pny39wNIiEGVT
 VojtE1L8BL8aZLGtDA19pg/eFaER3U0qjzbLSTZsuDJKqRCvlTiB2PKNnIZDhPC8LwRK
 zKUw==
X-Gm-Message-State: AOAM532P7Mdfjygc2GvWOIe1uJLb1GYavVr8bMZzumpO6EW8bfa29/w7
 npSDjpr/77WcVYOViNdxzJgjU/d8rbnQanH5Bw8=
X-Google-Smtp-Source: ABdhPJw2ot3ksVw/7/w8W0CmFimLGIIVFfgp6GBeisB2DF0ZfUzjgRLBY9u+5+T45uafnTRz85S/Cih44Yemw+cl5Tw=
X-Received: by 2002:a05:600c:34c1:: with SMTP id
 d1mr3060392wmq.139.1640097395684; 
 Tue, 21 Dec 2021 06:36:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211220142227epcas5p280851b0a62baa78379979eb81af7a096@epcas5p2.samsung.com>
 <20211220141734.12206-1-joshi.k@samsung.com>
 <fca4042f-6f44-62e2-0110-89c752ee71ea@kernel.dk>
In-Reply-To: <fca4042f-6f44-62e2-0110-89c752ee71ea@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 21 Dec 2021 20:06:10 +0530
Message-ID: <CA+1E3rKozJSTx1e6arz28VfqUkDJzy4dA+todrYrSZpCV2-Q4Q@mail.gmail.com>
Subject: Re: [RFC 00/13] uring-passthru for nvme
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 anuj20.g@samsung.com, pankydev8@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_063638_277013_459F7892 
X-CRM114-Status: GOOD (  22.33  )
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

On Tue, Dec 21, 2021 at 9:15 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/21 7:17 AM, Kanchan Joshi wrote:
> > Here is a revamped series on uring-passthru which is on top of Jens
> > "nvme-passthru-wip.2" branch.
> > https://git.kernel.dk/cgit/linux-block/commit/?h=nvme-passthru-wip.2
> >
> > This scales much better than before with the addition of following:
> > - plugging
> > - passthru polling (sync and async; sync part comes from a patch that
> >   Keith did earlier)
> > - bio-cache (this is regardless of irq/polling since we submit/complete in
> >   task-contex anyway. Currently kicks in when fixed-buffer option is
> > also passed, but that's primarily to keep the plumbing simple)
> >
> > Also the feedback from Christoph (previous fixed-buffer series) is in
> > which has streamlined the plumbing.
> >
> > I look forward to further feedback/comments.
> >
> > KIOPS(512b) on P5800x looked like this:
> >
> > QD    uring    pt    uring-poll    pt-poll
> > 8      538     589      831         902
> > 64     967     1131     1351        1378
> > 256    1043    1230     1376        1429
>
> These are nice results! Can you share all the job files or fio
> invocations for each of these? I guess it's just two variants, with QD
> varied between them?

Yes, just two variants with three QD/batch combinations.
Here are all the job files for the above data:
https://github.com/joshkan/fio/tree/nvme-passthru-wip-polling/pt-perf-jobs

> We really (REALLY) should turn the nvme-wip branch into something
> coherent, but at least with this we have some idea of an end result and
> something that is testable. This looks so much better from the
> performance POV than the earlier versions, passthrough _should_ be
> faster than non-pt.
>
It'd be great to know how it performs in your setup.
And please let me know how I can help in making things more coherent.

-- 
Joshi

