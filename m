Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D6C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 21:19:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769EA6108B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 769EA6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ewhncewMVGEXAcSvWm+T1l7gXWHu0yv1MAeGasQNnAU=; b=ZHvxJzKHdG0jBYMJGFIforZaPm
	U9273c+JCppMalHS0Dh85n+HExKRANQ6mWE9DNIEBYqASSn5jqCNGZIwOtfvVZbMIwHNdHP7mbDR1
	Xf3JSjiGPew3KexeB3ctxnV4bhs7wrsOY3Avqh3VkusaQBDhfQQ6uTrHL8PPqpTvdsZN8Pmwd0a/y
	CkuFYsBtIJLl+roqDmMHcMmcujfHgPqzbE7Rd9gvQdwHxBBkyTVy6DvSoO+qvTwb63s6RIN/+A5wx
	IsxZ0Ax+rQQOLe28DwmKmxc4ix5eP5Am8qfDMozKUwHuZWcho6i/17DlFNh4VRquKYwP6G8smuaLk
	PDYjtr2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mHBuO-00C842-N6; Fri, 20 Aug 2021 21:18:36 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mHBuL-00C82Z-IZ
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 21:18:35 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so14771288pjr.1
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 14:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ghNGDEZc2SSWn9VvNAd7fmG9UBe/rSvbMP1W9zaThGE=;
 b=X4ubKgmyTHiH6qq2pJMoBY5QCKHWHE45sr8TPpyjCy1dDjy6zfDVYSFjIPFJgYBNfm
 ppD59ldX634IGw6FZuF1kiiykUaqIW1LLwNbWtST2+Mw7SdJ7jaQVbfWZ67hFCoIHCRB
 r4hr6QhSP/lkg0ZAX0mJB06x/LeqrmPz8DYt+MYPBbTPv6WvLvt7tdZF+x3Nxy79QB8x
 SeqQeYl0RbMXiftYnakGQbTpAgNwEpgTR9hM1+p+Ca5vSbH2RBj0W/gREBhDCKg3lyMK
 yNv2XcqzoqTNMIQIVMHSrgqPPI8CayByG0C4B8NauP/qC1rcb1H4z1Wsm1tFzzgVDnTN
 KFag==
X-Gm-Message-State: AOAM533/0qIpMC3cCottOoZopMHTiLCM7W4LsHEWFa6ErctMtTJwKyDn
 CBMXMmkaq+jiXh8sBbCFQAc=
X-Google-Smtp-Source: ABdhPJzuE+NZzfM/vev5NRgk1CFObdVgW7MtwdoY7ko+PcKgdRS+PzinaHKAfWWwgZcHMP+PbGE5lA==
X-Received: by 2002:a17:90a:4a95:: with SMTP id
 f21mr6714960pjh.122.1629494311917; 
 Fri, 20 Aug 2021 14:18:31 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:ddfe:8579:6783:9ed8])
 by smtp.gmail.com with ESMTPSA id 8sm8164521pfo.153.2021.08.20.14.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 14:18:31 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 kch@kernel.org, mpatocka@redhat.com, djwong@kernel.org, agk@redhat.com,
 Selva Jove <selvajove@gmail.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 nitheshshetty@gmail.com, KANCHAN JOSHI <joshi.k@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, Mike Snitzer
 <snitzer@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <fb9931ae-de27-820a-1333-f24e020913ff@acm.org>
Date: Fri, 20 Aug 2021 14:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_141833_687648_A8213359 
X-CRM114-Status: GOOD (  30.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/20/21 3:39 AM, Kanchan Joshi wrote:
> Bart, Mikulas
> 
> On Tue, Aug 17, 2021 at 10:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 8/17/21 3:14 AM, SelvaKumar S wrote:
>>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
>>> bio with control information as payload and submit to the device.
>>> Larger copy operation may be divided if necessary by looking at device
>>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
>>> submitted to zoned device.
>>> Native copy offload is not supported for stacked devices.
>>
>> Using a single operation for copy-offloading instead of separate
>> operations for reading and writing is fundamentally incompatible with
>> the device mapper. I think we need a copy-offloading implementation that
>> is compatible with the device mapper.
>>
> 
> While each read/write command is for a single contiguous range of
> device, with simple-copy we get to operate on multiple discontiguous
> ranges, with a single command.
> That seemed like a good opportunity to reduce control-plane traffic
> (compared to read/write operations) as well.
> 
> With a separate read-and-write bio approach, each source-range will
> spawn at least one read, one write and eventually one SCC command. And
> it only gets worse as there could be many such discontiguous ranges (for
> GC use-case at least) coming from user-space in a single payload.
> Overall sequence will be
> - Receive a payload from user-space
> - Disassemble into many read-write pair bios at block-layer
> - Assemble those (somehow) in NVMe to reduce simple-copy commands
> - Send commands to device
> 
> We thought payload could be a good way to reduce the
> disassembly/assembly work and traffic between block-layer to nvme.
> How do you see this tradeoff?  What seems necessary for device-mapper
> usecase, appears to be a cost when device-mapper isn't used.
> Especially for SCC (since copy is within single ns), device-mappers
> may not be too compelling anyway.
> 
> Must device-mapper support be a requirement for the initial support atop SCC?
> Or do you think it will still be a progress if we finalize the
> user-space interface to cover all that is foreseeable.And for
> device-mapper compatible transport between block-layer and NVMe - we
> do it in the later stage when NVMe too comes up with better copy
> capabilities?

Hi Kanchan,

These days there might be more systems that run the device mapper on top 
of the NVMe driver or a SCSI driver than systems that do use the device 
mapper. It is common practice these days to use dm-crypt on personal 
workstations and laptops. LVM (dm-linear) is popular because it is more 
flexible than a traditional partition table. Android phones use 
dm-verity on top of hardware encryption. In other words, not supporting 
the device mapper means that a very large number of use cases is 
excluded. So I think supporting the device mapper from the start is 
important, even if that means combining individual bios at the bottom of 
the storage stack into simple copy commands.

Thanks,

Bart.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
