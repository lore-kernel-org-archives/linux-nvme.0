Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1240CD6114
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Oct 2023 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzAdnPv6S7wemZW2LOvDdjej33oUOA4jt9qFcygegX8=; b=YsyZXv1gdtpiGtngmR42Tw8PYY
	h1zvf003wUviBzuFgwS1yY2k78LLq/lYaxf4Uuo4qNItJGHoYU8hLEKaYAjm+3QG29f4B2XTh6+NI
	01RyHG0hG/wIRfUeHl7/Yy5qwkNLbyvt974efqKm/65ZNEXsrJ/gPOohFjpPlv+un8114FM3A25aK
	ACVLs0VhgmTAN41QcUoCVJd2MiAzeiQlykHyo+OINhlfqLerzKor0Td0p0U/2Rbjzk3XETzM5yubK
	vfJluW0KrrAPu2MrClxUCqPO36pxe8RLu9F3HC/u8H+uYzfI6zJpg12dy7wpUFVdPoMDu0Z/eixdL
	yN7DbuZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpuB1-00BJcv-1x;
	Mon, 09 Oct 2023 17:36:19 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qptzx-00BHh9-2t;
	Mon, 09 Oct 2023 17:24:55 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso4225489b3a.2;
        Mon, 09 Oct 2023 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696872290; x=1697477090; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzAdnPv6S7wemZW2LOvDdjej33oUOA4jt9qFcygegX8=;
        b=VVPJhuz4580rd1XHL4jexh5oCaPHaEw3x/IXvszckT77EDJ3JR2I5XUSF6d9GrWkGc
         ZLo0aZFMnAurdtQHVsOkx3Egw8hlSjItWa9YFqnYsR2DtF8cCqlddaJ314+tiSFlGWdu
         HIZhaOs12c2VFoLm9UFoHa49PRyeG1yR6c0dLhvfOLbgBl8YYMOVxaTp4ibKSSKJMxja
         LrEkZck5cKYVi2wAMsPtncOMBYEv4OSUltAg907MGIkFcqPezGfpPFQdwyAmQ173Y09k
         LQCWTW7VU412NefR/CLgBKQwm4vv/dUnf7PEhFz8f10XU2lqQA2TMGHTWXGCB31zM1VJ
         smKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872290; x=1697477090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzAdnPv6S7wemZW2LOvDdjej33oUOA4jt9qFcygegX8=;
        b=n7ELvF/7/08pwbcWy/tCtZVpHhyz36F77r1avzXrIQJEIVOnIG4nlvsrIEkxf/oI4o
         2MGobwoZVCNH6Ac2uhFY330gyQ0pBco2vYFEfolweM1NlAU+qaIoG+eYLlODSPtkxJ/O
         k8ADMOtoG14+giXqLg2noBl5hhkTLO7UkshU9KRSrGdF1fiacOLXayyHfC3oG1oa9Law
         iIMP6lk0VLeh2w2j03hBuOjcVsXtjBt/yq6m4sSmvSB9bqiNDQW9/o13FOQa5LK+9kBz
         h76enrbJBSspzOjh39GHgnsKOpMjiAXzVzIPWelsS/EnV8hHltxENFRsLvj+5wpgWeau
         C/5w==
X-Gm-Message-State: AOJu0YyzDwQ2RS5dZ6TLwflPAvfPdEn31nJhHTcSei2U4uDpFBSTw6De
	sH3TPE+2F8NmowzRHQs0//4=
X-Google-Smtp-Source: AGHT+IH+tyPqS70qDikWknMDjzYLaNh8XUrbid6v4dI3mkvPqY7I02GkSEKBPm73V9X3Q4ayZd0Azg==
X-Received: by 2002:a05:6a20:8e05:b0:162:4f45:b415 with SMTP id y5-20020a056a208e0500b001624f45b415mr20823608pzj.51.1696872290343;
        Mon, 09 Oct 2023 10:24:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090a7f9800b0027b168cb011sm8557487pjl.56.2023.10.09.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:24:49 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:24:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-6-max.kellermann@ionos.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_102453_940726_DF30A772 
X-CRM114-Status: GOOD (  16.24  )
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
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

In my opinion this touches way too many subsystems in a single patch.
If someting is wrong with just one of the changes, it will be all but
impossible to revert the whole thing.

Also, I don't know why checkpatch is happy with all the

	const struct attribute_group *const*groups;

instead of

	const struct attribute_group *const *groups;

but I still don't like it.

Guenter

