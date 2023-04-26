Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825D4C7618E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdPn91glfo5QUjEER08JPexoTroKHeJw/diZo9qi1BM=; b=fX0LTmd3VF7zUFb48Jjx5EnrBQ
	i4BP5KWcQ1lYAmlHogZXRV+5O1wfyBehiWcQfIQEuQymwEzPi8rMuvd+xXqtf0HAr0gXwA7II9avy
	R0F8jWV0+VUBqDpBQ66UrTud6c5Q2P107fMHLJ6PJd7qei0NBj1JpQLWb5lnRwdStMkC3veC4rwGx
	em3GGUBJnZ062Kpi0zWwKWptFxRPGwMMpXS7b9kf93wkxXuFqTRoVklUHa7tdozVRzyr6z45vhZgJ
	sW98+lHgfIDc/c+oBQC6K3xxeUMMbkg4Mw3yg1aTrApFvyoq30ot6euaVFxC0C4rjOSbvnvmMMoJH
	Q1dveAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prfRz-00479r-0G;
	Wed, 26 Apr 2023 13:44:51 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prfRv-00479O-1Z
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 13:44:49 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-518d325b8a2so7074854a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Apr 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682516686; x=1685108686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pdPn91glfo5QUjEER08JPexoTroKHeJw/diZo9qi1BM=;
        b=WPg07Y95vbIFPAiJDasxuHtGCE/l2JhjJXA/1pQr6tWeTJAP7CESCAen+xWoSuqgqn
         1Cx3M2Awh57igPNMJ3KpWhuuO3vlfTAHwE4NYn4Q9EwBXXMQAg5k1UqJYPuw+hrmweoM
         Y8+gUR9XoOsWti7cieV2E6T42pmXuGZeE8BaHf6UXItLpxa7Qy7rYw6e5yG9jqWFsiUR
         hzMZa1OHFhNngde43RlgfZeEb3bPnRwC/q3EFcq+HOR1uDuzOePd/svNJYDmNY/O1oGf
         5O5OkeU+c77ZCFebsmJJk8r5Wb/8cTh8P1BqfZddfp9bQpSFJUxKM+HJVtVdZ36MtU2n
         f3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516686; x=1685108686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdPn91glfo5QUjEER08JPexoTroKHeJw/diZo9qi1BM=;
        b=fxA5rGIwYnR6FN+AD8ljgpUjpCiZT6L/vA1acYdGxxbGds77i/0NIG90PBl/jwy1po
         yp9ijNymJtPDm1DUslc7yyQiLGZqnmdpV/qPwkHuGJsUggkUQJ8iucXsYzW+he6+N8HM
         dC00bp6+C4I4Ql6fKfoQ53Buc0/UgGWqnP8SCSNMKJkyf6XPuuSr1OSTXYuHisskdPoa
         8tOjFx5c3ISuQRVMguF+o1r11HQHOXsiiA5Stws3kXQUbv8ToWhGrtI0BQQw7RKzqPsf
         gHor4rikNOkQT8W0Kyk5IoGg5SBTVy/PfMtEeC1dQnmsV9XBK2On3SWbGmgsa5cUaXNr
         hI7g==
X-Gm-Message-State: AAQBX9dGAizrVB+2PSzAUyTyb2w6d6DnP7pRE0NFXmnPk8kAHJi7IhAA
	QpRZKXM5z0i2FORyIv+xUhI=
X-Google-Smtp-Source: AKy350a02ivUcXL0hM60DUBtaxz0ej49BaAkpRBAvpLaopDGMEOPe7Q0cWViu//sOk7VU5Jc/JG5QQ==
X-Received: by 2002:a05:6a21:792:b0:ef:e240:b562 with SMTP id mg18-20020a056a21079200b000efe240b562mr23665783pzb.39.1682516686319;
        Wed, 26 Apr 2023 06:44:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i22-20020a635856000000b00502f4c62fd3sm9591416pgm.33.2023.04.26.06.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:44:45 -0700 (PDT)
Message-ID: <8e643bff-49c5-6dd9-b51a-116e1990ff93@roeck-us.net>
Date: Wed, 26 Apr 2023 06:44:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme-pci: add quirk for missing secondary temperature
 thresholds
