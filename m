Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D6C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:01:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F203F2074F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MOGuqcKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F203F2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hyHWp12+oQ7rq6V82E33Rnrs43lhuAoYliSOnSThOD4=; b=MOGuqcKQA0wJKh3AU2Xk27iHM
	+K/8stcQsOn1LqIku6FcAizRQXhqlIT2mthCqGgTv46vijDzpV2j1BcbnyzTRdspgKT0QLR6LY8eo
	E8mOS7wIMnts7sFweWE7fod0JBqiRq1x9f9dkTwp1UzWaNWmAWdiCWk4NXUNzibHwvNNC1alOwkCP
	lOE8vYQygANXYV/UW+u6s/TeecPpaujLIn9wNpOHZyRfgBP3KcMZoCNThuQzXKGV/vc+hwtXBtvlH
	aNLhh366g5HborSjAsIWdCymky75XfMbFRjgHUWgAGJXhFVGo7RMLbu/LRkltI4K8X1Q32UljFAsa
	F2dy36oYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0S2M-0000LM-Nl; Tue, 28 Jul 2020 16:01:06 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0S2J-0000K3-Ny
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 16:01:05 +0000
Received: by mail-pj1-f66.google.com with SMTP id ha11so27502pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 09:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0CNBetYCagkg6PvLbkEjdjQMLpNhakRwNHBcjD2Ht88=;
 b=rDPemawmSe1lj+MyNyNrhpKErhF5wuu5Akdn8dXst3e+3eW2/0wqurMVXcSw5leyGr
 RiG6hEfGNeoUF89iUX+Yyu2OBbNlf/WG+Q8GTbgtc2Kzb2pxd+m60rOStu1NP/I7JX7R
 7LIGR7k1NwpNNzahwz1i+TaKfAIFgtLEJHt5NtJVThIXhRC2Ho5duxNdmpZXfq5gfm7f
 R8SrgH7xWPnGWr7cLz/AnfVwRArZSkV6cWCl5uGeU9BFhFhs14eUQhLHiQWFadmH3Kxw
 d6xyy+VtK8crTtGBvRU7n6+DiC1+iobIOl7qw52cE2DC2AVS/ACc9pH1NaczaQhxfhRY
 QRmw==
X-Gm-Message-State: AOAM532kCX/HfZ9ANpzlZvWCFQwfys4qCFYh1JnWLd1/gr40CstMpbsM
 rHDzSoJmqLorSUXCkPNANSIp7JPX
X-Google-Smtp-Source: ABdhPJx1DVzL13/g6YTRUn9pjPejUHWSkUu1eUJ4Eq7fuLcohruD+B+2Rb39OtnY+lDERDUx9b3TiQ==
X-Received: by 2002:a17:90a:380b:: with SMTP id
 w11mr5480253pjb.213.1595952061810; 
 Tue, 28 Jul 2020 09:01:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id q17sm21822738pfk.0.2020.07.28.09.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:01:01 -0700 (PDT)
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
To: Ingo Brunberg <ingo_brunberg@web.de>, Christoph Hellwig <hch@infradead.org>
References: <m3zh7jhfcl.fsf@web.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd401d6f-2065-b691-6a6a-96be466bb050@grimberg.me>
Date: Tue, 28 Jul 2020 09:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m3zh7jhfcl.fsf@web.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_120104_315235_2D62D1C2 
X-CRM114-Status: GOOD (  22.63  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 05aa568a60af62..0602e0f3e77de9 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1287,18 +1287,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>>   	if (status) {
>>   		dev_warn(ctrl->device,
>>   			"Identify Descriptors failed (%d)\n", status);
>> -		 /*
>> -		  * Don't treat non-retryable errors as fatal, as we potentially
>> -		  * already have a NGUID or EUI-64.  If we failed with DNR set,
>> -		  * we want to silently ignore the error as we can still
>> -		  * identify the device, but if the status has DNR set, we want
>> -		  * to propagate the error back specifically for the disk
>> -		  * revalidation flow to make sure we don't abandon the
>> -		  * device just because of a temporal retry-able error (such
>> -		  * as path of transport errors).
>> -		  */
>> -		if (status > 0 && (status & NVME_SC_DNR) && !nvme_multi_css(ctrl))
>> -			status = 0;
>>   		goto free_data;
>>   	}
>>
>> @@ -1888,7 +1876,9 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>>   		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
>>   	if (ctrl->vs >= NVME_VS(1, 2, 0))
>>   		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
>> -	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
>> +	if (nvme_multi_css(ctrl) ||
>> +	    (ctrl->vs >= NVME_VS(1, 3, 0) &&
>> +	     !(ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)))
>>   		return nvme_identify_ns_descs(ctrl, nsid, ids);
>>   	return 0;
>>   }
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index c5c1bac797aa5a..4cadaea9034ae4 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -137,6 +137,13 @@ enum nvme_quirks {
>>   	 * Don't change the value of the temperature threshold feature
>>   	 */
>>   	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
>> +
>> +	/*
>> +	 * The controller doesn't handle the Identify Namespace
>> +	 * Identification Descriptor list subcommand despite claiming
>> +	 * NVMe 1.3 compliance.
>> +	 */
>> +	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
>>   };
>>
>>   /*
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 61e612d52d61d6..bac3a3f9c79e0d 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3181,6 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
>>   	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
>>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>>   				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>> +	{ PCI_DEVICE(0x126f, 0x2263),
>> +		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
>>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
>>   		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
> 
> Thanks, the patch works. Maybe it is not too late to make its way into
> kernel 5.8.
> 

Patch looks good, you can add my
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

on the formal patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
