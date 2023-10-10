Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40580CD8CA9
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PbPxT1sSvRyDQp/e9n/Bbj4wr5MrWyZ0fFUXG4UTN3U=; b=q/JcNRD24sAAUk5IWng6cfqOVH
	Ok0Bm+pTtk3uAiiy7izn9MCUST2FLQ65XPDRmIkk9HueXbpVy8F/fvPGY/wufu9iv5RCZatHoQq6l
	dz3aUa8rTtja46Yyn/oNDhV3r29jJAtcfK7MVjRxMGkAbvKA1HYSUWl+HCYnQI5b2zAOc3LGmr62U
	mRNxbvd/1sjnlTqk0pAgfxmVZIVA6p1xdLBWgdtfx0KieIu15OaNtjXzzgvD/+ReuNr7AjkgZ53bu
	XlBA5Jo5aFydh9UgoepIz8CO+Vf9o6HtsOEmupWORLTBW8A+XLd8X0L679JpLtI54g0HG10QWLhN0
	mpj1yhhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqGHu-00DpYt-2e;
	Tue, 10 Oct 2023 17:12:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq5lw-00CVyH-0A;
	Tue, 10 Oct 2023 05:59:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6BB7D614E4;
	Tue, 10 Oct 2023 05:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCE0C433C8;
	Tue, 10 Oct 2023 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696917551;
	bh=S2Vq73dxgI8Hax8ZDzPktuJJ9WTcUpUL+/KM/V79r44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kg+lbBI2WFWTfw1g2nP0OCMspsLaEmhAGl8iOsaj2cy/oJfzG7zS6LdyTH+rgqFJW
	 sxCvDQ6Jwy3j0Ae58keCkT9pNIKZqzy2q0BM7QcmVrgaG+duK+v7nL5BaVefquSsO4
	 loMdrlwL5KeekjdN5/LA2S/AHzLoLV9Rn2EfXKfI=
Date: Tue, 10 Oct 2023 07:59:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
Message-ID: <2023101025-yogurt-masses-47da@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com>
 <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
 <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_225912_185481_DD46EFF2 
X-CRM114-Status: GOOD (  20.16  )
X-Mailman-Approved-At: Tue, 10 Oct 2023 10:12:54 -0700
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

On Mon, Oct 09, 2023 at 10:05:55PM +0200, Max Kellermann wrote:
> On Mon, Oct 9, 2023 at 7:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > Also, I don't know why checkpatch is happy with all the
> >
> >         const struct attribute_group *const*groups;
> >
> > instead of
> >
> >         const struct attribute_group *const *groups;
> 
> I found out that checkpatch has no check for this at all; it does
> complain about such lines, but only for local variables. But that
> warning is actually a bug, because this is a check for unary
> operators: it thinks the asterisk is a dereference operator, not a
> pointer declaration, and complains that the unary operator must be
> preceded by a space. Thus warnings on local variable are only correct
> by coincidence, not by design.
> 
> Inside structs or parameters (where my coding style violations can be
> found), it's a different context and thus checkpatch doesn't apply the
> rules for unary operators.

Ok, checkpatch support isn't always required, we can notice that changes
like this obviously are not sane and shouldn't be allowed just by
reading them :)

thanks,

greg k-h

