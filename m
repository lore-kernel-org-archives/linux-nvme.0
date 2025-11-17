Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B1CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h346Ou5INwYlAuZ0uhkL+2Ei0mYQguarg8r62JVFdCg=; b=3ncgcO3q6/qnKsH3y3b6DbEgjl
	DKFYluNFcUetisRScoAc9VHLYyix8hRsbrMmSCbwQAF/6LM5qImbClrcpr+mBdjZfnLNSbqyRX40D
	N7GMVT24fZoEUon//Z8nC2hN+j5lGlM6rBfphyTZ4zOxCi1m3md0PpGCehVUxxLGG1BKWlfSmdvgO
	HpqlJHKFx02x90WEeucZgNQhn8pphUugt6ThZRP8uyX3Fu2cj4h0p8I+rL6tMK8VM9/nZA0YsFIOP
	lp9JZX0K+2F5LgeUTKYFfVhxprwplxaYkrqx5SUgbfac2239APGxU7ZukMT4pqi9kcuF9+zjVX+WB
	0z5nyLhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL8Tl-0000000GzoK-3E73;
	Mon, 17 Nov 2025 23:17:49 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL8Tj-0000000Gznv-2xst
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 23:17:48 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-882390f7952so50678276d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 15:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763421466; x=1764026266; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h346Ou5INwYlAuZ0uhkL+2Ei0mYQguarg8r62JVFdCg=;
        b=JhALJkp5ZbHpGxe6LsHIpnYKD6DqLXNFEr06JYnj8yURnJwXHzGKprJdexBYrf9kqR
         IK79M5Ph2XqFXlCabLS++LvM012yu6WapgdydrY0OUFIKWAql/J+Dc8UHqT7ZFGAIEVN
         kaFkq0WJZnGZua+lPNrgtP3NeZ9AYpzpX7orrg7FZGuf3PvNEf10ze6s/YOk+ccmNgFJ
         ytffiTedXvhMfrjAhhbDVlWyF3zNkwu2TxswG1czld4pNkJSlAsDh/IiBuewbgV7aJ7V
         OKV011weOXYej/l+2LlzEr85WJWk0DiaGSf11EYfVRe292zWoLHxbp5xo/8DANSUkvO0
         RgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763421466; x=1764026266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h346Ou5INwYlAuZ0uhkL+2Ei0mYQguarg8r62JVFdCg=;
        b=fLdsIvBPH6P0Iekku3z+EWzGXR1DCUG60e/Ne9Oaz0CFO0NJCZLeGSqyjK+k8ZtzjX
         0Pt80crdTTsw4bjlrPGtiLhEJgllHHRfOoGTRfC20uoKeA3ylgHSD53bNSGb+4DkmXUH
         ygGIEuGj3vX7QpxuEhAiThJrGFfqVl4P75S8buOf3exPuJxr+YEk826Q19bywoiplx8L
         C3iSOIwu4k5oS8okzrNFtBrCyKB+LrpNwXxfKM2yWIQXcL5bOAvZQGTjF6d5RJMSGMOI
         /N8LYHJwsF8f9zjGBvnPiJv64+BLsLOo6nbiuToDht2zcSonSEaevK0sORa7pe8beeRP
         Opmw==
X-Gm-Message-State: AOJu0YzLyD5QtofZHsrSATHKN/U8dHKjmggG5YVEUk80ytLDjdVO0ECS
	mIAP6CApPOB8EIPtKMYiNUKj8jjmwFLeSravl5pyoxpZ76UKSi0fo5ScEATmA0sRgxrenTjiYd5
	m+QLr0ee63EyeuCm34NuAwQ8r1pD9dp8=
X-Gm-Gg: ASbGncursA8MU5VO9gPWe4I3wUWg1DQLTaziHRc055+XprndBBSkFOzYyYPQFlV+QSf
	KmfBVaohyMkC2zFvKsB6fMYnYKhvL1BYr/y3S3FCOjlUL2Vhap25QWCbbLMvjoPixgV2N/WIfGQ
	OmcroZvN+fi166+HmjydbRxcDcJeIJsKLsfXPZ5sVy4l5HkOSHpDmYTCcUvcTA6khnYzg87i7+t
	puccB6qBp+J8kPfdRUctNalmqv+lhSZMNhU5Sigx+5MDPFwBZLXbKdNxBaW3noCZWQJF2xpNC7j
	5ZW6/sv0cinJL9IhOg==
X-Google-Smtp-Source: AGHT+IE4ahfh6rwy82UH13vLsrBf45qYUCW0bRpIcvjHAyFl1Lbr5vb/2nT3bOJZnXc0BH/DbrXvkW07bvJ80l3B9oU=
X-Received: by 2002:a05:6214:1c09:b0:880:627c:fe12 with SMTP id
 6a1803df08f44-882925c575emr214281546d6.4.1763421466462; Mon, 17 Nov 2025
 15:17:46 -0800 (PST)
MIME-Version: 1.0
References: <21255200-a271-4fa0-b099-97755c8acd4c@work> <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work> <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
 <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work>
In-Reply-To: <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 17 Nov 2025 15:17:01 -0800
X-Gm-Features: AWmQ_bkFm9rgaXy2OiFlsEOy0lGrDG8zF1Sou3BHOEwE4tgjHEi-LdvHCksnYY0
Message-ID: <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
To: Aristeu Rozanski <aris@redhat.com>
Cc: linux-nvme@lists.infradead.org, Ewan Milne <emilne@redhat.com>, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_151747_748883_458A7513 
X-CRM114-Status: GOOD (  10.14  )
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

Hi Aristeu,

> But like I said, I never managed to reproduce on x86_64 and we had no report on
> aarch64 nor ppc64le. s390x "machines" have 2 CPUs, maybe lowering the number of
> CPUs would make it more likely?

Thanks for sharing this information.  I have logically offlined the
CPUs on my x86_64 system down to 2 CPUs and have reproduced the issue
on x86_64.

Broadcom will have a deeper look into the call trace and will report back.

Regards,
Justin

