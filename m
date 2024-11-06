Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF0D44D57
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=; b=iY2iiSS+iyzRE1QTdc6qlpYRVm
	E5wOq++3hLTqw4lWyc95t/LBuAzjJ288coAo7lyjGXHKWmQS7qZF/WxVJuTkdEmtlwFOk6Jwq6J1C
	2n8CxXS1NKQ3nDVHEQKBniMHv8jKy55D07T4T6z8cEcYxCL0yAfogz5gxUGSpeRxyhDPzxlxwvDNL
	A1pZ3HjuLRoEb1cicRtqnXg4iH4zr0efYlHgZ8FZLlTHKlW51YbLRFxfEehMPXBYRseMYVPooctYC
	Ic6CnmPRGKRT0drMaJRw5xNVL4h3mHFH4zuOs5NliNofqQcdUZkrEhFRwKBzK0fCh7p+nZBXnlmVk
	YsOEK5lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h1H-00000003bUM-0P92;
	Wed, 06 Nov 2024 14:28:27 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8gzY-00000003b1v-05Yu
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 14:26:41 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a9e8522445dso719574266b.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Nov 2024 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1730903197; x=1731507997; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=;
        b=LuOoaAojT0u2bNU4LlHeI9YGU5S1UtussU88kjCPk2ZrxZBXAKe0OcFgRp2xYJNZvc
         49rTurmT0WLx1vRPQV9z9UmegUfs+yNw9lPhqa2zoU53V5mtOEoAgk/kPye/a/i5digl
         gcIZbVuXaAJeavT8dn9OrwbhQDS9K8m/Ub+yATyAc7eHkbCWAlsW/9fbKojF6spUctg9
         wk+vbFuxb6LaRnTdDWTE9o4vE3cQewTaIswIil8bD6TW6rgUuVsk0VFS8Isu/5DQnFfj
         S3Tlf97chvrAfx+rc2Sd6phmjhBFVjAEYW9q48W0MWWDp3Dpm9GsJQZXBnLaKgZPjJO3
         q4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730903197; x=1731507997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipqB5GhZfhZeP6+Fw73KMpW7vTqNOHY4wT9od9XDnNU=;
        b=PJsSs3BU+Wy/nm7q+2MrSOW7bUiYPvOYghJM9piM79h3JAxGeO3BEvGK24UVbSW3Q8
         TJcfZGUINdVIPraMKYVtueRp9ENXnbXsBWMfwqFVXJKH6UrKOJZSA8pExTZJEhRb5nxs
         IxdlO1O6vGWBm7ISMDjOCVres3fIr4B4/Zet/HA0tsb+z5U+jHqmA3A7hKhH1meg3xvJ
         a2QD/rIKvidTTVuvgHRy2UGaekU2aj8owPu+QIPqIKBLFlK41DC4xITOXLCs40mcDyzv
         tamiFcRgPVAv3qNE9ZCoyuO8TEaShNbeWV8teyqAn72Y3ALvmK5WtVLXoVRroC/g/Ibh
         uVtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhVCdSQ35qpq0gj1DL4t9R3HRCn62nK7bq5NoyetrAdfeJIQj3wZl/uSglsUy7PEeZhd1gntKHeT/A@lists.infradead.org
X-Gm-Message-State: AOJu0YyZPETE2OSDH3QS3pYOxrO4RCc6SIEjrxhvhzXpeWy1cwMs3Ayg
	PNLIrGOoChTqkOhDs6QGx1KxXLt7XFkN1xSLhGvpxOhOVDD/fJuE+NXdJUu+WsSuTW3D9DJG8Fm
	jAvuklVueMc+btuHQlg5YMeGbkW88oUrr534oWQ==
X-Google-Smtp-Source: AGHT+IGTNjawymGmZtRv6kzFPFouB6jfAmX0w1MWjwjaaSmC15ADSV9RR263VUeTaevgARYiFWCXry3+rk2bBInzbBw=
X-Received: by 2002:a17:907:2dac:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-a9e6587df7fmr2121988466b.52.1730903196776; Wed, 06 Nov 2024
 06:26:36 -0800 (PST)
MIME-Version: 1.0
References: <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de> <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
 <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
 <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com> <CANr-nt30gQzFFsnJt9Tzs1kRDWSj=2w0iTC1qYfu+7JwpszwQQ@mail.gmail.com>
 <ZyTqZ3UR39VTHSA2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZyTqZ3UR39VTHSA2@kbusch-mbp.dhcp.thefacebook.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Wed, 6 Nov 2024 15:26:25 +0100
Message-ID: <CANr-nt0stXUn38EawwQPa+fGmgvHE7Ch8LH7tGyNp5NPpm1m0w@mail.gmail.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	javier.gonz@samsung.com, bvanassche@acm.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_062640_352641_7DA7B679 
X-CRM114-Status: GOOD (  28.35  )
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

On Fri, Nov 1, 2024 at 3:49=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Fri, Nov 01, 2024 at 08:16:30AM +0100, Hans Holmberg wrote:
> > On Thu, Oct 31, 2024 at 3:06=E2=80=AFPM Keith Busch <kbusch@kernel.org>=
 wrote:
> > > On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> > > > No. The meta data IO is just 0.1% of all writes, so that we use a
> > > > separate device for that in the benchmark really does not matter.
> > >
> > > It's very little spatially, but they overwrite differently than other
> > > data, creating many small holes in large erase blocks.
> >
> > I don't really get how this could influence anything significantly.(If =
at all).
>
> Fill your filesystem to near capacity, then continue using it for a few
> months. While the filesystem will report some available space, there
> may not be many good blocks available to erase. Maybe.

For *this* benchmark workload, the metadata io is such a tiny fraction
so I doubt the impact on wa could be measured.
I completely agree it's a good idea to separate metadata from data
blocks in general. It is actually a good reason for letting the file
system control write stream allocation for all blocks :)

> > I believe it would be worthwhile to prototype active fdp data
> > placement in xfs and evaluate it. Happy to help out with that.
>
> When are we allowed to conclude evaluation? We have benefits my
> customers want on well tested kernels, and wish to proceed now.

Christoph has now wired up prototype support for FDP on top of the
xfs-rt-zoned work + this patch set, and I have had time to look over
it and started doing some testing on HW.
In addition to the FDP support, metadata can also be stored on the
same block device as the data.

Now that all placement handles are available, we can use the full data
separation capabilities of the underlying storage, so that's good.
We can map out the placement handles to different write streams much
like we assign open zones for zoned storage and this opens up for
supporting data placement heuristics for a wider range use cases (not
just the RocksDB use case discussed here).

The big pieces that are missing from the FDP plumbing as I see it is
the ability to read reclaim unit size and syncing up the remaining
capacity of the placement units with the file system allocation
groups, but I guess that can be added later.

I've started benchmarking on the hardware I have at hand, iterating on
a good workload configuration. It will take some time to get to some
robust write amp measurements since the drives are very big and
require a painfully long warmup time.

