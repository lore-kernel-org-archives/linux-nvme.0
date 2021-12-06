Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB92C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKLdLKV0Vy4dcKePFjNOsWO+DAsBQeLawcQze2lYbWM=; b=RNz1WzMgMWg97X3Lpj+YwfdAFy
	+3fBmzhTz0xrFT2K934e0kEzVdj4IR/GeXWY3XQEcKnFMy7SpmYnlNcTW350H3sm8NFMslqaINaaV
	zktGt/ThknD5Fj5ucMfnmPbKwFLu4V7sFvYxD1eEUIfmXka9GZ7jRH2Jg8eKkdQXr7i3oILwyevKP
	SoP/1Xk5AB6JZp4rwMqg8xNT42loluUNDEnZ00LHlctaKTSo0wX78iphUYaZjrO4qY8fpzClrPxDJ
	eRCxz+aXyi3DXmdyux0yVsb3Xt+jYr5JiDtNQeenRR9jNRqD9rjiXSsQ3/QeZQqtsm3FrcdfY4xK2
	BVnCIh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muGvs-004nQj-47; Mon, 06 Dec 2021 16:33:40 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muGvo-004nPN-Qn
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 16:33:38 +0000
Received: by mail-io1-xd2c.google.com with SMTP id p65so13663196iof.3
 for <linux-nvme@lists.infradead.org>; Mon, 06 Dec 2021 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sKLdLKV0Vy4dcKePFjNOsWO+DAsBQeLawcQze2lYbWM=;
 b=Cu1rnEC6GiVIqaj1QKNBSnq6+OkPUkxEEm5FsZyZpmyv5vALUYoksXz4R7ScEyG97t
 AfdVC+HVaFCZw6aVaNrfbss6wOacCu9Mlc5+qyDhuzo78sCXVZkn+/N2R01T2C1n2/h+
 tuvTDcGBqTxLUKEnc/kvQtrr3IOcTfzQbX2XzoMi1V1noxW+cMnW4CoWcfJCJ27pRc66
 zZ4ZJnK5HmYAfD68eJnyjJHf6GL4cl74kkwyJNlSidgda4c/fUOwdihaFzEfte36wnOj
 /Ac9SyglIoGZM55uoyGo8jw9lP387u381U4vmDi5qVM4xAninP1M4w3qXGoTDkpVyXxo
 X+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sKLdLKV0Vy4dcKePFjNOsWO+DAsBQeLawcQze2lYbWM=;
 b=lJbnEGM9Qvm80//IjU9pJuwI8aPSXRhKVlTiljsmXIjKpXOHRr1qeBl2+e1eXoQP79
 uVWcHc73r1qQaV6yOf5NhPb9cZHmBZChv+2iIjFu4NWIaZBSZmBPDOBVQJ3Yp7CsJWXW
 Jl0/0QZ50t7xci/utEocWEiD/VZ+mF4kq0l/HXr7JiEMrknEdD5xDhtCPXP2AOmS3oDY
 k1VTyeZKuB66ige0SGWDoboAuhbjqOwDbcLcesHR/zrWBWHHVoUYmPZQotrXXEShYWVJ
 bj3KbvmGAuyTtkgUclMRKsCqrVXLw5DPxCyP274Nc1eZUZa2itnUospCdu9nZm4B2Vb9
 6jig==
X-Gm-Message-State: AOAM532NRpEGGt0hPxzsHuh2JF5QqMrqv9fc03BD5UWpiia2pEHuy+K1
 uBdjDnLRuVgmZ1r6CeyXu2mQwvXN+/bTBRba
X-Google-Smtp-Source: ABdhPJxtWXMpeas7aF8YYKJyjVk5+wyXHoFj12CWNeGa/Lirgl5LfKrEFlbnWAlsx0+m5Ih5V3Hhbw==
X-Received: by 2002:a02:6d4f:: with SMTP id e15mr43480868jaf.55.1638808415909; 
 Mon, 06 Dec 2021 08:33:35 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id r18sm6578114ilh.59.2021.12.06.08.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 08:33:35 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk> <Ya2+buqfKSFHWVvu@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05f538ae-d0fc-c557-54a0-06a035ad06b2@kernel.dk>
Date: Mon, 6 Dec 2021 09:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya2+buqfKSFHWVvu@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211206_083336_908078_19F797E0 
X-CRM114-Status: GOOD (  18.02  )
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

On 12/6/21 12:40 AM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 02:45:44PM -0700, Jens Axboe wrote:
>> This enables the block layer to send us a full plug list of requests
>> that need submitting. The block layer guarantees that they all belong
>> to the same queue, but we do have to check the hardware queue mapping
>> for each request.
>>
>> If errors are encountered, leave them in the passed in list. Then the
>> block layer will handle them individually.
>>
>> This is good for about a 4% improvement in peak performance, taking us
>> from 9.6M to 10M IOPS/core.
> 
> This looks pretty similar to my proposed cleanups (which is nice), but
> back then you mentioned the cleaner version was much slower.  Do you
> know what brought the speed back in this version?

Yes, it has that folded in and tweaked on top. Current version seems
to be fine.

-- 
Jens Axboe


