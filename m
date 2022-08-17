Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED5C25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rzh9E+72F70m+hS1CwxlUXK0VmhycnsIJMh46A4O51U=; b=OZtOYB5cAdoJOxYMkJcKKl3rXG
	fUJyVB5Y0Q+7C0/5cpd0encs361s5qxIXYxXI1hEOjLN7VOLKjgRhgWu7MsSfxPRZkIwZc5fCiuXo
	hkXHt1UXXIUOatxpHSivpDwWKinRQB6uw1Ull4KRzXW1N3/BUYH5N6ip5cuMN2fmpHfDjxYHef3P+
	AqEDVnrymX+of/JUEAZ/okw8xC2zPHbhHx4F7DfJ6f13otbNz7FOERpQ+xYX7Z/AVPEIkg4cFO3Md
	pMuEZ754mLyLd61vTTG+iwCeP2Oa/KME40lh9Qa4KtYyepmTZ/MW49k778GcWnpDvD1emLeVDZglu
	gzFTqzQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOGIz-000eCX-8u; Wed, 17 Aug 2022 10:29:45 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOGIw-000eAa-Jy
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 10:29:44 +0000
Received: by mail-wr1-f53.google.com with SMTP id z16so15654938wrh.12
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 03:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Rzh9E+72F70m+hS1CwxlUXK0VmhycnsIJMh46A4O51U=;
        b=bob4NtSHl+erRyElAiO5dphb+pcqzcqUFYoUw7yuk0HiepL6XH3A93n45791IDKZNu
         vQvnNJkdcp1EACRKv4zZADWXrQ2NYEB8kEwSjWDTYQh+P7d6y9Q3fIjy/8eV+0o1xBR1
         F6MI4am0yzZgnXdG9sZ7PY7RofSGJFiJ87s1taiMkGyj7wLTwaxDZavw+qJLRR9YcB2D
         vvZjwJwQamlp16qhtyijFxkIlRDN3GvEGrHSg17j6ayQAIg0EEivlIA6VZAtsspJIDON
         foG+5UMVJYdZl+BQhZhfUXEVXqr3s0arGG7l9HMmpn5X8OaG+D1eoDeWV4E8p2lruo6p
         jvGg==
X-Gm-Message-State: ACgBeo2TBz1IDVwy+Q63XfF6877EFI1n4WNIM+0u3jO+x0EbIGXMg4pG
	jKpTEjbU76XlnGBs8E88wAk=
X-Google-Smtp-Source: AA6agR74xRFQZRIc/KLYYg2lr1JGAwSnK6WcFCw6g1h61iRH0DdYQNWlDbPr4l0Uwmm2GZLocXrgRQ==
X-Received: by 2002:a5d:6d42:0:b0:220:7ab1:9da9 with SMTP id k2-20020a5d6d42000000b002207ab19da9mr13951116wri.403.1660732179643;
        Wed, 17 Aug 2022 03:29:39 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6042000000b00225232c03fdsm2191086wrt.27.2022.08.17.03.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:29:38 -0700 (PDT)
Message-ID: <35b13f23-25fd-cff6-1e79-7f8d5ef3790f@grimberg.me>
Date: Wed, 17 Aug 2022 13:29:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@fb.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Jonathan Derrick <Jonathan.Derrick@solidigm.com>
References: <20220812182147.1564958-1-kbusch@fb.com>
 <e034ba1d-b43e-6813-37b8-7b341dbdb573@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e034ba1d-b43e-6813-37b8-7b341dbdb573@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_032943_056554_E1C1425A 
X-CRM114-Status: UNSURE (   9.00  )
X-CRM114-Notice: Please train this message.
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


>> +
>> +    /*
>> +     * Ensure the namespace inventory is up-to-date before returning if
>> +     * this command can change it.
>> +     */
>> +    if (ret >= 0 && effects & (NVME_CMD_EFFECTS_NIC | 
>> NVME_CMD_EFFECTS_NCC))
>> +        flush_work(&ctrl->scan_work);
> Maybe it is better to move nvme_queue_scan together here.

I agree, why not move the scan here as well?

>> +
>>       return ret;
>>   }
>>
> 

