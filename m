Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5705AC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B8C6108E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B8C6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aP5fX1wdkFdrKuNBB5bbU3+bQHC4XJH51idBm/dTiTU=; b=Hu29cZtT3AjpXj
	WixLCHusdRkqvh9KhMBu64+vFh10bmlqrYjAEgoR2EZILAwiEIXSg6Zd2oNiRty9KM73DqeYQAgwa
	rtq7NGmbpRp+OuKDE8u1enknJsA3CLSRuS95O422pFtk+2SkuELJAUlPoaBs9xlHFo9E1y0zvK6Qp
	InA4jFanaegIGFKM8byImhZsG3s+ERwyC/NScuvISpzD1L2Wx57trd7mXk+o1fVA+ZT1VNgpb4x8Z
	yfRgXzrwYtjvi4G7dWNDxeZChxknlyRtzmq1IGLexMkRhAfHRlimKxRH6aNyBhhhD9XprBUXP3Emv
	ojXOwpBxHWnJzYdMzZrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqddu-009CnN-66; Tue, 08 Jun 2021 15:27:50 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqddq-009Ck2-D1
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 15:27:47 +0000
Received: by mail-oi1-f180.google.com with SMTP id z3so21885048oib.5
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 08:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HNwqdF6FkF+jEphsav1OW8cGD9Z3o0y9RutUW9W683k=;
 b=ki7vI5USSgw3Hzn+OxgnTVFlO2/Xe/q1EFI6840V10SUGSal54rBLscdzsAZjw9PiY
 FQg78gw06LXaPkxVRXYaQgiaCTYsqvnpp3fXke7Nq+1Jj0yr77yq4qItSafHkXJLMllD
 m6ani3YJlUVhEznspOv49qupqr/+Mvej6XYUu7biMR2fVae4bpJKiS4woooZRgiJUTQb
 JhvkPHUnp5SODFwLNFp8a1ndsLlHEog+rTqr2zOJn1b0R5AtI84N+wV1uiSBGhVIEZp2
 oN8EhF1uwmLRBpLEWjSHFYY3811C3NirUq9AqMMqJnh6Y55gMYKD4fARg7bxnJJh+7vp
 LVyw==
X-Gm-Message-State: AOAM530NpDDWCLqOq8DSByR93AV8c9hecLHTUxGufQanSopeXQeA3pqp
 zq7VHzJ3d38cH+W98kxRtrPsizwlQdXxrFx+pEY=
X-Google-Smtp-Source: ABdhPJw77ZfVxI0LUmBlUzwfJDe5Gk5EiRp2mgYf1qRMoU0+3AGGWi6PwFORKPY+Iw1IzD/mf56Jnwn6i9dg404tClo=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3242674oim.157.1623166063480; 
 Tue, 08 Jun 2021 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
 <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
 <556a22c7-58af-b9d4-d50c-25d7d16bd344@amd.com>
In-Reply-To: <556a22c7-58af-b9d4-d50c-25d7d16bd344@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jun 2021 17:27:32 +0200
Message-ID: <CAJZ5v0jwjSruQ1OYNyuJ=3UJA5LJW1-fGSw3Jy8jhRFfXasTuQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Nehal-bakulchandra.Shah@amd.com, Alex Deucher <Alexander.Deucher@amd.com>, 
 Prike Liang <prike.liang@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_082746_471057_403FCDDA 
X-CRM114-Status: GOOD (  28.67  )
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

On Tue, Jun 8, 2021 at 4:18 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 6/8/2021 06:20, Rafael J. Wysocki wrote:
> > On Tue, Jun 8, 2021 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> >>> +/**
> >>> + * acpi_storage_d3 - Check if a storage device should use D3.
> >
> > Let's be specific about what D3 means here in the first place and
> > that's D3hot AFAICS.
> >
> > And the comment should be something like "Check whether or not to use
> > D3hot in the suspend path".
>
> Actually it can be D3hot or D3cold.  Microsoft's documentation doesn't
> indicate it's D3hot.  On the AMD platforms that prompted some of these
> changes it's D3cold.

So say "D3" in the one-line description above and "D3hot or D3cold (if
supported)" in the more detailed comment below.

> >
> >>> + * @dev: Device to check
> >>> + *
> >>> + * Returns %true if @dev should be put into D3 when the ->suspend method is
> >>> + * called, else %false.  The name of this function is somewhat misleading
> >>> + * as it has nothing to do with storage except for the name of the ACPI
> >>> + * property.  On some platforms resume will not work if this hint is ignored.
> >
> > I would write it this way:
> >
> > "Return %true if the platform firmware wants @dev to be programmed
> > into D3hot in the suspend path, or %false when there is no specific
> > preference. On some platforms, if this hint is ignored, @dev may
> > remain unresponsive after suspending the platform as a whole."
> >
> > And I'm not sure if it is necessary to mention "storage" in this comment at all.
> >
>
> Is your thought here in not mentioning "storage" that this symbol may be
> overloaded in the future to look at more than just the StorageD3Enable
> property and used for other things too?

Well, the property itself is not about storage any more anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
