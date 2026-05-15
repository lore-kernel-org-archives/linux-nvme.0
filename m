Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A858CCD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 05:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90HxByDG1G+r8BADGKD7TzgvCkLCVwU7OWcJLPrsHAs=; b=EQC69a+ooKzsftOfmMF+kTL6Ia
	Z8tDq0dlnYzskafaStyDMyfKkyHsGMmym754Qz99SxtIfKm66cAf3yVJvuY56aSxa/eU39g8VBtyA
	BPM4UZYvwmW162q1ZvRgmguA51IvoOUCCUsGlOHkSKsfkVOtg8TSNwVfbQLpDdVuk88IKoO2BSrpF
	naEdSckNgSqMkd1Dr2XKpgBlEQswdPzcqgpxtjBKksiRJfXJTbQDDpHSbeAkVL1j0rInsS7EFdprX
	HyYiUI/4Hbo7/yCkU5ps6dFMmM1bMbDv9tTtGyCSgQSbY+WmNsISLcyvVz/ZMWkq+BFJZejKgzWL1
	oUCBETIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkjz-00000007N6a-0PKS;
	Fri, 15 May 2026 05:05:39 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkjw-00000007N5s-2vvg
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 05:05:37 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso15809751a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 22:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778821535; cv=none;
        d=google.com; s=arc-20240605;
        b=GtPlV5GxKejpGsiyLqDRFGs+U4P2Sp9dKGuVjCXn7N//RCiAFqi4mQ3q+F+CHTbTKo
         QOIMw4uE+lKvUv2aTg+uzwnL6+eYdkKQnjDnMSFNByXmdi5EPQ66viWoEU/+/zCqGFsr
         Qy0CZazDWIAqYyfICVz2BHCwNl/OnFE5dFa3MVveVBn4DtoSG1SOZLyAJxSdJkvIborT
         RaK/gxa6B90dDFztR5YnqqAvVY/5Msu6oHnMwpHWIXQCcVNonJ4HY1JzMl9199VSB2m+
         Gw2w7nWJjTYQT3flahQgPIqaJ/ydp1DPsF3co1GIXZDc5kP4TvWm41VnLHqV+lp+73eF
         GmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=90HxByDG1G+r8BADGKD7TzgvCkLCVwU7OWcJLPrsHAs=;
        fh=EE8jhFYKBi55coshXa4tAduUeoBO67C2GcRBU/hUdY8=;
        b=HZA8y4QRGAX23rmx7kWZ4pkdOWBIF9jca+84Fo8KL0/cyNgPJzNSbcQnn/LcDV/2dL
         avtJorUkv+I74vSrgZFfwM0mbSXMJccxu7zMEY4Fy8uJhFQn1sbkWrXdW1GsBeqFINWI
         7BMM14r45LmwENzMfxiVkorZdC1Ns28oPWGRZ3GP1lyz4G2rkHzu0hpvl+GtTUDC9GTM
         MgZr6SM0B19TrKLcbLvLeHBXVZy3Mbg1u5E7V0ZkUWCkm/ykaw0uY9GrSXiDxpHSkQ6T
         64YklyOV13+1myt0RgIX+Q3OsYbyqbl39aTJYOk53l4V+Q5x2b0SAM4nFxZxnbe3MExM
         hQ9g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821535; x=1779426335; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90HxByDG1G+r8BADGKD7TzgvCkLCVwU7OWcJLPrsHAs=;
        b=tAcCVK4ZNAa0rBQZh1E3iBsvLUtGFD82cCzxDCZFXHQsXE0AXznN9IhkN6WC+dxiNO
         qKBhECrPCOD3BCRAA62seqdnRK6K5/fjvJIGoTYC1pMAP0m+wuW+qEuMXjdHSVHj9rtP
         hVVXPY49y5JSUzJaUnsiKoi1G+9kvBgYxZb7sG8SSDbODtx54PVHbQaZhvv2e6VohrJd
         XO6PzWSbo4EijwWGFfisP62zd+jlGgn56U5QquXjXneoUqfAFRSCTviY5sUMKFBLJpun
         D/jGnjeulvB1jXP0TqNXorXhXGIaDriPEF+j2NyX+LA+pkpb+a7XJ739+rk1plm1//7l
         2q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821535; x=1779426335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90HxByDG1G+r8BADGKD7TzgvCkLCVwU7OWcJLPrsHAs=;
        b=tTyh7AbcvaQsfzdpqaQtyY0OFLoYN2ZekEncYG6nD88X/mJbR7XMnLp0lT0A7VcvgZ
         nm8YRKGE1uzpoRfbAiA3nUtbfYxwf/sub1iOHkL1MipkeDEB9rb0hVkN3vmdghXliJOT
         aLcge76theA2EXUBA0nVr3W9zyQlFlHGtyz/j03CZM+rzH10nVfiis2gZ6W+Tx7ec1nd
         LJTv9bB+TSzzs1qSKTInJE7Z96ivQGGDUl/pzjeCsQfaTYaqkNk8L4xwrCNI6bYAF3Qa
         f8npLVqrJNK0ZruGh0jk3OquVtt4Hr5yyVf5pM8/hNRW5Zv6ABqIBdg8I/+PBL2lFT5c
         KNzg==
