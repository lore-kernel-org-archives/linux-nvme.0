Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390B1C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKLUQCHfVgMEJnTrRslfbeGXik3U/rOoNt4N6SZRfTU=; b=OmOLsq73GyCV89VDZfHNhEbWBL
	T/r6TTNHK5zYmvEOpRG6pnB9COakZ9jegcaL6BJ+uJsdqksvhlhXcgT3cNaPz2yjJdZbtMf5exAKp
	MB1AajA7MnbZ6mcz2UwApa/tYrmd4qsUmrIOPVN/OvgZkYriUrbd/6RbeRpETAZrq8l6mayzaqBEp
	pYxqwrq0JljJgz7gq8jOsmXkjdZrGIteONO8inftbZaWOMiWtWjUbypsNdIOGO0/2loUF5aBjBrEu
	PLQ2nTM/G8N5k0yrCX4Qe9Pz2MMVnlz8fAhaWPI8I+JqzkQbZmqh+XpTzFlOf9h7pcLIfgTjVwdO8
	8zpfmhRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmWSq-00EXx9-RA; Thu, 05 May 2022 08:03:56 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmWRP-00EWpe-S2
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 08:02:29 +0000
Received: by mail-qk1-x733.google.com with SMTP id a22so2653360qkl.5
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PKLUQCHfVgMEJnTrRslfbeGXik3U/rOoNt4N6SZRfTU=;
 b=KavWwnzrf/Bkj6cOK4VQyb8WREwBkDnrhyUesJtEtcKMQEQnFkSxUXkShoWbl+Ph5S
 DGogpFH2S0Xbb9/p5jU1jHxyy15s81gy3LfzSq337RxR4ZVOn8yQE9VKAboqdTMtoQs7
 +XhHrCUFAzn47sZc5M4uggW4JYCw3wgSaMPf/4GzEW8DaN2WGJCZrduQ04VF4sA6LPcH
 tqDV8+oahOca0w3O3qp79rRYVMDAbRMWZvhrMvEfwwVsHqUt1LEimXA4Z9a/nb75EyRV
 0XYVZaOOeSEcdNeCXleUTwAfvri0qjqPcgoaOYo3azwc2T8JrsuMZCE1hMg3BNteleF7
 0cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PKLUQCHfVgMEJnTrRslfbeGXik3U/rOoNt4N6SZRfTU=;
 b=FbM2tkd+YwO/1GHoI7uV8aFM3tPjlNBA+OGPBx7K7jEKQ+2/oyewkSnsAQLfBM4vPK
 6jLgQZSKMYpadp7BKLj3BfoqJ7731EOK0IPkhDLXmO6Vr4Lx7b/+BjnQOoeSNjOHQMFb
 ek3JZBlWQM6eM0mBLvmAG6+yzwsX//VBvrRZV20Va9ZImi8R9Jndgx0ZWFI/24AO/NVF
 VCHggncPZrlM8AxOxdbaZs1uLa2YdxzqOjSwOmZWiKBQ/C73+aEhXM7pHjBfan5SgamU
 mRA9143gkkKc1Dokse68BR4bBdSmfB6mtD5mn1DGx/g5Ek/jG4c6I2bZ0mbnZi4Xjdlf
 BGVw==
X-Gm-Message-State: AOAM531KnbzXcPRxxL41sXMnObt+er0cmsFs+tzZpNeTNW43VR1RevXc
 II3wznwGkF/vPtbClol3Porxa1cMSrPTIZ9Qe2U=
X-Google-Smtp-Source: ABdhPJzV2fjGYRTFHgnPzgAXf7qjLmyXAgonvKvk1zHJEUnMlRsDVCcgldKjTzIcsqbeRk7Pj8DmCWXtuKo2HRfR+qk=
X-Received: by 2002:a05:620a:4105:b0:6a0:462:6b05 with SMTP id
 j5-20020a05620a410500b006a004626b05mr7811566qko.663.1651737743034; Thu, 05
 May 2022 01:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 5 May 2022 13:02:12 +0500
Message-ID: <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
To: Keith Busch <kbusch@kernel.org>
Cc: linux@leemhuis.info, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_010227_930094_39D539D0 
X-CRM114-Status: GOOD (  14.65  )
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

On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> I think you did misinterpret the results. The max latency just says which power
> state is the deepest it will request APST, and your controller's reported
> values will allow the deepest low power state your controller supports, which
> is known to cause problems with some platform/controller combinations.
>
> The troubleshooting steps for your observation is to:
>
>   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
>   2. Turn off APSM (pcie_aspm=off)
>   3. Turn off both
>
> Typically one of those resolves the issue.

Thanks.
To make it easier for everyone to diagnose such problems, it would be
great if every switching between power save modes would be written to
the kernel log (when console_loglevel is KERN_DEBUG)
If APST is culprit, we would have seen the change in the power state
in the kernel logs before the message "nvme nvme0: controller is
down;".

-- 
Best Regards,
Mike Gavrilov.

