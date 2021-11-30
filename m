Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 05:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctqDe9fR6tVHB3KwDybwrNny8yAHG6iPer1GTkHzbow=; b=AajaDoetuqoZEO83smZ83IwbtY
	sMW+uTjM86kD3kAn8r/vW4u79r7fw9Q2M6Wmp93ti2mySuIdXUIAoD2gfiFjeIvZGtFQgvkQlsxXQ
	7ttveCW4xX8S8OhgR3pU7SYdv/ZoLrTuRxnfgAOsKHqkMTAcYDj36TS8bvUSpDynIeEQWuACefq01
	/NBAwG7Am62yd30zX13NkDBoOkJD/bv4i5ktY9EcmGsu16xgNHlOBWMrENj7goXqA2b89//DgbJ9c
	eEd//ogEg1jUhw83dAMrfDNKYTddaBxqjg/HJyEpQC9cBKGAJoPDIn0ntwce57ysZdX38PzujLg7V
	PjsmKEig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrvKB-003cSA-BK; Tue, 30 Nov 2021 05:05:03 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrvK6-003cQk-VU
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 05:05:01 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426;
 MF=zhangliguang@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0UyqOnfv_1638248693; 
Received: from 30.225.24.15(mailfrom:zhangliguang@linux.alibaba.com
 fp:SMTPD_---0UyqOnfv_1638248693) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 13:04:54 +0800
Message-ID: <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
Date: Tue, 30 Nov 2021 13:04:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
 <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
From: luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_210459_202388_5251EB0E 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

Hi Keith,

在 2021/11/30 0:34, Keith Busch 写道:
> On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
>> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>>   
>>   	lockdep_assert_held(&nvme_subsystems_lock);
>>   
>> +	if (strncmp(subsysnqn, "nqn.", 4))
>> +		return NULL;
> This seems like an arbitrary way to decide not to check for duplicates.
> Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
> broken controllers?

Yeah, add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk is a way to resolve the 
problem. I do not

have enough controller in my hand, I don't make sure all the controller 
are covered. And there are some

Weird devices from partners are not registered in pci id table:

https://pci-ids.ucw.cz/

"nqn." prefix is a required naming, so i used this way.


Thanks,

Liguang


