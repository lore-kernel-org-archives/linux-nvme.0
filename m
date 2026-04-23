Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63262F99368
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=; b=EV7HxDls4X3UvrlAy+3kUHpNJ3
	R5aRxzgBTAzodfiHCI172l7p3FqFybUmAa247Z5K7mcb1d3J8rfX7daAhTZZN68HY/AiAKH9HGap/
	Id3Hf2wH5G8944Vi7+4dnTcccnu6NCBCcsVY3s+PqbG8aj1hX0DMxrlSzbT3fFhKlxLwI+mU+nu6J
	6L/3yRSKwNpKbfPrCStySTzySQtaqmurkp49v83jeBf7COt0EKzRJaA/juvobFUPFW5/589aukyMS
	+AOJ0dzHJcd6w+aSkRtV3L/qHVEb2Rd4if6Et4uJH6u7xtCm4fG9lljxUQ6KrmghNrwLnwlKT8oAT
	28BTxRvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFr8Z-0000000BT1j-02ck;
	Thu, 23 Apr 2026 10:18:23 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpAH-0000000BD26-2JHa
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 08:12:06 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so61615791fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2026 01:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931919; cv=none;
        d=google.com; s=arc-20240605;
        b=EXGHJUKeBCjkbuUST7WFelKLh0owv5GTS85VcJaHj6S+uZTADBRi4CRnuZgB6uiw8B
         juN4fkNT4n4urqXP9wkcf8sTI7g39ZIOaWJkt26TchlL8Ss0OxjAdqpBfXS+5nAXQ2hy
         hR7bo7ec0Zin7OrPVyNXnUEAQ1ZHSjXVHjvFx1OCWRB8VffjCz7Qst1enYB+xvNRGGUY
         w/Zu0lWo+ndDETWP1fykM3bXLixdNqZUCHcAVvoIjALihM2BANVAOF8D8GlFV1v0YmTU
         WnRhuZgR11/41R+pUwfUNdW8Ve+1jFg5fL2LpqAxZrFfW5huQu6izx2Fwf6IGAhEYzCA
         Daaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        fh=XGdWr2StH1arRrvPpi4iBsG4syj24V2bF18vF0M7Cos=;
        b=HAQMkfl5U3ZijAjFAML9Aa7Twg8az/gSh/2h5VY/zyTSlqti9IMkKr3emCv8idlGFA
         hCxcDGE4iRnQzx6M/qinlF4D5uz4OwSGXdr1Ph+JjN6cs5ncIxDTButAwmTa0gjoqVrQ
         LD+KCW8gjnG2GaqckBK/0wgU0CauZ3pKk4mw5P6wp9BXF5MQfjjQIGp2aBfzE98CFW9B
         S2a/vFJOqQdabYmBCv4VuFzu4zFQbqeU5SifvqdcxUu1TaNPO8EZkmOVDSXtCsMApBlT
         pIxhMSbbk0GJAyhCd1FmZpxFsnUzMNFg7sijXhTzNr19PNcHnZ7+veqwK06BFDHVktWr
         eQxw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776931919; x=1777536719; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=gCj0Nl4xiP1BA7r7gskDbBGXM5g0fpu3sebUuwr7y3JvmRNJ8UGkYrHOye89Jd06zn
         krxRDPXKwiEp073FuJdWpGoQivp6+t7nLLYOfLEQSOBneeGHj4GapFHbRAaCX+aLYjTj
         MKjWl+hIfDc0xLxyFkY0sDg8XwxEQDKDL2RQMrAdh3Am60UubklENSwE13xxeIWNolVT
         b0BITVXW3JmerXaOhsNDVIi1FlaOq/BXaeT96cW0CwCIodoS77PGvwKUBBMApbehzJpA
         eKe4iLzRP7C4w4wkjGaCP5nowfGtBYrIVOZjmaIP0mUv4vX2ilDpK/iBvmF6mKyy5iQ5
         0Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931919; x=1777536719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=Tf6s6Gtq784brM6Cich1EeDPTgBQt1GpaivwmCBsVZ4cyZF2p2uFClVxyKkpTexfJ9
         b3PJMd97xXXt4mHErx0r6JhdoKLTP6YQ5waZ+uVwawTA5MB3K+Tq41kGqzs03J7sk4Jj
         IPvxTCv5Tybs3u4AEN4ZoYqf7eSFeYk+snaY6BeD0UluckDfQmvJKgophtJO+xwPmLHT
         OyFPFuPVirddxD+yQLhA7C6F1aU+CXzboy5jzTtRY0h8dMpTZACmhuAz4vIcZ9cjfBK4
         tXmcvbKAjgacWGsNqwzjBFLgp7uimYiD/zNi5EEUH5pw1oX666ZLYR0tcGWKwPT3yydS
         un6A==
