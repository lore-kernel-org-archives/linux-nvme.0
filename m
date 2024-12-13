Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7785E77180
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTlv0Kdx+HiRvhP2J0+4YevtThUTN6crVLSeaVVJ+ek=; b=JyjvdXhb8dV8iMNLzHcvcUwAfp
	bsCSs0Nwg615Uae6N8WYsKujNqFWjuAYhC0VXJoiRjuN6gKl0HIHCmKjBS7sjR2FPZXgmmTwbP4sY
	tmgQMht1n+ecvb7gNMkxBSVXx+pSwxOhPuAGZw1KdK7iifX/CdF6tjg091jeWDNtpB+sJT86GgMIJ
	1eziEPc/LIb42sfYTPllQlc3dF7tIJ6sG+p5eW++OLjuI/jPfjJVZmL2yKQgr01X5rd8ApQSYDmBp
	0kiIDtf+OOm8hmyUKRpUDKlxKxfhpAs71VetlXeHr/HWT6daDODOCp7P2XmX5K3Kopghwmw+REZBm
	lYf7Ag/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM6nr-000000047bJ-1CkE;
	Fri, 13 Dec 2024 14:38:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM6lP-000000046no-1pKV
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 14:35:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D64C75C6937
	for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2024 14:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA74C4CED0
	for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2024 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100529;
	bh=rNJFAtYA5eksohwxJIjGyRtuHzibdqKAMtZF33hOZnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aCLTi40WpRvvI3pctHkHtG7heOhhIY6DGzk9kSNcLD7Nv/0yBQV6cl8dbDZfD/TDr
	 UrLwrUuMjvb9AyXdf5CuIvx2Sl2mTOMJjPcffycQIh95apIIJKGU4ym+LUicZWGYVd
	 MEzT0R9AyUZXtiNw8fzIYvDq4PtWBvnpOGtx853ZJk6hkfMhIdmamG8uAH8LSnsvPm
	 FajMigcU3wz+ZxiHHWR3BYPZiF6jMxU4v64FxOpZHNbyVguS9PAsEBgxwY+2TnlL7Y
	 Fq3X5fKMOekEsHWXOdlZDvlK41lzOdBhCrE7CHCGx2DmEtfprST3CjRCeITS/VOqd1
	 jMLzNvXmwTanQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eba347aa6fso756967b6e.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2024 06:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC2b4c8bvg3bCbRg7Yu2L2Yv07QZrIHHqkMsHMRQBKlGg4RDREc6iSTCurwpxTpQWMw84GXRrk38IP@lists.infradead.org
X-Gm-Message-State: AOJu0YwBdwSqDGjDnleUw6lrrW39WVGWZ6NsH4+bGigUsI4TN/tZUWSc
	bk6g9lK5PKL4K7lV+tL76PT4euO4ZKqpbP0mfcyfWgXobN6Ex8UIckktFnFl0WAdG7hx74hJDT7
	dM9zswQKLQb/zjIFlWjR1QGfyo8w=
X-Google-Smtp-Source: AGHT+IFfOFfVyFc4e2ZBGKXJgwfpRMnnYPRRl89VhFh3RmkUkQjqu6RTHIO8ptQLeagYlw8Qi6Fx0hYaADxx5ZLz+kA=
X-Received: by 2002:a05:6808:13c6:b0:3eb:60e9:eae1 with SMTP id
 5614622812f47-3eba6948a1amr1662834b6e.29.1734100529125; Fri, 13 Dec 2024
 06:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de>
In-Reply-To: <20241212151354.GA7708@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 15:35:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
Message-ID: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_063531_571445_0B9BE4CD 
X-CRM114-Status: GOOD (  22.79  )
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

On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > Right. This seems to somewhat work for ACPI types of systems, because
> > ACPI is controlling the low power state for all the devices. Based on
> > the requested system wide low power state, ACPI can then decide to
> > call pm_set_suspend_via_firmware() or not.
> >
> > Still there is a problem with this for ACPI too.
> >
> > How does ACPI know whether it's actually a good idea to keep the NVMe
> > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > only for S2R and S2disk!?)? Especially when my laptop only supports
> > s2idle and that's what I will use when I close the lid. In this way,
> > the NMVe storage will certainly contribute to draining the battery,
> > especially when I won't be using my laptop for a couple of days.
> >
> > In my opinion, we need a better approach that is both flexible and
> > that dynamically adjusts based upon the use case.
>
> Agreed.  I'd be happy to work with the PM maintainers to do this,
> but I don't really know enough about the PM core to drive it
> (as the reply from Rafael to my mail makes pretty clear :))

I'm here to help.

Let me know what exactly you want to achieve and we'll see how to make it w=
ork.

