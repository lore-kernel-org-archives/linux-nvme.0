Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E0DC43458
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2026 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OoHfKViv96Cd5dk2dx1K0qDipK81ZDFw1ZlAuoD6eRA=; b=j25Ik5B+Gor7mRSYh+10K2f5AV
	0/VDpUFP1kWMsKqk6eD+f2vOhLR1aSdBrqW2+fp9a7LclzaP+kimZ0PAcex3RaIzQgTjHGUTCTYIX
	Y5tTeomgWXMIS26gyduX2Cv7RwDPZSHRZuTeHEDDDLMdeQstqUR2ChMCJxi3VKyNbscWPxXrbsDCR
	i4NVq+K71cgSye7p1qDBFU8pmRoMmPZRdCS4PHxquMDTWZ7gRWWX6sqZ1uTi0WaX0GLDm1UxCcaWs
	E+FjZ3+xFxHU5bDpF1vAPxniH0/ZIVvPSRaKc7Db04B7xKDZenFh9EpQ+5+TktJLgVn86kVnO06o7
	MmoNnEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wifkN-00000006vXd-1pnv;
	Sat, 11 Jul 2026 22:00:31 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wifkL-00000006vXI-3AOF
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jul 2026 22:00:30 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-84a2c90e383so71044b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 15:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783807228; cv=none;
        d=google.com; s=arc-20260327;
        b=NTcGJFk0xHej2yAh1mXvO0sCCaIrluiMuA2+q86u8qxp23ykAeox/e9pUvBkP3/Kwm
         3cccKKghSabhAXVXguduCmokjHd+6cGPL7FLoqkLikXwDaddLrJnysOQaD8Qn/Idx5xH
         bkPbWFE5YTMVfuuzTPEAsyxr8CjAL2m7ltpVMlZmzfdkvJK7KAzvrC0HaWF8XzLW7qA8
         FvxTY3x4JUNcZol+t6HtPTrdNF9gU1Cbu/Zx2+sfkQ87rv2zjtijtOPmw2pSDfQ/A3fT
         qwK5jaDZ1w6SxzpI1c2iicTLW0+iohIs5VmY6fBKmXEq8VYPQL0FNVWbdp9UMjnUMyj5
         c12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OoHfKViv96Cd5dk2dx1K0qDipK81ZDFw1ZlAuoD6eRA=;
        fh=unw4ZMiNMo9siHivfvkoI1AXDaPn5oEWRzJhQt5Ht0Q=;
        b=jKmp9JASbJzphbFHIMtFExkAABtPNqpF5x3PijVyVBPr3zfvMu1HbwX7YeXgSs7N30
         Yjy6npZOkX+XCXJfqmRUw9YcGNtbo0HjGcPPZytDInX+VqpBZNgYo0GaRQ/Vst28m5Mh
         9Uh8lGkfr8Smbwk4LkZseCNzfZbyEsN0jMwPHKVIBlZG7f+m305OndJU6eP57RrRS1JQ
         mcKUEHkKHYyWKw3wzECTHzD528maTgpedob1u9f8foBqGCXFWEqvhgpiNi4R8gI9VGr+
         yfATrfVItgbsUt4LWX1cFUbKGZld6F040BCbuHAnRfwoKkL9yMWvQQMRcsRyqMD8s9S8
         W+Ag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783807228; x=1784412028; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoHfKViv96Cd5dk2dx1K0qDipK81ZDFw1ZlAuoD6eRA=;
        b=E4FiEXN5GXKrnMhYI4ZhOQuEjIvgarJnQoKHQjjTHoV5MzJ4svkimCE5FdFqJhiQCH
         uw/1n0wODtbxL+xOJO5mQC5sWj1YKjAO4XCeimL5NfTEkLqIOeOxF9CGFWsoWVUv8riC
         s/+NnrItb9agQrl6b1HoJUl4jDyJaLIe8xwZ0gzML7mQCrA/VnnFBwQFVCmDl4a/NcH7
         XK+XuypSj7KELsMLsFO0xrorOsiFWW9JZ+dsBoBGqZHKuyJwLgcYu/zi7R8Qmnr/YHLt
         R+M1kQpAbmi2tS1bbTk1aEU6nC+i8Ugn/dGfTbfloMdZ7qHy3eTLuH67uNESi4T53hBo
         EQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783807228; x=1784412028;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OoHfKViv96Cd5dk2dx1K0qDipK81ZDFw1ZlAuoD6eRA=;
        b=aJLOQHIX4VD8D98y+RWolNy3DXAhMBQR45zhr/iZC/EVBijEJuXjQbFJF/zwXFjivl
         8jDBYx0HOBHk0oWdNlCylDVTQn3NCwrJjSLmFvQj91B7R0mzcjX1Uddcxw6WfB+ohtGY
         Jy6ObI1f42BMt9cOIbrFjhUEwuAiQcmh8e/xDfLQZcJtm50rJ4mZoCB9vv5OfL/PGR0A
         xIyX03hOXKjotJzASP2Zy9rle6MkGAC/wGk2T8LmNgM9pZjLgc+Ho4GLfbrxYp9nbKvF
         PGGgM6t8xK/yorMZkxEVRCX3jaj3gACaKjoXVy1vtZiFdWQk26vgClEngxGjUXJWHi0t
         eL0g==
