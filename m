Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0A3D46BEE
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4E3/cI2ff13Nq+m47QYVkwCHRa6OfvjvBseA3qycb8I=; b=Lj4Ma32GeImlSU3fhte9ZLa4bg
	OOdjflNcTF8svb5jekPGiq+f0havWBJdLiprkW1BN1kHs6ou9gghJjV2DbvGbs8widR6Vz8W7WJHt
	uYV43JZJZOBT3FTwzrsheQ2xr7/2qpZjB4vQ7OcwyVSqY8cf31AT9sV8GbSjQ2DVJofIxVhoN+SaB
	QHGeWd14htVeSUDQNBI0vwmWEp5r9Y8PY2v1GPvTEIDGJNvm4fg1PK5r/Hb7RDJ8a5+nB+o2xxXlw
	zzl03RxyrTe0HwyPsvhpvcCtiHtm067GHwZxi3mJH/PTPUW57Rmv2bMTcVf1JXskxuMkOzkpapDKs
	/iymTLGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlAXP-0000000Gdan-0J79;
	Wed, 28 Jan 2026 18:45:11 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlAXM-0000000GdZv-1Sr2
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 18:45:09 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-794265fb73bso1726707b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jan 2026 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1769625906; x=1770230706; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4E3/cI2ff13Nq+m47QYVkwCHRa6OfvjvBseA3qycb8I=;
        b=0MeHm0RNGVJIFnCkBPFl3esRAJA7A9yJ8vGh21FJSUSYxluNmxYoDls5bQUDtr7ir5
         KKEg9eaKEKz7Zthi6dqMC74l9Wkp0IcKE5fkgqdanuAM5jryTFnDvoWuNyvyDJ7k20xp
         0kpQuB9cAnSAaVjOR72bNUPtxdc1ZrOwSdFt9jhVM8Oe0B7FwWtovAny+g5yxKRMGLhY
         ECPLorAagAAR1Q7tQV9Cbjiwg+6MmLwqCxajfXhwzVm6z4OY+NGHkh45Ap5Y881bKAAu
         5HGuSXqJIv5WbDH6Nk32gYijpQ0V2FXoBsqlpxZx6DYKXrwhbuwGeVdHk+4ZVmtaADi+
         zKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625906; x=1770230706;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3/cI2ff13Nq+m47QYVkwCHRa6OfvjvBseA3qycb8I=;
        b=ItTwBKQ5QmP8b4y/OnR4K7BJrOzNAm45ZIbWzqFGnI5zW2ZPzQBgphT/7uLFhk5smG
         k8Mrqw+HsR/uwIr4xH5UeE7gRUc0N3cEPIFyfQ2Yapu20h3R9CBLtyJ3O8Cr+wQurL+l
         zBBNg2PvZIGg1BaeGwqMId9UTjzKxgEvnokda1Yh3untx7wtZGvi3qNkRSyJRzt8KwuQ
         hO7p0AiizzcvH7eqzFS6FpZmooV8u4BKPmVDc4imkA2e8dMtOiVoP+ySn0t6zfNq9zp+
         MLhwN8TZGXYkzepDuBEm1IP8GxWEfnKAdCdGKFKKuCc8j0oxUKq4M+bw61vVWdLv+1jo
         YsLw==
X-Forwarded-Encrypted: i=1; AJvYcCWqS4M0rYgFGbMAfP1hRihqnb+E9AA3ErZnaL1Eaki5Rp/torqghYM/0B8tiujm1c5PTzGrAakgwB0c@lists.infradead.org
X-Gm-Message-State: AOJu0YzEGk7UBJpURxVmbT13YERaDcVfnU4eq51DLtFUiFQVmPj3Zn2l
	YdvWQNRleMfMHMUwS++VUyT+bYvbYgcyVhKECh+G6c3IYdUD+ylxxCDwwibv6JT2mN8=
