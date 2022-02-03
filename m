Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01FCC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxtKotbKYVVDliBEkS/8NGZxxXzsaCF/Ghrn8g2asII=; b=qQcuO+QvSpT9s7rFEhEPw09CQ6
	ZSVPOXWG7M4JzHkEMzMrlW1oyjtphCXB/z13x2MH9n4gWdMV+iPQl6S0MNkXKrHAADACOKdR7GwHJ
	zn3n260OgLYSbR1T5QLZRDQ3v3MVooVMjOfrgJdv506VPYkRjCR6Y0eD3HotlHgB2mtAfJE/Rgo3+
	hCRe+GZnAfuz72mYEe6FTN6FtDAjoOaKH6Mz6VJU1xdK3kF7OVXEdHdPTSMnrRpYtG8+hHWmsh0uf
	QHcInDFMXt46J3eQtvuZPAM2TSK7Jp0UTepEldSs5OCT7xDimPdqy10JHumGnGMnaviBGJmxhKqm6
	UydCEJYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFkvV-00339A-GR; Thu, 03 Feb 2022 22:50:05 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFkvS-00337t-6W
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 22:50:04 +0000
Received: by mail-pg1-f169.google.com with SMTP id q132so3492518pgq.7
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 14:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gxtKotbKYVVDliBEkS/8NGZxxXzsaCF/Ghrn8g2asII=;
 b=XkfcF48IYTkh4+Xmr1jupsyfQb0kKSdL9IX8G1L4JszAd8VR8f4mG2VkicVPWXGVtX
 ycRg8eL0fIab5MKUe13xp+495LdfsqEiL43t16m8RGeqfBT6HmvCXuwXmzeF2LxhQI3B
 bvbMiN4eIp+V9r64mYDL/jQMxQHgL4/55ojLr5VbnCq9NWiZx1Sk9gNWgwogmULxTGF4
 M4i4RAu8Y6IdcJJLC+qaRyHwvoBGvIJWbP8L03EkH6P88cmnCUHujWVfMzdDlUonuYz9
 Fl+c6mkVTpHTiCbuwHcT1KQTumzqDOoUrOTVn9/5Wz78FdeJ+wCQmqgP1SFn/QTppvo0
 h4yw==
X-Gm-Message-State: AOAM533ko7ejTAU4LyvR9BaNwJfrN19nj7GeV3lXUjz5TPLy6NhEM9lR
 c+H71cz63S0GhIlezJXbmBw=
X-Google-Smtp-Source: ABdhPJxbVDWLXFrYyts1WDQEZT5xMfsQOnoKDmtKT7LXmg2Sy357f0iLUMQzn3wbo7lsO987Ifcecw==
X-Received: by 2002:a63:91c3:: with SMTP id l186mr225003pge.558.1643928600285; 
 Thu, 03 Feb 2022 14:50:00 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id h11sm48342pfe.214.2022.02.03.14.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 14:49:59 -0800 (PST)
Message-ID: <a2ec9086-72d2-4a4e-c4fa-fe53bf5ba092@acm.org>
Date: Thu, 3 Feb 2022 14:49:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
 <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_145002_925663_4B68651E 
X-CRM114-Status: GOOD (  12.95  )
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

On 2/3/22 10:50, Mikulas Patocka wrote:
> On Tue, 1 Feb 2022, Bart Van Assche wrote:
>> On 2/1/22 10:32, Mikulas Patocka wrote:
>>>    /**
>>> + * blk_queue_max_copy_sectors - set maximum copy offload sectors for the
>>> queue
>>> + * @q:  the request queue for the device
>>> + * @size:  the maximum copy offload sectors
>>> + */
>>> +void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size)
>>> +{
>>> +	q->limits.max_copy_sectors = size;
>>> +}
>>> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
>>
>> Please either change the unit of 'size' into bytes or change its type into
>> sector_t.
> 
> blk_queue_chunk_sectors, blk_queue_max_discard_sectors,
> blk_queue_max_write_same_sectors, blk_queue_max_write_zeroes_sectors,
> blk_queue_max_zone_append_sectors also have the unit of sectors and the
> argument is "unsigned int". Should blk_queue_max_copy_sectors be
> different?

As far as I know using the type sector_t for variables that represent a 
number of sectors is a widely followed convention:

$ git grep -w sector_t | wc -l
2575

I would appreciate it if that convention would be used consistently, 
even if that means modifying existing code.

Thanks,

Bart.

