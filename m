Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC6DC433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB292076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mioD82IQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5lGJ4Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB292076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HWwwDyRDGe+ZtBgTQvVPf2ughpV35bHK7JBdNYiu82I=; b=mioD82IQtXanSQd+C8D7jsAEJ
	39aZE2JCep+Quk7MMTwpVeaWyYo4ZJVQgB2Dlyoly4bfiHUtp2PYedBIc5q8xkuCqTUmfgvDVGvVX
	lu8wkXGCNEzqtV6cvC/yRJLlrd+ZodoeuQvKdY0EBroQ0MHFXHyEfrRl0mshIsUlhVJb/RTEgW3sM
	EpFJRzsPGzrDHk1s9bq0IcPGsNaDh81GiS4Lic3suw0Ck0Tm1i9Iyorv6YrvpodsK7wnjYXDohl87
	SOIQDi5JPLhe1m0XhXpSyvN3xHYpp83cnGAatuqbJ5pX6GbYEk39fm2YBEXz4ZTaGk80f6QQgIB8m
	oyxj2gFQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8LOK-0007zs-Mc; Wed, 19 Aug 2020 10:32:24 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8LOI-0007yx-8P
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:32:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id p14so1568252wmg.1
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NV+AsSWtKgo9V3/Cia9q0raOuFNDesH+Q29wP1zWBh4=;
 b=B5lGJ4VjjJ0e8bFa5P9jabfVMJ2SDPRUYFM7GR79AU7H5PS7dHY0qLWGNgYNE40kxe
 KdNa5QE2zFmlsilJf1GOdlQECUEqFBq/M/SuwI4dKc0/AwbNc6/TGn1E62JqjyCvgHAq
 1PV8a8aEEwQ3ZwcumuPpv6ZMGZaJO6iWY/dJoQe6+0EdXyQw+DbdSkjssIMQQRIBMc6b
 s2VS0Jrye6Qzif4pBIJmA33Ab0sbcl7kPqSKP9mTjvhz6j8c5uRHGQ07fBMz/U2aRWeU
 fC26cTKMUYAuZYk9iwCvOelEWfptsBVaQ7Uw4GnyOMY76lP8PMBOOgsNWEBE9DVw4R6Y
 GHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NV+AsSWtKgo9V3/Cia9q0raOuFNDesH+Q29wP1zWBh4=;
 b=T1altL7zzg4xSiiS+T+lR+w5uUs0cPNU+zP5pi8oxya5S65yyGNfQocZLAEZ8hgthX
 zWsDtSGcbsq+Zn6Ys0KmKjWYqHwrU+nttYA6TZe47qJLaGw0Gxjt+8l/9lJ6NJOWPTFT
 Sw+wxO/M2xE+rGbJGLuA05eTT/5Jbp9U5W2uOKs7LCeL0RAZJNpFe9t6Nm3enunaJQqd
 1rNDhEm3LyL2erYHLWEEbXhA46LY7afSOU8CteCZnFXEqha4u1OK/P4W3Tqfo9eMmKNA
 Jy9Pe8f5vpR0I730jYDr4Ci4BpNnJcEC9lQa2BuS4AV/WEqqoIMrMeVS2kfY1bU88y0z
 r18g==
X-Gm-Message-State: AOAM5317sBx8YZf4si/girTcuY83ZfKc4Yb2zEzjCp1zYylzQyMo53OJ
 EBKTxBKogbKOdKCdnTYa+1fLOM22CYUu6zNPaTg=
X-Google-Smtp-Source: ABdhPJz+viaPlrYERgK5MAmEg65lIg4xfE1p/n9zOxz9KVwyCf2C+pTAPZVcWcXsVfCSDePwL6IxtloMUbN+Mo/cQ1I=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr4446682wmh.4.1597833140938;
 Wed, 19 Aug 2020 03:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 19 Aug 2020 16:01:54 +0530
Message-ID: <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_063222_352600_950CB93A 
X-CRM114-Status: GOOD (  23.64  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 3:08 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/08/19 18:27, Kanchan Joshi wrote:
> > On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> >>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
> >>
> >> No, it is not.
> >
> > Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
> > I see that null-block zoned and SCSI-ZBC both set this requirement. I
> > wonder how it became different for NVMe.
>
> It is not required for an NVMe ZNS drive that has zone append native support.
> zonefs and upcoming btrfs do not use regular writes, removing the requirement
> for zone write locking.

I understand that if a particular user (zonefs, btrfs etc) is not
sending regular-write and sending append instead, write-lock is not
required.
But if that particular user or some other user (say F2FS) sends
regular write(s), write-lock is needed.
Above block-layer, both the opcodes REQ_OP_WRITE and
REQ_OP_ZONE_APPEND are available to be used by users. And I thought
write-lock is taken or not is a per-opcode thing and not per-user (FS,
MD/DM, user-space etc.), is not that correct? And MQ-deadline can
cater to both the opcodes, while other schedulers cannot serve
REQ_OP_WRITE well for zoned-device.

> In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set only
> and only if the drive does not have native zone append support.

Sure I can keep it that way, once I get it right. If it is really not
required for native-append drive, it should not be here at the place
where I added.

> And even in that
> case, since for an emulated zone append the zone write lock is taken and
> released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is required
> only if the user will also be issuing regular writes at high QD. And that is
> trivially controllable by the user by simply setting the drive elevator to
> mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.

Are we saying applications should switch schedulers based on the write
QD  (use any-scheduler for QD1 and mq-deadline for QD-N).
Even if it does that, it does not know what other applications would
be doing. That seems hard-to-get-right and possible only in a
tightly-controlled environment.



-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
