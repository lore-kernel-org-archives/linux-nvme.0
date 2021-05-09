Return-Path: <SRS0=EFt+=KE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44545C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 03:52:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BBB61421
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 03:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BBB61421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N4Vkk2pscehM0uiZ0gcnzI+BFTYPec2OqXDiPok/nh0=; b=DF3wY9C4ZKd5dNduKmWvBG5pX
	Sa6jXEgV9dTgJV/RjT/9WgqinXuGDVzBtOJsiG2qmunGeMxvQ/cX+GXHrYc9Sl9DhsodiyScMC3Qt
	VK9y6aFF8zuq0oxR/Odcwj8112HYuvfrpDBensLI/pl4g1YMgYkjjJGMMjlYeGjcgej8bbLhbH2v/
	BeE4+FbTrkZnVb/qOQZQgnm3TKOjoSvahdyq/z+dZUo2yjylBmdcy8+7kH7WdXp+TddZLPjm/C+Fu
	7ABHS4mUNs05Fk/6yHbGhUcIuj1zeFCb0rNUfJFx7KMoXA1vWDJu8ZISGDtcasBzp0DTGFajSQCBL
	ctbCLPqyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfaTm-00AszJ-Kq; Sun, 09 May 2021 03:51:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfaTk-00AsyX-H4
 for linux-nvme@desiato.infradead.org; Sun, 09 May 2021 03:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
 Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=wK5/7IU4o9YhDHFoicZcfLXLedUpMj2SAlDtfL68d0I=; b=AhorfcHTkC73kZY2mRddTGCpHh
 1DE3i7t9I+N4HcGT9ltmhJNUULLCZLpKRhIxlTq2Kfn6EVK8vlpyh/p0ouwIqTRMj2fSg4m0BXJ7I
 o32L/pq0t36pkLqd+Ctkf4SmtN/BvT/T5vrpuCNdxIG/wppThKH5GcbSmrhaRR1v7plm4+XvyntpC
 a0/OiOvh+33K3vlymZt4dlKcKb+UY/E7CPizYRSxQW+OJFUhQU3JgkACja8BXFIqfuCOXzYaZed/2
 JnqhwSlLxV5uh05t7CiNHAs+98TX/9tndInKcuRWnDcpSEKhdQcBl7HSJwa4vmzBFh7SsnekfJHyw
 AahHxbbw==;
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfaTf-007pjN-Om
 for linux-nvme@lists.infradead.org; Sun, 09 May 2021 03:51:39 +0000
Received: by mail-pg1-x532.google.com with SMTP id q15so6692736pgg.12
 for <linux-nvme@lists.infradead.org>; Sat, 08 May 2021 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=wK5/7IU4o9YhDHFoicZcfLXLedUpMj2SAlDtfL68d0I=;
 b=YUpn4sry2AzpIxDfiNijmM4iRtMGnH8b+1iis0Bdzql5346VfsKns8E+76D/iQgwI+
 OTiIacC2fI4kB+PnuIGUXwdHSriipYsxazKqj8y+7QKzz0LsGUAP0LQ4/jh2hthuprCd
 Z1zTattZJiNEeR4npGvLSKYWP6JiwbBlnX9hTBrqi153aQjghZl2hTFmm3/S6n8MhavY
 bcgAy6FGCwm1Dw/DoVtUmcVX5gzkfUN+jLKh5g1BJKhoPk5DbDe8oxY+xB5lec8YADai
 rqFd3aRo1jys3vkW+wM0/jJcuR26dzi3GpSEXLWMhWMx9Abtn4Sg0r7Cw7pkGtAhccO6
 Oujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wK5/7IU4o9YhDHFoicZcfLXLedUpMj2SAlDtfL68d0I=;
 b=hGbV4eKvDr1hO8xCH5oDs6EbCOy6Ez3gRtX4Hn/6vVFp8RuFBxa417KrAZ4CVXuxgj
 B4Hc+OlTs6oFY8bemCvtH3FtURALnVL4skBt5iBAF98KkRh7CJqAH+xCOoBC7jgx966+
 /PFYpEUFAFlXbqdKoRB4a9MGVjThQjO4EcUk1yfSlICssTaJ6rqZPHJt8gHRDyA6Qz9X
 7HWlKo3Nd/TncYm83c7379Web+twEDXvCAgH1xJ2tkxCL1dhdSVRtkD4xtwtYoFdOZH2
 cvC7o8z4EY2/KZCiYhBzHk/kz4r35Eg1R+hZnzumDdgEcyj50FwX59UnwBtWclaEsK9e
 WaiA==
