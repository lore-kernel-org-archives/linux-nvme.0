Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB51C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1016A24656
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEAUYGqW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saTYAymW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1016A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmWRzmLPzjk3C1oU+xaPcFe3CEt7e83kPDC0SnW799E=; b=WEAUYGqWQXY6PV
	sZx/XliVR52fTCWuzUCPmr71BVmNTt5guSHyVCr4reJvYDcLVZs3kYK9f+eCLDf5tI+3Nmt9jSwy6
	3QFSdTYFboPK+ns71uTegXLh1tzeNOVfkz685ZUNtviU2L7P64uD+L+3fFIBgp8Qf0AFZEEmqFVx8
	5wzCS7LVx8O5TAgsIBjILck+WLlaEZbKN1O7vB8osmYAXzOQDsMr18e8AylJTVS1S8FcfDoc5ex1M
	q2Z1eZFFumCLx2izmEE2lss9ZtT0lunSHWONi6Z2uJVa/ovGzbvTUkYx5pJDJo8OGWWj6IfludPRg
	F5KiSFF09a5rJS2C5Tag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if40o-0000Yr-8i; Wed, 11 Dec 2019 15:34:50 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if40l-0000Xs-GB
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 15:34:49 +0000
Received: by mail-pf1-x444.google.com with SMTP id s18so1974345pfd.8
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HVbcFREEaAqSDDWDOprFJiM+U7AawLPMDqSvqgEPZVM=;
 b=saTYAymWtQJVo2xDI5CVVPD7OFscZvr3OmDkn9R98p/K2QPfrErbyRBfLSWuDw82Je
 o5ei0YTQ5fgmkh7BZCrXIsR8OBZyO/sfNZyPb/2FHmifAkGNyAGukafSKofRjuTXMFXl
 WMQxGPuD9wxK4yLU1VhNzWYYmxihNPVzCRYgjRidEsjCXlEHWzI7tLoB4bV+Tg3p4Myq
 VXt9uBaV6jd+hJ6IiKy+pcyDX7aXRViVdLgvrrtrP2D7MFxBpcCNbOct/mx5x6fZqNzY
 wB9Y8YH11zoDDTXPnrVGiEROE/KKqb2trAGgVZw0dOKu3YAS5kWfyPCL9O/gC/FZ67Mj
 Od8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HVbcFREEaAqSDDWDOprFJiM+U7AawLPMDqSvqgEPZVM=;
 b=Nq2QRijB2v2GRzE+MDa8y9cNM5RusWb9RpENtFqtQgnefenRxX/fNg9SybOw9t9WQW
 ECYaokBUzHRlfGrNimtheGJsldPElpTUMyL8HGIA9gnRgReG6Uvrz9znzp/XfkrLP3HD
 T03So8SuNYxm2w9MybQ0Rpdlhw7MV7TftH09/y2cs7IJgkIwB+Xtv1MyD83irvPOpgh2
 I5GVCCvWXML/zxNB0G8wyYPMkwGzc/GUYTfqFh6L7TGelE5WLH9fSYDhQQc+AIvffFFY
 8OJEIbyPTyOLRfkBqGSkwMm2EiSyFVTZQ7UmPorSl8e4YKATXhR3+Mbfc+oPWuL565vY
 PaEA==
X-Gm-Message-State: APjAAAU/zbmQsEXnvfMvSJsp7GC70lMkzcAApeIqJXa1/ebN14uW0SEZ
 V8R5XtvKAkuZ/GT2C0PgqDEQU1ks2nwRw/tnmKs=
X-Google-Smtp-Source: APXvYqzJ499NHPqVSLLyDUscDbmBddDHmzhr28AkkyOZGKxqfxHIirybt8amARCuiU4PKcyZgP8Qc63k0WPAFrMp7QU=
X-Received: by 2002:a62:1944:: with SMTP id 65mr4526218pfz.151.1576078486945; 
 Wed, 11 Dec 2019 07:34:46 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Dec 2019 17:34:37 +0200
Message-ID: <CAHp75VcsfbkG7n6FHkpnPN0sG_PdKg_iKS7VGfATxuPVYU5jcQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] add header file for kelvin to/from Celsius
 conversion helpers
