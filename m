Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B43AC5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=; b=dUiKU5aw31WqaEmPQrrE30Ihg2
	erpz0KNMhYQAVoMOT1rkvK2qqwVBPq5iw9AQLR7L9Fj2W+OxkwxUbOeP5Sc2z12a2bbOcFl6ZA/aB
	aKPgdc3yvc5dblw/5kb5iXrpTEitofeYFOZDtr55LJ0UHx/j6z6RjhI4qqBAIpWgPrs92bOCwuoeA
	ML8VR1n7pG6SSpWrds7YqJ8m+1SjWskmia+AndjeCuMAZYKn7BXx1ONm+fJdhkM3hdEBo/1u6eBtm
	N8GNKs5Cs2q1dtsc5r4ITvKN8K0tJ5tpIHZON0Jpw76e09Q1RWsfQ1fpnuPcpJ997KG4J3W0wGolo
	4jKMocPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXvo-0000000Cvtc-2lFz;
	Mon, 10 Aug 2026 21:53:16 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXvl-0000000Cvt6-0AM5
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 21:53:14 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3510031a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 10 Aug 2026 14:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786398791; cv=none;
        d=google.com; s=arc-20260327;
        b=J9AFMZfrBYEjgRsl+Z7zUdRe8fAtzTKlGirwgkBr4h93JWop1TIm8vjWPGr4w+mEYT
         bJuTFrwtvbJh0s/WxPR3TJ8Y5Rwc7xFXfsxZDruCe3HAc4RH/lLRQtMHMrVCklhbRqXO
         eYTvlLABgVnvyqiMUgf+2J/+HCo6CmyswOnuy2Bx8diqBCJRBwI4rniOjIugeCSuvFVS
         VzKI+3YNX+otr7P/xVWKANjxNtRmul3ylHKKbQimmHFRwOfyNDx34IcWO0WpD6NYhNNp
         wjPYro4Ivo6Y+lr+cs0AHzhJdH1B1nxZGL1BEELqELKx9PV4JDzwGeLaJtBnxR+2XcGY
         qtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        fh=HljOhIgDa+/uoRiyZ1f6Hzjoy9kDCHYM6BKAqRYrVyM=;
        b=Vj9UVmGcy2cDsmh17+g7CWudzz4CRkLkaXUI4dC47VGoq2xFiu1wdhT8gCC9hyoz3V
         yjJ6VOLqAsPXmOyaakjiVbDH+v5/oLsI8I9nzUVzvlbI7zaaS77GomyMSybDSS/ilGyE
         FH46sSzYFrzfzTDRio+xFJOQF/P9NjAI0a6NvI1LD1vdcIH22GrsBNwzDndoL83yM2Rg
         oFiZqAVSwmwOkwrf2ZGWRcG+TO1plp3dUOAFjFacA/2Vu8jGit4jf/V4xfB9Ci8+UDy9
         DxKji7IuOPwY695bKJqIxJ34Gq3JYZ+Scp/7cG0gGrcK9vBMxM7hS4mXEhHjQlZtg8Gx
         8BFQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786398791; x=1787003591; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        b=fDglwUMe0eghMCMpa8xDxLL5mADp4xsMVPex47Z2dyBxm3PFqCLumNQTBU0kuPu/Sy
         cSSnwGDwzaLZUdthug/kTQInwMsFVgP6fSkHdl/olDc9mxhJx+HzB4LcI+cG/tCEHqfG
         fFkaAek9PCNPk2hSdxfjm+iNIEm/klbm1s5CsiYqC++sLnxP9gRhoSQePoBpqsTbEUEO
         w70G912mKCumyXcmFScUNOOzLQhUH4zp5eUFDKn9DTZr8TeEwGisc9XVQx9R1TumQfLz
         W3/rU8rPqes/RwSsAfrUZVBhMcNExuhPBqCA0ix7aDMEOVodotrCjqW9Tg8+KNNj7HrJ
         D6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786398791; x=1787003591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        b=OMAcJrjTYuXC7bgMPj7P4r4QgmzZavzaXG3/HiR8xLfjGi74CO/ZvL+gy8ys1yUYp1
         pvJdEYY9GTO+bTa91V47hxYSlurLMH/kJbCFOkJY6rTaNY8ZcOO38ZfUzbJ2vbOAYM97
         +rMcb1VOWyr12j35GHe0MBfUF5c8pq3P6Ap9vaSU7kp3Ce8u6ahBfHkV+KCfziWioDhp
         T5GcgEWFBIptox0T8GVMAbrBt9eX67O7EPQ8OdLZy1K6CF1YCeM9yLp5mwFN+ibqywet
         rfUF3ujty0XIlzlvpJYkc2bJm7G2TE84wXdwf3JdVEh0MpP7Oz0/482uNy/YKDpnliWA
         1mdA==
