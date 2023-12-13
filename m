Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B08C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SwvVkoGDwWVwJB0R+zYhAcK05oz/fetffJKIFJMF5o=; b=ryzhrVfeCN4dd5anve+rC6x4ez
	A00Cm3w1xlAjMwHbAhvR0Ue3+GkOMhYVdbF/x1nIo+n+t9fl+CkUtAmR7hkmo7v1wjwjFjzrmJSme
	o32660dbY8aqWiMAfkbI++1PgyYZs38VrkZVPmaMAh0Y0EVkraB2085JPzGiSAYFb07Qs0TdU3Iq8
	7xJYGTR8eQJrXSQunm6qCorQg3BH0HT/1nsfggQQIoIwnL5J3N83f4PnqKW21IXinToq2X3IiDBHO
	stqMZkUjOG2+dmyn2usdyDNSb0kZfMjx2Cnwka0hul1u6mtxaZrCm/SySkPVCVMPpo2WML1Dok6dr
	FegtqANA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDTLT-00FeWf-1r;
	Wed, 13 Dec 2023 17:48:31 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDTLQ-00FeWL-2R
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 17:48:30 +0000
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cecb004339so4050543b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 09:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489707; x=1703094507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SwvVkoGDwWVwJB0R+zYhAcK05oz/fetffJKIFJMF5o=;
        b=oSmrT4DXsUB7Oa1SI5cCODKMFTmsZ0FDurgSSyezTIqYNERfh4kyHjw4BUFsm+bHgd
         snTZJrO3iAr7XXgu+Wb+2bvRAkHBbqkgzFKYG2r6ra4HX+PaPcIL99qSyAEk1f3JlRZ4
         inGZye6iOVQcma0RKicW7HJkZ1bQs+maXeBaVA20LJUH0a1tviPkQgRLk1RzugAYGHtG
         uZ+bsAM3otj4i+mXBAY0zzT7f0NFVo53/FD8G7/gZa/Q3Vp9DeIySaGdchahe587Gk9t
         Z+R+XxfWWaCmX5sn1Sdf7Vzm5dLDCAOsNRyimlPqPtF5bmKDo8+Ztj+RVsvQ2ZFfUPU/
         AFTA==
X-Gm-Message-State: AOJu0Yxk4ForuuKX3p9hF+1nsRh3hanqlt0FspS2hLyWenqilhJ4RvaF
	ffA43p/17VMa8+uxePBVCiQ=
X-Google-Smtp-Source: AGHT+IGHiwhkfgv0xM5ZPZLcziHy9LqG7qG54LMePSwPFJzxVF/eC1I51V4oI2zerwgUxkxQD9JFfQ==
X-Received: by 2002:a05:6a00:1254:b0:6ce:1001:2eeb with SMTP id u20-20020a056a00125400b006ce10012eebmr5180117pfi.17.1702489707036;
        Wed, 13 Dec 2023 09:48:27 -0800 (PST)
Received: from ?IPV6:2620:0:1000:5e10:fdd1:592b:d4d0:1d05? ([2620:0:1000:5e10:fdd1:592b:d4d0:1d05])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00191300b006ce75111ce7sm10159099pfi.162.2023.12.13.09.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 09:48:26 -0800 (PST)
Message-ID: <506c4b2f-4ee6-466f-89e8-8224ccff6044@acm.org>
Date: Wed, 13 Dec 2023 09:48:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231212180938.397403-1-jallison@ciq.com>
 <20231212180938.397403-2-jallison@ciq.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231212180938.397403-2-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_094828_819228_9A0B405B 
X-CRM114-Status: GOOD (  12.64  )
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

On 12/12/23 10:09, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility.
> 
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>   drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>   include/linux/device/bus.h | 10 ++++++++++
>   2 files changed, 48 insertions(+), 1 deletion(-)

 From the MAINTAINERS file:

DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
R:      "Rafael J. Wysocki" <rafael@kernel.org>
S:      Supported
T:      git 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
F:      Documentation/core-api/kobject.rst
F:      drivers/base/
F:      fs/debugfs/
F:      fs/sysfs/
F:      include/linux/debugfs.h
F:      include/linux/fwnode.h
F:      include/linux/kobj*
F:      include/linux/property.h
F:      lib/kobj*

Please Cc the maintainers of the modified files when posting kernel patches.

Thanks,

Bart.

