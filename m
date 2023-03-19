Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E3C6FD1F
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Mar 2023 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bws7dlZGTl7iCXr4Wc9RLNmmlTwIGSJusqxM2SEu6mY=; b=xrC4Nib8QvWnxRBJAcxbrBP3qh
	T2GbtNxK0uxl+xHWVxCr+43DXpEcHeyn4AVjTdBf7tbAbkOBwEeDINVzF/HoeyBbHM6EZK3zx/lPd
	JmFfEL+A6wt6xaFV8Yl5Ei+1mDZ9wEy1UJXik5UpTpwp0w0UWSeWQjzC51drQxE6KENEdTZQSd+2q
	3peBdmcwFaDSP1xfPHf3JlzLnaa1bUWg4wkauA0UppAjyXtmX/Q+7JXfpETyPqlnLAYkn/aqiX4eR
	fZjNjRdNAvZ0vLIK+LwIt/+GuacPtCpbJ16q6/PlUzuXn/HUr68ACDR/b8mK3DTpIGcSsPY3Cx8x5
	70nfVCUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdsoH-006mI9-2o;
	Sun, 19 Mar 2023 13:10:53 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdso9-006mHa-0Z
	for linux-nvme@lists.infradead.org;
	Sun, 19 Mar 2023 13:10:48 +0000
Received: by mail-ed1-f46.google.com with SMTP id ek18so37116528edb.6
        for <linux-nvme@lists.infradead.org>; Sun, 19 Mar 2023 06:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679231443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bws7dlZGTl7iCXr4Wc9RLNmmlTwIGSJusqxM2SEu6mY=;
        b=rJFh4eq0hO+gFNaHzZsbHNLH676NuxpCJvxYXCntGtjlvSExAERxngI1J+7/B6VMXB
         xyTEw9SwzZjCc5In/J5zTSwPnr8Bayt1lL9K/qJmCcpUx40+QJJJxHRtj3TW4SU8lDcr
         u5w7KyeAFsJctFiCf7hKn+dxDIzFBGS1EKUPlMXYUvBBAHeJ+WCI5Ly5yBTQUQT2bvBo
         KuKpheWLeFzYMLNJO7oY0GyvEpN3fvz9NP7JP5hSOUyTILo2IoEOT/ttvubWL7oz7ATf
         KnDkaaUQyX+rWiwzwbJk42U81Fg44pCduIz487ynNc0hiAccBSdoXjBNAxhg9VVBjR8V
         XSBA==
X-Gm-Message-State: AO0yUKWYt2RRn6IvOLs2iVmaDrgpLKmefqoDpHunZNDr3Lclkxbxa2gl
	zVuuJEbz8r6LfZhaLefkdjo=
X-Google-Smtp-Source: AK7set/mmbrcqcvkf7K8IJqaPXWE5ev/8My07dCAJZvn+oZUDjhtWbydydZcfcYFUJa6SIrd3qvRaw==
X-Received: by 2002:a17:906:7394:b0:932:170:e07b with SMTP id f20-20020a170906739400b009320170e07bmr7172000ejl.7.1679231442855;
        Sun, 19 Mar 2023 06:10:42 -0700 (PDT)
Received: from [10.100.102.14] (85.65.254.171.dynamic.barak-online.net. [85.65.254.171])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm3273118ejb.176.2023.03.19.06.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 06:10:42 -0700 (PDT)
Message-ID: <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
Date: Sun, 19 Mar 2023 15:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
To: Keith Busch <kbusch@kernel.org>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230319_061045_235972_4C2F2613 
X-CRM114-Status: GOOD (  14.92  )
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


>>> And since we're talking about this, what happens if a command is dispatched to
>>> a polled queue, but has no data transfer? The nvme driver doesn't attach a bio
>>> to the request in that case, so no cookie?
>>
>> IIRC, initially NONE was called once, and the loop in blk_execute_rq looped
>> until the completion was met.
>>
>> I would assume that any other cookie other than NONE would work here,
>> because the driver .poll() would be invoked at least once (maybe set
>> ONESHOT as well).
> 
> As long as the cookie points to the correct hctx, then it would work.

The only commands that can go to a polling hctx today either have a bio 
or they are connect... I don't think that any other sync commands has an
interface to end up on a polling hctx.

So perhaps we should just verify that with:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..29b31d8d9d8e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1051,6 +1051,11 @@ int __nvme_submit_sync_cmd(struct request_queue 
*q, struct nvme_command *cmd,
                 ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
                 if (ret)
                         goto out;
+       } else if (req->cmd_flags & REQ_POLLED) {
+               dev_err(nvme_req(req)->ctrl->device,
+                       "cannot issue a polled request with no bio\n");
+               ret = -EINVAL;
+               goto out;
         }

         ret = nvme_execute_rq(req, at_head);
--

Thoughts?

