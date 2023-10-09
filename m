Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B3ECD68F4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 04:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vntWR/EJpWFamZ/9NMXVbCLlV4xDhJbERcnlqbMN6Xk=; b=WUYY5GmCybmhhRzWsFiLNaAAUo
	T+TOdz3Bsl41MzK2o9fDxASXujHCryxGJ5sYDFCiNuuGtmNj+NMUvO9HedQSpcsTzPX1daT+Cnsdg
	CrBL56E+PJh9TDu17x/TMkkDh2EKOWVXaCJHaI1o/uDDQWOnTn1uqdEq50JayLE8WHrEiNCuESwpJ
	n6Yc42UilSStUAPW6kQKkQHqVQlZfDDsG21M+yMNvUZHlKC2wwS5GrpzKWJiYIC7/wvQ12dAbaL8I
	VrjaA8aEuMddj1yTCTJmVcHcHXA852ohgNZT3yNx17JapEOenc4DH6y17CM5uLI4vYhDfPiTnnws6
	F3IKD0MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq4YH-00CMBv-2Z;
	Tue, 10 Oct 2023 04:41:01 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpwW0-00BXd4-2P
	for linux-nvme@lists.infradead.org;
	Mon, 09 Oct 2023 20:06:10 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bff936e10fso71348911fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Oct 2023 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696881966; x=1697486766; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vntWR/EJpWFamZ/9NMXVbCLlV4xDhJbERcnlqbMN6Xk=;
        b=VVm9Yhy3F8u7rwE/wqDF1intlVX1uiiqsYwPrZekDpRjtFXJcqg6cn7nD/HOQQ6pX0
         ujqfk0mRWLt/5QYZKcTajuKuOjKABFCUZEGxcSP4R4Fi0B0Q7y72Re6QwNHqzMAj+F2f
         IWn5+krXlJAg6A8Mf6t1OB1wa4L2GxQdKeVTKZ6XYGnkgn9MpjaEmmnPea+hRj3tFFTt
         WoVeO9S+bKtD6LAzs6oNSwvPFcG71SSOaPKUbdz1sV+SALKkBCPfBbZkx83WvnOfFXVP
         LWbVpS6/ZhN0wYPqG+aq/QT1i5PvOpUq9yw3yLD/uyaR6V08uUAC7XqaEpOsbq6VurLe
         Qu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881966; x=1697486766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vntWR/EJpWFamZ/9NMXVbCLlV4xDhJbERcnlqbMN6Xk=;
        b=gsnsXr0H1C7DHYhJnfovYFxeWg5W22BppGNRFhZmhQxwV72vYXPHUAOz5uUXxT0YKj
         /B+TRYEhnPg+c8+9EsItcG1XYXxFd/Tin67hleAqZbpbq1UQ0RZx3rpRlTHElTXg0A2a
         eTRNG0Zu1Tnyyxmf7P+Rqbz9dzGZEZTiBV1ES1G8pbmHohW7ZQSzGnTFfIF6wwuseL/Q
         +3a33g0QasRu+DqSTVmUNQwbqgzACikTstEHvDbpRQxVCYKqo9i/iaXfc8aTfUc7vGHf
         6e0joQHw+dgDRhKDkKsagne37ky5LSzbA1AM4EoF7ECj3+QDkdaHNB/jWFMaRAEsROBL
         H4BA==
X-Gm-Message-State: AOJu0YxfEOTUGCzh6FZ0BPmYVP1KyQoqD0YLpXdG1Js1qtKFO1ldobsS
	4OvcuuwbzGJhSg0WooubzkkBFW0vVSZzeN/X3/br/Q==
X-Google-Smtp-Source: AGHT+IFghqg7b3VfDVvZ+soPEwEaIfxhrwarlOcz2b03PC3KagC0O9BH1UGRNCP79pJ8yT5JMzxC/VoYSKvtKG/y1ws=
X-Received: by 2002:a2e:870c:0:b0:2b6:cbdb:790c with SMTP id
 m12-20020a2e870c000000b002b6cbdb790cmr11535962lji.1.1696881966432; Mon, 09
 Oct 2023 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com> <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
In-Reply-To: <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Oct 2023 22:05:55 +0200
Message-ID: <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Jean Delvare <jdelvare@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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
X-CRM114-CacheID: sfid-20231009_130608_980192_241D9F7E 
X-CRM114-Status: GOOD (  15.58  )
X-Mailman-Approved-At: Mon, 09 Oct 2023 21:40:57 -0700
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

On Mon, Oct 9, 2023 at 7:24=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> Also, I don't know why checkpatch is happy with all the
>
>         const struct attribute_group *const*groups;
>
> instead of
>
>         const struct attribute_group *const *groups;

I found out that checkpatch has no check for this at all; it does
complain about such lines, but only for local variables. But that
warning is actually a bug, because this is a check for unary
operators: it thinks the asterisk is a dereference operator, not a
pointer declaration, and complains that the unary operator must be
preceded by a space. Thus warnings on local variable are only correct
by coincidence, not by design.

Inside structs or parameters (where my coding style violations can be
found), it's a different context and thus checkpatch doesn't apply the
rules for unary operators.