X-Forwarded-Encrypted: i=1; AFNElJ+HqeNwt3WzuaDN9J6dLF6FPoejm8gE2DukMSKLqV056qXOmx8OISQnEQbzMKW7FtTUqjaYWOWGCuCF@lists.infradead.org
X-Gm-Message-State: AOJu0YyRKapBuc8GyvNuCA0oGOMYAUpOFCyLow38kimT31TigFyfLko6
	5nBRHrIvQk/otKToI5ksBUpflB1c7NE7dafrF1+TYymHiPiQZByyysTcA8knjf9f0nI8FUkPjaY
	4eXMrm6zRHAwmmc94hhcKDDSWw3VoA1RdnRF/6BLgboHX
X-Gm-Gg: Acq92OGTzsRt/HcwAUXuRuCJ7d81DNiMnMQ8zbmKWX+CqLNKelZdT2NyTRW9H6vJpWR
	eAmGmPe5XOejLowPh4zZhgkwJhCCT1v9zmsCyqtAT8I5liZTeW9Lj3BqiYgZoi+ixVYdpPvfcXV
	7QRINXsNjTjZcWP4SsasD/0CDchqPK8w48NqSOLAC8sEbhLNbpPwNVFNiOQI7SK7lJVhg4adqwG
	sk8FIETqHNNNPAxX49rYe1MuTLSTGfe+wnBQjIanaaPeGvLewWeWRU4omj9cxqQKcRC2TZu07rM
	TU+kLZt4
X-Received: by 2002:a17:907:9452:b0:bca:a09:9212 with SMTP id
 a640c23a62f3a-bd517ad6f57mr99966266b.45.1778821534560; Thu, 14 May 2026
 22:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260428022911.1288485-1-coshi036@gmail.com> <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
In-Reply-To: <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 01:05:23 -0400
X-Gm-Features: AVHnY4JfhP-iUw2ylAsRknAnAiByVN9H5iz77e-hAVbShu5PrE24HFQPb7tEDVA
Message-ID: <CACd_6n2xKm2y41c4iLEHrrYecvVyk87gaG-zvYAMHw20N6aBhg@mail.gmail.com>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_220536_761916_3B788ADA 
X-CRM114-Status: GOOD (  21.70  )
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

On Tue, Apr 28, 2026, Maurizio Lombardi wrote:
> The spec 2.0a, at section 5.27.1.12 Keep Alive Timer (Feature
> Identifier 0Fh) says:
> "Keep Alive Timeout (KATO):
> ...
> The default value for this field is 0h for NVMe transports that do
> not require use of the Keep Alive feature (e.g., NVMe over PCIe).
> For NVMe transports that require use of the Keep Alive feature
> (e.g., RDMA and TCP), the default value for this field is 1D4C0h"
>
> To me, it sounds like for nvme-pci, keep alive isn't required, but
> could be activated.

Thanks for the spec reference - that exact wording will be quoted in
the v2 commit message.  I am adding you to the v2 Cc list so you see
the next revision directly. Thanks again!

Chao

On Tue, Apr 28, 2026 at 3:15=E2=80=AFAM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Tue Apr 28, 2026 at 8:47 AM CEST, Keith Busch wrote:
> > On Mon, Apr 27, 2026 at 10:29:11PM -0400, Chao Shi wrote:
> >> nvme_keep_alive_work() always allocates with BLK_MQ_REQ_RESERVED, but
> >> nvme_alloc_admin_tag_set() only sets reserved_tags for fabrics.  Since
> >> commit b58da2d270db ("nvme: update keep alive interval when kato is
> >> modified"), userspace can start keep-alive on any transport via Set
> >> Features (KATO), after which the allocation trips WARN_ON_ONCE() in
> >> blk_mq_get_tag() and fails with -EWOULDBLOCK:
> >>
> >>   nvme nvme0: keep-alive failed: -11
> >>
> >> Reserve one admin tag for keep-alive on all transports.  Fabrics keeps
> >> two, the second being for the connect command.
> >
> >> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is mo=
dified")
> >>
> >> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
> >>
> >> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> >> Acked-by: Dave Tian <daveti@purdue.edu>
> >> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> >> Signed-off-by: Chao Shi <coshi036@gmail.com>
> >> ---
> >>
> >> Reproducer (run as root on an unpatched kernel with a PCIe NVMe device=
):
> >
> > You have a PCI controller that doesn't return Invalid Field In Command
> > status to the KATO feature? That's weird, it's fabrics specific feature=
.
>
> Are you sure that it's fabrics-only?
>
> The spec 2.0a, at section 5.27.1.12 Keep Alive Timer (Feature Identifier
> 0Fh)
>
> says:
> "Keep Alive Timeout (KATO):
>
> This field specifies the timeout value for the Keep Alive feature in
> milliseconds.  [...]
> The default value for this field is 0h for NVMe transports that do not re=
quire use of the Keep Alive
> feature (e.g., NVMe over PCIe). For NVMe transports that require use of t=
he Keep Alive feature
> (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
>
> To me, it sounds like for nvme-pci, keep alive isn't required, but could
> be activated.
>
>
> Maurizio

