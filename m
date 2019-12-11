Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C059C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 15:32:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C71208C3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQ1/4n+I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+0FmpCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C71208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kqndFrQRiILOrfUVIJfJajCvZDnCVIYFpxcmsce1zLA=; b=dQ1/4n+IrFPfy1
	Dv0TkoBk4zrgt29ZdPNCMfZkjjbS71sjkjkgELzu2KYkH2/Xlsi0U4ZM3LjAt9Z54sYsNwDC9RZZY
	79ucNCxFl3EHE5auc3xCH26uVZfKk5Q1Dso2inbAPda03MAhLUNWmJJ8Jd8eIqdydy5142/yVroam
	34UUsL6nP8JM8EXdK7lEnSYRHdHqqCQXhO9NVdeiaD0O1oibFb4Ui58kxd/GQvlQ+1w5Wsq/WewNS
	oFb2wKy/ECwhKb46ZLNcM02ZeNTFc99HF0ckr78ZU+uuMSHQmk3z+PwyoKLNtpSWfVjiTM9IUDWqg
	z9mCddDnx9vtjK+JNXwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3yE-0007nY-Mc; Wed, 11 Dec 2019 15:32:10 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if3yC-0007mz-UH
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 15:32:10 +0000
Received: by mail-pg1-x541.google.com with SMTP id s64so4212496pgb.9
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p+UAPggfsHMu2hFz0NBTkqa2kv+TjIeundnroZjYfRQ=;
 b=i+0FmpCViNvInrmecmJ8i6R+1Ufzx50kWEgF1ULO5Y/9CJ+rZxzfqUnXlEbwQYrNt4
 Iv1n5ncNxZRNNpLFmN+OnXFBWvDDh6pY73qn7GqDGnKrvOW17oqucM6KRgmQJW0acOK2
 w/lI2CW6sFO+5h3Ld6gry2Te9P2rIgAzvpaEp2oR2V8huertU0W6vFv6YD+GyDMwVlAt
 AxLlTZbQZ/0dHInrrgdZxBZ4MDvWqT2TLOK6QP5zGRoLd2OJtyurY/P05yt8J8V7R92E
 Y+MgiRVTIbCRqRj+eb9qac/Jbz+S4uvC2nEQWqMBTCNULh1OxrAEWsG31dvPRWum2dnH
 Qi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p+UAPggfsHMu2hFz0NBTkqa2kv+TjIeundnroZjYfRQ=;
 b=fDTAWKXbBQw8qeQ/BP7kYySz9l8RMx4CMhXuge34+EKNU8KwPYyQuD6EKZ4ppU0Tac
 nk6LqUw0KAx2/Zh/ina0xDm1SkMpGtEL4K7BOtBn4esWZerYIyjYDv2phuK6ukByXq0p
 7uhnbKlPDetefdSePtxzwzTP5+comj/4FqyLa2zPtGfGSh/dupYZS/0YlTylflqVIxZQ
 dvCWqMBm6dC4vQyxMuETLGvVbd585CHuKH+Q8gOtiXXaX12Cb+ltl/m0HDPTfh2oXlUn
 OqBZm7zb1lOodoW+dQe2bMsYlFuvSIF4rJ9y2qC1YL1YVmUV7gSOJPQ7XYHq5hjJeSpZ
 pvAA==
X-Gm-Message-State: APjAAAXbovYtTdnOOCI7djbwe5fvZHS8nBOZj+f6L4vXqOylFd5wNgi7
 AAP3WPr0GAwDTBB9/PSNwDfNyTEkZ92GLdBTMpU=
X-Google-Smtp-Source: APXvYqyCFB+DRw4z7MaU08fIr+Pce9/ZvY0VsbXU7kdzcOrMS3l4Tfsjbogj2wZ4yk2WVuVWgmYDU0mq/Ion5fRBIZc=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr4417883pfa.64.1576078328144;
 Wed, 11 Dec 2019 07:32:08 -0800 (PST)
MIME-Version: 1.0
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
 <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Dec 2019 17:31:58 +0200
Message-ID: <CAHp75VfSUafrg82WcfUA4LhSFaNQSgZp39oVQGD=M124urC=xA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
To: Akinobu Mita <akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_073208_978721_0E02521F 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: linux-hwmon@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Linux PM <linux-pm@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Guenter Roeck <linux@roeck-us.net>,
 Keith Busch <kbusch@kernel.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 4:39 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> The asus-wmi driver doesn't implement the thermal device functionality
> directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
> is a bit odd.
>
> This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
> <linux/units.h>.

> @@ -33,7 +33,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
>  #include <linux/platform_device.h>
> -#include <linux/thermal.h>
> +#include <linux/units.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>

Similar comment about ordering. Can we move it to the end after dmi.h?

> -       return sprintf(buf, "%d\n", value);

> +       return sprintf(buf, "%ld\n",

%d -> %ld must be explained in the commit message (e.g. "due to
function returned type).

> +                      deci_kelvin_to_millicelsius(value & 0xFFFF));

I prefer to have this in one line.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
