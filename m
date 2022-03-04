Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CECC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LeProy8izTno1wkWKHkWuLWt5O2FYK3xOmB4Mvc3iFk=; b=lcF2syPrXUVtqQh0y/kCcUlW0D
	rjJ6TkX7OdroriIZZABx9kuwXhIIFowjk15PLQ2eUMKczFBCIhPAQNGWIaZqsD/OPb7hefMyb3CDj
	ZaxT0pTJ54k2kFBazuFL66kDsThpcbgx30MZDUvtPsIBWBDYUaK59wP5LPwkP4eH8wi00NDXLJyMd
	rtuCtuo0uXQZ4Gjum2ER7w/VFqFjrxqApniyR2cb0P3KLLOaFmTBgyt9WOcnqXioa0jE9UgxCLNDm
	o+IM3goe13wglW3JtEVd2R1xWSo/NClXWV3+1HhXub1kT8GwP0lKkf/BxdcJjMI0SwMFFba1ieQ2U
	p2uJ55zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQDkh-00BlcN-Cc; Fri, 04 Mar 2022 19:38:11 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQDke-00Blax-0H
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 19:38:09 +0000
Received: by mail-pf1-x42b.google.com with SMTP id s11so8392346pfu.13
 for <linux-nvme@lists.infradead.org>; Fri, 04 Mar 2022 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=LeProy8izTno1wkWKHkWuLWt5O2FYK3xOmB4Mvc3iFk=;
 b=4sRPfiYpeKlkerSVQ2gBXlQ7rspcFwPmF/tIH9oXKImY3M7j6/0vu+EzhCplFbZNe/
 gCGjToArVZWQMdXwTbLXTRJz5jiG7YIg17ks+HDdLmhMXqzWD2+GFQycgjOJ9aVotwvR
 9CYfJEKdt+XGQLpWRCYv+0bzWJWGpx07RzbBF8JsK+lprONQ7JWCBPzLsQ4ZkGfYl/p5
 Y7obbGIkT/ltHimuxLpwdzH5nE9Bjd4wjj2Rt1jEo/ZWYb73qNNWU8GkEwoOup/JZh3m
 05GZyHmMJMDHTdAPleMUGDKK9MitOyXF9R0KpApLCtl/F9ctjcvqSStUObEXrip7YF0L
 gkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LeProy8izTno1wkWKHkWuLWt5O2FYK3xOmB4Mvc3iFk=;
 b=u4HqSDKMyFynv2KjkTAVkYL/p2f17cQsxkePYULqMgDEwMzUyuZSAwwL5My3a/R0Jk
 L6YZZQwV4vyEtIRb7/33/LxWG9F9xOQYHZYE+TX9KW+fnTpSbaKWpGhdfnDWBWLY5nMF
 z120f+O1gixtKUC7gYui+RjHlexGIrEDVhkZfUR9N1+/Keb0mCkZD0CeoiM3XUMPnuPs
 aTcpa8s/Bxjfcy2xCFLLUmFUPJG4H9YRcWPE5yvhWHrx170stagRKVAXX8TjObOhlFsS
 bBbQCOui4ZDruSKaSj9+4abJhxJ324tJodCH4ZJ/mwdfB/W9gezSlMph6Ws0Ez4cMqjV
 8tYg==
X-Gm-Message-State: AOAM533MVu6SSM8hJfcx8qkFXuP5QMtG879ZuyeoPy8hT9BrxA7im1Ff
 U4jdcuIgI2+mxKOrflE/9hTR5g==
X-Google-Smtp-Source: ABdhPJzdC0Wzazqv5+3vyps6GODMy9xRLdDK4eSu1NPgcSZAabY2LxK6kKGr9BkLQlzdDCqQzUcyIg==
X-Received: by 2002:a63:5c0f:0:b0:374:4a37:48f9 with SMTP id
 q15-20020a635c0f000000b003744a3748f9mr14228pgb.470.1646422686812; 
 Fri, 04 Mar 2022 11:38:06 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056a00138b00b004f1343f915dsm6902723pfg.33.2022.03.04.11.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Mar 2022 11:38:06 -0800 (PST)
Message-ID: <e04da66f-3f72-5d8a-479b-f413222c3646@kernel.dk>
Date: Fri, 4 Mar 2022 12:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, song@kernel.org, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
 <20220304193600.GA15474@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304193600.GA15474@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_113808_134649_72CC8125 
X-CRM114-Status: GOOD (  16.50  )
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

On 3/4/22 12:36 PM, Christoph Hellwig wrote:
> On Fri, Mar 04, 2022 at 11:34:39AM -0800, Keith Busch wrote:
>> On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
>>> -	ctrl->nssa = le16_to_cpu(s.nssa);
>>> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
>>> -		dev_info(ctrl->device, "too few streams (%u) available\n",
>>> -					ctrl->nssa);
>>> -		goto out_disable_stream;
>>> -	}
>>
>> Just fyi, looks like the patch was built against an older version of the
>> driver, so it doesn't apply cleanly to nvme-5.18 at the above part.
>>
>> Also please consider folding the following in this patch since it removes all
>> nr_streams use:
> 
> This was against Jens' for-5.18/block tree.  I'm a bit lost what tree
> to best send it against as there will always be some conflicts.

It's always a bit of a problem when patches touch both drivers and core.
I actually put this one in a special branch just because of that. I'll
fold in Keith's incremental.

-- 
Jens Axboe


