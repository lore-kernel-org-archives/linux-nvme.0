Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC6E8FDC8
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ew4Dpo9/ZrqSVMpqgjbL/jLnSFae5vxwMPK2mEQvu18=; b=JHelD+fsc5Rw9bCEyhT2hG/zMe
	aHh5JG39f8k44JS9jZ/chjszX7NMLIqlnVwQPnsd5yZmCBuqVdapMBcQL8B0SzaWApFxY7U12O3gR
	FcT9q9uBYQmVnKQMBnT/op1P3ajMr4QCh7jD+N7krLSnMT0zTSKxUMmj3T7Y7X7bVqo1Zsyxtn53k
	BUkain/ByPkjGSsZIWzJRHXAACjSgO+S1tMWmI+Yg3EWOHu/n9wk5jTbFZqpXgXw14SjEjQjef+fi
	zuwj4EqrUf4EdnMSHzegOalT71Uw5tU+pGtqAS5+rNk0GfYDN3s2kjQQksKPRhDKHIgSsdpEkKI55
	qx6l7pyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoLPg-001sYB-0p;
	Thu, 05 Oct 2023 10:17:00 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoLPc-001sXI-0L
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 10:16:58 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-327be5fe4beso770631f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1696501012; x=1697105812; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew4Dpo9/ZrqSVMpqgjbL/jLnSFae5vxwMPK2mEQvu18=;
        b=C7DzQlUp8qtC/e9FrPafBAI04dMwhjJBBnEI0Rme5UYNTm7eIjYDGtGc6UM6bKhhyR
         5OEBnl3C6rDxIQCOlSLAE4epvEZzuuVS3clLNMKdYz+DXHz2CTZeoTYbWFR0bXNwlLZ3
         BdfAMGDzVcdqqO+rP/aLOCGkcgPU0E/Rsmkqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501012; x=1697105812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew4Dpo9/ZrqSVMpqgjbL/jLnSFae5vxwMPK2mEQvu18=;
        b=HiQNGADUyr+Yg37m8pnHbUDWXXfDQtxvCh9IhFBwAtyS/qLq/H2/bbcHPHtBhVO7PK
         oZs+TsSBRtcZBwySVsRG9MtQYVkUgSNwW777S9Q3a1+Au/6ySMXiHrb7omh2OkTaSptS
         GLFw4yZBK6gwE2amR6A7jypRongFn/FC4X4WmPO6FIDBREsFpbq7QI2JAZIT67EBVAnW
         ULEZ71ehlAW+ri19+m2Xu6q8mPnj84UItTGl888SuRGqEyhVF2yIfoDCtdFzKaim4WML
         w4r6gKIj210aG6tegVrjWF/xG23kuKGzum0CYRPt2iFGSeZMe8xVU+8usf27SmIUWSp+
         oCdQ==
X-Gm-Message-State: AOJu0YyYlnhrZahmtKVYS4e0tLp7OFJsGC/Tz3wHLdI5noKaTZPOzdl5
	7wiXtO+RqUvKOgnEW1AA1DUapnJfPS6TrGP7fRqFsA==
X-Google-Smtp-Source: AGHT+IEhouc/P6DLk3T5uDxrwwvS9EvhbOc+QY4+gto8sl2v/sAG2dwgNRDy68x2aiYnIZmfO/yO5Tyq1BLXH3oMOFI=
X-Received: by 2002:a5d:56ca:0:b0:319:6e74:1637 with SMTP id
 m10-20020a5d56ca000000b003196e741637mr4178385wrw.27.1696501012552; Thu, 05
 Oct 2023 03:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
 <ZR5y+2P/NQ25/Rkv@infradead.org>
In-Reply-To: <ZR5y+2P/NQ25/Rkv@infradead.org>
From: Mark Syms <mark.syms@cloud.com>
Date: Thu, 5 Oct 2023 11:16:41 +0100
Message-ID: <CAPYKksVJgr+XJUe5kFQq7T59Hn1ELvK9nLsz9re8UwvwPRY5Pw@mail.gmail.com>
Subject: Re: NVMe fabric multipathing
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, Ross Lagerwall <ross.lagerwall@cloud.com>, 
	Andrew Cooper <andrew.cooper@cloud.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_031656_175240_9CA308E3 
X-CRM114-Status: GOOD (  22.71  )
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

On Thu, 5 Oct 2023 at 09:25, Christoph Hellwig <hch@infradead.org> wrote:
>
> Hi Mark,
>
> On Mon, Oct 02, 2023 at 01:22:59PM +0100, Mark Syms wrote:
> > We have a requirement to report information about the status of NVMe
> > multipath controllers on an NVMe over fabrics deployment. In
> > particular the total number of "known" paths and the number of
> > "currently active" paths. As far as we can see right now, when a path
> > to an NVMe target device, when using Fibre Channel, is blocked, all
> > local information about the affected controller is flushed leaving
> > just the currently active controller(s) present.
>
> What do you mean with "blocked"?
>
Made unavailable for any reason. So failed switch port, failed HBA,
failed SAN controller, etc. We've been "emulating" this for testing
purposes by unbinding the PCI device for the HBA on the NVMe target
device but I expect the same happens for any of those reasons.

We basically want to be able to report to the end user something along
the lines of

* Multipath active, 4 active of total 4 paths

vs

* Multipath active 2 active of total 4 path

(and variants of that).

For SCSI based storage (iSCSI, FC, FCoE) using Device Mapper Multipath
for the multipathing this information is readily available from the
system tools (at least for paths which were present at bootime or
after a rescan) and shows active and faulty paths so that the above
style status message can be produced. With the entire NVMe controller
and all knowledge about it seemingly disappearing without trace it
means that to achieve the same results we'd need to track externally
how many paths we've ever seen (and some way of uniquely identifying
them, traddr and host_traddr probably) and what the current state of
those paths, at least for any which we've seen but are not currently
present. Doable of course but potentially a bit fragile so if
avoidable that would be preferable.

