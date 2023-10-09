Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCACCD6115
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Oct 2023 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHSd56ONGtiYc/4iRkmyqmxuAngFJzU7FR00LimB0+s=; b=eHSZ5QNHJcSyEHMZaP8zuiOSBO
	1ROHZ8xIHYgmjUhRB2W5p4UGFijbm+6XdmKml5+l0wl3qR3FqL7R2ZQ7vdzhU3c2oRI/zRhARtzJT
	ZlUiQz6SaqXth60r0p/EIpn0DdIQdT4g1X+9dX6uhXue44aSckePBjfDOfpPbGJJiyjc6WFEN9xs7
	5FUGsrZPET/+azcj8F+EACr75fCQpdDe1/OlxR5VKvcDYAW68YYeyx5lYVxYTfh1tGc5/7JgDMKaW
	2rnRm2QTiptSmtxQtuQzYp1FD9p+90EG5TO5iYfRfFka6QrXUBGHqBT6lwHb5R9a7OX4kiDMrS/ky
	W/WkIuzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpuB2-00BJdM-2k;
	Mon, 09 Oct 2023 17:36:20 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpu5W-00BIDn-1E
	for linux-nvme@lists.infradead.org;
	Mon, 09 Oct 2023 17:30:39 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so60811131fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Oct 2023 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696872635; x=1697477435; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHSd56ONGtiYc/4iRkmyqmxuAngFJzU7FR00LimB0+s=;
        b=LSAVJ2hCn+94jNNWFHRIxpOSg8BsouZbyCTwaEb8kRJqQqB8znIDejfEppY3ToyI5o
         WLWw0EBBoS9oBuZMCAod79ku6L+a87H2WfPzeaTH9st+VbE62QJSkSvobKh9tohJZYEn
         pV0i50t+DcWuRdhnxdPRRyWHt61lr3NoQDwwiFnBKDKI9Z59FWBPYlleg4raRZ67BuHZ
         lYN1WeNDH8ojXR8jBdnZlGWPxEpXJrWtlS67MLTGai89JWDeIC06x2cuY6/ZCOrSA9XA
         mB9GPOwXza5Uc4m6G7wqpY/OmbSMZhowefU659JwgRE5na8JS9e6/tyP+X3jFPliNrK+
         ITLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872635; x=1697477435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHSd56ONGtiYc/4iRkmyqmxuAngFJzU7FR00LimB0+s=;
        b=DYmZxqPHQ3i+S6dw7WoSG6Xr7k5CJDA42My93aVxQaeB6UzVU77mj05+wTebHuPnTQ
         L2bvKUMjPbL/SlWDV6wJm8N74hkh+LcXzCf4gUlaXiagMUHXx/dEFHr5FqaKXMDdflib
         iFZGZVO4mv91BBpeg/rDrh5awNle5ihGaVaeqcRfshDlEWzkLdCS/EV29D2nl1TF5QHe
         dYApIeWMo1IKK+dB9umALFVlh+IlsmJnlxuCgVYMlMjKgIFylMFy7ODEF046ttaBLhxY
         5bk7+a5OHzfoQEQ0hotEumBj0ZLe7qJm04RhmLu6GH65PsWKMaOZfNSHGSmyQbm5MzLc
         OgZQ==
X-Gm-Message-State: AOJu0YzVw5V6hmjpFFGV/k+comJYXZUP+tOkDR+I/Zb/1SSXBntMsCJL
	4WB/iiizvGaoQZ6Xt9JNPhU+CUkd85aLQlRnx6rFUA==
X-Google-Smtp-Source: AGHT+IHBRA959tJKQ7jnBDww7hLjflOoCbxbxU4OC4L9uyovk7KidWNus9mZc9b5/3C/KVDAr0hL4Kjy/lMZJqv9EF4=
X-Received: by 2002:a2e:86d6:0:b0:2c2:9e5c:2c82 with SMTP id
 n22-20020a2e86d6000000b002c29e5c2c82mr13644840ljj.46.1696872635192; Mon, 09
 Oct 2023 10:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com> <2023100921-that-jasmine-2240@gregkh>
In-Reply-To: <2023100921-that-jasmine-2240@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Oct 2023 19:30:24 +0200
Message-ID: <CAKPOu+8Tb2CopWgBN29hmJrmU9mjG63PyVoaewuY0FYj=aGTZA@mail.gmail.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alessandro Zummo <a.zummo@towertech.it>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>, 
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-serial@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_103038_421286_8D245310 
X-CRM114-Status: GOOD (  16.38  )
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

On Mon, Oct 9, 2023 at 7:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> I'm all for doing this type of work, but this is going to be rough.  You
> sent patch 6/7 that hit almost all subsystems at once :(

I wasn't sure whether splitting patches was desired. In the past, I
was often asked to fold multiple patches into one. There are so many
opinions :-) but I'll gladly change to whatever is asked.

> "*const*groups"?   That's a parsing nightmare, really hard for humans to
> read and understand.  Doesn't checkpatch complain about this?

No. I'll change the coding style (and maybe take some time to fix checkpatc=
h?)