X-Gm-Gg: AZuq6aJn7g0amX7MmMuXtb7Vnzsq3SjXqo2d/WrkPwlb9Jnqu69h39MtC3sUMH1VvAp
	FiVY778kXkJrQSxS4kiNNCDALfZtLcLwquSgPF2ooQAJwyYKtVwKxsJ/nHvp8s3ZLA2dzDIZmb2
	UCg9TIxJhrGI3SnR2ZspDwve/vh8PqjjclMDKquYBn5bnoojUMHPrSb9nUjxXWoG9ceT1/t7zmZ
	j/0VR6MrSvCUMAdoNQAN+UhLaerSI6g+eJoyDJuN9Ei93xwF9Tcjr+qVeQCvChIZDYXj0MYs0s/
	KBcN9nkQPvdU0FSrU/c4R6HisoK15R9IWgFl0g+l06IxLZGzbuZ0+WWTUYXJSsPQw9tOM0/ynWc
	EjH6AMGdvGwS+n2y6casKl2QbXlW0OfDe56tB1qPTWcZnMIWMbWTJTErNFbjuSAs0s7TOtPCAqr
	t3dyXDE3o7OMOxeHkVq+4qbuLS98uGORZelrOjJqyukCGu0VbqRQd4Tt61SPwgKrDXd3OHS6BC8
	oQrEPx+utWXau01x2TW69XcQwbpow==
X-Received: by 2002:a05:690c:2010:b0:794:29e6:791e with SMTP id 00721157ae682-7947ac921a1mr38503337b3.64.1769625905638;
        Wed, 28 Jan 2026 10:45:05 -0800 (PST)
Received: from unknown207bd2cf251a.attlocal.net ([2600:1700:6476:1430:32c7:2b13:eb34:a3c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482767fb2sm14313737b3.6.2026.01.28.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:45:05 -0800 (PST)
Message-ID: <aae4cf37afbf84ca8ac192acccf984d10d51dc2d.camel@dubeyko.com>
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Slava.Dubeyko@ibm.com
Date: Wed, 28 Jan 2026 10:45:02 -0800
In-Reply-To: <6d648dab-fe05-437e-be25-6c026302322e@acm.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
	 <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
	 <5273400e-5cf8-4d70-a85d-accfb2977d8e@acm.org>
	 <fcd8fae5950ea5888eab5279fa3ebcad1d27bfa4.camel@dubeyko.com>
	 <6d648dab-fe05-437e-be25-6c026302322e@acm.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_104508_672025_E4157CE6 
X-CRM114-Status: GOOD (  13.79  )
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

On Tue, 2026-01-27 at 11:11 -0800, Bart Van Assche wrote:
> On 1/27/26 10:03 AM, Viacheslav Dubeyko wrote:
> > So, frankly speaking, currently, I don't see the generic technique
> > that
> > can work for all LFS file systems.
> If I change my topic proposal such that it says "some LFS can benefit
> from copy offloading" instead of "all LFS can benefit from copy
> offloading", is that sufficient to agree?
>=20
>=20

I assume that your approach is based on suggestion of capability to
move one or several physical sectors as it is in background and, then,
correct file system metadata on new location of user data (or
metadata). So, you need to do this as part of GC operations because a
file system uses Copy-On-Write (COW) policy. This file system can be
LFS (log-structured) file system or not LFS file system. If file system
based on log concept, then we cannot simply move physical sectors as it
is because we need to extract valid blocks from the log and prepare the
new log. If we can offload this logic into storage device, then we can
use this approach for LFS file systems. Otherwise, we cannot talk about
LFS file systems. If file system uses COW policy, it has GC, but it
doesn't use the log-structured concept, then we can use the suggested
approach. Because, we can move physical sectors as it is in the
background. However, if file system uses compression or encryption,
then situation can be complicated again. Because, logical block could
be smaller than physical sector and some metadata structure needs to
keep the knowledge of the size and location of a particular logical
block. So, again, moving physical sectors as it is could move the
invalidated logical blocks.

Potentially, it needs to talk about COW policy and non-compressed/non-
encrypted data? But it limits the approach significantly. And real
business case should be ready for compression and encryption.

Thanks,
Slava.

