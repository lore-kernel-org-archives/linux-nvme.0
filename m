Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD386CFD36E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iqGO22Eo84dQQSwH69fcWPJDlu28MR6E9S1mkTawZc=; b=MgxtGUiOopJf4nQTuDbuW7z79Z
	ZaygCQTyGyQkVRGzNrFK+pD0+uXPXV/5UQ4FJuq3HgJGS8ogKEGsJdGmZxIMISxOPonzT/eFXOM+R
	q7l9fXgDLcI7NwX51+YHQwx3wLeqjuEumjMV1ndj6S2/2mWhj1iRlQ5bqossOoIKlqRMkuAMPTg9k
	pLOQIHPxIsdrUGcefJWfMkQxnfZ5wXxtHBAbBkB84XbNpzyDcwkuMjNoWJRDGJFCqkhDqZJv8/L5m
	8bPHdIllXGGy0e++uITtkszOKkpAiVJGMWOi/IjqwkdtKND/R8jczuP0IrRBFdfqD2eBpBDxmSdOc
	4xA1m23w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhNw-0000000CXIR-16eK;
	Tue, 25 Nov 2025 00:58:24 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhNt-0000000CXGr-2LpR
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 00:58:22 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8843ebf2facso69139526d6.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764032300; x=1764637100; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iqGO22Eo84dQQSwH69fcWPJDlu28MR6E9S1mkTawZc=;
        b=JfSmd5LpTnUk2nGeKBz1Y9bLQVM4M6q0o152hWnS6ZpHaFOryP/Nzwd8ZRtGj2RXdf
         aGHE8GULniz1H/Gtyc0HQkj8fWE6ezHjN9k76OLoVPUzjKD68gnO3hYVWo29hKapYxZQ
         l86/LrDMWIb0laNVliWDXQMeezvLniGGoyrH5HAeVm3j3HNVn9cx6e8kibM9/i065dpv
         3Lswy+aNelc7Gyx6r3b0HYIW8ff5z54VljvFVBEeZstufGAKbRzxd86Ua+UVWKlw/sgQ
         tmNKlb7jjsXA55NBianztvetHo0KpGf1uxoY35ESwSHuxs6/K8VizKDpLR7zHMgJR6eC
         pq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764032300; x=1764637100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iqGO22Eo84dQQSwH69fcWPJDlu28MR6E9S1mkTawZc=;
        b=OFSefwMbY7QvyMwcNzFKDdk/8ZOyGmmeiut9tRVP2scTgLjIgYy3gGVvV/iXu2c+nq
         fSKUc1d6QULhKWtXVChJrIcSX8c3Pb8MxEPmGmhDsmsA1qFTl08rS2oxw3LT06EL1oFt
         iC1VAFL3YWBcjXVZQpspmIHcsqvxvMqjsfBL9O00eaDVBVwP1mzWs+2o+B3RASm/9g/V
         fmXGWpbhHG4EcgYNLmRium7/x6L1mAFmEIVPFe30TvF5idSTx4vIM2jvRX60vJsYrn9I
         hjkGALz7m4ibGbUjXmyMSAtmtHcxY+HXHUjp5jwmHOT+P7hv7Z5BLKlR6x5YYml0FbE9
         okgA==
X-Forwarded-Encrypted: i=1; AJvYcCVuKMbalk3Yl0GNsurkleposO+p0Qm2XGR7y+jJIOreN9KU+zm4Xa0dp7nO3OurgWAj5EkUMfm5FY3F@lists.infradead.org
X-Gm-Message-State: AOJu0YwRTFPCg6UwxiuhMRVF4sXrKhzJmSsgDWXBeDAm4lMFX+m+7TFF
	kDcfmymUgSTZQ7XcUs5d0SG3rCT6OPtSUkLfRjrMCpDFDWSsjVUU/tJajEAB788jlFI4DRSysrq
	dQIAv5TwBZLX2LOWXpm4+bOWD63uhKyw=
X-Gm-Gg: ASbGncs7r4YUAjfCmluBPN9bKfMWH8rmn0Kx0J+NlLzFwUV3UL8pmB+6h1GDdPDoc/m
	VXs4dm8isM/NuMrl5mXXPxG6KU2w+a17QEmlZ35USq62dPXiXdeFoExgJ4Cj7JkL+Cc9VIUK2h3
	/CDshNLqNQE+hzcYNaYoiKP/kf5likOMBAWv6dyhrdSDZi3Y6IzJSyHgek6uhv9SbKA1cNXNZ8x
	H4uh2CNpzHbq2w8dZ0Fnfu7jq0tcaRQOdZcRmR9SWo7zHOnlSALJ8U6a2kvHnvmBi3sty/+Sa2n
	EtNyRaU=
X-Google-Smtp-Source: AGHT+IEFHuOyyLl2r/S4EG+KEx5xlPaf9KPxew2so6lp4s4XSr+jblph3HE559EzoHjN0fQf6DhliiaGkBdgyQrufXA=
X-Received: by 2002:a05:6214:212c:b0:880:591e:abf0 with SMTP id
 6a1803df08f44-8847c515a92mr232851076d6.31.1764032300102; Mon, 24 Nov 2025
 16:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20251117184343.97605-1-justintee8345@gmail.com>
 <c2b9fb9c-440d-4e41-b4e8-7428fcf9c2ca@suse.de> <de42309a-8103-457c-a150-402488b36ede@flourine.local>
In-Reply-To: <de42309a-8103-457c-a150-402488b36ede@flourine.local>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 24 Nov 2025 16:57:29 -0800
X-Gm-Features: AWmQ_bmm7waRg5MeA62sXNuSgHo6cHseIznPMunmMP_z3mMqVCNOozG_BILpYCE
Message-ID: <CABPRKS-YF66xeYpsKsw40F3Rs7YJHaEdm=BgkS+pzQYwMaccJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jsmart2021@gmail.com, justin.tee@broadcom.com, 
	Daniel Wagner <wagi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_165821_637664_AFA0D8FB 
X-CRM114-Status: GOOD (  14.85  )
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

Hi Daniel,

> The patch itself is okay, nothing against it. But it wont close the bug
> report. blktests nvme/041 just passes because we don't check the return
> code from 'nvme connect' yet. I wanted to add this for a while, time to
> do it.
>
> Furthermore, the test now races with the kernel. If the worker thread in
> the kernel is delayed, the 'nvme disconnect' might still see a controller=
:
>
>      Test authenticated connection
>     -disconnected 1 controller(s)
>     +disconnected 0 controller(s)
>
> Anyway, I am fine with this change just without the 'Closes' tag.
>
> Tested-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Daniel Wagner <wagi@kernel.org>

Was under the impression that the issue with 041 is that there is a
lingering reconnect attempt leftover from the =E2=80=9CTest unauthenticated
connection (should fail)=E2=80=9D portion that interferes with the next =E2=
=80=9CTest
authenticated connection=E2=80=9D portion of the blktest.

Through correcting the nvmf_should_reconnect routine, which stops
retrying reconnect when -ENOKEY, there would be no interference in the
second part of the test when nvme connect is with an actual key.  So,
there will be a controller to nvme disconnect, as expected, for the
=E2=80=9CTest authenticated connection=E2=80=9D portion of the test.

Regards,
Justin

