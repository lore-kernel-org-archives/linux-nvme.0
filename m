Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A56EC4707C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4Kvga+gCCknNcaIDhI5P0YQnHCrcQUlvVgE/vEI7AQ=; b=JcUM3kafK1fSgEqXcIcRDtrxS5
	P+p97yMdbLi7mDmqnSt3vtvMZPIO2ZdLbLoS16HUMkvNy/gf3gffQr4Q6sSrHJITHjUAtjQ+5961T
	mAs9xKjlEnMC3JaBjtDEkr0O4K8tb38yzZrH5d3qnqcylLuHXqhyESOC99UPmUXV5hsxX3FQFeVUD
	hgcLCN/Aqa9w2JxmRoeYOiv8k7IODdqpEPybgBWWpZ1MV76eUzE4xTbCBHYT+8bNqPdxZbQwOpnNL
	uN7+r8+1b5G+xdqs7fCvEo/4soFAjmsBkiYUxyxb3Z+MWdkRl+8xhy/OZTgH1SycqbdRChul03lAz
	ubel5LJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONKu-003kvQ-0e;
	Fri, 12 Jan 2024 19:37:00 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONKq-003krj-1X
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 19:36:57 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-204c9c002e0so3361045fac.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Jan 2024 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088214; x=1705693014; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4Kvga+gCCknNcaIDhI5P0YQnHCrcQUlvVgE/vEI7AQ=;
        b=CgKqQZfJ5BEstkgK5DF4m8wUVeBg6TNWvOf11A3z5HAhr45UwIHnah9Ej0GTWg+slm
         msHhhGZAoj+/i5L2HmwVZi4LnP+eZsS3swZjSrhkt1kGJtdyoxP9hQ2yj+mYBnV/dC6t
         qdfEoYbPdOBW0VhcDE7iWn/fh8zl9zjf7CFK2Rogof5W8GrqqNQgbjXsUSdvzwIdbEiS
         ZoWNsGmqEEA3VVXGWTQvAyYmHYN/0FM74Ft8pvJ/sexEnJAMiLmZvcrLnFNPuUsPwBUc
         oXcre/7qa61FpJFEzXyBvCj0V97sy1GCZj3CoEbFHwP9QGSotzyXtxSAPp06udAuuJqy
         0/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088214; x=1705693014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4Kvga+gCCknNcaIDhI5P0YQnHCrcQUlvVgE/vEI7AQ=;
        b=JZ6trFtQxCkhx1AVkZdob1dZfK1FAEESX7KZTZr7t3ljs90TYv7yyO6AWPUpjDxFTR
         1aw6mBPU4v6PeshHWtfQiGUOwqrwBt1cVqotvu98t0x7vym7JBR2lWLTc4nHu2u8afGn
         AjwwpwfQOGCspZBca/R3l18QzzhvBzf5V9CUDzD3pdfsChaxnrQjM344fw69B6KLM4LS
         n1B1zqsXIade/3geZXJu0uy4Y/C0/Pqn0l4pzke3YK20dr30SsC8ZeLbcYpj/QM/PYoe
         uKTHbMyllxHlgzZk+kVx9RV/h00CniJq2W54FEI59GUl+6P2VpOzUY6Uzk7qztI+21IQ
         s1TA==
X-Gm-Message-State: AOJu0YxvnhSRNxv8ZfRLGBFQQtvSNBNLjSGguvARq+C1qzPwrpnWXis3
	PBCEIcPVdsE5UdYoho5Q0Fo=
X-Google-Smtp-Source: AGHT+IEs16qGmAqhDHcPe664G8j2FDJbJZqAJRciT5h1idWKdvOb1zElvzcttSUTDiZq3Wfx1Pz3Dw==
X-Received: by 2002:a05:6870:9f03:b0:1fb:75b:99c5 with SMTP id xl3-20020a0568709f0300b001fb075b99c5mr1870013oab.116.1705088213832;
        Fri, 12 Jan 2024 11:36:53 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id qr1-20020a056870ef8100b0020650e8e782sm948786oab.57.2024.01.12.11.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 11:36:53 -0800 (PST)
Message-ID: <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
Date: Fri, 12 Jan 2024 13:36:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_113656_513209_A76986D0 
X-CRM114-Status: GOOD (  25.55  )
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


> 
> 
> On 04/01/2024 18:47, Keith Busch wrote:
>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>> Currently NVME namespaces are scanned serially, so it can take a long time
>>> for all of a controller's namespaces to become available, especially with a
>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>
>>> Use async function calls to make namespace scanning happen in parallel,
>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>
>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>> so I'm a little surprised it makes a noticable difference. How much time
>> improvement are you observing by parallelizing the scan? Is there a
>> tipping point in Number of Namespaces where inline scanning is better
>> than asynchronous? And if it is a meaningful gain, let's not introduce
>> another module parameter to disable it.
> 
> I don't think it is a good idea since some of the namespace characteristics must be validated during re-connection time for example.
> I actually prepared a patch that makes sure we sync the ns scanning before kicking the ns blk queue to avoid that situations.
> for example, if for some reason ns1 change its uuid then we must remove it and open a new bdev instead. We can't kick old request to it...
> 


Sorry for the delayed response--I thought I could get exact data on how long it takes with and
without the patch before I responded, it is taking a while (I'm having to rely on someone else
to do the testing).  I'll respond with the data as soon as I get it--hopefully it won't be too
much longer.  The time it takes to scan namespaces adds up when there are 1000 namespaces and
you have a fabrics controller on a network that isn't too fast.

I don't expect there would be any reason to disable this.  I only put the module parameter to
disable it in case there was some unforeseen issue, but I can remove that.

To Max Gurtovoy--this patch wouldn't change when or how namespaces are validated... it just
puts the actual scan work function on a workqueue so the scans can happen in parallel.  It will
do the same work to scan, at the same point, and it will wait for all the scanning to finish
before proceeding.  I don't understand how this patch would make the situation you mention any
worse.


