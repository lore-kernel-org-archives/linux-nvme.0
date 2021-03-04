Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB3C433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 11:02:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A524764F2C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A524764F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/bnXq9FCQPfGTApeVdqtmcIgBqBJ/DcGsMpBQ8DvWPw=; b=ZpYF1QyfWd1eVopGLaTzBOJOa
	3FVGXdy3r2mPubZW4W1/DS14FTobO0xSZiHSsqZfQG0LUFnZpcfmMgoxNL5pv6w1PIvKs35NXwQn7
	OSYkKuDoZ2YL8a7M3mWBoFDv4zcoYC+vzxuzbo3u/KXu5UUxHUBE25TJS6Oew90cjvhHcBjdDosep
	Wugk79vWmWkJ9wCfgUUxgpomhfnLwpPmmwgaY9zZiV3WAQJJYtKcCs+y7G2ohy7TPLjEnxQ/RwrcL
	S0n2mfe2QGWb7ygU14tTrwTiTsbEkKTJOF4XcqUBc/C/ObjTkLYfiC+JUEfnQB/BEEjSqOsEEJ6rc
	InXoCMSSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHlkD-008Pev-14; Thu, 04 Mar 2021 11:02:14 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHljk-008Pd5-37
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 11:02:08 +0000
Received: by mail-wr1-x436.google.com with SMTP id u16so9128425wrt.1
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mjdz8WpGGWhjIOSZ1TFNSDrCUu+htoeU4z79Rhlf1z4=;
 b=IuzSIuS9g6qFONXKeW55E2wLFb+bzYIjDkRKt6O1UhE/WqVnLZVbcXHIAaULej2YF9
 KUmBCXwbxPTW7yQw+8bNq/JqtWTkdBqdG9LD1jAbYiLdVHqz1DRIsonhCP53uwbuBk13
 XssNlKj49yHuOeDj39GLQsNtCB4IBfu5ebT2KMDqVokpVQaWSdLqBezhIRv7sozuJLJq
 UedGqwqMPLJyQNTytvEcHBNGZfngQrS7ojr5TcxzISxu+Qr/ZDmHEEQF2Ac45djuow5C
 +hCb1qfFldnJghETG4O8dkNVxRvjtrOOToONUi4ZYYxsNPppI4xsWtNdR1ULjBRmum62
 V5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mjdz8WpGGWhjIOSZ1TFNSDrCUu+htoeU4z79Rhlf1z4=;
 b=VjKaK/IBFKNnU2Wr7GmrtYGSmjCrllf8xPA8Lq52QdFLLT6+e5NnqNvjb4tqsHJi/v
 Qx0SB42MuuiArF7Cx4NYsWemQjm4NO6u7B0+WaKWRYwap96YCy0qxbl4rfJ2Uc2kn6Qh
 hGQujugfePJIXH9cN6Rzv3NhNaydLrAopKxMiDulq1bB1fA0DQW6XIQdnVSQoEXBWkXY
 bIE8sivgLWySP8fcAkr6InE8ix/tT/QcmhUXRFSEdlErpiV7MuDSWCH6J5vm+qKf4sv6
 llKqecgJCxyiy2FMdY+iL6/ulRTvILTr2qUncEO0ZkHxgGvtOGhN0eBDPcX11Pk6QFmA
 ovFA==
X-Gm-Message-State: AOAM530HUcGbsFmHXJhkye75ceza/NqqEjJXv6vrLb4I9fMQEdY4lBrG
 QNW7N8wg1bo7Y5dCJwtkkcZ55E3izOqpqvfgfFjwT5A+b4g=
X-Google-Smtp-Source: ABdhPJw09jvjtSlQCGIIOkypWNKovOI2rHUY1PIDoq89R6ltpK+7dErIDmB9kAf9NHvOsSyhhf1T2cCUSrfkMpLVjoI=
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr3340605wrz.407.1614855699360; 
 Thu, 04 Mar 2021 03:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB496501DAED24CC28347A283086989@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496501DAED24CC28347A283086989@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 4 Mar 2021 16:31:11 +0530
Message-ID: <CA+1E3rLvrC4s2o3qDgHfRWN0JhnB5ZacHK572kjP+-5NmOPBhw@mail.gmail.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 4, 2021 at 3:14 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/2/21 23:22, Kanchan Joshi wrote:
> > +     if (!ioucmd)
> > +             cptr = &c;
> > +     else {
> > +             /*for async - allocate cmd dynamically */
> > +             cptr = kmalloc(sizeof(struct nvme_command), GFP_KERNEL);
> > +             if (!cptr)
> > +                     return -ENOMEM;
> > +     }
> > +
> > +     memset(cptr, 0, sizeof(c));
> Why not kzalloc and remove memset() ?

Yes sure. Ideally I want to get rid of the allocation cost. Perhaps
employing kmem_cache/mempool can help. Do you think there is a better
way?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