X-Gm-Message-State: AOAM531WN98DY/7O9SK18fuIptfY5L5m5yq8f6k2cfTUKRVy1ZIeeATm
 kKpIDMwtj8gMAehd6iraj5vjfw==
X-Google-Smtp-Source: ABdhPJz2bYqb40v/5PySanPTXWCo+v5sANxFSuWgfuXlAqfRT48bHmD8zZcuwLyY9aZHX4I/7fKTkA==
X-Received: by 2002:a63:a511:: with SMTP id n17mr18825904pgf.9.1620532293431; 
 Sat, 08 May 2021 20:51:33 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 ne20sm7834245pjb.52.2021.05.08.20.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 May 2021 20:51:32 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, dm-crypt@saout.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
 yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com, hch@lst.de,
 jaegeuk@kernel.org
References: <1620493841.bxdq8r5haw.none@localhost>
 <1620526887.tg1zx7w5np.none@localhost>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f0c90fc0-c239-df68-371d-a5c74c8f32eb@kernel.dk>
Date: Sat, 8 May 2021 21:51:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620526887.tg1zx7w5np.none@localhost>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210508_205135_929588_20B0AC65 
X-CRM114-Status: GOOD (  21.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/8/21 8:29 PM, Alex Xu (Hello71) wrote:
> Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
>> Hi all,
>>
>> Using torvalds master, I recently encountered data corruption on my ext4 
>> volume on LUKS on NVMe. Specifically, during heavy writes, the system 
>> partially hangs; SysRq-W shows that processes are blocked in the kernel 
>> on I/O. After forcibly rebooting, chunks of files are replaced with 
>> other, unrelated data. I'm not sure exactly what the data is; some of it 
>> is unknown binary data, but in at least one case, a list of file paths 
>> was inserted into a file, indicating that the data is misdirected after 
>> encryption.
>>
>> This issue appears to affect files receiving writes in the temporal 
>> vicinity of the hang, but affects both new and old data: for example, my 
>> shell history file was corrupted up to many months before.
>>
>> The drive reports no SMART issues.
>>
>> I believe this is a regression in the kernel related to something merged 
>> in the last few days, as it consistently occurs with my most recent 
>> kernel versions, but disappears when reverting to an older kernel.
>>
>> I haven't investigated further, such as by bisecting. I hope this is 
>> sufficient information to give someone a lead on the issue, and if it is 
>> a bug, nail it down before anybody else loses data.
>>
>> Regards,
>> Alex.
>>
> 
> I found the following test to reproduce a hang, which I guess may be the 
> cause:
> 
> host$ cd /tmp
> host$ truncate -s 10G drive
> host$ qemu-system-x86_64 -drive format=raw,file=drive,if=none,id=drive -device nvme,drive=drive,serial=1 [... more VM setup options]
> guest$ cryptsetup luksFormat /dev/nvme0n1
> [accept warning, use any password]
> guest$ cryptsetup open /dev/nvme0n1
> [enter password]
> guest$ mkfs.ext4 /dev/mapper/test
> [normal output...]
> Creating journal (16384 blocks): [hangs forever]
> 
> I bisected this issue to:
> 
> cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
> commit cd2c7545ae1beac3b6aae033c7f31193b3255946
> Author: Changheun Lee <nanich.lee@samsung.com>
> Date:   Mon May 3 18:52:03 2021 +0900
> 
>     bio: limit bio max size
> 
> I didn't try reverting this commit or further reducing the test case. 
> Let me know if you need my kernel config or other information.

If you have time, please do test with that reverted. I'd be anxious to
get this revert queued up for 5.13-rc1.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
