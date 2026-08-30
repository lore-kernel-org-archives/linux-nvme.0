Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883B6C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t03n0SCVM9xo3y55esfWhopIqO3fG0jqpzDMbmpTJl8=; b=0U0baLMjbTUjcS1p5XMEHaw+I3
	EUYCyLX8nxt1mnPhvet3sc2zmYIoZMHpnSwR0tG7Im7dNOWF1k7D4iATsKbzfrWxxIs76ss0pcFPh
	nGtQVPCM98+p3tzsV7D0p+wfA859MVovNbniWOYP8V2W0AF96NrWx1+3IBLYfj+J5lSzVWXFdG/AZ
	hYBgXcwiRAItDUxFV1dGbIfbDU4x7rGtrg7RxrLKmjRvlyICRtLdALgtrpqjvhEoY5R8EK/E0UBGk
	v/GkmSpyimufL3qNxXUysE5O4LGJEo5sFguT9frvdLjCheXGxJnTGfthMuNpsWcs1qz3HjLDl8f/1
	JLQTV3Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mYt-000000085Wn-0k8d;
	Sun, 30 Aug 2026 20:55:31 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mYr-000000085WS-0MH6
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 20:55:30 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so1679807f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 13:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123327; x=1788728127;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t03n0SCVM9xo3y55esfWhopIqO3fG0jqpzDMbmpTJl8=;
        b=Hwx6YVj/l23CM9EQ7zJRjaxiYdGqcaCR4rKCFTBPQPTfJqiwRoCyJoIAzgZbqtdB7g
         t7r6Bffe3IsCwkIJ3rbiPT65vT3z+ZXs9cPtr5fW3R+zg7wa0fw9hsqh5hCCxohwUUP8
         hJ4m3Yl/OjEf1jUrj4S5/RV9fPxYBH0NI7SdI/424cWTAWO51XAd4NXtO1TtC4/7d7gK
         W6Mhq0kHZSXhmTzSngwxJ938Di2/nDz73V01/f2SvWE1wk9hreFBCnEKKBK1dY22798s
         6FX9TarohoDYVIdkHU5y+TLUYyWyZBxzMqddjq/WnzoHjpqbEMg4sRvGHaZjIsw5qy22
         oHMg==
X-Gm-Message-State: AFuF++kMER6qBcl9JWhJJinn7BvmOe/ZmoxOZSTRGnSWFEs8Zx9II2+2
	dhParcyReM6wUmCogfaa/0Uwn1zXXQf06IJGLYN2qR+rrxyoRRESSJtzCXNT8P3n448=
X-Gm-Gg: AYBFou0gOUJQdhenG28DX+DredW0ZTtvXjEEYZkZ4WFpfTT4OIL8IQQiusX0JEzHu4A
	XtEB5FqTa+bwg1lg7Iq28KRADOVg182GDq/afwBlIGkzFOCDLLE18FzpHpGyZM6Lo5TzD1S+XrU
	yqikSchfooN/jQJG77dqDooYmllKtmN72ndKYn99z+FjL/YoIPjh3J/I+BYEOWv66cPCDs7CRug
	aYmg5I2sOhhZhNKFjU31wuutC3ccBaqGdwt5mWVk6yQkUh2vKh7hFqNBVSLNE4Jhekf6A8a2EvE
	1HFuRE9yOWqEDgfhnuokjXCtmDWviDt4mMI1WHuXwjn0p9K28YyCf+Ak5gY+x1U5GbDTvyIfMt1
	yYXnbhamMwjl5vb74fxM5itWGKGGAGaYoLGJ0rw8Vvl3NaL3iAQINWQaJqqajZCXbKVVzMyhIx5
	2aTKHnbg7NOu82B23SMnyHQyagMr+eXJNOzwzVgveB/z/7nTx//hO5TgdVJ1mwr1jbIt8fbdSRl
	2LSSLblpsLYXoZUIaEHcGGYQ6pBM1v0
X-Received: by 2002:a05:6000:2dc1:b0:482:aa2a:52f6 with SMTP id ffacd0b85a97d-482f7977a50mr33254679f8f.1.1788123326780;
        Sun, 30 Aug 2026 13:55:26 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2005esm18142433f8f.24.2026.08.30.13.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 13:55:26 -0700 (PDT)
Message-ID: <8530b5cc-6a66-4a3e-b4f0-3d38a8f00131@grimberg.me>
Date: Sun, 30 Aug 2026 23:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/6 RFC] nvme: test per-command retry delay
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-8-sagi@grimberg.me> <apPZImACgVFO8Rsv@shinhome>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <apPZImACgVFO8Rsv@shinhome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_135529_137318_BC9290B2 
X-CRM114-Status: GOOD (  16.82  )
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



On 30/08/2026 11:23, Shin'ichiro Kawasaki wrote:
> On Aug 23, 2026 / 11:49, Sagi Grimberg wrote:
>> Add tests to exercise host command retry delays handling.
>>
>> 070: check that basic command RETRY disposition works and respect ctrl
>>       crd
>> 071: check that basic command FAILOVER disposition works and respects
>>       ctrl crd
>> 072: check that different commands completed with different crd levels
>>       are retried independently, each respecting its paired completion
>>       crd level
>> 073: check that different commands completed with different crd levels
>>       are failed-over independently, each respecting its paired completion
>>       crd level
>>
>> These tests rely on nvmet support for subsystem crdt attributes
>> (_require_nvmet_crdt) and nvme host crd error injection support.
>>
>> In addition we add some common nvme helpers to set nvmet attributes,
>> inject errors, and leverage nvme diags to count retries/failovers.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Thank you for the patch. I ran the added four test cases using the kernel with
> the kernel patches, and observed the all four test cases passed. Good.
>
> I walked through the new test cases. Overall, they look good. One point to
> improve is the global variable used to return a value. I will comment it in-
> line.
>
> I found the new test cases measure some numbers like retry count, failover
> count, or elapsed times. Those numbers are used as pass/fail criteria. The
> numbers are logged in the FULL file, but it might be useful to print the
> numbers in the test run console like this:

Thanks - will wait for some more feedback before a respin.

