Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685CDC47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQC9NIYsanqnP74bCvHtEBj3zQATwxHSwO/bnPWyKDs=; b=BfOsaY37V4fwLmxwlTc608y7U5
	ocUjKImeqfJriCHugUU2zJLwz8Buvwn+TdWGUEU6hOU70/SQ4O63iOR3oncnl/Y8jP5iEEHZVlCym
	hM/qhIRO4V2XwOr6VFBAJWFf4Kt7dJ/csdjClHd0huTUZ/UnRY/f9o7TH9EJa7KUJk6ipRdmEOse3
	g1faFYcLmrvSLKioxydDfs0nZ2iY/jW2UUZMx+h8OkIlbahwpsOV5TbgurK8xEOSlHXliEMmzaf/C
	wJxfYJ5wszqT2YCWC1i17MNdwmASWrYUNC3dlCuG+5JIk+hox+0GBkIqE5HVcu/ZHR96QBrMPyE2x
	1skEE/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQA1z-000GsQ-11;
	Wed, 17 Jan 2024 17:48:51 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQA1v-000Grs-2F
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 17:48:50 +0000
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-361319083daso2255605ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 09:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705513726; x=1706118526; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQC9NIYsanqnP74bCvHtEBj3zQATwxHSwO/bnPWyKDs=;
        b=2pUITRe+BaK2fXftrhVKY9UMVlx0+DNzCW96S1Q5G/yoK1lTt2GHdIW34uPjVFrcrN
         uXik4DorM6tZ6TGegonEd2pmCQ15TKKu5B/lcDESkJ6dSlNGc1nCs9fWX+SJHCFm9znV
         C34vW0+nJgSwOivtDwcVab92rb3heaKAgUsXmLMaFzme5uFk5ozqRenCFVTc3BF4NUYy
         Ng9QH5xZVKPRlvcrFsUSQ/gOyzzE8BKgkbV760KMiqbQovJekM1PbGhQ+RIiJVizlbDs
         1EmXlNI2+dM/OES0vjmoQkapaNaiZDJ4AkvdY7BhAtib0nOkvXriGK4XeZSDz3fKm749
         p9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513726; x=1706118526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQC9NIYsanqnP74bCvHtEBj3zQATwxHSwO/bnPWyKDs=;
        b=sINup9wkrPJhD3BXqaAgotkA+6XM8ptgFl7biPSrK1xng0w06nCT4EDcYAbiGCwfKk
         bOS5w6oR0jVS6bC9CZW2/jdYwAdvx0UKfGX4tc/91rgS9Evx66mmGjPGJ3UAAhwxKuIL
         RJB4G32gBEvAcObDT45qFBS0nvW+SH0xdnmMoZxsb9nGF9Ssht783Nl6A6Yj6BdfZR5v
         YqtaCWpjczZKFjo4SVyStlIrajlZEL3t17VGnQ4VRhHTKMR0Q/zkeYSN1x87tvvFrErE
         7d2MboIKjLcDo5XrAwfAwD/hgR6e7glkmMh11K7VU0CqANi2VuE1NEurgMw2xv7Vo3wr
         ivBg==
X-Gm-Message-State: AOJu0Yz/o/0gBNgRqBFs29E+wiQ4l6laF6Eh1NKpkbJYhP7naXjO2ILw
	Puhspcs8GYBB92k2xOpvYPLtgX6M9L/SHA==
X-Google-Smtp-Source: AGHT+IEUEIvv10b+JJwg7Xu8LougIkwfXnz36eWtRwiTe+nB7SDqr3vHRNimePjucL9zCXyuTMJ7yg==
X-Received: by 2002:a05:6602:1229:b0:7bf:f20:2c78 with SMTP id z9-20020a056602122900b007bf0f202c78mr3060126iot.1.1705513725920;
        Wed, 17 Jan 2024 09:48:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h24-20020a0566380f1800b0046e3023b444sm513339jas.32.2024.01.17.09.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:48:45 -0800 (PST)
Message-ID: <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
Date: Wed, 17 Jan 2024 10:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_094847_939747_4129B930 
X-CRM114-Status: GOOD (  13.65  )
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

On 1/17/24 10:36 AM, Bart Van Assche wrote:
> On 1/16/24 15:34, Damien Le Moal wrote:
>> FYI, I am about to post 20-something patches that completely remove zone write
>> locking and replace it with "zone write plugging". That is done above the IO
>> scheduler and also provides zone append emulation for drives that ask for it.
>>
>> With this change:
>>   - Zone append emulation is moved to the block layer, as a generic
>> implementation. sd and dm zone append emulation code is removed.
>>   - Any scheduler can be used, including "none". mq-deadline zone block device
>> special support is removed.
>>   - Overall, a lot less code (the series removes more code than it adds).
>>   - Reordering problems such as due to IO priority is resolved as well.
>>
>> This will need a lot of testing, which we are working on. But your help with
>> testing on UFS devices will be appreciated as well.
> 
> When posting this patch series, please include performance results
> (IOPS) for a zoned null_blk device instance. mq-deadline doesn't support
> more than 200 K IOPS, which is less than what UFS devices support. I
> hope that this performance bottleneck will be solved with the new
> approach.

Not really zone related, but I was very aware of the single lock
limitations when I ported deadline to blk-mq. Was always hoping that
someone would actually take the time to make it more efficient, but so
far that hasn't happened. Or maybe it'll be a case of "just do it
yourself, Jens" at some point...

-- 
Jens Axboe


