Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEC4C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAumLxLnWfAM18CUZyhLKrEQTBxFDu0Nq3UHPT8n9DM=; b=pkZ9U7A4jSdq1LY/qwJ1Qn94El
	2990usbEUAkgxVmIKDIGLg0cs+pNEY993cHT2AD7ksPzQznfGwWUhK5fk5UBE3svUuquGzzHsJkf9
	n1Jsy2S6+g5YR2EMZVig75RMVDug4WcnDsTfUfRc8cNJ7cK5Ck+yaIKO9K0xRpKKHmiP81fSZdFLJ
	nyD0QkN9ydLOUY2LfyggSdNMiz4v3ZhY9D+lINn48A1GilW0vcWRUw83OfX+tBoAmRQA8cBKlVOqY
	NPFmpCy9C6CpIBBgB80P21E85fpiTbTCioo0cb39crxUoqIy0/48Q/xA7mUOiHctQ52idktb53W5l
	aspXebaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqejS-001Cp8-3B; Thu, 03 Nov 2022 18:14:26 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqejO-001Cnk-LO
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 18:14:23 +0000
Received: by mail-pj1-f52.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2581402pjc.2
        for <linux-nvme@lists.infradead.org>; Thu, 03 Nov 2022 11:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAumLxLnWfAM18CUZyhLKrEQTBxFDu0Nq3UHPT8n9DM=;
        b=ZsCP0g6Bvh3XZ8OlDmwR+uAZcVncrLskjv4Uhv28R4El8O7rrmS4q5t7BcxfD2FVi3
         kKxLJ7NJ2ioATNqhNmrsyaS+Zl2+SrwasuVcovXVL4JHE64+47jQeav5JqLGey3qH0K1
         bkp1EzvqtchTB7id9NJt6JXJBs+ksmGeVDzjtn2P4RI/tmPFoaKlCWjyNqWgRZkgbC+8
         Y2jlVs3yzVN8u6rnO3F3fzTBM0sJrw7fmDpC6OME8jWqw6UTAv4WKhyBjK/FwcXI0J1n
         G+4ANPldvce+gqtLcQyj3vPY2H2PRJvvi+lg6zwLK44MLMzPSGJs/46zm/VPgJT2DKhc
         0zlA==
X-Gm-Message-State: ACrzQf3n5ZBR1zsoYDnKMXLBQZjZ4Gv8j438tygHvGSIxtZAPtxk82Qv
	tHhKnm9KLNuNwWgnDlGbzV0=
X-Google-Smtp-Source: AMsMyM7EErA8tHxPvzrZVcpD4tDFhNKSgLTGblrV/zcW9vCOr6QKeDAhLbttK1YYZeyphS7cjxvfow==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr49029090pjb.200.1667499261396;
        Thu, 03 Nov 2022 11:14:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:881a:8a80:fdae:8683? ([2620:15c:211:201:881a:8a80:fdae:8683])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b00178b77b7e71sm958760plh.188.2022.11.03.11.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:14:20 -0700 (PDT)
Message-ID: <84af9938-81bc-7c58-2210-7da935312d6a@acm.org>
Date: Thu, 3 Nov 2022 11:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 03/19] scsi: Move sd_pr_type to header to share
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-4-michael.christie@oracle.com>
 <0123db70-6217-135a-4101-0609512e723b@acm.org>
 <7b8cdc82-0aca-2f41-2eed-299dacf95771@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7b8cdc82-0aca-2f41-2eed-299dacf95771@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_111422_715696_72D9CC85 
X-CRM114-Status: GOOD (  18.58  )
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

On 11/2/22 19:13, Mike Christie wrote:
> On 11/2/22 5:47 PM, Bart Van Assche wrote:
>> On 10/26/22 16:19, Mike Christie wrote:
>>> +static inline enum scsi_pr_type block_pr_type_to_scsi(enum pr_type type)
>>> +{
>>> +    switch (type) {
>>> +    case PR_WRITE_EXCLUSIVE:
>>> +        return SCSI_PR_WRITE_EXCLUSIVE;
>>> +    case PR_EXCLUSIVE_ACCESS:
>>> +        return SCSI_PR_EXCLUSIVE_ACCESS;
>>> +    case PR_WRITE_EXCLUSIVE_REG_ONLY:
>>> +        return SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY;
>>> +    case PR_EXCLUSIVE_ACCESS_REG_ONLY:
>>> +        return SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY;
>>> +    case PR_WRITE_EXCLUSIVE_ALL_REGS:
>>> +        return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
>>> +    case PR_EXCLUSIVE_ACCESS_ALL_REGS:
>>> +        return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +};
>>
>> Please leave out "default: return 0;" from the switch statement and add "return 0;" after the switch statement. That will make the compiler emit a warning if a value is added in enum pr_type but not in the above function.
> 
> Did you want that compiler warning functionality in the future code
> or are you asking me to do the above only if we go the switch based
> route?
> 
> Chaitanya requested me to make this array based in nvme/scsi. For this
> approach, I can add a WARN or printk warning if the pr_type passed in
> does not match a value in the array. I don't think I can do a compiler
> warning though.
> 
> I didn't care, but I think the compiler warning route might be better
> though.

Hi Mike,

Although I do not have a strong opinion about this, keeping the switch 
statement and moving the return statement out of the switch statement 
has the advantage that the compiler will warn if the switch statement is 
incomplete. I don't think that a similar warning would be emitted if the 
switch statement would be converted into an array lookup.

Thanks,

Bart.