X-Forwarded-Encrypted: i=1; AFNElJ+j4Z/tbm5jsx0/v3SKMKl1Zt7RgIgRNbuVlbpK7gPIjxEsPTBxfO6v/D183ktcKPrRtdWZ8jn8iT7a@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+OvpuwjXsFxUpT+eDGqLNlm87FrMXoPKgYfZ4rnHnGqpSGNJV
	RNU31K7Ezh8vI7eDFAL6jgzHCEVCW16phQ8cMTwlxQotBskydqn+zTJD1/5G9DRomewoIwdcGYJ
	f8DCaAdiqZpDa9wfPmjB64+cn0KVmsBEfyObllekUHw==
X-Gm-Gg: AeBDieujNTknOd/Ue6t/1JecEarL9WkF2pXUDLaRgc8XBVnBVY1P33kq6Sii+oIPtqU
	N++SgN3fvLnFcb0Ke7PTkTnnr7nC1Vp2yNXIkterqRmvd3Tj6KyoTcXPXPlrhqs1dLA+ocshEtd
	7ceAYWhMBgNp/THl06ogdp2nLQJ6csqRhVZDR65yZB6Yyx+MgIUvShJvgRA7hHvpWIgR/K9fpAX
	XjI+xLDLQMl/vVMbWvwV1TJOONrLMtL4BuF89Y5fdzEBTZ2/taMDJI8IT+6a8TarcsmXfHKj6+l
	InJFQlO6kHNUFEYS0uY43LllgS/EqO3Xt0EjnglM17tiOCrFWlU=
X-Received: by 2002:a05:6512:3ba6:b0:5a3:ff60:b72e with SMTP id
 2adb3069b0e04-5a4172eac66mr8218916e87.39.1776931918554; Thu, 23 Apr 2026
 01:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260416192942.1243421-4-atomlin@atomlin.com> <20260420131152.243488-1-marco.crivellari@suse.com>
 <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
In-Reply-To: <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 23 Apr 2026 10:11:47 +0200
X-Gm-Features: AQROBzAAJimGp24FdJwHT7vl8MEKvFnP60qRLQ-HOdwRzLvk1TNgQokO0fGWBCw
Message-ID: <CAAofZF5+igiyR8vne9We5tnfouuWNO2H=BdwWbFCN+gnpUXoVw@mail.gmail.com>
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: James.Bottomley@hansenpartnership.com, MPT-FusionLinux.pdl@broadcom.com, 
	aacraid@microsemi.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	bigeasy@linutronix.de, chandrakanth.patil@broadcom.com, chenridong@huawei.com, 
	chjohnst@gmail.com, frederic@kernel.org, hare@suse.de, hch@lst.de, 
	jinpu.wang@cloud.ionos.com, juri.lelli@redhat.com, kashyap.desai@broadcom.com, 
	kbusch@kernel.org, kch@nvidia.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, liyihang9@h-partners.com, longman@redhat.com, 
	martin.petersen@oracle.com, maz@kernel.org, megaraidlinux.pdl@broadcom.com, 
	ming.lei@redhat.com, mingo@redhat.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	mproche@gmail.com, mst@redhat.com, neelx@suse.com, nick.lange@gmail.com, 
	peterz@infradead.org, ranjan.kumar@broadcom.com, ruanjinjie@huawei.com, 
	sagi@grimberg.me, sathya.prakash@broadcom.com, sean@ashe.io, 
	shivasharan.srikanteshwara@broadcom.com, sreekanth.reddy@broadcom.com, 
	steve@abita.co, suganath-prabu.subramani@broadcom.com, 
	sumit.saxena@broadcom.com, tglx@kernel.org, tom.leiming@gmail.com, 
	vincent.guittot@linaro.org, virtualization@lists.linux.dev, wagi@kernel.org, 
	yphbchou0911@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_011201_609991_603624BA 
X-CRM114-Status: GOOD (  15.43  )
X-Mailman-Approved-At: Thu, 23 Apr 2026 03:18:21 -0700
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

On Wed, Apr 22, 2026 at 7:47=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Mon, Apr 20, 2026 at 03:11:52PM +0200, Marco Crivellari wrote:
> > Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will
> > return ZERO_SIZE_PTR:
>
> Hi Marco,
>
> Thank you for reviewing the patch.
>
> You are correct. If numgrps is 0, __do_kmalloc_node() will
> return ZERO_SIZE_PTR.
>
> > Should this check be added or it is not needed? Or maybe rely on `ZERO_=
OR_NULL_PTR()` ?
>
>  - File: mm/slub.c
>
>     5275 static __always_inline
>     5276 void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flag=
s, int node,
>     5277                         unsigned long caller)
>     5278 {
>     5279         struct kmem_cache *s;
>     5280         void *ret;
>      :
>     5289         if (unlikely(!size))
>     5290                 return ZERO_SIZE_PTR;
>      :
>     5298 }
>
> Regarding your suggestion: rather than relying on ZERO_OR_NULL_PTR() afte=
r
> the fact, I think it is much cleaner to just add the early exit at the ve=
ry
> beginning of the function, exactly as group_cpus_evenly() does. It avoids
> the allocator path entirely.

Hi,

Cool, I think that's the right thing indeed.

Thanks!

--=20

Marco Crivellari

SUSE Labs