X-Forwarded-Encrypted: i=1; AHgh+RqUpUrNm8jQrAQbRsHs7xXE3SyonJs70V8IwdsZzda93zFH6p+PEcUusvsFqB9hQQGwZzGy2+dLbtCV@lists.infradead.org
X-Gm-Message-State: AOJu0Yyh0xjOpSL+70khd5uVFfh5Lbr+D09lu6Uxo4RjnqlRgM8nToU3
	metG1KMRFZ0F6XYw/6hIritGEnIJCgeHNMtkTlmsk6xzF3U/46B312FuxKgMAntkqOetL+QJDv2
	94j1cVbIuHoxvKSLqIAGcdYrjDWxSEcI=
X-Gm-Gg: AR+sD13w9hCayJ172cOPGtErOEoHfoNKWrpgQe6nQn9FOOf6b0QsozbKK42MJZZdeqc
	3yOHzpqhCdLf05BCOj9iO0w+6bPhDsJpAnIzOvHre2JbLwvMJTKaOwNLhXq0FJsTYEQAeQDwbQk
	iy9h6Dzuh0oa9cUL1tObigocpuhWMKHm2KAHd8WeobUPff84wnBuQffS+gky7a5S3fzB+ioBnB/
	83mm9cOcsQhlfBEa6EodNuAL/b3sdOZeY6o2P6XeRVhtEDLJ20Ljm7WAElfyaJFEeYuykSFonVp
	wjda60jUSFg2kbbQg82B8Xao7TBeOBZ10e4onpRIrIAA
X-Received: by 2002:a05:6402:4597:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a1f2488fb6mr11785301a12.15.1786398790858; Mon, 10 Aug 2026
 14:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com> <anpBQXfo7eGNU2-v@kbusch-mbp>
In-Reply-To: <anpBQXfo7eGNU2-v@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Mon, 10 Aug 2026 17:52:58 -0400
X-Gm-Features: AUfX_mz-TxhDpyhqedKezJsp7FjgXE-sPnTQOf8ufLKnlwR9JDNJrqPKqLRJsyI
Message-ID: <CACd_6n0dCda28CA+1WePuHjXEqu+wB_sFvWWPQmrmO3nfW7WiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de, 
	tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_145313_098290_4C9A0FA5 
X-CRM114-Status: GOOD (  16.97  )
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

Got you. Please let me know if you need any help.

Best,
Chao

On Mon, Aug 10, 2026 at 5:23=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
> > Keith, I checked this patch against the nvme_setup_rw() WARN I reported
> > (the second link in your cover letter).  __bio_split_to_limits() is
> > called from blk_mq_submit_bio() after bio_queue_enter(), on both the
> > cached-request path and the newly-allocated-request path, so the bounds
> > check is now serialized against the freeze window in
> > nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
> > failed here and can no longer reach nvme_queue_rq(), which is exactly
> > the race I hit.  Thanks for picking it up, and sorry for the slow reply=
.
> >
> > I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
> > unusable metadata" patch in favour of this.
>
> I'll need to revisit this approach as it is dependent on something in
> the stack calling the split to limits functions, as well as the upper
> layers error handling for a catching the end-of-device condition later
> than before.

