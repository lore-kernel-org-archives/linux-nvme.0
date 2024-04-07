Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9719CD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1nmJQjHCwPLhxYOYTnwa5eGcJ1PrPKaj77Bji1P0kA=; b=FVTC5wubxvawG2PWTnZu/K6bqg
	vJPEUuSX2oeFIKjy2YjRH3x0F4eE0qXURZjbq11wMICL7fFGQ4JOpG6Vcz6gOniR1DscZH/fxqg36
	xO63gjV28wNnsgVVbKtV6LVmmDbdBnbGGDI5K7MChRr9R1kirOp5pJRE9vs89EKSsNh1oURfTkecZ
	L0g9UpBpDSpU3zsE6Rtj6ezn0bC0JPE7VU6VoG5rgdul4XaaQnlrd7nnsfzz/33z3dpQYdlbDGfiR
	cNJNIhFsXO/3w61R5lMnA5XimGiQ2fpdsiCRsWQRIKxQtK5fYSKCBXkVMx/okVBtN5R52+PGe5lIF
	jlrCu/QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtazp-0000000DeHL-1DQ6;
	Sun, 07 Apr 2024 22:28:17 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtazm-0000000DeFt-0hbZ
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 22:28:16 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34584c783acso303347f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 15:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712528892; x=1713133692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1nmJQjHCwPLhxYOYTnwa5eGcJ1PrPKaj77Bji1P0kA=;
        b=Vub4AsULvb2itJoTCyVjwgmvDVXPLjoIZ3W4n6eX7WLA2nY/jHL4Dq1C4lyYUkSbVT
         jjMohSi/FRQKlCNBDBDInVC8A0hy8B+0c9OR9vVOad27Jw8KJihz89kOPRe+KNF92x8q
         4puCDvb4+cN+cBgjNOCjEPWrJl0NQsqO2tVT4ErjXu4reYbO2aJFDpJrirBQGPXISeSm
         5GazFVktjQXN3U3Q5uL8bRl2bUyUQtCh6X89r5vlq6+7mXKmVp44PHQpXZeugP4m2HL0
         fMFOj5HDeFGeJGpxTIzV80Y/5zKjRG/Q4UQg7EZKFCWyDAJOdvNgoZOChFfZPMEs3I9Q
         8Lvg==
X-Forwarded-Encrypted: i=1; AJvYcCVLLKLfuuTtI572X0CX9+DtJNyPGNhHI7aHm0lv1wAHrMpsCxqmX2Js1cE97CcS1SC2o+5Fuwma8VD65qafo4Ui2ilXswY81Ww3qFave4k=
X-Gm-Message-State: AOJu0YwANnOJTcYafW6ofNyeA+MmMH+uyaM99BiVtzGy2TpCkk4vIIHC
	rr/+3qB9JARUR7khOYngqGeuUzqXg98rV5rHPlxdNLQcJEZOOsUD
X-Google-Smtp-Source: AGHT+IFqdc1tvwEJ4NsU8S+qFjeuOgFOJcKKwNnVe46pNj/u17mmLFb9bMbbbWMmEHN+SOxYzoDVCg==
X-Received: by 2002:a05:600c:4f95:b0:414:f154:e652 with SMTP id n21-20020a05600c4f9500b00414f154e652mr5638794wmq.3.1712528891852;
        Sun, 07 Apr 2024 15:28:11 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id t21-20020adfa2d5000000b00345690c160esm3355343wra.15.2024.04.07.15.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:28:11 -0700 (PDT)
Message-ID: <bf0752e1-8fb9-45f6-9cf2-e88716952fe6@grimberg.me>
Date: Mon, 8 Apr 2024 01:28:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Jirong Feng <jirong.feng@easystack.cn>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
 <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
 <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
 <d0d87635-839a-43bb-89e4-9ff853d0a878@easystack.cn>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d0d87635-839a-43bb-89e4-9ff853d0a878@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_152814_269501_54BD468C 
X-CRM114-Status: GOOD (  13.08  )
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



On 21/03/2024 5:06, Jirong Feng wrote:
>
>> Hey Jirong,
>>
>> We do not yet understand if this works for Linux nvme-mpath (which 
>> iirc requires a suggested host-side patch).
>> Once we understand that we can take the changes to mainline.
>>
> My last test(native multipath) was done on kernel 
> 4.18.0-147.3.1.el8_1, the result is ocassional failure.
>
> Refer to your previous reply to my question, this time I changed the 
> cntlid_min/cntlid_max range, making it single subsystem from different 
> targets.
> then I retested, here's the result:
>
> 1. on kernel 4.18.0-147.3.1.el8_1, the failure still occurs.
> 2. on kernel 6.6.0, no failure. (about 50 times)
> 3. on kernel 6.6.0 applying your host-side patch, no failure.

So essentially there is no need for the host side patch? interesting. 
Are you sure?

Can you please also try with mpath iopolicy=round-robin?

I'm asking because I cannot understand what is preventing this path from 
being selected again and
again for I/O....

