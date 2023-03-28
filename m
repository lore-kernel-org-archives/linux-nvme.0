Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303EC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RIhiaE3mSkC/DEDExnLElz1YhgI0ekxIjujI7DTb8I=; b=ZrGvecnBVDfSw4DO5H0p9Tl+gy
	UqO9ffBMYbV/DgjGRQdECBvvvKV/9c8cpkUffxFM+oxj4F28/zLh2KycDp5hR3hAFU+evMhyC6Ex/
	M2qIKiYzQFgZ1d51JC6lloOVHa3s85NNh2yxb8lgEaaXWZ5ThZcsNToSjwqpVeADZNLu8zSE/JeGz
	JLDb6J4w+DsRY2N4WhlF/VNT1CxMSgASQds3PU6KvD7/CpvQ5P/a4bWaQTQv2Ev1kcJm5uwXEoF84
	XjDulgwjPs8NzbBmW/Dn1cVTZCKgSLRZR3E8UFPQoqbooPE6QU+XgLGTKnTVXCC3D1qGlhhTPqJIF
	CnXOr6mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph552-00DeVg-09;
	Tue, 28 Mar 2023 08:53:24 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph54z-00DeUP-0P
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:53:22 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3edc2294fb4so5661245e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RIhiaE3mSkC/DEDExnLElz1YhgI0ekxIjujI7DTb8I=;
        b=hH18zGRFCPwqy91i1WdSYwnQxbROXM4mjgGPuwj3TvJ3u0b0MpgeMWgeNIim6OsdNa
         oURJUj/PRH+RpTLYAF4ka5Ny8KsgSCD/VmApxUVGvM49Pt4P4Him6nR6AEIudb+K19DO
         eU4aPFatEVI3piJYwRe9zW4O//JGG5LZIdcUjFjLo+CAg3q4xZU8pZBbpfeOVve14+BJ
         E2HcXHfiEeBbGrU2kwim9mUUCxRXM0Qzuyh7hQWuhfFmLUPZMW/lTVdFzNyJ6PZFRUYf
         YJYWwGr13KyhE8lFiE+UDe2lxcbCqR8blXzV1bbvYreSLKJ+MXj/1Ii2LaowSTv0LkvL
         gY3g==
X-Gm-Message-State: AAQBX9eC2l8bxr7rvRdhg2SPRuxVsAgoI6uIXPzs3nkULDbIZOMbx5Jo
	wPGHaj4IoVbxcKw12c9e+9o=
X-Google-Smtp-Source: AKy350ZVVdn3JBnPxmszWSOsfY5fD8Q5krwT5YKd+lj2sRwOpE+y1czwV60wMDqH1vWjaDnZT23U0Q==
X-Received: by 2002:a05:600c:3514:b0:3ef:6257:d0e7 with SMTP id h20-20020a05600c351400b003ef6257d0e7mr9887680wmq.2.1679993599165;
        Tue, 28 Mar 2023 01:53:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z5-20020a1c4c05000000b003ef5db16176sm12379093wmf.32.2023.03.28.01.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:53:18 -0700 (PDT)
Message-ID: <fbfe5720-d0f1-fb5d-df7d-de6d549e3627@grimberg.me>
Date: Tue, 28 Mar 2023 11:53:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v2 1/3] nvme: move fault injector to nvme-debugfs.c
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-2-alan.adamson@oracle.com>
 <20230328005617.GB21497@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230328005617.GB21497@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_015321_159534_3316F4E1 
X-CRM114-Status: GOOD (  13.49  )
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


>> Move the nvme fault injector code associated with debugfs into
>> nvme-debugfs.c (new file) so all nvme debugfs associated can
>> reside in a common place.
>>
>> CONFIG_NVME_FAULT_INJECTION_DEBUG_FS needs to be enabled to
>> be able to use fault injection.
> 
> It feels a bit pointless to me to have a separate file for what
> even with the next patch is way under 100 lines of code.
> 
> Keith, Sagi, any opinion?

If we add stuff to debugfs other than fault injection, maybe the
file is better off called debugfs.c instead of fault_inject.c

In that case we can have nvme_debugfs_init(ns)/nvme_debugfs_fini that
would do what it needs based on config opts (fault_inject and
error_logging).

I don't see why we need a separate CONFIG_NVME_FAULT_INJECTION_DEBUG_FS
though...

