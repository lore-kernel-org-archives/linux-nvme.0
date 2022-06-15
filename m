Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01E5C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T824YRyWbY8QMwmDAOdeOrXAS4lOWMO5bv33bcKaW7M=; b=cMOTiICg/Z1b+UZVtjtvqvR5++
	V5/N/auGKxnIaqd1enTKAHDIeBM3pVS9sTlRw21Cye1fsTfsnJ929YOUPYrOvWAhFK60zq/SMOjM5
	lS7jD5SshVhThb1IED6MP9GsV0UsH2Fhop28SZkkpC/NrsVTjQ3M3s2pbJXsC1wRMw/tANpajUdZ7
	g+AUzeLBgXKrnf2qwUJowriHrSXzilnusKEYcuf1uTPEpkZH62UmfYFHe7CwSMHcfIXO0/UTlPNoP
	bbLPCNCRb4GnPn3ZgvgvYYaJkS36L2eZsi8J2y2TFoaXlH7p8cnOxr5sgzTBcOIp7qBo+yX58pohX
	AQmKEuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Qti-00E5XX-19; Wed, 15 Jun 2022 11:09:18 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QpB-00E3tA-El
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:04:39 +0000
Received: by mail-pj1-x102a.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1722743pjk.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T824YRyWbY8QMwmDAOdeOrXAS4lOWMO5bv33bcKaW7M=;
        b=7k0x2XCq3c+fO57mLWxyW3hIRphZs6qRafxHeFqwN6WujzbKD2zGN3SOtovrXLKgzM
         WmD21sQigiQQXmu3CRxkLilzT39tnuFDZfFTYahh83+0Qb00MasNXGLYfbCgjBI4HLf+
         PVSVLC2n8rCGc0P1fq1xDHDyfqJ6vjrYVhtOcfHM05QUZJwGfhuixYo/cmO/inIwPKII
         WeYU64MyfllBmx53oSXWEWsBU4NbbjdyGaGVB+4XgZ0x/2i4mGQ/Cs+tbSIU3Q/SRpAV
         82pfRdxx7TxB1lWM1lZziARVfujowqge99iYdGMjGNmunykqNTr4zdyA2LE5F5ic5gH3
         MgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T824YRyWbY8QMwmDAOdeOrXAS4lOWMO5bv33bcKaW7M=;
        b=DKRaXXW/+3AWI2DoeR0Vs33qT7m1mK2/a7cZaS2MKWI1et3RtOLBignGRnpw3FjKXZ
         5oggYlZL1Gwrw2d20H4mCxDPZa0VvHbceWltXdXPQMLDkBEG3ko/AaxZc3LD0oW95seo
         NMFWCFMqZtlHoXudgX/UKHNntBGW94ROoc+4jsz1RiGGGuO7/QYDwb9OkGBpHm3XSNGh
         ssdaxH9/k2B436idH3TDIHCpgz6CM1JMLNGOeWXDbjtDRb6vqXOtJq82DcURCgCFVIaT
         pHsEY0djWU16QYCPFdnjsXTZ92/LncOkuAeNqZV+EPXoOnrplVcOUT1pxyREr57GQtDQ
         O0ew==
X-Gm-Message-State: AJIora+q99F/6QwzB2HWjm12jBUc4USXywsgRvksgfZGqob5GWK6j8ra
	8WfCuSljVFQ9DZiQMo6Q9K5LzA==
X-Google-Smtp-Source: AGRyM1t5eoWtX6J8r3c+wvPvgRu3y+yh8lij5bXtDZ8bbbUbfVBMy8KPtTccm7534wzKi0hhYKIX1Q==
X-Received: by 2002:a17:90b:4a8c:b0:1e2:f378:631d with SMTP id lp12-20020a17090b4a8c00b001e2f378631dmr9590261pjb.58.1655291074460;
        Wed, 15 Jun 2022 04:04:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b00163c6ac211fsm9009421pln.111.2022.06.15.04.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 04:04:34 -0700 (PDT)
Message-ID: <6d214e48-721d-c9b8-f900-c23d6cbe9324@kernel.dk>
Date: Wed, 15 Jun 2022 05:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Erwan Velu <e.velu@criteo.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20220614210902.744318-1-e.velu@criteo.com>
 <20220614210902.744318-2-e.velu@criteo.com>
 <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
 <20220615053729.GA21858@lst.de>
 <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
 <20220615105316.GA7911@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220615105316.GA7911@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_040437_785286_96CBC83F 
X-CRM114-Status: GOOD (  15.10  )
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

On 6/15/22 4:53 AM, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 09:57:05AM +0200, Erwan Velu wrote:
>>> I would much prefer to not print it all.  The Linux boot is way to spammy
>>> to start with and this doesn't add any real value.
>>>
>>
>> I know the boot is a bit spammy but when systems crash because of nvme
>> drives, that's very handy to get a trace showing who was the culprit and
>> what drive is installed (including the fw version which is usually a major
>> source of troubles).
> 
> Well, usually they are all the same or a very small set of different
> SKUs compared to the total number of drives.

Agree that we don't want to add unnecessary spam to the boot messages,
and we don't need tons of lines like eg SCSI does. But it does seem
handy to have a single line of the basic model/fw/sn for each drive
along with the enumeration we already print.

-- 
Jens Axboe


