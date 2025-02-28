Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100CC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQqt3r025DJCbsc59QzlMQIjxIUe40/8e/dqEZGAfJA=; b=AFD+X8dVGzZbTnT4eEuzqFsuEp
	60S+NYwacp2sS/G6XJcSnOUye+zY8vJ5WcqfzbXitbkPxHoAm9b1EEP9FV5d7aPDxu2N+PF0jZRuZ
	GfK8neNlj7BqNDqr/0rsVQQmIYpOlmA/iIpxdgxDuL8XmUMemUEuWZyg7285hMn1m/HKRQ5SvcYU/
	MiP8G9Lf7IdeG8qqchxxCboxLEBbrmdhqZaMt+4IOU5x73jBrYrNc9ktPiENVgbZbKsyqCoUAiA85
	F7sjUc3jB40XtY6jwGVUT6t1+K1J2utVftXO8Z3P/yKUMupl1G80oIP6vVcknSv5kCjd9HvZOchAY
	c8dtUBIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to0F3-0000000B3EZ-3hiE;
	Fri, 28 Feb 2025 13:17:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to0Co-0000000B2mC-3o0I
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 13:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQqt3r025DJCbsc59QzlMQIjxIUe40/8e/dqEZGAfJA=;
	b=BdLG6bm/lkD6LPaQmRDipdFEdAShpWjs/DLxH7t/RMs03FSyxaR0lt4Q91Ve0b3mWDlKr9
	xFWLifTgyL6hOtBsQ99Lv83w9mPxnKhhLSG23MOJzwF92r7JcvgTEzQdL60g7aVvAuxjU6
	hrzJbo14rgVvA+didcB2pGImpsxFHSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-k9FfwJOHOByQiLqbKSXXWQ-1; Fri,
 28 Feb 2025 08:15:02 -0500
X-MC-Unique: k9FfwJOHOByQiLqbKSXXWQ-1
X-Mimecast-MFC-AGG-ID: k9FfwJOHOByQiLqbKSXXWQ_1740748501
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69B61800360;
	Fri, 28 Feb 2025 13:15:00 +0000 (UTC)
Received: from [10.22.88.31] (unknown [10.22.88.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9D5E19560AE;
	Fri, 28 Feb 2025 13:14:58 +0000 (UTC)
Message-ID: <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Date: Fri, 28 Feb 2025 08:14:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
 <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_051507_078994_036118AB 
X-CRM114-Status: GOOD (  19.95  )
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

On 2/28/25 1:28 AM, Nilay Shroff wrote:
> On 2/28/25 8:55 AM, John Meneghini wrote:
>> The new NVME_MULTIPATH_PARAM config option requires updates
>> to the warning message in nvme_init_ns_head(). Remove
>> the old warning message and add new ones.
>>
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> ---
>>   drivers/nvme/host/core.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 818d4e49aab5..c2b7e6834535 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>>   			dev_warn(ctrl->device,
>>   				"Found shared namespace %d, but multipathing not supported.\n",
>>   				info->nsid);
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
>> +			dev_warn_once(ctrl->device,
>> +				"Shared namespace support requires core.nvme_multipath=Y.\n");
>> +
>> +#endif
>> +#else
>>   			dev_warn_once(ctrl->device,
>> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>> +				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
>> +#endif
>>   		}
>>   	}
>>   
> 
> As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies
> that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
> So above logic could be simplified.
> 
> However on another note, I really don't understand why do we need to add
> new warning here as there's already a warning present just above your
> changes.

Agreed.  How about if we just remove the

    	dev_warn_once(ctrl->device,
		"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
  
This is real problem.  This is a confusing message since there is no now plan to remove any of these config options from the kernel.

/John

> Thanks,
> --Nilay
> 
> 


