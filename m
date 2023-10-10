Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE425CD8CAC
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6c9ziF43dDtJXvWYvRCgiJ1BZExyV3h3M0WIsu3jak=; b=MYD6u1NaNQCK5AExiggPScJ7Ei
	ej9WMtM+1B2K4gAzOdvh/sr5Ue7C5m/k569DpybZbVNGAnj1BiHn1rmuUGrn9xYa0E4Lb3kBf1+wH
	sJ1QXRuIbIqmUu1cNkpk3RPoo8d9bwgFbFxRhTITeN8drzWJmrrZTdSvcWMTlVLgRJxiKfcdrH9XX
	h21eEu+LcHuAgwEjqJCeTzHMb+zJ01rwUVrd4WmRTXjqo4kSwxRYm9xnNz/ipM2dZ3hS9t3gCoATm
	FYUKer0wEHzPGvhi7mFVGsheznKO1k3rLHwXDrre2Kgdl8TsrXkU4XLPJu0Uz5MC/30IUOZpzXlhZ
	0oWyf69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqGHv-00DpZ6-1T;
	Tue, 10 Oct 2023 17:12:55 +0000
Received: from smtprelay0013.hostedemail.com ([216.40.44.13] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq6Xx-00CcrA-0k;
	Tue, 10 Oct 2023 06:48:50 +0000
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9630C1201A7;
	Tue, 10 Oct 2023 06:48:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 379272000F;
	Tue, 10 Oct 2023 06:48:11 +0000 (UTC)
Message-ID: <f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
From: Joe Perches <joe@perches.com>
To: Max Kellermann <max.kellermann@ionos.com>, Guenter Roeck
	 <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>,  Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>, Jean Delvare <jdelvare@suse.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bart Van
 Assche <bvanassche@acm.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>,  Jiri Slaby
 <jirislaby@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike
 Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, Leo Yan
 <leo.yan@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>,  Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>, Sebastian
 Reichel <sre@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>,  "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-serial@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-scsi@vger.kernel.org
Date: Mon, 09 Oct 2023 23:48:10 -0700
In-Reply-To: <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
	 <20231009165741.746184-6-max.kellermann@ionos.com>
	 <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
	 <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: x66gji9pr8zwbank5ef871m9qoojjjfr
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 379272000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19bm9nHqj2XrX3TKwatvC/C1GajNvD5h9I=
X-HE-Tag: 1696920491-749924
X-HE-Meta: U2FsdGVkX1/+029EmPc9sKVNFK2VRUjBCte/A2E+5y43hxFCP+MAKFoIxkcikfn6Jucu52vLqnvIqQDvdm6WvqlwnI8PH42O3yPwjrf6/Rk44z8SFUR40tWN1QdYZq3HPOEvKn0PLMPTqRRMr7zlpFwkMW85ySQYIyr+J8E4OP6W/LoiP3zYhR+0cmnV5ToftIwEMltweE+g/zUx+NL1fSjTbqk3Sf4w33VMSw7k9oncskJ8CUN/bQZEOiHhpNbgGpLqoQJ7ob3InQymsj8a//o/6ldtQbuoxFCk/RnYuGfC0EahOFEMbfIs5+kJ0g+hK4chvkcdMx/L2QmQgmCvPhqiadvx8BYdkeJ2IpCV5Y5g+W85x67f7ON0uqOVXWab
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_234849_347432_2E065038 
X-CRM114-Status: GOOD (  20.93  )
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

On Mon, 2023-10-09 at 22:05 +0200, Max Kellermann wrote:
> On Mon, Oct 9, 2023 at 7:24=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> > Also, I don't know why checkpatch is happy with all the
> >=20
> >         const struct attribute_group *const*groups;
> >=20
> > instead of
> >=20
> >         const struct attribute_group *const *groups;
>=20
> I found out that checkpatch has no check for this at all; it does
> complain about such lines, but only for local variables. But that
> warning is actually a bug, because this is a check for unary
> operators: it thinks the asterisk is a dereference operator, not a
> pointer declaration, and complains that the unary operator must be
> preceded by a space. Thus warnings on local variable are only correct
> by coincidence, not by design.
>=20
> Inside structs or parameters (where my coding style violations can be
> found), it's a different context and thus checkpatch doesn't apply the
> rules for unary operators.

My opinion is that const use in the kernel should almost
always have whitespace before and after it except when
preceded by a open parenthesis or a newline.

$ git grep -wh const -- '*.[ch]' | \
  grep -oP "[ \*\(]?const[ \*]?" | \
  sort | uniq -c | sort -rn
 222438  const=20
  83386 const=20
  51667 (const=20
   2766 *const=20
    834 const
    442  const
    343  const*
     88 *const
     37 (const
      4 *const*


