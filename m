Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6CC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067E06128A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067E06128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R7Qe5Qvt6tDQv3B4iKsJznZwsORThEMLZbjXBYCAYtg=; b=iHDVhYXMSjFDYg
	VzJAx7d3AZZe3mPgRLEK/uQ65kX7GEfIItVwe4dy1NgPtpAYvYi5OD9VzuGJP2PLzyIndzIFPVzFr
	GKe4hzqa9bCX1IGVY/eR+qHROSg6fVM6z6bFculGmZ09cASdF4iwS63roGncnrIIdU+IA97zLE0hT
	8UtYR4IZJpJTl4nyeFL+NXzIGsCI9HM3ibo/Juk5MfT427VavW+zZHuX0XWQEyB7aYwafqQ2lyw0D
	0J2qbMd+cMZ+9TVIkFB0q5ZD+UJe38ZSmoYcBteAAhQUu+dARPwI4+HpDMLTuuyY6iogiwWRrgNOY
	i+1nupfApjuKmOOqnPFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqZrN-0080oR-4d; Tue, 08 Jun 2021 11:25:29 +0000
Received: from mail-oi1-f178.google.com ([209.85.167.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqZmy-007yGy-1O
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 11:20:57 +0000
Received: by mail-oi1-f178.google.com with SMTP id v142so20754326oie.9
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 04:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3kRxbCWG2OXZOSOQYjN+wij24NaIQIZS7qE5IBc04fg=;
 b=UK/WOtx+pMStOP0H8CXUwhee65YCFlB7tsyVOAiKaAffYsLuKPohJ7CXzEgAiJKv4x
 czVAR/GdDATG/4eKGq1x6Fh9Aa0ieAqDlJuAxydzxHTt+ipprrZ3CAZPAHffv8/Hh94K
 Cuc9N3IEsJJi7A9v4YKiObfDb0nWTqtbwMzyysDP8dR8ZV6EhYRx9/U37GD+QFmXbSM2
 b/3L9KJi5znes6yfR9NurcuVuZlTpxD/BY9Z+Ww8hku0zF+8f38zwXVWlb54zRx4UN+8
 9pSqrEp79vKUonb1v4hSnRQzjqMaI9phXZptvVRs0iFiMTqzE4/9EVTc1T9xYRe29HWe
 ++BQ==
X-Gm-Message-State: AOAM531lW9YEsWywNbUdp+B9E3MXSRzrDowf5daI7T18s6zJcDo2xS19
 SmI5sbNVrWqTjQDeLGj+E8OPjua2iWFRkrKVcKk=
X-Google-Smtp-Source: ABdhPJzj+2qh6aoDiTJMWsDt+F99NabZ7WwOKqMPzK2YQB8EtAKcx+tMAiNZbi4uFRLXKo/sM5gmy+NMfihYiFhThGY=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2324517oii.69.1623151254329; 
 Tue, 08 Jun 2021 04:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
In-Reply-To: <20210608053546.GA14116@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jun 2021 13:20:43 +0200
Message-ID: <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To: Christoph Hellwig <hch@lst.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, 
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Nehal-bakulchandra.Shah@amd.com, Alex Deucher <Alexander.Deucher@amd.com>, 
 Prike Liang <prike.liang@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_042056_119376_108114FE 
X-CRM114-Status: GOOD (  28.12  )
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

On Tue, Jun 8, 2021 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > +/**
> > + * acpi_storage_d3 - Check if a storage device should use D3.

Let's be specific about what D3 means here in the first place and
that's D3hot AFAICS.

And the comment should be something like "Check whether or not to use
D3hot in the suspend path".

> > + * @dev: Device to check
> > + *
> > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > + * called, else %false.  The name of this function is somewhat misleading
> > + * as it has nothing to do with storage except for the name of the ACPI
> > + * property.  On some platforms resume will not work if this hint is ignored.

I would write it this way:

"Return %true if the platform firmware wants @dev to be programmed
into D3hot in the suspend path, or %false when there is no specific
preference. On some platforms, if this hint is ignored, @dev may
remain unresponsive after suspending the platform as a whole."

And I'm not sure if it is necessary to mention "storage" in this comment at all.

> > + *
> > + */
>
> I still do not like this comment.  There is nothing about only using this
> for storage devices.  It is specific to a PCIe slot, and if I plug
> something that is not a storage device into it the same restrictions
> still apply.

Originally, it was about storage devices IIUC (and that's why the
property name is what it is).

IIRC PCIe link management was broken in some NVMe drives and putting
them into D3hot would allow the link to go down later and it would
never go up again.  So you-know-who decided to avoid using D3hot for
all NVMe drives and they were generally characterized as "storage".
Alas, that turned out to break other things depending on the devices
being put into D3hot (like PS_ON) so the property was invented to
allow OEMs to mark the configurations including the devices that
actually worked (and Linux was/is on the receiving end). And
originally the property applied to the endpoint device under the root
port it was present for (my personal opinion about this doesn't really
matter, so let me avoid wasting time on expressing it).

Now, it evidently has been re-purposed to mark PCIe root ports that
require devices under them to be put into D3hot in the suspend path
(and it now means any device under the root port with this property,
at least in some cases).

> Also no need for the empty-ish line at the end.

Right.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