X-Forwarded-Encrypted: i=1; AHgh+RqsX/tvb27iipg7xrDFr8vl4GDbzX2ZMx4Pzn5hIEIfsuo6Sfb9NOkxkluMFgEby9Wf5piAqRO8RUZ0@lists.infradead.org
X-Gm-Message-State: AOJu0Yyoi64LEQevizMiQy39m2uGeEbY6dxPrmYqxhRKnW8tTthwnQf9
	smI+HPND3ZFBOWF7rsJ/AdcoqWW4wv8sgcsHxGgZ335TVQxjhpba8+s0bktfxnhrwc9IetmScvA
	TKNXYgg2wgG5HOeBbTH86mZd9x+vG0U+SXKAPKZ7s
X-Gm-Gg: AfdE7cnjox95oJhqB5EjfOdaOXudddLL4Km+VEi3uISvX983GkUc+GCb7JjiHTEcgW8
	qB93sZizRuDhr7HtbwAZBpjGcGgPpoEMwtqcEBGqDbEmONxHHwEZwwXuZJA1NT7xZu8NO4d6mEb
	ySRP68zHOLzeN4v7S5NdGwJmcrRxEvIY+J9fcy/X0I7jaP9cPRietJGSGodNZgH0gce059A1W4B
	Wf/M2o6VWKxhW3n7DPMEYpJfiRjBoFRTpOnzDgWrgfwz6Ysw1uQNtMlJG4j1ywcwXmst4XdsA==
X-Received: by 2002:a05:6a21:490:b0:3bf:b625:5bd0 with SMTP id
 adf61e73a8af0-3c0f08efe2bmr9873396637.9.1783807227204; Sat, 11 Jul 2026
 15:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-15-nilay@linux.ibm.com>
 <20260709063020.GC18056@lst.de> <1e72d8d2-ecfb-42c8-9ba4-97cf70f8b70b@linux.ibm.com>
In-Reply-To: <1e72d8d2-ecfb-42c8-9ba4-97cf70f8b70b@linux.ibm.com>
From: Marco Elver <elver@google.com>
Date: Sat, 11 Jul 2026 23:59:48 +0200
X-Gm-Features: AVVi8CeYiGAvVjerxGFsLJPavUOx4WUoapX8FeHJ67Z2vQywhrQw3Mpo5oklosQ
Message-ID: <CANpmjNMckikjJUdTT=ugs4pHMTOOQ+9mvSWZG31BGU3EFvRU1g@mail.gmail.com>
Subject: Re: [PATCH v3 14/18] list: Permit context-unguarded access with list_empty_careful()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_150029_849133_02E09D1B 
X-CRM114-Status: GOOD (  24.83  )
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

On Fri, 10 Jul 2026 at 10:10, Nilay Shroff <nilay@linux.ibm.com> wrote:
>
> Hi Marco,
>
> On 7/9/26 12:00 PM, Christoph Hellwig wrote:
> > On Mon, Jul 06, 2026 at 07:44:16PM +0530, Nilay Shroff wrote:
> >> From: Marco Elver <elver@google.com>
> >>
> >> With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
> >> that are __guarded_by(..) require holding the appropriate context lock
> >> when accessing and manipulating them via the list API. Because Clang's
> >> warning diagnostics do not perform inter-procedural analysis, this is
> >> enforced by Clang with -Wthread-safety-pointer in the caller at the call
> >> boundary; a warning is produced when passing a pointer to a guarded
> >> variable without holding the appropriate context locks:
> >
> > Same thing here, maybe try to get this to Linus late in the current
> > window as it's trivial and makes dependency management much easier.

It's not a bug fix, more of a feature, so I don't think this should be
sent in a post-rc1 PR (and Linus would likely reject it).

> > If that doesn't work, move it to the front of the series.
> >
> Would it be possible for you to send a pull request for Linus directly, or
> would it need to go through another maintainer?

Needs another maintainer.

> If you're able to send it directly, we also have patch 09/18 in this
> series that should go to Linus. In that case, I'd suggest including both
> patches in the same pull request.

list has no de-facto maintainer, so anyone could take it. My guess is
it could go through tip/locking/core since it's related to Context
Analysis...

... alas, this is more complex than it needs to be, esp. given it's
borderline to get this merged post-rc1.

> Otherwise, as Christoph suggested, I'll move these patches to the
> beginning of the series in the next revision.

I'd just move it to the beginning on the respin, given what I said above.

Thanks,
-- Marco

