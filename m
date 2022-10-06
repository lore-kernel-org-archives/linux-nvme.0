Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CA1C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9IT9ZPV47oSI0RsAKXTKPKx72GmJpK7wORfME8i3q/4=; b=x1W0/YRwzS3U99fDdQlXIIElNe
	0gB7aKuV2J3LP7BFI1XXzBYUGk31pwlHEXOiCgrWmpizpV0qucb6DV+2byzQtKOg2709IHZXnwRZt
	aRZQr/gt51s2iWU6QC29urYFvtT9jdRcwSo7Pl0Zw40F29Rpei68LWMhy4mJqc6u4NOvs0Qvy8NUM
	q6nsFx0C5dvEngRGoMsHLqq8wwtKTlk4NnBf160HIL9Y357AjdywfvQDGcE9SM9AEaM1bdRGy7Vo+
	EErnSG+Gf7nmI3gCZM4IBzJI3tok0AOyhnf4pZ/SYmw963vQa+AdhnO5Zt2TDP30ytsr8wZNku9Dj
	WOrCwU0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogP8J-001uJC-Dn; Thu, 06 Oct 2022 11:33:43 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogP8H-001uHn-Hk
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 11:33:42 +0000
Received: by mail-wr1-f42.google.com with SMTP id a3so2304112wrt.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Oct 2022 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IT9ZPV47oSI0RsAKXTKPKx72GmJpK7wORfME8i3q/4=;
        b=440o721A/oEfxf4TgeycnxvSpq9Wfp0En0dNobAENc1I59l2JbL2KMBpqbfZLz+wsR
         mthFn1oCQ7goKSl39wYYyPrmtdiCLo/FeZTB9rvdrhmC6krtHjpOPvZ4qv8kri3Ot0rt
         QFZlSMWQWqPYj5gIgXNZru3UtGf1z6mxDN7828fBB3G+UW/zADRvHYcJuhmmWh/Xxtf6
         jDrzUdWBEXP0WhBk+g/4plgwZKCxty42aP7a4v4qPCk9fP1DaKRahsZWuzYxgsKkfmfG
         QpwCZ64gpLMgEnTrmAdb7A+78rfk8dZsAi8M7zi+mZiLVSyUMSUqglbXavleEPBLkRDW
         zp4g==
X-Gm-Message-State: ACrzQf3IbBSimr6uaB4gDaZ+ZYfaFnK3IvLzc4gRltm55ewkdkLB8ikO
	eKjtrpCeUwO06EsOA8H5+XY=
X-Google-Smtp-Source: AMsMyM7Lqv407cV4jJ8c3L6+Rr6FM77k3iDw1c02iK00o71kupr7fcDejQ+eU/UTHGJrA9xAHmpwGA==
X-Received: by 2002:adf:fdc6:0:b0:22e:373:939e with SMTP id i6-20020adffdc6000000b0022e0373939emr2917665wrs.290.1665056017621;
        Thu, 06 Oct 2022 04:33:37 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v127-20020a1cac85000000b003b505d26776sm4672680wme.5.2022.10.06.04.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:33:37 -0700 (PDT)
Message-ID: <a3aaa8ae-d259-359d-8a08-084d53fca830@grimberg.me>
Date: Thu, 6 Oct 2022 14:33:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
To: clay.mayers@kioxia.com, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220929223955.3275715-1-clay.mayers@kioxia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_043341_610432_B2C85C0A 
X-CRM114-Status: GOOD (  18.73  )
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


> This adds support for the ZNS Zone-Descriptor-Changes AEN, which is of
> type notify and uses CQE.DW1 to convey the NSID of the log page to read.
> 
> Patch 1 adds non-zero NVME_AEN_DATA with the value of CQE.DW1 to all
> NVME_AEN uevents.
> 
> Patch 2 generates a uevent for all unhandled AEN notify results instead
> of issuing a dev warning.
> 
> This support is planned to be used by both zone based applications and
> another unreleased device with an alternate command set.
> 
> Changes since v1
> - Break up into two patches
> - Only inlucde AEN_DATA if CQE.DW1 is non-zero

What about the other comments that were given on v1?

--
 >   #endif
 > -    case NVME_AER_NOTICE_DISC_CHANGED:
 > +    default:
 >           ctrl->aen_result = result;
 >           break;
 > -    default:
 > -        dev_warn(ctrl->device, "async event result %08x\n", result);

I'd keep the log... and also don't know if we want to pass any unknown
possible spam to userspace... not sure that being blindly forward
compatible is the right choice here.

 >       }
 >       return requeue;
 >   }
 > @@ -4799,8 +4800,10 @@ void nvme_complete_async_event(struct 
nvme_ctrl *ctrl, __le16 status,
 >           break;
 >       }
 >   -    if (requeue)
 > +    if (requeue) {
 > +        ctrl->aen_data = le64_to_cpu(res->u64) >> 32;

Please use a helper for that.
aen_data is not a great name... maybe use a union for that for the
specific aen subtype?

Maybe it'd be better that zoned namespace aen is handled explicitly
and passes a AEN_NSID env veriable to the uevent.

