Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3EDCA9EB5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3329220656
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXKZvGEd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCkIh9nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3329220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rTXfFRd+C2MRooMpinD+NHfLb26QRbgEBypaG1Pz+XQ=; b=XXKZvGEd8/58CD
	/jwDubYYU1Q+vfuTx/SNlPTW7izvih80q86MHejgdyn59+/h1thvbYUxExXFUa0USrxZVoHQpUcG7
	SI1YNc7O2IFnstJfxh+WJ6z2dJHb2Wh54p0x6HlTC+CFlkoBxX9S+cMUmgJh6tVYEsEDfNdyZiYaV
	AmYeX2GjQx/zqO8d7kWRO0B1pl+krcHFjCmHvRspyS9sXQ7hxAslWZrz5vw1BkckFNcWLaUisxJgN
	EV+OSyGwKpYRoOIFLSc9wsCw+YoEbPCcd/PDIfx8eYJGyOhtBDmxldQNmY/SMRrp1DYk6EyvnnAwD
	2oGLkPwMuWDSUb+RPKVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRdrt-0006eZ-54; Mon, 04 Nov 2019 15:02:09 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRdrq-0006b7-0G
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 15:02:07 +0000
Received: by mail-yw1-xc41.google.com with SMTP id a67so7039132ywg.7
 for <linux-nvme@lists.infradead.org>; Mon, 04 Nov 2019 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z+Iy7ChZaVTYIBEpx4qfobr917iForOix/y0Q8dZCPs=;
 b=eCkIh9nvYNasuS98f92lbZBrT9P/ERTzX7Eq6v6/OjOtJ19UPRCofXW5BwXRtIuob1
 gH7Wj1lYMLMpTpj1T3SqjMiHKSgFb+vNfozPsx1bk32aKoFXDXzfbPADYLm+spQfSfdZ
 1jpoRjl8Rc1fb6kI4bNyw+jadi+cXVQK4S1w/Tq4i/iBNXg3u5r7tg0QL99DEb/Cdb21
 iMW+2yNiqvfbG9NLq8rMf7L7PPQrApckgKxujIIe7Bq7G5Ldp4QdyzSHcXgFOyJlcnmR
 i1czsmamS3bARr/hfAW6LLfuHU4Ko9r+rpAafuYZ2OnDxKTngiKMf4ChRv/Rn0elm9tX
 myeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+Iy7ChZaVTYIBEpx4qfobr917iForOix/y0Q8dZCPs=;
 b=qkzTnNz3rlDXz2EYuvbJZaftwQ7YL6THf/ra8NctpVVtSVmCNm3wDAmV09SAXNUapP
 4km2S2tyryIalRnKnOA4uG8Pt9pQlZRXuP/pmz20EahtcUNloFO4EoE9OnXdkmYt/nk9
 XYIE1zQqN1kGf4T3VoO7bzkPyMUFWCtTAAhT69gy2hzFVSLjHYWGskTZ0/VVU2dAoQCw
 LNrE2kDjyqK+EtjgTCsjg6zpGug1YU1CFCQf1p4SVbjcANjvT9H+1DzBT4BL9DR6AZeY
 YPiVvszQ8J4FV+kO7gRI/E5iRBjDhY3rUlmlGcCJOtYIxKvJUk1lFu8n2j/UJeAZx0r2
 mHSw==
X-Gm-Message-State: APjAAAVBWNZ+IkCWOt5p0+j19mkxa7hDTkCCoI2IM95F+Bj4rgu6XEa0
 GJf1xeqIFnwpavUgzVn3QyD88fbrkQ4pKFmf/e0=
X-Google-Smtp-Source: APXvYqzfkPQ2lOX33XS5YjF+WOofdN2erZkB5sf7/kcHuf9q7ma020bq1NDJRXqhJ0a5/zmNYkiHwcbwmQvxfBDFbao=
X-Received: by 2002:a81:98c6:: with SMTP id p189mr2906416ywg.443.1572879724375; 
 Mon, 04 Nov 2019 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
 <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
In-Reply-To: <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
From: Charles Machalow <csm10495@gmail.com>
Date: Mon, 4 Nov 2019 07:01:52 -0800
Message-ID: <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To: Marta Rybczynska <mrybczyn@kalray.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_070206_068772_E4272A6C 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, axboe <axboe@fb.com>,
 kbusch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Yes. The idea is just to change the 64 IOCTL structure so it lines up
with the old ones so that the same struct can be used from userspace.
Right now the first 32 of 64's result doesn't line up with the old
result field.

- Charlie Scott Machalow

On Mon, Nov 4, 2019 at 6:56 AM Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>
>
>
> ----- On 4 Nov, 2019, at 15:51, Charles Machalow csm10495@gmail.com wrote:
>
> > For this one yes, UAPI size changes. Though I believe this IOCTL
> > hasn't been in a released Kernel yet (just RC). Technically it may be
> > changeable as a fix until the next Kernel is released. I do think its
> > a useful enough
> > change to warrant a late fix.
>
> The old one is in UAPI for years. The new one is not yet, right. I'm OK
> to change the new structure. To have compatibility you would have to use
> the new structure (at least its size) in the user space code. This is
> what you'd liek to do?
>
> Marta

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
