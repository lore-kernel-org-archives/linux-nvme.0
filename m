Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C813CD6118
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Oct 2023 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+99ERTETs1SOs6pbAOMlQDoNcerfqUwnkmaN+AEx1yo=; b=uEESgE/9Tf4ioOmpFLHToCQhkC
	bI4vz/t2ve8O0BDzVOt9AK76RRKlIkat02VnOy5Mje6wCLPYMtQOiIuHCpDfYADRARThS9K+4xSkx
	oapwfFAu54hOjoV81UvPr72eXwU8BWcEXfee/Cop2PVudLgoGaiTrJ0pI4bNIrHp7hRkw/B15YoOz
	1lCgma5QbOO8IfuHrKCCpYcokmk9MKdIO8+InhSfxD4v2xT8xoygMrVCEgoPQ7O6cNC/2ghdzJ1h2
	sX1Fpy9Q/FkzYEu3B2MuakksemvveJwqk6RuLOUoIbe9+NhFFBVo6oPgBVJfTUYkCzVwd9YPiqvBU
	jj/MR4pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpuB2-00BJdA-0k;
	Mon, 09 Oct 2023 17:36:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpu13-00BHoA-2U;
	Mon, 09 Oct 2023 17:26:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 16F7761299;
	Mon,  9 Oct 2023 17:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B86C433C8;
	Mon,  9 Oct 2023 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696872360;
	bh=Xvq7hDU/coDuEsdrXCSvDDCeu4fDcSPbyB2v1f0haJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LH/vqB4X1j5QvSSkBM6vklj2Pb9c2SspT6NgEyJDP9vbRIpWR6CQ+nJkcsCjQ4Vir
	 43qqnL24pp98K8WJjk6l/x23d5SHHpCaxfpNhOF9JsbcR9rYVEP68LmxblNqxA33nb
	 6ckKZ/2qQDECOCthGRjyk9BmKLlvlEvFYD03WIdc=
Date: Mon, 9 Oct 2023 19:25:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <2023100921-that-jasmine-2240@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-6-max.kellermann@ionos.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_102601_898130_123B8B90 
X-CRM114-Status: GOOD (  14.31  )
X-Mailman-Approved-At: Mon, 09 Oct 2023 10:36:16 -0700
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

On Mon, Oct 09, 2023 at 06:57:39PM +0200, Max Kellermann wrote:
> This allows passing arrays of const pointers.  The goal is to make
> lots of global variables "const" to allow them to live in the
> ".rodata" section.

I'm all for doing this type of work, but this is going to be rough.  You
sent patch 6/7 that hit almost all subsystems at once :(

Also, the code:

> -int driver_add_groups(struct device_driver *drv, const struct attribute_group **groups);
> -void driver_remove_groups(struct device_driver *drv, const struct attribute_group **groups);
> +int driver_add_groups(struct device_driver *drv, const struct attribute_group *const*groups);
> +void driver_remove_groups(struct device_driver *drv, const struct attribute_group *const*groups);
>  void device_driver_detach(struct device *dev);

"*const*groups"?   That's a parsing nightmare, really hard for humans to
read and understand.  Doesn't checkpatch complain about this?

thanks,

greg k-h

