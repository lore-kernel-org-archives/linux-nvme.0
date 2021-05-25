Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5206C47084
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 13:54:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC1061420
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 13:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC1061420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HNhXXmnuBaQLFdZsvuvchjFsp7IqTmDrZmwJwYm7TFA=; b=AeDyCTEGoonyV+OhEA+Xpvgqvd
	njcpmo39kJvuwG26QcrdS6yHyEpUJXgdUeBCiuNivIvR4c3FIEb18LG+FjiYuB/jfqfxNwZIfmY1P
	aqxNW9I5jAJheOoo4Inu+0auywYpDKQv1H2BZ20aGOoD7VwaQC2bo4MHAW7aqzpE9CWpMWPq01D06
	N1UXvoikD2hT0y3tuvi6p7KGhvflC4ETJ4lbCGhUn477ko71jSpxdE3ZpcEKloYz4+EgTrK17S19T
	dDMGmiUScwtiGCE+zKZ41FHyImc/kaCgtCj6qFAPfFz3P8JrVF2lI4b7tWtzdzeqIlPpk1H5KNp6y
	0iC8qmyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llXVs-005Tr4-18; Tue, 25 May 2021 13:54:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXVl-005ToC-Qu
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 13:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621950860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rk9FpEdpHXhpgYxjwwEYJQVlfBBmpMhpP53RFf6eh4w=;
 b=QKMZvFsKi5SL+ilFmUtWN5uBlcCZN6fLYzeDIJhJB3moLxdQTuzb0yyDDcgGDYR5Al2Wu8
 s78WTQhNlObg/FFW58otbZCneVM1dXGJo8Zc66+yVIsNsHAqHPlf5mtADqiq3+kQvh7fA2
 3ZGUM46H8fHaumhr+8BzUbzLFEX76Y8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-LR7kz_3mPvu9xVhfVFPpQA-1; Tue, 25 May 2021 09:54:17 -0400
X-MC-Unique: LR7kz_3mPvu9xVhfVFPpQA-1
Received: by mail-ej1-f69.google.com with SMTP id
 z6-20020a17090665c6b02903700252d1ccso8789549ejn.10
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 06:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rk9FpEdpHXhpgYxjwwEYJQVlfBBmpMhpP53RFf6eh4w=;
 b=PxS0h0TQw60AKEwU4bZJRcnYhJmPoBKpvm81w8D/jTveCAr9Mi+hTTTHYdrPzy/F6I
 H1VIN29R3jzsOEiwS/aGJahbfvyQXnb486dewXAtOpqoKdibZEqZFQRYSoNDfJf06lKP
 aLw2DoPG+optyw8Nmt1rYgLDlrF34QOWITgjsP3TTxX0fVpRPu8G6xUpqL0RVHJJG/2i
 hc1LnsuJRB5y0wlrhqWOiWHEIdwXsNUtGDU1lYxZb8Qc1TErbyTrZuFaFnQUJb//nFlM
 08J7DeQ7MyhXotGsV65pV0rVwrUjG5p0onIybXamT4cD2UhRvMMV1rGpzvyKQF2sj46/
 YMYQ==
X-Gm-Message-State: AOAM530chtI0DcYtfhw3sdmBvYv1B1+TzzoBtNX6Bn+f9YYxVK1R0Y0v
 48NpHHQ3KOJ0uaUGGUPIZzbJxH4imZC9b8JN088Rhb3XRmRhaxURBxdJixL7KUAvCjmj92FiU+a
 mdsUi8e9qay1Ic8/BRIZZDFNSGUA=
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr31559726edu.359.1621950856737; 
 Tue, 25 May 2021 06:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRp37bczvkiT/eefp5DnH2QqUHt9q0JK5Rcsz31thNWKnpW0GO6oMuri87gXc9A4MoCHjQMQ==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr31559705edu.359.1621950856552; 
 Tue, 25 May 2021 06:54:16 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id a19sm10698834edv.80.2021.05.25.06.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 06:54:16 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Liang, Prike" <Prike.Liang@amd.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
Date: Tue, 25 May 2021 15:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_065422_008356_EEA602CD 
X-CRM114-Status: GOOD (  25.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 5/25/21 3:39 PM, Deucher, Alexander wrote:
> [AMD Public Use]
> 
>> -----Original Message-----
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Tuesday, May 25, 2021 2:21 AM
>> To: Liang, Prike <Prike.Liang@amd.com>
>> Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me;
>> linux-nvme@lists.infradead.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
>> k@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
>> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage
>> device to D3 for s2idle
>>
>> On Tue, May 25, 2021 at 10:48:59AM +0800, Prike Liang wrote:
>>> +#ifdef CONFIG_X86
>>> +#include <asm/cpu_device_id.h>
>>> +#endif
>>>
>>>  #include "trace.h"
>>>  #include "nvme.h"
>>> @@ -2828,6 +2831,16 @@ static unsigned long
>>> check_vendor_combination_bug(struct pci_dev *pdev)  }
>>>
>>>  #ifdef CONFIG_ACPI
>>> +
>>> +#ifdef CONFIG_X86
>>> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),
>> /*Cezanne*/
>>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),
>> /*Renoir*/
>>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104,
>> NULL),/*Lucienne*/
>>> +	{}
>>> +};
>>> +#endif
>>
>> This is completely unacceptable.  The NVMe driver could not care less what
>> CPU we on.  We need information from the PCI or power managment core
>> on how broken the power management of the root port is, not this kind of
>> crap in a low-level driver, with potentially many more needing the same kind
>> of quirk in the future.
> 
> Hans,
> 
> Any ideas on how to handle this at that platform level?  We need to select the NVME_QUIRK_SIMPLE_SUSPEND flag on certain AMD platforms.  This is a platform firmware requirement.  It's not an NVME specific requirement, it's not a PCIe specific requirement, it's a platform specific requirement.  DMI matching doesn't really make sense because it affects all AMD platforms of a certain generation.

Honestly I can understand that Christoph is a bit unhappy about this, but
the nvme driver seems like the right place for this to me and it is
already doing DMI based quirking for 1 specific Lenovo model, I don't
see why that would be ok, but a CPU-id based check would not be ok.

Both are ugly, yet both are unfortunately sometimes necessary.

Reading Christoph's reply a second time though, I believe that what
Christoph is trying to say, that this seems to be related to some
special suspend demands stemming from using the pci-e root ports
from the CPU, if instead the NVME device where situated behind
some pci-e switch, then the link to that switch would need to
power-down for the CPU's deep-sleep demands to be met, so this
really should be a (probably new?) flag on the pci-e parent of the
NVME device and then the nvme/host/pci.c code would set the
NVME_QUIRK_SIMPLE_SUSPEND flag based on the flag on its pci-e
parent, rather then having the CPU-id check inside the nvme code.

IOW I believe what Christoph is suggesting is the following:

1. Add some new flag (or some-such) to pci-e ports/links inside
Linux to signal the requirement for the link to be turned off
during suspend (or whatever the requirement actually is).

2. Make the drivers/pci code set that flag on the pci-e root
ports of the AMD CPUs which need this (based on the CPU-id as
done in the original patch).

3. Have the nvme/host/pci.c code would set the
NVME_QUIRK_SIMPLE_SUSPEND flag based on the new pci-e port/link
flag.

Christoph have I understood correctly that this is more or less
what you are asking for ?

Note I don't know it this actually makes sense, because I don't
know all the details here. I believe that AMD is in the best
position to decide if this makes sense or not.

Regards,

Hans



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
