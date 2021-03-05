Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3097C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:06:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5D86509A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5D86509A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lEt43NOA0K78jhS0hHlEvHk9pQ1blmm5waSKtPEzc5U=; b=IiFYqZIbruZx3HuL3dlOl59Jd
	IzFgsKTRz6Hiy7ieLAZLnN4aSGltaydugdcWYAdbMdFHvCg8/FshXWMEaZRs+AxW0n3rQ6R7u3VkK
	KLnu3hC4d6SJp0YtDk7DXCdn+rf49c3CNpUdv/vdh72A0JH+3JjuyZFlOxNLo7PGB6Ywc2FBAlaym
	q6odXl5ayK22DmjjhW7/t0VGwG8s+Q1akfdqTse5YBtxKrehw52oLh1pcNB8IVlKs4bmLFuXT7f2z
	4hcTMz56YmwFgOqwuilZxlOyh+w5gTTo7wS9VSQpcF9FgMgx/ho5CFYWmCxmxDKH2DRTpXdmi5Fhr
	T5bTFZGHw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIGiQ-00GHyN-Js; Fri, 05 Mar 2021 20:06:26 +0000
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGiL-00GHxT-1r
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:06:22 +0000
Received: by mail-ot1-f50.google.com with SMTP id j8so3020270otc.0
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V5W7bfVLI++JpUHp1rlw8bHB2BsUxPbsIcTRmeTrDgs=;
 b=RxvScDE2ft6PiWZMRcHSKvMKhsbC0Kx1KpZU9UfFSYxMJQdaMDLLj9s5JhcYT+/bU7
 +rBOLFUJanbVngaKRMaNDev+1RIwIcSRxLtJlHyQIGZrKbXnefY2zFOsgqJ29onYDXNF
 s1aCYbUo9BR9d6JQRzuiH4WDNY5BE7Dpxa/dyJ3wp/CcR3Mv3m/DVrx6tUEEIPbJ5VUx
 m09zSyn8H+unF4N8V26CNo9C3+ng+zA2kPECVpt9r/Hm/ZGJwQoZaBRqNJ0TWanib8fn
 gAyGYm7XvZVvdDHDfAwHdanDryDPkhZxU/iUxWrvFGrYoC63aanMJpAAZXdUa08L/uQ2
 /hsQ==
X-Gm-Message-State: AOAM533b0m4YTTvnnIgtikwUZN087+XCUMMhUr+6r0vw17wuyE6EoHmN
 uXIErdk7/fR2mLlltj23+0I=
X-Google-Smtp-Source: ABdhPJy0CSVWvbpj5CxqHQ1VgB271XXDVCNde2DDj/HadvepsrZ9KzGhn3VSxRGKhi7Hz2z3rRgFTQ==
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr9141570otp.80.1614974780052; 
 Fri, 05 Mar 2021 12:06:20 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id o18sm738439ooi.16.2021.03.05.12.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:06:19 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-2-hare@suse.de> <20201005125054.GA1125@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4b22798e-c55c-8113-fa09-4bb7b2bf42a0@grimberg.me>
Date: Fri, 5 Mar 2021 12:06:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201005125054.GA1125@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_200621_274254_CE44BD24 
X-CRM114-Status: GOOD (  12.09  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> -	nvme_mpath_remove_disk(head);
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +	if (head->disk)
>> +		put_disk(head->disk);
>> +#endif
> 
> Please move this into a helper in multipath.c with a stub for the
> non-multipath case.

Other than this comment, it looks good to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
