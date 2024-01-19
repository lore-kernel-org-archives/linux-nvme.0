Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2F1C4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 21:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w81q7ZYYMDn0rmz9YGOMbYmxBkTkJD+b4cgOreci3a0=; b=xmCC8wxlgCGKHPa/FmyFYGffb0
	Y0pMc5bsK4fvt0D9kqVK1YPvts6jDYJ3QfWHKVq8ddt0n6rTaIqx5GZ2sPxcwit3jZS1ExmtwVRlR
	ISg+QxbNWHG7MNW92cNOXtctZljuY/FGiA00ijEMCZca2n2v996zo/jA3cONkFyo0TmFvwnlMQloR
	vPAHadCDbdCxKe4BfhFhfUzQZP/Hkt/srpyHnmIzb/YJJZGXr2lKAoQLPf8CVXlAd5cv09MXOysDN
	xkGRypf8cdEOu3zkhUNCCaFZAk3y2O13o+TCuQeM8nAPHx0HfL8yW/GlL3RIxFS9iJI2ZuVGRrvTR
	EV5U4p+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwZo-006gGQ-1v;
	Fri, 19 Jan 2024 21:39:00 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwZl-006gEu-0W
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 21:38:59 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7bee9f626caso18017939f.0
        for <linux-nvme@lists.infradead.org>; Fri, 19 Jan 2024 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705700333; x=1706305133; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w81q7ZYYMDn0rmz9YGOMbYmxBkTkJD+b4cgOreci3a0=;
        b=SXPhtcPfHbpiGpLb1ZtQgndpVph9FdSsz9sSANyNYlf9Lb0QkJfX6XQhe8Lpr/UvLt
         vMzzlzkBW9+sDH1L33uFjDtn2aPjesg7Vvsqgpq5m4bEC6HG/HydqO9WbWG4752Kifl0
         o8pjmTKAUkXe4PIn/BhGZAjW9nhgexDdTimwM/8L/mZlmb9PqisqE9ocNFm35t6Gly4B
         NUQcV2AnFG0v8UNw8LVQv8CGsckmZ2AIwTrLQKJdzMw7zJzJwR0LZFzGwP1u+Jjj+fbZ
         1P2bq+31y0cMg52GeGc2rfiqKwxcUNYF0/2eOpTvVJA+6WHiK36TLBZ07W2Iub6D0Npe
         GSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700333; x=1706305133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w81q7ZYYMDn0rmz9YGOMbYmxBkTkJD+b4cgOreci3a0=;
        b=Osd779WV8Ntv39YKIiMJGKux2yvbnwFplAUqPnJPLulvYNXTgWafcxwS7W9JzSKMEr
         XCXvhxYX7J53gg3dGiZCwsDqwow+aaF5rp2RW84TjHmQ43zsIvWEZMSiF+UxFoorRypv
         hbUz8m2x1/7oPgBZ3Cd1AFbrso6vWVAUVcqq1hp7zracOcJaEHvHU9t0qSfXPyyYFxU6
         UyBSW19t4ttFO5ZToYhtrcvjrFgvL6YQ+G3lx/ZsB6MCWHD/KoAqLKttV8OGRzJ4whvA
         9j+JY9Mo9KS0/o9+u0MmuqIo1fupIEO+UGEeT1tqwby5llDRYf/fnTC8ozeH5T9jv8EZ
         W2EQ==
X-Gm-Message-State: AOJu0YzfgDEQ/44wfylmpuq6hOyzRq6G8yORw7WDZ6h/Mv5QZzshaJrS
	DggfpfLMq2NYFEn/5IFNSlP+qRTb9R0li71uvX8hfUedn+5mbNBsjMDcXv03nMw=
X-Google-Smtp-Source: AGHT+IEZ7MwAlj/2AVQHt0vLZJCgIM639R5JZkHM4c666ps7wnDkNpJWJW5E+AH/QxzendqT5oYF8g==
X-Received: by 2002:a05:6e02:1c2f:b0:35f:f59f:9f4c with SMTP id m15-20020a056e021c2f00b0035ff59f9f4cmr905052ilh.1.1705700333638;
        Fri, 19 Jan 2024 13:38:53 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bd10-20020a056e02300a00b0035f7f712c78sm5736905ilb.36.2024.01.19.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:38:53 -0800 (PST)
Message-ID: <772c3422-0657-4c61-9392-0388119902a4@kernel.dk>
Date: Fri, 19 Jan 2024 14:38:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME with
 BCACHEFS
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mia Kanashi <chad@redpilled.dev>, linux-bcachefs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
 <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
 <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_133857_218573_7F609DB9 
X-CRM114-Status: GOOD (  24.75  )
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

On 1/19/24 2:34 PM, Kent Overstreet wrote:
> On Fri, Jan 19, 2024 at 02:22:04PM -0700, Jens Axboe wrote:
>> On 1/19/24 5:25 AM, Mia Kanashi wrote:
>>> This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
>>>
>>> Transferring large amounts of files to the bcachefs from the btrfs
>>> causes I/O timeouts and freezes the whole system. This doesn't seem to
>>> be related to the btrfs, but rather to the heavy I/O on the drive, as
>>> it happens without btrfs being mounted. Transferring the files to the
>>> HDD, and then from it to the bcachefs on the NVME sometimes doesn't
>>> make the problem occur. The problem only happens on the bcachefs, not
>>> on btrfs or ext4. It doesn't happen on the HDD, I can't test with
>>> other NVME drives sadly. The behaviour when it is frozen is like this:
>>> all drive accesses can't process, when not cached in ram, so every app
>>> that is loaded in the ram, continues to function, but at the moment it
>>> tries to access the drive it freezes, until the drive is reset and
>>> those abort status messages appear in the dmesg, after that system is
>>> unfrozen for a moment, if you keep copying the files then the problem
>>> reoccurs once again.
>>>
>>> This drive is known to have problems with the power management in the
>>> past:
>>> https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
>>> But those problems where since fixed with kernel workarounds /
>>> firmware updates. This issue is may be related, perhaps bcachefs does
>>> something different from the other filesystems, and workarounds don't
>>> apply, which causes the bug to occur only on it. It may be a problem
>>> in the nvme subsystem, or just some edge case in the bcachefs too, who
>>> knows. I tried to disable ASPM and setting latency to 0 like was
>>> suggested, it didn't fix the problem, so I don't know. If this is
>>> indeed related to that specific drive it would be hard to reproduce.
>>
>> From a quick look, looks like a broken drive/firmware. It is suspicious
>> that all failed IO is 256 blocks. You could try and limit the transfer
>> size and see if that helps:
>>
>> # echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb
>>
>> Or maybe the transfer size is just a red herring, who knows. The error
>> code seems wonky:
> 
> Does nvme have a blacklist/quirks mechanism, if that ends up resolving
> it?

It does, in fact this drive is already marked as having broken suspend.
So not too surprising if it's misbehaving in other ways too, I guess.

-- 
Jens Axboe


