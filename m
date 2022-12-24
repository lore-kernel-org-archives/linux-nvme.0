Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78385C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=; b=PvyZUlsrMdMN0PyADiWzX6l/ul
	nfilW/yXf3A1SqzD37VPSFuOT1K5s2ih3acrSLcg85NWn9NX1FQlSB8LnQv3oJXgVM8bCzeC6dxON
	+BceSQGfqApM4WLlxbmGyUlh9SAObHnbDUfxwIyQYBXT4gqgn9NXRhoM9zq/LU4ACNDvhxKPQ5Xbk
	aAzZOuqP7puswK054cfs+PAaAuZZfX0KPBlGm1v60ksEkmsYGgeRNy6vDJV4hdvxqNTItv2QpTapI
	erZ8UC1plIUcod3Qx/g32+jPMOA93YFrMCD0ucJYywriCCP1zsRwqtzK3iHTHMKx4iuLPS60b6g7l
	hxTCXO0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p97pH-001nzC-Vo; Sat, 24 Dec 2022 16:56:48 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p97pD-001nw7-FK
	for linux-nvme@lists.infradead.org; Sat, 24 Dec 2022 16:56:45 +0000
Received: by mail-qv1-xf34.google.com with SMTP id h10so4981341qvq.7
        for <linux-nvme@lists.infradead.org>; Sat, 24 Dec 2022 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=eHv1mgQ5AP7oglntmJxZbKwRJLD99vZvrbBfFnrC1Jz7Ia5B1JDL0ZVdTe1ypPUTRQ
         5WCHLYSZyzzKFMghdQRAE1HIgHcXJ19GaLrYGrmqNcv/IylzDZaqSNbaWFNgXXY8isCb
         xvyY1lejoB6EYNIgNic+EwyGt+zj1OR7/0hzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpcHNwpuE5O5lhju52DhjRWOVFDf/6KjMwJeJDv0qOk=;
        b=bIFof93M8nFARMrV/kIpbzf+A74WB5fTUUKFtRVCyy5PZrOxyYClQGjb/cwKiCfiAt
         8IfRptoFSeWdcw4yxpoEQY3v83Zkk/mA8xvVSipRbD3nU3x+v0bfQiA+3KVHRo1n2QrL
         wjS/67pjEMQT/CdqIja5V6qNcS33xIT7QbjcLBg2Fwy+Rg7DNM6TKMlKMy0j3Gg5Qwe6
         +PXnuwvbiK3b77L04PF97QolPCa6qJYZ/aWsop4wP6yvoKV5krZUxQ6GyIxq74GvlZdm
         xk6MnyDCABww0cwsqe0o8T7V/xoq/JUduZjOCCBBvXYj8TJs5K6dADUArrkeB3W8Kvew
         gvnw==
X-Gm-Message-State: AFqh2krsbnw3KQhS6ExaykaQ7knx76z8sZMBGpi8qfPv7IdxxV5TZ3e4
	X2I1AuPczXnHB30/8snAJQxSVb8YWgpmFJZO
X-Google-Smtp-Source: AMrXdXuAjJwaPtFvTs3sCAmLlueqiI6DNGNIqyZggUv7NBEhD8hSolSerGicno0svqOHMPKv1d78DQ==
X-Received: by 2002:a05:6214:719:b0:4bb:a62e:c1bc with SMTP id c25-20020a056214071900b004bba62ec1bcmr33139262qvz.25.1671901000078;
        Sat, 24 Dec 2022 08:56:40 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fc2f74ad12sm4507780qkp.92.2022.12.24.08.56.39
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 08:56:39 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id x11so5844728qtv.13
        for <linux-nvme@lists.infradead.org>; Sat, 24 Dec 2022 08:56:39 -0800 (PST)
X-Received: by 2002:ac8:4e26:0:b0:3a7:648d:23d4 with SMTP id
 d6-20020ac84e26000000b003a7648d23d4mr705942qtw.180.1671900999023; Sat, 24 Dec
 2022 08:56:39 -0800 (PST)
MIME-Version: 1.0
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6amzxU7choHAXWi@infradead.org>
 <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
In-Reply-To: <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Dec 2022 08:56:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Message-ID: <CAHk-=wjVw9=Hio5pRfGW45+yL-geWfNGyPeSFess3FAZQwVJrg@mail.gmail.com>
Subject: Re: 6.2 nvme-pci: something wrong
To: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221224_085643_757530_AE62D3DD 
X-CRM114-Status: GOOD (  12.87  )
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

On Sat, Dec 24, 2022 at 2:19 AM Hugh Dickins <hughd@google.com> wrote:
>
> Regarding the awful 0's based queue depth: yes, it just looked to me
> as if the way that got handled in pci.c before differed from the way
> it gets handled in pci.c and core.c now, one too many "+ 1"s or "- 1"s
> somewhere.

The commit in question seems to replace nvme_pci_alloc_tag_set() calls
with nvme_alloc_io_tag_set(), and that has a big difference in how
queue_depth is set.

It used to do (in nnvme_pci_alloc_tag_set()):

        set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;

but now it does (in nvme_alloc_io_tag_set())

        set->queue_depth = ctrl->sqsize + 1;

instead.

So that "set->queue_depth" _seems_ to have historically had that "-1"
(that "zero means one" that apparently sqsize also has), but the new
code basically undoes it.

I don't know the code at all, but this does all seem to be a change
(and *very* confusing).

The fact that Hugh gets it to work by doint that

        set->queue_depth = ctrl->sqsize;

does seem to match the whole "it used to subtract one" behavior it
had. Which is why I assume Hugh tried that patch in the first place.

             Linus

