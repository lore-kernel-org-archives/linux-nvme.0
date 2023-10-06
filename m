Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778E8E81E1F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnL6IcDEF/I+SFfFl9VQ/bBGtLZVeE0oEvuHjO2kHpI=; b=lBqax7ep9fRcAAuxfVWqyFPk6n
	rtfk82U6QgcOQuPDKVOPg6p6tAD8oCbtvmf0aTAYFCmo5lNcexe2rKEwylLSnfs+Uurb2+oxDIRqX
	AIgPA/0DA/WDusl+moI8le6S22xvWepLAHIFNxr+TiacvgIfLS8Y5DRRY/jXFXXTvmDhNf0MQkUgy
	3EKKkl/QUdpCkl2wqoFBK1cxIgnXMntf5tOxoDGhUuT4cxQEqyRxZaTf90wVhZYfEhWq3DicKo4v/
	CchXPVMkCzZ9hmpWBECB3AKDBz4JK+BlxxKD4ZTvJ87a1P9NdrYrbGGy1WlziNnxzK6fsHdIXFeHi
	pjTSttuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qop0M-006H1O-0h;
	Fri, 06 Oct 2023 17:52:50 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qop0J-006H0f-0O
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 17:52:48 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c888b3a25aso14600975ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Oct 2023 10:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696614765; x=1697219565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnL6IcDEF/I+SFfFl9VQ/bBGtLZVeE0oEvuHjO2kHpI=;
        b=PpN/npoc/W463e3zB7XIdvW3nduo1eXqRy2qWXknf5C36s5d4kcV2NY3QdY1ecnv77
         uSl3YKSM+0FUUaxNk7/Cq7h01MuY7VrghWEAuVcMryBEgm2gFuu/MDaAYrFuSO6GyB8Q
         +7O/0+1JuK8a5vTEN9rhDb55hRdJ/rKGGAkY9D+cFiKyMkIg+fJX4C4XtJbQQ0kG0I/M
         qukB+JmzB/itz0rm41hkQKz/BmijaXP2oLj9aygwtNkt9NpPIotaLgHm0d4wSRAwvZMN
         sccMk90TPnz5HFzE8rH393p8E6NTSXCb4waJa9JfXBAZG68d5nHk9mjmBSKpLpoxD7Kp
         5cXw==
X-Gm-Message-State: AOJu0YyME+SxaH19NMJaytdOuKBU5Tyza7xppc26K+tUlOPbyymvcSeR
	4gYI0B+FoQkmfRc9tNlAsQM=
X-Google-Smtp-Source: AGHT+IFEfu6krZRMMNdIjI9SRnksIybRzXbtBBjNfKK1W53oKfdtvx2+WeKkXpi7mnUPNlqRrPCVhw==
X-Received: by 2002:a17:90b:4a12:b0:274:6503:26d with SMTP id kk18-20020a17090b4a1200b002746503026dmr8363179pjb.33.1696614765149;
        Fri, 06 Oct 2023 10:52:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a0c8500b00256b67208b1sm6168825pja.56.2023.10.06.10.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:52:43 -0700 (PDT)
Message-ID: <a7a24914-4940-4a23-b439-bc8f0ad99212@acm.org>
Date: Fri, 6 Oct 2023 10:52:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-19-john.g.garry@oracle.com>
 <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
 <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_105247_162042_FF905B75 
X-CRM114-Status: GOOD (  14.76  )
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

On 10/2/23 04:27, John Garry wrote:
> On 29/09/2023 18:54, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>>> +static void sd_config_atomic(struct scsi_disk *sdkp)
>>> +{
>>> +    unsigned int logical_block_size = sdkp->device->sector_size;
>>> +    struct request_queue *q = sdkp->disk->queue;
>>> +
>>> +    if (sdkp->max_atomic) {
>>
>> Please use the "return early" style here to keep the indentation
>> level in this function low.
> 
> ok, fine.
> 
>>
>>> +        unsigned int max_atomic = max_t(unsigned int,
>>> +            rounddown_pow_of_two(sdkp->max_atomic),
>>> +            rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
>>> +        unsigned int unit_min = sdkp->atomic_granularity ?
>>> +            rounddown_pow_of_two(sdkp->atomic_granularity) :
>>> +            physical_block_size_sectors;
>>> +        unsigned int unit_max = max_atomic;
>>> +
>>> +        if (sdkp->max_atomic_boundary)
>>> +            unit_max = min_t(unsigned int, unit_max,
>>> +                rounddown_pow_of_two(sdkp->max_atomic_boundary));
>>
>> Why does "rounddown_pow_of_two()" occur in the above code?
> 
> I assume that you are talking about all the code above to calculate 
> atomic write values for the device.
> 
> The reason is that atomic write unit min and max are always a power-of-2 
> - see rules described earlier - as so that we why we rounddown to a 
> power-of-2.

 From SBC-5: "The ATOMIC ALIGNMENT field indicates the required alignment
of the starting LBA in an atomic write command. If the ATOMIC ALIGNMENT
field is set to 0000_0000h, then there is no alignment requirement for
atomic write commands.

The ATOMIC TRANSFER LENGTH GRANULARITY field indicates the minimum
transfer length for an atomic write command. Atomic write operations are
required to have a transfer length that is a multiple of the atomic
transfer length granularity. An ATOMIC TRANSFER LENGTH GRANULARITY field
set to 0000_0000h indicates that there is no atomic transfer length
granularity requirement."

I think the above means that it is wrong to round down the ATOMIC
TRANSFER LENGTH GRANULARITY or the ATOMIC BOUNDARY values.

Thanks,

Bart.


