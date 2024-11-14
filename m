Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA35D6A224
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQa0McRJ6ktHn9JWaay5cO4vE1zjTG1spgas33tTGRY=; b=lY5W0WrbfZOsii6MHmrop68jQF
	EbdExTF+KF3oqT7DUL95EsXoifuBo+v+WXUuZhoMgz7498Aw2rtUU1xz2J/j2Bl2e3VR1BF48g22W
	Cf4yPCT10nL8ZYEjzmCDR5lYowkqapML/Ko4ZDAFo2uc5ynYLTBboDUIa22J6WXIzgBNXMASE8VMI
	zdVgreN0lzEA08ZFYwk7d2z5n21nrqDyMZGs/fHpRA7tPc1E1Dt2CI6sha15N7pnGp4yfk3sPgiqf
	ao1zJ4t5AkxpgnxuAOHdqJ+yqLXY9EDTXYufHgqqCiT17wLaaP10K9cC0/2QxiebFJjPx6MSidtiv
	Hab41R6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeA8-00000000Pw9-2Kdh;
	Thu, 14 Nov 2024 18:01:48 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeA5-00000000PvK-2Lrp
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:01:47 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-290c69be014so472638fac.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731607304; x=1732212104; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQa0McRJ6ktHn9JWaay5cO4vE1zjTG1spgas33tTGRY=;
        b=NR82KSRkCZoXObO2TixmbEtXC2LDwPFML/1+LnL5ez70hxRLp93D6yc2UFgl7tSG+J
         n3wUtJVXZTPLfiR2LRmQyEbZmMxGOHi4AiOU9WtORzDHpniKLHZeR9VjeZhiC7EiLRkO
         4OpWCOkNqVbacB6d4wsURfFLnWBsWk6oCfv9pOpY0KMx5+vEXdOchE/pN8HtiivNRsAX
         KUCRbzTktJB5rLMa02Ug7OQisCNMZP2mWlpbNUl+uEJcA7eP0SYIqqGi2bGcbbyg1G9g
         jfFf46b6XMGdAaenhFrTdVff3nceZ+Ffyzgs8/1vpFY+ZwkLRWTk58UvpWVP5lfDypFB
         PVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607304; x=1732212104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQa0McRJ6ktHn9JWaay5cO4vE1zjTG1spgas33tTGRY=;
        b=ukLcEaplKJ61YkO26c3+fr5CdYyE6pL57ZjEU21TuCn9JcotsbCmVB9cvnlnuJ84TR
         aK/v3CmBCSg4MUa6ANz6F0M3zn8WFMHLoxTNKKbI/a15x2mRwAbP1q9qwjqtgQ5Hh3O8
         GaNvSe0OOWwkelbuOg9GHMEGQsaUiM4+4pJaZmBq6Xfi47q7B8meC7JNQlSroH2QzpF2
         iOnjZDYpmLux6j7PJrxDb0XRzSnNAI1t+/l73L+qQKHdPOjfDB1Ndg2HILr1xrHCtwWP
         /bc03oERMNlo9aBrkoyvSmZlEFgrDA9+JJJjZMsgVSQ8/p9I+EvtBxQnS8sWDdDmSBgQ
         lfTg==
X-Forwarded-Encrypted: i=1; AJvYcCXR/naDyEguB7jVRXgKBF/MgB61IJoPR64fYsOUd4oUNQDp1OqCSP7qV5jju6rNYZAaqmID5CJXgwP+@lists.infradead.org
X-Gm-Message-State: AOJu0YxmQTJ3+Jy2s8OXDxQ3qUVGsCUW2J+UtiROdz0CJJy5sHwhwHOv
	oXN/CvShfZ39TDG7buUy02D0+QN1e1hiSspjUKM7wLfXKX/RMzrB1ICxCaZoO8I=
X-Google-Smtp-Source: AGHT+IFoKXcjI2CaRY/oLgtT/oix+5apDbtPkI9pzbUKznrd7KQao0Yve/QbD7+Q2w+5aA9I6DSzbg==
X-Received: by 2002:a05:6870:32d2:b0:270:1eca:e9fd with SMTP id 586e51a60fabf-296102a0557mr3342246fac.3.1731607303805;
        Thu, 14 Nov 2024 10:01:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29610b57149sm679918fac.44.2024.11.14.10.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:01:43 -0800 (PST)
Message-ID: <b977f98e-136b-486d-a52b-61c85708ced9@kernel.dk>
Date: Thu, 14 Nov 2024 11:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Keith Busch <kbusch@kernel.org>, Bob Beckett <bob.beckett@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 kernel@collabora.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <ZzY6v4d71jliy78w@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzY6v4d71jliy78w@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_100145_868766_B66D67CB 
X-CRM114-Status: GOOD (  18.13  )
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

On 11/14/24 11:00 AM, Keith Busch wrote:
> On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> We initially put in a quick fix of limiting the queue depth to 1
>> as experimentation showed that it fixed data corruption on 64GB
>> steamdecks.
>>
>> After further experimentation, it appears that the corruption
>> is fixed by aligning the small dma pool segments to 512 bytes.
>> Testing via desync image verification shows that it now passes
>> thousands of verification loops, where previously
>> it never managed above 7.
>>
>> Currently it is not known why this fixes the corruption.
>> Perhaps it is doing something nasty like using an mmc page
>> as a cache for the prp lists (mmc min. page size is 512 bytes)
>> and not invalidating properly, so that the dma pool change to
>> treats segment list as a stack ends up giving a previous
>> segment in the same cached page.
>>
>> This fixes the previous queue depth limitation as it fixes
>> the corruption without incurring a 37% tested performance
>> degredation.
>>
>> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
> 
> I had this queued up for the nvme-6.12 pull request, which I'm about to
> send out, but I guess we should drop it until we conclude this
> discussion. With 6.12 likely to be released on Sunday, this better
> mitigation would need to target 6.13, then stable.

Since it's a long standing issue, it's not urgent it go into 6.12 in the
first place. So I'd concur with that assessment, even before this
discussion, it should just go into 6.13 and be marked for stable. It
needs that anyway.

-- 
Jens Axboe

