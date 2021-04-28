Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D97C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 14:44:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7155E6142A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 14:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7155E6142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zo0X0b2BWjvZkFGhyLRWYrxVkbJlYj21lWuM3004TqQ=; b=MZvU2xu5RYurxbO2Y4RauXno6
	QJ/Y/Z7bwK03vN2+RwzBp97ea2112Xoy9r1tifQJKnPIOnEyxnFJV6DcUnVsqNaphxAuMNRYO7728
	9F5LfK5v9hXG+jXXLYg3FwiO0q9ceZoQiti4l6KOc4YzjA2iqHQyblZ3UACIBFXGm3rBLX7tRagR4
	ea2Z/OKSLWvhaZUqP6LVxyFpWlcIC0CZOhcX6/eCh9PW5faU3pJMFCHblT4lRzVH595E1y6DpC4Jw
	JDZopWBcab0aDxDCEigIG+kT5yoZ5dphMwbUrxR2N0C3e3uVxuGqGde+tmwE5oZ4XwxDw/FV1n+VJ
	WHH2jMejA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lblQY-003eZF-4c; Wed, 28 Apr 2021 14:44:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lblQU-003eZ6-VV
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 14:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zdwoiOH67SfQTPv/gqLSWIaFh8GPfs7qMxwDRvEnh4k=; b=ssSOarDl0zxbkcF+jGHXLwusNn
 un1BIWhe7G+8UpCDfyxMyUShcBz1JJIqb4FqdcZ8hzO1iF3Ol8TMOMBfmCVB5/wy3Hm5OW+ctG0r+
 MWXemfkvaDG7ilAlrBOhgwMocLAiFtOWp8muO70ueasu+yAe2ADHqCZDYEjL/7m4St2WJ79rzTirH
 7y8PrKMgVAkn5HKNbi0pPtahtERRMA7qxeNc2eXknthWMpDy64mHDtzuiHN/Ke6rEqVmh77qGRpul
 JZDapLpamxbfeMGTgovELr2D6cA4v2OUdJ2o7SpbOIMQn7Je1/x6rZXhUx3zyZCb8S5YGqK6D1f10
 FoJYLLGQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lblQS-00HV3l-6Z
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 14:44:29 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEDB76142A
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619621066;
 bh=OHkMUHQBoyz/gEf5RAs50np/fKoXOcxtaMwUqImbPfk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h5T6NwzVDwjkpZmIouQ/0x+N7KcPGDVxPEPCO1VicEUoHGqyEl6CnsdN8yjULmHRV
 T62JdfjD/WiG8FenSeSEjMb2H6e260wVgTB5ddIk1V60pSTKKcwP+DoIkH2XXalNl8
 YPgdWzO7xRquhQG0gc5z47pZu3lY1FpFsh0FvoMLl46FWDhnNvRDL1brignbgCiV8G
 Hk0EPSng3dVP5DFHIkbBG+0RhI3cypG827ANJMAvJUVlQB7UDLKObJaJW91ODwM0v1
 Bmf0/FHxLyNI4Nlye6q3tJGJrRiQVaeQ/2eMTK0/17CEMthSLKmER/QJ0vgeb65Cdx
 bltsi8/TOUjuA==
Received: by mail-ed1-f45.google.com with SMTP id z5so38054450edr.11
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 07:44:26 -0700 (PDT)
X-Gm-Message-State: AOAM530vLT/YT3ynLY/fCSH8GxL4KDBozIRcpw8RPlztdiHG678jPn8l
 YV+DNVJYpU6fcB6vXZm9Fg7/3+XIqTukWY+JKUidGA==
X-Google-Smtp-Source: ABdhPJzCWHkui5uwRqRd2h6i/ZcLWEG13Wh6t31iWnew5n1IVvHmoh8nBguOqrLiY9r9lQduogEqKSRPTLLMCMld2sQ=
X-Received: by 2002:a05:6402:3063:: with SMTP id
 bs3mr10643156edb.84.1619621065228; 
 Wed, 28 Apr 2021 07:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
 <20210428124256.GB28566@lst.de>
In-Reply-To: <20210428124256.GB28566@lst.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 28 Apr 2021 07:44:13 -0700
X-Gmail-Original-Message-ID: <CALCETrXSP8RR_xu3aVwGNL26KNZCkE6D6yztMpu_MPZUfkRCew@mail.gmail.com>
Message-ID: <CALCETrXSP8RR_xu3aVwGNL26KNZCkE6D6yztMpu_MPZUfkRCew@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
To: "hch@lst.de" <hch@lst.de>
Cc: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, 
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_074428_341117_FA6CA446 
X-CRM114-Status: GOOD (  28.24  )
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

On Wed, Apr 28, 2021 at 5:43 AM hch@lst.de <hch@lst.de> wrote:
>
> Adding Andy who wrote the original APST code.
>
> On Wed, Apr 28, 2021 at 09:27:36AM +0000, Alexey Bogoslavsky wrote:
> > From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
> >
> > The algorithm that was used until now for building the APST configuration
> > table has been found to produce entries with excessively long ITPT
> > (idle time prior to transition) for devices declaring relatively long
> > entry and exit latencies for non-operational power states. This leads
> > to unnecessary waste of power and, as a result, failure to pass
> > mandatory power consumption tests on Chromebook platforms.
> >
> > The new algorithm is based on two predefined ITPT values and two
> > predefined latency tolerances. Based on these values, as well as on
> > exit and entry latencies reported by the device, the algorithm looks
> > for up to 2 suitable non-operational power states to use as primary
> > and secondary APST transition targets. The predefined values are
> > supplied to the nvme driver as module parameters:
> >
> >  - apst_primary_timeout_ms (default: 100)
> >  - apst_secondary_timeout_ms (default: 2000)
> >  - apst_primary_latency_tol_us (default: 15000)
> >  - apst_secondary_latency_tol_us (default: 100000)
> >
> > The algorithm echoes the approach used by Intel's and Microsoft's drivers
> > on Windows. The specific default parameter values are also based on those
> > drivers. Yet, this patch doesn't introduce the ability to dynamically
> > regenerate the APST table in the event of switching the power source from
> > AC to battery and back. Adding this functionality may be considered in the
> > future. In the meantime, the timeouts and tolerances reflect a compromise
> > between values used by Microsoft for AC and battery scenarios.
> >
> > In most NVMe devices the new algorithm causes them to implement a more
> > aggressive power saving policy. While beneficial in most cases, this
> > sometimes comes at the price of a higher IO processing latency in certain
> > scenarios as well as at the price of a potential impact on the drive's
> > endurance (due to more frequent context saving when entering deep non-
> > operational states). So in order to provide a fallback for systems where
> > these regressions cannot be tolerated, the patch allows to revert to
> > the legacy behavior by setting either apst_primary_timeout_ms or
> > apst_primary_latency_tol_us parameter to 0. Eventually (and possibly after
> > fine tuning the default values of the module parameters) the legacy behavior
> > can be removed.

Can you give an example of the APST states and latencies on a device
for which this is useful?

I'm not opposed to adjusting the algorithm, but I'd like to understand
what we're up against.  If Linux were the only game in town, I would
say that the approach in this patch is unfortunate because of the
arbitrary thresholds it introduces, but if it tracks Windows, then
we're probably okay.

--Andy

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
