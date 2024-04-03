Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1968C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVq/F6jwmyuusQdHnZ4WViSQjual7NBb8Hrq3g+KgzU=; b=h1Zao8vPQHW5FSxZpbAPmMCBfB
	+i8K6i0XvkZ858kFq3lrhTo6RVce3l/kEOZBZRke8UI+tK1Xgkay3xmCPj7TJlfeM3O5FHPLfEvrH
	uPAWR9DgAtJ+8njI+MPsLfEvz3/LjEtp4FGh6kg/neUraZWy1sThc+g3yD6G1kzvWBwruQJ6SJETp
	9Zjju46z0pA+5MpDtrwlypGBKAQzKlhzCoI6D96x4+TfRTeG4PEPQxN/rQ/8bW4l9WG2VgZL+RmTk
	IJlt6k6sNQoMNlXv6t2VKxvde8Mk9BKi3DNzXVgAv35p6DEFWIhmuPYDsNOcFW0t4sMyzNjCLPVRW
	BRP9LPUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrp0P-0000000DRee-3BfM;
	Wed, 03 Apr 2024 01:01:33 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrp0M-0000000DRcj-0iCg
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 01:01:31 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1e0e89faf47so18936315ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 02 Apr 2024 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712106083; x=1712710883; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVq/F6jwmyuusQdHnZ4WViSQjual7NBb8Hrq3g+KgzU=;
        b=C6woBoEuvHbv+f8jdYgFH+d08sbi10ty/itz1tBc3bgWQrg6wgjUCwEQZWwANbbt53
         Xs/a8ctnFVmQQYxbdrm+Lf5bYTpRNPpJN/YGkQGasJiGoEqk0kz7kpGpNBV7GGQkOQoA
         J96U4UVc7N9AV+S50ZbEtaSXCTp4RlEBQPwx0zOwz4DYwX69eppyo17FXPuzqf3lPLDx
         cyB3DEPm5IKDAQy9jUrTIMxBXtVLj7hSDpyH8QAjQqUEBjq3LetPl8AbsaRrngHyh/UY
         5J0R4xjuo1IRiRYkheZrS6HSY10bR0sB1hYi7h9hJV+RJMMeRhI3Bf2cm1ZrX9ilEcBF
         wcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712106083; x=1712710883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVq/F6jwmyuusQdHnZ4WViSQjual7NBb8Hrq3g+KgzU=;
        b=spEEjEXWvI2Pdw0fBLwdG2Xofd5ROEWbG3BEa6iZ1v3TNe3QNRPlY0G3aNONtfUgf6
         YAkOzVHXv0I2CunJ0yXnahNsqxBQF7Fa3c83RJ4/mompp7MyPYoYfe/XwzA/XYn1cRQp
         frk7aUBAxuYgccxmXwCbZRZm6p5Alj+2vxTEH+mSFtib55tShDDVPMpP64xwFAWDo57L
         5+QYJLJkTSZuQBT3ZaIKmkHnMRz638ZMLkiDINZjSSp3Yg3d34OfxfzjaNHYF3i3I1gO
         a8dQUYV3BCx846KHPvTOBNKv7QxvGyLtzvOo9OJk8mQ7JT50MAy4Yg9NhgNvCMJz2s+n
         Ztig==
X-Forwarded-Encrypted: i=1; AJvYcCXcQ1V/TMcecAoIZAMnTBYIhtCqBFVFxuIYER/wQXoaqCwzOu4JgPdD+ulBzSDeK9/Oo6dlhl7fOwzcK9xHt0+oj3jVa4UIC2iPnOavJH0=
X-Gm-Message-State: AOJu0Yxs3QhNdV5P6xUx/nh3jadxWUluWZ/OCMDMnIfYVLA39kfqjqts
	puWhoqilWROcexUbJ+LgGTzdi9sGbdHM/sZJHidpCSIkJ7WfroYtAsFE0dZzTPc=
X-Google-Smtp-Source: AGHT+IGJhXKwl0JdEUOdgu34QyQrsf18ALIOaqHxaO+yI+l2ba4JnRblQLZM3qjRUlxHmlFK3QYxCA==
X-Received: by 2002:a17:902:b18c:b0:1e0:c887:f93f with SMTP id s12-20020a170902b18c00b001e0c887f93fmr15507773plr.1.1712106083237;
        Tue, 02 Apr 2024 18:01:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902694500b001e038619e34sm11769300plt.221.2024.04.02.18.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 18:01:22 -0700 (PDT)
Message-ID: <a68d7e70-d82f-4a09-8b9c-db5e902a3663@kernel.dk>
Date: Tue, 2 Apr 2024 19:01:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] block: Introduce zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-8-dlemoal@kernel.org> <20240402161213.GB3527@lst.de>
 <e923b1cf-9683-4029-8a39-c66aa8fb2647@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e923b1cf-9683-4029-8a39-c66aa8fb2647@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_180130_341524_5C9D28FA 
X-CRM114-Status: GOOD (  17.47  )
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

On 4/2/24 5:38 PM, Damien Le Moal wrote:
> On 4/3/24 01:12, Christoph Hellwig wrote:
>>> +static inline struct blk_zone_wplug *
>>> +disk_lookup_zone_wplug(struct gendisk *disk, sector_t sector)
>>> +{
>>> +	unsigned int zno = disk_zone_no(disk, sector);
>>> +	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
>>> +	struct blk_zone_wplug *zwplug;
>>> +
>>> +	rcu_read_lock();
>>> +	hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[idx], node) {
>>> +		if (zwplug->zone_no == zno)
>>> +			goto unlock;
>>> +	}
>>> +	zwplug = NULL;
>>> +
>>> +unlock:
>>> +	rcu_read_unlock();
>>> +	return zwplug;
>>> +}
>>
>> Did we lose an atomic_inc_unless_zero here?  This now just does a lookup
>> under RCU, but nothing to prevent the zwplug from beeing freed?
> 
> Nope. When disk_lookup_zone_wplug() is called directly, it is always
> for handling requests/bios which are holding a reference on the plug
> and because there are requests/BIOs in-flight, the plug is marked as
> busy (BLK_ZONE_WPLUG_PLUGGED or BLK_ZONE_WPLUG_ERROR are set). In such
> state, the plug is always hashed given that
> disk_should_remove_zone_wplug() retturns false for busy plugs. So
> there is no reference increase here. The atomic_inc_not_zero() is in
> disk_get_zone_wplug() which calls disk_lookup_zone_wplug() +
> atomic_inc_not_zero() within an rcu_read_lock()/rcu_read_unlock()
> section.

But doing a lookup under rcu, dropping it, and then returning the unit
without an increment is just a horrible pattern. Regardless of whether
it's safe or not. And as most callers do the atomic_inc anyway, some of
then outside rcu lock, this looks horrible buggy.

Please just unify it all and have it follow the idiomatic rcu lookup
pattern, which is:

rcu_read_lock();
item = lookup();
if (atomic_inc_not_zero(item->ref)) {
	rcu_read_unlock();
	return item;
}

rcu_read_unlock();
return NULL;

as that is well understood, and your code most certainly does not look
safe nor sane in that regard.

And probably kill that atomic_inc() helper you have as well while at it.

-- 
Jens Axboe


