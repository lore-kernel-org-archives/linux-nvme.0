Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E7EC64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 13:22:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F028C206B6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 13:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhxsy78/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omjzs4OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F028C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XJRb0QC2XvHg7VwZE5gFTnnGSfuEKDc70ehX5jbgZ5c=; b=nhxsy78/NQBK+GcnMIXqpwuSI
	Ecy8KXvw6Iwg2N5nRQLEw+/UB/1CfLqxYYj783RNc3OkadfyoLsDhi0auV7vXBjcUrt/7Mdkb6yJ+
	xbBHZ5piqWCGVL1lJ02HkkfWw7CrKJNQg68sUxU36Dg/K4J6b4skB1h6eUpRWeEyrQYI+UWyqGQwI
	xX0kfR97EQLeLlkCSccHaBmMtqTAU8MoTQYkTHbiVTFiHHcG0RKNXjjVFbxBgYzP7/Y8hTEkUodaT
	FFth4emy7dA2O0fBRVsS/nderwOnp2EVLjR+LOXKQXCjIr/dhW62b8vyn16mTzr3b/lumhl3PuaTB
	mDoXisFTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk5cE-0003E1-JJ; Tue, 01 Dec 2020 13:22:46 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk5cC-0003CJ-U0
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 13:22:45 +0000
Received: by mail-ej1-x643.google.com with SMTP id f23so4028430ejt.8
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uADe8pIjhPSuCRhZ6wL+nTegabcP2vd7po21w3/KsKc=;
 b=omjzs4OIh0H0sHYUNmwiXYUGGpzCAAS6J/sItDiufcNI3jka57fonKBcXPHYZ7EC3w
 AqLZcIzbTeNVW0c2I3+JFfvc8LbaA+N3OSA5kU5bLEsXHk7ey8xXeITb4y8BDGmkSuEX
 hnhkY9dSxfZLgLIQnczOR5S5HMKm+X7Jv0afzHvs4nlyr69ybrpO7EVWh6s6RZgB6Mkn
 lYmSW2uOOaAeRQOm0KA1q31X9cNYK3/WEn63GNDPTPmca1DLBuO2Blex+UBkVzSy+0K6
 4Qu2amZVXcEhnwiECDLa3n03Q3H8ZM/P0xJKQl1pedcKaAHTPsyAzDhlUOPYREoTmZhq
 HEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uADe8pIjhPSuCRhZ6wL+nTegabcP2vd7po21w3/KsKc=;
 b=Tyv1G8Ve/xjRc9bwWn78ka5FcSshrqDjQm/5021yORerfcZcKPOrpg2WJR7Dv+VrPw
 Dc955/YGItsdDdqfZi6CfLBHeE9x8tm19kpSu7Af3+jun6XeWPbZANi1jclnqsnmW75g
 vuqIXLaUNcdm4mHo990v2ZkGOZ8hO8KS0kP5+bG+A7dyUZoMYQahYjN490zBGKYptN9f
 1RAPWGk4Fts8+6QYsg3vC0KlNr/CuDiotrSGun4xZe6oQYgb5DxP9U3aIVzvtfs3Vvhr
 PzlgtjEZ1Q/p7X1vQk2osUYI181SsH9JjwPKLuAqbxAUq76eYQjSoX0cvusM9p3JcFbS
 rsZA==
X-Gm-Message-State: AOAM532Tmo2gVjEVRoM2QLJoXG4vyM+oOMrvT18XdoNRhlNBbq6X7chr
 4HJtcXi3Vvw/85Sh/9Cu1u+L7w101VpvHbvoHn4=
X-Google-Smtp-Source: ABdhPJz0oX8n58WEDpkBVOtEEmsqhZFkHTca/aDr4LQ7oluH4avRguTL/Swrpq6KXGmBFui3PPL0bTwu0E0hx+11DBY=
X-Received: by 2002:a17:906:68d1:: with SMTP id
 y17mr2997597ejr.447.1606828962469; 
 Tue, 01 Dec 2020 05:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
 <20201201053949.143175-2-selvakuma.s1@samsung.com>
 <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
In-Reply-To: <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
From: Selva Jove <selvajove@gmail.com>
Date: Tue, 1 Dec 2020 18:52:28 +0530
Message-ID: <CAHqX9vantopwsTYLNh92uaVaP_vOsbB0O-XgMSEjdKUsRk=gFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
To: Aleksei Marov <alekseymmm@mail.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_082244_996733_8E1AE439 
X-CRM114-Status: GOOD (  12.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, joshi.k@samsung.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nj.shetty@samsung.com, linux-block@vger.kernel.org, kbusch@kernel.org,
 javier.gonz@samsung.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for reporting the memory leak. Will add a fix.

On Tue, Dec 1, 2020 at 3:58 PM Aleksei Marov <alekseymmm@mail.ru> wrote:
>
> On Tue, 2020-12-01 at 11:09 +0530, SelvaKumar S wrote:
> > +     ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
> > +                     &bio);
> > +     if (!ret && bio) {
> > +             ret = submit_bio_wait(bio);
> > +             if (ret == -EOPNOTSUPP)
> > +                     ret = 0;
> > +
> > +             kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
> > +                             bio_first_bvec_all(bio)->bv_offset);
> > +             bio_put(bio);
> > +     }
> > +
> > +     return ret;
> > +}
> I think  there is an issue here that if bio_add_page  returns error in
> __blkdev_issue_copy then ret is -ENOMEM and we never do bio_put for bio
> allocated in  __blkdev_issue_copy so it is small memory leak.
>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
