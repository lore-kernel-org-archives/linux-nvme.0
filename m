Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 10:45:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50BC64FD4
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 10:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50BC64FD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PglexNtIxc0XOAmEDllD7RexII92p18XqkelgO5zbAM=; b=VFjRwHxUep5R1ZemfQTrmiKY7
	bMWpYpGQ0vJ+uQGRq1BsJBLCqaTE2DJIE7MoZbmKP3ImPP64iuh0BNi+78oKKMQqFpgbR696XLLZo
	McLtNiZFyHzLLmhtxvKOHoz0sohlUDkhKvdi4ORmWtsIqmLtofLpv2a9dBVGLOmQl61W8HpbcoCXK
	BwSyPYb5AKn0VVw47uWWzKalYW6mBDJivtmGlvCueCuk9SwJlhOPYPJmpE6rQtO/0KoeHZmgLmtlc
	Z0vmr75avOvdrhuB/G/MJ7SX1OKdhmoFp4ogwp3OFzqze3/b1wuOVAQ2S3vfbI18YIc6w/cuqlUMd
	IzL4MEr7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI7xa-00EcZv-La; Fri, 05 Mar 2021 10:45:30 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI7xF-00EcXJ-Pu
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 10:45:18 +0000
Received: by mail-wm1-x333.google.com with SMTP id m1so1032974wml.2
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NZwS2J3Ocb1h5Ffe7xElWH2+RmHLKydk8E116ZIyoA0=;
 b=gZX++oMxiVwkzJUXmGCRBa8tJYvOaRsVETmtpxqGDtnmA+20uvbE0RWXTjr7Oqw0ec
 l3DGVj38N4BRsQ/AIlMWgs6TROcI4hvhP63jiNu2R8jbkVC9DjHNqmv/olWC9Ntei51s
 n6i6HbbWe9aiY8T5+W5xd6CsaZ/bt2AiD65Ls7TGucl1w2XYE3Xfil/EdpmL53qvLhrM
 uh9Y4NME5dC8nTHXR/jU71iLLEs3l4Ye+JvDlzWbXRNoFJWA1Np5AtucyqIleZWCKBZy
 Yod6fYQPc+bntuVy+NvFojzc5SQjaeNqK7foxFusH+ho08VX3K6fjaBCTFDliBcM+7Ya
 2+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NZwS2J3Ocb1h5Ffe7xElWH2+RmHLKydk8E116ZIyoA0=;
 b=FH1bto1vFR+Bog+U7QQSiWR7O9vEmrxwmk7uVxauPb8UeTFOsVTCalMDG7HUZDeRRe
 PCdx8BRQB5zRO+1GgkrEt48JdtoWss0TF7/9fngDrQNF/zm+9PHW6kOAjff3eZlT8DDz
 5RlZCEkSCH9x6f6gnFm3h/a00vYIQmNZxQpk1GFxRgvzW0FXAYk6Z1TvF3c5xix1vGEQ
 0H3dTSYJ3OqDJFFK4f58qAM0T4nthJzhfCXqLI2wy2N/hwMvpdSamQbk+6IkABuGIKj/
 B2t9IInQVCcJbxRD4xy839dLJwHqrdob5yGyngry4wIfySm5ZgspF8xVj9BsXKSbWEk1
 x3uQ==
X-Gm-Message-State: AOAM531eNS/RWBPDNtVH9CSiptQJbyjks+nrNk72TgQaWod7ql3ZD35o
 TENydnEX9JMc+KBH98oLxnsCXiA+OuqXeHewG5o=
X-Google-Smtp-Source: ABdhPJxUgd6mpZ9+slf42a6EXjG/w+QEsJH+sbRku7AyAEVdoJIKBIe6d69e3LLGn/HGEd9djPPUJHuDlGSh6ZZWa2M=
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr8162928wmh.15.1614941109143;
 Fri, 05 Mar 2021 02:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB496501DAED24CC28347A283086989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rLvrC4s2o3qDgHfRWN0JhnB5ZacHK572kjP+-5NmOPBhw@mail.gmail.com>
 <20210305024133.GD32558@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210305024133.GD32558@redsun51.ssa.fujisawa.hgst.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 5 Mar 2021 16:14:43 +0530
Message-ID: <CA+1E3rL=xWPERkPuxAOrwg2ie3e=f8=f8r_pCVFca_BNTtvE=g@mail.gmail.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>, 
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, 
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_104516_951091_E17678B9 
X-CRM114-Status: GOOD (  17.82  )
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

On Fri, Mar 5, 2021 at 8:11 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Mar 04, 2021 at 04:31:11PM +0530, Kanchan Joshi wrote:
> > On Thu, Mar 4, 2021 at 3:14 AM Chaitanya Kulkarni
> > <Chaitanya.Kulkarni@wdc.com> wrote:
> > >
> > > On 3/2/21 23:22, Kanchan Joshi wrote:
> > > > +     if (!ioucmd)
> > > > +             cptr = &c;
> > > > +     else {
> > > > +             /*for async - allocate cmd dynamically */
> > > > +             cptr = kmalloc(sizeof(struct nvme_command), GFP_KERNEL);
> > > > +             if (!cptr)
> > > > +                     return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     memset(cptr, 0, sizeof(c));
> > > Why not kzalloc and remove memset() ?
> >
> > Yes sure. Ideally I want to get rid of the allocation cost. Perhaps
> > employing kmem_cache/mempool can help. Do you think there is a better
> > way?
>
> I'll need to think on this to consider if the memory cost is worth it
> (8b to 64b), but you could replace nvme_request's 'struct nvme_command'
> pointer with the struct itself and not have to allocate anything per IO.
> An added bonus is that sync and async handling become more the same.

Indeed, thanks for this. I will fold that change as a prep in the next version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