Content-Language: en-US
To: Hristo Venev <hristo@venev.name>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20230425195853.322100-1-hristo@venev.name>
 <5e8a5d87-3cc8-4141-bcea-34aff5a82149@roeck-us.net>
 <386668a7596beb52443c14fb33bfb5f329895509.camel@venev.name>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <386668a7596beb52443c14fb33bfb5f329895509.camel@venev.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_064447_566731_D50F0E5C 
X-CRM114-Status: GOOD (  22.61  )
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

On 4/25/23 22:57, Hristo Venev wrote:
> On Tue, 2023-04-25 at 16:39 -0700, Guenter Roeck wrote:
>> On Tue, Apr 25, 2023 at 10:58:54PM +0300, Hristo Venev wrote:
>>> On Kingston KC3000 and Kingston FURY Renegade (both have the same
>>> PCI
>>> IDs) accessing temp3_{min,max} fails with an invalid field error
>>> (note
>>> that there is no problem setting the thresholds for temp1).
>>>
>>> This contradicts the NVM Express Base Specification 2.0b, page 292:
>>>
>>>    The over temperature threshold and under temperature threshold
>>>    features shall be implemented for all implemented temperature
>>> sensors
>>>    (i.e., all Temperature Sensor fields that report a non-zero
>>> value).
>>>
>>> Define NVME_QUIRK_NO_SECONDARY_TEMP_THRESH that disables the
>>> thresholds
>>> for all but the composite temperature and set it for this device.
>>>
>>
>> The description above says that temp3_{min,max} return errors.
>> How about temp2 ? This patch disables that as well, but it is not
>> clear
>> if temp2_{min,max} return errors as well. If temp2 limits work,
>> disabling
>> them would be overkill.
> 
> temp2 doesn't exist. The only temperature sensors on that SSD are temp1
> and temp3.
> 

Interesting. In that case

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

>>
>> Thanks,
>> Guenter
>>
>>> Signed-off-by: Hristo Venev <hristo@venev.name>
>>> ---
>>>   drivers/nvme/host/hwmon.c | 3 ++-
>>>   drivers/nvme/host/nvme.h  | 5 +++++
>>>   drivers/nvme/host/pci.c   | 2 ++
>>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
>>> index 9e6e56c20ec9..7a2c4b5e018c 100644
>>> --- a/drivers/nvme/host/hwmon.c
>>> +++ b/drivers/nvme/host/hwmon.c
>>> @@ -163,7 +163,8 @@ static umode_t nvme_hwmon_is_visible(const void
>>> *_data,
>>>          case hwmon_temp_max:
>>>          case hwmon_temp_min:
>>>                  if ((!channel && data->ctrl->wctemp) ||
>>> -                   (channel && data->log->temp_sensor[channel -
>>> 1])) {
>>> +                   (channel && data->log->temp_sensor[channel - 1]
>>> &&
>>> +                    !(data->ctrl->quirks &
>>> NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
>>>                          if (data->ctrl->quirks &
>>>                              NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
>>>                                  return 0444;
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index bf46f122e9e1..a2d4f59e0535 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -149,6 +149,11 @@ enum nvme_quirks {
>>>           * Reports garbage in the namespace identifiers (eui64,
>>> nguid, uuid).
>>>           */
>>>          NVME_QUIRK_BOGUS_NID                    = (1 << 18),
>>> +
>>> +       /*
>>> +        * No temperature thresholds for channels other than 0
>>> (Composite).
>>> +        */
>>> +       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH     = (1 << 19),
>>>   };
>>>   
>>>   /*
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index cd7873de3121..e457ad169dcb 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -3416,6 +3416,8 @@ static const struct pci_device_id
>>> nvme_id_table[] = {
>>>                  .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>>>          { PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ
>>> OS21011 NVMe SSD */
>>>                  .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>>> +       { PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000,
>>> Kingston FURY Renegade */
>>> +               .driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH,
>>> },
>>>          { PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co.
>>> NV3000 NVMe SSD */
>>>                  .driver_data = NVME_QUIRK_BOGUS_NID, },
>>>          { PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co.
>>> NV7000 NVMe SSD */
>>> -- 
>>> 2.40.0
>>>
> 