To: Akinobu Mita <akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_073447_540627_ED77323C 
X-CRM114-Status: GOOD (  18.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Stanislaw Gruszka <sgruszka@redhat.com>, linux-iio <linux-iio@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Luca Coelho <luciano.coelho@intel.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Christoph Hellwig <hch@lst.de>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Johannes Berg <johannes.berg@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Intel Linux Wireless <linuxwifi@intel.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 linux-hwmon@vger.kernel.org,
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 4:38 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> There are several helper macros to convert kelvin to/from Celsius in
> <linux/thermal.h> for thermal drivers.  These are useful for any other
> drivers or subsystems, but it's odd to include <linux/thermal.h> just for
> the helpers.
>
> This adds a new <linux/units.h> that provides the equivalent inline
> functions for any drivers or subsystems, and switches all the users of
> conversion helpers in <linux/thermal.h> to use <linux/units.h>
> helpers.
>

Thank you for an update.

For non-commented patches
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> * v3
> - rename new header name from <linux/temperature.h> to <linux/units.h>
> - add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
>   use them for implementing other helpers
> - add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
>   the hardcoded constants
> - add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>
> - add Reviewed-by tags
> - switch iwlegacy driver to use <linux/units.h> helpers
> - switch iwlwifi driver to use <linux/units.h> helpers
> - remove unused TO_MCELSIUS macro in armada thermal driver
> - switch qcom-vadc-common module to use <linux/units.h> helpers
>
> * v2
> - add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
> - stop including linux/temperature.h from linux/thermal.h
> - include <linux/temperature.h> explicitly from thermal drivers
> - fix s/temprature/temperature/ typo in commit log
> - use deci_kelvin_to_millicelsius_with_offset() in ACPI thermal zone driver
> - don't mix up another fix (format string for cellsius value)
> - add Acked-by and Reviewed-by tags
>
> Akinobu Mita (12):
>   add helpers for kelvin to/from Celsius conversion
>   ACPI: thermal: switch to use <linux/units.h> helpers
>   platform/x86: asus-wmi: switch to use <linux/units.h> helpers
>   platform/x86: intel_menlow: switch to use <linux/units.h> helpers
>   thermal: int340x: switch to use <linux/units.h> helpers
>   thermal: intel_pch: switch to use <linux/units.h> helpers
>   nvme: hwmon: switch to use <linux/units.h> helpers
>   thermal: remove kelvin to/from Celsius conversion helpers from
>     <linux/thermal.h>
>   wireless: iwlegacy: use <linux/units.h> helpers
>   wireless: iwlwifi: use <linux/units.h> helpers
>   thermal: armada: remove unused TO_MCELSIUS macro
>   iio: adc: qcom-vadc-common: use <linux/units.h> helpers
>
>  drivers/acpi/thermal.c                             | 36 +++++-----
>  drivers/iio/adc/qcom-vadc-common.c                 |  6 +-
>  drivers/iio/adc/qcom-vadc-common.h                 |  1 -
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  3 +-
>  drivers/net/wireless/intel/iwlegacy/4965.c         | 11 +--
>  drivers/net/wireless/intel/iwlegacy/common.h       |  3 -
>  drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |  5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |  6 +-
>  drivers/nvme/host/hwmon.c                          | 13 ++--
>  drivers/platform/x86/asus-wmi.c                    |  7 +-
>  drivers/platform/x86/intel_menlow.c                |  9 ++-
>  drivers/thermal/armada_thermal.c                   |  2 -
>  .../intel/int340x_thermal/int340x_thermal_zone.c   |  7 +-
>  drivers/thermal/intel/intel_pch_thermal.c          |  3 +-
>  include/linux/thermal.h                            | 11 ---
>  include/linux/units.h                              | 84 ++++++++++++++++++++++
>  16 files changed, 139 insertions(+), 68 deletions(-)
>  create mode 100644 include/linux/units.h
>
> Cc: Sujith Thomas <sujith.thomas@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Stanislaw Gruszka <sgruszka@redhat.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Intel Linux Wireless <linuxwifi@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
