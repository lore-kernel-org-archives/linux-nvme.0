Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B5C761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTO/wDmK2UmTrFBMoprVG6kpljuMcGX46IeTf5JP1x8=; b=vJSo8pvhy8pvcXrz0gGqLMTewR
	z5X7ObsbtuUIq420uF6j9lFxP2tqlwhDckzjemmGitI2yAQZOTBtuE7ItAvCX7eb+OW/r1MhIqOch
	frFYMyJueGMHKYjISCiyWtfR0PCxtrKXV8TVtlXzHp2zdoZBycMDNLBKpOBVs3vAH/67GTqpjN8Jr
	7PUhGMuKyUdThrAZuknvRQIaZ++qr4hVb/rIAeP6d3A4yXRPnJsWmzrfIYAt1DnqIQU4S35PjexIY
	tRfyGKfC4/0bLh7eBKFkL3mpVYwgD13JGmybygIzUhsBqd8smbbYjUfBbVt619jZiFVQEXyB7BVcS
	CpRZcjCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phtPp-0046ZV-1Z;
	Thu, 30 Mar 2023 14:38:13 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phtPm-0046YD-2X
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 14:38:12 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-2cfe3278da7so20697f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 07:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTO/wDmK2UmTrFBMoprVG6kpljuMcGX46IeTf5JP1x8=;
        b=Zkh5XlagQjmTe38+pqcGMOiMv4VZ24hhoCDkbjyE0fG65hbJy6cCpqiTLSHAg7NMym
         PIZh8WJI+6lg1abl8pBMnYH8t8Q6iFGlt5vZJ/u72RRvh4xej0Z6ltal75iQg1BtI23n
         2u2DzuCoGSKW64xRlAEFphSJxFhSQdvmhW/XXaC8wfy/UiFFJV8GU1TWru61BjRBLJlN
         9ySYKnenKxVa4cX762EhpQCXtWYrce0jkMCwva7CKIq3T3QZUVNPmDDTKKQrtR3U2fEi
         h8XZ8RBcEqMGswI+KdCu2ohYIFQYgNViJfrhv8LsuxyRJM/RgJE3wipP/+fEFasJTa/O
         LJdA==
X-Gm-Message-State: AAQBX9eVBLRalpkPoUTLZlBBRFO7cLsOO62FubAFpHW1Z5hytnGkCEN9
	2OigVXsYziayrM9AuiY9Hek=
X-Google-Smtp-Source: AKy350Z5nQIEFMpyzn9bWokRg3bgkLalPWl4ZCHGhtXF25bNAvJ3Fi5G1VvqZZT4eO+x4JCWfj5lqw==
X-Received: by 2002:a05:600c:4fc9:b0:3ef:7bc5:4e14 with SMTP id o9-20020a05600c4fc900b003ef7bc54e14mr2202600wmq.4.1680187087792;
        Thu, 30 Mar 2023 07:38:07 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003ee1e07a14asm6459623wmq.45.2023.03.30.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:38:07 -0700 (PDT)
Message-ID: <b0c0b258-7af8-4ab7-bed3-901744c79378@grimberg.me>
Date: Thu, 30 Mar 2023 17:38:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/18] nvme-keyring: register '.nvme' keyring and add
 CONFIG_NVME_TLS
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-2-hare@suse.de>
 <20230330085338.cf5z7zvy3elxiusm@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230330085338.cf5z7zvy3elxiusm@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_073810_820990_E33F3714 
X-CRM114-Status: GOOD (  13.34  )
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



On 3/30/23 11:53, Daniel Wagner wrote:
> On Wed, Mar 29, 2023 at 03:59:21PM +0200, Hannes Reinecke wrote:
>> +++ b/drivers/nvme/host/core.c
>> @@ -25,6 +25,9 @@
>>   #include "nvme.h"
>>   #include "fabrics.h"
>>   #include <linux/nvme-auth.h>
>> +#ifdef CONFIG_NVME_TLS
>> +#include <linux/nvme-keyring.h>
>> +#endif
>>   
>>   #define CREATE_TRACE_POINTS
>>   #include "trace.h"
>> @@ -3954,7 +3957,6 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>>   	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>   		return 0;
>>   #endif
>> -
>>   	return a->mode;
>>   }
>>   
>> @@ -5414,13 +5416,21 @@ static int __init nvme_core_init(void)
>>   		result = PTR_ERR(nvme_ns_chr_class);
>>   		goto unregister_generic_ns;
>>   	}
>> -
>> -	result = nvme_init_auth();
>> +#ifdef CONFIG_NVME_TLS
>> +	result = nvme_keyring_init();
>>   	if (result)
>>   		goto destroy_ns_chr;
>> +#endif
> 
> Would it make sense to introduce empty nvme_keyring_init() function for
> !CONFIG_NVME_TLS and avoid this ifdefery here?

Yes.

